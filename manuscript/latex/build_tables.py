"""tables.md -> tables.tex (pandoc + postprocessing). Run from manuscript/latex."""
import re, subprocess
raw = subprocess.run(["pandoc", "../tables.md", "-t", "latex", "--wrap=none"], capture_output=True, text=True, check=True).stdout
raw = re.sub(r"^\\section\{Tables, generated[^\n]*\n", "", raw)
labels = {"Table 1": "tab:nodes", "Table 2": "tab:report", "Table 3": "tab:repro"}
def sub(m):
    title = m.group(1); lab = next(v for k, v in labels.items() if title.startswith(k))
    return "\\subsection*{" + title + "}\\label{" + lab + "}"
raw = re.sub(r"\\subsection\{([^}]*)\}\\label\{[^}]*\}", sub, raw)
raw = raw.replace("{\\def\\LTcaptype{none} % do not increment counter", "{")
def cite(m):
    keys = [k.strip().replace("\\_", "_").split(",")[0].strip() for k in m.group(1).split(";")]
    return "\\cite{" + ",".join(keys) + "}"
raw = re.sub(r"\{\[\}([A-Za-z][A-Za-z\\_0-9;,\s]*?)\{\]\}", cite, raw)
raw = raw.replace("−", "$-$").replace("≤", "$\\leq$").replace("≥", "$\\geq$").replace("×", "$\\times$").replace("\u2009", "\\,").replace("\u00a0", "~")
open("tables.tex", "w").write(raw)
print("tables.tex written")
