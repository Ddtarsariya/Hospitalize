import 'package:flutter/material.dart';

RoundedRectangleBorder get cardShape {
  return RoundedRectangleBorder(
    side: const BorderSide(color: Colors.red, width: 2),
    borderRadius: BorderRadius.circular(5),
  );
}
