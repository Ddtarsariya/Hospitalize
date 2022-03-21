import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AdminEdit extends StatelessWidget {
  static const routeName = '/admin-edit';

  const AdminEdit({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _key = GlobalKey<FormState>();
    String? name, mobile, hMobile, beds, location, address;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Edit'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Form(
            key: _key,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
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
                    label: const Text('Enter hospital name'),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter address';
                    }
                    return null;
                  },
                  textInputAction: TextInputAction.next,
                  onChanged: (val) {
                    address = val;
                  },
                  decoration: InputDecoration(
                    label: const Text('Enter address'),
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
                    label: const Text('Enter mobile number'),
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
                    hMobile = val;
                  },
                  decoration: InputDecoration(
                    label: const Text('Enter mobile number'),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    final email = FirebaseAuth.instance.currentUser!.email;
                    Map<String, String?> data = {};
                    if (name != null) data.putIfAbsent('name', () => name);
                    if (address != null) {
                      data.putIfAbsent('address', () => address);
                    }
                    if (mobile != null) {
                      data.putIfAbsent('mobile', () => mobile);
                    }
                    print(data);
                    FirebaseFirestore.instance
                        .collection('users')
                        .doc('hospitals')
                        .collection('verified')
                        .doc(email!)
                        .update(data);
                    Navigator.pop(context, data.isNotEmpty ? true : null);
                  },
                  child: const Text('Save'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
