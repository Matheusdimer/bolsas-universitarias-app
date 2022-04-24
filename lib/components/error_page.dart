import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class ErrorPage extends StatelessWidget {
  final String error;

  const ErrorPage({Key? key, required this.error}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.error_outline),
          Text(error),
        ],
      ),
    );
  }
}

Widget Function(dynamic error) buildErrorPage(BuildContext context) {
  return (error) {
    if (error is DioError) {
      if (error.response?.statusCode == 401) {
        SchedulerBinding.instance?.addPostFrameCallback((timeStamp) {
          Navigator.of(context).popAndPushNamed('/login');
        });
      } else {
        return ErrorPage(error: error.message);
      }
    }
    return ErrorPage(error: error.toString());
  };
}
