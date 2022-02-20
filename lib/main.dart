import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'screens/admin_request.dart';
import 'screens/compare_hospital.dart';
import 'screens/home.dart';
import 'screens/login.dart';
import 'screens/track_ambulance.dart';
import 'services/auth_service.dart';
import 'widgets/wrapper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AuthService>.value(
      value: AuthService(),
      builder: (context, snapshot) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Hospitalize',
          theme: ThemeData(
            primarySwatch: Colors.red,
          ),
          initialRoute: '/',
          routes: {
            Wrapper.routeName: (context) => const Wrapper(),
            Home.routeName: (context) => const Home(),
            CompareHospital.routeName: (context) => const CompareHospital(),
            TrackAmbulance.routeName: (context) => const TrackAmbulance(),
            Register.routeName: (context) => const Register(),
            Login.routeName: (context) => const Login(),
          },
        );
      },
    );
  }
}