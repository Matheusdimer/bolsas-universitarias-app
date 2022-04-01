import 'package:flutter/material.dart';

class TileButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final Color? color;
  final void Function()? onTap;
  final bool top;

  const TileButton({
    Key? key,
    required this.label,
    required this.icon,
    this.onTap,
    this.color,
    this.top = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (top)
          Divider(
            height: 0,
            thickness: 2,
            color: Colors.grey.shade300,
          ),
        InkWell(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(30, 20, 30, 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(
                      icon,
                      color: color,
                      size: 25,
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    Text(
                      label,
                      style: const TextStyle(fontSize: 18),
                    ),
                  ],
                ),
                const Icon(
                  Icons.arrow_forward_ios,
                )
              ],
            ),
          ),
          onTap: onTap,
        ),
        Divider(
          height: 0,
          thickness: 2,
          color: Colors.grey.shade300,
        ),
      ],
    );
  }
}
