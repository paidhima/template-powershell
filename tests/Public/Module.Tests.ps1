# Placeholder test file - add Pester tests here

BeforeAll {
    $ModulePath = Join-Path $PSScriptRoot "../../src/TemplateModule/TemplateModule.psm1" | Resolve-Path -ErrorAction SilentlyContinue
    if ($ModulePath) {
        Import-Module $ModulePath -Force
    }
}

Describe "TemplateModule" {
    It "Module imports successfully" {
        Get-Module TemplateModule | Should -Not -BeNullOrEmpty
    }
}
