#!/usr/bin/env python3

import sys
from pathlib import Path

import yaml


REQUIRED_FIELDS = [
    ("agent", "name"),
    ("agent", "display_name"),
    ("agent", "environment"),
    ("azure", "resource_group"),
    ("powerplatform", "solution"),
    ("deployment", "enabled"),
]


def main():
    if len(sys.argv) != 2:
        print("Usage: validate-agent-config.py <agent.yaml>")
        sys.exit(1)

    config_path = Path(sys.argv[1])

    if not config_path.is_file():
        print(f"ERROR: Configuration file not found: {config_path}")
        sys.exit(1)

    try:
        with config_path.open("r", encoding="utf-8") as file:
            config = yaml.safe_load(file)
    except yaml.YAMLError as exc:
        print(f"ERROR: Invalid YAML: {exc}")
        sys.exit(1)

    if not isinstance(config, dict):
        print("ERROR: Configuration must contain a YAML object.")
        sys.exit(1)

    errors = []

    for section, field in REQUIRED_FIELDS:
        section_data = config.get(section)

        if not isinstance(section_data, dict):
            errors.append(f"Missing section: {section}")
            continue

        value = section_data.get(field)

        if value is None or value == "":
            errors.append(f"Missing required field: {section}.{field}")

    if errors:
        print("Agent configuration validation FAILED:")
        for error in errors:
            print(f"  - {error}")

        sys.exit(1)

    print("Agent configuration validation PASSED.")
    print(f"Agent:        {config['agent']['name']}")
    print(f"Display Name: {config['agent']['display_name']}")
    print(f"Environment:  {config['agent']['environment']}")
    print(f"Resource Group: {config['azure']['resource_group']}")
    print(f"Solution:     {config['powerplatform']['solution']}")
    print(f"Deployment Enabled: {config['deployment']['enabled']}")


if __name__ == "__main__":
    main()
