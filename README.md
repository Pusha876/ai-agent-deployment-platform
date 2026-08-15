# AI Agent Deployment Platform

Reusable CI/CD platform for deploying AI agents and supporting Azure infrastructure.

## Technology

- Azure
- Microsoft Power Platform
- Microsoft Entra ID
- GitHub Actions
- Terraform
- Power Platform CLI

## Architecture

GitHub Actions provides the CI/CD layer.

Microsoft Entra ID provides workload identity federation using GitHub Actions OIDC.

Terraform manages Azure infrastructure.

Power Platform solutions provide the deployment unit for AI agents and related Power Platform components.

## Environments

- DEV
- TEST
- PROD

## Deployment Flow

Developer
→ GitHub
→ GitHub Actions
→ OIDC
→ Microsoft Entra
→ Azure / Power Platform

## Getting Started

1. Clone the GitHub repository and open it in VS Code.
2. Choose the first implementation runtime and add its project manifest under the repository root.
3. Keep deployable services and infrastructure documented in `docs/`.
4. Add tests alongside each platform capability in `tests/`.
