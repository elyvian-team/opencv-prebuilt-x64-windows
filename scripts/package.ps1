param(
  [string]$Name = "opencv-4.11.0-x64-windows-elyvian"
)

$ErrorActionPreference = "Stop"
$repo = Split-Path -Parent $MyInvocation.MyCommand.Path
$repo = "$repo\.."
$artifacts = Resolve-Path "$repo\artifacts"
$zipPath = Join-Path $repo "$Name.zip"

if (Test-Path $zipPath) { Remove-Item $zipPath -Force }
Add-Type -AssemblyName System.IO.Compression.FileSystem
[System.IO.Compression.ZipFile]::CreateFromDirectory($artifacts, $zipPath)

Write-Host "Packaged: $zipPath"
