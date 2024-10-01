import 'package:flutter/material.dart';
import 'package:pertemuan3/home_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  var namauser;

  void _saveUsername() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('username', _usernameController.text);
  }

  Widget _showInput(TextEditingController namacontroller, String placeholder,
      bool isPassword) {
    return TextField(
      controller: namacontroller,
      obscureText: isPassword,
      decoration: InputDecoration(
        hintText: placeholder,
      ),
    );
  }

  void _showDialog(String pesan, Widget alamat) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(pesan),
          actions: [
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => alamat,
                    ));
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login Page'),
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _showInput(_usernameController, 'Enter Username', false),
            _showInput(_passwordController, 'Enter Password', true),
            ElevatedButton(
              child: const Text('Login'),
              onPressed: () {
                if (_usernameController.text == 'admin' &&
                    _passwordController.text == 'admin') {
                  _saveUsername();
                  _showDialog('Anda berhasil Login!', const HomePage());
                } else {
                  _showDialog(
                      'Username atau Password Salah', const LoginPage());
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
