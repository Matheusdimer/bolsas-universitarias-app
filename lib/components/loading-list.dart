import 'package:bolsas_universitarias/components/loading-tile.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class LoadingList extends StatelessWidget {
  final int size;
  final bool hasImage;

  const LoadingList({Key? key, this.size = 5, this.hasImage = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomShimmer(
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

class LoadingCardList extends StatelessWidget {
  final int size;
  final bool hasImage;

  const LoadingCardList({Key? key, this.size = 5, this.hasImage = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Card(
            clipBehavior: Clip.antiAliasWithSaveLayer,
            child: CustomShimmer(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (hasImage)
                    const LoadingTile(
                      width: double.infinity,
                      height: 120,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(5),
                        topRight: Radius.circular(5),
                      ),
                    ),
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        SizedBox(
                          height: 5,
                        ),
                        LoadingTile(
                          width: 140,
                          height: 30,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        LoadingTile(
                          width: double.infinity,
                          height: 60,
                        ),
                        Divider(),
                        LoadingTile(
                          width: 200,
                          height: 30,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
      itemCount: size,
    );
  }
}

class CustomShimmer extends StatelessWidget {
  final Widget child;

  const CustomShimmer({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: const Color(0xAAAAAAAA),
      highlightColor: const Color(0xDDDDDDDD),
      child: child,
    );
  }
}
