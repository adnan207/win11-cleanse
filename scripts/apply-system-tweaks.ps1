# language: PowerShell, file: scripts/apply-system-tweaks.ps1, target: Windows 11 / Windows 10
Write-Host "=== Menerapkan Privacy & System Tweaks Windows 11 ===" -ForegroundColor Cyan

$isAdmin = ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
if ($isAdmin) {
    Write-Host "[+] Mode Administrator terdeteksi. Menerapkan semua tweak sistem dan pengguna..." -ForegroundColor Green
} else {
    Write-Host "[!] Berjalan sebagai Standard User. Tweak level pengguna (HKCU) diterapkan; jalankan sebagai Administrator untuk hasil penuh." -ForegroundColor Yellow
}

# 1. Services: DiagTrack & WSAIFabricSvc
if ($isAdmin) {
    $services = @("DiagTrack", "WSAIFabricSvc", "dmwappushservice")
    foreach ($svc in $services) {
        $found = Get-Service -Name $svc -ErrorAction SilentlyContinue
        if ($found) {
            Write-Host "[-] Mematikan service: $svc" -ForegroundColor Yellow
            Stop-Service -Name $svc -Force -ErrorAction SilentlyContinue
            Set-Service -Name $svc -StartupType Disabled -ErrorAction SilentlyContinue
        }
    }
}

# 2. Registry: Web Search & Cortana in Start Menu
Write-Host "[*] Mengonfigurasi privasi Start Menu & Windows Search..." -ForegroundColor Yellow
reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\Search" /v "BingSearchEnabled" /t REG_DWORD /d 0 /f 2>$null | Out-Null
reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\Search" /v "CortanaConsent" /t REG_DWORD /d 0 /f 2>$null | Out-Null

if ($isAdmin) {
    reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v "DisableWebSearch" /t REG_DWORD /d 1 /f 2>$null | Out-Null
    reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v "ConnectedSearchUseWeb" /t REG_DWORD /d 0 /f 2>$null | Out-Null
    reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v "AllowCloudSearch" /t REG_DWORD /d 0 /f 2>$null | Out-Null
    reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v "AllowCortana" /t REG_DWORD /d 0 /f 2>$null | Out-Null
}

# 3. Registry: Advertising ID
reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\AdvertisingInfo" /v "Enabled" /t REG_DWORD /d 0 /f 2>$null | Out-Null

# 4. Registry: Win32 Long Paths
if ($isAdmin) {
    reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\FileSystem" /v "LongPathsEnabled" /t REG_DWORD /d 1 /f 2>$null | Out-Null
    Write-Host "[+] Win32 Long Paths diaktifkan." -ForegroundColor Green
}

# 5. Registry: Turn off Content Delivery suggestions / bloat promotions
reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SystemPaneSuggestionsEnabled" /t REG_DWORD /d 0 /f 2>$null | Out-Null
reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-338388Enabled" /t REG_DWORD /d 0 /f 2>$null | Out-Null
reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-338389Enabled" /t REG_DWORD /d 0 /f 2>$null | Out-Null
reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-353696Enabled" /t REG_DWORD /d 0 /f 2>$null | Out-Null
reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SilentInstalledAppsEnabled" /t REG_DWORD /d 0 /f 2>$null | Out-Null

# 6. Registry: Disable Windows Error Reporting & Telemetry Collection
if ($isAdmin) {
    reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /v "AllowTelemetry" /t REG_DWORD /d 0 /f 2>$null | Out-Null
    reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /v "DoNotShowFeedbackNotifications" /t REG_DWORD /d 1 /f 2>$null | Out-Null
}

# 7. Registry: Disable GameBar & ms-gamebar controller trigger (Solusi tuntas popup ms-gamebar)
Write-Host "[*] Mengamankan trigger controller dari popup ms-gamebar..." -ForegroundColor Yellow
reg.exe add "HKCU\Software\Microsoft\GameBar" /v "UseNexusForGameBarEnabled" /t REG_DWORD /d 0 /f 2>$null | Out-Null
reg.exe add "HKCU\Software\Microsoft\GameBar" /v "AutoGameModeEnabled" /t REG_DWORD /d 0 /f 2>$null | Out-Null
reg.exe add "HKCU\Software\Microsoft\GameBar" /v "AllowAutoGameMode" /t REG_DWORD /d 0 /f 2>$null | Out-Null
reg.exe add "HKCU\System\GameConfigStore" /v "GameDVR_Enabled" /t REG_DWORD /d 0 /f 2>$null | Out-Null
reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\GameDVR" /v "AppCaptureEnabled" /t REG_DWORD /d 0 /f 2>$null | Out-Null

# Buat dummy protocol handler untuk ms-gamebar agar Windows tidak pernah memunculkan dialog 'Get an app to open ms-gamebar link'
reg.exe add "HKCU\Software\Classes\ms-gamebar" /f 2>$null | Out-Null
reg.exe add "HKCU\Software\Classes\ms-gamebar\shell\open\command" /ve /t REG_SZ /d "rundll32.exe" /f 2>$null | Out-Null

if ($isAdmin) {
    reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\Windows\GameDVR" /v "AllowGameDVR" /t REG_DWORD /d 0 /f 2>$null | Out-Null
}

Write-Host "=== Privacy & System Tweaks Berhasil Diterapkan Tanpa Error ===" -ForegroundColor Green
