# ⚡ win11-cleanse

<p align="center">
  <img src="https://img.shields.io/badge/Platform-Windows%2011%20%7C%20Windows%2010-0078D4?logo=windows" alt="Platform" />
  <img src="https://img.shields.io/badge/PowerShell-5.1%2B-5391FE?logo=powershell" alt="PowerShell" />
  <img src="https://img.shields.io/badge/Defender%20Protection-ACTIVE-success" alt="Defender" />
  <img src="https://img.shields.io/badge/License-MIT-blue" alt="License" />
</p>

Koleksi skrip otomatis dan modular untuk membersihkan bloatware (*debloat*), mematikan telemetri pelacakan, dan mengoptimalkan performa **Windows 11 & Windows 10**.

> **Filosofi Utama**: Membuat Windows seringan, sebersih, dan secepat mungkin tanpa merusak fitur esensial harian dan tanpa mematikan keamanan sistem.

---

## 🎯 Mengapa win11-cleanse?

Banyak script debloat di internet terlalu agresif—mereka mematikan Windows Defender, merusak Windows Update, dan memutus koneksi smartphone. **win11-cleanse mengambil pendekatan yang aman, seimbang, dan fungsional:**

- 🛡️ **Windows Defender Tetap Aktif**: Proteksi *real-time* tidak dimatikan agar PC Anda tetap terlindungi dari virus dan malware.
- 📱 **Phone Link Tetap Berfungsi**: Aplikasi **Link to Windows / Phone Link** tetap aman dan aktif secara default untuk sinkronisasi HP Anda.
- 🪶 **Tanpa Aplikasi Tambahan yang Membebani**: Tidak memasang background tools yang berat. Fitur native Windows (Night Light, Volume Mixer, Print-to-PDF) dimaksimalkan.
- 🔄 **Windows Update 100% Normal**: Sistem tetap menerima update keamanan berkala tanpa kendala.

---

## 📖 Panduan Menjalankan (Paling Mudah)

Pilih salah satu metode di bawah ini yang paling nyaman untuk Anda:

### 🟢 Metode 1: Download Langsung (Untuk Semua Pengguna / Pemula)

Tidak perlu menginstall Git, cukup ikuti 5 langkah mudah ini:

1. **Unduh ZIP Repository**  
   Klik link download langsung ini: 👉 [**Download win11-cleanse.zip**](https://github.com/adnan207/win11-cleanse/archive/refs/heads/main.zip)  
   *(atau klik tombol hijau **Code** di atas halaman GitHub lalu pilih **Download ZIP**)*.

2. **Ekstrak File ZIP**  
   - Buka folder `Downloads`, cari file `win11-cleanse-main.zip`.  
   - Klik kanan pada file tersebut, pilih **Extract All...** (Ekstrak Semua), lalu klik **Extract**.

3. **Jalankan sebagai Administrator**  
   - Buka folder hasil ekstrak (`win11-cleanse-main`).  
   - Cari file bernama **`Run-Setup-As-Admin.bat`**.  
   - **Klik kanan** pada file tersebut, lalu pilih **"Run as administrator"** *(Jalankan sebagai administrator)*.

4. **Konfirmasi Izin (UAC)**  
   - Saat muncul dialog konfirmasi Windows (*"Do you want to allow this app to make changes to your device?"*), klik **Yes**.

5. **Tunggu Hingga Selesai**  
   - Jendela terminal akan otomatis bekerja membersihkan bloatware, mematikan service pelacak, dan mengoptimalkan sistem.  
   - Saat muncul pesan **`Selesai! Silakan restart PC Anda untuk hasil optimal`**, tekan tombol keyboard apa saja untuk menutup jendela.  
   - **Restart PC Anda** untuk menikmati Windows yang jauh lebih ringan dan responsif!

---

### 💻 Metode 2: Lewat Git / Terminal (Untuk Power User & Developer)

Jika Anda sudah memiliki Git terpasang di komputer:

```cmd
git clone https://github.com/adnan207/win11-cleanse.git
cd win11-cleanse
```
Lalu jalankan runner dengan hak administrator:
```cmd
Run-Setup-As-Admin.bat
```

---

### ⚙️ Metode 3: Menjalankan Per Modul (Opsional)

Jika Anda hanya ingin menjalankan langkah tertentu melalui PowerShell:

#### 1. Debloat Aplikasi UWP Saja (`debloat-apps.ps1`)
```powershell
# Jalankan debloat standar (Phone Link otomatis aman)
powershell -ExecutionPolicy Bypass -File .\scripts\debloat-apps.ps1

# Jika ingin tetap mempertahankan Xbox & Game Bar:
powershell -ExecutionPolicy Bypass -File .\scripts\debloat-apps.ps1 -KeepGaming

# Jika ingin tetap mempertahankan Sticky Notes:
powershell -ExecutionPolicy Bypass -File .\scripts\debloat-apps.ps1 -KeepStickyNotes

# Jika Anda juga ingin menghapus Phone Link:
powershell -ExecutionPolicy Bypass -File .\scripts\debloat-apps.ps1 -RemovePhoneLink
```

#### 2. Tweak Privasi & Service Latar Belakang (`apply-system-tweaks.ps1`)
```powershell
powershell -ExecutionPolicy Bypass -File .\scripts\apply-system-tweaks.ps1
```
*Tindakan:*
- Mematikan service pelacak: `DiagTrack`, `dmwappushservice`, dan `WSAIFabricSvc`.
- Mematikan iklan web Bing dan Cortana di Start Menu (pencarian Start Menu jadi instan & lokal).
- Mematikan Advertising ID dan rekomendasi promosi Windows.
- Mengaktifkan *Win32 Long Paths*.

#### 3. Instalasi 7-Zip Minimalis (`install-apps.ps1`)
```powershell
# Memasang utilitas arsip 7-Zip (~3MB, tanpa background RAM)
powershell -ExecutionPolicy Bypass -File .\scripts\install-apps.ps1
```

---

## 📊 Status Komponen & Aplikasi

| Komponen / Aplikasi | Status | Alasan & Keterangan |
|---|:---:|---|
| **Phone Link (Link to Windows)** | ✅ **Dipertahankan** | Sinkronisasi HP, SMS, dan notifikasi tetap berjalan normal. |
| **Windows Defender Real-time** | ✅ **Dipertahankan** | Sistem tetap aman tanpa celah keamanan. |
| **Windows Update** | ✅ **Dipertahankan** | Pembaruan sistem dan keamanan tetap dapat berjalan normal. |
| **7-Zip** (Opsional) | 📦 **Tersedia** | Pengganti native zip untuk format `.7z`, `.rar`, dsb. Ringan dan bebas background service. |
| **Bing News, Weather, Search** | ❌ **Dihapus** | Menghilangkan konsumsi internet dan RAM di background. |
| **Widgets WebExperience Engine** | ❌ **Dihapus** | Menghemat ratusan MB penggunaan memori idle. |
| **Cortana, Clipchamp, Solitaire** | ❌ **Dihapus** | Bloatware promosi yang tidak esensial. |
| **Power Automate & DevHome** | ❌ **Dihapus** | Menghilangkan beban background agent yang tidak digunakan. |
| **f.lux, PDF24, EarTrumpet** | ❌ **Dieliminasi** | Digantikan fitur bawaan Windows yang jauh lebih hemat RAM. |

---

## ❓ FAQ & Tanya Jawab

<details>
<summary><b>Apakah menjalankan Run-Setup-As-Admin.bat sudah mencakup semua optimasi?</b></summary>
<br>
<b>Ya, semuanya langsung berjalan berurutan.</b> Skrip tersebut otomatis meminta hak Administrator, menerapkan tweak privasi/service telemetri, membersihkan seluruh bloatware UWP untuk semua akun di PC, dan me-refresh kebijakan sistem (<code>gpupdate /force</code>). Anda tidak perlu menjalankan skrip satu per satu lagi.
</details>

<details>
<summary><b>Bagaimana jika saya tidak sengaja ingin mengembalikan aplikasi yang terhapus?</b></summary>
<br>
Semua aplikasi UWP yang dihapus dapat dipasang kembali kapan saja dengan mudah melalui <b>Microsoft Store</b> resmi.
<br><br>
Contoh untuk menginstal ulang <b>Phone Link</b>, cukup tekan <code>Win + R</code>, lalu ketik dan tekan Enter:
<pre>ms-windows-store://pdp/?productid=9NMPJ99VJBWV</pre>
</details>

<details>
<summary><b>Apakah skrip ini bisa digunakan di Windows 10?</b></summary>
<br>
<b>Bisa.</b> Skrip debloat dan tweak registri privasi sepenuhnya kompatibel dengan Windows 10 (versi 1809 ke atas). Paket yang spesifik untuk Windows 11 akan dilewati secara otomatis tanpa menimbulkan error.
</details>

<details>
<summary><b>Apakah aman untuk bermain game?</b></summary>
<br>
Sangat aman dan performa PC justru menjadi lebih stabil karena berkurangnya proses latar belakang. Jika Anda sering menggunakan fitur perekaman layar atau party chat bawaan <b>Xbox Game Bar</b>, gunakan parameter <code>-KeepGaming</code> saat menjalankan debloat.
</details>

---

## 📁 Struktur Direktori

```text
win11-cleanse/
├── Run-Setup-As-Admin.bat          # Runner satu-klik otomatis (Metode Utama)
├── scripts/
│   ├── debloat-apps.ps1            # Skrip pembersih bloatware UWP
│   ├── apply-system-tweaks.ps1     # Skrip privasi, registri, dan servis telemetri
│   └── install-apps.ps1            # Skrip utilitas esensial 7-Zip
├── Group Policy settings/          # Dokumentasi dan referensi template Group Policy
└── Resources/                      # File referensi tambahan
```

---

## ⚖️ Lisensi & Penghargaan

- Proyek ini dirilis di bawah lisensi [MIT](LICENSE).
- Terinspirasi oleh dokumentasi riset setup Windows 11 oleh [Tom4tot/Windows-11-Personal-Setup](https://github.com/Tom4tot/Windows-11-Personal-Setup).
