! [Form Register](register_ui.png)
! [Form Register](register.png)
penjelasan proses registrasi:

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

  penjelasan:
  - Fungsi _formKey.currentState!.save() memanggil metode save() pada formulir (yang diwakili oleh _formKey) untuk menyimpan data input dari pengguna.
  - setState(() { _isLoading = true; }) digunakan untuk mengubah nilai _isLoading menjadi true, yang mungkin memicu tampilan indikator loading di UI.
  - RegistrasiBloc.registrasi() adalah pemanggilan asynchronous untuk proses registrasi, di mana nilai dari controller text _namaTextboxController, _emailTextboxController, dan _passwordTextboxController dikirim sebagai parameter nama, email, dan password.
  - Jika registrasi berhasil, ditampilkan SuccessDialog dengan pesan "Registrasi berhasil, silahkan login". Pengguna harus menekan tombol "OK" untuk menutup dialog tersebut menggunakan Navigator.pop(context).
  - Jika proses registrasi gagal, akan muncul WarningDialog yang menampilkan pesan "Registrasi gagal, silahkan coba lagi".
  - Setelah proses selesai (baik berhasil atau gagal), setState(() { _isLoading = false; }) akan mengubah status loading menjadi false, menghentikan indikator loading di UI.


! [Form Login](login_ui.png)
! [Login](login.png)

void _submit() {
    _formKey.currentState!.save();
    setState(() {
      _isLoading = true;
    });
    LoginBloc.login(
            email: _emailTextboxController.text,
            password: _passwordTextboxController.text)
        .then((value) async {
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
                ));
      }
    }, onError: (error) {
      print(error);
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) => const WarningDialog(
                description: "Login gagal, silahkan coba lagi",
              ));
    });
    setState(() {
      _isLoading = false;
    });
  

Penjelasan Login:
    - _formKey.currentState!.save(); digunakan untuk menyimpan data yang diinputkan pengguna dari form, dalam hal ini berupa email dan password yang dimasukkan melalui _emailTextboxController dan _passwordTextboxController.
    - setState(() { _isLoading = true; }); digunakan untuk mengubah status variabel _isLoading menjadi true, biasanya untuk menunjukkan indikator loading di UI selama proses login berlangsung.
    - Fungsi LoginBloc.login() dipanggil dengan parameter email dan password yang diambil dari input pengguna. Fungsi ini adalah proses asynchronous yang akan melakukan autentikasi pengguna melalui email dan password.
    - Akan muncul dialog peringatan WarningDialog dengan pesan "Login gagal, silahkan coba lagi", memberitahu pengguna bahwa login tidak berhasil.
    - Cek Kode Status: Jika value.code == 200 (artinya login berhasil), dua informasi penting disimpan secara lokal menggunakan fungsi UserInfo():
    setToken(value.token.toString()): Menyimpan token autentikasi yang diterima dari server ke dalam perangkat.setUserID(int.parse(value.userID.toString())): Menyimpan ID pengguna.
    - Navigasi ke Halaman Produk: Setelah login berhasil, pengguna akan diarahkan ke halaman ProdukPage menggunakan Navigator.pushReplacement(), yang mengganti halaman login dengan halaman produk tanpa memungkinkan pengguna kembali ke halaman login.
    - Setelah proses login selesai, baik berhasil atau gagal, status loading diubah kembali ke false dengan setState(() { _isLoading = false; });, menonaktifkan indikator loading di UI.



Create Produk
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
              ));
    });
    setState(() {
      _isLoading = false;
    });
  }

  - setState(() { _isLoading = true; }); digunakan untuk menandai bahwa proses penyimpanan sedang berlangsung, dengan mengubah variabel _isLoading menjadi true. Ini mungkin digunakan untuk menampilkan indikator loading di UI.
  - Produk createProduk = Produk(id: null); membuat objek produk baru dengan id yang disetel ke null karena ini adalah produk baru.
  - ProdukBloc.addProduk(produk: createProduk) adalah panggilan asynchronous yang akan menyimpan objek produk baru ke dalam sistem atau database.
  - Jika proses penyimpanan berhasil, aplikasi akan diarahkan ke halaman ProdukPage dengan menggunakan Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => const ProdukPage()));. Ini akan memuat ulang halaman produk.
  - Jika penyimpanan gagal, sebuah dialog peringatan WarningDialog akan muncul, menampilkan pesan "Simpan gagal, silahkan coba lagi", yang memberi tahu pengguna bahwa proses penyimpanan tidak berhasil.
  - Setelah proses penyimpanan selesai, variabel _isLoading diubah kembali menjadi false dengan setState(() { _isLoading = false; });, yang akan menghentikan indikator loading di UI.


Edit Produk
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
              ));
    });
    setState(() {
      _isLoading = false;
    });
  }
}

- setState(() { _isLoading = true; }); digunakan untuk mengubah variabel _isLoading menjadi true, yang biasanya digunakan untuk menampilkan indikator loading di UI selama proses pembaruan berlangsung.
- Produk updateProduk = Produk(id: widget.produk!.id!); membuat objek updateProduk dengan ID yang diambil dari produk yang sudah ada (dari widget.produk
- ProdukBloc.updateProduk(produk: updateProduk) adalah fungsi asynchronous yang dipanggil untuk memperbarui produk di database atau sistem.
- Jika pembaruan berhasil, pengguna akan diarahkan ke halaman ProdukPage menggunakan Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => const ProdukPage())); untuk menampilkan halaman produk yang sudah diperbarui.
- Jika pembaruan gagal, dialog peringatan WarningDialog akan muncul dengan pesan "Permintaan ubah data gagal, silahkan coba lagi", memberitahu pengguna bahwa proses pembaruan tidak berhasil.
- Setelah proses pembaruan selesai (baik berhasil atau gagal), status loading diubah kembali menjadi false dengan setState(() { _isLoading = false; });, menghentikan indikator loading di UI.


Read Produk
body: FutureBuilder<List>(
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
      ),

- future: ProdukBloc.getProduks() memanggil fungsi getProduks() dari ProdukBloc, yang bertugas untuk mengambil data produk dari sumber data, seperti API atau database.
- Fungsi builder menerima dua parameter: context dan snapshot.
- Jika terjadi kesalahan saat pengambilan data, maka kesalahan tersebut akan dicetak menggunakan print(snapshot.error);. Ini membantu dalam debugging untuk melihat apa yang salah selama pemanggilan Future
- Jika data sudah diterima (snapshot.hasData bernilai true), maka widget ListProduk akan ditampilkan, di mana list: snapshot.data mengirimkan data produk yang diterima ke widget ListProduk untuk menampilkannya sebagai daftar.
- Jika data belum tersedia (snapshot.hasData bernilai false), maka CircularProgressIndicator akan ditampilkan di tengah layar dengan widget Center. Ini memberi tahu pengguna bahwa aplikasi sedang dalam proses mengambil data.

Delete Produk
OutlinedButton(
          child: const Text("DELETE"),
          onPressed: () => confirmHapus(),
        ),
      ],
    );
  }

  void confirmHapus() {
    AlertDialog alertDialog = AlertDialog(
      content: const Text("Yakin ingin menghapus data ini?"),
      actions: [
//tombol hapus
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
                      ));
- OutlinedButton dengan teks "DELETE" ditampilkan di UI. Ketika tombol ini ditekan, fungsi confirmHapus() dipanggil untuk menampilkan dialog konfirmasi penghapusan data.





