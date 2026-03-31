#!/usr/bin/env bash
set -euo pipefail

if [[ -z "${DISPLAY:-}" ]]; then
  cat <<'EOF'
DISPLAY is not set, so Isaac Sim cannot open a GUI window.

Use headless mode instead:
  ./scripts/launch_isaac_sim_headless.sh

Or export DISPLAY on the host before reopening the devcontainer.
EOF
  exit 1
fi

exec /isaac-sim/isaac-sim.sh "$@"
