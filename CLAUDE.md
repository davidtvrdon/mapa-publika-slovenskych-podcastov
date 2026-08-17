# Mapa publika slovenských podcastov

Single-page static site. `index.html` is the whole app: styles, script and data in one
file. There is no build step for the page itself and no dependencies to install.

## Deployment — read this before merging anything

**GitHub Pages builds from the `claude/gallant-gates-UKccu` branch, not from `main`.**

`main` is the repository's default branch, so pull requests default to it, but nothing
publishes it. A change merged only into `main` does not reach
https://davidtvrdon.github.io/mapa-publika-slovenskych-podcastov/ — the site keeps
serving whatever `claude/gallant-gates-UKccu` holds. Verify the source branch from the
deploy history (`pages build and deployment` workflow runs) rather than assuming, since
the setting lives in repo settings and is not visible in the tree.

Publishing a change therefore means:

1. Merge it into `claude/gallant-gates-UKccu`.
2. Wait for the `pages build and deployment` run on that branch to finish and confirm
   the `deploy` job succeeded. It takes roughly 90 seconds.
3. Merge the same change into `main` so the default branch does not drift.

Carry data updates through all three steps without stopping to ask. An open pull
request is not a delivered update. Repointing Pages at `main` in Settings → Pages would
collapse this to a single merge, but that is a manual settings change.

## Updating the data

The IAB Slovakia monthly report arrives as an xlsx with one sheet per month plus a
`Demografia_<year>` sheet. To roll the site forward:

1. Add the new month(s) to `ALL_SHEETS` in `tools/build_data.py`, oldest first, as
   `('<exact sheet name>', '<short chart label>')`. Sheet names are inconsistent in the
   source (`'Marec _2026'`, `'Januar_2026'`, `'Máj 2025'`) — copy them verbatim.
2. Run `python3 tools/build_data.py <report>.xlsx` (needs `openpyxl`; `--dry` to preview).
   It rewrites the `DATA`, `TREND` and `MONTHS` lines in `index.html` in place.
3. **Read the printed report.** It lists fuzzy name matches, stitched trend series and
   podcasts left without play counts. The source sheets rename and re-spell podcasts
   between months, so these need a human eye each round — a wrong match silently
   attributes one show's numbers to another.
4. Update the period-dependent prose by hand: the source-note link and `(MM/YYYY)` label
   in the footer, the `X zo 107` counts and the plays figure for the largest podcast
   without demographics in the methodology paragraph, and the matching lines in
   `README.md`. The trend chart heading derives itself from `MONTHS`.
5. If cluster centroids have drifted, refresh the `seed` values in `SEGMENTS` from the
   `wf`/`u35` printed for each segment, so the next update starts from current positions.

### How the numbers are derived

Reverse-engineered from the original data and verified to reproduce it exactly:

- Podcast list, demographics, publisher and medium come from `Demografia_<year>`; rows
  whose gender and age values are all zero are excluded (no demographics).
- Values arrive in three formats in the same sheet: fractions (`0.325`), percentages
  (`32.5`) and strings (`'32,5 %'`). Scale is detected per row group by whether the
  group sums to ~1 or ~100.
- `wf` = women as a share of women+men. `u35` = sum of the first four age bands.
- `meanage` uses band midpoints `8.5, 20, 25, 31, 39.5, 52, 67`, normalised by the sum
  of the age values (which does not always reach 100 in the source).
- `small` (the ◌ marker) flags degenerate samples: two or fewer non-empty age bands, or
  a single band at 80 % or more.
- `plays` and `cat` come from the newest monthly sheet, joined on podcast name: exact,
  then diacritic/case-insensitive, then — constrained to the same publisher — substring
  or fuzzy match. Publisher labels differ between sheets too (`Petit Press` vs
  `PetitPress`, `News and Media` vs `News and Media Holding`), so comparison is
  prefix-tolerant.
- Segments are k-means (k=6) on standardised `(wf, u35)`, seeded from the previous
  centroids so segment ids, names and colours keep their meaning across updates.
- `TREND` holds one series per mapped podcast over the last 12 months. Series the source
  renames mid-year are stitched together only when their reported months do not overlap;
  overlapping months mean two distinct shows.

## Verifying a change

`index.html` has no test suite. Check it by loading it in a browser and confirming the
map draws, a podcast detail panel opens with its trend chart, and the console is clean
(the Bunny Fonts stylesheet may fail in sandboxed networks — that is expected). Exercise
a podcast with unknown plays and one flagged ◌, since those take different code paths.
