import 'package:flutter/material.dart';

class ProdukPage extends StatefulWidget {
  const ProdukPage({super.key});
  @override
  State<ProdukPage> createState() => _ProdukPageState();
}

class _ProdukPageState extends State<ProdukPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('List Data Produk'),
      ),
      body: ListView(children: const [
        Card(
          child: ListTile(
            title: Text('Kode Produk: 001'),
            subtitle: Text('Nama Produk: Laptop'),
            trailing: Text('Harga: Rp. 10.000.000'),
          ),
        ),
        Card(
          child: ListTile(
            title: Text('Kode Produk: 002'),
            subtitle: Text('Nama Produk: Smartphone'),
            trailing: Text('Harga: Rp. 5.000.000'),
          ),
        ),
        Card(
          child: ListTile(
            title: Text('Kode Produk: 003'),
            subtitle: Text('Nama Produk: Printer'),
            trailing: Text('Harga: Rp. 2.000.000'),
          ),
        )
      ]),
    );
  }
}
