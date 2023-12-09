#=============================================================================================================================
#
# Script Name:     Remediate_Local_Admin_Account.ps1
# Description:     This script creates the LAPS local admin account
# Notes:           No variable substitution needed
#
#=============================================================================================================================

try {

    #Generate initial random password
    #ASCII Character set for Password
    $CharacterSet = @{
        Lowercase   = (97..122) | Get-Random -Count 10 | % { [char]$_ }
        Uppercase   = (65..90)  | Get-Random -Count 10 | % { [char]$_ }
        Numeric     = (48..57)  | Get-Random -Count 10 | % { [char]$_ }
        SpecialChar = (33..47) + (58..64) + (91..96) + (123..126) | Get-Random -Count 10 | % { [char]$_ }
    }

    #Frame Random Password from given character set
    $StringSet = $CharacterSet.Uppercase + $CharacterSet.Lowercase + $CharacterSet.Numeric + $CharacterSet.SpecialChar

    $password = -join (Get-Random -Count 14 -InputObject $StringSet)

    # Create local user
    New-LocalUser -Name "djm_LAPS" -Password $password -Description "Local LAPS account"

    # Add user to Administrators group
    Add-LocalGroupMember -Group "Administrators" -Member "djm_LAPS"

    $userCreated = Get-LocalUser | Where-Object { $_.Name -eq "djm_LAPS" }

    if ($userCreated) {

        Write-Host "Local LAPS account created successfully"
        exit 0
    }
    else {

        Write-Host "Local LAPS account creation failed"
    }
}
catch {
    
    $errMsg = $_.Exception.Message
    return $errMsg
    exit 1
}