# Terraform and Azure DevOps CI/CD Runbook

## Purpose

Deliver an Azure infrastructure change from a Git feature branch through automated Terraform validation, reviewed planning, a protected approval gate, and application of the exact saved plan.

## Preconditions

- The target belongs in the Terraform-managed boundary `rg-azure-iac-lab`.
- The Azure CLI is authenticated to the intended tenant and subscription for local validation.
- The Terraform backend points to the correct Blob container and state key.
- The Azure DevOps service connection `sc-terraform-azure-iac-lab` is available.
- The pipeline identity has scoped access to both the deployment resource group and the state container.
- The proposed address space does not overlap an existing network.

## Local change workflow

1. Update local `main` and create a descriptive feature branch.
2. Modify the required HCL and variable definitions.
3. Run formatting, validation, and a local plan.
4. Read the full plan, including replacement and destroy indicators.
5. Confirm the plan contains only the intended actions.
6. Do not apply the shared change locally.
7. Commit the HCL change and push the feature branch.
8. Open a pull request targeting `main`.

```bash
terraform fmt -recursive
terraform validate
terraform plan
```

## Pull-request CI

For pull requests that change `terraform/**` or `azure-pipelines.yml`, Azure Pipelines:

1. checks out the repository;
2. installs the configured Terraform version;
3. runs `terraform fmt -check -recursive`;
4. authenticates through the federated Azure service connection;
5. initializes the remote backend;
6. validates the configuration;
7. produces an authenticated Terraform plan;
8. stops without applying infrastructure.

Review the plan as a change record. Pay special attention to `must be replaced`, `forces replacement`, and any destroy count.

## Main-plan stage

After the pull request is reviewed and merged, the `MainPlan` stage:

1. checks out the accepted `main` source;
2. reruns formatting and Terraform initialization;
3. validates the configuration;
4. creates a fresh saved plan with `terraform plan -out=tfplan`;
5. publishes `tfplan` as the `terraform-plan` pipeline artifact.

Generating a fresh plan after merge prevents the deployment from relying on a stale local plan created before review.

## Approval and deployment

The `Deploy` stage downloads the saved plan and targets the protected Azure DevOps environment `azure-iac-lab`. The deployment pauses for human review.

Before approving:

1. confirm the triggering commit and source branch;
2. confirm the plan stage succeeded;
3. confirm the intended resource and scope;
4. confirm no unplanned replacement or destroy action is present;
5. confirm the timing is appropriate for the expected impact.

After approval, the deployment job initializes Terraform, copies the published plan into the working directory, and runs:

```bash
terraform apply -input=false tfplan
```

## Post-deployment validation

1. Confirm the apply job completed successfully.
2. Confirm the expected add/change/destroy counts.
3. Verify the resource and configuration in Azure.
4. Run a final Terraform plan against the remote state.
5. Confirm Terraform reports that the infrastructure matches the configuration.
6. Record the pull request, pipeline run, approval, apply result, and Azure validation.

## Failure isolation

| Symptom | Likely layer | First checks |
|---|---|---|
| `terraform fmt -check` fails | HCL formatting | Run `terraform fmt -recursive`; review the diff |
| `terraform validate` fails | HCL/provider references | Check resource names, variables, types, and provider configuration |
| `terraform init` cannot access state | Backend authentication/authorization | Check federated identity, Blob data role, scope, container, and state key |
| Plan shows unexpected replacement | Resource lifecycle/API behavior | Find `forces replacement`; assess impact before merge |
| Plan shows unexpected destroy | HCL/state mismatch | Confirm whether the resource was removed, renamed, or moved in configuration |
| Pipeline plan differs from local plan | State, identity, source, or subscription mismatch | Compare commit, backend, state key, subscription, variables, and provider version |
| Deployment waits indefinitely | Environment approval | Review pending checks, authorized approvers, and timeout |
| Apply fails after approval | Azure API, RBAC, conflict, or stale condition | Preserve logs; review the exact failing resource and Azure Activity Log |
| Apply succeeds but Azure looks wrong | Verification or scope mismatch | Confirm subscription, resource group, resource properties, and final plan |

## Security and operational controls

- Do not commit Terraform state, saved plans, `.terraform` directories, or secret-bearing variable files.
- Prefer Workload Identity Federation over stored service-principal secrets.
- Grant the pipeline only the roles and scopes required for resources and state.
- Keep pull-request approval separate from deployment approval.
- Apply the saved plan artifact rather than generating a different plan inside the deployment step.
- Treat any replacement or destroy action as an explicit review event.

## Evidence

- [Merged GitHub Terraform pull request](../screenshots/26-github-terraform-pull-request.png)
- [Authenticated Terraform plan](../screenshots/28-azure-pipelines-authenticated-terraform-plan.png)
- [Deployment approval gate](../screenshots/29-azure-pipelines-terraform-deployment-approval.png)
- [Successful Terraform apply](../screenshots/30-azure-pipelines-terraform-apply-success.png)
- [End-to-end management-subnet plan](../screenshots/32-azure-pipelines-pr-terraform-plan.png)
- [End-to-end management-subnet deployment](../screenshots/33-azure-pipelines-end-to-end-terraform-deployment.png)
