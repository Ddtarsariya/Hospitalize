import 'package:flutter/material.dart';
import 'package:hospitalize/screens/search_hospital.dart';
import 'package:hospitalize/widgets/compare_hospital_card.dart';

class CompareHospital extends StatefulWidget {
  static const routeName = '/compare-hospital';

  const CompareHospital({Key? key}) : super(key: key);

  @override
  State<CompareHospital> createState() => _CompareHospitalState();
}

class _CompareHospitalState extends State<CompareHospital> {
  Map<String, dynamic> _hospital1 = {};
  Map<String, dynamic> _hospital2 = {};
  bool _hospital1Close = true;
  bool _hospital2Close = true;

  RoundedRectangleBorder get cardShape {
    return RoundedRectangleBorder(
      side: BorderSide(color: Theme.of(context).primaryColor, width: 2),
      borderRadius: BorderRadius.circular(5),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Compare Hospital'),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.all(10),
          child: ListView(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            children: [
              Card(
                shape: cardShape,
                child: Column(
                  mainAxisAlignment: _hospital1Close
                      ? MainAxisAlignment.center
                      : MainAxisAlignment.start,
                  children: [
                    Visibility(
                      visible: !_hospital1Close,
                      child: Align(
                        alignment: Alignment.topRight,
                        child: Card(
                          margin: const EdgeInsets.only(right: 10, top: 10),
                          color: Colors.red,
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                _hospital1Close = true;
                              });
                            },
                            child: const Icon(
                              Icons.close,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Visibility(
                      visible: _hospital1Close,
                      child: SizedBox(
                        height: 250,
                        width: double.maxFinite,
                        child: InkWell(
                          onTap: () {
                            Navigator.pushNamed(
                                    context, SearchHospital.routeName,
                                    arguments: true)
                                .then((value) {
                              if (value != null) {
                                _hospital1 = value as Map<String, dynamic>;
                                setState(() {
                                  _hospital1Close = false;
                                });
                              }
                            });
                          },
                          child: const Icon(
                            Icons.apartment_rounded,
                            size: 70,
                          ),
                        ),
                      ),
                      replacement: CompareHospitalCard(
                        data: _hospital1,
                      ),
                    ),
                  ],
                ),
              ),
              Card(
                shape: cardShape,
                child: Column(
                  mainAxisAlignment: _hospital2Close
                      ? MainAxisAlignment.center
                      : MainAxisAlignment.start,
                  children: [
                    Visibility(
                      visible: !_hospital2Close,
                      child: Align(
                        alignment: Alignment.topRight,
                        child: Card(
                          margin: const EdgeInsets.only(right: 10, top: 10),
                          color: Colors.red,
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                _hospital2Close = true;
                              });
                            },
                            child: const Icon(
                              Icons.close,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Visibility(
                      visible: _hospital2Close,
                      child: SizedBox(
                        height: 250,
                        width: double.maxFinite,
                        child: InkWell(
                          onTap: () {
                            Navigator.pushNamed(
                                    context, SearchHospital.routeName,
                                    arguments: true)
                                .then((value) {
                              if (value != null) {
                                _hospital2 = value as Map<String, dynamic>;
                                setState(() {
                                  _hospital2Close = false;
                                });
                              }
                            });
                          },
                          child: const Icon(
                            Icons.apartment_rounded,
                            size: 70,
                          ),
                        ),
                      ),
                      replacement: CompareHospitalCard(
                        data: _hospital2,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/* Column(
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
              ),*/
