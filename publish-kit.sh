#!/bin/bash
# Usage: ./publish-kit.sh <launch-kit.zip or media-kit.html> <author-slug>
# Puts the media kit page at https://nunaisi789-afk.github.io/media-kits/<author-slug>/
set -e
cd "$(dirname "$0")"
SRC="$1"; SLUG="$2"
[ -f "$SRC" ] && [ -n "$SLUG" ] || { echo "Usage: ./publish-kit.sh <kit.zip or media-kit.html> <author-slug>"; exit 1; }
case "$SLUG" in *[!a-z0-9-]*) echo "Slug: lowercase letters, numbers and hyphens only"; exit 1;; esac
mkdir -p "$SLUG"
case "$SRC" in
  *.zip) unzip -p "$SRC" media-kit.html > "$SLUG/index.html" ;;
  *)     cp "$SRC" "$SLUG/index.html" ;;
esac
[ -s "$SLUG/index.html" ] || { echo "No media-kit.html found in $SRC"; exit 1; }
git add "$SLUG" && git commit -q -m "Media kit: $SLUG" && git push -q
echo "Live in about a minute: https://nunaisi789-afk.github.io/media-kits/$SLUG/"
