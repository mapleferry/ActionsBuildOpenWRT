#!/bin/bash
set -euo pipefail

echo "🔧 Customizing x86_64 defaults..."

DEFAULT_IP="192.168.18.1"
CONFIG_GEN="package/base-files/files/bin/config_generate"

# Validate file exists
if [[ ! -f "$CONFIG_GEN" ]]; then
  echo "❌ Error: $CONFIG_GEN not found!" >&2
  exit 1
fi

# Replace default IP
sed -i "s/192.168.1.1/$DEFAULT_IP/g" "$CONFIG_GEN"

# Verify change
if ! grep -q "$DEFAULT_IP" "$CONFIG_GEN"; then
  echo "❌ Failed to set default IP!" >&2
  exit 1
fi

echo "✅ Default IP set to $DEFAULT_IP"