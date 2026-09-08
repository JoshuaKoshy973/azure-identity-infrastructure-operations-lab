# Screenshot Evidence Index

Each screenshot captures a meaningful configuration, decision point, failure mode, or validation result. The sequence shows the project’s progression from manual Azure operations to Terraform and approval-gated CI/CD.

## Azure identity, operations, monitoring, and recovery

1. [Azure resource inventory](01-azure-resource-inventory.png) — Existing VMs, networking resources, disks, and VNet.
2. [Microsoft Entra cloud users](02-entra-cloud-users.png) — Cloud identities used for lifecycle and access exercises.
3. [Microsoft Entra security groups](03-entra-security-groups.png) — Role-oriented cloud groups used for access management.
4. [Role-change membership](04-entra-role-change-membership.png) — Membership verification after a user role change.
5. [Offboarded account disabled](05-entra-offboarded-account-disabled.png) — Entra account state after offboarding.
6. [Offboarding membership removed](06-entra-offboarding-membership-removed.png) — User with no remaining group memberships.
7. [Offboarding sign-in blocked](07-entra-offboarding-signin-blocked.png) — Failed sign-in with the account-disabled reason.
8. [Azure RBAC group assignments](08-azure-rbac-group-scope-assignments.png) — Group-based Reader and Virtual Machine Contributor roles at different scopes.
9. [Effective RBAC access](09-jordan-effective-rbac-access.png) — User access inherited through approved group assignments.
10. [No-access user validation](10-taylor-no-azure-access.png) — Negative test for an identity without Azure resource access.
11. [Azure VM backup completed](11-azure-vm-backup-completed.png) — Completed backup and configuration jobs in the Recovery Services vault.
12. [Domain-controller service health](12-domain-controller-service-health.png) — AD DS, DNS, Netlogon, KDC, and Splunk services running.
13. [Client DNS and domain trust](13-client-dns-domain-trust-validation.png) — Domain identity, DNS resolution, and secure-channel validation.
14. [Client CPU utilization spike](14-client-cpu-utilization-spike.png) — Azure Monitor metric evidence during a controlled CPU event.
15. [High-CPU alert fired](15-high-cpu-alert-fired.png) — Fired alert with severity, condition, affected resource, and rule details.
16. [File-level recovery success](16-file-level-recovery-success.png) — Restored file with existence, readable content, and matching hash validation.

## Terraform foundation and change behavior

17. [Initial Terraform plan](17-terraform-initial-plan.png) — Resource group, VNet, and subnet plan with three additions and no changes or destroys.
18. [Initial Terraform apply](18-terraform-apply-success.png) — Successful creation of the three-resource Azure network foundation.
19. [Azure network validation](19-terraform-azure-network-validation.png) — Terraform-created VNet and `10.40.1.0/24` subnet visible in Azure.
20. [Application subnet plan](20-terraform-add-subnet-plan.png) — Additive plan for `subnet-azure-iac-apps` at `10.40.2.0/24`.
21. [In-place update plan](21-terraform-update-in-place-plan.png) — Resource-group tags changing without resource replacement.
22. [Resource replacement plan](22-terraform-resource-replacement-plan.png) — `forces replacement` behavior with one add and one destroy.
23. [Destroy plan](23-terraform-destroy-plan.png) — Planned removal after the application subnet was removed from configuration.
24. [Drift detection](24-terraform-drift-detection.png) — Terraform detecting a manually changed Azure tag and proposing reconciliation to HCL.
25. [Azure Blob remote state](25-terraform-remote-state-azure-blob.png) — State object, lock acquisition, resource refresh, and no-change result.

## GitHub and Azure DevOps CI/CD

26. [Terraform GitHub pull request](26-github-terraform-pull-request.png) — Merged feature branch showing reviewed HCL changes.
27. [Terraform CI success](27-azure-pipelines-terraform-ci-success.png) — Green checkout, install, format, init, and validate steps.
28. [Authenticated Terraform plan](28-azure-pipelines-authenticated-terraform-plan.png) — Azure-authenticated pipeline plan for the operations subnet.
29. [Terraform deployment approval](29-azure-pipelines-terraform-deployment-approval.png) — Protected environment waiting for an explicit approve or reject decision.
30. [Terraform apply success](30-azure-pipelines-terraform-apply-success.png) — Pipeline apply creating the operations subnet from the saved plan.
31. [Operations subnet validation](31-azure-terraform-operations-subnet-validation.png) — `10.40.3.0/24` operations subnet verified in Azure.
32. [Pull-request Terraform plan](32-azure-pipelines-pr-terraform-plan.png) — Automated CI plan for the `10.40.4.0/24` management subnet.
33. [End-to-end Terraform deployment](33-azure-pipelines-end-to-end-terraform-deployment.png) — Approval-gated apply successfully creating the management subnet.

## Strongest portfolio evidence

For a short walkthrough, the most useful sequence is:

1. [Remote state and locking](25-terraform-remote-state-azure-blob.png)
2. [Authenticated pipeline plan](28-azure-pipelines-authenticated-terraform-plan.png)
3. [Protected deployment approval](29-azure-pipelines-terraform-deployment-approval.png)
4. [Successful end-to-end deployment](33-azure-pipelines-end-to-end-terraform-deployment.png)

Together, these show centralized state, secretless pipeline identity, plan review, human governance, and successful infrastructure delivery.
