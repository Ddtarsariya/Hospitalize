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
        print(snapshot.data);
        if (snapshot.connectionState == ConnectionState.waiting) {
          /*return const  AdminRequest(childWidget: CircularProgressIndicator());*/
          return Scaffold(body: Center(child: CircularProgressIndicator(),),);
        } else if (snapshot.data == Status.fullyVerified) {
          return const AdminScreen(
            isPending: false,
          );
        } else if (snapshot.data == Status.pendingForDetail) {
          return const AdminScreen(
            isPending: true,
          );
        } else if (snapshot.data == Status.pending) {
          return const AdminRequest(childWidget: Text('Pending'));
        } else if (snapshot.data == Status.unknown) {
          return const AdminRequest(childWidget: null);
        } else {
          return const AdminRequest(childWidget: null);
        }
      },
    );
  }
}
