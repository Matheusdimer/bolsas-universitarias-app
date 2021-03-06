import 'package:flutter/material.dart';

enum BadgeType { error, warn, success, info, white }
enum BadgeStyle { badge, status }

class Badge extends StatelessWidget {
  final String text;
  final BadgeType type;
  final double? width;
  final double? height;
  final double? fontSize;
  final BadgeStyle style;

  const Badge({
    Key? key,
    required this.type,
    required this.text,
    this.width,
    this.height,
    this.fontSize,
    this.style = BadgeStyle.badge,
  }) : super(key: key);

  static MaterialColor getColor(BadgeType type) {
    switch (type) {
      case BadgeType.error:
        return Colors.red;
      case BadgeType.success:
        return Colors.green;
      case BadgeType.warn:
        return Colors.amber;
      case BadgeType.info:
        return Colors.cyan;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    var color = getColor(type);

    switch (style) {
      case BadgeStyle.badge:
        return Container(
          padding: const EdgeInsets.fromLTRB(8, 5, 8, 5),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            color: color.withOpacity(0.3),
          ),
          width: width,
          height: height,
          child: Text(
            text,
            style: TextStyle(
              color: color.shade900,
              fontWeight: FontWeight.w600,
              fontSize: fontSize,
            ),
          ),
        );
      case BadgeStyle.status:
        return Row(
          children: [
            Container(
              width: 10,
              height: 10,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: color,
              ),
            ),
            const SizedBox(width: 10),
            Text(
              text,
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: Colors.grey.shade900,
              ),
            ),
          ],
        );
    }
  }
}
