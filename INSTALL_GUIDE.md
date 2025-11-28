# Panduan Install Dependencies dan Build

Jika build gagal karena Java atau Android SDK tidak ditemukan, ikuti panduan ini:

## 1. Install Java JDK

### Opsi A: Menggunakan Adoptium (Recommended)

1. Download Java JDK dari: https://adoptium.net/
2. Pilih versi **JDK 17** atau **JDK 21** (LTS)
3. Install dengan default settings
4. Set Environment Variables:
   - Buka **System Properties** > **Environment Variables**
   - Klik **New** di System Variables
   - Variable name: `JAVA_HOME`
   - Variable value: `C:\Program Files\Eclipse Adoptium\jdk-17.0.X-hotspot` (sesuaikan dengan versi yang diinstall)
   - Edit variable **Path** dan tambahkan: `%JAVA_HOME%\bin`
   - Klik **OK** untuk semua dialog

5. Verifikasi:
   ```powershell
   java -version
   javac -version
   ```

### Opsi B: Menggunakan Oracle JDK

1. Download dari: https://www.oracle.com/java/technologies/downloads/
2. Install dan set JAVA_HOME seperti di atas

## 2. Install Android SDK

### Opsi A: Install Android Studio (Paling Mudah)

1. Download Android Studio dari: https://developer.android.com/studio
2. Install dengan default settings
3. Buka Android Studio dan ikuti setup wizard
4. SDK akan terinstall di: `C:\Users\YourUsername\AppData\Local\Android\Sdk`

### Opsi B: Command Line Tools (Lebih Ringan)

1. Download dari: https://developer.android.com/studio#command-tools
2. Extract ke folder, misalnya: `C:\Android\sdk`
3. Buka PowerShell sebagai Administrator
4. Install SDK Platform:
   ```powershell
   cd C:\Android\sdk\cmdline-tools\bin
   .\sdkmanager "platform-tools" "platforms;android-34" "build-tools;34.0.0"
   ```

## 3. Setup local.properties

Setelah Android SDK terinstall, buat atau edit file `local.properties` di root project:

**Windows:**
```properties
sdk.dir=C\:\\Users\\YourUsername\\AppData\\Local\\Android\\Sdk
```

**Catatan:** Ganti `YourUsername` dengan username Windows Anda.

## 4. Build Aplikasi

### Menggunakan Script Otomatis (Recommended)

Jalankan script PowerShell:
```powershell
.\setup-and-build.ps1
```

Script ini akan:
- Cek Java dan Android SDK
- Setup local.properties otomatis
- Build aplikasi
- Menampilkan lokasi APK

### Manual Build

```powershell
.\gradlew.bat assembleDebug
```

APK akan berada di: `app\build\outputs\apk\debug\app-debug.apk`

## 5. Install APK ke Device

### Opsi A: Transfer Manual

1. Copy file `app-debug.apk` ke Android device (via USB, email, atau cloud storage)
2. Buka file APK di device
3. Izinkan install dari sumber tidak dikenal jika diminta
4. Install aplikasi

### Opsi B: Install via ADB (USB Debugging)

1. Aktifkan **USB Debugging** di Android device:
   - Settings > About Phone > Tap "Build Number" 7 kali
   - Settings > Developer Options > Enable "USB Debugging"

2. Hubungkan device ke PC via USB
3. Verifikasi device terdeteksi:
   ```powershell
   adb devices
   ```

4. Install APK:
   ```powershell
   .\gradlew.bat installDebug
   ```
   Atau:
   ```powershell
   adb install app\build\outputs\apk\debug\app-debug.apk
   ```

## Troubleshooting

### Error: JAVA_HOME is not set

**Solusi:**
```powershell
# Set sementara di PowerShell
$env:JAVA_HOME = "C:\Program Files\Eclipse Adoptium\jdk-17.0.X-hotspot"

# Atau set permanent via System Properties > Environment Variables
```

### Error: SDK location not found

**Solusi:**
1. Pastikan file `local.properties` ada di root project
2. Pastikan path SDK benar (gunakan backslash ganda: `\\`)
3. Contoh: `sdk.dir=C\:\\Users\\Gitgitmiko\\AppData\\Local\\Android\\Sdk`

### Error: Gradle daemon tidak bisa start

**Solusi:**
```powershell
.\gradlew.bat --stop
.\gradlew.bat assembleDebug
```

### Build lambat pertama kali

**Normal!** Gradle akan download dependencies pertama kali. Build selanjutnya akan lebih cepat.

### APK tidak bisa diinstall: "App not installed"

**Kemungkinan penyebab:**
- Device tidak mengizinkan install dari sumber tidak dikenal
- APK corrupt (build ulang)
- Konflik dengan aplikasi yang sudah terinstall (uninstall dulu)

**Solusi:**
- Settings > Security > Enable "Install from unknown sources"
- Build ulang: `.\gradlew.bat clean assembleDebug`

