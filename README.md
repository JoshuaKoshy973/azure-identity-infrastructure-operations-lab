# Azure Identity & Infrastructure Operations Lab

Separate portfolio project for practicing Azure management operations while reusing the existing SOC lab resources. The lab will be documented incrementally as each phase is completed and validated.

## Planned focus

- Microsoft Entra ID users and security groups
- Group-based Azure RBAC
- VM operations and status checks
- Azure Monitor and alerts
- Azure Backup and recovery
- PowerShell administration and automation
- Infrastructure troubleshooting

## Existing lab context

The project reuses the existing Azure environment: VNet `10.10.0.0/16`, subnet `10.10.1.0/24`, `DC-01` running Windows Server 2022 with AD DS, DNS, and Splunk, and `Client-01` joined to `SOC-LAB.LOCAL`.

AD DS inside `DC-01` remains separate from Microsoft Entra ID unless synchronization is intentionally configured later.

## Status

Repository structure initialized. Detailed runbooks, scripts, incident reports, screenshots, and validation results will be added only after the corresponding lab work is completed.

See the [architecture diagram](architecture/architecture-diagram.png) for the planned management and infrastructure layers.
