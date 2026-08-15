# Repository Instructions

## Project Focus

This repository contains an AI agent deployment platform. Prefer small, composable changes that keep agent configuration, deployment workflows, runtime code, and operations concerns independently testable.

## Development Rules

- Read the nearest implementation and test before changing behavior.
- Keep secrets out of source control; update `.env.example` when configuration names change.
- Add or update focused tests for behavior changes.
- Document architectural decisions in `docs/decisions/`.
- Keep deployment configuration environment-specific and reproducible.
- Use clear names and avoid introducing a framework or service abstraction without a concrete use case.