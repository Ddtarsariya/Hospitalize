import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class BedsAvailability extends StatelessWidget {
  static const routeName = '/beds-availability';

  const BedsAvailability({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Beds Availability'),
      ),
      body: FutureBuilder<QuerySnapshot<Map<String, dynamic>>>(
          future: FirebaseFirestore.instance
              .collection('admin/hospitals/verified')
              .get(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return ListView.builder(
                  itemCount: snapshot.data!.size,
                  itemBuilder: (ctx, index) {
                    var data = snapshot.data!.docs[index];
                    return Container(
                      margin: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        border: Border.all(),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: ListTile(
                        title: Expanded(child: Text(data.get('name'))),
                        leading: const CircleAvatar(
                          child: Text(
                            'H',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        subtitle: Expanded(child: Text(data.get('address'))),
                        trailing: IntrinsicHeight(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Expanded(
                                flex: 4,
                                child: Container(
                                  width: 45,
                                  decoration: BoxDecoration(
                                    border: Border.all(),
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                  child: Center(
                                    child: FittedBox(
                                        child:
                                            Text(data.get('available_beds'))),
                                  ),
                                ),
                              ),
                              const Expanded(
                                  child: FittedBox(child: Text('Beds'))),
                            ],
                          ),
                        ),
                      ),
                    );
                  });
            }
          }),
    );
  }
}
