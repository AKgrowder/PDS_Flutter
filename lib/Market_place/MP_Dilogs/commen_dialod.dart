import 'package:flutter/material.dart';

class CommonAlertDialog {
  static void show(BuildContext context, Widget? title, Widget? content) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          
          builder: (context, state) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0))),
              title: title,
              content: content,
            );
          },
        );
      },
    );
  }
}
