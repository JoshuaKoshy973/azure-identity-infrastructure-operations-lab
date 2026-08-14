# Offboarding Access Verification

## Scenario

The offboarding validation checked whether disabling the account and removing group memberships produced the expected access outcome.

## Observed result

Ryan Brooks was disabled, was not a member of any groups, and produced a failed sign-in with the reason that the user account was disabled.

## Evidence

- [Account disabled](../screenshots/05-entra-offboarded-account-disabled.png)
- [Group membership removed](../screenshots/06-entra-offboarding-membership-removed.png)
- [Sign-in blocked](../screenshots/07-entra-offboarding-signin-blocked.png)

## Lesson

Offboarding should be validated at multiple layers: account status, group membership, active sessions, and an attempted sign-in. A single disabled-account screenshot would not prove that group-based access was also removed.
