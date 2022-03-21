import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hospitalize/screens/add_hospital_detail.dart';
import 'package:hospitalize/screens/admin_edit.dart';
import 'package:hospitalize/screens/admin_screen.dart';
import 'package:hospitalize/screens/beds_availability.dart';
import 'package:hospitalize/screens/book_appointment.dart';
import 'package:hospitalize/screens/booked_appointments.dart';
import 'package:hospitalize/screens/search_hospital.dart';
import 'package:hospitalize/widgets/admin_wrapper.dart';
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
            AdminRequest.routeName: (context) =>
                const AdminRequest(childWidget: null),
            Login.routeName: (context) => const Login(),
            Home.routeName: (context) => const Home(),
            CompareHospital.routeName: (context) => const CompareHospital(),
            TrackAmbulance.routeName: (context) => const TrackAmbulance(),
            AdminScreen.routeName: (context) => const AdminScreen(),
            AdminWrapper.routeName: (context) => const AdminWrapper(),
            SearchHospital.routeName: (context) => const SearchHospital(),
            BookAppointment.routeName: (context) => const BookAppointment(),
            AddHospitalDetail.routeName: (context) => const AddHospitalDetail(),
            BedsAvailability.routeName: (context) => const BedsAvailability(),
            AdminEdit.routeName: (context) => const AdminEdit(),
            BookedAppointments.routeName: (context) =>
                const BookedAppointments(),
          },
        );
      },
    );
  }
}
