# Incomplete Offboarding

## Ticket summary

**Ticket:** `INC-2126`
**Priority:** High
**Affected identity:** Ryan Brooks
**Title:** Offboarded user still appears to retain access

## Reported symptom

An offboarding request was processed, but the administrator could not confirm that every access path had been removed. The account was disabled, while group memberships, role assignments, active sessions, and service dependencies still required review.

## Why the symptom matters

Disabling an account blocks normal sign-in, but it is not the same as completing the access-removal workflow. Group membership can remain as an audit or reactivation risk, direct Azure RBAC assignments can remain outside the group model, and existing sessions may continue until revoked or expired.

## Investigation

1. Confirmed the approved offboarding request and effective time.
2. Confirmed Ryan Brooks showed `Account enabled: No` in Microsoft Entra ID.
3. Reviewed the Groups page and confirmed the user was not a member of any groups.
4. Reviewed direct Azure role assignments and privileged access paths.
5. Considered active sessions, registered devices, application assignments, licenses, shared credentials, and service-account dependencies.
6. Attempted a sign-in to validate the user-facing result.
7. Recorded the evidence and completed the ticket only after the access checks were reconciled.

## Root-cause reasoning

The risk in incomplete offboarding is a mismatch between account status and effective access. A disabled account with retained group membership is different from a disabled account with no group membership, and both differ from an account with an active session or a direct resource assignment.

## Resolution standard

Disable the account, revoke active sessions where appropriate, remove group memberships, review direct RBAC and application assignments, transfer ownership of business data, and document exceptions. The exact order should follow the organization’s approved offboarding policy and effective time.

## Verification

Ryan Brooks was shown with the account disabled, no group memberships, and a failed sign-in whose reason was that the user account was disabled.

- [Account disabled](../screenshots/05-entra-offboarded-account-disabled.png)
- [Membership removed](../screenshots/06-entra-offboarding-membership-removed.png)
- [Sign-in blocked](../screenshots/07-entra-offboarding-signin-blocked.png)

## Lesson learned

Offboarding is a lifecycle process, not a single toggle. Strong verification checks account status, group membership, direct assignments, active sessions, and the actual sign-in result.
