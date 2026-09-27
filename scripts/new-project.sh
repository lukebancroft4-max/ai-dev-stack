#!/usr/bin/env bash
set -euo pipefail

if [[ -z "${1:-}" ]]; then
  echo "Usage: $0 <project-name>"
  exit 1
fi

NAME="$1"
mkdir -p "$NAME" && cd "$NAME"
git init

# Detect stack preference
read -rp "Web (node) or research (python)? [node]: " STACK
STACK=${STACK:-node}

if [[ "$STACK" == "python" || "$STACK" == "py" ]]; then
  python3 -m venv .venv
  echo ".venv/" >> .gitignore
  echo "__pycache__/" >> .gitignore
  echo "*.pyc" >> .gitignore
  cat > README.md <<EOF
# $NAME

Research/Python project.

## Setup

\
```bash
source .venv/bin/activate
pip install -r requirements.txt
\
```
EOF
  touch requirements.txt
else
  pnpm init
  cat > README.md <<EOF
# $NAME

Web project.

## Setup

\
```bash
pnpm install
pnpm dev
\
```
EOF
fi

echo "Project $NAME created."
