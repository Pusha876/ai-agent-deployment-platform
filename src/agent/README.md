# AI Agent Deployment Standard

Every AI agent deployed through this platform must conform
to the platform deployment contract.

## Required Metadata

Each agent must define:

- Agent name
- Agent identifier
- Environment
- Power Platform environment
- Deployment owner
- Required Azure resources
- Required configuration
- Monitoring requirements

## Environment

Supported environments:

- dev
- test
- prod

## Deployment

Agents are deployed through GitHub Actions.

Authentication uses Microsoft Entra Workload Identity
Federation (OIDC).

No long-lived Azure credentials are stored in GitHub.
