# Tugas Praktikum 4 & 5 Pemrogaman Mobile

Nama: Brian Cahya Purnama

NIM: H1D022009

Shift Lama: C

Shift Baru: D

# List of Contents

- [Tugas Praktikum 4](#tugas-praktikum-4-pemrograman-mobile)
  - [Demo Tampilan](#demo-tampilan-aplikasi)
- [Tugas Praktikum 5](#tugas-praktikum-5-pemrograman-mobile-lanjutan)

  - [Proses Registrasi](#proses-registrasi)
  - [Proses Login](#proses-login)
  - [Proses Tampil Data](#proses-tampil-data)
  - [Create Produk](#create-menambah-produk)
  - [Read Produk](#read-melihat-produk)
  - [Update Produk](#update-mengedit-produk)
  - [Delete Produk](#delete-menghapus-produk)

# Tugas Praktikum 4 Pemrograman Mobile

## Demo Tampilan Aplikasi

![Demo GIF](demo.gif)

# Tugas Praktikum 5 Pemrograman Mobile (Lanjutan)

## Proses Registrasi

### Langkah 1: Buka Halaman Registrasi
Pada halaman login tekan "Registrasi", untuk pergi ke halaman registrasi:

![image](https://github.com/user-attachments/assets/b85c33b1-f7a2-47ab-9331-7696b68ca7a6)

### Langkah 2: Masukkan Inputan Registrasi
Masukkan nama, email, password, dan konfirmasi password kamu:

![image](https://github.com/user-attachments/assets/ff25e70d-d87e-4f5f-80c3-a762a3bc33e7)

### Langkah 3: Kirim Registrasi
Klik tombol "Registrasi" untuk mengirim inputan.

### Potongan Kode & Penjelasan: Proses Registrasi
```
void _submit() {
  _formKey.currentState!.save();
  setState(() {
    _isLoading = true;
  });

  RegistrasiBloc.registrasi(
    nama: _namaTextboxController.text,
    email: _emailTextboxController.text,
    password: _passwordTextboxController.text,
  ).then((value) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) => SuccessDialog(
        description: "Registrasi berhasil, silahkan login",
        okClick: () {
          Navigator.pop(context);
        },
      ),
    );
  }, onError: (error) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) => const WarningDialog(
        description: "Registrasi gagal, silahkan coba lagi",
      ),
    );
  });

  setState(() {
    _isLoading = false;
  });
}
```
- Fungsi _submit() dipanggil saat tombol registrasi ditekan.
- _formKey.currentState!.save() menyimpan state form saat ini.
- setState(() { _isLoading = true; }) mengubah state untuk menampilkan indikator loading.
- RegistrasiBloc.registrasi() dipanggil dengan data dari form.
- Kalau registrasi berhasil, dialog pesan sukses dimunculin.
- Kalau registrasi gagal, dialog peringatan dimunculin.
- State loading diubah menjadi false setelah proses selesai.

### Langkah 4: Hasil Registrasi
Ketika registrasi berhasil, maka akan muncul tampilan dialog pesan sukses seperti berikut dan dapat kembali ke halaman login:

![image](https://github.com/user-attachments/assets/32ef5fc7-a6e6-4d42-8559-461a1dbf8029)

## Proses Login

### Langkah 1: Buka Halaman Login
Ini muncul ketika baru ngejalanin flutter run, maka akan muncul tampilan awal sebagai berikut:

![image](https://github.com/user-attachments/assets/1eb778c4-46c7-45f4-abfe-f1b872b9ba82)

### Langkah 2: Masukkan Inputan Login
Masukkan email dan password yang telah didaftarkan setelah proses registrasi sukses

### Langkah 3: Kirim Login
Klik tombol "Login" untuk mengirim inputan.

### Potongan Kode & Penjelasan: Proses Login
```
void _submit() {
  _formKey.currentState!.save();
  setState(() {
    _isLoading = true;
  });
  LoginBloc.login(
    email: _emailTextboxController.text,
    password: _passwordTextboxController.text
  ).then((value) async {
    if (value.code == 200) {
      await UserInfo().setToken(value.token.toString());
      await UserInfo().setUserID(int.parse(value.userID.toString()));
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => const ProdukPage()));
    } else {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) => const WarningDialog(
          description: "Login gagal, silahkan coba lagi",
        )
      );
    }
  }, onError: (error) {
    print(error);
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) => const WarningDialog(
        description: "Login gagal, silahkan coba lagi",
      )
    );
  });
  setState(() {
    _isLoading = false;
  });
}
```
- Fungsi _submit() dipanggil saat menekan tombol login.
- _formKey.currentState!.save() buat menyimpan state form saat ini.
- setState(() { _isLoading = true; }) buat mengubah state untuk menampilkan indikator loading.
- LoginBloc.login() ini dipanggil dengan email dan password dari controller.
- Kalau loginnya berhasil (kode 200), token dan userID disimpan, lalu navigasi ke halaman produk.
- Kalau loginnya gagal, dialog peringatan dimunculin.
- Lalu yang terakhir, state loading diubah kembali menjadi false baik loginnya berhasil ataupun tidak.

### Langkah 4: Hasil Login
Kalau login berhasil, akan diarahkan ke halaman produk. Kalau login gagal, akan melihat pesan kesalahan:
![image](https://github.com/user-attachments/assets/4984d5eb-c9e8-4a6d-b9aa-866ef0a03e49)
![image](https://github.com/user-attachments/assets/d4d08688-959c-4670-a6ca-fee0c6958b5d)

## Proses Tampil Data

### Langkah 1: Memilih Produk dari Daftar
Pada halaman daftar produk, kita bisa lihat semua produk yang tersedia. Setiap produk ditampilkan dalam bentuk Card dengan informasi nama dan harga produk:

![image](https://github.com/user-attachments/assets/c68f1604-8858-4456-8308-27af04b9a343)

### Langkah 2: Membuka Halaman Detail Produk
Ketika menekan salah satu produk, aplikasi akan membuka halaman detail produk. Halaman ini menampilkan informasi lengkap tentang produk yang dipilih:

![image](https://github.com/user-attachments/assets/a494e98f-9fb2-4df0-aabf-23d6001680ee)

### Potongan Kode & Penjelasan: Proses Tampil Data
```
class ItemProduk extends StatelessWidget {
  final Produk produk;

  const ItemProduk({Key? key, required this.produk}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProdukDetail(
              produk: produk,
            )
          )
        );
      },
      child: Card(
        child: ListTile(
          title: Text(produk.namaProduk!),
          subtitle: Text(produk.hargaProduk.toString()),
        ),
      ),
    );
  }
}
```
- ItemProduk adalah widget yang menerima objek Produk sebagai parameter.
- Menggunakan GestureDetector untuk mendeteksi action tekan pada item produk.
- Ketika salah satu item ditekan, navigasi pergi ke halaman ProdukDetail dengan data produk yang dipilih.
- Tampilan menggunakan Card dan ListTile untuk menampilkan nama dan harga produk.

```
class ProdukDetail extends StatefulWidget {
  Produk? produk;

  ProdukDetail({Key? key, this.produk}) : super(key: key);

  @override
  _ProdukDetailState createState() => _ProdukDetailState();
}

class _ProdukDetailState extends State<ProdukDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Produk'),
      ),
      body: Center(
        child: Column(
          children: [
            Text(
              "Kode : ${widget.produk!.kodeProduk}",
              style: const TextStyle(fontSize: 20.0),
            ),
            Text(
              "Nama : ${widget.produk!.namaProduk}",
              style: const TextStyle(fontSize: 18.0),
            ),
            Text(
              "Harga : Rp. ${widget.produk!.hargaProduk.toString()}",
              style: const TextStyle(fontSize: 18.0),
            ),
            _tombolHapusEdit()
          ],
        ),
      ),
    );
  }
}
```
- ProdukDetail adalah widget stateful yang menerima objek Produk.
- build method membuat tampilan dengan Scaffold yang memiliki AppBar dengan title "Detail Produk".
- Body Scaffold berisi Column yang menampilkan:
  - Kode produk dengan font size 20.0
  - Nama produk dengan font size 18.0
  - Harga produk dengan font size 18.0 diawali dengan "Rp."
- _tombolHapusEdit() menambahkan tombol untuk mengedit atau menghapus produk.
- Halaman detail mengakses data produk melalui widget.produk dan menampilkannya.
- Data ditampilkan langsung tanpa request jaringan tambahan, karena semua info sudah ada dalam objek Produk yang diteruskan.

## Create: Menambah Produk

### Langkah 1: Buka Halaman Tambah Produk
Dari halaman daftar produk, klik ikon "+" di app bar.

![image](https://github.com/user-attachments/assets/5a0d014b-8adf-4d73-81cc-e61d5a655bda)

### Langkah 2: Isi Detail Produk
Masukkan detail produk dalam formulir:

![image](https://github.com/user-attachments/assets/cb105eef-7837-4776-9a7d-570dc2e28acb)

### Langkah 3: Simpan Produk
Klik tombol "SIMPAN" untuk menyimpan produk baru.

### Potongan Kode & Penjelasan: Menambah Produk
```
simpan() {
  setState(() {
    _isLoading = true;
  });
  Produk createProduk = Produk(id: null);
  createProduk.kodeProduk = _kodeProdukTextboxController.text;
  createProduk.namaProduk = _namaProdukTextboxController.text;
  createProduk.hargaProduk = int.parse(_hargaProdukTextboxController.text);
  ProdukBloc.addProduk(produk: createProduk).then((value) {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (BuildContext context) => const ProdukPage()));
  }, onError: (error) {
    showDialog(
      context: context,
      builder: (BuildContext context) => const WarningDialog(
        description: "Simpan gagal, silahkan coba lagi",
      )
    );
  });
  setState(() {
    _isLoading = false;
  });
}
```
- Fungsi simpan() dipanggil saat menekan tombol simpan.
- State loading diubah jadi true.
- Objek Produk baru dibuat dengan data dari text controller.
- ProdukBloc.addProduk() akan dipanggil buat nyimpen produk baru.
- Kalau berhasil, pindah ke halaman daftar produk.
- Kalau gagal, dialog peringatan dimunculin.
- Terakhir, state loading diubah lagi menjadi false.

### Langkah 4: Hasil Create
![image](https://github.com/user-attachments/assets/f32f398a-647d-440a-965a-3f66f79c67eb)

## Read: Melihat Produk

### Langkah 1: Daftar Produk
Setelah login, Anda akan melihat daftar produk:

![image](https://github.com/user-attachments/assets/c0586da6-60b6-430d-859e-584d23b9367b)

### Langkah 2: Detail Produk
Ketuk pada produk untuk melihat detailnya:

![image](https://github.com/user-attachments/assets/a18eca80-ef9f-497f-8c31-f3e44c63b123)

### Potongan Kode & Penjelasan: Mengambil Produk
```
FutureBuilder<List>(
  future: ProdukBloc.getProduks(),
  builder: (context, snapshot) {
    if (snapshot.hasError) print(snapshot.error);
    return snapshot.hasData
        ? ListProduk(
            list: snapshot.data,
          )
        : const Center(
            child: CircularProgressIndicator(),
          );
  },
)
```
Kode ini buat melihat produk menggunakan FutureBuilder untuk mengambil dan menampilkan daftar produk.

## Update: Mengedit Produk

### Langkah 1: Buka Form Edit
Dari halaman detail produk, klik tombol "EDIT".

![image](https://github.com/user-attachments/assets/e9f946b1-d9d4-4a8b-b2d4-30a88fa9c4b0)

### Langkah 2: Ubah Detail Produk
Coba untuk perbarui data / informasi produk dalam formulir.

![image](https://github.com/user-attachments/assets/24503b99-82ce-44a1-87e8-0e7e6a782d40)

### Langkah 3: Simpan Perubahan
Klik tombol "UBAH" untuk menyimpan perubahannya.

### Potongan Kode & Penjelasan: Memperbarui Produk
```
ubah() {
  setState(() {
    _isLoading = true;
  });
  Produk updateProduk = Produk(id: widget.produk!.id!);
  updateProduk.kodeProduk = _kodeProdukTextboxController.text;
  updateProduk.namaProduk = _namaProdukTextboxController.text;
  updateProduk.hargaProduk = int.parse(_hargaProdukTextboxController.text);
  ProdukBloc.updateProduk(produk: updateProduk).then((value) {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (BuildContext context) => const ProdukPage()));
  }, onError: (error) {
    showDialog(
      context: context,
      builder: (BuildContext context) => const WarningDialog(
        description: "Permintaan ubah data gagal, silahkan coba lagi",
      )
    );
  });
  setState(() {
    _isLoading = false;
  });
}
```
- Fungsi ubah() dipanggil saat menekan tombol ubah.
- State loading diubah menjadi true.
- Objek Produk dibuat dengan ID yang sudah ada dan data baru dari text controller.
- ProdukBloc.updateProduk() akan dipanggil buat memperbarui produk.
- Kalau berhasil, pindah navigasi ke halaman daftar produk.
- Kalau gagal, dialog peringatan dimunculin.
- Terakhir, state loading diubah lagi jadi false.

### Langkah 4: Hasil Update
![image](https://github.com/user-attachments/assets/9d66ffb0-7a56-4340-8682-69260d363c57)

## Delete: Menghapus Produk

### Langkah 1: Mulai Penghapusan
Dari halaman detail produk, klik tombol "DELETE".

![image](https://github.com/user-attachments/assets/d5cf92a3-e474-422b-bc42-232e2fbf8fd4)

### Langkah 2: Konfirmasi Penghapusan
Dialog konfirmasi akan muncul. Klik "Ya" buat ngonfirmasi penghapusan.

![image](https://github.com/user-attachments/assets/4d67826d-206c-412a-9b6e-8f15de4615a9)

### Langkah 3: Produk Dihapus
Produk akan dihapus dari daftar.

### Potongan Kode: Menghapus Produk
```
void confirmHapus() {
  AlertDialog alertDialog = AlertDialog(
    content: const Text("Yakin ingin menghapus data ini?"),
    actions: [
      OutlinedButton(
        child: const Text("Ya"),
        onPressed: () {
          ProdukBloc.deleteProduk(id: int.parse(widget.produk!.id!)).then(
            (value) => {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const ProdukPage()))
            }, onError: (error) {
            showDialog(
              context: context,
              builder: (BuildContext context) => const WarningDialog(
                description: "Hapus gagal, silahkan coba lagi",
              )
            );
          });
        },
      ),
      OutlinedButton(
        child: const Text("Batal"),
        onPressed: () => Navigator.pop(context),
      )
    ],
  );
  showDialog(builder: (context) => alertDialog, context: context);
}
```
Kode ini buat menghapus produk menampilkan dialog konfirmasi sebelum melakukan penghapusan. Jika dikonfirmasi, ProdukBloc.deleteProduk() akan dipanggil buat  menghapus produk dari database.

### Langkah 4: Hasil Delete
![image](https://github.com/user-attachments/assets/4b8ffd43-c5ef-4d32-8604-fa0e78cb7412)

