# 🚀 Panduan Push ke GitHub

## Opsi 1: Install Git dan Push via Command Line

### Langkah 1: Install Git

1. **Download Git untuk Windows:**
   - Download dari: https://git-scm.com/download/win
   - Atau: https://github.com/git-for-windows/git/releases

2. **Install Git:**
   - Jalankan installer
   - Pilih default options (recommended)
   - Pastikan "Add Git to PATH" dicentang

3. **Verifikasi instalasi:**
   - Buka PowerShell baru
   - Jalankan: `git --version`

### Langkah 2: Buat Repository di GitHub

1. Buka https://github.com
2. Login ke akun GitHub
3. Klik **+** (New repository)
4. Isi:
   - Repository name: `gitgitmiko-android` (atau nama lain)
   - Description: "Gitgitmiko Expense Android App"
   - Pilih **Public** atau **Private**
   - **JANGAN** centang "Initialize with README" (karena kita sudah punya)
5. Klik **Create repository**

### Langkah 3: Push Code

Buka PowerShell di folder project dan jalankan:

```powershell
# Inisialisasi git (jika belum)
git init

# Tambahkan semua file
git add .

# Commit
git commit -m "Initial commit: Gitgitmiko Expense Android App"

# Tambahkan remote (ganti username dengan username GitHub Anda)
git remote add origin https://github.com/USERNAME/gitgitmiko-android.git

# Rename branch ke main (jika perlu)
git branch -M main

# Push ke GitHub
git push -u origin main
```

**Catatan:** Ganti `USERNAME` dengan username GitHub Anda dan `gitgitmiko-android` dengan nama repository yang Anda buat.

## Opsi 2: Menggunakan GitHub Desktop (Lebih Mudah!)

### Langkah 1: Install GitHub Desktop

1. Download dari: https://desktop.github.com/
2. Install dan login dengan akun GitHub

### Langkah 2: Publish Repository

1. Buka GitHub Desktop
2. File > Add Local Repository
3. Pilih folder project: `C:\Users\Gitgitmiko\Documents\Project\Gitgitmiko Android`
4. Klik **Publish repository**
5. Isi nama repository dan deskripsi
6. Klik **Publish Repository**

GitHub Desktop akan otomatis:
- ✅ Inisialisasi git
- ✅ Commit semua file
- ✅ Buat repository di GitHub
- ✅ Push code ke GitHub

## Opsi 3: Menggunakan GitHub Web UI (Tanpa Install Git)

Jika tidak ingin install Git, Anda bisa:

1. **Buat repository di GitHub** (seperti Opsi 1 Langkah 2)

2. **Upload file via web:**
   - Buka repository yang baru dibuat
   - Klik **uploading an existing file**
   - Drag & drop semua file dari folder project
   - Klik **Commit changes**

**Catatan:** Metode ini tidak akan trigger GitHub Actions otomatis. Lebih baik gunakan Opsi 1 atau 2.

## Setelah Push Berhasil

1. Buka repository di GitHub
2. Tab **Actions** akan otomatis build aplikasi
3. Tunggu build selesai (centang hijau ✅)
4. Download APK dari **Actions** > **Artifacts**

## Troubleshooting

### Error: "remote origin already exists"
```powershell
# Hapus remote yang lama
git remote remove origin

# Tambahkan remote baru
git remote add origin https://github.com/USERNAME/gitgitmiko-android.git
```

### Error: "Authentication failed"
- Gunakan Personal Access Token sebagai password
- Atau gunakan GitHub Desktop
- Atau setup SSH key

### Error: "Repository not found"
- Pastikan repository sudah dibuat di GitHub
- Pastikan URL repository benar
- Pastikan Anda punya akses ke repository

### Ingin update code setelah push?
```powershell
git add .
git commit -m "Update: deskripsi perubahan"
git push
```

## Quick Reference

```powershell
# Setup pertama kali
git init
git add .
git commit -m "Initial commit"
git remote add origin https://github.com/USERNAME/REPO-NAME.git
git branch -M main
git push -u origin main

# Update setelah perubahan
git add .
git commit -m "Deskripsi perubahan"
git push
```

