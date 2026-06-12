<!--
Raintree Technology README template.
Replace {{PLACEHOLDERS}}; delete sections that don't apply (a library has no
Deploy section; a worker may have no Env vars). Keep the STATUS badge — the
drift check requires it. Status values: live | WIP | archived.
-->

# {{REPO_NAME}}

![status](https://img.shields.io/badge/status-{{live|WIP|archived}}-{{brightgreen|yellow|lightgrey}})
![Raintree Technology](https://img.shields.io/badge/Raintree-Technology-1a7f37)

{{One-line description: what this is and who it's for.}}

## Stack

{{e.g. Next.js 16 (App Router) · TypeScript (strict) · Bun · Neon (Postgres) · Drizzle · Better Auth · Vercel · Biome}}

## Setup

```bash
{{bun install}}
cp .env.example .env.local   # then fill in values
{{bun dev}}
```

## Environment variables

Validated at boot by {{`lib/env.ts`}} (Zod). Real values live in Vercel env / a
secret manager — never in the repo.

| Variable | Purpose |
| --- | --- |
| `{{DATABASE_URL}}` | {{Neon Postgres connection string}} |

## Scripts

| Script | What it does |
| --- | --- |
| `dev` | local dev server |
| `build` | production build |
| `check` | Biome lint + format check |
| `typecheck` | `tsc --noEmit` |
| `test` | test suite |

## Deploy

{{Vercel project `{{name}}`; pushes to `main` deploy via PR merge only.}}

## License

{{MIT — see [LICENSE](LICENSE) | Proprietary — © FinSync LLC (dba Raintree Technology)}}

---

Built by [Raintree Technology](https://raintree.technology) · [hello@raintree.technology](mailto:hello@raintree.technology)
