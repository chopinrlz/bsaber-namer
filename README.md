# bsaber-namer

**Install-BSaberFiles.ps1** is a PowerShell 7 script which will automatically install custom songs downloaded from bsaber.com to the Custom Songs folder in the Oculus Apps directory. It will automatically find all the ZIP files matching the bsaber.com naming convention, unzip them to the Custom Songs folder, and rename the target directory to match the song name based on the JSON contained in the info.dat file. Beat Saber will show you your custom songs in Song Title order.

## Prerequisites

* Requires Beat Saber for Oculus to be installed.
* Requires PowerShell 7 to use the ConvertFrom-Json cmdlet.

## Usage

1. Put **Install-BSaberFiles.ps1** into the folder on your computer where your web browser automatically saves downloads.
2. Download a bunch of custom Beat Saber songs from bsaber.com
3. Open a PowerShell 7 terminal and run the script to install them.

## Parameters

Parameter | Required | Description
--- | --- | ---
OculusAppsPath | required | the literal path to your Oculus Apps root folder
SourcePath | optional | the literal path to your bsaber.com custom song ZIP files, defaults to the directory where the script is located
FromDownloads | optional | switch to ignore SourcePath and use your user profile downloads folder instead

## Examples

All of the following examples assume your Oculus Apps folder is located in "D:\Oculus Apps"

### Install from where you put the script

.\Install-BSaberFiles.ps1 -OculusAppsPath "D:\Oculus Apps"

### Install from your profile's Downloads folder

.\Install-BSaberFiles.ps1 -OculusAppsPath "D:\Oculus Apps" -FromDownloads

### Install from an arbitrary folder F:\Games\Beat Saber\Custom Songs

.\Install-BSaberFiles.ps1 -OculusAppsPath "D:\Oculus Apps" -SourcePath "F:\Games\Beat Saber\Custom Songs"