import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';

class CustomFlushBarMarketPlace {
  void flushBar(
      {required int duration,
      required String text,
      required BuildContext context,
      required Color backgroundColor}) async {
    await dismiss();
    Flushbar(
      margin: EdgeInsets.all(8),
      borderRadius: BorderRadius.circular(8),
      backgroundColor: backgroundColor,
      flushbarStyle: FlushbarStyle.FLOATING,
      message: text,
      duration: Duration(seconds: duration ?? 3),
    )..show(context);
  }

  Future<void> dismiss() async {
    if (!Flushbar().isDismissed()) {
      await Flushbar().dismiss();
    }
  }
}
