# creates a backup policy object and stores it in the **$Policy** variable.
$Policy = New-WBPolicy

# adds bare metal recovery to the policy.
Add-WBBareMetalRecovery $Policy

# gets the Windows Backup disk configuration. This cmdlet gets the list of internal and external disks available for the local computer and stores the resulting list in the **$Disks** variable.
$Disks = Get-WBDisk

# creates a backup target object and stores it in the **$BackupLocation** variable.
$BackupLocation = New-WBBackupTarget -Disk $Disks[2]

# adds a backup target. The **$BackupLocation** variable specifies the backup locations in the policy.
Add-WBBackupTarget -Policy $Policy -Target $BackupLocation

# Adds the system state components to the backup policy.
Add-WBSystemState -Policy $Policy

# sets the backup schedule in the policy. The cmdlet sets the times to create daily backups.
Set-WBSchedule -Policy $Policy 01:00

# gets the virtual machines available to be backed up
$VirtualMachines = Get-WBVirtualMachine

# Adds the virtual machines to the backup policy
Add-WBVirtualMachine -Policy $Policy -All

# sets the backup policy object for the computer.
Set-WBPolicy -Policy $Policy