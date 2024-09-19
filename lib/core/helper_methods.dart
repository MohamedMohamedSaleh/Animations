import 'package:flutter/material.dart';

Future navigateTo(BuildContext context, {required Widget toPage, bool isRemove = false}) async {
  Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(
      builder: (context) => toPage,
    ),
    (route) => !isRemove,
  );
}