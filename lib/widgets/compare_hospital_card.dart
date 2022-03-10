import 'package:flutter/material.dart';

import '../models/hospital.dart';

class CompareHospitalCard extends StatelessWidget {
  final Hospital data;
  const CompareHospitalCard({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                data.name ?? '',
                style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),
              )),
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
        ],
      ),
    );
  }
}
