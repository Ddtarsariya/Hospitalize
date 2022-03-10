import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hospitalize/models/hospital.dart';
import 'package:hospitalize/screens/add_hospital_detail.dart';

class AdminScreen extends StatefulWidget {
  final bool isPending;
  static const routeName = '/admin-screen';

  const AdminScreen({Key? key, this.isPending = false}) : super(key: key);

  @override
  State<AdminScreen> createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  final user = FirebaseAuth.instance.currentUser;
  bool booking = false;

  RoundedRectangleBorder get cardShape {
    return RoundedRectangleBorder(
      side: BorderSide(color: Theme.of(context).primaryColor, width: 2),
      borderRadius: BorderRadius.circular(5),
    );
  }

  @override
  Widget build(BuildContext context) {
    print('%%%%%%%%%%%%%');
    print(widget.isPending);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin'),
      ),
      body: FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
        future: Hospital().getHospital(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.data == null || !snapshot.data!.exists) {
            return PendingForDetail(
                resetScreen: () => setState(() {
                      print('.......................??');
                    }));
          } else {
            final data = snapshot.data;
            print(snapshot.data?.get('name'));
            return Card(
              margin: const EdgeInsets.all(10),
              shape: cardShape,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Icon(Icons.label_off),
                        ),
                        Expanded(
                          child: Text(data?.get('name')),
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.edit),
                        ),
                      ],
                    ),
                    const Divider(thickness: 1),
                    const SizedBox(height: 10),
                    Text(data?.get('address')),
                    const SizedBox(height: 10),
                    Card(
                      shape: cardShape,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: IntrinsicHeight(
                          child: Row(
                            children: [
                              const Icon(Icons.phone),
                              const VerticalDivider(color: Colors.black),
                              Expanded(child: Text(data?.get('mobile'))),
                              const VerticalDivider(color: Colors.black),
                              Expanded(child: Text(data?.get('mobile'))),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          flex: 5,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Card(
                                shape: cardShape,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: IntrinsicHeight(
                                    child: Row(
                                      children: [
                                        const Icon(Icons.bed),
                                        const VerticalDivider(),
                                        Text(
                                            '${data?.get('available_beds')} / ${data?.get('beds')}'),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 20),
                              OutlinedButton.icon(
                                onPressed: () {},
                                label: const Text('Edit Location'),
                                icon: const Icon(Icons.add_location),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          flex: 6,
                          child: Card(
                            shape: cardShape,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  const Text('Appointment Booking'),
                                  Divider(
                                    color: Theme.of(context).primaryColor,
                                    thickness: 2,
                                    height: 30,
                                  ),
                                  Row(
                                    children: [
                                      const Text('Block'),
                                      AppointBookingSwitch(
                                          isBooking: data?.get('booking')),
                                      const Text('Available'),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          final request = FirebaseFirestore.instance
              .collection('users/hospitals/verified')
              .doc(user?.email);
          request.set({
            'name': 'Hospital name',
            'location': 'locationsss',
            'mobile': '9876543210',
            'email': user?.email ?? 'tarsashaj',
            'ratings': '6.5',
            'beds': '9',
            'available_beds': '1',
            'address': '.amb as dh asjdg address',
            'verified': 'Yes',
          });
        },
      ),
    );
  }
}

class AppointBookingSwitch extends StatefulWidget {
  const AppointBookingSwitch({Key? key, required this.isBooking})
      : super(key: key);
  final bool? isBooking;

  @override
  _AppointBookingSwitchState createState() => _AppointBookingSwitchState();
}

class _AppointBookingSwitchState extends State<AppointBookingSwitch> {
  late bool? booking;
  final user = FirebaseAuth.instance.currentUser;

  @override
  void initState() {
    booking = widget.isBooking;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Switch(
        value: booking ?? false,
        onChanged: (val) {
          final hos = FirebaseFirestore.instance
              .collection('users/hospitals/verified')
              .doc(user?.email);
          hos.update({
            'booking': val,
          });
          setState(() {
            booking = val;
          });
        });
  }
}

class PendingForDetail extends StatelessWidget {
  final Function resetScreen;

  const PendingForDetail({
    Key? key,
    required this.resetScreen,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      margin: const EdgeInsets.all(5),
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        border: Border.all(
          width: 1,
        ),
        color: Colors.lightGreen,
      ),
      child: Row(
        children: [
          const Icon(Icons.info),
          const SizedBox(width: 6),
          const Flexible(
            child: Text(
              "Your hospital isn't appear, add more details of your hospital",
              overflow: TextOverflow.visible,
            ),
          ),
          const VerticalDivider(),
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              Navigator.pushNamed(context, AddHospitalDetail.routeName)
                  .then((value) => resetScreen());
            },
          ),
        ],
      ),
    );
  }
}
