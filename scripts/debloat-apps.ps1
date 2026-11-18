# language: PowerShell, file: scripts/debloat-apps.ps1, target: Windows 11 / Windows 10
param (
    [switch]$KeepGaming = $false,
    [switch]$KeepStickyNotes = $false,
    [switch]$RemovePhoneLink = $false
)

$isAdmin = ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
if ($isAdmin) {
    Write-Host "[+] Mode Administrator terdeteksi (Full AllUsers & Provisioned Cleanup)." -ForegroundColor Green
} else {
    Write-Host "[!] Mode Standard User terdeteksi (Membersihkan aplikasi akun saat ini)." -ForegroundColor Yellow
}

# Daftar aplikasi bloatware yang dibersihkan (Ringan & Tetap Fungsional)
$appsToRemove = @(
    "Clipchamp.Clipchamp",
    "Microsoft.549981C3F5F10",              # Cortana
    "Microsoft.BingNews",                   # News
    "Microsoft.BingSearch",                 # Bing Search
    "Microsoft.BingWeather",                # Weather
    "Microsoft.GetHelp",                    # Get Help
    "Microsoft.Getstarted",                 # Tips / Get Started
    "Microsoft.MicrosoftOfficeHub",         # Office Hub Promo
    "Microsoft.MicrosoftSolitaireCollection", # Solitaire
    "Microsoft.People",                     # People
    "Microsoft.PowerAutomateDesktop",       # Power Automate
    "Microsoft.Todos",                      # Microsoft To Do
    "Microsoft.WindowsAlarms",              # Alarms & Clock
    "microsoft.windowscommunicationsapps",  # Mail & Calendar promo
    "microsoft.windowscommunicationsapp",
    "Microsoft.WindowsFeedbackHub",         # Feedback Hub
    "Microsoft.WindowsMaps",                # Maps
    "Microsoft.WindowsSoundRecorder",       # Sound Recorder
    "Microsoft.ZuneMusic",                  # Media Player Legacy
    "Microsoft.ZuneVideo",                  # Movies & TV
    "MicrosoftCorporationII.QuickAssist",   # Quick Assist
    "MicrosoftWindows.Client.WebExperience", # Windows Widgets Engine (Hemat RAM)
    "MSTeams",                              # Teams Personal
    "Microsoft.Office.ActionsServer",
    "Microsoft.OfficePushNotificationUtility",
    "Microsoft.OneDriveSync",
    "Microsoft.Windows.DevHome",
    "Microsoft.Windows.Cortana",
    "Microsoft.Windows.DevHomeGitHubExtension"
)

# Phone Link (Link to Phone / Windows) - DIPERTAHANKAN SECARA DEFAULT
if ($RemovePhoneLink) {
    Write-Host "[!] Menghapus Phone Link sesuai permintaan..." -ForegroundColor Yellow
    $appsToRemove += @(
        "Microsoft.YourPhone",
        "MicrosoftWindows.CrossDevice"
    )
} else {
    Write-Host "[+] Menjaga Phone Link (Link to Phone) agar tetap aktif dan berfungsi normal." -ForegroundColor Green
}

# Gaming & Xbox components
if (-not $KeepGaming) {
    $appsToRemove += @(
        "Microsoft.GamingApp",
        "Microsoft.Xbox.TCUI",
        "Microsoft.XboxGameOverlay",
        "Microsoft.XboxGamingOverlay",
        "Microsoft.XboxIdentityProvider",
        "Microsoft.XboxSpeechToTextOverlay"
    )
} else {
    Write-Host "[Info] Menjaga paket gaming (Xbox & Gaming Overlay)..." -ForegroundColor Yellow
}

# Sticky Notes
if (-not $KeepStickyNotes) {
    $appsToRemove += "Microsoft.MicrosoftStickyNotes"
} else {
    Write-Host "[Info] Menjaga Sticky Notes..." -ForegroundColor Yellow
}

foreach ($app in $appsToRemove) {
    if ($isAdmin) {
        $packages = Get-AppxPackage -AllUsers $app -ErrorAction SilentlyContinue
    } else {
        $packages = Get-AppxPackage $app -ErrorAction SilentlyContinue
    }

    if ($packages) {
        Write-Host "[-] Menghapus: $app" -ForegroundColor Yellow
        if ($isAdmin) {
            $packages | Remove-AppxPackage -AllUsers -ErrorAction SilentlyContinue
        } else {
            $packages | Remove-AppxPackage -ErrorAction SilentlyContinue
        }
    } else {
        Write-Host "[v] Tidak terpasang / sudah bersih: $app" -ForegroundColor DarkGray
    }
}

if ($isAdmin) {
    Write-Host "[*] Membersihkan Provisioned Packages..." -ForegroundColor Cyan
    foreach ($app in $appsToRemove) {
        Get-AppxProvisionedPackage -Online -ErrorAction SilentlyContinue |
            Where-Object { $_.PackageName -like "*$app*" } |
            ForEach-Object {
                Write-Host "[-] Menghapus Provisioned Package: $($_.DisplayName)" -ForegroundColor Yellow
                Remove-AppxProvisionedPackage -Online -PackageName $_.PackageName -ErrorAction SilentlyContinue | Out-Null
            }
    }
}

Write-Host "=== Pembersihan UWP Bloatware Selesai ===" -ForegroundColor Green
