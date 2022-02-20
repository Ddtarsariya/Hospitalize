import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../screens/home.dart';
import '../screens/login.dart';

class Wrapper extends StatefulWidget {
  static const routeName = '/';

  const Wrapper({Key? key}) : super(key: key);

  @override
  State<Wrapper> createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasData) {
          return const Home();
        } else if (snapshot.hasError) {
          return const Center(
            child: Text('Something went wrong!'),
          );
        } else {
          return const Login();
        }
      },
    );
  }
}
