# User Cannot Manage Resources Because of Missing RBAC Access

## Scenario

Jordan Reed needs read-only access to investigate an infrastructure alert, but cannot view the expected resources in `RG-SOC-LAB-AD-DETECTION`.

## Investigation

1. Confirm the user, tenant, subscription, and requested action.
2. Check Entra group membership.
3. Open the resource group’s Access control (IAM) page.
4. Review the group’s role assignments and scope.
5. Confirm that `Reader` is assigned to the approved group at the resource-group scope.
6. Allow for membership propagation and refresh the user session.
7. Verify that the user can view resources but cannot start, stop, modify, or delete them.

## Corrective principle

Assign `Reader` to the approved security group at the narrowest correct scope. Do not assign `Owner` or `Contributor` just to make the access problem disappear.

## PowerShell verification

```powershell
$resourceGroup = 'RG-SOC-LAB-AD-DETECTION'
$scope = (Get-AzResourceGroup -Name $resourceGroup).ResourceId

Get-AzRoleAssignment -Scope $scope |
    Select-Object DisplayName, RoleDefinitionName, Scope |
    Sort-Object RoleDefinitionName, DisplayName
```

## Lesson learned

Group membership and role assignment are separate objects. Correct role with incorrect scope still produces the wrong result, and Azure Reader access does not grant Windows RDP or SMB access.
