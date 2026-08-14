[CmdletBinding()]
param(
    [Parameter(Mandatory)]
    [pscustomobject]$UserRequest
)

$ErrorActionPreference = 'Stop'
$required = 'DisplayName','UserPrincipalName','Department'

foreach ($field in $required) {
    if ([string]::IsNullOrWhiteSpace([string]$UserRequest.$field)) {
        throw "Missing required field: $field"
    }
}

[PSCustomObject]@{
    DisplayName       = $UserRequest.DisplayName
    UserPrincipalName = $UserRequest.UserPrincipalName
    Department        = $UserRequest.Department
    RequiredFields    = 'Validated'
    NextStep          = 'Apply approved groups through the auditable identity workflow'
}
