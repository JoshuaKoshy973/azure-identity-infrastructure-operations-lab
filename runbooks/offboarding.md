# Offboarding Runbook

## Purpose

Remove a user’s ability to sign in and access cloud resources while preserving an auditable record of the change.

## Procedure

1. Confirm the approved offboarding request and effective time.
2. Disable the Entra user account.
3. Remove the user from cloud security groups and review direct role assignments.
4. Revoke active sessions when appropriate.
5. Attempt a sign-in with the affected account to verify the disabled-account result.
6. Review group membership and record the completed actions.

## Validation performed

Ryan Brooks was shown with `Account enabled: No`, no group memberships, and a failed sign-in whose reason was that the user account was disabled.

- [Disabled account](../screenshots/05-entra-offboarded-account-disabled.png)
- [Membership removed](../screenshots/06-entra-offboarding-membership-removed.png)
- [Sign-in blocked](../screenshots/07-entra-offboarding-signin-blocked.png)

The sign-in test validates the user-facing result. A production workflow would also address ownership transfer, licenses, devices, mailbox/data retention, and ticket closure.
