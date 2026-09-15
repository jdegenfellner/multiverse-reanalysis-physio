#!/usr/bin/env python3
"""Holt die Dryad-Deposits als Versions-ZIP und entpackt sie.

WARUM SO: Der Endpunkt fuer EINZELDATEIEN (/api/v2/files/{id}/download) antwortet
auch bei oeffentlich publizierten Datensaetzen mit HTTP 401, und /downloads/file_stream
mit 403. Nur der Download der ganzen Version (/api/v2/versions/{id}/download) liefert
HTTP 200 und ein ZIP. Der Datensatzstatus laesst sich vorher pruefen: curationStatus
muss "Published" sein.
"""
import csv, json, os, re, subprocess, sys, time, zipfile

DRY = re.compile(r'(10\.5061/dryad[\w./]+)', re.I)
PAUSE = 6
OUT = "studies"


def curl_json(url, tries=4):
    for t in range(tries):
        p = subprocess.run(["curl", "-sSL", "--max-time", "60", "-H", "Accept: application/json", url],
                           capture_output=True, text=True)
        try:
            return json.loads(p.stdout)
        except Exception:
            time.sleep(PAUSE * (t + 1))
    return None


def version_id(doi):
    enc = doi.replace("/", "%2F")
    v = curl_json(f"https://datadryad.org/api/v2/datasets/doi%3A{enc}/versions")
    vers = ((v or {}).get("_embedded", {}) or {}).get("stash:versions", [])
    if not vers:
        return None, None
    last = vers[-1]
    href = ((last.get("_links", {}) or {}).get("self", {}) or {}).get("href", "")
    return href.rstrip("/").split("/")[-1] or None, last.get("versionNumber")


if __name__ == "__main__":
    rows = [r for r in csv.DictReader(open(sys.argv[1]))
            if r["is_rct"] == "True" and DRY.search(f'{r["data_urls"]} {r["code_urls"]}')]
    print(f"{len(rows)} Studien mit Dryad-Deposit", file=sys.stderr)

    for i, r in enumerate(rows, 1):
        cand = [d for d in os.listdir(OUT) if d.endswith(r["pmcid"])]
        if not cand:
            print(f"  [{i}] Ordner fuer {r['pmcid']} fehlt", file=sys.stderr)
            continue
        base = os.path.join(OUT, cand[0])
        dep = os.path.join(base, "deposit")
        if os.path.isdir(dep) and os.listdir(dep):
            print(f"  [{i}] {cand[0][:50]} schon befuellt", file=sys.stderr)
            continue

        doi = DRY.search(f'{r["data_urls"]} {r["code_urls"]}').group(1).rstrip(".")
        vid, _ = version_id(doi)
        if not vid:
            print(f"  [{i}] {cand[0][:50]}  keine Version gefunden ({doi})", file=sys.stderr)
            continue

        os.makedirs(dep, exist_ok=True)
        zpath = os.path.join(dep, f"dryad_{vid}.zip")
        p = subprocess.run(["curl", "-sSL", "--max-time", "600", "-o", zpath, "-w", "%{http_code}",
                            f"https://datadryad.org/api/v2/versions/{vid}/download"],
                           capture_output=True, text=True)
        code = p.stdout.strip()
        if not (code.startswith("2") and os.path.exists(zpath) and os.path.getsize(zpath) > 0):
            print(f"  [{i}] {cand[0][:50]}  FEHLER http={code}", file=sys.stderr)
            if os.path.exists(zpath):
                os.remove(zpath)
            time.sleep(PAUSE)
            continue

        n = 0
        try:
            with zipfile.ZipFile(zpath) as z:
                for m in z.namelist():
                    if m.endswith("/"):
                        continue
                    safe = re.sub(r'[^\w.\- ]', '_', os.path.basename(m))[:110]
                    if not safe:
                        continue
                    with z.open(m) as src, open(os.path.join(dep, safe), "wb") as dst:
                        dst.write(src.read())
                    n += 1
            os.remove(zpath)
        except zipfile.BadZipFile:
            print(f"  [{i}] {cand[0][:50]}  ZIP defekt, bleibt liegen", file=sys.stderr)

        print(f"  [{i}] {cand[0][:50]}  {n} Dateien entpackt "
              f"({os.path.getsize(zpath)/1e6 if os.path.exists(zpath) else 0:.1f} MB Rest)", file=sys.stderr)
        time.sleep(PAUSE)
