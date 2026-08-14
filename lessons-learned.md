# Lessons Learned

- Microsoft Entra ID and AD DS are separate identity systems unless synchronization is intentionally configured.
- Groups are a maintainable boundary for Azure RBAC; effective access must be tested from the user’s perspective.
- RBAC scope matters: a Reader assignment inherited from a resource group is different from a VM-scoped Virtual Machine Contributor assignment.
- A user with no effective role may see the Azure welcome experience even when the tenant itself is reachable.
- Offboarding is stronger when account status, group membership, and sign-in behavior are all verified.
- Domain troubleshooting should validate DNS and the computer secure channel, not just whether a VM is powered on.
- A CPU metric spike becomes operationally useful when it is connected to an alert rule, affected resource, severity, and fired state.
- A completed backup job is not the same as a proven restore. File existence, content, and hashes provided the recovery validation here.
- Azure control-plane state, network data-plane behavior, and guest-OS health must be checked separately.
- NSG priority and configured fields determine behavior; a rule name does not narrow a rule’s actual scope.
- PowerShell pipelines preserve objects through `Get-AzVM`, `Sort-Object`, and `Select-Object`; formatting belongs at the end of a reporting pipeline.
- Screenshots are most useful when each one proves a specific state or transition rather than merely showing a settings page.
- Strong operational documentation connects each configuration change to a validation result and a user or service outcome.
