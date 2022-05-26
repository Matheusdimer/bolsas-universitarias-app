import 'package:flutter/material.dart';

class FutureTracker<T> extends StatelessWidget {
  final Future<T>? future;
  final Widget loading;
  final Widget Function(Object error)? error;
  final void Function(Object error)? onError;
  final Widget Function(T data) completed;

  const FutureTracker(
      {Key? key,
      required this.future,
      this.loading = const Center(
        child: CircularProgressIndicator(),
      ),
      this.error,
      this.onError,
      required this.completed})
      : super(key: key);

  bool isNotAlive(AsyncSnapshot snapshot) {
    return snapshot.connectionState == ConnectionState.none ||
        snapshot.connectionState == ConnectionState.done;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<T>(
      future: future,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          print(snapshot.error);

          if (onError != null) {
            onError!(snapshot.error as Object);
          }

          return error != null ? error!(snapshot.error as Object) : Container();
        } else if (snapshot.hasData ||
            (T.toString() == 'void' && isNotAlive(snapshot))) {
          final data = snapshot.data as T;
          return completed(data);
        }

        return loading;
      },
    );
  }
}
