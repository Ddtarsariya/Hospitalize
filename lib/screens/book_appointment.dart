import 'package:flutter/material.dart';

class BookAppointment extends StatelessWidget {
  static const routeName = '/book-appointment';
  const BookAppointment({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Book an Appointment'),
      ),
      body: Container(),
    );
  }
}
