# AI Dev Stack — Windows bootstrap
# Run this FIRST on a new PC that does not have Git.
# Open PowerShell as your normal user (Admin only if winget asks).

$ErrorActionPreference = "Stop"

Write-Host "=== AI Dev Stack Windows bootstrap ===" -ForegroundColor Cyan

# 1. Allow local scripts for this user only (fixes the profile.ps1 error)
try {
  Set-ExecutionPolicy -Scope CurrentUser -ExecutionPolicy RemoteSigned -Force
  Write-Host "Execution policy set to RemoteSigned for CurrentUser."
} catch {
  Write-Host "Could not change execution policy. You can still install tools with winget." -ForegroundColor Yellow
}

# 2. Need winget
if (-not (Get-Command winget -ErrorAction SilentlyContinue)) {
  Write-Host "winget is missing. Install App Installer from the Microsoft Store, then re-run this script." -ForegroundColor Red
  Write-Host "https://aka.ms/getwinget"
  exit 1
}

function Install-IfMissing {
  param(
    [string]$CommandName,
    [string]$WingetId,
    [string]$DisplayName
  )
  if (Get-Command $CommandName -ErrorAction SilentlyContinue) {
    Write-Host "$DisplayName already installed."
    return
  }
  Write-Host "Installing $DisplayName..."
  winget install --id $WingetId -e --accept-source-agreements --accept-package-agreements
}

Install-IfMissing -CommandName git -WingetId "Git.Git" -DisplayName "Git"
Install-IfMissing -CommandName gh -WingetId "GitHub.cli" -DisplayName "GitHub CLI"
Install-IfMissing -CommandName node -WingetId "OpenJS.NodeJS.LTS" -DisplayName "Node.js LTS"
Install-IfMissing -CommandName python -WingetId "Python.Python.3.12" -DisplayName "Python 3.12"
Install-IfMissing -CommandName docker -WingetId "Docker.DockerDesktop" -DisplayName "Docker Desktop"
Install-IfMissing -CommandName ollama -WingetId "Ollama.Ollama" -DisplayName "Ollama"
Install-IfMissing -CommandName code -WingetId "Microsoft.VisualStudioCode" -DisplayName "VS Code"

# Refresh PATH in this session so git works immediately
$env:Path = [System.Environment]::GetEnvironmentVariable("Path", "Machine") + ";" +
            [System.Environment]::GetEnvironmentVariable("Path", "User")

if (-not (Get-Command git -ErrorAction SilentlyContinue)) {
  Write-Host "Git was installed but is not on PATH yet. Close this window, open a NEW PowerShell, then run:" -ForegroundColor Yellow
  Write-Host "  git clone https://github.com/lukebancroft4-max/ai-dev-stack.git"
  Write-Host "  cd ai-dev-stack"
  Write-Host "  .\setup\install.bat"
  exit 0
}

# 3. Clone repo if missing
$repoDir = Join-Path $HOME "ai-dev-stack"
if (-not (Test-Path $repoDir)) {
  Write-Host "Cloning ai-dev-stack..."
  git clone https://github.com/lukebancroft4-max/ai-dev-stack.git $repoDir
} else {
  Write-Host "Repo already exists at $repoDir"
}

Set-Location $repoDir

# 4. npm / pip tools (need PATH refresh first)
if (Get-Command npm -ErrorAction SilentlyContinue) {
  if (-not (Get-Command claude -ErrorAction SilentlyContinue)) {
    Write-Host "Installing Claude Code CLI..."
    npm install -g @anthropic-ai/claude-code
  }
} else {
  Write-Host "npm not on PATH yet. Open a new PowerShell later and run: npm install -g @anthropic-ai/claude-code" -ForegroundColor Yellow
}

if (Get-Command pip -ErrorAction SilentlyContinue) {
  pip install --upgrade pip
  pip install aider-chat jupyterlab
} elseif (Get-Command pip3 -ErrorAction SilentlyContinue) {
  pip3 install --upgrade pip
  pip3 install aider-chat jupyterlab
} else {
  Write-Host "pip not on PATH yet. Open a new PowerShell later and run: pip install aider-chat jupyterlab" -ForegroundColor Yellow
}

Write-Host ""
Write-Host "=== Bootstrap done ===" -ForegroundColor Green
Write-Host "Next:"
Write-Host "  1. Close PowerShell and open a NEW window (so PATH updates stick)"
Write-Host "  2. cd $repoDir"
Write-Host "  3. copy .env.example .env   then add API keys"
Write-Host "  4. ollama pull llama3.2"
