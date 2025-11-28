# Quick Start - Build Tanpa Android Studio

## Langkah Cepat (Windows)

### 1. Install Java JDK
- Download dari: https://adoptium.net/
- Install dan set `JAVA_HOME` environment variable

### 2. Install Android SDK (Pilih salah satu)

**Opsi A: Download Command Line Tools**
- Download dari: https://developer.android.com/studio#command-tools
- Extract dan jalankan `sdkmanager` untuk install platform tools

**Opsi B: Install Android Studio Minimal**
- Install Android Studio hanya untuk mendapatkan SDK
- Lokasi SDK biasanya: `C:\Users\YourUsername\AppData\Local\Android\Sdk`

### 3. Buat file `local.properties`

Buat file `local.properties` di root project dengan isi:

```properties
sdk.dir=C\:\\Users\\YourUsername\\AppData\\Local\\Android\\Sdk
```

Ganti `YourUsername` dengan username Windows Anda.

### 4. Build APK

Buka PowerShell atau Command Prompt di folder project, lalu jalankan:

```powershell
.\gradlew.bat assembleDebug
```

### 5. APK Siap!

APK akan berada di: `app\build\outputs\apk\debug\app-debug.apk`

Anda bisa install APK ini ke Android device dengan:
- Transfer file ke device dan install manual
- Atau gunakan: `.\gradlew.bat installDebug` (jika device terhubung via USB dengan USB debugging enabled)

## Troubleshooting Cepat

**Error: JAVA_HOME not set**
```powershell
# Set di PowerShell (sementara)
$env:JAVA_HOME = "C:\Program Files\Java\jdk-17"

# Atau set permanent via System Properties > Environment Variables
```

**Error: SDK location not found**
- Pastikan file `local.properties` ada di root project
- Pastikan path SDK benar

**Build pertama kali lambat?**
- Normal! Gradle akan download dependencies pertama kali
- Build selanjutnya akan lebih cepat

## Butuh Bantuan Lebih Detail?

Lihat file [BUILD.md](BUILD.md) untuk dokumentasi lengkap.

