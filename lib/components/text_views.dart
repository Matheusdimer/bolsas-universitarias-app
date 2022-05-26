import 'package:flutter/material.dart';

const double h1 = 20;
const double h2 = 18;
const double normal = 16;
const double small = 14;

class TextTitle extends StatelessWidget {
  final String text;

  const TextTitle({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: h1,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}

class TextSubTitle extends StatelessWidget {
  final String text;

  const TextSubTitle({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: h2,
        fontWeight: FontWeight.bold,
        color: Colors.black
      ),
    );
  }
}

class TextNormal extends StatelessWidget {
  final String text;

  const TextNormal({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(fontSize: normal),
    );
  }
}

class TextSmall extends StatelessWidget {
  final String text;

  const TextSmall({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(fontSize: small),
    );
  }
}

class TextNormalBold extends StatelessWidget {
  final String text;

  const TextNormalBold({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: normal,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}

class TextSmallBold extends StatelessWidget {
  final String text;

  const TextSmallBold({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: small,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}

class TextSmallWeak extends StatelessWidget {
  final String text;
  final double? size;

  const TextSmallWeak({Key? key, required this.text, this.size}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: size ?? small,
        fontWeight: FontWeight.w300,
      ),
    );
  }
}

class TextNormalWeak extends StatelessWidget {
  final String text;

  const TextNormalWeak({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: normal,
        fontWeight: FontWeight.w300,
        color: Colors.black,
      ),
    );
  }
}

class CustomDivider extends StatelessWidget {
  final double height;

  const CustomDivider({Key? key, this.height = 0}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Divider(
      height: height,
      thickness: 2,
      color: Colors.grey.shade300,
    );
  }
}
