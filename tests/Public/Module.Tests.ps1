# Placeholder test file - add Pester tests here

BeforeAll {
    $ModulePath = Join-Path (Split-Path -Parent $PSScriptRoot) "../../src/TemplateModule/TemplateModule.psm1"
    if (Test-Path $ModulePath) {
        Import-Module $ModulePath -Force
    }
}

Describe "TemplateModule" {
    It "Module imports successfully" {
        Get-Module TemplateModule | Should -Not -BeNullOrEmpty
    }
}
