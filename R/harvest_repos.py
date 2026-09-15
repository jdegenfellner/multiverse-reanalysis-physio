#!/usr/bin/env python3
"""Sucht von der Datenseite: Physio-relevante Deposits in Zenodo und Dryad,
die per related-identifier auf einen Zeitschriftenartikel verweisen."""
import csv, json, re, sys, time, urllib.parse, urllib.request

TERMS = [
    "physiotherapy", "physical therapy", "exercise therapy", "low back pain",
    "neck pain", "shoulder pain", "knee osteoarthritis", "musculoskeletal pain",
    "rehabilitation trial", "exercise intervention", "resistance training trial",
    "telerehabilitation", "manual therapy", "pulmonary rehabilitation",
    "cardiac rehabilitation", "stroke rehabilitation", "chronic pain trial",
    "physiotherapy randomized", "exercise randomized controlled trial",
]

TRIAL = re.compile(r'random|trial|cohort|rct|controlled', re.I)
CLIN = re.compile(r'physiotherap|physical therap|rehabilitat|exercise|low back|neck pain|'
                  r'shoulder|osteoarthrit|musculoskelet|chronic pain|patient', re.I)


def get(url, tries=3):
    for t in range(tries):
        try:
            req = urllib.request.Request(url, headers={"User-Agent": "physio-scout/1.0",
                                                       "Accept": "application/json"})
            with urllib.request.urlopen(req, timeout=60) as r:
                return json.loads(r.read().decode("utf-8", "replace"))
        except Exception:
            time.sleep(1.5 * (t + 1))
    return None


def zenodo():
    seen, out = set(), []
    for term in TERMS:
        for rtype in ("dataset", "software"):
            for page in (1, 2):
                p = urllib.parse.urlencode({
                    "q": f'"{term}"', "size": 50, "page": page,
                    "type": rtype, "sort": "mostrecent",
                })
                d = get(f"https://zenodo.org/api/records?{p}")
                if not d:
                    continue
                hits = d.get("hits", {}).get("hits", [])
                if not hits:
                    break
                for h in hits:
                    rid = h.get("id")
                    if rid in seen:
                        continue
                    m = h.get("metadata", {})
                    title = (m.get("title") or "").strip()
                    desc = re.sub(r"<[^>]+>", " ", m.get("description") or "")[:600]
                    blob = f"{title} {desc}"
                    if not CLIN.search(blob):
                        continue
                    rel = m.get("related_identifiers") or []
                    art = [r.get("identifier") for r in rel
                           if r.get("relation") in ("isSupplementTo", "isDocumentedBy",
                                                    "isDerivedFrom", "isPartOf", "cites")
                           and str(r.get("identifier", "")).startswith("10.")]
                    seen.add(rid)
                    out.append({
                        "source": "zenodo", "type": rtype,
                        "year": (m.get("publication_date") or "")[:4],
                        "title": title[:190],
                        "doi": m.get("doi") or "",
                        "url": f"https://zenodo.org/records/{rid}",
                        "article_doi": art[0] if art else "",
                        "looks_trial": bool(TRIAL.search(blob)),
                        "matched_term": term,
                    })
                time.sleep(0.25)
    return out


def dryad():
    seen, out = set(), []
    for term in TERMS:
        p = urllib.parse.urlencode({"q": term, "per_page": 50})
        d = get(f"https://datadryad.org/api/v2/search?{p}")
        if not d:
            continue
        for h in (d.get("_embedded", {}) or {}).get("stash:datasets", []) or []:
            ident = h.get("identifier")
            if not ident or ident in seen:
                continue
            title = (h.get("title") or "").strip()
            desc = re.sub(r"<[^>]+>", " ", h.get("abstract") or "")[:600]
            blob = f"{title} {desc}"
            if not CLIN.search(blob):
                continue
            seen.add(ident)
            rel = h.get("relatedWorks") or []
            art = [r.get("identifier") for r in rel if str(r.get("identifier", "")).startswith("10.")]
            out.append({
                "source": "dryad", "type": "dataset",
                "year": (h.get("publicationDate") or "")[:4],
                "title": title[:190],
                "doi": ident.replace("doi:", ""),
                "url": f"https://datadryad.org/dataset/{ident.replace('doi:', '')}",
                "article_doi": art[0] if art else "",
                "looks_trial": bool(TRIAL.search(blob)),
                "matched_term": term,
            })
        time.sleep(0.25)
    return out


if __name__ == "__main__":
    rows = []
    print("Zenodo ...", file=sys.stderr)
    rows += zenodo()
    print(f"  {len(rows)}", file=sys.stderr)
    print("Dryad ...", file=sys.stderr)
    rows += dryad()
    print(f"  gesamt {len(rows)}", file=sys.stderr)

    rows.sort(key=lambda r: (not r["looks_trial"], not r["article_doi"], -int(r["year"] or 0)))
    with open(sys.argv[1], "w", newline="") as fh:
        w = csv.DictWriter(fh, fieldnames=list(rows[0].keys()))
        w.writeheader()
        w.writerows(rows)

    trial = [r for r in rows if r["looks_trial"]]
    linked = [r for r in trial if r["article_doi"]]
    print(f"\nDeposits klinisch relevant: {len(rows)}", file=sys.stderr)
    print(f"  studienartig (trial/cohort/random): {len(trial)}", file=sys.stderr)
    print(f"  davon mit Artikel-DOI verknuepft:   {len(linked)}", file=sys.stderr)
