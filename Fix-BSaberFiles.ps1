<#
    .SYNOPSIS
    Normalizes all Beat Saber custom song folder names at the specified Path to match
    the [Song Name] - [Artist Name] - [Mapper Name] convention.
    .PARAMETER Path
    The path to search. All folders in this path containing an info.dat file will be renamed
    according to the contents of the info.dat file.
#>
param(
    [Parameter(Mandatory,ValueFromPipeline,Position = 0)]
    [string]
    $Path
)

# Assert
if( -not (Test-Path $Path) ) {
    throw "$Path does not exist"
}

function Get-FolderName {
    <#
        .SYNOPSIS
        Builds the new name of the folder from the info.dat JSON payload using the song name, author name, and level author name
        properties.
        .PARAMETER Json
        The info.dat information converted from JSON to an object.
    #>
    [CmdletBinding()]
    Param(
        [Parameter(ValueFromPipeline)]
        $Json
    )
    Write-Output ("$($Json._songName ?? "Song Name") - $($Json._songAuthorName ?? "Artist Name") - $($Json._levelAuthorName ?? "Mapper Name")")
}

function Remove-IllegalCharacters {
    <#
        .SYNOPSIS
        Removes illegal file system characters from the new folder name and replaces them with underscore.
        .PARAMETER Name
        The Beat Saber song folder name to test for illegal characters.
    #>
    [CmdletBinding()]
    Param(
        [Parameter(ValueFromPipeline)]
        $Name
    )
    [string]$chars = [System.IO.Path]::GetInvalidPathChars()
    Write-Output ($Name -replace "[$([Regex]::Escape( $chars ))]","_")
}

# Read all folders at Path
Get-ChildItem -Path $Path -Directory | ForEach-Object {
    $dat = Join-Path -Path ($_.FullName) -ChildPath "info.dat"
    if( Test-Path $dat ) {
        # Read info.dat and generate folder name
        $newName = Get-Content $dat -Raw | ConvertFrom-Json | Get-FolderName | Remove-IllegalCharacters
        $newPath = Join-Path -Path $Path -ChildPath $newName
        if( -not (Test-Path $newPath) ) {
            # Set new folder name
            Rename-Item -Path ($_.FullName) -NewName $newName
        }
    }
}