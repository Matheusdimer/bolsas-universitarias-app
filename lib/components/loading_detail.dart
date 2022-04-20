import 'package:app/components/loading-list.dart';
import 'package:app/components/loading-tile.dart';
import 'package:flutter/material.dart';

class LoadingDetail extends StatelessWidget {
  const LoadingDetail({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: CustomShimmer(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              LoadingTile(width: 250, height: 30,),
              SizedBox(height: 20,),

              LoadingTile(width: double.infinity, height: 90,),
              SizedBox(height: 30,),

              LoadingTile(width: 300, height: 40,),
              SizedBox(height: 20,),
              LoadingTile(width: double.infinity, height: 30,),
              SizedBox(height: 20,),
              LoadingTile(width: double.infinity, height: 30,),
              SizedBox(height: 20,),
              LoadingTile(width: double.infinity, height: 30,),
              SizedBox(height: 20,),
            ],
          ),
        ),
      ),
    );
  }
}
