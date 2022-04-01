import 'package:flutter/material.dart';

showAlertDialog({
  required BuildContext context,
  required void Function() confirm,
  String confirmLabel = 'Continuar',
  String title = 'Atenção',
  String message = 'Deseja mesmo continuar?',
  bool warn = false,
}) {
  AlertDialog alertDialog = AlertDialog(
    title: Text(title),
    content: Text(message),
    actions: [
      TextButton(
        child: const Text(
          "Cancelar",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        onPressed: () => Navigator.of(context).pop(),
      ),
      TextButton(
        child: Text(
          confirmLabel,
          style: TextStyle(
            color: warn ? Colors.red.shade800 : Colors.black,
          ),
        ),
        onPressed: confirm,
      )
    ],
  );

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alertDialog;
    },
  );
}
