#!/bin/zsh
# Oeffnet paper.pdf in Preview auf der Seite, die den Suchtext enthaelt.
# Aufruf: ./open_at.sh "Suchtext"   (ohne Argument: Seite 1)
PDF="$(cd "$(dirname "$0")" && pwd)/paper.pdf"
PAGE=1
if [ -n "$1" ]; then
  N=$(pdfinfo "$PDF" | awk '/Pages/{print $2}')
  for p in $(seq 1 $N); do
    if pdftotext -f $p -l $p "$PDF" - 2>/dev/null | tr -s ' \n' ' ' | grep -qiF "$1"; then PAGE=$p; break; fi
  done
fi
open -a Preview "$PDF"
sleep 1.2
osascript <<APPLESCRIPT
tell application "Preview" to activate
tell application "System Events"
  tell process "Preview"
    keystroke "g" using {option down, command down}
    delay 0.4
    keystroke "$PAGE"
    keystroke return
  end tell
end tell
APPLESCRIPT
echo "Seite $PAGE"
