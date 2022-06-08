import 'package:flutter/material.dart';

SnackBar buildSnackBar(String text) {
  return SnackBar(
    content: Text(text),
    behavior: SnackBarBehavior.floating,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10.0),
    ),
  );
}

void showSnackBar(BuildContext context, String text) {
  ScaffoldMessenger.of(context).showSnackBar(buildSnackBar(text));
}
