import 'package:flutter/material.dart';

class SearchHospital extends StatelessWidget {
  const SearchHospital({Key? key}) : super(key: key);
  static const routeName = '/search-hospital';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search Hospital'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Hospitals Near by you'),
          Expanded(child: Container()),
          const Text('Other Hospitals'),
          Expanded(child: Container()),
        ],
      ),
    );
  }
}
