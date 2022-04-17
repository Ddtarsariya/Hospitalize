import 'package:flutter/material.dart';

import '../screens/book_appointment.dart';
import '../utils/constant.dart';

class CompareHospitalCard extends StatelessWidget {
  final Map<String, dynamic> data;
  const CompareHospitalCard({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).primaryColor;
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              const Icon(Icons.eighteen_mp),
              const SizedBox(width: 10),
              Expanded(
                  child: Text(
                data['name'] ?? '',
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              )),
              const Icon(Icons.grade_outlined),
              const SizedBox(width: 5),
              Text(data['ratings'] ?? ''),
            ],
          ),
          Divider(
            color: color,
            thickness: 2,
          ),
          const SizedBox(height: 10),
          Text(data['address'] ?? ''),
          const SizedBox(height: 15),
          Card(
            shape: cardShape,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: IntrinsicHeight(
                child: Row(
                  children: [
                    const Icon(Icons.phone),
                    const VerticalDivider(color: Colors.black),
                    Expanded(child: Text(data['mobile'] ?? '')),
                    const VerticalDivider(color: Colors.black),
                    Expanded(child: Text(data['mobile'] ?? '')),
                  ],
                ),
              ),
            ),
          ),
          Divider(
            color: color,
          ),
          Row(
            children: [
              Expanded(
                child: Card(
                  shape: cardShape,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: IntrinsicHeight(
                      child: Row(
                        children: [
                          const Icon(Icons.bed),
                          const VerticalDivider(),
                          Text('${data['available_beds']} / ${data['beds']}'),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: OutlinedButton(
                  onPressed: () {
                    if (data['booking']) {
                      Navigator.pushNamed(context, BookAppointment.routeName,
                          arguments: data);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text(
                              'For this hospital appointment booking unavailable!')));
                    }
                  },
                  child: const Text('Book appointment'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
