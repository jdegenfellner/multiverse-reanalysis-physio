import re, sys
b=open('supplement_body.tex').read()
b=b.replace("−","$-$").replace("≤","$\\leq$").replace("≥","$\\geq$").replace("×","$\\times$").replace("\u2009","\\,").replace("\u00a0","~").replace("\\def\\LTcaptype{none} % do not increment counter","")
b=re.sub(r"\\includegraphics(\[[^\]]*\])?\{", r"\\includegraphics[width=\\textwidth,height=0.85\\textheight,keepaspectratio]{", b)
b=re.sub(r"\\begin\{figure\}\s*\\centering", r"\\begin{figure}[H]\\centering", b)
# Tabellen ohne Breitenangabe: feste p-Spalten mit Umbruch, Gesamtbreite = \textwidth
def fix(m):
    spec=m.group(1)
    if "p{" in spec or "real" in spec: return m.group(0)
    cols=[c for c in spec if c in "lrc"]
    n=len(cols)
    if n==0: return m.group(0)
    w=f"\\dimexpr(\\textwidth-{2*n}\\tabcolsep)/{n}\\relax"
    newspec="".join(("@{}" if i==0 else "")+(">{\\raggedright\\arraybackslash}p{"+w+"}" if c!="r" else ">{\\raggedleft\\arraybackslash}p{"+w+"}") for i,c in enumerate(cols))+"@{}"
    return "\\begin{longtable}[]{"+newspec+"}"
b=re.sub(r"\\begin\{longtable\}\[\]\{([^}]*)\}", fix, b)
open('supplement_body.tex','w').write(b); print("postprocess ok")
