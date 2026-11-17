# language: PowerShell, file: scripts/debloat-apps.ps1, target: Windows 11
param (
    [switch]$KeepGaming = $false,
    [switch]$KeepStickyNotes = $false
)

$isAdmin = ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
if ($isAdmin) {
    Write-Host "[+] Mode Administrator terdeteksi (Full AllUsers & Provisioned Cleanup)." -ForegroundColor Green
} else {
    Write-Host "[!] Mode Standard User terdeteksi (Membersihkan aplikasi akun saat ini). Jalankan Run as Administrator untuk menghapus dari seluruh sistem." -ForegroundColor Yellow
}

$appsToRemove = @(
    "Clipchamp.Clipchamp",
    "Microsoft.549981C3F5F10",
    "Microsoft.BingNews",
    "Microsoft.BingSearch",
    "Microsoft.BingWeather",
    "Microsoft.GetHelp",
    "Microsoft.Getstarted",
    "Microsoft.MicrosoftOfficeHub",
    "Microsoft.MicrosoftSolitaireCollection",
    "Microsoft.People",
    "Microsoft.PowerAutomateDesktop",
    "Microsoft.Todos",
    "Microsoft.WindowsAlarms",
    "microsoft.windowscommunicationsapps",
    "microsoft.windowscommunicationsapp",
    "Microsoft.WindowsFeedbackHub",
    "Microsoft.WindowsMaps",
    "Microsoft.WindowsSoundRecorder",
    "Microsoft.YourPhone",
    "Microsoft.ZuneMusic",
    "Microsoft.ZuneVideo",
    "MicrosoftCorporationII.QuickAssist",
    "MicrosoftWindows.Client.WebExperience",
    "MicrosoftWindows.CrossDevice",
    "MSTeams",
    "Microsoft.Office.ActionsServer",
    "Microsoft.OfficePushNotificationUtility",
    "Microsoft.OneDriveSync",
    "Microsoft.Windows.DevHome",
    "Microsoft.Windows.Cortana",
    "Microsoft.Windows.DevHomeGitHubExtension"
)

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
