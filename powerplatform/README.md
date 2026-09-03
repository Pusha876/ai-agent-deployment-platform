## Importing the Core Solution

The import script uses a service principal and reads its client secret from an
environment variable. Run it from Git Bash at the repository root or from any
working directory:

```bash
export POWER_PLATFORM_CLIENT_ID="<app-registration-client-id>"
export POWER_PLATFORM_TENANT_ID="<tenant-id>"
export POWER_PLATFORM_CLIENT_SECRET="<client-secret-value>"
export POWER_PLATFORM_ENVIRONMENT_URL="https://aiagentdev.crm.dynamics.com/"

./scripts/import-powerplatform-solution.sh
```

The script imports the default Debug package. To use another package, set
`POWER_PLATFORM_SOLUTION_PATH` to its absolute or repository-relative path.

`POWER_PLATFORM_TENANT_ID` must be the Microsoft Entra tenant where the app
registration has a service principal. It must also be the tenant that owns the
target Power Platform environment. If PAC reports `AADSTS7000229`, the app is
missing from the tenant named in that error. An administrator in that tenant
must grant consent or create the enterprise application before retrying. For
example, an administrator can create the service principal with:

```bash
az ad sp create --id "$POWER_PLATFORM_CLIENT_ID"
```

Verify the target environment and tenant explicitly before running the script:

```bash
export POWER_PLATFORM_ENVIRONMENT_URL="https://aiagentdev.crm.dynamics.com/"
export POWER_PLATFORM_TENANT_ID="<tenant-that-owns-aiagentdev>"
./scripts/import-powerplatform-solution.sh
```

In GitHub Actions, map the environment secret to
`POWER_PLATFORM_CLIENT_SECRET` and provide the other values as environment
variables or repository/environment variables. The service principal must be
registered as an application user in the target Dataverse environment with a
security role that permits solution import.
