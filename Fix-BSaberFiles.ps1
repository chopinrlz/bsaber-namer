Get-Item "$PSScriptRoot\*" | ? Name -match "[a-f,0-9]{40}" | % {
    $path = $_.FullName
    $data = Get-Content "$path\info.dat" | ConvertFrom-Json
    $name = "$($data._songName ?? "Song Name") - $($data._songAuthorName ?? "Author Name") - $($data._levelAuthorName ?? "Mapper Name")"
    Rename-Item -Path $destination -NewName $name
}