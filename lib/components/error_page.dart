import 'package:app/components/text_views.dart';
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
          const Icon(
            Icons.error_sharp,
            size: 100,
            color: Color.fromRGBO(255, 70, 70, 0.8),
          ),
          const SizedBox(
            height: 10,
          ),
          const TextTitle(text: 'Ops, ocorreu um erro.'),
          const SizedBox(
            height: 10,
          ),
          Text(
            error,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 20),
          )
        ],
      ),
    );
  }
}

Widget Function(dynamic error) buildErrorPage(BuildContext context) {
  return (error) {
    print(error.stackTrace);
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
