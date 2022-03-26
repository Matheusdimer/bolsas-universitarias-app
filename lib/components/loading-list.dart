import 'package:app/components/loading-tile.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class LoadingList extends StatelessWidget {
  final int size;
  final bool hasImage;

  const LoadingList({Key? key, this.size = 5, this.hasImage = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: const Color(0xAAAAAAAA),
      highlightColor: const Color(0xDDDDDDDD),
      child: ListView.builder(
        itemBuilder: (context, index) {
          return ListTile(

            title: const LoadingTile(
              height: 15,
              width: 20,
            ),
            leading: hasImage
                ? const LoadingTile(
                    height: 40,
                    width: 40,
                  )
                : null,
            subtitle: const LoadingTile(
              height: 15,
              width: 50,
            ),
          );
        },
        itemCount: size,
      ),
    );
  }
}
