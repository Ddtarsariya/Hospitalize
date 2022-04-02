import 'package:flutter/material.dart';
import 'package:hospitalize/models/hospital.dart';
import 'package:hospitalize/screens/compare_hospital.dart';
import 'package:hospitalize/screens/search_hospital.dart';
import 'package:permission_handler/permission_handler.dart';

import '../widgets/app_drawer.dart';
import 'home_map.dart';
import 'track_ambulance.dart';

class Home extends StatelessWidget {
  static const routeName = '/home';
  const Home({Key? key}) : super(key: key);

  void setPermissions() async {
    final serviceStatus = await Permission.locationWhenInUse.serviceStatus;
    bool isGpsOn = serviceStatus == ServiceStatus.enabled;
    final status = await Permission.locationWhenInUse.request();
    if (status == PermissionStatus.granted) {
      print('Permission granted');
    } else if (status == PermissionStatus.denied) {
      print(
          'Denied. Show a dialog with a reason and again ask for the permission.');
    } else if (status == PermissionStatus.permanentlyDenied) {
      print('Take the user to the settings page.');
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    setPermissions();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      drawer: const AppDrawer(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.location_on),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(label: '', icon: Icon(Icons.phone)),
          BottomNavigationBarItem(label: '', icon: Icon(Icons.search)),
        ],
        onTap: (index) {
          switch (index) {
            case 0:
              break;
            case 1:
              Navigator.pushNamed(context, SearchHospital.routeName);
              break;
            default:
              break;
          }
        },
      ),
      body: FutureBuilder<bool>(
          future: Hospital().setHospital(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } /*else if (snapshot.hasError) {
              print(snapshot.data);
              return const Center(
                child: Text('Something went wrong!'),
              );
            } */
            else {
              return SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.all(8),
                      height: size.height / 2,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(
                          color: Theme.of(context).primaryColor,
                          width: 2,
                        ),
                      ),
                      child: const Center(
                        child: HomeMap(),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(
                          color: Theme.of(context).primaryColor,
                          width: 2,
                        ),
                      ),
                      child: ListView(
                        shrinkWrap: true,
                        children: [
                          ListTile(
                            onTap: () {
                              Navigator.pushNamed(
                                  context, TrackAmbulance.routeName);
                            },
                            title: const Text('Track Ambulance'),
                            leading: const Icon(Icons.add_location_rounded),
                          ),
                          Divider(
                            height: 0,
                            color: Theme.of(context).primaryColor,
                            thickness: 2,
                          ),
                          ListTile(
                            onTap: () {
                              Navigator.pushNamed(
                                  context, CompareHospital.routeName);
                            },
                            title: const Text('Compare Hospitals'),
                            leading: const Icon(Icons.apartment_rounded),
                          ),
                          Divider(
                            height: 0,
                            color: Theme.of(context).primaryColor,
                            thickness: 2,
                          ),
                          ListTile(
                            onTap: () {},
                            title: const Text('Beds Availability'),
                            leading: const Icon(Icons.hotel),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }
          }),
    );
  }
}
