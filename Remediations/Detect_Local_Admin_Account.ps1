#=============================================================================================================================
#
# Script Name:     Detect_Local_Admin_Account.ps1
# Description:     Detect if local admin account was created on device
# Notes:           Remediate if account not found
#
#=============================================================================================================================

# Define Variables

try {

    $localUsers = Get-LocalUser

    if ($localUsers.Name -notcontains "djm_LAPS"){

        # Exit 1 for Intune.
        Write-Host "Local LAPS account does not exist"
        exit 1
    }
    else {

        # Exit 0 for Intune
        Write-Host "Local LAPS account exists"
        exit 0
    }
}
catch {
    
    $errMsg = $_.Exception.Message
    return $errMsg
    exit 1
}