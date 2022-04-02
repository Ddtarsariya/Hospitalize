import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

enum Status {
  fullyVerified,
  verified,
  pending,
  pendingForDetail,
  unknown,
}

class Hospital {
  final String? uid;
  final String? name;
  final String? ratings;
  final String? location;
  final String? address;
  final String? mobile;
  final String? email;
  final String? beds;
  final String? availableBeds;
  final String? verified;
  final bool? isBookingAvailable;

  Hospital({
    this.uid,
    this.isBookingAvailable,
    this.name,
    this.ratings,
    this.location,
    this.address,
    this.mobile,
    this.email,
    this.beds,
    this.availableBeds,
    this.verified,
  });

  static List<Hospital> hospitalsList = [];

  Future<bool> setHospital() async {
    final hospital =
        FirebaseFirestore.instance.collection('admin/hospitals/verified');
    await hospital.get().then((value) {
      hospitalsList = value.docs
          .map((e) {
            return Hospital(
              ratings: e['ratings'],
              uid: e['uid'],
              name: e['name'],
              mobile: e['mobile'],
              location: e['location'],
              email: e['email'],
              beds: e['beds'],
              availableBeds: e['available_beds'],
              address: e['address'],
              verified: e['verified'],
              isBookingAvailable: e['booking'],
            );
          })
          .where((element) => element.verified == 'Yes')
          .toList();
    });
    return true;
  }

  /* users/hospitals/requests/request */

  /* users/hospitals/list */

  Future<void> requestForRegister() async {
    final user = FirebaseAuth.instance.currentUser;
    final request = FirebaseFirestore.instance
        .collection('admin/hospitals/requests')
        .doc(user!.email);
    request.set({
      'name': name,
      'location': location,
      'mobile': mobile,
      'email': user.email,
      'ratings': ratings,
      'beds': beds,
      'available_beds': availableBeds,
      'address': address,
      'verified': 'No',
    });
  }

  Future<Status> requestStatus() async {
    final user = FirebaseAuth.instance.currentUser;
    Status status = Status.unknown;
    final request = await FirebaseFirestore.instance
        .collection('admin/hospitals/verified')
        .doc(user!.email)
        .get();
    if (request.exists) {
      var verified = request.get('verified');
      if (verified == 'Yes') {
        status = Status.fullyVerified;
      } else {
        status = Status.pendingForDetail;
      }
    } else {
      await FirebaseFirestore.instance
          .collection('admin/hospitals/requests')
          .doc(user.email)
          .get()
          .then((value) {
        if (value.exists) {
          if (value['verified'] == 'Yes') {
            status = Status.pendingForDetail;
          } else {
            status = Status.pending;
          }
        } else {
          status = Status.unknown;
        }
      });
    }
    return status;
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> getHospital() async {
    final user = FirebaseAuth.instance.currentUser;
    return await FirebaseFirestore.instance
        .collection('admin/hospitals/verified')
        .doc(user!.email)
        .get();
  }

  Future<List<QueryDocumentSnapshot<Map<String, dynamic>>>> hospitals() async {
    final hospital =
        FirebaseFirestore.instance.collection('admin/hospitals/requests');
    final list = await hospital.get();
    return list.docs;
  }
}
