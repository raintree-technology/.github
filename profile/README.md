# Raintree Technology

**Open-source evidence infrastructure for AI-native software.**

Raintree Technology builds open-source tools for testing and reviewing AI
systems. Our projects make three commonly hidden layers inspectable: the
context agents consume, the policies governing their actions, and the
interfaces they help generate. Each tool produces durable local evidence and
can enforce release criteria in CI.

Built for engineers working on agents, RAG pipelines, governed data products,
and AI-assisted application development.

[Explore our repositories][org] · [Visit raintree.technology][website] ·
[Start a technical conversation][hello] · [Follow @raintree_tech][x]

## Flagship projects

| Project | Problem | What it does | Best for |
| --- | --- | --- | --- |
| [DocPull][docpull] | External context changes without a reviewable dependency trail | Locks sources, builds cited context packs, detects changes, and gates context quality | Agents, RAG, evals, and context engineering |
| [PolicyStrata][policystrata] | Policy drifts between agent intent, application logic, SQL, databases, and output | Finds cross-layer disagreement and produces reproducible witnesses and release decisions | Text-to-SQL, BI copilots, analytics agents, and governed AI |
| [HIG Doctor][hig-doctor] | Coding agents and teams lack consistent, automatable interface guidance | Combines structured Apple HIG knowledge with deterministic source-level UI audits | Apple platforms and cross-framework interface review |

## Evidence, not just output

- **DocPull** uses dependency manifests, content hashes, lockfiles, cited pack
  contracts, and Context CI to make agent context reviewable.
- **PolicyStrata** ships a reproducible paper artifact reporting 1,720/1,720
  killed non-clean injected cases and zero false positives on 80 clean controls.
- **HIG Doctor** evaluates 348 deterministic rules across 12 native and web
  framework families, backed by 14 agent skills and 156 reference topics.
- **All three** prioritize deterministic, local-first workflows before optional
  hosted or model-dependent execution.

## [DocPull][docpull]

**Lock, inspect, and test the external context your agents depend on.**

DocPull treats context like a software dependency. A project declares public
web, package, repository, standard, API, dataset, or local-file sources; DocPull
syncs them into versioned packs with stable citations, provenance, coverage,
rights metadata, and content hashes. Context CI checks whether those artifacts
are fresh, complete, attributable, and ready for an agent or evaluation loop.

Use DocPull when a model must answer from specific, reviewable sources rather
than an opaque scrape or an unversioned collection of documents. Its base
workflow is local and browser-free; rendering and paid-capable routes require
explicit opt-in.

[Repository][docpull] · [PyPI][docpull-pypi] ·
[Pack contract][docpull-contract] · [Context CI][docpull-ci]

## [PolicyStrata][policystrata]

**Detect policy drift across agent, application, SQL, and database layers.**

PolicyStrata compares a canonical policy with the behavior exposed by
manifests, semantic plans, validators, compilers, database controls, and release
filters. Its scanner imports representative traces, exercises deterministic
mutations, localizes the first disagreement, and reduces failures into compact
witnesses that can be reviewed or enforced in CI.

The project also includes a TypeScript recorder and default-deny authorizer,
plus a customer-hosted Agent Trust Gateway for local runtime evaluation and
sanitized decision envelopes. These controls add evidence and defense in depth;
they do not replace application authorization or database policy.

[Repository][policystrata] · [Paper][policystrata-paper] ·
[Reproduction artifact][policystrata-release] · [PyPI][policystrata-pypi] ·
[Node runtime][policystrata-node] · [Agent Trust Gateway][policystrata-gateway]

## [HIG Doctor][hig-doctor]

**Give coding agents deterministic Apple HIG guidance and source-level audits.**

HIG Doctor combines a progressively disclosed Human Interface Guidelines
corpus, a cross-framework static auditor, and a small MCP surface for coding
agents. It checks accessibility, semantic color, typography, layout, motion,
focus, input, and interaction patterns, then returns file-level findings,
positive signals, Markdown reports, JSON, and configurable severity gates.

Use HIG Doctor as a fast, repeatable first pass across SwiftUI, UIKit, React,
Vue, Svelte, Angular, Compose, Android XML, React Native, Flutter, CSS, and
HTML. It provides source-level evidence—not rendered UI testing, assistive
technology testing, or a complete compliance certification.

[Repository][hig-doctor] · [Reference site][hig-site]

## How we build

- **Deterministic before probabilistic:** test observable state and explicit
  contracts before asking a model to judge a system.
- **Evidence over dashboards:** keep hashes, traces, reports, citations, and
  witnesses portable and reviewable.
- **Explicit trust boundaries:** state what each tool observes, what it can
  gate, and which responsibilities remain with the host system.
- **Local-first execution:** make the useful base workflow run without a hosted
  account or automatic paid route.

## More open source

[agent-starter][agent-starter] generates portable skills and MCP configuration
for Claude Code, Codex, and Cursor from one versioned manifest.

## Contributing and security

Issues and pull requests are welcome. Each repository documents its own build,
test, and contribution workflow.

To report a vulnerability, **do not open a public issue**. Email
[security@raintree.technology][security] with the affected repository, version
or commit, reproduction steps, and potential impact.

Building an agent, governed AI product, or developer tool?
[Start a technical conversation →][hello]

[website]: https://raintree.technology
[org]: https://github.com/raintree-technology
[x]: https://x.com/raintree_tech
[hello]: mailto:hello@raintree.technology
[docpull]: https://github.com/raintree-technology/docpull
[docpull-pypi]: https://pypi.org/project/docpull/
[docpull-contract]: https://github.com/raintree-technology/docpull/blob/main/docs/context-pack-contract-v3.md
[docpull-ci]: https://github.com/raintree-technology/docpull/blob/main/docs/context-ci.md
[policystrata]: https://github.com/raintree-technology/policystrata
[policystrata-paper]: https://raintree.technology/papers/PolicyStrata.pdf
[policystrata-release]: https://github.com/raintree-technology/policystrata/releases/tag/policystrata-paper-2026-06-26
[policystrata-pypi]: https://pypi.org/project/policystrata/
[policystrata-node]: https://github.com/raintree-technology/policystrata/tree/main/packages/node
[policystrata-gateway]: https://github.com/raintree-technology/policystrata/tree/main/packages/gateway
[hig-doctor]: https://github.com/raintree-technology/hig-doctor
[hig-site]: https://apple.raintree.technology
[agent-starter]: https://github.com/raintree-technology/agent-starter
[security]: mailto:security@raintree.technology
