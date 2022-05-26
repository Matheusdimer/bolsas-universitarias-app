import 'package:flutter/material.dart';

SnackBar buildSnackBar(String text) {
  return SnackBar(content: Text(text));
}

void showSnackBar(BuildContext context, String text) {
  ScaffoldMessenger.of(context).showSnackBar(buildSnackBar(text));
}