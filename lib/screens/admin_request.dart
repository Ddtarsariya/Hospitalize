import 'package:flutter/material.dart';
import 'package:hospitalize/screens/admin_driver.dart';
import 'package:hospitalize/screens/admin_hospital_request.dart';

class AdminRequest extends StatelessWidget {
  static const routeName = '/admin-request';
  final Widget? childWidget;

  const AdminRequest({Key? key, @required this.childWidget}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Request'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, AdminHospitalRequest.routeName);
              },
              child: const Text('Hospital Registration'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, AdminDriver.routeName);
              },
              child: const Text('Driver Registration'),
            ),
          ],
        ),
      ),
    );
  }
}
