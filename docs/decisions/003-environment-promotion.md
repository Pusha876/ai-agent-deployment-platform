# ADR-003: Environment Promotion and Deployment Governance

## Status

Accepted

## Context

The AI Agent Deployment Platform supports multiple deployment
environments using a shared GitHub Actions reusable workflow.

The platform currently supports:

- DEV
- TEST

Future deployments may include:

- PROD

Each environment has its own:

- GitHub Environment
- Azure configuration
- Terraform state
- Azure resource group
- Power Platform environment
- Environment-specific deployment variables

The deployment platform must prevent environment-specific
configuration from becoming duplicated across separate workflows.

It must also provide a controlled promotion path between
environments.

## Decision

The platform will use GitHub Environments as deployment boundaries.

The reusable workflow:

    .github/workflows/deploy-agent-reusable.yml

will remain the common deployment engine for all environments.

Environment-specific caller workflows will provide the target
environment as an input.

Example:

    environment: dev

or:

    environment: test

Environment-specific configuration will be stored in the
corresponding GitHub Environment variables.

### Promotion Model

The intended promotion path is:

    DEV → TEST → PROD

DEV is intended for development and integration testing.

TEST is a controlled validation environment and requires an
authorized reviewer before deployment.

PROD will require an explicit approval gate before deployment.

### Terraform Governance

Terraform plan and Terraform apply are treated as separate
deployment actions.

Terraform plan is used to preview infrastructure changes.

Terraform apply is an explicit infrastructure modification
operation and should not be implicitly executed by every
deployment validation workflow.

### Power Platform Governance

The same logical Power Platform solution is promoted between
environments.

Environment-specific configuration is provided through
environment variables rather than creating separate versions of
the solution for each environment.

### Identity and Access

GitHub Actions authenticates to Azure using OpenID Connect (OIDC).

The deployment identity is scoped to the resources required by
the deployment environment.

Power Platform authentication uses an application identity.

The Power Platform application user currently has elevated
permissions while the deployment model is being validated.
Least-privilege permissions will be implemented before
production deployment.

## Consequences

### Positive

- One reusable deployment engine supports multiple environments.
- Environment configuration remains isolated.
- TEST deployments require explicit human approval.
- Azure authentication does not require long-lived GitHub
  credentials.
- Terraform state remains environment-specific.
- The same Power Platform solution can be promoted across
  environments.
- Additional environments can be added without duplicating the
  deployment implementation.

### Trade-offs

- Each environment requires its own configuration.
- Deployment approvals introduce a manual step.
- Production deployment requires additional governance.
- Least-privilege Power Platform permissions require additional
  validation.

## Result

The platform now has a controlled DEV → TEST promotion model
implemented through GitHub Environments and the reusable
deployment workflow.

The same architecture can be extended to PROD without creating
a separate deployment implementation.
