# Script Setup dan Build untuk Gitgitmiko Expense Android App
# Script ini akan membantu setup environment dan build aplikasi

Write-Host "=== Setup dan Build Gitgitmiko Expense ===" -ForegroundColor Cyan
Write-Host ""

# Fungsi untuk cek Java
function Test-Java {
    try {
        $javaVersion = java -version 2>&1 | Select-Object -First 1
        if ($javaVersion -match "version") {
            Write-Host "Java ditemukan" -ForegroundColor Green
            java -version
            return $true
        }
    } catch {
        return $false
    }
    return $false
}

# Fungsi untuk cek Android SDK
function Test-AndroidSDK {
    $commonPaths = @(
        "$env:USERPROFILE\AppData\Local\Android\Sdk",
        "$env:LOCALAPPDATA\Android\Sdk",
        "C:\Android\Sdk"
    )
    
    foreach ($path in $commonPaths) {
        if (Test-Path $path) {
            Write-Host "Android SDK ditemukan di: $path" -ForegroundColor Green
            return $path
        }
    }
    return $null
}

# Cek Java
Write-Host "1. Mengecek Java..." -ForegroundColor Yellow
$hasJava = Test-Java

if (-not $hasJava) {
    Write-Host "Java tidak ditemukan!" -ForegroundColor Red
    Write-Host ""
    Write-Host "Silakan install Java JDK terlebih dahulu:" -ForegroundColor Yellow
    Write-Host "1. Download dari: https://adoptium.net/" -ForegroundColor White
    Write-Host "2. Install Java JDK (pilih versi 8 atau lebih baru)" -ForegroundColor White
    Write-Host "3. Set environment variable JAVA_HOME:" -ForegroundColor White
    Write-Host "   - Buka System Properties > Environment Variables" -ForegroundColor White
    Write-Host "   - Tambahkan JAVA_HOME = C:\Program Files\Eclipse Adoptium\jdk-XX.X.X-hotspot" -ForegroundColor White
    Write-Host "   - Tambahkan %JAVA_HOME%\bin ke PATH" -ForegroundColor White
    Write-Host ""
    Write-Host "Atau jika Java sudah terinstall, set JAVA_HOME secara manual:" -ForegroundColor Yellow
    Write-Host '  $env:JAVA_HOME = "C:\Program Files\Java\jdk-XX"' -ForegroundColor White
    Write-Host ""
    exit 1
}

# Cek Android SDK
Write-Host ""
Write-Host "2. Mengecek Android SDK..." -ForegroundColor Yellow
$sdkPath = Test-AndroidSDK

if (-not $sdkPath) {
    Write-Host "Android SDK tidak ditemukan!" -ForegroundColor Red
    Write-Host ""
    Write-Host "Silakan install Android SDK:" -ForegroundColor Yellow
    Write-Host "1. Download Android Studio dari: https://developer.android.com/studio" -ForegroundColor White
    Write-Host "2. Install Android Studio (minimal untuk mendapatkan SDK)" -ForegroundColor White
    Write-Host "3. Atau download Command Line Tools dari: https://developer.android.com/studio#command-tools" -ForegroundColor White
    Write-Host ""
    Write-Host "Setelah SDK terinstall, edit file local.properties dan set:" -ForegroundColor Yellow
    Write-Host "  sdk.dir=C\:\\Users\\YourUsername\\AppData\\Local\\Android\\Sdk" -ForegroundColor White
    Write-Host ""
    exit 1
}

# Update local.properties
Write-Host ""
Write-Host "3. Mengupdate local.properties..." -ForegroundColor Yellow
$sdkPathEscaped = $sdkPath -replace '\\', '\\'
$localPropsContent = "sdk.dir=$sdkPathEscaped"
Set-Content -Path "local.properties" -Value $localPropsContent -Force
Write-Host "local.properties telah diupdate" -ForegroundColor Green

# Build aplikasi
Write-Host ""
Write-Host "4. Membuild aplikasi..." -ForegroundColor Yellow
Write-Host "   (Ini mungkin memakan waktu beberapa menit pertama kali)" -ForegroundColor Gray
Write-Host ""

try {
    .\gradlew.bat assembleDebug --no-daemon
    if ($LASTEXITCODE -eq 0) {
        Write-Host ""
        Write-Host "=== BUILD BERHASIL! ===" -ForegroundColor Green
        Write-Host ""
        $apkPath = "app\build\outputs\apk\debug\app-debug.apk"
        if (Test-Path $apkPath) {
            $apkSize = (Get-Item $apkPath).Length / 1MB
            Write-Host "APK berhasil dibuat:" -ForegroundColor Green
            Write-Host "  Lokasi: $apkPath" -ForegroundColor White
            Write-Host "  Ukuran: $([math]::Round($apkSize, 2)) MB" -ForegroundColor White
            Write-Host ""
            Write-Host "Cara install ke Android device:" -ForegroundColor Cyan
            Write-Host "1. Transfer file APK ke Android device (via USB, email, atau cloud)" -ForegroundColor White
            Write-Host "2. Buka file APK di device dan install" -ForegroundColor White
            Write-Host "3. Atau gunakan: .\gradlew.bat installDebug (jika device terhubung via USB dengan USB debugging enabled)" -ForegroundColor White
        }
    } else {
        Write-Host ""
        Write-Host "=== BUILD GAGAL ===" -ForegroundColor Red
        Write-Host "Silakan cek error di atas untuk detail" -ForegroundColor Yellow
        exit 1
    }
} catch {
    Write-Host ""
    Write-Host "Error saat build: $_" -ForegroundColor Red
    exit 1
}

