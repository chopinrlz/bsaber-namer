# bsaber-namer

> _Someone forgot to give the Beat Saber devs a sort(custom_song *array) function._

bsaber-namer is a collection of scripts to help you unzip, rename, install, and fix bsaber.com custom song downloads.

* All Scripts Require PowerShell 7.0

# Fix-BSaberFiles.ps1
This script will rename your bsaber.com folders from their original ZIP file names using the song title, artist, and mapper. This script will run in the folder you specify with the `Path` parameter and will process any subfolders which contain the `info.dat` JSON file which describes the Beat Saber custom song. Subfolders will be named using this format:
```
[Song Title] - [Artist Name] - [Mapper Name]
```
For an example, the song _I Don't Wanna Wait_ by David Guetta featuring OneRepublic and mapped by _Faded 99_ into Beat Saber will be automatically named:
```
I Don't Wanna Wait - David Guetta ft. OneRepublic - Faded 99
```
This will put all of your custom Beat Saber songs in alphabetical order by song title.
## Usage
1. Open PowerShell 7
2. Run `.\Fix-BSaberFiles.ps1 -Path "[your path here]"` replacing [your path here] with the path to your Beat Saber custom songs.

**NOTE: EVERY custom song folder in `Path` will be renamed. You cannot UNDO this action.**
# Install-BSaberFiles.ps1
This script will automatically install custom songs downloaded from bsaber.com to the Custom Songs folder in the Oculus Apps directory. It will automatically find all the ZIP files matching the bsaber.com naming convention, unzip them to the Custom Songs folder, and rename the target directory to match the song name based on the JSON contained in the info.dat file. Beat Saber will show you your custom songs in Song Title order.
## Prerequisites

* Requires Beat Saber for Oculus to be installed.

## Usage

1. Put **Install-BSaberFiles.ps1** into the folder on your computer where your web browser automatically saves downloads.
2. Download a bunch of custom Beat Saber songs from bsaber.com
3. Open a PowerShell 7 terminal and run the script to install them.

## Parameters

Parameter | Required | Description
--- | --- | ---
OculusAppsPath | required | the absolute path to your Oculus Apps root folder
SourcePath | optional | the absolute path to your bsaber.com custom song ZIP files, defaults to the directory where the script is located
FromDownloads | optional | switch to ignore SourcePath and use your user profile downloads folder instead

## Examples

All of the following examples assume your Oculus Apps folder is located in "D:\Oculus Apps"

### Install from where you put the script

    .\Install-BSaberFiles.ps1 -OculusAppsPath "D:\Oculus Apps"

### Install from your profile's Downloads folder

    .\Install-BSaberFiles.ps1 -OculusAppsPath "D:\Oculus Apps" -FromDownloads

### Install from an arbitrary folder F:\Games\Beat Saber\Custom Songs

    .\Install-BSaberFiles.ps1 -OculusAppsPath "D:\Oculus Apps" -SourcePath "F:\Games\Beat Saber\Custom Songs"

## Unpack-BSaberFiles.ps1
This script will unzip a bunch of bsaber.com custom songs into the current folder and rename their destination folders to match the song, artist, and mapper. This script will run in the folder where you place it or some other location by specifying the optional $Path parameter.

## Usage

1. Put **Unpack-BSaberFiles.ps1** into the folder with all your bsaber.com custom song ZIP files
2. Open a PowerShell 7.0 terminal in this folder
3. Run .\Unpack-BSaberFiles.ps1 with no parameters

If you have multiple folders, or if your custom songs are not in the same folder as the script, use the $FullPath parameter. See the **Examples** section below.

## Parameters

Parameter | Required | Description
--- | --- | ---
FullPath | optional | the absolute path to your bsaber.com custom song ZIP files

## Examples

### Unzip and name custom songs located in a specific folder

    .\Unpack-BSaberFiles.ps1 -FullPath "D:\SomeFolder\CustomSongs"

### Unzip and name custom songs in multiple sub-folders

    Get-ChildItem -Path "D:\SomeFolder\CustomSongs" -Directory | % {
        .\Unpack-BSaberFiles.ps1 -FullPath ($_.FullName)
    }