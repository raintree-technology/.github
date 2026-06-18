#!/usr/bin/env bash
# Raintree standard drift check. Run from the root of the repo under test with
# the org .github repo checked out at .raintree-standard/ (or set STANDARD_DIR).
# Checks apply conditionally by repo type; each violation is one FAIL line.
set -u
STANDARD_DIR="${STANDARD_DIR:-.raintree-standard}"
FAILURES=0
fail() { echo "FAIL: $1"; FAILURES=$((FAILURES + 1)); }
warn() { echo "WARN: $1"; }
ok()   { echo "ok:   $1"; }

# ---- universal checks -------------------------------------------------------
[ -f README.md ] || fail "README.md missing"
if [ -f README.md ]; then
  grep -qE 'img\.shields\.io/badge/status-' README.md \
    && ok "README has STATUS badge" \
    || fail "README missing STATUS badge (live/WIP/archived)"
fi

if git ls-files --error-unmatch .env >/dev/null 2>&1; then
  fail ".env is committed to git"
else
  ok "no committed .env"
fi

# every workflow `uses:` must be pinned to a 40-char SHA (local ./ refs and
# docker:// refs excluded)
if [ -d .github/workflows ]; then
  UNPINNED=$(grep -rhoE 'uses:\s*[^ ]+@[^ #]+' .github/workflows/ 2>/dev/null \
    | grep -vE '@[0-9a-f]{40}$' \
    | grep -vE 'uses:\s*(\./|docker://)' || true)
  if [ -n "$UNPINNED" ]; then
    fail "workflow actions not pinned to commit SHAs:"$'\n'"$UNPINNED"
  else
    ok "all workflow actions SHA-pinned"
  fi
  grep -rq 'raintree-technology/.github/.github/workflows/ci.yml@' .github/workflows/ 2>/dev/null \
    && ok "central reusable CI wired" \
    || warn "repo does not call the central reusable CI (fine for Python/Swift/shell repos with bespoke CI)"
else
  fail "no .github/workflows directory"
fi

# ---- JS/TS repos ------------------------------------------------------------
if [ -f package.json ]; then
  node "$STANDARD_DIR/scripts/check-pinned-deps.mjs" || fail "unpinned dependencies (see above)"

  LOCKS=0
  for f in bun.lock bun.lockb pnpm-lock.yaml package-lock.json; do
    [ -f "$f" ] && LOCKS=$((LOCKS + 1))
  done
  [ "$LOCKS" -eq 1 ] && ok "exactly one lockfile" || fail "expected exactly 1 lockfile, found $LOCKS"

  if [ -f biome.json ] || [ -f biome.jsonc ]; then
    ok "biome config present"
  else
    fail "no biome.json/biome.jsonc"
  fi

  node -e "process.exit(require('./package.json').engines?.node ? 0 : 1)" 2>/dev/null \
    && ok "engines.node declared" \
    || fail "package.json missing engines.node"
fi

# ---- Python repos -----------------------------------------------------------
if [ -f pyproject.toml ]; then
  [ -f uv.lock ] || [ -f poetry.lock ] || fail "pyproject.toml without lockfile (uv.lock/poetry.lock)"
fi

# ---- summary ----------------------------------------------------------------
echo ""
if [ "$FAILURES" -gt 0 ]; then
  echo "DRIFT: $FAILURES violation(s) of the Raintree standard."
  exit 1
fi
echo "No drift detected."
