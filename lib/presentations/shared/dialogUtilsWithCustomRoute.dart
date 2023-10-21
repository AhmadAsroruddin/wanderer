import 'package:flutter/material.dart';

class DialogUtilsWithCustomRoute {
  static void alertDialogWithCustomRoute(
      BuildContext context, String title, String content, Function func) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(title),
          content: Text(content),
          actions: [
            TextButton(
              onPressed: func(),
              child: const Text("OK"),
            ),
          ],
        );
      },
    );
  }
}
