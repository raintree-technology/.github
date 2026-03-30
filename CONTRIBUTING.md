# Contributing to Raintree Technology

Thank you for your interest in contributing. We welcome issues, feature requests, bug reports, and pull requests across all our public repositories.

## Getting Started

1. **Fork** the repository you want to contribute to
2. **Clone** your fork locally
3. **Install dependencies** per the repo's README
4. **Create a branch**: `git checkout -b feat/your-feature-name`
5. **Make changes** with clear, atomic commits
6. **Run tests** and linting before pushing
7. **Open a Pull Request** against `main`

## Commit Style

We use [Conventional Commits](https://www.conventionalcommits.org/):

- `feat:` — new feature
- `fix:` — bug fix
- `docs:` — documentation only
- `chore:` — maintenance, dependency updates
- `refactor:` — code change without feature/fix
- `test:` — adding or updating tests
- `perf:` — performance improvement

## Code Style

Each language has a designated formatter — run it before committing:

| Language | Tool |
|---|---|
| TypeScript / JS | `biome format --write .` |
| Rust | `cargo fmt` |
| Python | `black .` |

Linting is enforced on PRs. Ensure `biome check`, `cargo clippy`, or equivalent passes.

## Pull Request Guidelines

- Keep PRs focused — one feature or fix per PR
- Include a clear description of *what* and *why*
- Reference related issues with `Closes #123`
- Add tests for any new functionality
- Update documentation where relevant
- Screenshots are appreciated for UI changes

## Reporting Bugs

Use the Bug Report issue template. Include:
- Steps to reproduce
- Expected vs actual behavior
- Environment (OS, runtime version, etc.)
- Relevant logs or error output

## Feature Requests

Use the Feature Request issue template. Be specific about the use case and expected behavior.

## Code of Conduct

All contributors are expected to follow our [Code of Conduct](CODE_OF_CONDUCT.md).

## Questions

Open a Discussion or reach out at [support@raintree.technology](mailto:support@raintree.technology).
