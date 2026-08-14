# RDP Unavailable Because of an NSG Rule

## Ticket summary

**Ticket:** `INC-2047`
**Priority:** Medium
**Affected system:** `vm-win-client-01`
**Title:** Unable to connect to Windows client through RDP

## Reported symptom

The administrator reported that RDP to the Windows client had worked earlier but now timed out while access to the domain controller remained available.

## Scope and impact

The issue affected one client VM and prevented continued lab administration and testing. The domain controller and shared subnet were not changed.

## Troubleshooting

1. Confirmed the requester and target VM.
2. Checked VM power state and Resource Health.
3. Confirmed the current IP and attached NIC.
4. Reviewed the NIC-associated NSG and effective rules for TCP `3389`.
5. Found `Deny-NonCorp-RDP` with `Source = Any` and priority `250` ahead of the allow rule at `300`.

## Root cause

The configured source was `Any`, so the deny rule blocked all RDP sources. The rule name did not limit the behavior; the configured fields and priority determined the result.

## Resolution and verification

The temporary deny condition was removed or corrected, the effective rules were rechecked, and a new RDP connection was established to the client VM.

## Lesson learned

Separate Azure resource state, network filtering, and guest authentication. A timeout usually directs the investigation toward availability or filtering before credentials, but the exact error and scope still need to be confirmed.
