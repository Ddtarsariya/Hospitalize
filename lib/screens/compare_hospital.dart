import 'package:flutter/material.dart';

class CompareHospital extends StatelessWidget {
  static const routeName = '/compare-hospital';
  const CompareHospital({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Compare Hospital'),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.all(10),
          child: Column(
            children: [
              Column(
                children: [
                  TextField(
                    decoration: InputDecoration(
                      label: const Text('Enter name of Hospital'),
                      icon: const Icon(Icons.apartment_rounded),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    decoration: InputDecoration(
                      label: const Text('Enter name of Hospital'),
                      icon: const Icon(Icons.apartment_rounded),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Container(
                height: MediaQuery.of(context).size.height / 1.5,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(
                    color: Theme.of(context).primaryColor,
                    width: 2,
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: const [
                    Icon(
                      Icons.apartment_rounded,
                      size: 70,
                    ),
                    Divider(
                      color: Colors.red,
                    ),
                    Icon(
                      Icons.apartment_rounded,
                      size: 70,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}
