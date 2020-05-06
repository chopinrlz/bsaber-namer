Param(
    [string]$FullPath
)
function Remove-IllegalCharacters( [string]$Name ) {
    [string]$chars = [System.IO.Path]::GetInvalidFileNameChars()
    return $Name -replace "[$([Regex]::Escape( $chars ))]"," "
}
function Get-SongFolderName( [string]$Path ) {
    $info = Join-Path -Path $Path -ChildPath "info.dat"
    $json = Get-Content $info | ConvertFrom-Json
    $name = "$($json._songName ?? "Song Name") - $($json._songAuthorName ?? "Author Name") - $($json._levelAuthorName ?? "Mapper Name")"
    return (Remove-IllegalCharacters -Name $name)
}
[string]$Path = ""
if( -not [String]::IsNullOrEmpty( $FullPath ) ) {
    $script:Path = $FullPath
} else {
    $script:Path = $PSScriptRoot
}
if( -not (Test-Path $Path) ) {
    Write-Warning "$Path does not exist or cannot be accessed"
    exit
}
$source = Join-Path -Path $Path -ChildPath "*"
Get-Item -Path $source | ? Name -match "[a-f,0-9]{40}\.zip" | % {
    $destination = Join-Path -Path $Path -ChildPath (($_.Name).Replace(".zip", ""))
    Expand-Archive -LiteralPath $_.FullName -DestinationPath $destination -Force
    $safeName = Get-SongFolderName -Path $destination
    $newFullPath = Join-Path -Path $script:Path -ChildPath $safeName
    if( -not (Test-Path $newFullPath) ) {
        Rename-Item -Path $destination -NewName $safeName -ErrorAction SilentlyContinue -ErrorVariable RenameError
        if( $RenameError ) {
            Write-Warning "Could not rename folder $safeName"
        }
    } else {
        Write-Warning "$safeName already exists"
    }
}