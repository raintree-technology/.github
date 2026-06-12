# .github

Organization-wide GitHub configuration for [Raintree Technology](https://raintree.technology).

## Contents

| Path | Purpose |
|---|---|
| `profile/README.md` | Organization profile displayed on [github.com/raintree-technology](https://github.com/raintree-technology) |
| `CONTRIBUTING.md` | Default contributing guidelines inherited by all repos without their own |
| `SECURITY.md` | Default security policy and vulnerability reporting process |
| `PULL_REQUEST_TEMPLATE.md` | Default PR template with checklist |
| `ISSUE_TEMPLATE/` | Bug report and feature request templates |
| `CODEOWNERS` | Owner of this repo (CODEOWNERS is **not** inherited — each repo vendors its own) |
| `.github/workflows/ci.yml` | **Reusable CI** every repo calls: frozen install → pin check → biome → typecheck → test → build → gitleaks → Socket |
| `.github/workflows/drift-check.yml` | **Reusable drift check** run on a schedule per repo; fails when a repo stops meeting the standard |
| `scripts/check-pinned-deps.mjs` | Fails on any `^`/`~` range in package.json (root + workspaces) |
| `scripts/drift-check.sh` | The drift-check engine (files, pinning, SHA-pinned actions, CI wiring) |
| `configs/biome.base.jsonc` | Canonical Biome base — vendored per repo, extended by the repo's `biome.json` |
| `configs/tsconfig.base.json` | Canonical strict TypeScript base — vendored per repo |
| `configs/renovate-base.json` | Shared Renovate preset: pin everything, 7-day `minimumReleaseAge`, weekly grouped PRs |
| `templates/README.template.md` | README template (STATUS badge, stack, setup, env vars, scripts, deploy, license) |

## The Raintree standard (per repo)

- Exact-pinned dependencies, one lockfile, frozen installs in CI (`save-exact=true`)
- Biome lint+format extending the vendored canonical base
- Strict TypeScript extending the vendored canonical base
- CI calls the reusable workflow here, pinned to a commit SHA
- All GitHub Actions pinned to full commit SHAs — never floating tags
- Renovate/Dependabot with a 7-day cooldown so freshly published (possibly malicious) versions never land same-day
- Zod-validated env module + committed `.env.example`; secrets only in Vercel env / a secret manager
- README from the template with a STATUS badge (live / WIP / archived)
- Branch protection on `main`: PR required, checks required, no force-push, linear history

### Calling the reusable CI

```yaml
# .github/workflows/ci.yml in any repo
name: CI
on:
  push: {branches: [main]}
  pull_request:
jobs:
  ci:
    uses: raintree-technology/.github/.github/workflows/ci.yml@<commit-sha>
    with:
      package-manager: bun   # bun | pnpm | npm
      standard-ref: <commit-sha>
    secrets: inherit # private repos; public repos may omit this when no optional org secrets are needed
```

### Calling the drift check

```yaml
# .github/workflows/drift-check.yml in any repo
name: Drift check
on:
  schedule: [{cron: "17 6 * * 1"}]
  workflow_dispatch:
jobs:
  drift:
    uses: raintree-technology/.github/.github/workflows/drift-check.yml@<commit-sha>
    with:
      standard-ref: <commit-sha>
```

## How it works

GitHub automatically applies files in this repository as defaults across the organization. Any repository can override these by adding its own version of the same file.

See [GitHub docs: creating a default community health file](https://docs.github.com/en/communities/setting-up-your-project-for-healthy-contributions/creating-a-default-community-health-file) for details.
