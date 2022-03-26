import 'package:flutter/material.dart';

class LoadingTile extends StatelessWidget {
  final double width;
  final double height;

  const LoadingTile({Key? key, this.width = 40, this.height = 40}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: Container(
        decoration: const BoxDecoration(
          color: Color(0xAAAAAAAA),
          borderRadius: BorderRadius.all(Radius.circular(5)),
        ),
      ),
    );
  }
}
