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
