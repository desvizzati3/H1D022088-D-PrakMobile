import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SideMenu extends StatelessWidget {
  const SideMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.lightGreen.shade300,
            ),
            child: ProfileOverview(),
          ),
          ListTile(
            leading: Icon(Icons.bar_chart),
            title: Text('App Stats / Analytics'),
            onTap: () {
              Navigator.pop(context);
              // Navigasi ke halaman statistik atau tampilkan alert
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text("App Stats"),
                    content: Text("Usage: 5 hours\nAchievements: 3/5 unlocked"),
                    actions: <Widget>[
                      TextButton(
                        child: Text("OK"),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  );
                },
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.format_quote),
            title: Text('Daily Quote'),
            onTap: () {
              Navigator.pop(context);
              // Tampilkan quote harian
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text("Daily Quote"),
                    content: Text(
                        "\"The best time to plant a tree was 20 years ago. The second best time is now.\""),
                    actions: <Widget>[
                      TextButton(
                        child: Text("OK"),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}

class ProfileOverview extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CircleAvatar(
          radius: 30,
          backgroundImage: NetworkImage(
              'https://example.com/avatar.png'), // Ganti dengan avatar pengguna
        ),
        SizedBox(height: 10),
        Text(
          'John Doe', // Nama pengguna
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          'Level: 5 | Achievements: 3/5', // Statistik pengguna
          style: TextStyle(
            color: Colors.white70,
            fontSize: 14,
          ),
        ),
      ],
    );
  }
}
