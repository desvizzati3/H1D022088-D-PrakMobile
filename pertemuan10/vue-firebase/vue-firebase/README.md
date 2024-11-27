# Tugas Pertemuan 10

<table align="center">
  <tr align="center">
    <td>Halaman Sign In</td>
    <td>Pop Up Sign In</td>
  </tr>
  <tr>
    <td><img src="https://github.com/user-attachments/assets/761342b1-73cf-4c6f-a453-160774ded147" width="150" height="280"></td>
    <td><img src="https://github.com/user-attachments/assets/2016c97a-9a69-48c5-a482-5963e1a6c8f2" width="150" height="280"></td>
  </tr>
</table>

### Proses Sign In

Ketika user klik sign in, maka akan muncul pop up untuk memilih user akan login dengan akun google yang mana. kemudian setelah user memilih, akan dilakukan proses autentikasi, dan apabila berhasil akan langsung diarahkan ke halaman Home.


<table align="center">
  <tr align="center">
    <td>Halaman Home</td>
    <td>Halaman Profile</td>
  </tr>
  <tr>
    <td><img src="https://github.com/user-attachments/assets/209d7970-501d-4c56-8afa-f29be2ca76c7" width="150" height="280"></td>
    <td><img src="https://github.com/user-attachments/assets/bd00fd64-7392-49b6-98dc-a24a4367b0bb" width="150" height="280"></td>
  </tr>
</table>

### Halaman Home dan Profile

Setelah berhasil melakukan Sign In, pengguna akan langsung sampai di Halaman Home, di Halaman Home ini terdapat Header 'Home' yang menandakan halaman Home dan ada Bottom Navigator yang memiliki 2 menu yaitu Home dan Profile. 
Pada halaman Profile terdapat foto profile dari akun google dan data Nama Pengguna Email yang digunakan untuk Sign In serta data emailnya. 


# Alur Pengambilan Data Profile saat Autentikasi

## Firebase & Google Authentication Setup

### 1. Inisialisasi Firebase dan Google Auth
- Konfigurasi Firebase diinisialisasi melalui file `firebase.ts`.
- Google Auth diatur menggunakan client ID yang telah terdaftar sebelumnya.
- Pinia store (`auth.ts`) disiapkan untuk mengelola status autentikasi user di aplikasi.

### 2. Proses Login
- Pengguna mengklik tombol **"Sign In with Google"** untuk memulai login.
- Fungsi `loginWithGoogle()` yang ada di store `auth` dipanggil.
- Capacitor Google Auth menampilkan popup untuk memilih akun Google.
- Setelah pengguna memilih akun, Google mengirimkan token otentikasi.
- Token ini digunakan untuk menghasilkan kredensial Firebase.
- Data pengguna yang diperoleh dari otentikasi disimpan di state Pinia.

### 3. Mengambil Data Profil Pengguna
- Setelah login berhasil, Firebase memberikan objek `User`.
- Informasi profil (seperti nama, email, dan foto) diambil dari objek tersebut dan disimpan dalam store Pinia.
- Data profil tersebut dapat diakses di seluruh bagian aplikasi.
- Komponen **Profile** menggunakan computed property untuk mengakses dan menampilkan data ini.

### 4. Perlindungan Rute
- Router guard (`beforeEach`) digunakan untuk memeriksa status autentikasi saat pengguna mengakses rute.
- Halaman yang memerlukan autentikasi (seperti `home` dan `profile`) dilindungi.
- Pengguna yang belum login akan diarahkan ke halaman login.
- Pengguna yang sudah login tidak akan bisa mengakses halaman login.

### 5. Proses Logout
- Ketika pengguna mengklik tombol logout, fungsi `logout()` dijalankan.
- Fungsi `Firebase signOut()` dan `Google signOut()` dipanggil untuk mengakhiri sesi.
- State user di Pinia direset.
- Pengguna akan diarahkan kembali ke halaman login.

# Tugas Pertemuan 11

<table align="center">
  <tr align="center">
    <td>Halaman Sign In</td>
    <td>Pop Up Sign In</td>
  </tr>
  <tr>
    <td><img src="https://github.com/user-attachments/assets/f525c409-691c-45e4-8d37-931bae2563e7" width="150" height="280"></td>
    <td><img src="https://github.com/user-attachments/assets/3273856c-90d9-4dd9-a216-1788cfc73f7e" width="150" height="280"></td>
    <td><img src="https://github.com/user-attachments/assets/9bd33939-6509-4bfe-b262-86a2173b49e4" width="150" height="280"></td>
    <td><img src="https://github.com/user-attachments/assets/32f1a01c-da93-48b5-a38f-096913a608c1" width="150" height="280"></td>
    <td><img src="https://github.com/user-attachments/assets/1e9acc06-0850-48a5-b1b2-54ef8259053c" width="150" height="280"></td>
    <td><img src="https://github.com/user-attachments/assets/68d11c03-473a-422f-8bf6-130c5dfbe6a6" width="150" height="280"></td>
    <td><img src="https://github.com/user-attachments/assets/ee38300d-15ed-4989-8401-9ef674751fe1" width="150" height="280"></td>
    
    
  </tr>
</table>



