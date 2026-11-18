# win11-cleanse

Script modular dan terotomatisasi untuk pembersihan bloatware (debloat), penguatan privasi (anti-telemetri), dan optimasi performa pada **Windows 11 & Windows 10**.

Fokus utama: **Membuat Windows seringan mungkin, bebas background process yang tidak perlu, namun tetap fungsional untuk kebutuhan harian.**

> Terinspirasi dan disempurnakan dari riset setup personal [Tom4tot/Windows-11-Personal-Setup](https://github.com/Tom4tot/Windows-11-Personal-Setup).

---

## ⚡ Prinsip & Fitur Utama

- **📱 Phone Link Dipertahankan**: Aplikasi **Link to Windows / Phone Link** (`Microsoft.YourPhone` & `MicrosoftWindows.CrossDevice`) **tetap dipertahankan aktif secara default** agar sinkronisasi smartphone ke PC tetap berfungsi normal.
- **🪶 Ringan & Bebas Aplikasi Tidak Penting**:
  - Semua aplikasi pihak ketiga yang redundan atau memakan background RAM (seperti f.lux, PDF24, EarTrumpet, PowerToys, RustDesk) telah **dieliminasi**.
  - Mengandalkan fitur bawaan Windows yang sudah efisien (Night Light native, Print-to-PDF native, per-app Volume Mixer native).
  - Hanya menyisakan **7-Zip** (opsional, ~3MB tanpa background service) untuk kebutuhan arsip file.
- **🛡️ Keamanan Tetap Aktif**: **Windows Defender Real-Time Protection tetap ON dan terlindungi penuh**.
- **🧹 UWP Bloatware Debloater**: Menghapus bloatware agresif (Bing News, Bing Search, Bing Weather, Cortana, Clipchamp, Solitaire, Power Automate, DevHome, Widgets WebExperience engine, promo app).
- **🔒 Privasi & Anti-Telemetri**:
  - Mematikan service telemetri background (`DiagTrack`, `dmwappushservice`, `WSAIFabricSvc`).
  - Menonaktifkan integrasi pencarian web (Bing) dan iklan pada Start Menu.
  - Mematikan Advertising ID dan saran konten promosi (Content Delivery Manager).
- **🚀 All-in-One Runner**: Menyediakan script satu-klik `Run-Setup-As-Admin.bat` dengan auto-elevation untuk pembersihan menyeluruh di tingkat sistem (`-AllUsers` & *Provisioned Packages*).

---

## 📁 Struktur Direktori

```text
win11-cleanse/
├── Run-Setup-As-Admin.bat          # Runner satu-klik dengan elevasi Administrator otomatis
├── scripts/
│   ├── debloat-apps.ps1            # Skrip debloat UWP (Phone Link dijaga; opsi -KeepGaming & -KeepStickyNotes)
│   ├── apply-system-tweaks.ps1     # Skrip privasi & penonaktifan service telemetri
│   └── install-apps.ps1            # Skrip minimalis (hanya 7-Zip / tanpa background bloat)
├── Group Policy settings/          # Dokumentasi dan referensi template Group Policy
└── Resources/                      # File referensi tambahan
```

---

## 🚀 Cara Menjalankan

### Cara Cepat (Rekomendasi - System-wide Cleanup)
1. Clone repository ini:
   ```cmd
   git clone https://github.com/adnan207/win11-cleanse.git
   cd win11-cleanse
   ```
2. Klik kanan pada **`Run-Setup-As-Admin.bat`** dan pilih **"Run as administrator"**.
3. Konfirmasi dialog UAC. Skrip otomatis membersihkan bloatware untuk semua user, mematikan telemetri, dan me-refresh policy sistem.

---

### Cara Modular (PowerShell)

#### 1. Debloat Aplikasi
```powershell
# Jalankan debloat standar (Phone Link otomatis dipertahankan)
powershell -ExecutionPolicy Bypass -File .\scripts\debloat-apps.ps1

# Jika ingin tetap mempertahankan Xbox & Game Bar:
powershell -ExecutionPolicy Bypass -File .\scripts\debloat-apps.ps1 -KeepGaming

# Jika ingin tetap mempertahankan Sticky Notes:
powershell -ExecutionPolicy Bypass -File .\scripts\debloat-apps.ps1 -KeepStickyNotes

# Jika ingin ikut menghapus Phone Link (opsional):
powershell -ExecutionPolicy Bypass -File .\scripts\debloat-apps.ps1 -RemovePhoneLink
```

#### 2. Tweak Privasi & Servis
```powershell
powershell -ExecutionPolicy Bypass -File .\scripts\apply-system-tweaks.ps1
```

#### 3. Instalasi Utilitas Minimalis (Opsional)
```powershell
# Hanya menginstal 7-Zip (~3MB, tanpa background RAM)
powershell -ExecutionPolicy Bypass -File .\scripts\install-apps.ps1

# Tidak menginstal aplikasi apa pun (murni debloat saja)
powershell -ExecutionPolicy Bypass -File .\scripts\install-apps.ps1 -SkipAll
```

---

## 📋 Aplikasi yang Dihapus vs Dipertahankan

| Kategori | Status | Keterangan |
|---|---|---|
| **Phone Link (Link to Windows)** | ✅ **Dipertahankan** | Sinkronisasi HP dan notifikasi tetap berjalan normal |
| **Windows Defender Real-time** | ✅ **Dipertahankan** | Keamanan sistem 100% aktif |
| **Bing News / Weather / Search** | ❌ **Dihapus** | Tidak memakan bandwidth & RAM di background |
| **Widgets WebExperience Engine** | ❌ **Dihapus** | Menghemat RAM dan resource CPU |
| **Cortana / Clipchamp / Solitaire**| ❌ **Dihapus** | Bloatware non-esensial |
| **Power Automate / DevHome** | ❌ **Dihapus** | Background services dihilangkan |
| **f.lux / PDF24 / EarTrumpet** | ❌ **Dibuang** | Digantikan fitur native Windows yang lebih hemat RAM |

---

## ⚖️ Lisensi & Kredit

- Proyek ini dirilis di bawah lisensi MIT / open-source.
- Kredit untuk riset awal Group Policy: [Tom4tot/Windows-11-Personal-Setup](https://github.com/Tom4tot/Windows-11-Personal-Setup).
