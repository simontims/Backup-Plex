# Backup-Plex
# Simon Tims

# Settings
$mirror = "D:\Backup\Plex"
$destination = "\\bubblenas1\general\backups\Plex"
$tempLocation = "C:\temp"

# Do not change anything below this line
##################################################



# Load ZipFile .NET Framework
Add-Type -assembly "system.io.compression.filesystem"

# Build paths
$regKey = "HKEY_CURRENT_USER\Software\Plex, Inc.\Plex Media Server"
$source = Join-Path -Path $env:LOCALAPPDATA -ChildPath "Plex Media Server"
$cacheFolder = Join-Path -Path $source -ChildPath "cache"
$metadataFolder = Join-Path -Path $source -ChildPath "Metadata"
$regKeyFile = Join-Path -Path $mirror -ChildPath "PlexRegistryKey.reg"
$zipFile = Join-Path -Path $tempLocation -ChildPath "Plex.zip"

# Mirror Plex data folder
robocopy $source $mirror /MIR /NFL /NDL /R:0 /W:0 /XD $cacheFolder /XD $metadataFolder

# Export Plex Registry key 
Reg export $regKey $regKeyFile

# Zip file should have been removed already; double check and remove if present
if (Test-Path $zipFile) {Remove-Item $zipFile}

# Zip folder to zipfile (cannot be the source folder we are zipping)
[io.compression.zipfile]::CreateFromDirectory($mirror, $zipFile)

# Move zipfile to destination
try
{
    Move-Item $zipFile $destination -Force
}
catch
{
    Write-Host "Unable to move $zipfile to $destination"
}

