import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class AdminDriver extends StatelessWidget {
  static const routeName = '/admin-driver';
  const AdminDriver({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _key = GlobalKey<FormState>();
    var id, name, driverId, mobile;
    driverId = const Uuid().v4().substring(0, 23);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Driver'),
      ),
      body: SingleChildScrollView(
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
                    driverId,
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
                            .collection('admin/hospitals/verified/$id/drivers')
                            .doc(driverId)
                            .set({
                          'name': name,
                          'mobile': mobile,
                        });
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content:
                                    Text('Driver request sent successfully')));
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
      ),
    );
  }
}
