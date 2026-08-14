# VM Unavailable

## Ticket summary

**Ticket:** `INC-2160`
**Priority:** High
**Affected resource:** `vm-win-client-01`
**Title:** Windows client unavailable for administrative access

## Reported symptom

An administrator reported that the client VM could not be reached for RDP testing. The first task was to determine whether the failure was caused by Azure resource state, network filtering, the guest operating system, or Windows authentication.

## Scope and impact

The client VM was the affected resource. The domain controller remained available, so the investigation treated the issue as isolated until evidence showed otherwise. The impact was loss of access to the workstation used for domain, RDP, monitoring, and end-user validation.

## Troubleshooting sequence

1. Confirmed the target VM name, resource group, requester, and exact RDP error.
2. Checked the VM power state, provisioning state, Resource Health, Activity Log, and Boot diagnostics.
3. Confirmed the current public or private IP address.
4. Identified the attached NIC, subnet, and NSG associations.
5. Reviewed effective inbound rules for TCP `3389`.
6. Tested whether the failure was a timeout or a credential rejection.
7. If Azure and network checks passed, validated Windows Firewall and Remote Desktop Services.
8. Verified the account had the required Windows logon rights.
9. Applied the smallest corrective action and waited for any transitional state to complete.
10. Reconnected through RDP and validated the Windows desktop and required services.

## Root-cause decision tree

| Evidence | Most likely layer | Next check |
|---|---|---|
| VM stopped or deallocating | Azure control plane | Wait for state transition; review Activity Log |
| Resource Health issue | Azure platform | Review health details and affected dependency |
| VM running, TCP 3389 blocked | NIC/NSG/network | Review associations, priorities, and effective rules |
| TCP path works, credentials rejected | Guest authentication | Check account, logon rights, and domain health |
| RDP connects but Windows service is broken | Guest OS | Check service state, event logs, and dependencies |

## Lifecycle-state consideration

Azure may display `Starting`, `Stopping`, or `Deallocating` while an operation is still being processed. Start, Restart, and Stop commands should not be submitted on top of an active transition. `-Force` suppresses confirmation; it does not override an operation already in progress.

## Verification standard

Recovery is complete only after the final Azure power state is confirmed, the network path is available, RDP succeeds, the user can authenticate, and the intended Windows services are healthy.

## Lesson learned

“The VM is down” is a hypothesis, not a diagnosis. Separate Azure resource state, network data-plane behavior, and guest operating-system health before changing anything.
