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

        #Exit 1 for Intune.
        Write-Host "Exists"
        exit 1
    }
    else {

        #Exit 0 for Intune and "No_Match" for SCCM, only remediate "Match"
        Write-Host "Not_Exists"
        exit 0
    }
}
catch {
    
    $errMsg = $_.Exception.Message
    return $errMsg
    exit 1
}