import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Hospital {
  final String? name;
  final String? ratings;
  final String? location;
  final String? mobile;
  final String? email;
  final String? beds;
  final String? availableBeds;

  Hospital(
      {this.name,
      this.ratings,
      this.location,
      this.mobile,
      this.email,
      this.beds,
      this.availableBeds});

  /* users/hospitals/requests/request */

  /* users/hospitals/list */

  Future<void> requestForRegister() async {
    final user = FirebaseAuth.instance.currentUser;
    final request = FirebaseFirestore.instance
        .collection('users/hospitals/requests')
        .doc(user!.email);
    request.set({
      'name': name,
      'location': location,
      'mobile': mobile,
      'email': email,
      'ratings': ratings,
      'beds': beds,
      'available_beds': availableBeds,
      'verified': 'No',
    });
  }

  Future<String> requestStatus() async {
    final user = FirebaseAuth.instance.currentUser;
    final request = await FirebaseFirestore.instance
        .collection('users/hospitals/requests')
        .doc(user!.email)
        .get();
    if (request.exists) {
      return request.get('verified');
    } else {
      return 'unknown';
    }
  }
}
