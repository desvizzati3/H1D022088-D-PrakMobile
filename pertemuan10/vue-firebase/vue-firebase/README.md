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
  
    <td><img src="https://github.com/user-attachments/assets/68d11c03-473a-422f-8bf6-130c5dfbe6a6" width="150" height="280"></td>
    
    <td><img src="https://github.com/user-attachments/assets/a691c261-8aff-4f7f-b0a3-9896756866af" width="150" height="280"></td>
    <td><img src="https://github.com/user-attachments/assets/6d3007d3-8b12-43fd-aa59-4cac760dd45e" width="150" height="280"></td>
    <td><img src="https://github.com/user-attachments/assets/6d3007d3-8b12-43fd-aa59-4cac760dd45e" width="150" height="280"></td>
  </tr>
</table>

## Create To DO List
<table align="center">
  <tr align="center">
    <td>Home</td>
    <td>Form Create</td>
    <td>Hasil</td>
  </tr>
  <tr align="center">
    <td><img src="https://github.com/user-attachments/assets/f525c409-691c-45e4-8d37-931bae2563e7" width="150" height="280"></td>
    <td><img src="https://github.com/user-attachments/assets/3273856c-90d9-4dd9-a216-1788cfc73f7e" width="150" height="280"></td>
    <td><img src="https://github.com/user-attachments/assets/9bd33939-6509-4bfe-b262-86a2173b49e4" width="150" height="280"></td>
  </tr>
</table>

Lampiran printscreen di atas adalah tampilan pembuatan To Do List, dengan cara klik tombol Add (+) kemudian isikan judul to do list dan descriptionnya, kemudian Add Todo. Kemudain jika berhasil akan muncul pop up 'Todo added successfully' berwarna hijau, dan akan tampil di halaman Home.

## Completed Todo
<table align="center">
  <tr align="center">
    <td>Completed Todo</td>
  </tr>
  <tr align="center">
    <td><img src="https://github.com/user-attachments/assets/f72d8424-7099-4fe3-adb5-32c942c80d4e" width="150" height="280"></td>
  </tr>
</table>

Jika ingin Completed sebuah Todo, maka slide ke Kiri, kemudian tap Completed, maka akan otomatis masuk ke kolom COmpleted yang ada pada bagian bawah (berupa dropdown)

## Delete Todo
<table align="center">
  <tr align="center">
    <td>Delete Todo</td>
  </tr>
  <tr align="center">
    <td><img src="https://github.com/user-attachments/assets/f88354cd-ea22-4e58-9c72-b0a07cf0e633" width="150" height="280"></td>
  </tr>
</table>

Untuk menghapus Todo, slide Todo ke kanan, maka akan ter-Delete dan muncul notifikasi berhasil berwarna hijau.


## Edit Todo
<table align="center">
  <tr align="center">
    <td>Pilih Todo</td>
    <td>Pilih Edit</td>
    <td>Form Edit</td>
    <td>Hasil</td>
  </tr>
  <tr align="center">
    <td><img src="https://github.com/user-attachments/assets/48917b24-4528-4d61-a90a-6819511aba2a" width="150" height="280"></td>
    <td><img src="https://github.com/user-attachments/assets/f3319dfa-a1f0-4ee4-be3c-36e4995867ef" width="150" height="280"></td>
    <td><img src="https://github.com/user-attachments/assets/f22de153-06a7-456a-a81b-6650f6cdcfbf" width="150" height="280"></td>
    <td><img src="https://github.com/user-attachments/assets/02b908c1-4664-4942-a169-f99eb9e22971" width="150" height="280"></td>
  </tr>
</table>

Untuk melakukan Edit, slide Todo yang akan di edit ke kiri, kemudian pilih icon edit yang berwarna biru. Setelah masuk ke halaman Edit, lakukan edit lalu klik tombol Edit Todo. Maka Todo sudah berhasil di edit dan muncul notifikansi berhasil Edit todo.




