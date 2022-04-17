import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hospitalize/models/appointment.dart';

class BookedAppointments extends StatelessWidget {
  static const routeName = '/booked-appointments';
  final List<Appointment>? appointment;

  const BookedAppointments({Key? key, this.appointment}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final email = FirebaseAuth.instance.currentUser!.email;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Booked Appointments'),
      ),
      body: FutureBuilder<QuerySnapshot<Map<String, dynamic>>>(
        future: FirebaseFirestore.instance
            .collection('admin/hospitals/verified/$email/appointment')
            .get(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.data == null || snapshot.data!.docs.isEmpty) {
            return const Center(
              child: Text('Yet not get any appointments!'),
            );
          } else {
            print("-------------- ${snapshot.data!.docs.isEmpty}");
            return ListView.builder(
              itemCount: snapshot.data!.size,
              itemBuilder: (ctx, index) {
                var da = (snapshot.data!.docs[index].get('date') as Timestamp)
                    .toDate();
                var appointmentDate = (da.year.toString() +
                    '-' +
                    da.month.toString() +
                    '-' +
                    da.day.toString());
                return Container(
                  margin: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(),
                  ),
                  child: ListTile(
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        builder: (context) {
                          return Container(
                            margin: const EdgeInsets.only(
                                left: 8, right: 8, top: 5, bottom: 15),
                            decoration: BoxDecoration(
                              border: Border.all(),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: ListView(
                              shrinkWrap: true,
                              children: [
                                const Padding(
                                  padding: EdgeInsets.all(15.0),
                                  child: Text(
                                    'Appointment',
                                    style: TextStyle(fontSize: 20),
                                  ),
                                ),
                                DataTable(
                                  headingRowHeight: 0,
                                  columns: [
                                    DataColumn(label: Container()),
                                    DataColumn(label: Container()),
                                  ],
                                  rows: [
                                    DataRow(
                                      cells: [
                                        const DataCell(
                                          Text('Name'),
                                        ),
                                        DataCell(
                                          Text(snapshot.data!.docs[index]
                                              .get('name')),
                                        ),
                                      ],
                                    ),
                                    DataRow(
                                      cells: [
                                        const DataCell(
                                          Text('Disease'),
                                        ),
                                        DataCell(
                                          Text(snapshot.data!.docs[index]
                                              .get('disease')),
                                        ),
                                      ],
                                    ),
                                    DataRow(
                                      cells: [
                                        const DataCell(
                                          Text('Mobile No..'),
                                        ),
                                        DataCell(
                                          Text(snapshot.data!.docs[index]
                                              .get('mobile')),
                                        ),
                                      ],
                                    ),
                                    DataRow(
                                      cells: [
                                        const DataCell(
                                          Text('Date'),
                                        ),
                                        DataCell(
                                          Text(appointmentDate),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: OutlinedButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: const Text('Close')),
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    },
                    title: Text(snapshot.data!.docs[index].get('name')),
                    subtitle: Text(snapshot.data!.docs[index].get('disease')),
                    trailing: Text(appointmentDate),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
