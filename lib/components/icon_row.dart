import 'package:flutter/material.dart';

class IconRow extends StatelessWidget {
  final IconData icon;
  final Color? color;
  final double size;
  final Widget text;

  const IconRow({
    Key? key,
    required this.icon,
    required this.text,
    this.color,
    this.size = 20,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: color ?? Colors.grey.shade800, size: size),
        const SizedBox(width: 5),
        text,
      ],
    );
  }
}
