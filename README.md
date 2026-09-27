# AI Dev Stack

Personal toolkit for AI-assisted development, app building, and research.

## Windows — brand new PC (no Git yet)

You will see `git is not recognized`. That is normal. Do this in PowerShell:

```powershell
Set-ExecutionPolicy -Scope CurrentUser -ExecutionPolicy RemoteSigned
irm https://raw.githubusercontent.com/lukebancroft4-max/ai-dev-stack/main/setup/bootstrap.ps1 | iex
```

That one command installs Git and the rest of the stack, then clones this repo into `%USERPROFILE%\ai-dev-stack`.

If PowerShell blocks the download, install Git first, then clone:

```powershell
winget install --id Git.Git -e --accept-source-agreements --accept-package-agreements
```

Close PowerShell, open a **new** window, then:

```powershell
git clone https://github.com/lukebancroft4-max/ai-dev-stack.git
cd ai-dev-stack
.\setup\install.bat
```

## Linux / macOS

```bash
git clone https://github.com/lukebancroft4-max/ai-dev-stack.git
cd ai-dev-stack
chmod +x setup/install.sh
./setup/install.sh
```

## After install

1. Copy `.env.example` to `.env` and add API keys.
2. `ollama pull llama3.2`
3. Open VS Code and install extensions listed in `stack/vscode-extensions.txt`.

## What's inside

- `setup/` — installers and a Windows bootstrap that works before Git exists
- `stack/` — recommended tools and versions
- `prompts/` — reusable prompt templates
- `scripts/` — project scaffolding
