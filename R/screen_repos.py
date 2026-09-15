#!/usr/bin/env python3
"""Screent Physio-/Reha-Volltexte auf echte Daten- und Code-Hinterlegung."""
import csv, json, re, sys, urllib.parse, urllib.request
from concurrent.futures import ThreadPoolExecutor

BASE = "https://www.ebi.ac.uk/europepmc/webservices/rest"

PHYSIO = ('(TITLE_ABS:physiotherapy OR TITLE_ABS:physiotherapist OR TITLE_ABS:"physical therapy" '
          'OR TITLE_ABS:"physical therapist" OR TITLE_ABS:"exercise therapy" OR TITLE_ABS:"exercise intervention" '
          'OR TITLE_ABS:"manual therapy" OR TITLE_ABS:"musculoskeletal" OR TITLE_ABS:"low back pain" '
          'OR TITLE_ABS:"neck pain" OR TITLE_ABS:"shoulder pain" OR TITLE_ABS:"knee osteoarthritis" '
          'OR TITLE_ABS:"resistance training" OR TITLE_ABS:"rehabilitation")')
CODE = '("github.com" OR "gitlab.com" OR "analysis code" OR "statistical code")'
DATA = ('("zenodo" OR "osf.io" OR "datadryad" OR "figshare" OR "dataverse" '
        'OR "public, open access repository" OR "publicly available repository")')
QUERY = f'{PHYSIO} AND {CODE} AND {DATA} AND OPEN_ACCESS:Y'

CODE_HOST = re.compile(r'(?:github\.com|gitlab\.com|bitbucket\.org)/[\w.\-]+/[\w.\-]+', re.I)
DATA_HOST = re.compile(r'(?:zenodo\.org/(?:record|records|doi)[/\w.\-]*|osf\.io/[\w]{4,8}'
                       r'|datadryad\.org/[\w./\-]+|doi\.org/10\.5061/dryad[\w./\-]*'
                       r'|figshare\.com/[\w./\-]+|dataverse[\w.\-]*\.[a-z]{2,}/[\w./\-]*'
                       r'|doi\.org/10\.5281/zenodo\.\d+)', re.I)
ON_REQUEST = re.compile(r'available (?:from|upon|on) (?:the )?(?:reasonable )?request', re.I)
RCT = re.compile(r'random(?:i[sz]ed|isation|ization)', re.I)


def get(url):
    req = urllib.request.Request(url, headers={"User-Agent": "physio-multiverse-scout/1.0"})
    with urllib.request.urlopen(req, timeout=90) as r:
        return r.read().decode("utf-8", "replace")


def search_all():
    out, cursor, seen = [], "*", set()
    while True:
        p = urllib.parse.urlencode({"query": QUERY, "format": "json", "pageSize": 1000,
                                    "cursorMark": cursor, "resultType": "lite"})
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


def das_of(xml):
    """Data-availability-Statement aus dem JATS-XML ziehen."""
    pats = [
        r'<sec[^>]*sec-type="[^"]*data-availability[^"]*"[^>]*>(.*?)</sec>',
        r'<notes[^>]*notes-type="data-availability"[^>]*>(.*?)</notes>',
        r'<custom-meta[^>]*>\s*<meta-name>[^<]*[Dd]ata [Aa]vailability[^<]*</meta-name>\s*<meta-value>(.*?)</meta-value>',
        r'<title>[^<]*(?:Data availability|Availability of data)[^<]*</title>(.*?)(?=<title>|</sec>)',
    ]
    for p in pats:
        m = re.search(p, xml, re.S | re.I)
        if m:
            return strip_tags(m.group(1))[:900]
    return ""


def screen(rec):
    pmcid = rec["pmcid"]
    try:
        xml = get(f"{BASE}/{pmcid}/fullTextXML")
    except Exception:
        return None
    text = strip_tags(xml)
    code = sorted({m.group(0).rstrip('.,;)').lower() for m in CODE_HOST.finditer(xml)})
    data = sorted({m.group(0).rstrip('.,;)').lower() for m in DATA_HOST.finditer(xml)})
    das = das_of(xml)
    return {
        "pmcid": pmcid, "pmid": rec.get("pmid") or "", "doi": rec.get("doi") or "",
        "year": rec.get("pubYear") or "", "journal": (rec.get("journalTitle") or "")[:60],
        "title": (rec.get("title") or "").strip().rstrip(".")[:190],
        "is_rct": bool(RCT.search((rec.get("title") or "") + " " + text[:4000])),
        "n_code": len(code), "n_data": len(data),
        "code_urls": " | ".join(code[:4]), "data_urls": " | ".join(data[:4]),
        "on_request_only": bool(ON_REQUEST.search(das)) and not (code or data),
        "das": das,
    }


if __name__ == "__main__":
    recs = search_all()
    print(f"Kandidaten: {len(recs)}", file=sys.stderr)
    rows = []
    with ThreadPoolExecutor(max_workers=8) as ex:
        for i, r in enumerate(ex.map(screen, recs), 1):
            if r:
                rows.append(r)
            if i % 25 == 0:
                print(f"  ... {i}/{len(recs)}", file=sys.stderr)

    rows.sort(key=lambda r: (-(r["n_code"] > 0) - (r["n_data"] > 0), -int(r["year"] or 0)))
    with open(sys.argv[1], "w", newline="") as fh:
        w = csv.DictWriter(fh, fieldnames=list(rows[0].keys()))
        w.writeheader()
        w.writerows(rows)

    both = [r for r in rows if r["n_code"] and r["n_data"]]
    conly = [r for r in rows if r["n_code"] and not r["n_data"]]
    donly = [r for r in rows if r["n_data"] and not r["n_code"]]
    print(f"\nGescreent: {len(rows)}", file=sys.stderr)
    print(f"  Code UND Daten verlinkt: {len(both)}  (davon RCT: {sum(r['is_rct'] for r in both)})", file=sys.stderr)
    print(f"  nur Code-Repo:           {len(conly)}", file=sys.stderr)
    print(f"  nur Daten-Repo:          {len(donly)}", file=sys.stderr)
