import 'package:flutter/material.dart';

class Snackbar {
  static void showSnackbarr(
      BuildContext context, String text) {
    final snackBar = SnackBar(
      content: Text(text),
    );

    // Find the ScaffoldMessenger in the widget tree
    // and use it to show a SnackBar.
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  static void showActionSnackbarr(
      BuildContext context, String text, Function function) {
    final snackBar = SnackBar(
      content: Text(text),
      action: SnackBarAction(
      label: 'Undo',
      onPressed: () {
        function();
        // Some code to undo the change.
      },
    ),
    );

    // Find the ScaffoldMessenger in the widget tree
    // and use it to show a SnackBar.
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
