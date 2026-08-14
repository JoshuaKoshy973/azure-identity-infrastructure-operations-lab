[CmdletBinding()]
param(
    [string]$ResourceGroupName = 'RG-SOC-LAB-AD-DETECTION'
)

$ErrorActionPreference = 'Stop'
$scope = (Get-AzResourceGroup -Name $ResourceGroupName).ResourceId

Get-AzRoleAssignment -Scope $scope |
    Select-Object DisplayName, SignInName, ObjectType, RoleDefinitionName, Scope |
    Sort-Object RoleDefinitionName, DisplayName |
    Format-Table -AutoSize
