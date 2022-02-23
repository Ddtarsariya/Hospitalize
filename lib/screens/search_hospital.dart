import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hospitalize/models/hospital.dart';
import 'package:hospitalize/widgets/hospital_card.dart';

class SearchHospital extends StatelessWidget {
  const SearchHospital({Key? key}) : super(key: key);
  static const routeName = '/search-hospital';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search Hospital'),
        actions: const [
          Padding(
            padding: EdgeInsets.all(15.0),
            child: Icon(Icons.search),
          ),
        ],
      ),
      body: FutureBuilder<List<QueryDocumentSnapshot<Map<String, dynamic>>>>(
          future: Hospital().hospitals(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return const Center(child: Text('Something went wrong!'));
            } else {
              snapshot.data!
                  .removeWhere((element) => element['verified'] == 'No');
              return ListView.builder(
                itemCount: snapshot.data?.length,
                itemBuilder: (ctx, index) {
                  final data = snapshot.data!.elementAt(index).data();
                  return HospitalCard(data: data);
                },
              );
            }
          }),
    );
  }
}
