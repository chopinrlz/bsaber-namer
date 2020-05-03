Param(
    [switch]$FromHere,
    [string]$SourcePath,
    [Parameter(Mandatory=$true)]
    [string]$OculusApps
)
if( $FromHere ) {
    $SourcePath = $PSScriptRoot
} else {
    if( -not $SourcePath ) {
        $SourcePath = "$env:USERPROFILE\Downloads"
    }
}
if( -not (Test-Path $SourcePath) ) {
    Write-Warning "Source path $SourcePath does not exist"
    exit
}
if( -not (Test-Path $OculusApps) ) {
    Write-Warning "Oculus Apps path $OculusApps does not exist"
    exit
}
$source = Join-Path -Path $SourcePath -ChildPath "*"
$target = Join-Path -Path $OculusApps -ChildPath "Software\hyperbolic-magnetism-beat-saber\Beat Saber_Data\CustomLevels"
Get-Item -Path $source | ? Name -match "[a-f,0-9]{40}\.zip" | % {
    $destination = Join-Path -Path $target -ChildPath (($_.Name).Replace(".zip", ""))
    Expand-Archive -LiteralPath $_.FullName -DestinationPath $destination
}