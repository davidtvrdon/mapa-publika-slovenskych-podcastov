#!/usr/bin/env bash
# Wait until the Pages deploy serves the newest index.html, then merge the Pages branch
# into main. Run after a data change has landed on the Pages branch (see CLAUDE.md).
set -euo pipefail
PAGES=claude/gallant-gates-UKccu
git fetch -q origin "$PAGES" main
want=$(git show "origin/$PAGES:index.html" | grep -o 'Aktualizované [0-9. ]*' | head -1)
src=$(git show "origin/$PAGES:index.html" | grep -o 'https://www.iabslovakia.sk/[^"]*' | head -1)
for _ in $(seq 1 40); do
  page=$(curl -fsS https://davidtvrdon.github.io/mapa-publika-slovenskych-podcastov/ || true)
  if grep -qF "$src" <<<"$page" && grep -qF "$want" <<<"$page"; then echo "live: $want"; break; fi
  sleep 15
done
grep -qF "$want" <<<"$page" || { echo "deploy not live after 10 minutes" >&2; exit 1; }
git config user.name "github-actions[bot]"
git config user.email "41898282+github-actions[bot]@users.noreply.github.com"
git checkout -q -B main origin/main
git merge --no-ff "origin/$PAGES" -m "Merge: sync main with the published data"
git push origin main
