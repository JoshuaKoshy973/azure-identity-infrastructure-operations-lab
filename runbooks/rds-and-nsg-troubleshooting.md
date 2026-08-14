# RDP and NSG Troubleshooting Runbook

## Purpose

Use this sequence when RDP to an Azure Windows VM fails. Treat the RDP error as a symptom and isolate the failing layer before changing the network.

## Troubleshooting order

```text
Exact error and scope
→ requester authorization
→ VM power state
→ Resource Health
→ current public/private IP
→ NIC and subnet
→ NSG associations
→ inbound TCP 3389 rules
→ effective security rules
→ Windows Firewall
→ Remote Desktop Services
→ Windows login permissions
```

## Procedure

1. Confirm the requester, target VM, exact error, and whether the failure is a timeout or credential rejection.
2. Confirm the requester is authorized to access the VM.
3. Check VM power state, Resource Health, Activity Log, and Boot diagnostics.
4. Confirm the current public or private IP; do not rely on a previously saved address.
5. Identify the attached NIC and its NSG associations.
6. Review inbound TCP `3389` rules and their priorities.
7. Review effective security rules for the NIC.
8. If the Azure path is allowed, check Windows Firewall, Remote Desktop Services, and logon rights.
9. Correct the overly broad or incorrect rule using the smallest safe change.
10. Establish a new RDP connection and confirm the Windows desktop loads.
11. Record the root cause, correction, verification, and any security follow-up.

## Lab incident pattern

An inbound rule named `Deny-NonCorp-RDP` used `Source = Any` and priority `250`, which matched before an existing allow rule at priority `300`. The rule name suggested a narrower restriction than the configured fields actually applied.

```text
Incoming TCP 3389
→ priority 250 deny matches
→ processing stops
→ priority 300 allow is never reached
```

Do not expose RDP broadly in production. Prefer private connectivity, VPN, Bastion, just-in-time access, or another controlled administrative path.
