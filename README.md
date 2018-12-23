# Backup-Plex
Powershell script that backs up a standard Windows Plex Media Server installation.
Does not include any media!
Important files are mirrored to a specified location, then the same files are compressed and the zip file is moved to a second location.

A Plex backup should contain the contents of %USERAPPDATA%\Plex Media Server and an export of the Registry key HKEY_CURRENT_USER\Software\Plex, Inc.\Plex Media Server
(for more information see https://support.plex.tv/articles/201539237-backing-up-plex-media-server-data)

This script first mirrors the Plex data (minus the cache folder which is not required) to a destination supplied in settings.
It then exports the registry key to the same location, before zipping the mirror and key to a temporary location
and moving the zip file out to some other destination.
