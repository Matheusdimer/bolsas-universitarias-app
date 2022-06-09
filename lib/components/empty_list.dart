import 'package:flutter/material.dart';

class EmptyList extends StatelessWidget {
  final String message;

  const EmptyList({
    Key? key,
    required this.message,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'lib/assets/empty-box.png',
            scale: 3,
          ),
          const SizedBox(
            height: 30,
          ),
          Text(
            message,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
