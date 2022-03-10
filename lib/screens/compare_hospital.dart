import 'package:flutter/material.dart';
import 'package:hospitalize/models/hospital.dart';
import 'package:hospitalize/screens/search_hospital.dart';
import 'package:hospitalize/widgets/compare_hospital_card.dart';

class CompareHospital extends StatefulWidget {
  static const routeName = '/compare-hospital';

  const CompareHospital({Key? key}) : super(key: key);

  @override
  State<CompareHospital> createState() => _CompareHospitalState();
}

class _CompareHospitalState extends State<CompareHospital> {
  Hospital _hospital1 = Hospital();
  Hospital _hospital2 = Hospital();
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
          child: Column(
            children: [
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
              Container(
                height: MediaQuery.of(context).size.height / 1.5,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      flex: 5,
                      child: Card(
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
                                  margin:
                                      const EdgeInsets.only(right: 10, top: 10),
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
                              child: InkWell(
                                onTap: () {
                                  Navigator.pushNamed(
                                          context, SearchHospital.routeName,
                                          arguments: true)
                                      .then((value) {
                                    if (value != null) {
                                      _hospital1 = value as Hospital;
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
                              replacement: CompareHospitalCard(
                                data: _hospital1,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 5,
                      child: Card(
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
                                  margin:
                                      const EdgeInsets.only(right: 10, top: 10),
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
                              child: InkWell(
                                onTap: () {
                                  Navigator.pushNamed(
                                          context, SearchHospital.routeName,
                                          arguments: true)
                                      .then((value) {
                                    if (value != null) {
                                      _hospital2 = value as Hospital;
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
                              replacement: CompareHospitalCard(
                                data: _hospital2,
                              ),
                            ),
                          ],
                        ),
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
