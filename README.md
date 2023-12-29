# Aplikasi Trans Flutter

Aplikasi Trans Flutter adalah sebuah aplikasi manajemen transportasi yang dibangun menggunakan bahasa pemrograman Dart dan framework Flutter. Aplikasi ini menyediakan sejumlah fitur utama, termasuk login, dashboard, edit profile, riwayat, dan list perjalanan wisata. Data aplikasi disimpan menggunakan layanan Firebase, seperti Firebase Storage untuk menyimpan file, Firebase Firestore untuk database, dan Firebase Auth untuk manajemen otentikasi.

## Fitur-fitur Utama

### 1. Login
- Pengguna dapat login menggunakan akun yang telah terdaftar.
- Firebase Auth digunakan untuk manajemen otentikasi pengguna.

### 2. Dashboard
- Tampilan utama yang menyajikan informasi penting seperti statistik perjalanan dan notifikasi terkini.

### 3. Edit Profile
- Pengguna dapat mengedit informasi profil mereka, termasuk gambar profil.
- Perubahan profil disimpan dan terupdate secara langsung di Firebase Firestore.

### 4. Riwayat
- Menampilkan riwayat perjalanan pengguna dengan detail informasi seperti tanggal, rute, dan jumlah pengeluaran.

### 5. List Perjalanan Wisata
- Menampilkan daftar perjalanan wisata yang tersedia.
- Informasi perjalanan diambil dari Firebase Firestore.

## Penggunaan Firebase

Aplikasi ini memanfaatkan layanan Firebase untuk menyimpan dan mengelola data pengguna. Berikut adalah layanan Firebase yang digunakan:

### 1. Firebase Storage
- Digunakan untuk menyimpan gambar profil pengguna.

### 2. Firebase Firestore
- Menyimpan data perjalanan wisata, riwayat perjalanan, dan informasi profil pengguna.

### 3. Firebase Auth
- Menangani proses otentikasi pengguna.

## Cara Menjalankan Aplikasi

1. Pastikan Anda telah menginstal [Flutter](https://flutter.dev/docs/get-started/install) di sistem Anda.
2. Clone repositori ini ke dalam direktori lokal Anda.
   ```bash
   git clone https://github.com/username/nama-repo.git
   ```
3. Masuk ke direktori proyek.
   ```bash
   cd nama-repo
   ```
4. Jalankan perintah `flutter pub get` untuk menginstal dependensi proyek.
   ```bash
   flutter pub get
   ```
5. Konfigurasi kredensial Firebase pada file `lib/services/firebase_service.dart` dengan informasi yang diberikan oleh Firebase Console.
6. Pastikan emulator atau perangkat Anda terhubung dan jalankan aplikasi menggunakan perintah:
   ```bash
   flutter run
   ```
7. Aplikasi akan terbuka di emulator atau perangkat yang Anda pilih.

## Kontribusi

Silakan berkontribusi dengan membuat *pull request* untuk perbaikan atau peningkatan fitur. Jangan lupa untuk membuat *issue* terlebih dahulu jika ingin membahas perubahan yang signifikan.

Terima kasih telah menggunakan Aplikasi Trans Flutter!
