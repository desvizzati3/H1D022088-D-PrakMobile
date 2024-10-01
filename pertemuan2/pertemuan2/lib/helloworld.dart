import 'package:flutter/material.dart';

class HelloWorldScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Belajar Flutter'),
      ),
      body: const Center(
        child: Text('anjay flutter!'),
      ),
    );
  }
}
