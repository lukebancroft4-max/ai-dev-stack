@echo off
setlocal EnableDelayedExpansion
echo === AI Dev Stack installer (Windows) ===

where git >nul 2>&1
if errorlevel 1 (
  echo Installing Git...
  winget install --id Git.Git -e --accept-source-agreements
)

where gh >nul 2>&1
if errorlevel 1 (
  echo Installing GitHub CLI...
  winget install --id GitHub.cli -e --accept-source-agreements
)

where node >nul 2>&1
if errorlevel 1 (
  echo Installing Node.js 22...
  winget install --id OpenJS.NodeJS.22 -e --accept-source-agreements
)

where python >nul 2>&1
if errorlevel 1 (
  echo Installing Python 3.12...
  winget install --id Python.Python.3.12 -e --accept-source-agreements
)

where docker >nul 2>&1
if errorlevel 1 (
  echo Installing Docker Desktop...
  winget install --id Docker.DockerDesktop -e --accept-source-agreements
)

echo Installing Ollama...
winget install --id Ollama.Ollama -e --accept-source-agreements

echo Installing VS Code...
winget install --id Microsoft.VisualStudioCode -e --accept-source-agreements

echo Installing Claude Code CLI...
npm install -g @anthropic-ai/claude-code

echo Installing Aider...
pip install aider-chat

echo Installing JupyterLab...
pip install jupyterlab

echo.
echo === Done! ===
echo Next steps:
echo   1. Copy .env.example to .env and add your API keys
echo   2. Run: ollama pull llama3.2
echo   3. Open VS Code and install extensions from stack/vscode-extensions.txt
pause
