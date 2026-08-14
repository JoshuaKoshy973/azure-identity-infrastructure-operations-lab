# VM Lifecycle Operation Stuck in Deallocating

## Ticket summary

**Affected system:** `vm-win-client-01`
**Symptom:** Azure displayed `Deallocating`, and Start, Restart, and Stop controls were temporarily unavailable.

## Troubleshooting

1. Confirmed the intended VM and resource group.
2. Checked the VM’s current power and provisioning state.
3. Reviewed the Activity Log for the accepted lifecycle operation.
4. Waited for the transitional state to complete before submitting another command.
5. Refreshed the portal and verified the final power state.

## Root cause

The VM was already processing a lifecycle operation. An additional command could not override the in-progress state.

## Lesson learned

`-Force` suppresses confirmation; it does not override an Azure operation already in progress. Avoid overlapping Start, Stop, Restart, and Deallocate commands, and record the final state before continuing administration.
