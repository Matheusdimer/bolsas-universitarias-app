import 'package:flutter/material.dart';

class FutureTracker<T> extends StatelessWidget {
  final Future<T> future;
  final Widget loading;
  final Widget Function(Object error) error;
  final Widget Function(T data) completed;

  const FutureTracker(
      {Key? key,
      required this.future,
      required this.loading,
      required this.error,
      required this.completed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<T>(
      future: future,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final data = snapshot.data as T;
          return completed(data);
        } else if (snapshot.hasError) {
          print(snapshot.error);
          return error(snapshot.error as Object);
        }

        return loading;
      },
    );
  }
}
