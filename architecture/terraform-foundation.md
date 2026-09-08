# Terraform Azure Network Foundation

The [`terraform/`](../terraform/) directory defines the separate Azure network used for the Infrastructure-as-Code and CI/CD portion of the lab.

## Managed resources

| Terraform resource | Azure resource | Address space |
|---|---|---|
| `azurerm_resource_group.iac_rg` | `rg-azure-iac-lab` | `eastus` |
| `azurerm_virtual_network.iac_vnet` | `vnet-azure-iac-lab` | `10.40.0.0/16` |
| `azurerm_subnet.iac_subnet` | `subnet-azure-iac-lab` | `10.40.1.0/24` |
| `azurerm_subnet.app_subnet` | `subnet-azure-iac-apps` | `10.40.2.0/24` |
| `azurerm_subnet.operations_subnet` | `subnet-azure-iac-operations` | `10.40.3.0/24` |
| `azurerm_subnet.management_subnet` | `subnet-azure-iac-management` | `10.40.4.0/24` |

## File responsibilities

- `providers.tf` pins the AzureRM provider family and configures the provider.
- `backend.tf` points Terraform to the Azure Blob remote backend.
- `main.tf` defines the resource group, VNet, and subnets.
- `variables.tf` defines typed names, region, and address ranges.
- `outputs.tf` returns the primary resource group, VNet, and subnet names.
- `.terraform.lock.hcl` records the selected provider dependency version.

## Remote state

The backend uses Azure AD authentication and stores the state as `azure-iac-lab.tfstate` in the `tfstate` Blob container. Local state files, saved plans, `.terraform` directories, and `tfvars` files are excluded from Git.

The pipeline service principal requires separate authorization for the deployment resource group and the state container. Successful access to Azure Resource Manager does not by itself grant Blob data-plane access.

## Local validation workflow

```bash
terraform fmt -check -recursive
terraform init
terraform validate
terraform plan
```

Local planning is used to review a proposed change. Shared infrastructure deployment is performed through the Azure DevOps pipeline after pull-request review and protected-environment approval.

## Change-safety checks

Before accepting a plan, confirm:

- the active Azure subscription and intended resource group;
- the expected backend and state key;
- that subnet address ranges do not overlap;
- the counts for resources to add, change, replace, or destroy;
- whether an attribute marked `forces replacement` is acceptable;
- that unrelated resources are absent from the plan;
- that the final post-deployment plan reports no remaining differences.

See the [Terraform and CI/CD runbook](../runbooks/terraform-cicd.md) for the complete delivery process.
