import 'package:buku/ui/login_page.dart';
import 'package:buku/ui/registrasi_page.dart';
import 'package:flutter/material.dart';
import '/ui/status_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Status Management',
      debugShowCheckedModeBanner: false,
      home: const StatusPage(), // Langsung arahkan ke StatusPage
    );
  }
}
