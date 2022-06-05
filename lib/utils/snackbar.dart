import 'package:bolsas_universitarias/components/text_views.dart';
import 'package:flutter/material.dart';

SnackBar buildSnackBar(String text) {
  return SnackBar(
    content: TextNormal(text: text),
    behavior: SnackBarBehavior.floating,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10.0),
    ),
  );
}

void showSnackBar(BuildContext context, String text) {
  ScaffoldMessenger.of(context).showSnackBar(buildSnackBar(text));
}
