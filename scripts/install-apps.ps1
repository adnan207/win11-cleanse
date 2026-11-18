# language: PowerShell, file: scripts/install-apps.ps1, target: Windows 11 / Windows 10
param (
    # Hanya 7-Zip sebagai utilitas arsip ultra-ringan (~3MB, tanpa background service)
    [string[]]$Packages = @("7zip.7zip"),
    [switch]$SkipAll = $false
)

Write-Host "=== Instalasi Utilitas Esensial (Minimalist & Lightweight) ===" -ForegroundColor Cyan

if ($SkipAll) {
    Write-Host "[!] SkipAll aktif. Tidak ada aplikasi tambahan yang dipasang agar Windows tetap seringan mungkin." -ForegroundColor Yellow
    exit 0
}

# Periksa ketersediaan winget
if (-not (Get-Command winget -ErrorAction SilentlyContinue)) {
    Write-Host "[!] Winget tidak ditemukan. Melewati proses instalasi aplikasi." -ForegroundColor Yellow
    exit 0
}

foreach ($pkg in $Packages) {
    Write-Host "[*] Memeriksa dan menginstal: $pkg" -ForegroundColor Yellow
    winget install --id $pkg --silent --accept-source-agreements --accept-package-agreements --no-upgrade
}

Write-Host "=== Selesai (Sistem tetap ringan dan bebas background bloatware) ===" -ForegroundColor Green
