import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AddHospitalDetail extends StatelessWidget {
  static const routeName = '/add-hospital-detail';

  const AddHospitalDetail({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _key = GlobalKey<FormState>();
    String? name, address, mobileNo, apMobNo, beds, availableBeds;
    final user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Add hospital detail'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: _key,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextFormField(
                  textInputAction: TextInputAction.next,
                  onChanged: (val) {
                    name = val;
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter Hospital name';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    label: const Text('Enter name of Hospital'),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  textInputAction: TextInputAction.next,
                  onChanged: (val) {
                    address = val;
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter Hospital address';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    label: const Text('Enter Address'),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  textInputAction: TextInputAction.next,
                  onChanged: (val) {
                    mobileNo = val;
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter Mobile number';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    label: const Text('Enter Mobile number'),
                    prefixIcon: const Icon(Icons.phone),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                  keyboardType: TextInputType.phone,
                ),
                const SizedBox(height: 10),
                TextFormField(
                  textInputAction: TextInputAction.next,
                  onChanged: (val) {
                    apMobNo = val;
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter Mobile number';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    label: const Text('Enter Appointment number'),
                    prefixIcon: const Icon(Icons.call),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                  keyboardType: TextInputType.phone,
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        textInputAction: TextInputAction.next,
                        onChanged: (val) {
                          beds = val;
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter total beds';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          label: const Text('Total beds'),
                          prefixIcon: const Icon(Icons.bed),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                        keyboardType: TextInputType.number,
                      ),
                    ),
                    const SizedBox(width: 5),
                    Expanded(
                      child: TextFormField(
                        textInputAction: TextInputAction.next,
                        onChanged: (val) {
                          availableBeds = val;
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter available beds';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          label: const Text('Available beds'),
                          prefixIcon: const Icon(Icons.bed_sharp),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                        keyboardType: TextInputType.number,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                InkWell(
                  onTap: () {},
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(width: 1),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: const [
                          Icon(Icons.add_location),
                          Text('Add Location'),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    if (name != null) print(name);
                    if (_key.currentState!.validate()) {
                      final request = FirebaseFirestore.instance
                          .collection('users/hospitals/verified')
                          .doc(user?.email);
                      request.set({
                        'name': name,
                        'location': 'Location....',
                        'mobile': mobileNo,
                        'email': user?.email ?? 'tarsashaj',
                        'ratings': '0',
                        'beds': beds,
                        'available_beds': availableBeds,
                        'address': address,
                        'verified': 'Yes',
                        'booking': false,
                      });
                      FirebaseFirestore.instance
                          .collection('users/hospitals/requests')
                          .doc(user?.email)
                          .delete();
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text(
                              'Your hospital details added successfully')));
                      Navigator.pop(context);
                    }
                  },
                  child: const Text('Submit'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
