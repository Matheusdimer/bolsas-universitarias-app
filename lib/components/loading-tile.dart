import 'package:flutter/material.dart';

class LoadingTile extends StatelessWidget {
  final double width;
  final double height;
  final BorderRadius? borderRadius;

  const LoadingTile({Key? key, this.width = 40, this.height = 40, this.borderRadius}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xAAAAAAAA),
          borderRadius: borderRadius ?? const BorderRadius.all(Radius.circular(5)),
        ),
      ),
    );
  }
}
