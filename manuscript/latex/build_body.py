"""paper.md -> abstract.tex + body.tex (pandoc + figure environments). Run from manuscript/latex."""
import re, subprocess
s = open("../paper.md").read()
def cite(m):
    keys = [k.split(",")[0].strip() for k in m.group(1).split(";")]
    return "\\cite{" + ",".join(keys) + "}"
def md_to_tex(md, shift):
    t = re.sub(r"\[([A-Za-z][A-Za-z_0-9]*_\d{4}[A-Za-z_0-9]*(?:;\s*[A-Za-z][A-Za-z_0-9]*_\d{4}[A-Za-z_0-9]*)*)\]", cite, md)
    t = re.sub(r"^## \d+\. ", "## ", t, flags=re.M); t = re.sub(r"^### \d+\.\d+ ", "### ", t, flags=re.M); t = t.replace("---\n", "")
    out = subprocess.run(["pandoc", "-f", "markdown", "-t", "latex", "--wrap=none", f"--shift-heading-level-by={shift}"], input=t, capture_output=True, text=True, check=True).stdout
    out = out.replace("−", "$-$").replace("≤", "$\\leq$").replace("≥", "$\\geq$").replace("×", "$\\times$").replace("\u2009", "\\,").replace("\u00a0", "~")
    return re.sub(r"(?<!\\) & ", " \\\\& ", out)
a0 = s.index("## Abstract"); a1 = s.index("## 1. Introduction")
abstract = s[a0:a1]; abstract = re.sub(r"^## Abstract\s*\n", "", abstract)
open("abstract.tex", "w").write(md_to_tex(abstract, 0))
body = s[a1:]; body = re.sub(r"\n---\n\n\*Tables 1 to 3 and Figures.*?\*\s*$", "\n", body, flags=re.S)
b = md_to_tex(body, -1)
b = b.replace("Figure 1 shows", "Figure~\\ref{fig:flow} shows").replace("(Figure 4)", "(Figure~\\ref{fig:variance})").replace("Figure 2 shows, for the 11 trials", "Figure~\\ref{fig:displacement} shows, for the 11 trials")
b = re.sub(r"and Figure 3\s+the specification", "and Figure~\\\\ref{fig:curves} the specification", b); b = re.sub(r"Figure 3 shows the specification", "Figure~\\\\ref{fig:curves} shows the specification", b)
b = b.replace("(Table 3)", "(Table~\\ref{tab:repro})").replace("(Table 2)", "(Table~\\ref{tab:report})").replace("(Table 1)", "(Table~\\ref{tab:nodes})")
old = open("body.tex").read()
figs = re.findall(r"\n\\begin\{figure\}\[p\].*?\\end\{figure\}\n", old, flags=re.S)
pick = lambda tag: [f for f in figs if tag in f][0]
def ins(b, pats, fig):
    for pat in pats:
        m = re.search(pat, b)
        if m: return b[:m.end()] + "\n" + fig + b[m.end():]
    raise SystemExit("figure anchor missing: " + pats[0])
b = ins(b, [r"shows the corpus\."], pick("fig:flow"))
b = ins(b, [r"away from the reproduced\s+published estimate\.", r"away from the\s+reproduced published estimate\."], pick("fig:displacement"))
b = ins(b, [r"specification curves of two\s+trials\."], pick("fig:curves"))
b = ins(b, [r"Figure~\\ref\{fig:variance\}[^.]*\."], pick("fig:variance"))
open("body.tex", "w").write(b); print("abstract.tex and body.tex written")
