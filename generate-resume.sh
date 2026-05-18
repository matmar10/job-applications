#!/usr/bin/env bash
set -euo pipefail

if [ $# -ne 1 ]; then
  echo "Usage: $0 <path-to-resume.md>"
  exit 1
fi

MD_FILE="$(cd "$(dirname "$1")" && pwd)/$(basename "$1")"
BASE="${MD_FILE%.md}"
PDF_FILE="${BASE}.pdf"
DOCX_FILE="${BASE}.docx"

command -v pandoc >/dev/null || { echo "Error: pandoc not found. Run: brew install pandoc"; exit 1; }
command -v typst >/dev/null || { echo "Error: typst not found. Run: brew install typst"; exit 1; }

META_FILE="$(mktemp /tmp/resume-meta-XXXXXX.yaml)"
cat > "$META_FILE" <<'EOF'
papersize: us-letter
margin:
  top: 0.5in
  bottom: 0.5in
  left: 0.5in
  right: 0.5in
EOF

TYP_FILE="$(mktemp /tmp/resume-XXXXXX.typ)"

echo "Generating PDF..."
# Convert markdown to typst first, then inject footer, then compile
pandoc "$MD_FILE" \
  --metadata-file="$META_FILE" \
  -t typst \
  -o "$TYP_FILE"

# Inject footer at top of .typ file (before document content)
FOOTER='#set page(footer: context [
  #set text(size: 7pt, fill: luma(120))
  Resume of Matthew Joseph Martin – Staff Software Engineer
  #h(1fr)
  Page #counter(page).display() of #context counter(page).final().at(0)
])
'
printf '%s\n' "$FOOTER" | cat - "$TYP_FILE" > "${TYP_FILE}.tmp" && mv "${TYP_FILE}.tmp" "$TYP_FILE"

typst compile "$TYP_FILE" "$PDF_FILE"
rm -f "$META_FILE" "$TYP_FILE"

echo "Generating DOCX..."
pandoc "$MD_FILE" \
  -o "$DOCX_FILE"
python3 "$(dirname "$0")/add-footer.py" "$DOCX_FILE"

echo ""
echo "PDF:  $PDF_FILE"
echo "DOCX: $DOCX_FILE"
