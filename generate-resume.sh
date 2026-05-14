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

echo "Generating PDF..."
pandoc "$MD_FILE" \
  --pdf-engine=typst \
  --metadata-file="$META_FILE" \
  -o "$PDF_FILE"
rm -f "$META_FILE"

echo "Generating DOCX..."
pandoc "$MD_FILE" \
  -o "$DOCX_FILE"

echo ""
echo "PDF:  $PDF_FILE"
echo "DOCX: $DOCX_FILE"
