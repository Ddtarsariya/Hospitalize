import 'package:flutter/material.dart';
import 'package:hospitalize/models/hospital.dart';

class Register extends StatelessWidget {
  static const routeName = '/register-screen';
  final Function? toggleView;

  const Register({Key? key, this.toggleView}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register'),
      ),
      body: FutureBuilder(
          future: Hospital().requestStatus(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.data == 'No') {
              return const Center(
                child: Text('Pending'),
              );
            } else if (snapshot.data == 'Yes') {
              return const Center(
                child: Text('Verified'),
              );
            }
            return Container(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TextField(
                    decoration: InputDecoration(
                      label: const Text('Enter name of Hospital'),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    decoration: InputDecoration(
                      label: const Text('Enter Mobile No.'),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    keyboardType: TextInputType.phone,
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    decoration: InputDecoration(
                      label: const Text('Total beds'),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    keyboardType: TextInputType.number,
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    decoration: InputDecoration(
                      label: const Text('Location'),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    decoration: InputDecoration(
                      label: const Text('Email'),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    keyboardType: TextInputType.emailAddress,
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    decoration: InputDecoration(
                      label: const Text('Ratings'),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    keyboardType: TextInputType.number,
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () {
                      Hospital(
                        availableBeds: '1',
                        beds: '12',
                        email: 'tarsariyadd@gmail.com',
                        location: 'location',
                        mobile: '9876543210',
                        name: 'name',
                        ratings: '5',
                      ).requestForRegister();
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content:
                              Text('Your request has been sent successfully')));
                    },
                    child: const Text('Request for Register'),
                  ),
                  /*TextButton(
                  onPressed: () {
                    */ /*Navigator.pushNamed(context, Login.routeName);*/ /*
                    toggleView!();
                  },
                  child: const Text('Already Register? Login Here'),
                ),*/
                ],
              ),
            );
          }),
    );
  }
}
