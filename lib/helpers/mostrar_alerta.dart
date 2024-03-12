import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

mostrarAlerta(BuildContext context, String titulo, String subTitulo) {
  if (Platform.isAndroid) {
    return showDialog(
        context: context,
        builder: (_) => AlertDialog(
                title: Text(titulo),
                content: Text(subTitulo),
                actions: [
                  MaterialButton(
                    onPressed: () => Navigator.pop(context),
                    elevation: 5,
                    textColor: Colors.blue,
                    child: const Text('Ok'),
                  )
                ]));
  }

  showCupertinoDialog(
    context: context,
    builder: (context) => CupertinoAlertDialog(
      title: Text(titulo),
      content: Text(subTitulo),
      actions: [
        CupertinoDialogAction(
            isDefaultAction: true,
            onPressed: () => Navigator.pop(context),
            child: const Text('Ok'))
      ],
    ),
  );
}
