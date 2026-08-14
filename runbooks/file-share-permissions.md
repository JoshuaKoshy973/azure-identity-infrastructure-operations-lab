# File Share Permissions Runbook

## Purpose

Use this workflow when a user can reach a Windows file server but cannot browse, read, create, modify, or delete content.

## Permission model

SMB share permissions and NTFS permissions are separate layers. For network access, Windows evaluates both and the more restrictive effective result applies.

```text
User token
→ Active Directory group membership
→ SMB share permissions
→ NTFS permissions and inheritance
→ effective file action
```

## Procedure

1. Confirm the user, device, UNC path, exact error, and business impact.
2. Determine whether the user can browse, read, create, modify, rename, and delete.
3. Confirm the server and share are reachable.
4. Verify group membership and refresh the user’s logon token when needed.
5. Check share permissions.
6. Check NTFS permissions, inheritance, and explicit entries.
7. Compare the requested action with the effective permission.
8. Correct only the faulty layer.
9. Retest from the affected user’s UNC path.
10. Record root cause, correction, verification, and user communication.

## Design principles

- Assign access to role-based groups instead of individual users.
- Use least privilege for departmental folders.
- Avoid broad inherited entries that undermine the intended design.
- Avoid explicit Deny unless there is a strong, documented reason.
- Test each file action separately; successful browsing does not prove write access.

## Related evidence

The supporting [file-permissions lab](https://github.com/JoshuaKoshy973/soc-home-lab-active-directory-threat-detection/tree/main/file-permissions-lab) documents group membership, NTFS inheritance cleanup, access-denied symptoms, root-cause isolation, and verification.
