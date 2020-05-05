function Get-FolderName {
    [CmdletBinding()]
    Param(
        [Parameter(ValueFromPipeline)]
        $Json
    )
    return "$($Json._songName ?? "Song Name") - $($Json._songAuthorName ?? "Author Name") - $($Json._levelAuthorName ?? "Mapper Name")"
}

function Remove-IllegalCharacters {
    [CmdletBinding()]
    Param(
        [Parameter(ValueFromPipeline)]
        $Name
    )
    [string]$chars = [System.IO.Path]::GetInvalidPathChars()
    return $Name -replace "[$([Regex]::Escape( $chars ))]"," "
}

Get-Item "$PSScriptRoot\*" | ? Name -match "[a-f,0-9]{40}" | % {
    $newName = Get-Content -LiteralPath ($_.FullName | Join-Path -ChildPath "info.dat") | ConvertFrom-Json | Get-FolderName | Remove-IllegalCharacters
    if ( -not (Test-Path $newName) ) {
        Rename-Item -Path $_.FullName -NewName $newName
    } else {
        Write-Warning "$newName already exists"
    }
}