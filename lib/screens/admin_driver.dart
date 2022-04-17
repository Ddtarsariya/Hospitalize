import 'package:background_location/background_location.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class AdminDriver extends StatefulWidget {
  static const routeName = '/admin-driver';

  const AdminDriver({Key? key}) : super(key: key);

  @override
  State<AdminDriver> createState() => _AdminDriverState();
}

class _AdminDriverState extends State<AdminDriver> {
  void setLiveLocation(String clientId) async {
    await BackgroundLocation.setAndroidNotification(
      title: 'Background service is running',
      message: 'Background location in progress',
      icon: '@mipmap/ic_launcher',
    );
    /*await BackgroundLocation.setAndroidConfiguration(5);*/
    /*await BackgroundLocation.startLocationService(distanceFilter: 0);*/
    await BackgroundLocation.startLocationService();
    BackgroundLocation.getLocationUpdates((location) async {
      /*Future.value(LatLng(location.latitude!, location.longitude!));*/
      /*LatLng loc = await getLocation(location);*/
      if (location.longitude != null) {
        FirebaseFirestore.instance
            .collection('users/$clientId/ambulance')
            .doc('tracking')
            .set({
          'location': GeoPoint(location.latitude!, location.longitude!),
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final _key = GlobalKey<FormState>();
    var id, name, driverId, mobile;
    final email = FirebaseAuth.instance.currentUser!.email;
    driverId = const Uuid().v4().substring(0, 23);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Driver'),
      ),
      body: FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
          future: FirebaseFirestore.instance
              .collection('admin/hospitals/drivers')
              .doc(email)
              .get(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.data!.exists) {
              return Card(
                shape: Border.all(
                  width: 2,
                  color: Theme.of(context).primaryColor,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.label),
                          const SizedBox(width: 10),
                          Text(
                            snapshot.data!.get('hospitalId'),
                            style: const TextStyle(fontSize: 20),
                          ),
                        ],
                      ),
                      const Divider(),
                      Text(
                        "Name : " + snapshot.data!.get('name'),
                        style: const TextStyle(fontSize: 20),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        "Your Id : $email",
                        style: const TextStyle(fontSize: 20),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        "Mobile : " + snapshot.data!.get('mobile'),
                        style: const TextStyle(fontSize: 20),
                      ),
                      const SizedBox(height: 10),
                      ElevatedButton(
                          onPressed: () {
                            showDialog(
                                context: context,
                                builder: (ctx) {
                                  var clientId = '';
                                  return Dialog(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.stretch,
                                        children: [
                                          TextFormField(
                                            validator: (value) {
                                              if (value == null ||
                                                  value.isEmpty) {
                                                return 'Please enter ID';
                                              }
                                              return null;
                                            },
                                            textInputAction:
                                                TextInputAction.next,
                                            onChanged: (val) {
                                              clientId = val;
                                            },
                                            decoration: InputDecoration(
                                              label: const Text('Enter ID'),
                                              border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                              ),
                                            ),
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              const Text('Current Location'),
                                              OutlinedButton(
                                                onPressed: () async {
                                                  setLiveLocation(clientId);
                                                },
                                                child:
                                                    const Text('Add Location'),
                                              ),
                                            ],
                                          ),
                                          ElevatedButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child: const Text('Submit'),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                });
                          },
                          child: const Text('Add ambulance Tracking ID')),
                      ElevatedButton(
                        onPressed: () async {
                          await BackgroundLocation.stopLocationService();
                        },
                        child: const Text('Stop service'),
                      ),
                    ],
                  ),
                ),
              );
            } else {
              return SingleChildScrollView(
                child: Container(
                  padding: const EdgeInsets.all(10),
                  child: Form(
                    key: _key,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter hospital id';
                            }
                            return null;
                          },
                          textInputAction: TextInputAction.next,
                          onChanged: (val) {
                            id = val;
                          },
                          decoration: InputDecoration(
                            label: const Text('Enter id of Hospital'),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter name';
                            }
                            return null;
                          },
                          textInputAction: TextInputAction.next,
                          onChanged: (val) {
                            name = val;
                          },
                          decoration: InputDecoration(
                            label: const Text('Enter name'),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter mobile number';
                            }
                            return null;
                          },
                          textInputAction: TextInputAction.next,
                          onChanged: (val) {
                            mobile = val;
                          },
                          decoration: InputDecoration(
                            label: const Text('Enter Mobile No.'),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                          keyboardType: TextInputType.phone,
                        ),
                        const SizedBox(height: 10),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(width: 1),
                          ),
                          padding: const EdgeInsets.all(8),
                          child: Text(
                            email!,
                            style: const TextStyle(fontSize: 20),
                          ),
                        ),
                        const SizedBox(height: 10),
                        ElevatedButton(
                          onPressed: () async {
                            if (_key.currentState!.validate()) {
                              var isAvailable = await FirebaseFirestore.instance
                                  .collection('admin/hospitals/verified')
                                  .doc(id)
                                  .get();
                              if (isAvailable.exists) {
                                FirebaseFirestore.instance
                                    .collection('admin/hospitals/drivers')
                                    .doc(email)
                                    .set({
                                  'name': name,
                                  'mobile': mobile,
                                  'hospitalId': id,
                                });
                                ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text(
                                            'Driver request sent successfully')));
                                Navigator.pop(context);
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text('Hospital not found!')));
                              }
                            }
                          },
                          child: const Text('Request for Register'),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }
          }),
    );
  }
}
