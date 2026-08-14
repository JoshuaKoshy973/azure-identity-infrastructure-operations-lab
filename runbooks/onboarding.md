# Onboarding Runbook

## Purpose

Provide a repeatable starting point for adding a cloud user and granting only the access required for the user’s role.

## Procedure

1. Confirm the request, department, manager, required applications, and requested access.
2. Create the user in Microsoft Entra ID with the minimum required profile information.
3. Add the user to the appropriate cloud security group instead of assigning individual permissions.
4. Confirm the membership and review any group-based Azure RBAC inherited by the user.
5. Test the expected access with the user or an approved test account.
6. Record the request, groups, scope, validation result, and owner.

## Evidence

- [Entra cloud users](../screenshots/02-entra-cloud-users.png)
- [Entra security groups](../screenshots/03-entra-security-groups.png)
- [Role-change membership verification](../screenshots/04-entra-role-change-membership.png)

This lab demonstrates the identity and group-management portions of the workflow. Production onboarding would also include approval, licensing, MFA, and ticket references.
