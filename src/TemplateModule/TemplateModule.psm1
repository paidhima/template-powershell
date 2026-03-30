<#
.SYNOPSIS
Import and export module functions.
#>

$ModuleRoot = Split-Path -Parent $MyInvocation.MyCommand.Path

# Discover and dot-source functions
$PublicFunctions = @(
    Get-ChildItem -Path "$ModuleRoot/Public/*.ps1" -ErrorAction SilentlyContinue
)
$PrivateFunctions = @(
    Get-ChildItem -Path "$ModuleRoot/Private/*.ps1" -ErrorAction SilentlyContinue
)

foreach ($Function in @($PublicFunctions + $PrivateFunctions)) {
    . $Function.FullName
}

# Export public functions
Export-ModuleMember -Function ($PublicFunctions.BaseName)
