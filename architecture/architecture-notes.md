# Architecture Notes

## Control-plane and guest-services relationship

The Azure control plane manages resources such as VMs, NICs, disks, VNets, NSGs, monitoring rules, and backup configuration. The guest operating system provides Windows services, domain authentication, DNS behavior, RDP, SMB, and local firewall policy.

```text
Entra identity and Azure RBAC
            ↓
Azure subscription and resource group
            ↓
VM / NIC / disk / VNet / subnet / NSG
            ↓
Windows guest: AD DS, DNS, logon, RDP, SMB, services
```

An Azure VM can be running while RDP, DNS, a Windows service, or an application is unavailable. Conversely, an NSG can block network traffic while the VM and guest services remain healthy.

## Identity boundaries

Microsoft Entra ID users and groups control cloud identity and Azure management authorization. Active Directory Domain Services inside `DC-01` controls the lab’s Windows domain, DNS-integrated discovery, domain logon, and Windows resource access. These are separate systems in this lab; no synchronization was configured.

## Network boundaries

The client and domain controller share the `10.10.1.0/24` subnet inside the `10.10.0.0/16` VNet. The client NSG was used for isolated network testing at the client NIC. Changes to that NSG do not change the VM’s power state and do not directly change Windows file or printer permissions.

## Data-protection boundary

Azure Backup protects the VM through the Recovery Services vault. A completed backup job demonstrates protection activity; file-level recovery validation demonstrates that usable data can be recovered and verified.

## Infrastructure-as-Code extension boundary

The completed lab was built and operated through the Azure portal, PowerShell, and targeted validation commands. The next evolution will place the Azure resource definitions under Terraform management without rebuilding the existing environment unnecessarily.

The intended control flow is:

```text
Terraform configuration in Git
        ↓
terraform plan and review
        ↓
authenticated CI/CD pipeline
        ↓
Azure resource changes
        ↓
post-apply validation and documentation
```

The extension should preserve the existing boundaries:

- Microsoft Entra ID and Azure RBAC remain the identity and authorization layer.
- The existing VNet, subnet, VMs, NSGs, monitoring, and Recovery Services vault remain the operational environment.
- Terraform becomes the desired-state and change-review layer for infrastructure.
- Remote state must be protected and shared safely; it must not be committed to Git.
- Workload identity or another federated mechanism should be preferred over long-lived service-principal secrets.
- Azure DevOps or GitHub-based pipelines should run validation and plan review before any apply step.
- Approval gates should protect changes that affect shared networking, identity, VM availability, or backup.

This creates a clear portfolio progression: first operate the environment manually and learn its boundaries, then codify those same boundaries and automate controlled changes.
