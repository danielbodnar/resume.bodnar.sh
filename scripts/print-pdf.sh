#!/bin/sh
# Prints the resume to static/resume.pdf with headless Chromium.
#
# Usage: scripts/print-pdf.sh
#
# Run it after editing config.toml or the print styles, then commit
# static/resume.pdf. The Workers build can't run a browser, so the PDF is
# printed here and served as a static file. Set CHROME to use a browser
# binary other than `chromium`.
set -eu

cd "$(dirname "$0")/.."

out=.tmp/print
rm -rf "$out"
zola build --force --output-dir "$out" --base-url "file://$PWD/$out" >/dev/null

"${CHROME:-chromium}" --headless=new --disable-gpu --no-pdf-header-footer \
  --virtual-time-budget=10000 --print-to-pdf=static/resume.pdf \
  "file://$PWD/$out/index.html" 2>/dev/null

rm -rf "$out"
if command -v pdfinfo >/dev/null 2>&1; then
  pdfinfo static/resume.pdf | grep '^Pages:'
fi
# ATS parsers (Greenhouse among them) can't read Type 3 fonts.
if command -v pdffonts >/dev/null 2>&1; then
  if pdffonts static/resume.pdf | grep -q 'Type 3'; then
    echo "static/resume.pdf embeds Type 3 fonts:" >&2
    pdffonts static/resume.pdf | grep 'Type 3' >&2
    exit 1
  fi
fi
