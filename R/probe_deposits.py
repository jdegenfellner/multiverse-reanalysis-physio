#!/usr/bin/env python3
"""Automatischer Vor-Screen: Was liegt in den Repositorien der Shortlist wirklich?

Holt fuer jede Studie die Dateiliste des verlinkten Deposits (OSF, Zenodo, Dryad,
figshare) und klassifiziert, ob dort ueberhaupt etwas Tabellarisches liegt, das
Individualdaten enthalten koennte. Ersetzt keine manuelle Pruefung, sortiert aber
die 82 RCTs so vor, dass die Handarbeit dort anfaengt, wo sie sich lohnt.
"""
import csv, json, re, subprocess, sys, time
from concurrent.futures import ThreadPoolExecutor

# Dateiendungen, die individuelle Rohdaten tragen koennen
TABULAR = {".csv", ".tsv", ".xlsx", ".xls", ".sav", ".dta", ".rds", ".rdata", ".rda",
           ".sas7bdat", ".por", ".parquet", ".feather", ".json", ".txt", ".dat", ".zip", ".7z"}
CODE = {".r", ".py", ".do", ".sps", ".sas", ".jl", ".rmd", ".qmd", ".ipynb", ".m"}
DOCS = {".pdf", ".docx", ".doc", ".png", ".jpg", ".jpeg", ".tif", ".svg", ".pptx", ".md", ".html"}

OSF = re.compile(r'osf\.io/([a-z0-9]{4,8})', re.I)
ZEN = re.compile(r'(?:zenodo\.org/records?/|10\.5281/zenodo\.)(\d+)', re.I)
DRY = re.compile(r'(10\.5061/dryad[\w./]+)', re.I)
FIG = re.compile(r'figshare\.com/(?:articles/[^/]+/[^/]+/(\d+)|s/([0-9a-f]+))', re.I)


def curl(url, tries=3):
    """Zenodo drosselt bei 30 Anfragen/Minute und antwortet dann mit einem
    JSON-Fehlerobjekt statt Daten, deshalb grosszuegig zurueckfallen."""
    for t in range(tries):
        p = subprocess.run(["curl", "-sSL", "--max-time", "45", "-H", "Accept: application/json", url],
                           capture_output=True, text=True)
        try:
            d = json.loads(p.stdout)
            if isinstance(d, dict) and d.get("status") in (400, 429, 403):
                time.sleep(6 * (t + 1))
                continue
            return d
        except Exception:
            time.sleep(2 * (t + 1))
    return None


def ext(name):
    m = re.search(r'(\.[A-Za-z0-9]{1,9})$', name or "")
    return m.group(1).lower() if m else ""


def _osf_listing(url, depth=0):
    """OSF liefert Ordner und Dateien gemischt. Bis zwei Ebenen absteigen.
    ACHTUNG: page[size] MUSS prozentkodiert sein, sonst bricht curl mit
    'bad range in URL' ab und man haelt das faelschlich fuer ein leeres Deposit."""
    d = curl(url)
    if not d or "data" not in d:
        return []
    out = []
    for f in d["data"]:
        a = f.get("attributes", {}) or {}
        if a.get("kind") == "folder":
            if depth < 2:
                href = (((f.get("relationships", {}) or {}).get("files", {}) or {})
                        .get("links", {}) or {}).get("related", {})
                href = href.get("href") if isinstance(href, dict) else href
                if href:
                    out += _osf_listing(f"{href}?page%5Bsize%5D=100", depth + 1)
        else:
            out.append((a.get("name", ""), a.get("size") or 0))
    return out


def files_osf(node):
    got = _osf_listing(f"https://api.osf.io/v2/nodes/{node}/files/osfstorage/?page%5Bsize%5D=100")
    if got:
        return got
    # Kurzlink kann auch auf eine Registrierung zeigen
    return _osf_listing(
        f"https://api.osf.io/v2/registrations/{node}/files/osfstorage/?page%5Bsize%5D=100")


def files_zenodo(rec):
    d = curl(f"https://zenodo.org/api/records/{rec}")
    if not d:
        return None
    return [(f.get("key") or f.get("filename", ""), f.get("size") or 0) for f in d.get("files", [])]


def files_dryad(doi):
    enc = doi.replace("/", "%2F")
    v = curl(f"https://datadryad.org/api/v2/datasets/doi%3A{enc}/versions")
    if not v:
        return None
    vers = (v.get("_embedded", {}) or {}).get("stash:versions", [])
    if not vers:
        return None
    href = ((vers[-1].get("_links", {}) or {}).get("stash:files", {}) or {}).get("href")
    if not href:
        return None
    f = curl(f"https://datadryad.org{href}?per_page=100")
    if not f:
        return None
    return [(x.get("path", ""), x.get("size") or 0)
            for x in (f.get("_embedded", {}) or {}).get("stash:files", [])]


def files_figshare(art):
    d = curl(f"https://api.figshare.com/v2/articles/{art}/files")
    if not isinstance(d, list):
        return None
    return [(x.get("name", ""), x.get("size") or 0) for x in d]


def probe(row):
    urls = f'{row.get("data_urls","")} {row.get("code_urls","")}'
    files, hosts = [], []
    for m in ZEN.finditer(urls):
        hosts.append("zenodo"); files += files_zenodo(m.group(1)) or []
    for m in OSF.finditer(urls):
        hosts.append("osf"); files += files_osf(m.group(1)) or []
    for m in DRY.finditer(urls):
        hosts.append("dryad"); files += files_dryad(m.group(1).rstrip(".")) or []
    for m in FIG.finditer(urls):
        if m.group(1):
            hosts.append("figshare"); files += files_figshare(m.group(1)) or []
        else:
            hosts.append("figshare-private")

    exts = [ext(n) for n, _ in files]
    tab = [(n, s) for (n, s), e in zip(files, exts) if e in TABULAR]
    code = [n for n, e in zip([n for n, _ in files], exts) if e in CODE]
    biggest = max((s for _, s in tab), default=0)
    return {
        "year": row.get("year", ""), "is_rct": row.get("is_rct", ""),
        "journal": row.get("journal", "")[:38], "title": row.get("title", "")[:120],
        "doi": row.get("doi", ""), "pmcid": row.get("pmcid", ""),
        "hosts": ",".join(sorted(set(hosts))),
        "n_files": len(files), "n_tabular": len(tab), "n_code_files": len(code),
        "biggest_tabular_bytes": biggest,
        "tabular_files": " | ".join(n for n, _ in tab[:6]),
        "code_files": " | ".join(code[:5]),
        "data_urls": row.get("data_urls", ""), "code_urls": row.get("code_urls", ""),
    }


if __name__ == "__main__":
    rows = [r for r in csv.DictReader(open(sys.argv[1]))
            if (r.get("data_urls") or "").strip() or (r.get("code_urls") or "").strip()]
    print(f"Sondiere {len(rows)} Studien ...", file=sys.stderr)
    out = []
    with ThreadPoolExecutor(max_workers=3) as ex:
        for i, r in enumerate(ex.map(probe, rows), 1):
            out.append(r)
            if i % 20 == 0:
                print(f"  ... {i}/{len(rows)}", file=sys.stderr)

    # Vielversprechendste zuerst: RCT, Tabellendatei vorhanden, gross, mit Code
    out.sort(key=lambda r: (r["is_rct"] != "True", -(r["n_tabular"] > 0),
                            -(r["n_code_files"] > 0), -r["biggest_tabular_bytes"]))
    with open(sys.argv[2], "w", newline="") as fh:
        w = csv.DictWriter(fh, fieldnames=list(out[0].keys()))
        w.writeheader(); w.writerows(out)

    rct = [r for r in out if r["is_rct"] == "True"]
    reach = [r for r in out if r["n_files"] > 0]
    withtab = [r for r in reach if r["n_tabular"] > 0]
    print(f"\nSondiert: {len(out)}  (RCTs: {len(rct)})", file=sys.stderr)
    print(f"  Deposit erreichbar, Dateiliste geholt: {len(reach)}", file=sys.stderr)
    print(f"  mit mindestens einer Tabellendatei:    {len(withtab)}"
          f"  (RCTs: {sum(r['is_rct']=='True' for r in withtab)})", file=sys.stderr)
    print(f"  zusaetzlich mit Analysecode:           {sum(r['n_code_files']>0 for r in withtab)}", file=sys.stderr)
