# AI Dev Stack

Personal toolkit for AI-assisted development, app building, and research.

## What's inside

- `setup/` — one-command install scripts for a new PC (Windows, macOS, Linux)
- `stack/` — recommended tools and versions for AI dev, web dev, and research
- `prompts/` — reusable prompt templates for coding, research, and debugging
- `scripts/` — helper scripts (git config, env setup, project scaffolding)

## Quick start (new PC)

```bash
git clone https://github.com/lukebancroft4-max/ai-dev-stack.git
cd ai-dev-stack
./setup/install.sh        # Linux/macOS
# or
setup\install.bat        # Windows
```

## Stack overview

| Layer | Tools |
|---|---|
| AI coding | Claude Code, Cursor, GitHub Copilot, Aider |
| Local models | Ollama, LM Studio |
| Web dev | Node.js 22, Python 3.12, pnpm, Docker |
| Research | JupyterLab, VS Code + Python/Jupyter extensions |
| Version control | Git, GitHub CLI |

## Notes

- Edit `stack/versions.md` to pin your preferred versions.
- Add your API keys to `.env.example` (never commit real keys).
