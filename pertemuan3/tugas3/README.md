# tugas3

[main.dart]

{
    initialRoute: '/',
        routes: {
          '/': (context) => LoginPage(),
          '/home': (context) => HomePage(),
        });
}

source code di atas adalah bagian rpute, di mana digunakan untuk mendefinik=sikan navigasi antar halaman dengan dua route, yang pertama '/' yang akan mengarah ke Login Page dan '/home' yang akan mengarah ke Home Page.

[login_page.dart]

{
    _saveUsername() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('username', _username);
  }
}

source code di atas digunakan untuk menyimpan username secara lokal di perangkat pengguna dengan menggunakan shared preferences.

{
     onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    if (_username == 'admin' && _password == 'password') {
                      _saveUsername();
                      Navigator.pushReplacementNamed(context, '/home');
                    } else {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          content: Text('Login failed!'),
                        ),
}

source code di atas adalah method untuk memverifikasi password dan username pengguna ketika login, kemudian Navigator.pushReplacementNamed(context, '/home'); digunakan untuk menavigasikan halaman ke /home dan akan membuat tidak bisa kembali ke halaman sebelumnya.

[home_page.dart]

{
    _loadUsername() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _username = prefs.getString('username') ?? '';
    });
  }
}

fungsi ini memungkinkan untuk memunculkan nama user yang sebelumnya sudah disimpan secara lokal melalui shared references.

[sidemenu.dart]

terdapat ListTile() yang memungkinkan untuk menaruh menu menu berurutan ke bawah pada drawer di side menu.


# printscreen aplikasi

! [Login page](login_page.png)
! [Home page](home_page.png)
! [Sidemenu](sidemenu.png)
! [App Stats](app_stats.png)
! [Daily Quote](daily_quote.png)


 