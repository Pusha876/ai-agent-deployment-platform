#!/usr/bin/env bash

set -euo pipefail

repository_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
solution_path="${POWER_PLATFORM_SOLUTION_PATH:-$repository_root/powerplatform/solutions/aiagentplatform_core/AIAgentPlatformCore/bin/Debug/AIAgentPlatformCore.zip}"
environment_url="${POWER_PLATFORM_ENVIRONMENT_URL:-https://aiagenttest.crm.dynamics.com/}"

: "${POWER_PLATFORM_CLIENT_ID:?Set POWER_PLATFORM_CLIENT_ID to the Entra app registration client ID}"
: "${POWER_PLATFORM_TENANT_ID:?Set POWER_PLATFORM_TENANT_ID to the Entra tenant ID}"
: "${POWER_PLATFORM_CLIENT_SECRET:?Set POWER_PLATFORM_CLIENT_SECRET to the client secret value}"

if [[ ! -f "$solution_path" ]]; then
  printf 'Solution package not found: %s\n' "$solution_path" >&2
  printf 'Build the solution first or set POWER_PLATFORM_SOLUTION_PATH.\n' >&2
  exit 1
fi

if ! command -v pac >/dev/null 2>&1; then
  printf 'Power Platform CLI (pac) is required but was not found in PATH.\n' >&2
  exit 1
fi

pac auth create \
  --environment "$environment_url" \
  --applicationId "$POWER_PLATFORM_CLIENT_ID" \
  --clientSecret "$POWER_PLATFORM_CLIENT_SECRET" \
  --tenant "$POWER_PLATFORM_TENANT_ID"

pac solution import \
  --environment "$environment_url" \
  --path "$solution_path" \
  --publish-changes
