# language: PowerShell, file: scripts/install-apps.ps1, target: Windows 11
param (
    [string[]]$Packages = @(
        "7zip.7zip",
        "Microsoft.PowerToys"
    ),
    [switch]$IncludeAllRecommended = $false
)

if ($IncludeAllRecommended) {
    $Packages += @(
        "File-New-Project.EarTrumpet",
        "flux.flux",
        "geeksoftwareGmbH.PDF24Creator",
        "RustDesk.RustDesk"
    )
}

Write-Host "=== Instalasi Aplikasi Esensial via Winget ===" -ForegroundColor Cyan
foreach ($pkg in $Packages) {
    Write-Host "[*] Memeriksa dan menginstal paket: $pkg" -ForegroundColor Yellow
    winget install --id $pkg --silent --accept-source-agreements --accept-package-agreements
}
Write-Host "=== Instalasi Selesai ===" -ForegroundColor Green
