import 'package:flutter/material.dart';

void showDialogDefault(BuildContext context, String text) {
  showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
            title: const Text("ATENÇÃO"),
            content: Text(text),
            actions: <Widget>[
              // usually buttons at the bottom of the dialog
              TextButton(
                child: const Text("OK"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ]
        );
      }
  );
}

void showDialogDefaultFunction(BuildContext context, String text, Future<void> function) {
  showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
            title: const Text("ATENÇÃO"),
            content: Text(text),
            actions: <Widget>[
              // usually buttons at the bottom of the dialog
              TextButton(
                child: const Text("OK"),
                onPressed: () async {
                  await function;
                  Navigator.of(context).pop();
                },
              )
            ]
        );
      }
  );
}
