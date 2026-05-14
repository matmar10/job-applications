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

for f in "$PDF_FILE" "$DOCX_FILE"; do
  [ -f "$f" ] || { echo "Error: $f not found. Run generate-resume.sh first."; exit 1; }
done

command -v gcloud >/dev/null || { echo "Error: gcloud not found."; exit 1; }
ACCESS_TOKEN=$(gcloud auth print-access-token 2>/dev/null) || { echo "Error: gcloud auth failed. Run: gcloud auth login"; exit 1; }

upload_and_share() {
  local file="$1"
  local mime="$2"
  local name
  name="$(basename "$file")"

  local id
  id=$(curl -s -X POST \
    "https://www.googleapis.com/upload/drive/v3/files?uploadType=multipart&fields=id" \
    -H "Authorization: Bearer $ACCESS_TOKEN" \
    -F "metadata={\"name\":\"$name\",\"mimeType\":\"$mime\"};type=application/json;charset=UTF-8" \
    -F "file=@$file;type=$mime" | python3 -c "import sys,json; print(json.load(sys.stdin)['id'])")

  curl -s -X POST \
    "https://www.googleapis.com/drive/v3/files/$id/permissions" \
    -H "Authorization: Bearer $ACCESS_TOKEN" \
    -H "Content-Type: application/json" \
    -d '{"role":"reader","type":"anyone"}' > /dev/null

  echo "https://drive.google.com/file/d/$id/view"
}

echo "Uploading PDF..."
PDF_URL=$(upload_and_share "$PDF_FILE" "application/pdf")

echo "Uploading DOCX..."
DOCX_URL=$(upload_and_share "$DOCX_FILE" "application/vnd.openxmlformats-officedocument.wordprocessingml.document")

echo ""
echo "PDF_URL=$PDF_URL"
echo "DOCX_URL=$DOCX_URL"
