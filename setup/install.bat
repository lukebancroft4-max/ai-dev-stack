@echo off
setlocal EnableDelayedExpansion
echo === AI Dev Stack installer (Windows) ===
echo.
echo If git is missing, do NOT use this file first.
echo Open PowerShell and run:
echo   irm https://raw.githubusercontent.com/lukebancroft4-max/ai-dev-stack/main/setup/bootstrap.ps1 ^| iex
echo.

where winget >nul 2>&1
if errorlevel 1 (
  echo winget not found. Install App Installer from the Microsoft Store:
  echo https://aka.ms/getwinget
  pause
  exit /b 1
)

where git >nul 2>&1
if errorlevel 1 (
  echo Installing Git...
  winget install --id Git.Git -e --accept-source-agreements --accept-package-agreements
)

where gh >nul 2>&1
if errorlevel 1 (
  echo Installing GitHub CLI...
  winget install --id GitHub.cli -e --accept-source-agreements --accept-package-agreements
)

where node >nul 2>&1
if errorlevel 1 (
  echo Installing Node.js LTS...
  winget install --id OpenJS.NodeJS.LTS -e --accept-source-agreements --accept-package-agreements
)

where python >nul 2>&1
if errorlevel 1 (
  echo Installing Python 3.12...
  winget install --id Python.Python.3.12 -e --accept-source-agreements --accept-package-agreements
)

where docker >nul 2>&1
if errorlevel 1 (
  echo Installing Docker Desktop...
  winget install --id Docker.DockerDesktop -e --accept-source-agreements --accept-package-agreements
)

where ollama >nul 2>&1
if errorlevel 1 (
  echo Installing Ollama...
  winget install --id Ollama.Ollama -e --accept-source-agreements --accept-package-agreements
)

where code >nul 2>&1
if errorlevel 1 (
  echo Installing VS Code...
  winget install --id Microsoft.VisualStudioCode -e --accept-source-agreements --accept-package-agreements
)

echo.
echo If npm / pip commands fail below, close this window, open a NEW PowerShell, and re-run this file.
echo.

where npm >nul 2>&1
if not errorlevel 1 (
  echo Installing Claude Code CLI...
  npm install -g @anthropic-ai/claude-code
)

where pip >nul 2>&1
if not errorlevel 1 (
  echo Installing Aider and JupyterLab...
  pip install aider-chat jupyterlab
)

echo.
echo === Done ===
echo Next steps:
echo   1. Open a NEW PowerShell window
echo   2. copy .env.example .env
echo   3. ollama pull llama3.2
pause
