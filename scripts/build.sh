#!/bin/sh
# Builds resume.bodnar.sh into public/ for Cloudflare Workers.
#
# Usage: scripts/build.sh
#
# Uses `zola` from PATH, or downloads the pinned release into .cache/ and
# checks its SHA-256 (the Workers Builds image doesn't ship Zola). Writes
# public/resume.md from config.toml with Bun. public/resume.pdf is copied
# from static/resume.pdf, which scripts/print-pdf.sh regenerates.
set -eu

ZOLA_VERSION=0.23.6
ZOLA_SHA256=8f5132b3522412d04e395e0b25f6d68613ad272a873e54a2b3ebf664873024a4

cd "$(dirname "$0")/.."

if command -v zola >/dev/null 2>&1; then
  zola=zola
else
  dir=".cache/zola-$ZOLA_VERSION"
  if [ ! -x "$dir/zola" ]; then
    mkdir -p "$dir"
    curl -fsSL -o "$dir/zola.tar.gz" \
      "https://github.com/getzola/zola/releases/download/v$ZOLA_VERSION/zola-v$ZOLA_VERSION-x86_64-unknown-linux-gnu.tar.gz"
    echo "$ZOLA_SHA256  $dir/zola.tar.gz" | sha256sum -c -
    tar -xzf "$dir/zola.tar.gz" -C "$dir"
  fi
  zola="$dir/zola"
fi

"$zola" build "$@"
bun scripts/resume-md.ts > public/resume.md
