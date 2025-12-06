# Aplikasi Inventaris Buku Flutter 

Nama: Fauzia Azahra Depriani  
NIM: H1D023117  
Shift Lama: D  
Shift Baru: F  

---

## 🛠️ Framework & Tools

- **Flutter** → Frontend mobile app  
- **CodeIgniter 4** → Backend REST API  
- **MySQL** → Database  
- **Postman** → Testing API  
- **Laragon** → Local development environment  

---

## ⚙️ Penjelasan Kode

1. `main.dart`
   - `MyApp` menggunakan `MaterialApp` untuk mengatur tema, navigasi, dan halaman awal (`LoginPage`).  
   - Aplikasi akan mengarahkan user ke halaman login. Jika belum memiliki akun, user bisa menekan tombol register.  

---

2. Halaman Login (`login_page.dart`)
   - Input email & password menggunakan `TextEditingController`.  
   - Validasi:
     - Email tidak boleh kosong.  
     - Password tidak boleh kosong.  
   - Saat login, memanggil `LoginBloc.login(...)` untuk request ke API.  
   - Jika berhasil: simpan token & userID di local storage lalu diarahkan ke `ProdukPage`.  
   - Jika gagal akan ditampilkan `WarningDialog`.  

---

3. Halaman Registrasi (`registrasi_page.dart`)
   - Digunakan untuk mendaftar user baru.  
   - Validasi input:
     - Nama minimal 3 karakter.  
     - Email sesuai format.  
     - Password minimal 6 karakter & konfirmasi harus sama.  
   - Fungsi `_submit()` memanggil `RegistrasiBloc.registrasi()`.  
   - Jika berhasil: tampilkan `SuccessDialog` dan akan diarahkan ke halaman login.  
   - Jika gagal akan ditampilkan `WarningDialog`.  

---

4. Halaman Produk (`produk_page.dart`)
   - Menampilkan daftar buku dari API (`ProdukBloc.getProduks()`).  
   - Setiap item buku pakai widget `ItemProduk`.
   - Ketika item diklik akan diarahkan ke `ProdukDetail`.  
   - FloatingActionButton di kanan bawah halaman digunakan untuk menambah buku baru. Jika diklik makan akan diarahkan ke `ProdukForm`.  
   
   Terdapat **Drawer Menu** pada halaman ini:
   - Daftar Buku untuk kembali ke halaman `ProdukPage`.  
   - Tambah Buku untuk membuka `ProdukForm`.  
   - Tentang Aplikasi untuk menampilkan modal bottom sheet yang berisi penjelasan singkat tentang aplikasi ini.  
   - Logout dengan `LogoutBloc.logout()` untuk kembali ke halaman login.  

---

5. Produk Form (`produk_form.dart`)
   - Digunakan untuk menambah atau mengubah buku.  
   - `initState()` memanggil `isUpdate()`, lalu akan menentukan mode tambah atau edit.  
   - Validasi input:
     - Judul harus diisi.  
     - Harga harus diisi.  
     - Jumlah harus diisi.
     - Tanggal Masuk harus diisi.  
     - Volume harus diisi.  
     - Penulis harus diisi.
     - Penerbit harus diisi.  
   - Tombol Simpan/Ubah menyesuaikan mode form:  
     ```dart
     if (widget.produk != null) {
       ubah();
     } else {
       simpan();
     }
     ```
   - Fungsi `simpan()` / `ubah()` akan memanggil `ProdukBloc` lalu kembali ke `ProdukPage` jika berhasil, tetapi akan menampilkan `WarningDialog` jika gagal.  

---

6. Produk Detail (`produk_detail.dart`)
   - Menampilkan detail buku di tengah halaman (`Center` + `Column`).  
   - Tombol Edit membuka halaman `ProdukForm` dengan data buku terisi.  
   - Jika menekan tombol delete, maka akan muncul popup konfirmasi hapus:
     - Jika "Ya" dilakukan penghapusan denganm memanggil `ProdukBloc.deleteProduk(id)` lalu kembali ke `ProdukPage`.  
     - Jika Batal, maka dialog akan ditutup.  

---

## 🎥 Demo Aplikasi
https://github.com/user-attachments/assets/ff568c86-8f39-4bad-8a90-c2b9aa2c8a63
