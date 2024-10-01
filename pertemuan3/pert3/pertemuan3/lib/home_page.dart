import 'package:flutter/material.dart';
import 'package:pertemuan3/sidemenu.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var namauser;

  @override
  void initState() {
    super.initState();
    _getUsername();
  }

  void _getUsername() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      namauser = prefs.getString('username');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
      ),
      body: Center(
        child: Text('Ini adalah halaman user $namauser'),
      ),
      drawer: const SideMenu(),
    );
  }
}
