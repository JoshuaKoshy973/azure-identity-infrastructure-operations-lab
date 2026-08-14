# Identity and Azure RBAC Runbook

## Purpose

Use this workflow when a user needs Azure management access or reports that an expected resource or action is unavailable.

## Access model

```text
Entra user or group
→ built-in role definition
→ subscription, resource-group, or resource scope
→ effective Azure management permissions
```

Azure RBAC controls Azure management-plane actions. It does not automatically grant Windows logon, RDP, SMB, NTFS, or application access inside a VM.

## Procedure

1. Validate the request, tenant, subscription, business need, and approver.
2. Identify the user or approved security group.
3. Select the least-privileged built-in role.
4. Select the narrowest correct scope.
5. Assign through a group when practical instead of assigning users individually.
6. Verify the assignment in Access control (IAM).
7. Verify the user’s Entra group membership.
8. Allow for membership and token propagation.
9. Test the requested action from the user’s effective perspective.
10. Confirm that unrelated privileges were not granted.
11. Record the role, principal, scope, approver, timestamp, and validation result.

## Diagnostic questions

- Is the user in the correct tenant and subscription?
- Is the group membership present?
- Is the expected role assigned to that group?
- Is the scope inherited, direct, or missing?
- Is a deny assignment or policy affecting access?
- Is the user attempting an Azure action or a guest-OS action?

## Evidence

- [Group-based scope assignments](../screenshots/08-azure-rbac-group-scope-assignments.png)
- [Jordan effective access](../screenshots/09-jordan-effective-rbac-access.png)
- [Taylor no-access validation](../screenshots/10-taylor-no-azure-access.png)

## PowerShell verification

```powershell
$resourceGroup = 'RG-SOC-LAB-AD-DETECTION'
$scope = (Get-AzResourceGroup -Name $resourceGroup).ResourceId

Get-AzRoleAssignment -Scope $scope |
    Select-Object DisplayName, SignInName, ObjectType, RoleDefinitionName, Scope |
    Sort-Object RoleDefinitionName, DisplayName |
    Format-Table -AutoSize
```

Do not assign Owner or Contributor merely to make an access problem disappear. Correct the principal, role, or scope that is actually wrong.
