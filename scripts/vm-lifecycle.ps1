[CmdletBinding(SupportsShouldProcess)]
param(
    [Parameter(Mandatory)]
    [ValidateSet('Start','Restart','Stop','Deallocate')]
    [string]$Action,

    [string]$ResourceGroupName = 'RG-SOC-LAB-AD-DETECTION',

    [Parameter(Mandatory)]
    [string]$VmName
)

$ErrorActionPreference = 'Stop'

if ($PSCmdlet.ShouldProcess($VmName, $Action)) {
    switch ($Action) {
        'Start'      { Start-AzVM -ResourceGroupName $ResourceGroupName -Name $VmName }
        'Restart'    { Restart-AzVM -ResourceGroupName $ResourceGroupName -Name $VmName }
        'Stop'       { Stop-AzVM -ResourceGroupName $ResourceGroupName -Name $VmName }
        'Deallocate' { Stop-AzVM -ResourceGroupName $ResourceGroupName -Name $VmName -Force }
    }
}

Get-AzVM -ResourceGroupName $ResourceGroupName -Name $VmName -Status |
    Select-Object Name, ResourceGroupName, Location, ProvisioningState, PowerState |
    Format-List
