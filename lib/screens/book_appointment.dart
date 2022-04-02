import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hospitalize/utils/constant.dart';

import '../models/hospital.dart';

class BookAppointment extends StatefulWidget {
  static const routeName = '/book-appointment';

  const BookAppointment({Key? key}) : super(key: key);

  @override
  State<BookAppointment> createState() => _BookAppointmentState();
}

class _BookAppointmentState extends State<BookAppointment> {
  String? name, mobileNo, gender, disease, address;
  late Hospital hospital;
  final _key = GlobalKey<FormState>();
  DateTime? selectedDate;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    hospital = ModalRoute.of(context)!.settings.arguments as Hospital;
  }

  Future<DateTime?> _pickAppointmentDate() async {
    return await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime(2040),
        helpText: "SELECT BOOKING DATE",
        cancelText: "CANCEL",
        confirmText: "BOOK");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Book an Appointment'),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.all(10),
          child: Form(
            key: _key,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your name';
                    }
                    return null;
                  },
                  textInputAction: TextInputAction.next,
                  onChanged: (val) {
                    name = val;
                  },
                  decoration: InputDecoration(
                    label: const Text('Name'),
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
                    mobileNo = val;
                  },
                  decoration: InputDecoration(
                    label: const Text('Mobile Number'),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your address';
                    }
                    return null;
                  },
                  textInputAction: TextInputAction.next,
                  onChanged: (val) {
                    address = val;
                  },
                  decoration: InputDecoration(
                    label: const Text('Address'),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your disease';
                    }
                    return null;
                  },
                  textInputAction: TextInputAction.next,
                  onChanged: (val) {
                    disease = val;
                  },
                  decoration: InputDecoration(
                    label: const Text('Disease'),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                InkWell(
                  onTap: () async {
                    selectedDate = await _pickAppointmentDate();
                    if (selectedDate != null) {
                      setState(() {});
                    }
                  },
                  child: Card(
                    shape: cardShape,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        children: [
                          const Icon(Icons.date_range),
                          const SizedBox(width: 10),
                          const Expanded(child: Text('Pick a date')),
                          Text(
                            selectedDate != null
                                ? '${selectedDate!.day}-${selectedDate!.month}-${selectedDate!.year}'
                                : 'Not any Date picked',
                            style: TextStyle(
                                color: selectedDate != null
                                    ? Theme.of(context).primaryColor
                                    : Colors.grey),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    if (_key.currentState!.validate() && selectedDate != null) {
                      final user = FirebaseAuth.instance.currentUser;
                      var data = {
                        'name': name,
                        'mobile': mobileNo,
                        'email': user!.email,
                        'address': address,
                        'disease': disease,
                        'date': selectedDate,
                      };
                      final setRequest = FirebaseFirestore.instance.collection(
                          'admin/hospitals/verified/${hospital.email}/appointment');
                      final setDataInUser = FirebaseFirestore.instance
                          .collection('users/${user.email}/appointment');
                      setRequest.doc().set(data);
                      setDataInUser.doc().set(data);
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text(
                              'Your appointment is booked successfully!')));
                      Navigator.pop(context);
                    }
                  },
                  child: const Text('Book an appointment'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
