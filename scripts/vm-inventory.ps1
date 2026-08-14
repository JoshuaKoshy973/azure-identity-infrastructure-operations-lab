[CmdletBinding()]
param(
    [string]$ResourceGroupName = 'RG-SOC-LAB-AD-DETECTION'
)

$ErrorActionPreference = 'Stop'

$vms = Get-AzVM -ResourceGroupName $ResourceGroupName -Status | Sort-Object Name

$report = foreach ($vm in $vms) {
    $powerState = $vm.Statuses |
        Where-Object { $_.Code -like 'PowerState/*' } |
        Select-Object -First 1 -ExpandProperty DisplayStatus

    [PSCustomObject]@{
        ResourceGroup = $vm.ResourceGroupName
        Name          = $vm.Name
        Location      = $vm.Location
        PowerState    = $powerState
    }
}

$report | Format-Table -AutoSize
