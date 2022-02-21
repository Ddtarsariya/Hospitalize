import 'package:flutter/material.dart';

class AdminScreen extends StatelessWidget {
  static const routeName = '/admin-screen';
  const AdminScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin'),
      ),
      body: const Center(
        child: Text('Admin'),
      ),
    );
  }
}
