#!/usr/bin/env python3
"""Klinische Physio-/Reha-Studien mit hinterlegten Daten (und ggf. Code).

Anders als der erste Durchlauf: Studiendesign wird über PUB_TYPE erzwungen, und
Repository-Links zaehlen nur, wenn sie im Data-/Code-Availability-Statement stehen,
nicht irgendwo im Volltext (sonst zaehlt jedes zitierte Tool mit).
"""
import csv, json, re, sys, urllib.parse, urllib.request
from concurrent.futures import ThreadPoolExecutor

BASE = "https://www.ebi.ac.uk/europepmc/webservices/rest"

PHYSIO = ('(TITLE_ABS:physiotherapy OR TITLE_ABS:physiotherapist OR TITLE_ABS:"physical therapy" '
          'OR TITLE_ABS:"physical therapist" OR TITLE_ABS:"exercise therapy" OR TITLE_ABS:"exercise intervention" '
          'OR TITLE_ABS:"exercise programme" OR TITLE_ABS:"exercise program" OR TITLE_ABS:"resistance training" '
          'OR TITLE_ABS:"strength training" OR TITLE_ABS:"manual therapy" OR TITLE_ABS:"low back pain" '
          'OR TITLE_ABS:"neck pain" OR TITLE_ABS:"shoulder pain" OR TITLE_ABS:"knee osteoarthritis" '
          'OR TITLE_ABS:"musculoskeletal pain" OR TITLE_ABS:"telerehabilitation" '
          'OR TITLE_ABS:"pulmonary rehabilitation" OR TITLE_ABS:"cardiac rehabilitation" '
          'OR TITLE_ABS:"stroke rehabilitation" OR TITLE_ABS:"motor rehabilitation")')

DESIGN = ('(PUB_TYPE:"Randomized Controlled Trial" OR PUB_TYPE:"Clinical Trial" '
          'OR PUB_TYPE:"Pragmatic Clinical Trial" OR PUB_TYPE:"Observational Study" '
          'OR TITLE_ABS:"randomised controlled trial" OR TITLE_ABS:"randomized controlled trial" '
          'OR TITLE_ABS:"randomised trial" OR TITLE_ABS:"randomized trial" '
          'OR TITLE_ABS:"cohort study" OR TITLE_ABS:"secondary analysis")')

REPO = ('("zenodo" OR "osf.io" OR "datadryad" OR "dryad" OR "figshare" OR "dataverse" '
        'OR "github.com" OR "gitlab.com" OR "mendeley data")')

QUERY = f'{PHYSIO} AND {DESIGN} AND {REPO} AND OPEN_ACCESS:Y'

CODE_HOST = re.compile(r'(?:github\.com|gitlab\.com|bitbucket\.org)/[\w.\-]+/[\w.\-]+', re.I)
DATA_HOST = re.compile(r'(?:zenodo\.org/(?:record|records|doi)[/\w.\-]*'
                       r'|10\.5281/zenodo\.\d+|osf\.io/[a-z0-9]{4,8}'
                       r'|datadryad\.org/[\w./\-]+|10\.5061/dryad[\w./\-]*'
                       r'|figshare\.com/[\w./\-]+|dataverse[\w.\-]*\.[a-z]{2,}/[\w./\-]*'
                       r'|data\.mendeley\.com/[\w./\-]+)', re.I)
ON_REQUEST = re.compile(r'available (?:from|upon|on) (?:the )?(?:corresponding author|reasonable request|request)', re.I)
RCT_PT = re.compile(r'randomized controlled trial|randomised controlled trial', re.I)


def get(url):
    req = urllib.request.Request(url, headers={"User-Agent": "physio-multiverse-scout/1.0"})
    with urllib.request.urlopen(req, timeout=90) as r:
        return r.read().decode("utf-8", "replace")


def search_all():
    out, cursor, seen = [], "*", set()
    while True:
        p = urllib.parse.urlencode({"query": QUERY, "format": "json", "pageSize": 1000,
                                    "cursorMark": cursor, "resultType": "core"})
        d = json.loads(get(f"{BASE}/search?{p}"))
        res = d["resultList"]["result"]
        if not res:
            break
        for r in res:
            pid = r.get("pmcid")
            if pid and pid not in seen:
                seen.add(pid)
                out.append(r)
        nxt = d.get("nextCursorMark")
        if not nxt or nxt == cursor:
            break
        cursor = nxt
    return out


def strip_tags(s):
    return re.sub(r"\s+", " ", re.sub(r"<[^>]+>", " ", s)).strip()


def avail_blocks(xml):
    """Alle Availability-Abschnitte (Daten UND Code) einsammeln."""
    out = []
    pats = [
        r'<sec[^>]*sec-type="[^"]*(?:data-availability|code-availability)[^"]*"[^>]*>(.*?)</sec>',
        r'<notes[^>]*notes-type="(?:data-availability|code-availability)"[^>]*>(.*?)</notes>',
        r'<custom-meta[^>]*>\s*<meta-name>[^<]*(?:[Dd]ata|[Cc]ode)\s*[Aa]vailability[^<]*</meta-name>\s*<meta-value>(.*?)</meta-value>',
        r'<title>[^<]*(?:Data availability|Availability of data|Code availability|Data and code)[^<]*</title>(.*?)(?=<sec\b|</sec>)',
        r'<p>\s*<bold>[^<]*(?:Data availability|Code availability)[^<]*</bold>(.*?)</p>',
    ]
    for p in pats:
        for m in re.finditer(p, xml, re.S | re.I):
            out.append(m.group(1))
    return out


def screen(rec):
    pmcid = rec["pmcid"]
    try:
        xml = get(f"{BASE}/{pmcid}/fullTextXML")
    except Exception:
        return None
    blocks = avail_blocks(xml)
    das = strip_tags(" ".join(blocks))[:1000]
    scope = " ".join(blocks) if blocks else ""
    code = sorted({m.group(0).rstrip('.,;)').lower() for m in CODE_HOST.finditer(scope)})
    data = sorted({m.group(0).rstrip('.,;)').lower() for m in DATA_HOST.finditer(scope)})
    ptypes = " ".join(rec.get("pubTypeList", {}).get("pubType", []) or [])
    return {
        "pmcid": pmcid, "pmid": rec.get("pmid") or "", "doi": rec.get("doi") or "",
        "year": rec.get("pubYear") or "", "journal": (rec.get("journalInfo", {}).get("journal", {}) or {}).get("title", "")[:55],
        "title": (rec.get("title") or "").strip().rstrip(".")[:200],
        "is_rct": bool(RCT_PT.search(ptypes + " " + (rec.get("title") or ""))),
        "pub_types": ptypes[:70],
        "n_code": len(code), "n_data": len(data),
        "code_urls": " | ".join(code[:3]), "data_urls": " | ".join(data[:3]),
        "on_request_only": bool(ON_REQUEST.search(das)) and not (code or data),
        "das": das,
    }


if __name__ == "__main__":
    recs = search_all()
    print(f"Kandidaten (klinisches Design + Repo-Term): {len(recs)}", file=sys.stderr)
    rows = []
    with ThreadPoolExecutor(max_workers=8) as ex:
        for i, r in enumerate(ex.map(screen, recs), 1):
            if r:
                rows.append(r)
            if i % 50 == 0:
                print(f"  ... {i}/{len(recs)}", file=sys.stderr)

    rows.sort(key=lambda r: (-((r["n_code"] > 0) + (r["n_data"] > 0)), not r["is_rct"], -int(r["year"] or 0)))
    with open(sys.argv[1], "w", newline="") as fh:
        w = csv.DictWriter(fh, fieldnames=list(rows[0].keys()))
        w.writeheader()
        w.writerows(rows)

    both = [r for r in rows if r["n_code"] and r["n_data"]]
    anyrepo = [r for r in rows if r["n_code"] or r["n_data"]]
    print(f"\nGescreent: {len(rows)}", file=sys.stderr)
    print(f"  Repo im Availability-Statement: {len(anyrepo)}  (RCTs: {sum(r['is_rct'] for r in anyrepo)})", file=sys.stderr)
    print(f"  davon Code UND Daten:           {len(both)}  (RCTs: {sum(r['is_rct'] for r in both)})", file=sys.stderr)
    print(f"  nur 'auf Anfrage':              {sum(r['on_request_only'] for r in rows)}", file=sys.stderr)
