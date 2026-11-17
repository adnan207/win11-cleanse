# language: PowerShell, file: scripts/apply-system-tweaks.ps1, target: Windows 11
Write-Host "=== Menerapkan Privacy & System Tweaks Windows 11 ===" -ForegroundColor Cyan

# 1. Services: DiagTrack & WSAIFabricSvc
$services = @("DiagTrack", "WSAIFabricSvc", "dmwappushservice")
foreach ($svc in $services) {
    $found = Get-Service -Name $svc -ErrorAction SilentlyContinue
    if ($found) {
        Write-Host "[-] Mematikan dan menonaktifkan service: $svc" -ForegroundColor Yellow
        Stop-Service -Name $svc -Force -ErrorAction SilentlyContinue
        Set-Service -Name $svc -StartupType Disabled -ErrorAction SilentlyContinue
    } else {
        Write-Host "[v] Service tidak ditemukan / tidak aktif: $svc" -ForegroundColor DarkGray
    }
}

# 2. Registry: Web Search & Cortana in Start Menu
Write-Host "[*] Mengonfigurasi privasi Start Menu & Windows Search..." -ForegroundColor Yellow
$searchUserPath = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Search"
if (!(Test-Path $searchUserPath)) { New-Item -Path $searchUserPath -Force | Out-Null }
Set-ItemProperty -Path $searchUserPath -Name "BingSearchEnabled" -Value 0 -Type DWord -Force
Set-ItemProperty -Path $searchUserPath -Name "CortanaConsent" -Value 0 -Type DWord -Force

$searchPolicyPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Windows Search"
if (!(Test-Path $searchPolicyPath)) { New-Item -Path $searchPolicyPath -Force | Out-Null }
Set-ItemProperty -Path $searchPolicyPath -Name "DisableWebSearch" -Value 1 -Type DWord -Force
Set-ItemProperty -Path $searchPolicyPath -Name "ConnectedSearchUseWeb" -Value 0 -Type DWord -Force
Set-ItemProperty -Path $searchPolicyPath -Name "AllowCloudSearch" -Value 0 -Type DWord -Force
Set-ItemProperty -Path $searchPolicyPath -Name "AllowCortana" -Value 0 -Type DWord -Force

# 3. Registry: Advertising ID
$advPath = "HKCU:\Software\Microsoft\Windows\CurrentVersion\AdvertisingInfo"
if (!(Test-Path $advPath)) { New-Item -Path $advPath -Force | Out-Null }
Set-ItemProperty -Path $advPath -Name "Enabled" -Value 0 -Type DWord -Force

# 4. Registry: Win32 Long Paths
$fsPath = "HKLM:\SYSTEM\CurrentControlSet\Control\FileSystem"
if (Test-Path $fsPath) {
    Set-ItemProperty -Path $fsPath -Name "LongPathsEnabled" -Value 1 -Type DWord -Force
    Write-Host "[+] Win32 Long Paths diaktifkan." -ForegroundColor Green
}

# 5. Registry: Turn off Content Delivery suggestions / bloat promotions
$cdmPath = "HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager"
if (Test-Path $cdmPath) {
    Set-ItemProperty -Path $cdmPath -Name "SystemPaneSuggestionsEnabled" -Value 0 -Type DWord -Force
    Set-ItemProperty -Path $cdmPath -Name "SubscribedContent-338388Enabled" -Value 0 -Type DWord -Force
    Set-ItemProperty -Path $cdmPath -Name "SubscribedContent-338389Enabled" -Value 0 -Type DWord -Force
    Set-ItemProperty -Path $cdmPath -Name "SubscribedContent-353696Enabled" -Value 0 -Type DWord -Force
    Set-ItemProperty -Path $cdmPath -Name "SilentInstalledAppsEnabled" -Value 0 -Type DWord -Force
}

# 6. Registry: Disable Windows Error Reporting & Telemetry Collection
$dataColPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\DataCollection"
if (!(Test-Path $dataColPath)) { New-Item -Path $dataColPath -Force | Out-Null }
Set-ItemProperty -Path $dataColPath -Name "AllowTelemetry" -Value 0 -Type DWord -Force
Set-ItemProperty -Path $dataColPath -Name "DoNotShowFeedbackNotifications" -Value 1 -Type DWord -Force

Write-Host "=== Privacy & System Tweaks Selesai Diterapkan ===" -ForegroundColor Green
