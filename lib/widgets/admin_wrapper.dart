import 'package:flutter/material.dart';
import 'package:hospitalize/screens/admin_request.dart';

import '../models/hospital.dart';
import '../screens/admin_screen.dart';

class AdminWrapper extends StatelessWidget {
  static const routeName = '/admin-wrapper';
  const AdminWrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Hospital().requestStatus(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const AdminRequest(childWidget: CircularProgressIndicator());
        } else if (snapshot.data == 'No') {
          return const AdminRequest(childWidget: Text('Pending'));
        } else if (snapshot.data == 'Yes') {
          return const AdminScreen();
        } else {
          return const AdminRequest(childWidget: null);
        }
      },
    );
  }
}
