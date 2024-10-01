import 'package:flutter/material.dart';

class ProdukForm extends StatefulWidget {
  const ProdukForm({Key? key}) : super(key: key);

  @override
  _ProdukFormState createState() => _ProdukFormState();
}

class _ProdukFormState extends State<ProdukForm> {
  final _kodeProdukController = TextEditingController();
  final _namaProdukController = TextEditingController();
  final _hargaProdukController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Form Produk'),
      ),
      body: Container(
        margin: const EdgeInsets.all(10),
        child: Column(
          children: [
            _textboxKodeProduk(),
            _textboxNamaProduk(),
            _textboxHarga(),
            _tombolSimpan(),
          ],
        ),
      ),
    );
  }

  Widget _textboxKodeProduk() {
    return TextField(
      decoration: const InputDecoration(labelText: 'Kode Produk'),
      controller: _kodeProdukController,
    );
  }

  Widget _textboxNamaProduk() {
    return TextField(
      decoration: const InputDecoration(labelText: 'Nama Produk'),
      controller: _namaProdukController,
    );
  }

  Widget _textboxHarga() {
    return TextField(
      decoration: const InputDecoration(labelText: 'Harga'),
      controller: _hargaProdukController,
      keyboardType: TextInputType.number, // Hanya angka yang diperbolehkan
    );
  }

  Widget _tombolSimpan() {
    return ElevatedButton(
      onPressed: () {
        String kodeProduk = _kodeProdukController.text;
        String namaProduk = _namaProdukController.text;

        // Validasi untuk memastikan harga dapat diparse menjadi integer
        int harga;
        try {
          harga = int.parse(_hargaProdukController.text);
        } catch (e) {
          // Jika parsing gagal, tampilkan pesan error
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Harga harus berupa angka')),
          );
          return;
        }

        // Navigasi ke ProdukDetail dengan data yang telah dimasukkan
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => ProdukDetail(
            kodeProduk: kodeProduk,
            namaProduk: namaProduk,
            harga: harga,
          ),
        ));
      },
      child: const Text('Simpan'),
    );
  }
}

// Tambahkan ProdukDetail sebagai class terpisah
class ProdukDetail extends StatelessWidget {
  final String kodeProduk;
  final String namaProduk;
  final int harga;

  const ProdukDetail({
    Key? key,
    required this.kodeProduk,
    required this.namaProduk,
    required this.harga,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Produk'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Kode Produk: $kodeProduk'),
            Text('Nama Produk: $namaProduk'),
            Text('Harga Produk: $harga'),
          ],
        ),
      ),
    );
  }
}
