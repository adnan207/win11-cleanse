# ⚡ win11-cleanse

<p align="center">
  <img src="https://img.shields.io/badge/Platform-Windows%2011%20%7C%20Windows%2010-0078D4?logo=windows" alt="Platform" />
  <img src="https://img.shields.io/badge/PowerShell-5.1%2B-5391FE?logo=powershell" alt="PowerShell" />
  <img src="https://img.shields.io/badge/Defender%20Protection-ACTIVE-success" alt="Defender" />
  <img src="https://img.shields.io/badge/License-MIT-blue" alt="License" />
</p>

Koleksi skrip otomatis dan modular untuk membersihkan bloatware (*debloat*), mematikan telemetri pelacakan, dan mengoptimalkan performa **Windows 11 & Windows 10**.

> **Filosofi Utama**: Membuat sistem operasi seringan dan secepat mungkin tanpa merusak fitur penting harian dan tanpa mengorbankan keamanan sistem.

---

## 🎯 Mengapa win11-cleanse Berbeda?

Sebagian besar script debloat pihak ketiga di internet terlalu agresif—mereka mematikan Windows Defender, merusak Windows Update, dan memutus integrasi smartphone. **win11-cleanse dirancang dengan pendekatan aman dan fungsional:**

1. **🛡️ Windows Defender Tetap Aktif**: Proteksi *real-time* tidak disentuh demi menjaga keamanan sistem dari malware.
2. **📱 Phone Link Tetap Berfungsi**: Aplikasi **Link to Windows / Phone Link** (`Microsoft.YourPhone` & `MicrosoftWindows.CrossDevice`) dipertahankan secara *default*.
3. **🪶 Tanpa Tambahan Bloatware Baru**: Menghindari aplikasi pihak ketiga redundan yang memakan RAM latar belakang (*background memory*). Fitur bawaan Windows dioptimalkan secara native.
4. **🔄 Aman untuk Pembaruan**: Tidak merusak integritas *Windows Update* atau komponen inti OS.

---

## 🚀 Cara Penggunaan

### 1. Cara Cepat: Runner Administrator (Direkomendasikan)
Cocok untuk clean install atau optimasi instan seluruh sistem:

1. Unduh atau clone repository ini:
   ```cmd
   git clone https://github.com/adnan207/win11-cleanse.git
   cd win11-cleanse
   ```
2. Klik kanan pada **`Run-Setup-As-Admin.bat`**, lalu pilih **"Run as administrator"**.
3. Konfirmasi dialog UAC (*User Account Control*). Skrip akan otomatis:
   - Menghapus bloatware UWP untuk semua akun pengguna (`-AllUsers`).
   - Menghapus *provisioned package* agar akun baru tidak terkena bloatware.
   - Mematikan service telemetri dan mematikan web search di Start Menu.
   - Menerapkan pembaruan kebijakan sistem (*gpupdate /force*).

---

### 2. Cara Modular (Menjalankan Per Komponen)

Anda dapat memilih modul mana saja yang ingin dieksekusi melalui terminal PowerShell:

#### A. Debloat Aplikasi UWP (`debloat-apps.ps1`)
```powershell
# Jalankan debloat standar (Phone Link otomatis aman)
powershell -ExecutionPolicy Bypass -File .\scripts\debloat-apps.ps1

# Tetap pertahankan aplikasi Xbox & Gaming Overlay:
powershell -ExecutionPolicy Bypass -File .\scripts\debloat-apps.ps1 -KeepGaming

# Tetap pertahankan aplikasi Sticky Notes:
powershell -ExecutionPolicy Bypass -File .\scripts\debloat-apps.ps1 -KeepStickyNotes

# Jika Anda juga ingin menghapus Phone Link:
powershell -ExecutionPolicy Bypass -File .\scripts\debloat-apps.ps1 -RemovePhoneLink
```

#### B. Penguatan Privasi & Service (`apply-system-tweaks.ps1`)
```powershell
powershell -ExecutionPolicy Bypass -File .\scripts\apply-system-tweaks.ps1
```
*Tindakan:*
- Mematikan service telemetri: `DiagTrack`, `dmwappushservice`, dan `WSAIFabricSvc`.
- Mematikan iklan web Bing dan Cortana di Start Menu.
- Mematikan Advertising ID dan rekomendasi promosi Microsoft.
- Mengaktifkan dukungan path file panjang (*Win32 Long Paths*).

#### C. Utilitas Esensial Minimalis (`install-apps.ps1`)
```powershell
# Hanya menginstal 7-Zip (~3MB, tanpa background RAM)
powershell -ExecutionPolicy Bypass -File .\scripts\install-apps.ps1

# Melewati instalasi (tidak memasang software tambahan)
powershell -ExecutionPolicy Bypass -File .\scripts\install-apps.ps1 -SkipAll
```

---

## 📊 Status Komponen & Aplikasi

| Komponen / Aplikasi | Status | Alasan & Keterangan |
|---|:---:|---|
| **Phone Link (Link to Windows)** | ✅ **Dipertahankan** | Sinkronisasi HP, SMS, dan notifikasi tetap berjalan normal. |
| **Windows Defender Real-time** | ✅ **Dipertahankan** | Sistem tetap aman tanpa celah keamanan. |
| **Windows Update** | ✅ **Dipertahankan** | Pembaruan sistem dan keamanan tetap dapat berjalan normal. |
| **7-Zip** (Opsional) | 📦 **Tersedia** | Pengganti native zip untuk format `.7z`, `.rar`, dsb. Ringan dan bebas service. |
| **Bing News, Weather, Search** | ❌ **Dihapus** | Menghilangkan konsumsi internet dan RAM di background. |
| **Widgets WebExperience Engine** | ❌ **Dihapus** | Menghemat ratusan MB penggunaan memori idle. |
| **Cortana, Clipchamp, Solitaire** | ❌ **Dihapus** | Bloatware promosi yang tidak esensial. |
| **Power Automate & DevHome** | ❌ **Dihapus** | Menghilangkan beban background agent yang tidak digunakan. |
| **f.lux, PDF24, EarTrumpet** | ❌ **Dieliminasi** | Digantikan fitur bawaan Windows (Night Light, Print to PDF, Volume Mixer). |

---

## ❓ FAQ & Pemecahan Masalah

<details>
<summary><b>Bagaimana jika saya tidak sengaja menghapus aplikasi dan ingin mengembalikannya?</b></summary>
<br>
Semua aplikasi UWP yang dihapus dapat diinstal ulang kapan saja secara gratis melalui <b>Microsoft Store</b> resmi.
<br><br>
Contoh untuk menginstal ulang <b>Phone Link</b>, buka jendela Run (<code>Win + R</code>) dan jalankan:
<pre>ms-windows-store://pdp/?productid=9NMPJ99VJBWV</pre>
</details>

<details>
<summary><b>Apakah skrip ini kompatibel dengan Windows 10?</b></summary>
<br>
<b>Ya.</b> Skrip debloat dan tweak registri privasi sepenuhnya kompatibel dengan Windows 10 (versi 1809 ke atas). Paket yang spesifik untuk Windows 11 akan dilewati secara otomatis tanpa menimbulkan error.
</details>

<details>
<summary><b>Apakah performa game terpengaruh?</b></summary>
<br>
Performa justru meningkat karena berkurangnya background task yang berjalan saat bermain game. Jika Anda rutin menggunakan <b>Xbox Game Bar</b> (perekaman layar / Discord sync via Game Bar), gunakan switch <code>-KeepGaming</code> saat menjalankan debloat.
</details>

---

## 📁 Struktur Direktori

```text
win11-cleanse/
├── Run-Setup-As-Admin.bat          # Runner batch satu-klik dengan elevasi Administrator otomatis
├── scripts/
│   ├── debloat-apps.ps1            # Skrip debloat aplikasi UWP
│   ├── apply-system-tweaks.ps1     # Skrip privasi, registri, dan pematian service telemetri
│   └── install-apps.ps1            # Skrip instalasi utilitas minimalis (7-Zip)
├── Group Policy settings/          # Arsip referensi Group Policy
└── Resources/                      # Dokumentasi dan referensi tambahan
```

---

## ⚖️ Lisensi & Penghargaan

- Proyek ini dilisensikan di bawah lisensi [MIT](LICENSE).
- Terinspirasi oleh dokumentasi riset setup Windows 11 oleh [Tom4tot/Windows-11-Personal-Setup](https://github.com/Tom4tot/Windows-11-Personal-Setup).
