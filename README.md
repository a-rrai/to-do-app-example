# To-Do List App 📝

Aplikasi To-Do List sederhana berbasis Flutter yang dirancang dengan antarmuka yang bersih dan interaktif. Proyek ini dibuat sebagai pemenuhan tugas untuk mata kuliah **Pemrograman Perangkat Bergerak (Mobile)**.

## Deskripsi Proyek
Aplikasi ini memungkinkan pengguna untuk mengelola daftar kegiatan harian mereka. Sistem dibangun menggunakan `StatefulWidget` untuk menangani perubahan status (*state management*) secara *real-time* tanpa memerlukan *database* eksternal untuk versi dasar ini.

## Fitur Utama
*   **Create:** Menambahkan tugas baru lengkap dengan judul dan rentang waktu melalui *Bottom Sheet*.
*   **Read:** Menampilkan daftar tugas secara dinamis. Terdapat tampilan khusus (*Empty State*) jika daftar tugas masih kosong.
*   **Update:** Mengedit detail tugas (judul dan waktu) yang sudah dibuat sebelumnya.
*   **Delete:** Menghapus tugas dari daftar.
*   **Toggle Status:** Menceklis tugas yang sudah diselesaikan (teks akan dicoret secara otomatis).

## Teknologi yang Digunakan
*   **Framework:** Flutter
*   **Bahasa Pemrograman:** Dart
*   **Font:** [Outfit](https://fonts.google.com/specimen/Outfit) (Google Fonts)

## 🚀 Cara Menjalankan Aplikasi

1. Pastikan Flutter SDK sudah terpasang di komputermu.
2. *Clone* repositori ini atau unduh *source code*-nya.
3. Buka terminal di dalam folder proyek (`to_do_app`) dan jalankan perintah berikut untuk mengunduh dependensi:
   ```bash
   flutter pub get