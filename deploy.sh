#!/usr/bin/env bash
# -----------------------------------------------------------------------------
# deploy.sh — sync the development site/ folder into docs/ so that GitHub
# Pages (configured to serve from main:/docs) picks up the latest output.
#
# Usage:
#   bash deploy.sh
#
# Then commit and push the docs/ changes:
#   git add docs/
#   git commit -m "deploy: refresh docs/ from site/"
#   git push
# -----------------------------------------------------------------------------

set -euo pipefail

ROOT="$(cd "$(dirname "$0")" && pwd)"
SRC="$ROOT/site"
DST="$ROOT/docs"

if [ ! -d "$SRC" ]; then
  echo "✗ Source folder $SRC not found." >&2
  exit 1
fi

echo "Syncing $SRC/ → $DST/"
mkdir -p "$DST"

# Use rsync if available (preserves correct deletion of removed files);
# fall back to cp -r otherwise.
if command -v rsync >/dev/null 2>&1; then
  rsync -a --delete "$SRC/" "$DST/"
else
  rm -rf "$DST"
  mkdir -p "$DST"
  cp -r "$SRC/." "$DST/"
fi

echo "Done. docs/ is now in sync with site/."
echo ""
echo "Next steps:"
echo "  git add docs/"
echo "  git commit -m \"deploy: refresh docs/ from site/\""
echo "  git push"
echo ""
echo "GitHub Pages will republish automatically (1–2 minutes)."
