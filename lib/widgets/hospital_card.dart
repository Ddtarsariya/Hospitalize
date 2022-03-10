import 'package:flutter/material.dart';
import 'package:hospitalize/screens/book_appointment.dart';

import '../models/hospital.dart';

class HospitalCard extends StatelessWidget {
  final Hospital data;
  const HospitalCard({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(10),
      shape: RoundedRectangleBorder(
        side: BorderSide(color: Theme.of(context).primaryColor, width: 2),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.eighteen_mp),
                const SizedBox(width: 10),
                Expanded(child: Text(data.name ?? '')),
                const Icon(Icons.grade_outlined),
                const SizedBox(width: 5),
                Text(data.ratings ?? ''),
              ],
            ),
            Divider(
              color: Theme.of(context).primaryColor,
              thickness: 2,
            ),
            const SizedBox(height: 10),
            Text(data.address ?? ''),
            const SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Icon(Icons.local_phone),
                    const SizedBox(width: 5),
                    Text(data.mobile ?? ''),
                  ],
                ),
                Row(
                  children: [
                    const Icon(Icons.local_phone),
                    const SizedBox(width: 5),
                    Text(data.mobile ?? ''),
                  ],
                )
              ],
            ),
            const Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Icon(Icons.location_on_outlined),
                    const SizedBox(width: 5),
                    OutlinedButton(
                        onPressed: () {}, child: const Text('Location')),
                  ],
                ),
                const VerticalDivider(),
                Row(
                  children: [
                    const Icon(Icons.add_box_rounded),
                    const SizedBox(width: 5),
                    OutlinedButton(
                        onPressed: () {
                          if (data.isBookingAvailable!) {
                            Navigator.pushNamed(
                                context, BookAppointment.routeName);
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text(
                                        'For this hospital appointment booking unavailable!')));
                          }
                        },
                        child: const Text('Book appointment')),
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
