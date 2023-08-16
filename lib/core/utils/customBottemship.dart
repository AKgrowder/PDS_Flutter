import 'package:flutter/material.dart';

showCustomBottomSheet(BuildContext context, {required Widget child}) {
  showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    isDismissible: true,
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(35), topRight: Radius.circular(35))),
    builder: (BuildContext context) {
      return StatefulBuilder(builder: (context, setSta) {
        return SafeArea(
          bottom: true,
          child: Container(
            decoration: BoxDecoration(
              color: Color(0xFFFFFFFF),
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(35), topRight: Radius.circular(35)),
            ),
            child: SingleChildScrollView(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 100),
                  Container(
                    height: 100,
                    width: 800,
                    decoration: BoxDecoration(
                      color: Color(0xFF8D8D8D),
                      borderRadius: BorderRadius.circular(100),
                    ),
                  ),
                  child,
                ],
              ),
            ),
          ),
        );
      });
    },
  );
}
