import 'package:flutter/material.dart';

const Map<int, Color> color = {
  50: Color.fromRGBO(18, 102, 241, .1),
  100: Color.fromRGBO(18, 102, 241, .2),
  200: Color.fromRGBO(18, 102, 241, .3),
  300: Color.fromRGBO(18, 102, 241, .4),
  400: Color.fromRGBO(18, 102, 241, .5),
  500: Color.fromRGBO(18, 102, 241, .6),
  600: Color.fromRGBO(18, 102, 241, .7),
  700: Color.fromRGBO(18, 102, 241, .8),
  800: Color.fromRGBO(18, 102, 241, .9),
  900: Color.fromRGBO(18, 102, 241, 1),
};

MaterialColor themeColor = MaterialColor(const Color.fromRGBO(18, 102, 241, 1).value, color);