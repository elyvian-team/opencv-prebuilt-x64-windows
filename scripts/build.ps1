param(
  [string]$Triplet = "x64-windows-elyvian" # 또는 "x64-windows"
)

$ErrorActionPreference = "Stop"
$root = Split-Path -Parent $MyInvocation.MyCommand.Path
$repo = Resolve-Path "$root\.."
$vcpkg = Resolve-Path "$repo\vcpkg"

# 1) vcpkg bootstrap (최초 1회)
if (-not (Test-Path "$vcpkg\vcpkg.exe")) {
  & "$vcpkg\bootstrap-vcpkg.bat"
}

# 2) 매니페스트 모드 설치
& "$vcpkg\vcpkg.exe" install --triplet $Triplet --clean-after-build

# 3) 산출물 수집
$installed = Resolve-Path "$repo\vcpkg_installed\$Triplet"
New-Item -Force -ItemType Directory "$repo\artifacts" | Out-Null
$artifacts = Resolve-Path "$repo\artifacts"
New-Item -Force -ItemType Directory "$artifacts\include" | Out-Null
New-Item -Force -ItemType Directory "$artifacts\lib"     | Out-Null
New-Item -Force -ItemType Directory "$artifacts\bin"     | Out-Null

Copy-Item "$installed\include\*" "$artifacts\include" -Recurse -Force
Copy-Item "$installed\lib\*.lib" "$artifacts\lib" -Force
Copy-Item "$installed\bin\*.dll" "$artifacts\bin" -Force

Write-Host "Artifacts ready at: $artifacts"
