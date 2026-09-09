# Terraform Environments

## Troubleshooting: Azure CLI login errors

If `terraform init`/`plan` fails with errors like:

```
Error: authorizing request: running Azure CLI: exit status 1: ERROR: Account has previously been signed out of this application.. Status: Response_Status.Status_AccountUnusable
Please explicitly log in with:
az login --scope https://storage.azure.com/.default
```

this indicates a corrupted Windows broker (WAM) session for your account, not a
missing scope. Re-running `az login` (with or without `--scope`) will keep
hitting the same error because it reuses the broken broker session. Resolve it
with:

1. Clear the CLI's cached accounts/tokens:
   ```
   az account clear
   ```
2. Log in using the device code flow to bypass the broker:
   ```
   az login --use-device-code --tenant <tenant-id>
   ```
3. Open the printed URL, enter the device code, and select the correct
   subscription when prompted.
4. Re-run the Terraform command.
