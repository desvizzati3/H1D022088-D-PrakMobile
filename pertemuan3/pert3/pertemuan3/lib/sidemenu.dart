import 'package:flutter/material.dart';
import 'package:pertemuan3/home_page.dart';
import 'package:pertemuan3/about_page.dart'; // Import the AboutPage if it's in a different file

class SideMenu extends StatelessWidget {
  const SideMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          const DrawerHeader(
            child: Text('Side Menu'),
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('Home'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const HomePage(),
                ),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.info),
            title: const Text('About'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      const AboutPage(), // Ensure AboutPage is defined
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
