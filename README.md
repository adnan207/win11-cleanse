# win11-cleanse

Script modular dan terotomatisasi untuk pembersihan bloatware (debloat), penguatan privasi (anti-telemetri), dan setup esensial pada **Windows 11** tanpa mengorbankan proteksi keamanan sistem.

> Diturunkan dan disempurnakan dari riset setup personal [Tom4tot/Windows-11-Personal-Setup](https://github.com/Tom4tot/Windows-11-Personal-Setup).

---

## ⚡ Fitur Utama

- **🛡️ Aman & Proteksi Terjaga**: Berbeda dengan konfigurasi ekstrem yang mematikan antivirus, `win11-cleanse` **tetap mempertahankan Windows Defender Real-Time Protection** dalam kondisi aktif.
- **🧹 UWP Bloatware Debloater**: Menghapus aplikasi bawaan yang tidak diperlukan (Bing News/Weather/Search, Cortana, Clipchamp, Solitaire, Power Automate, DevHome, Phone Link, Widgets WebExperience, overlay Xbox, dll.).
- **🔒 Privasi & Anti-Telemetri**:
  - Mematikan service telemetri latar belakang (`DiagTrack`, `dmwappushservice`, `WSAIFabricSvc`).
  - Menonaktifkan integrasi pencarian web (Bing) dan Cortana pada Start Menu.
  - Mematikan Advertising ID dan saran konten promosi (Content Delivery Manager).
- **🚀 All-in-One Runner**: Menyediakan script satu-klik `Run-Setup-As-Admin.bat` yang otomatis meminta hak Administrator (UAC elevation) untuk pembersihan tingkat sistem menyeluruh (`-AllUsers` & *Provisioned Packages*).
- **📦 Instalasi Aplikasi Opsional (Winget)**: Skrip opsional untuk memasang utilitas esensial (`7-Zip`, `PowerToys`, dll.).

---

## 📁 Struktur Direktori

```text
win11-cleanse/
├── Run-Setup-As-Admin.bat          # Runner satu-klik dengan elevasi Administrator otomatis
├── scripts/
│   ├── debloat-apps.ps1            # Skrip debloat UWP (mendukung switch -KeepGaming & -KeepStickyNotes)
│   ├── apply-system-tweaks.ps1     # Skrip tweak registri privasi dan penonaktifan service telemetri
│   └── install-apps.ps1            # Skrip instalasi software esensial via Winget
├── Group Policy settings/          # Dokumentasi dan referensi template Group Policy
└── Resources/                      # File referensi tambahan
```

---

## 🚀 Cara Menjalankan

### Cara Cepat (Rekomendasi - System-wide Cleanup)
1. Unduh atau clone repository ini:
   ```cmd
   git clone https://github.com/adnan207/win11-cleanse.git
   cd win11-cleanse
   ```
2. Klik kanan pada **`Run-Setup-As-Admin.bat`** dan pilih **"Run as administrator"**.
3. Konfirmasi dialog UAC. Skrip akan otomatis membersihkan bloatware untuk seluruh user, mematikan telemetri, dan memperbarui kebijakan sistem (`gpupdate /force`).

---

### Cara Modular (PowerShell)

Anda juga dapat menjalankan modul secara terpisah via PowerShell:

#### 1. Debloat Aplikasi
```powershell
# Jalankan debloat standar
powershell -ExecutionPolicy Bypass -File .\scripts\debloat-apps.ps1

# Jika ingin tetap mempertahankan Xbox & Game Bar:
powershell -ExecutionPolicy Bypass -File .\scripts\debloat-apps.ps1 -KeepGaming

# Jika ingin tetap mempertahankan Sticky Notes:
powershell -ExecutionPolicy Bypass -File .\scripts\debloat-apps.ps1 -KeepStickyNotes
```

#### 2. Tweak Privasi & Servis
```powershell
powershell -ExecutionPolicy Bypass -File .\scripts\apply-system-tweaks.ps1
```

#### 3. Instalasi Utilitas Esensial (Winget)
```powershell
# Memasang 7-Zip dan PowerToys
powershell -ExecutionPolicy Bypass -File .\scripts\install-apps.ps1

# Memasang paket rekomendasi lengkap (EarTrumpet, f.lux, PDF24, RustDesk)
powershell -ExecutionPolicy Bypass -File .\scripts\install-apps.ps1 -IncludeAllRecommended
```

---

## 📋 Aplikasi yang Dihapus

<details>
<summary>Klik untuk melihat daftar paket UWP yang dibersihkan</summary>

- `Clipchamp.Clipchamp`
- `Microsoft.549981C3F5F10` (Cortana)
- `Microsoft.BingNews`, `Microsoft.BingSearch`, `Microsoft.BingWeather`
- `Microsoft.GetHelp`
- `Microsoft.MicrosoftOfficeHub`
- `Microsoft.MicrosoftSolitaireCollection`
- `Microsoft.People`
- `Microsoft.PowerAutomateDesktop`
- `Microsoft.Todos`
- `Microsoft.WindowsAlarms`
- `Microsoft.WindowsFeedbackHub`
- `Microsoft.WindowsMaps`
- `Microsoft.WindowsSoundRecorder`
- `Microsoft.YourPhone` (Phone Link)
- `Microsoft.ZuneMusic` & `Microsoft.ZuneVideo`
- `MicrosoftCorporationII.QuickAssist`
- `MicrosoftWindows.Client.WebExperience` (Widgets board)
- `MicrosoftWindows.CrossDevice`
- `MSTeams`
- `Microsoft.OneDriveSync`
- `Microsoft.Windows.DevHome`
- `Microsoft.GamingApp` & Xbox Overlays *(opsional via flag)*
- `Microsoft.MicrosoftStickyNotes` *(opsional via flag)*

</details>

---

## ⚖️ Lisensi & Kredit

- Proyek ini dirilis di bawah lisensi MIT / open-source.
- Kredit untuk kurasi awal pengaturan Group Policy: [Tom4tot/Windows-11-Personal-Setup](https://github.com/Tom4tot/Windows-11-Personal-Setup).
