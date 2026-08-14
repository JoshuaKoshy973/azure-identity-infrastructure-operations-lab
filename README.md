# Azure Identity & Infrastructure Operations Lab

An incremental Azure operations lab built on an existing SOC environment. It demonstrates cloud identity administration, group-based access control, VM health validation, monitoring, alert response, and safe backup recovery.

## What this demonstrates

- Microsoft Entra cloud users and security groups
- User lifecycle actions: membership changes, account disablement, and sign-in validation
- Azure RBAC assigned to groups at resource-group and VM scopes
- Effective-access testing for authorized and unauthorized users
- Windows domain, DNS, and secure-channel validation inside Azure-hosted VMs
- Azure Monitor metric review and fired-alert investigation
- Azure Backup job review and file-level recovery validation
- Evidence-driven documentation with repeatable operational checks

## Environment

| Layer | Details |
|---|---|
| Azure network | Existing VNet `10.10.0.0/16`, subnet `10.10.1.0/24` |
| Domain controller | `DC-01`, Windows Server 2022, AD DS, DNS, Splunk |
| Client | `Client-01`, joined to `SOC-LAB.LOCAL` |
| Cloud identity | Microsoft Entra ID users and cloud security groups |
| Protection | Recovery Services vault `rsv-soc-lab-backup` |

AD DS inside `DC-01` remains separate from Microsoft Entra ID. No synchronization was configured as part of this lab.

## Phase status

| Phase | Status | Evidence |
|---|---|---|
| Environment review | Completed | [Resource inventory](screenshots/01-azure-resource-inventory.png) |
| Entra users and groups | Completed | [Users](screenshots/02-entra-cloud-users.png), [groups](screenshots/03-entra-security-groups.png) |
| Lifecycle management | Completed | [Role membership](screenshots/04-entra-role-change-membership.png), [offboarding evidence](screenshots/05-entra-offboarded-account-disabled.png) |
| Azure RBAC | Completed | [Scope assignments](screenshots/08-azure-rbac-group-scope-assignments.png), [effective access](screenshots/09-jordan-effective-rbac-access.png) |
| VM and domain health | Completed | [Service health](screenshots/12-domain-controller-service-health.png), [DNS and trust](screenshots/13-client-dns-domain-trust-validation.png) |
| Monitor and alerting | Completed | [CPU spike](screenshots/14-client-cpu-utilization-spike.png), [fired alert](screenshots/15-high-cpu-alert-fired.png) |
| Backup and recovery | Completed | [Backup jobs](screenshots/11-azure-vm-backup-completed.png), [file recovery](screenshots/16-file-level-recovery-success.png) |

## Architecture

![Azure identity and infrastructure architecture](architecture/architecture-diagram.png)

## Documentation

- [Screenshot index](screenshots/README.md)
- [Onboarding runbook](runbooks/onboarding.md)
- [Offboarding runbook](runbooks/offboarding.md)
- [VM operations runbook](runbooks/vm-operations.md)
- [Backup and recovery runbook](runbooks/backup-recovery.md)
- [Lessons learned](lessons-learned.md)
- [Incident documentation](incidents/)

The project is organized around practical identity, access, operations, monitoring, and recovery workflows. Screenshots provide evidence for the key configuration and validation steps.
