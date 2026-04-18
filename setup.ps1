#!/usr/bin/env pwsh

<#
.SYNOPSIS
Post-clone setup script for PowerShell and Python projects.

.DESCRIPTION
Initializes project structure, installs dependencies, and configures dev environment.

.PARAMETER Type
Project type: 'python', 'powershell', or 'both'. Defaults to 'both'.

.EXAMPLE
./setup.ps1 -Type python
#>

param(
    [ValidateSet('python', 'powershell', 'both')]
    [string]$Type = 'both'
)

$ErrorActionPreference = 'Stop'
$ProjectName = Split-Path -Leaf (Get-Location)

Write-Host "🚀 Setting up $ProjectName ($Type)" -ForegroundColor Cyan

# Ensure .copilot-instructions.md exists
if (-not (Test-Path '.copilot-instructions.md')) {
    Write-Host "⚠️  .copilot-instructions.md not found. Creating default..." -ForegroundColor Yellow
    if ($Type -in 'python', 'both') {
        $defaultInstructions = @'
# Project Context
This is a Python project using pytest, mypy (strict), black, and ruff.
See copilot-config/standards/conventions.md for full standards.

## Development Workflow
- Run tests: `pytest tests/ -xvs`
- Type check: `mypy src/ --strict`
- Format: `black src/ tests/`
- Lint: `ruff check src/ tests/`

## Completion Criteria
- [ ] All mypy --strict checks pass
- [ ] All tests pass
- [ ] Code formatted with black
- [ ] No ruff violations
- [ ] Docstrings in Google style
'@
        $defaultInstructions | Out-File '.copilot-instructions.md' -Encoding UTF8
    }
}

# Create base directories if missing
Write-Host "📁 Creating directory structure..." -ForegroundColor Cyan
if ($Type -in 'python', 'both') {
    New-Item -ItemType Directory -Path "src\$ProjectName", 'tests' -Force | Out-Null
    New-Item -ItemType File -Path "src\$ProjectName\__init__.py", 'tests\conftest.py' -Force | Out-Null
}

if ($Type -in 'powershell', 'both') {
    New-Item -ItemType Directory -Path "src\$ProjectName\Public", "src\$ProjectName\Private", 'tests\Public' -Force | Out-Null
}

# Create/update .gitignore
Write-Host "🔧 Updating .gitignore..." -ForegroundColor Cyan
if (-not (Test-Path '.gitignore')) {
    $gitignore = @'
# Python
__pycache__/
*.py[cod]
*.egg-info/
.venv/
venv/
.pytest_cache/
.coverage
htmlcov/

# PowerShell
*.psd1.bak
*.psm1.zip

# IDE
.vscode/
.idea/
*.swp

# OS
.DS_Store
Thumbs.db
'@
    $gitignore | Out-File '.gitignore' -Encoding UTF8
}

# Python setup
if ($Type -in 'python', 'both') {
    Write-Host "🐍 Python environment setup..." -ForegroundColor Cyan
    if (-not (Test-Path '.venv')) {
        python -m venv .venv
        Write-Host "✅ Created .venv (activate with: .venv\Scripts\Activate.ps1)" -ForegroundColor Green
    }
    
    Write-Host ""
    Write-Host "📌 Next: Install dev dependencies" -ForegroundColor Yellow
    Write-Host ".venv\Scripts\Activate.ps1" -ForegroundColor Gray
    Write-Host "pip install -e '.[dev]' 2>nul || pip install pytest mypy black ruff" -ForegroundColor Gray
    Write-Host ""
}

# PowerShell setup
if ($Type -in 'powershell', 'both') {
    Write-Host "🔷 PowerShell environment setup..." -ForegroundColor Cyan
    Write-Host ""
    Write-Host "📌 Install tools:" -ForegroundColor Yellow
    Write-Host "Install-Module -Name PSScriptAnalyzer -Force" -ForegroundColor Gray
    Write-Host "Install-Module -Name Pester -MinimumVersion 5.0 -Force" -ForegroundColor Gray
    Write-Host ""
}

# Create GitHub Actions workflows
if (-not (Test-Path '.github\workflows')) {
    Write-Host "🔄 Setting up GitHub Actions..." -ForegroundColor Cyan
    New-Item -ItemType Directory -Path '.github\workflows' -Force | Out-Null
    $workflow = @'
name: Validate Project (On-Demand)
on:
  workflow_dispatch:
jobs:
  validate:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v6
      - name: Check project setup
        run: echo "✅ Project initialized. See copilot-config for full validation."
'@
    $workflow | Out-File '.github\workflows\validate-on-demand.yml' -Encoding UTF8
}

Write-Host ""
Write-Host "✅ Setup complete for $ProjectName!" -ForegroundColor Green
Write-Host ""
Write-Host "📖 Next steps:" -ForegroundColor Yellow
Write-Host "1. Read copilot-config/standards/conventions.md"
Write-Host "2. Update pyproject.toml or .psd1 with project details"
Write-Host "3. Create README.md"
Write-Host "4. git push origin main"
