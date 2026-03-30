# PowerShell Module Template

Created from [copilot-config](https://github.com/paidhima/copilot-config).

This is a minimal PowerShell module scaffold with all standards pre-configured.

## Quick Start

### Option 1: From This Template (Recommended)
```powershell
gh repo create my-module --template paidhima/template-powershell --clone --private
cd my-module
.\setup.ps1 -Type powershell
```

### Option 2: Manual Setup
```powershell
Import-Module .\src\TemplateModule\TemplateModule.psd1 -Force
```

## Module Structure

```
my-module/
├── src/
│   └── MyModule/
│       ├── MyModule.psd1          # Module manifest
│       ├── MyModule.psm1          # Module loader
│       ├── Public/                # Exported functions
│       │   └── Get-Data.ps1
│       └── Private/               # Internal helpers
│           └── _Initialize.ps1
├── tests/
│   └── Public/
│       └── Get-Data.Tests.ps1
├── setup.ps1                      # Setup script
├── .copilot-instructions.md       # Copilot standards
├── README.md
└── .gitignore
```

## Development Workflow

```powershell
# Linting
Invoke-ScriptAnalyzer -Path src/ -Recurse

# Testing
Invoke-Pester -Path tests/ -Verbose

# View help
Get-Help Get-Data -Detailed
```

## Standards

See [Development Standards](https://github.com/paidhima/copilot-config/blob/main/standards/conventions.md) for:
- Naming conventions (Verb-Noun, PascalCase)
- Comment-based help (required for all public functions)
- Testing (Pester v5)
- Linting (PSScriptAnalyzer)
- Module structure (Public/Private organization)

## Copilot Integration

The `.copilot-instructions.md` file tells GitHub Copilot about your PowerShell standards.

**Features**:
- Copilot generates functions with proper comment-based help
- Copilot suggests PSScriptAnalyzer fixes
- Copilot understands module structure and naming conventions

## Next Steps

1. Update `src/TemplateModule/TemplateModule.psd1` with your module name and details
2. Create public functions in `src/TemplateModule/Public/`
3. Add private helpers in `src/TemplateModule/Private/` as needed
4. Create Pester tests in `tests/Public/`
5. Follow [Copilot Config Bootstrap Checklist](https://github.com/paidhima/copilot-config/blob/main/checklists/new-project-bootstrap.md)

## Function Template

```powershell
<#
.SYNOPSIS
Short description of what the function does.

.DESCRIPTION
Longer description explaining behavior and usage.

.PARAMETER Name
Parameter description.

.EXAMPLE
Get-Data -Name "Example"

Description of what this example does.

.OUTPUTS
[System.Collections.Hashtable]

Description of output structure.
#>
function Get-Data {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)]
        [string]$Name
    )
    
    # Implementation here
}
```

## Support

Questions? See:
- [Copilot Config Repository](https://github.com/paidhima/copilot-config)
- [Quick Reference](https://github.com/paidhima/copilot-config/blob/main/docs/QUICK-REFERENCE.md)
- [Development Standards](https://github.com/paidhima/copilot-config/blob/main/standards/conventions.md)
