# Cara Build Project Tanpa Android Studio

Dokumen ini menjelaskan cara build aplikasi Android ini menggunakan command line tanpa Android Studio.

## Requirements

Sebelum memulai, pastikan Anda telah menginstall:

1. **Java Development Kit (JDK) 8 atau lebih baru**
   - Download dari: https://adoptium.net/ atau https://www.oracle.com/java/technologies/downloads/
   - Set environment variable `JAVA_HOME` ke lokasi JDK
   - Pastikan `java` dan `javac` ada di PATH

2. **Android SDK Command Line Tools** (opsional, untuk membuat APK signed)
   - Download dari: https://developer.android.com/studio#command-tools
   - Atau gunakan Android SDK yang sudah ada

## Cara Verifikasi Setup

### 1. Cek Java Installation
```bash
java -version
javac -version
```

### 2. Cek JAVA_HOME (Windows)
```powershell
echo %JAVA_HOME%
```

### 3. Cek JAVA_HOME (Linux/Mac)
```bash
echo $JAVA_HOME
```

## Build Menggunakan Gradle Wrapper

### Windows (PowerShell atau Command Prompt)

1. **Buka terminal di folder project**
   ```powershell
   cd "C:\Users\Gitgitmiko\Documents\Project\Gitgitmiko Android"
   ```

2. **Build Debug APK**
   ```powershell
   .\gradlew.bat assembleDebug
   ```

3. **Build Release APK** (tanpa signing)
   ```powershell
   .\gradlew.bat assembleRelease
   ```

4. **Install ke device** (jika device terhubung via USB dengan USB debugging enabled)
   ```powershell
   .\gradlew.bat installDebug
   ```

### Linux/Mac

1. **Buka terminal di folder project**
   ```bash
   cd "/path/to/Gitgitmiko Android"
   ```

2. **Beri permission execute pada gradlew**
   ```bash
   chmod +x gradlew
   ```

3. **Build Debug APK**
   ```bash
   ./gradlew assembleDebug
   ```

4. **Build Release APK**
   ```bash
   ./gradlew assembleRelease
   ```

5. **Install ke device**
   ```bash
   ./gradlew installDebug
   ```

## Lokasi APK yang Dihasilkan

Setelah build berhasil, APK akan berada di:
- **Debug APK**: `app/build/outputs/apk/debug/app-debug.apk`
- **Release APK**: `app/build/outputs/apk/release/app-release.apk`

## Build Release APK dengan Signing

Untuk membuat APK yang bisa di-publish, Anda perlu menandatangani APK:

### 1. Buat Keystore

```bash
keytool -genkey -v -keystore gitgitmiko-release-key.jks -keyalg RSA -keysize 2048 -validity 10000 -alias gitgitmiko
```

### 2. Buat file `keystore.properties` di folder `app/`

```properties
storePassword=your_store_password
keyPassword=your_key_password
keyAlias=gitgitmiko
storeFile=../gitgitmiko-release-key.jks
```

### 3. Update `app/build.gradle`

Tambahkan sebelum `android {`:

```gradle
def keystorePropertiesFile = rootProject.file("keystore.properties")
def keystoreProperties = new Properties()
if (keystorePropertiesFile.exists()) {
    keystoreProperties.load(new FileInputStream(keystorePropertiesFile))
}
```

Dan tambahkan di dalam `android {`, sebelum `buildTypes`:

```gradle
signingConfigs {
    release {
        if (keystorePropertiesFile.exists()) {
            keyAlias keystoreProperties['keyAlias']
            keyPassword keystoreProperties['keyPassword']
            storeFile file(keystoreProperties['storeFile'])
            storePassword keystoreProperties['storePassword']
        }
    }
}
```

Dan update `buildTypes.release`:

```gradle
buildTypes {
    release {
        minifyEnabled false
        proguardFiles getDefaultProguardFile('proguard-android-optimize.txt'), 'proguard-rules.pro'
        signingConfig signingConfigs.release
    }
}
```

### 4. Build Signed Release APK

```powershell
.\gradlew.bat assembleRelease
```

## Troubleshooting

### Error: JAVA_HOME is not set
- Set environment variable `JAVA_HOME` ke lokasi JDK
- Windows: System Properties > Environment Variables
- Tambahkan `%JAVA_HOME%\bin` ke PATH

### Error: Gradle daemon tidak bisa start
- Coba: `.\gradlew.bat --stop` (Windows) atau `./gradlew --stop` (Linux/Mac)
- Lalu build lagi

### Error: SDK location not found
- Buat file `local.properties` di root project
- Tambahkan: `sdk.dir=C:\\Users\\YourUsername\\AppData\\Local\\Android\\Sdk` (Windows)
- Atau: `sdk.dir=/Users/YourUsername/Library/Android/sdk` (Mac)
- Atau: `sdk.dir=/home/YourUsername/Android/Sdk` (Linux)

### Build lambat pertama kali
- Normal, karena Gradle akan download dependencies pertama kali
- Build selanjutnya akan lebih cepat

## Command Lainnya

- **Clean build**: `.\gradlew.bat clean` (Windows) atau `./gradlew clean` (Linux/Mac)
- **Build semua variant**: `.\gradlew.bat build`
- **Cek dependencies**: `.\gradlew.bat dependencies`
- **Stop Gradle daemon**: `.\gradlew.bat --stop`

