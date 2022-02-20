import 'package:flutter/material.dart';
import 'package:hospitalize/screens/compare_hospital.dart';
import 'package:hospitalize/screens/track_ambulance.dart';

import '../widgets/app_drawer.dart';

class Home extends StatelessWidget {
  static const routeName = '/home';
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
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
      ),
      body: SingleChildScrollView(
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
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(
                      Icons.map_outlined,
                      size: 70,
                      color: Colors.orange,
                    ),
                    Text('Map'),
                  ],
                ),
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
                      Navigator.pushNamed(context, TrackAmbulance.routeName);
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
                      Navigator.pushNamed(context, CompareHospital.routeName);
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
      ),
    );
  }
}
