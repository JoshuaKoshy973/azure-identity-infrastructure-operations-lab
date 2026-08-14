# Backup and Recovery Runbook

## Purpose

Validate that an Azure VM is protected, that backup jobs complete, and that a recoverable file can be restored without treating a backup job as proof of recovery by itself.

## Procedure

1. Confirm the Recovery Services vault and protected VM.
2. Review backup configuration, recovery-point availability, retention, and recent job status.
3. Create or identify a non-sensitive validation file in the test environment.
4. Confirm the file content or hash before the recovery test.
5. Delete the test copy and mount or expose the backup recovery point for file recovery.
6. Restore the file to a test location.
7. Confirm the destination exists, compare content hashes, and review the recovered content.
8. Record the recovery point, job result, validation method, and cleanup performed.

## Evidence captured

- [Completed backup jobs](../screenshots/11-azure-vm-backup-completed.png)
- [File-level recovery with matching hash](../screenshots/16-file-level-recovery-success.png)

The workflow validates both backup completion and file-level recovery, with content verification used as the final recovery check.
