# Gitgitmiko Expense - Android App

Aplikasi Android WebView untuk menampilkan website Gitgitmiko Expense (https://gitgitmiko.my.id/).

## Fitur

- WebView dengan JavaScript enabled
- Support untuk DOM Storage
- Zoom controls
- Back button navigation
- Support untuk mixed content (HTTP/HTTPS)

## Requirements

### Untuk Build:
- **Java JDK 8 atau lebih baru** (Download: https://adoptium.net/)
- **Android SDK** (Download: https://developer.android.com/studio atau Command Line Tools)
- **Koneksi Internet** (untuk download dependencies pertama kali)

### Aplikasi:
- Minimum SDK: 21 (Android 5.0 Lollipop)
- Target SDK: 34 (Android 14)

## Cara Build

### Menggunakan Android Studio

1. Buka project di Android Studio
2. Sync Gradle files
3. Build project (Build > Make Project)
4. Run aplikasi di emulator atau device

### Menggunakan Command Line (Tanpa Android Studio)

Lihat file [BUILD.md](BUILD.md) untuk instruksi lengkap atau [QUICK_START.md](QUICK_START.md) untuk panduan cepat.

**Quick Start (Windows):**
```powershell
.\gradlew.bat assembleDebug
```

**Quick Start (Linux/Mac):**
```bash
chmod +x gradlew
./gradlew assembleDebug
```

APK akan berada di: `app/build/outputs/apk/debug/app-debug.apk`

**Catatan:** 
- Saat pertama kali menjalankan `gradlew`, Gradle akan otomatis download `gradle-wrapper.jar` jika belum ada. Pastikan koneksi internet aktif.
- **Jika build error karena Java/SDK tidak ditemukan**, lihat [BUILD_STATUS.md](BUILD_STATUS.md) atau [INSTALL_GUIDE.md](INSTALL_GUIDE.md) untuk panduan install dependencies.

## ⚡ Quick Build (Setelah Dependencies Terinstall)

Jalankan script otomatis:
```powershell
.\setup-and-build.ps1
```

Script akan otomatis cek dependencies, setup, dan build aplikasi!

### 🚀 Build di GitHub (Tanpa Install Dependencies Lokal!)

**Cara termudah:** Build otomatis di GitHub Actions tanpa perlu install Java atau Android SDK!

1. **Push code ke GitHub repository** (lihat [PUSH_TO_GITHUB.md](PUSH_TO_GITHUB.md))
2. GitHub Actions akan otomatis build aplikasi
3. Download APK dari tab **Actions** > **Artifacts**

📖 **Quick Start:** Lihat [QUICK_GITHUB_BUILD.md](QUICK_GITHUB_BUILD.md)  
📚 **Dokumentasi Lengkap:** Lihat [GITHUB_ACTIONS.md](GITHUB_ACTIONS.md)  
🚀 **Cara Push:** Lihat [PUSH_TO_GITHUB.md](PUSH_TO_GITHUB.md) atau jalankan `.\push-to-github.ps1`

## Struktur Project

```
app/
├── src/
│   └── main/
│       ├── java/com/gitgitmiko/expense/
│       │   └── MainActivity.kt
│       ├── res/
│       │   ├── layout/
│       │   │   └── activity_main.xml
│       │   ├── values/
│       │   │   ├── strings.xml
│       │   │   ├── colors.xml
│       │   │   └── themes.xml
│       │   └── xml/
│       │       ├── backup_rules.xml
│       │       └── data_extraction_rules.xml
│       └── AndroidManifest.xml
└── build.gradle
```

## Catatan

- Aplikasi memerlukan permission INTERNET untuk mengakses website
- Aplikasi menggunakan `usesCleartextTraffic="true"` untuk support HTTP jika diperlukan
- WebView dikonfigurasi untuk mendukung JavaScript dan DOM Storage

# git-expenses
