import 'package:flutter/material.dart';

import 'admin_driver.dart';
import 'admin_hospital_request.dart';

class AdminRequest extends StatelessWidget {
  static const routeName = '/admin-request';
  final Widget? childWidget;

  const AdminRequest({Key? key, @required this.childWidget}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          /*crossAxisAlignment: CrossAxisAlignment.stretch,*/
          children: [
            Expanded(
              child: InkWell(
                onTap: () {
                  Navigator.pushNamed(context, AdminHospitalRequest.routeName);
                },
                child: Card(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(color: Colors.grey),
                    ),
                    height: 100,
                    child: Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        Image.network(
                            "https://img.icons8.com/external-flaticons-flat-flat-icons/344/external-hospital-wayfinding-flaticons-flat-flat-icons-2.png"),
                        Container(
                          width: double.maxFinite,
                          color: Colors.black.withOpacity(0.4),
                          padding: const EdgeInsets.all(5),
                          child: const Text(
                            'Hospital',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: InkWell(
                onTap: () {
                  Navigator.pushNamed(context, AdminDriver.routeName);
                },
                child: Card(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(color: Colors.grey),
                    ),
                    height: 100,
                    child: Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        Image.network(
                            "https://img.icons8.com/external-nawicon-flat-nawicon/344/external-ambulance-medical-nawicon-flat-nawicon.png"),
                        Container(
                          width: double.maxFinite,
                          color: Colors.black.withOpacity(0.4),
                          padding: const EdgeInsets.all(5),
                          child: const Text(
                            'Driver',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
