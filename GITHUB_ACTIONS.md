# Build Aplikasi dengan GitHub Actions

Anda bisa build aplikasi Android ini secara otomatis di GitHub tanpa perlu install Java atau Android SDK di komputer lokal!

## 🚀 Cara Menggunakan

### 1. Push Code ke GitHub

Jika belum punya repository GitHub:

```bash
# Inisialisasi git (jika belum)
git init

# Tambahkan remote repository
git remote add origin https://github.com/username/gitgitmiko-android.git

# Commit dan push
git add .
git commit -m "Initial commit"
git push -u origin main
```

### 2. Workflow Otomatis

Setelah code di-push, GitHub Actions akan otomatis:
- ✅ Build aplikasi saat ada push ke branch `main` atau `master`
- ✅ Build aplikasi saat ada Pull Request
- ✅ Generate APK dan simpan sebagai artifact

### 3. Download APK

Setelah build selesai:

1. Buka repository di GitHub
2. Klik tab **Actions**
3. Pilih workflow run yang berhasil (centang hijau)
4. Scroll ke bawah, cari bagian **Artifacts**
5. Download **app-debug-apk**
6. Install APK ke Android device

## 📋 Workflow yang Tersedia

### 1. Build Workflow (`build.yml`) - ⭐ Recommended untuk Development

**Trigger:**
- ✅ Otomatis saat push ke branch `main` atau `master`
- ✅ Otomatis saat ada Pull Request ke branch `main` atau `master`
- ✅ Manual trigger dari GitHub UI (Actions > Build Android APK > Run workflow)

**Output:**
- Debug APK sebagai artifact (tersedia 30 hari)

**Gunakan untuk:** Build otomatis setiap ada perubahan code

### 2. Build on Demand (`build-on-demand.yml`) - Untuk Build Manual

**Trigger:**
- ✅ Hanya manual trigger dari GitHub UI

**Output:**
- Debug APK sebagai artifact (tersedia 90 hari)

**Gunakan untuk:** Build kapan saja tanpa perlu push code

### 3. Build and Release Workflow (`build-and-release.yml`) - Untuk Production

**Trigger:**
- ✅ Otomatis saat push tag dengan format `v*` (contoh: `v1.0.0`)
- ✅ Manual trigger dari GitHub UI

**Output:**
- Debug APK sebagai artifact
- Release APK sebagai artifact
- GitHub Release dengan kedua APK (jika menggunakan tag)

**Gunakan untuk:** Membuat release resmi dengan versi tertentu

## 🏷️ Membuat Release dengan Tag

Untuk membuat release dengan APK:

```bash
# Buat tag
git tag -a v1.0.0 -m "Release version 1.0.0"

# Push tag ke GitHub
git push origin v1.0.0
```

Setelah tag di-push, workflow akan:
1. Build aplikasi
2. Membuat GitHub Release
3. Menyertakan Debug dan Release APK di release

## 🔧 Manual Trigger

Anda juga bisa trigger build manual dari GitHub UI:

1. Buka repository di GitHub
2. Klik tab **Actions**
3. Pilih workflow yang ingin dijalankan
4. Klik **Run workflow**
5. Pilih branch dan klik **Run workflow**

## 📱 Install APK dari GitHub

### Dari Artifacts:
1. Download APK dari Actions > Artifacts
2. Transfer ke Android device
3. Install APK

### Dari Release:
1. Buka tab **Releases** di repository
2. Download APK dari release terbaru
3. Install ke device

## ⚙️ Konfigurasi

### Mengubah Branch Trigger

Edit file `.github/workflows/build.yml`:

```yaml
on:
  push:
    branches: [ main, master, develop ] # Tambah branch lain
```

### Mengubah Java Version

Edit file `.github/workflows/build.yml`:

```yaml
- name: Set up JDK 17
  uses: actions/setup-java@v4
  with:
    distribution: 'temurin'
    java-version: '17' # Ubah ke '11', '21', dll
```

### Build Release APK dengan Signing

Untuk build signed release APK, tambahkan keystore sebagai GitHub Secret:

1. **Buat keystore lokal:**
   ```bash
   keytool -genkey -v -keystore gitgitmiko-release-key.jks -keyalg RSA -keysize 2048 -validity 10000 -alias gitgitmiko
   ```

2. **Encode keystore ke base64:**
   ```bash
   # Windows PowerShell
   [Convert]::ToBase64String([IO.File]::ReadAllBytes("gitgitmiko-release-key.jks"))
   ```

3. **Tambah GitHub Secrets:**
   - Buka repository > Settings > Secrets and variables > Actions
   - Tambahkan secrets:
     - `KEYSTORE_BASE64` (hasil base64 dari step 2)
     - `KEYSTORE_PASSWORD` (password keystore)
     - `KEY_ALIAS` (alias, biasanya `gitgitmiko`)
     - `KEY_PASSWORD` (password key)

4. **Update workflow** untuk menggunakan secrets (lihat contoh di bawah)

## 🔐 Contoh Workflow dengan Signing

Tambahkan step ini sebelum build release:

```yaml
- name: Setup Keystore
  run: |
    echo "${{ secrets.KEYSTORE_BASE64 }}" | base64 -d > gitgitmiko-release-key.jks
    
- name: Create keystore.properties
  run: |
    echo "storePassword=${{ secrets.KEYSTORE_PASSWORD }}" > app/keystore.properties
    echo "keyPassword=${{ secrets.KEY_PASSWORD }}" >> app/keystore.properties
    echo "keyAlias=${{ secrets.KEY_ALIAS }}" >> app/keystore.properties
    echo "storeFile=../gitgitmiko-release-key.jks" >> app/keystore.properties
```

Dan update `app/build.gradle` untuk menggunakan keystore (lihat BUILD.md untuk detail).

## 📊 Status Badge

Tambahkan badge build status ke README.md:

```markdown
![Build Status](https://github.com/username/gitgitmiko-android/workflows/Build%20Android%20APK/badge.svg)
```

## 🐛 Troubleshooting

### Build gagal: "SDK location not found"
- Pastikan workflow menggunakan `android-actions/setup-android@v3`
- Workflow sudah benar, tidak perlu `local.properties` di GitHub Actions

### Build lambat
- Normal untuk build pertama kali
- GitHub Actions menggunakan runner yang fresh setiap kali
- Cache akan membantu build selanjutnya

### APK tidak bisa di-download
- Pastikan build berhasil (centang hijau)
- Artifacts hanya tersedia selama 30 hari (default)
- Untuk permanen, gunakan GitHub Releases

## 💡 Tips

1. **Gunakan GitHub Releases** untuk distribusi APK yang lebih permanen
2. **Enable branch protection** untuk memastikan code quality
3. **Setup notifications** untuk mendapat notifikasi saat build selesai
4. **Gunakan tags** untuk versioning yang jelas

## 📚 Referensi

- [GitHub Actions Documentation](https://docs.github.com/en/actions)
- [Android Actions Setup](https://github.com/android-actions/setup-android)
- [GitHub Actions for Android](https://github.com/actions/setup-java)

