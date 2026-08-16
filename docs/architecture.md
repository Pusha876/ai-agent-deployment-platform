# AI Agent Deployment Platform

## Overview

Reusable Azure infrastructure and GitHub Actions
deployment framework for AI agent workloads.

## Authentication

GitHub Actions authenticates to Azure using
Microsoft Entra Workload Identity Federation (OIDC).

No long-lived Azure credentials are stored in GitHub.

## Terraform State

Terraform state is stored remotely in Azure Blob Storage.

Resource Group:
rg-aiagent-tfstate-eastus

Storage Account:
staaiagenttfeus001

Container:
tfstate

DEV State:
ai-agent-platform/dev/terraform.tfstate

## Azure Deployment Boundary

DEV infrastructure is deployed into:

rg-aiagent-dev-eastus

## CI/CD

Terraform Plan:
terraform-plan.yml

Terraform Apply:
terraform-apply.yml

## Current Infrastructure

- Log Analytics Workspace


```
### Architecture Notes

This document is the working place for the platform's system boundaries and deployment model.

#### Initial Boundaries

- **Agent definition:** prompts, tools, model settings, and versioned configuration.
- **Deployment:** packaging, environment configuration, rollout, and rollback.
- **Runtime:** request handling, tool execution, state, and error behavior.
- **Operations:** evaluation, tracing, metrics, health checks, and incident response.

These boundaries are provisional. Update this document when implementation establishes a more precise contract.
```
