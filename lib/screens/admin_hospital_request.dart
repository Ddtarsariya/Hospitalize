import 'package:flutter/material.dart';
import 'package:hospitalize/models/hospital.dart';

class AdminHospitalRequest extends StatelessWidget {
  static const routeName = '/admin-hospital-request';
  final Widget? childWidget;

  const AdminHospitalRequest({Key? key, @required this.childWidget})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _key = GlobalKey<FormState>();
    String? name, mobile, beds, location, address;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Request'),
      ),
      body: childWidget == null
          ? SingleChildScrollView(
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
                            return 'Please enter hospital name';
                          }
                          return null;
                        },
                        textInputAction: TextInputAction.next,
                        onChanged: (val) {
                          name = val;
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
                          label: const Text('Enter Mobile No.'),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                        keyboardType: TextInputType.phone,
                      ),
                      const SizedBox(height: 10),
                      TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter total beds';
                          }
                          return null;
                        },
                        textInputAction: TextInputAction.next,
                        onChanged: (val) {
                          beds = val;
                        },
                        decoration: InputDecoration(
                          label: const Text('Total beds'),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                        keyboardType: TextInputType.number,
                      ),
                      const SizedBox(height: 10),
                      TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter location';
                          }
                          return null;
                        },
                        textInputAction: TextInputAction.next,
                        onChanged: (val) {
                          location = val;
                        },
                        decoration: InputDecoration(
                          label: const Text('Location'),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      ElevatedButton(
                        onPressed: () {
                          if (_key.currentState!.validate()) {
                            Hospital(
                              availableBeds: '0',
                              beds: beds,
                              location: 'location',
                              mobile: mobile,
                              name: name,
                              ratings: '0',
                              address: address,
                            ).requestForRegister();
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text(
                                        'Your request has been sent successfully')));
                            Navigator.pop(context);
                          }
                        },
                        child: const Text('Request for Register'),
                      ),
                    ],
                  ),
                ),
              ),
            )
          : Center(
              child: childWidget,
            ),
    );
  }
}
