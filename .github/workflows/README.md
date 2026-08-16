# GitHub Workflows

This directory contains the GitHub Actions workflows for the platform. The Terraform workflows target the DEV environment and share the `terraform-dev` concurrency group so that plan and apply runs do not overlap.

## Terraform workflows

- `terraform-plan.yml`: runs a Terraform plan for DEV.
- `terraform-apply.yml`: creates a plan and applies it for DEV.

Both workflows use Azure OIDC authentication and the `dev` GitHub environment. The environment must provide these repository or environment variables:

- `AZURE_CLIENT_ID`
- `AZURE_TENANT_ID`
- `AZURE_SUBSCRIPTION_ID`

## Running Terraform locally

The DEV provider requires `azure_subscription_id`; it has no default value. The GitHub workflows provide it through `TF_VAR_azure_subscription_id`, but a local `terraform plan` will prompt for it unless you provide the variable yourself.

After authenticating with Azure and selecting the intended subscription, run from the DEV Terraform directory:

```bash
cd /c/WORKSPACE/ai-agent-deployment-platform/infrastructure/terraform/environments/dev
az account set --subscription "<AZURE_SUBSCRIPTION_ID>"

export TF_VAR_azure_subscription_id="<AZURE_SUBSCRIPTION_ID>"
terraform plan -input=false -lock-timeout=60s -no-color
```

In Git Bash, `export` applies to the current terminal session. Alternatively, create an ignored `terraform.tfvars` file in this directory:

```hcl
azure_subscription_id = "<AZURE_SUBSCRIPTION_ID>"
```

Replace the placeholder with the actual subscription ID. Do not enter a menu choice such as `2`; Terraform passes the entered value to Azure as the subscription ID, and Azure will reject it if it is not a real subscription GUID.

## Recovering a stale Terraform lock

Use this procedure only when a Terraform run has stopped or failed and no other plan or apply is currently running against the DEV state. Do not use `-lock=false` to bypass the lock.

1. Check the GitHub Actions page for active or queued `Terraform Plan - DEV` and `Terraform Apply - DEV` runs. Cancel or wait for any run that is still active.
2. Open Git Bash or a terminal at the repository root. The Terraform working directory is not `.github/workflows`:

   ```bash
   cd /c/WORKSPACE/ai-agent-deployment-platform/infrastructure/terraform/environments/dev
   ```

3. Authenticate to the Azure tenant that owns the subscription. Use the tenant ID configured as `AZURE_TENANT_ID` in GitHub:

   ```bash
   az logout
   az account clear
   az login --tenant "<AZURE_TENANT_ID>" --use-device-code
   az account set --subscription "<AZURE_SUBSCRIPTION_ID>"
   az account show -o table
   ```

   Confirm that the selected subscription is the intended DEV subscription before continuing. If Azure reports `No subscriptions found`, the signed-in account does not have access to that subscription or the wrong tenant was selected.

4. Initialize Terraform using the remote backend:

   ```bash
   terraform init -input=false -lock-timeout=60s
   ```

5. Unlock the exact lock ID reported by Terraform. Replace the example ID with the current lock ID from the failed workflow log:

   ```bash
   terraform force-unlock -force e3270dc2-e3c8-901c-ac34-d6d394d2913c
   ```

6. Rerun the appropriate GitHub Actions workflow and monitor the plan or apply run.

### Backend details

The DEV state is stored in Azure Blob Storage with this backend configuration:

```text
Resource group:  rg-aiagent-tfstate-eastus
Storage account: staaiagenttfeus001
Container:       tfstate
State key:       ai-agent-platform/dev/terraform.tfstate
```

A stale lock is an Azure backend lock, not a local Terraform lock. Running `terraform force-unlock` from another directory can produce `LocalState not locked` and does not clear the remote lock. Always initialize and unlock from `infrastructure/terraform/environments/dev`.

## Common errors

### `cd: infrastructure/terraform/environments/dev: No such file or directory`

The command was run from `.github/workflows` or another non-root directory. Use the absolute path shown above, or return to the repository root first:

```bash
cd /c/WORKSPACE/ai-agent-deployment-platform
cd infrastructure/terraform/environments/dev
```

### `Failed to unlock state: LocalState not locked`

Terraform was not initialized against the remote backend in the correct directory. Confirm the working directory, run `terraform init`, and retry with the lock ID from the workflow log.

### Azure login returns `No subscriptions found`

The authenticated account may not have access to the subscription, or the login used the wrong tenant. Sign in with the tenant configured for the GitHub environment and verify access with `az account list --refresh -o table`.
