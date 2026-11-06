#!/usr/bin/env bash
# Convertit toutes les règles Sigma vers un backend (sigma-cli requis).
set -euo pipefail
BACKEND="${1:?backend ex: elasticsearch/splunk}"; PIPE="${2:-}"
OUT="converted-$BACKEND"; mkdir -p "$OUT"
for f in rules/*.yml; do
  name="$(basename "$f" .yml)"
  if [ -n "$PIPE" ]; then
    sigma convert -t "$BACKEND" -p "$PIPE" "$f" > "$OUT/$name.query" 2>/dev/null || echo "  (échec: $f)"
  else
    sigma convert -t "$BACKEND" "$f" > "$OUT/$name.query" 2>/dev/null || echo "  (échec: $f)"
  fi
  echo "  -> $OUT/$name.query"
done
echo "Terminé. Requêtes dans $OUT/"
