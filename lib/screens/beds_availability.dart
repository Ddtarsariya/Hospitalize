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
    );
  }
}
