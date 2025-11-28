# Script untuk membantu push code ke GitHub
# Script ini akan memandu Anda melalui proses push

Write-Host "=== Push ke GitHub ===" -ForegroundColor Cyan
Write-Host ""

# Cek apakah git terinstall
try {
    $gitVersion = git --version 2>&1
    if ($gitVersion -match "git version") {
        Write-Host "Git ditemukan: $gitVersion" -ForegroundColor Green
    }
} catch {
    Write-Host "Git tidak ditemukan!" -ForegroundColor Red
    Write-Host ""
    Write-Host "Silakan install Git terlebih dahulu:" -ForegroundColor Yellow
    Write-Host "1. Download dari: https://git-scm.com/download/win" -ForegroundColor White
    Write-Host "2. Install dengan default options" -ForegroundColor White
    Write-Host "3. Restart PowerShell dan jalankan script ini lagi" -ForegroundColor White
    Write-Host ""
    Write-Host "Atau gunakan GitHub Desktop: https://desktop.github.com/" -ForegroundColor Yellow
    exit 1
}

Write-Host ""

# Cek apakah sudah ada git repository
if (Test-Path ".git") {
    Write-Host "Git repository sudah diinisialisasi" -ForegroundColor Green
} else {
    Write-Host "Menginisialisasi git repository..." -ForegroundColor Yellow
    git init
    Write-Host "Git repository berhasil diinisialisasi" -ForegroundColor Green
}

Write-Host ""

# Cek remote
$remoteUrl = git remote get-url origin 2>$null
if ($remoteUrl) {
    Write-Host "Remote sudah ada: $remoteUrl" -ForegroundColor Green
    Write-Host ""
    $useExisting = Read-Host "Gunakan remote yang ada? (Y/n)"
    if ($useExisting -eq "n" -or $useExisting -eq "N") {
        git remote remove origin
        $remoteUrl = $null
    }
}

if (-not $remoteUrl) {
    Write-Host "Masukkan informasi repository GitHub:" -ForegroundColor Yellow
    Write-Host ""
    $username = Read-Host "Username GitHub Anda"
    $repoName = Read-Host "Nama repository (contoh: gitgitmiko-android)"
    
    if (-not $username -or -not $repoName) {
        Write-Host "Username dan nama repository harus diisi!" -ForegroundColor Red
        exit 1
    }
    
    $repoUrl = "https://github.com/$username/$repoName.git"
    Write-Host ""
    Write-Host "Menambahkan remote: $repoUrl" -ForegroundColor Yellow
    git remote add origin $repoUrl
    Write-Host "Remote berhasil ditambahkan" -ForegroundColor Green
}

Write-Host ""
Write-Host "Menambahkan semua file..." -ForegroundColor Yellow
git add .
Write-Host "File berhasil ditambahkan" -ForegroundColor Green

Write-Host ""
$commitMessage = Read-Host "Masukkan commit message (atau tekan Enter untuk default)"
if (-not $commitMessage) {
    $commitMessage = "Initial commit: Gitgitmiko Expense Android App"
}

Write-Host ""
Write-Host "Membuat commit..." -ForegroundColor Yellow
git commit -m $commitMessage
Write-Host "Commit berhasil dibuat" -ForegroundColor Green

Write-Host ""
Write-Host "Mengatur branch ke 'main'..." -ForegroundColor Yellow
git branch -M main 2>$null
Write-Host "Branch sudah diatur ke 'main'" -ForegroundColor Green

Write-Host ""
Write-Host "=== Siap untuk Push ===" -ForegroundColor Cyan
Write-Host ""
Write-Host "Repository URL: $(git remote get-url origin)" -ForegroundColor White
Write-Host ""
$confirm = Read-Host "Push ke GitHub sekarang? (Y/n)"

if ($confirm -eq "n" -or $confirm -eq "N") {
    Write-Host ""
    Write-Host "Push dibatalkan. Anda bisa push manual dengan:" -ForegroundColor Yellow
    Write-Host "  git push -u origin main" -ForegroundColor White
    exit 0
}

Write-Host ""
Write-Host "Mempush ke GitHub..." -ForegroundColor Yellow
Write-Host "(Anda mungkin diminta login GitHub)" -ForegroundColor Gray
Write-Host ""

try {
    git push -u origin main
    Write-Host ""
    Write-Host "=== PUSH BERHASIL! ===" -ForegroundColor Green
    Write-Host ""
    $repoUrl = git remote get-url origin
    $repoUrl = $repoUrl -replace '\.git$', ''
    $repoUrl = $repoUrl -replace 'https://github.com/', 'https://github.com/'
    Write-Host "Repository: $repoUrl" -ForegroundColor Cyan
    Write-Host ""
    Write-Host "Langkah selanjutnya:" -ForegroundColor Yellow
    Write-Host "1. Buka repository di GitHub" -ForegroundColor White
    Write-Host "2. Klik tab 'Actions' untuk melihat build progress" -ForegroundColor White
    Write-Host "3. Tunggu build selesai (centang hijau)" -ForegroundColor White
    Write-Host "4. Download APK dari Actions > Artifacts" -ForegroundColor White
} catch {
    Write-Host ""
    Write-Host "=== PUSH GAGAL ===" -ForegroundColor Red
    Write-Host ""
    Write-Host "Kemungkinan penyebab:" -ForegroundColor Yellow
    Write-Host "1. Repository belum dibuat di GitHub" -ForegroundColor White
    Write-Host "2. Authentication gagal (perlu login atau Personal Access Token)" -ForegroundColor White
    Write-Host "3. URL repository salah" -ForegroundColor White
    Write-Host ""
    Write-Host "Solusi:" -ForegroundColor Yellow
    Write-Host "- Buat repository di GitHub terlebih dahulu: https://github.com/new" -ForegroundColor White
    Write-Host "- Atau gunakan GitHub Desktop untuk push" -ForegroundColor White
    Write-Host "- Atau setup Personal Access Token: https://github.com/settings/tokens" -ForegroundColor White
}

