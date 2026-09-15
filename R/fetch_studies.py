#!/usr/bin/env python3
"""Laedt fuer jede RCT der Shortlist das Paper-PDF und die Deposit-Dateien.

Ein Ordner je Studie unter studies/. Dateien ueber MAX_MB werden uebersprungen und
in der MANIFEST.txt vermerkt, damit die Videos und Bilddatensaetze den Ordner nicht
sprengen. Wiederaufsetzbar: was schon liegt, wird nicht erneut geholt.
"""
import csv, json, os, re, subprocess, sys, time
from concurrent.futures import ThreadPoolExecutor

MAX_MB = 400
OUT = "studies"

OSF = re.compile(r'osf\.io/([a-z0-9]{4,8})', re.I)
ZEN = re.compile(r'(?:zenodo\.org/records?/|10\.5281/zenodo\.)(\d+)', re.I)
DRY = re.compile(r'(10\.5061/dryad[\w./]+)', re.I)
FIG = re.compile(r'figshare\.com/(?:articles/[^/]+/[^/]+/(\d+)|s/([0-9a-f]+))', re.I)


def curl_json(url, tries=3):
    for t in range(tries):
        p = subprocess.run(["curl", "-sSL", "--max-time", "60", "-H", "Accept: application/json", url],
                           capture_output=True, text=True)
        try:
            d = json.loads(p.stdout)
            if isinstance(d, dict) and d.get("status") in (400, 403, 429):
                time.sleep(6 * (t + 1)); continue
            return d
        except Exception:
            time.sleep(2 * (t + 1))
    return None


def download(url, path):
    if os.path.exists(path) and os.path.getsize(path) > 0:
        return "cached"
    os.makedirs(os.path.dirname(path), exist_ok=True)
    p = subprocess.run(["curl", "-sSL", "--max-time", "300", "-o", path, "-w", "%{http_code}", url],
                       capture_output=True, text=True)
    if p.stdout.strip().startswith("2") and os.path.getsize(path) > 0:
        return "ok"
    if os.path.exists(path):
        os.remove(path)
    return f"FEHLER http={p.stdout.strip()}"


def slug(s, n=48):
    return re.sub(r'-+', '-', re.sub(r'[^a-z0-9]+', '-', (s or "").lower()))[:n].strip('-')


# --- Deposit-Dateilisten mit Download-Links -------------------------------

def osf_files(node, depth=0, url=None):
    url = url or f"https://api.osf.io/v2/nodes/{node}/files/osfstorage/?page%5Bsize%5D=100"
    d = curl_json(url)
    if not d or "data" not in d:
        if depth == 0:
            return osf_files(node, 1,
                f"https://api.osf.io/v2/registrations/{node}/files/osfstorage/?page%5Bsize%5D=100")
        return []
    out = []
    for f in d["data"]:
        a = f.get("attributes", {}) or {}
        if a.get("kind") == "folder":
            if depth < 2:
                rel = (((f.get("relationships", {}) or {}).get("files", {}) or {}).get("links", {}) or {}).get("related")
                href = rel.get("href") if isinstance(rel, dict) else rel
                if href:
                    out += osf_files(node, depth + 1, f"{href}?page%5Bsize%5D=100")
        else:
            dl = (f.get("links", {}) or {}).get("download")
            if dl:
                out.append((a.get("name", "file"), a.get("size") or 0, dl))
    return out


def zenodo_files(rec):
    d = curl_json(f"https://zenodo.org/api/records/{rec}")
    if not d:
        return []
    out = []
    for f in d.get("files", []):
        name = f.get("key") or f.get("filename", "file")
        link = (f.get("links", {}) or {}).get("self") or (f.get("links", {}) or {}).get("download")
        if link:
            out.append((name, f.get("size") or 0, link))
    return out


def dryad_files(doi):
    enc = doi.replace("/", "%2F")
    v = curl_json(f"https://datadryad.org/api/v2/datasets/doi%3A{enc}/versions")
    if not v:
        return []
    vers = (v.get("_embedded", {}) or {}).get("stash:versions", [])
    if not vers:
        return []
    rel = ((vers[-1].get("_links", {}) or {}).get("stash:files", {}) or {}).get("href")
    if not rel:
        return []
    f = curl_json(f"https://datadryad.org{rel}?per_page=100")
    out = []
    for x in (f or {}).get("_embedded", {}).get("stash:files", []):
        # ACHTUNG: der Link heisst "stash:download", nicht "stash:file-download".
        # Mit dem falschen Schluessel liefert Dryad still eine leere Liste und
        # das sieht aus wie ein Deposit ohne Dateien.
        dl = ((x.get("_links", {}) or {}).get("stash:download", {}) or {}).get("href")
        if dl:
            out.append((x.get("path", "file"), x.get("size") or 0, f"https://datadryad.org{dl}"))
    return out


def figshare_files(art):
    d = curl_json(f"https://api.figshare.com/v2/articles/{art}/files")
    if not isinstance(d, list):
        return []
    return [(x.get("name", "file"), x.get("size") or 0, x.get("download_url")) for x in d if x.get("download_url")]


def collect(row):
    urls = f'{row.get("data_urls","")} {row.get("code_urls","")}'
    files, skipped = [], []
    for m in ZEN.finditer(urls):
        files += zenodo_files(m.group(1))
    for m in OSF.finditer(urls):
        files += osf_files(m.group(1))
    for m in DRY.finditer(urls):
        files += dryad_files(m.group(1).rstrip("."))
    for m in FIG.finditer(urls):
        if m.group(1):
            files += figshare_files(m.group(1))
        else:
            skipped.append(("figshare private share link, manuell oeffnen", 0, f"https://figshare.com/s/{m.group(2)}"))
    return files, skipped


def handle(row):
    name = f'{row["year"]}_{slug(row["title"])}_{row["pmcid"] or "noPMC"}'
    base = os.path.join(OUT, name)
    log = [f'TITEL: {row["title"]}', f'DOI: {row["doi"]}', f'PMCID: {row["pmcid"]}',
           f'JOURNAL: {row["journal"]} {row["year"]}',
           f'DATA: {row["data_urls"]}', f'CODE: {row["code_urls"]}', ""]

    # Paper-PDF
    if row.get("pmcid"):
        r = download(f'https://europepmc.org/articles/{row["pmcid"]}?pdf=render',
                     os.path.join(base, "paper.pdf"))
        log.append(f'paper.pdf : {r}')
    else:
        log.append('paper.pdf : uebersprungen, keine PMCID')

    files, skipped = collect(row)
    log.append(f'\nDeposit-Dateien gefunden: {len(files)}')
    got = 0
    for fname, size, url in files:
        mb = (size or 0) / 1e6
        safe = re.sub(r'[^\w.\- ]', '_', fname)[:110]
        if mb > MAX_MB:
            log.append(f'  UEBERSPRUNGEN ({mb:.0f} MB, > {MAX_MB} MB): {fname}\n      {url}')
            continue
        r = download(url, os.path.join(base, "deposit", safe))
        if r in ("ok", "cached"):
            got += 1
        log.append(f'  [{r}] {safe} ({mb:.2f} MB)')
    for s in skipped:
        log.append(f'  MANUELL: {s[0]} -> {s[2]}')

    os.makedirs(base, exist_ok=True)
    with open(os.path.join(base, "MANIFEST.txt"), "w") as fh:
        fh.write("\n".join(log) + "\n")
    return name, got, len(files), len(skipped)


if __name__ == "__main__":
    rows = [r for r in csv.DictReader(open(sys.argv[1]))
            if r["is_rct"] == "True" and int(r["n_tabular"]) > 0]
    print(f"{len(rows)} RCTs werden geladen ...", file=sys.stderr)
    os.makedirs(OUT, exist_ok=True)
    done = []
    with ThreadPoolExecutor(max_workers=3) as ex:
        for i, res in enumerate(ex.map(handle, rows), 1):
            done.append(res)
            print(f'  [{i}/{len(rows)}] {res[0][:56]}  Dateien {res[1]}/{res[2]}', file=sys.stderr)
    print(f'\nFertig. {sum(d[1] for d in done)} Dateien in {OUT}/', file=sys.stderr)
    print(f'Studien ohne jede Deposit-Datei: {sum(1 for d in done if d[2]==0)}', file=sys.stderr)
    print(f'Manuelle figshare-Links: {sum(d[3] for d in done)}', file=sys.stderr)
