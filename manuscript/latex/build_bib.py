"""literature/references.bib -> latex/references.bib (bibtex-safe copy). Run from manuscript/latex."""
import re
src = open("../../literature/references.bib").read()
entries = re.split(r"(?=^\s*@\w+\{)", src, flags=re.M)
out = []
for e in entries:
    if not e.strip(): continue
    e = re.sub(r",\s*month\s*=\s*[^,}]*(\{[^}]*\})?", "", e)          # month strings
    if re.search(r"\b[Dd][Oo][Ii]\s*=", e):
        e = re.sub(r",\s*url\s*=\s*\{[^}]*\}", "", e, flags=re.I)      # url redundant with DOI
    e = re.sub(r",\s*keywords\s*=\s*\{[^}]*\}", "", e)
    e = re.sub(r",\s*copyright\s*=\s*\{[^}]*\}", "", e)
    def trunc(m):
        auth = [a.strip() for a in m.group(1).split(" and ")]
        if len(auth) > 6: auth = auth[:6] + ["others"]
        return "author={" + " and ".join(auth) + "}"
    e = re.sub(r"author\s*=\s*\{((?:[^{}]|\{[^{}]*\})*)\}", trunc, e)
    e = e.replace("&lt;", "$<$").replace("&gt;", "$>$").replace("<i>", " ").replace("</i>", " ").replace("  ", " ").replace("&amp;", "\\&")
    e = re.sub(r"(?<!\\)&(?![a-z#])", "\\&", e)
    out.append(e.strip())
open("references.bib", "w").write("\n\n".join(out) + "\n")
print(len(out), "entries written")
