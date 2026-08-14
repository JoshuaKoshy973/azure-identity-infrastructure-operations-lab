# Domain Resources Unavailable Because of Client DNS Configuration

## Ticket summary

**Ticket:** `INC-2083`
**Priority:** Medium
**Requester:** Alex Carter
**Affected system:** `vm-win-client-01`
**Title:** Internal resources unavailable from Azure workstation

## Reported symptom

The client could be reached, but domain authentication and internal resources became unreliable after a restart. The initial symptom appeared similar to a file-share or permissions issue.

## Scope and evidence

The client NIC was using a custom DNS server address of `10.10.1.250`, while the lab domain controller and DNS server were at `10.10.1.10`.

## Troubleshooting

1. Confirmed the client VM was running.
2. Inspected the client NIC DNS configuration in Azure.
3. Compared the custom DNS address with the lab architecture.
4. Corrected the client DNS setting to use the intended domain DNS design.
5. Restarted or refreshed the client as required.
6. Verified DNS resolution, domain authentication, and internal resource access.

## Root cause

The client NIC pointed to a DNS address that did not host the lab’s domain DNS service. The client could not reliably locate the domain controller or resolve internal names.

## Verification

```powershell
ipconfig /all
nslookup dc-01.soclab.local
Test-ComputerSecureChannel
```

The client resolved `DC-01.soclab.local` to `10.10.1.10` and returned a successful secure-channel result.

## Lesson learned

DNS is an Active Directory dependency. When a file-share or authentication symptom appears after a client network change, validate client DNS before changing server permissions.
