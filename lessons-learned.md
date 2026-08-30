# Lessons Learned

## Identity and authorization

Microsoft Entra ID, Azure RBAC, Active Directory Domain Services, Windows logon rights, SMB permissions, and application authorization are different control layers. A successful sign-in to one layer does not prove access to another.

The most reliable access model was group-based:

```text
User
→ security group
→ role or permission
→ scope
→ verified action
```

This makes access easier to audit, change, remove, and explain. It also makes troubleshooting more structured because the investigation can compare the expected group, role, scope, and effective result.

## RBAC scope

The role definition alone is not enough. A `Reader` assignment at resource-group scope provides visibility within that scope, while a VM-scoped `Virtual Machine Contributor` assignment enables a different set of management actions on a narrower resource. A correct role at the wrong scope can still produce an access failure.

Azure Reader access also does not grant RDP, Windows domain logon, SMB, NTFS, printer, or application access inside the guest operating system. That boundary is one of the most important distinctions in this project.

## Lifecycle management

Onboarding and offboarding are repeatable service workflows, not isolated clicks. A strong onboarding process validates the request, creates or identifies the user, applies baseline and role-specific groups, verifies access, and records the result.

Offboarding requires more than disabling the account. The complete review includes group memberships, direct RBAC assignments, active sessions, devices, application access, licenses, ownership of data, service-account dependencies, and the final sign-in result.

## Azure control plane versus guest OS

Azure can report a VM as running while RDP, DNS, a Windows service, or an application is broken. The reverse is also true: a healthy guest cannot be reached when an NSG, route, IP address, or platform state blocks the network path.

The troubleshooting model is therefore layered:

```text
Azure resource state
→ network path and security rules
→ guest operating system
→ Windows services
→ authentication and authorization
→ application or user workflow
```

This prevents an administrator from changing Windows settings when the failure is in Azure networking, or changing an NSG when the VM is simply processing a lifecycle operation.

## Networking and NSGs

NSG behavior is determined by configured fields and priority, not by the rule name. A rule named as if it affects only external sources can still deny everyone when `Source = Any`. Lower priority numbers are evaluated first, so an earlier deny prevents a later allow from being reached.

An RDP timeout usually directs the investigation toward availability or network filtering, while a credential error directs it toward authentication and Windows logon rights. Neither is absolute; the exact error, scope, power state, IP, NIC, NSG, effective rules, firewall, and service state must be compared.

## DNS and Active Directory

DNS is a dependency for Active Directory discovery and authentication. A domain-joined client should use the domain’s DNS infrastructure. A client can appear healthy at the network layer while failing to locate the domain controller, resolve internal names, authenticate, or access file and printer resources.

The client-side sequence is efficient:

```text
ipconfig /all
→ DNS server address
→ hostname and FQDN resolution
→ domain authentication
→ secure-channel test
→ SMB or application access
```

The same reasoning applies to the supporting printer and file-permissions labs: validate client identity and name resolution before changing server permissions.

## Monitoring and alerting

A metric by itself is an observation. An operational alert adds a threshold, duration, severity, affected resource, notification path, and response procedure. The CPU exercise connected a utilization spike to a fired Azure Monitor alert and a defined investigation path.

Useful alerts should be actionable, explain what the responder should check first, and avoid creating noise that trains people to ignore notifications. Alert closure should include the cause, corrective action, verification, and any tuning or follow-up.

## Backup and recovery

A completed backup job proves that a protection operation ran. It does not prove that the required data can be recovered. Recovery validation should confirm the correct recovery point, source path, restored destination, file existence, readable content, and content hash.

The strongest evidence in this lab connected all three stages:

```text
Backup job completed
→ recovery point available
→ file restored to a test location
→ content hash matched
→ recovered content was readable
```

This is the difference between configuring backup and demonstrating recoverability.

## PowerShell and automation

PowerShell is most useful when it produces repeatable, auditable results. Azure cmdlets return objects, so a reporting pipeline can sort and select properties before formatting them for display:

```text
Get-AzVM
→ Sort-Object
→ Select-Object
→ Format-Table
```

Formatting should remain at the end of the pipeline. State-changing scripts should identify the target explicitly, support `-WhatIf` where appropriate, and report the final state after the operation.

## Documentation and support practice

The printer and file-permissions labs reinforced the same support pattern used here:

```text
Symptom
→ scope and business impact
→ evidence
→ hypothesis
→ diagnostic action
→ root cause
→ smallest safe correction
→ user or service verification
→ follow-up
```

Screenshots are strongest when each one proves a meaningful state or transition. A clean ticket or runbook should allow another technician to understand what happened, why the change was made, how it was verified, and what should be checked next time.

## Final takeaway

The central skill demonstrated across these projects is not memorizing a portal path or command. It is isolating the failing layer, protecting scope, choosing the least-privileged correction, validating the actual user or service outcome, and leaving behind documentation that another technician can use.
