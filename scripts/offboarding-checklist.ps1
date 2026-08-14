[CmdletBinding()]
param(
    [Parameter(Mandatory)]
    [string]$UserPrincipalName
)

[PSCustomObject]@{
    User                   = $UserPrincipalName
    DisableAccount         = 'Required'
    RevokeSessions         = 'Review and perform through approved process'
    RemoveGroupMemberships = 'Required'
    RemoveRBACAssignments  = 'Required'
    CheckServiceAccounts   = 'Required'
    VerifySignInBlocked    = 'Required'
    DocumentApproval       = 'Required'
} | Format-List
