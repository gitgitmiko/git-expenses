# 🚀 Quick Start: Build di GitHub

Cara termudah build aplikasi tanpa install dependencies di komputer lokal!

## Langkah 1: Push ke GitHub

```bash
# Jika belum ada git repository
git init
git add .
git commit -m "Initial commit"

# Buat repository di GitHub, lalu:
git remote add origin https://github.com/username/gitgitmiko-android.git
git branch -M main
git push -u origin main
```

## Langkah 2: Tunggu Build Otomatis

Setelah push, GitHub Actions akan otomatis build aplikasi. Lihat progress di:
- Tab **Actions** di repository GitHub
- Tunggu sampai ada centang hijau ✅

## Langkah 3: Download APK

1. Buka tab **Actions**
2. Klik workflow run yang berhasil (centang hijau)
3. Scroll ke bawah, cari **Artifacts**
4. Download **app-debug-apk**
5. Install ke Android device

## 🎯 Build Manual (Kapan Saja)

Jika ingin build tanpa push code:

1. Buka repository di GitHub
2. Klik tab **Actions**
3. Pilih **Build APK on Demand** (atau workflow lain)
4. Klik **Run workflow**
5. Pilih branch dan klik **Run workflow**
6. Tunggu build selesai
7. Download APK dari Artifacts

## 📦 Membuat Release

Untuk membuat release dengan tag:

```bash
git tag -a v1.0.0 -m "Release version 1.0.0"
git push origin v1.0.0
```

GitHub akan otomatis:
- Build aplikasi
- Membuat GitHub Release
- Menyertakan APK di release

## ✅ Keuntungan Build di GitHub

- ✅ **Tidak perlu install Java** di komputer lokal
- ✅ **Tidak perlu install Android SDK** di komputer lokal
- ✅ **Build otomatis** setiap ada perubahan
- ✅ **APK tersedia** untuk di-download kapan saja
- ✅ **Build konsisten** di environment yang sama
- ✅ **Gratis** untuk repository public

## 🆘 Butuh Bantuan?

Lihat [GITHUB_ACTIONS.md](GITHUB_ACTIONS.md) untuk dokumentasi lengkap.

