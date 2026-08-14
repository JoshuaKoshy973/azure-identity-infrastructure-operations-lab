# VM Operations Runbook

## Purpose

Use a small set of checks to establish whether an Azure-hosted Windows workload is reachable, healthy, and functioning at the operating-system level.

## Procedure

1. Confirm the VM, resource group, subscription context, and current power state.
2. Review the VM’s NIC, private IP, public IP, disk, VNet, subnet, and NSG relationships.
3. Check Azure Resource Health and the Activity Log for recent platform or configuration events.
4. From the server, confirm core services such as AD DS, DNS, Netlogon, KDC, and required monitoring agents.
5. From the client, confirm the expected DNS server, resolve the domain controller, and test the computer secure channel.
6. Record the observed state before taking an operational action such as restart or stop/start.
7. Recheck service health and client connectivity after the action.

## Evidence captured

- [Azure resource inventory](../screenshots/01-azure-resource-inventory.png)
- [Domain controller services](../screenshots/12-domain-controller-service-health.png)
- [Client DNS and secure channel](../screenshots/13-client-dns-domain-trust-validation.png)

These checks provide a structured baseline for investigating VM availability and guest operating-system health.
