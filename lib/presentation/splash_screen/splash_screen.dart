import 'dart:async';

import 'package:archit_s_application1/core/app_export.dart';
import 'package:flutter/material.dart';

import '../register_create_account_screen/register_create_account_screen.dart';

class SplashScreen extends StatelessWidget {
  int GetTimeSplash = 0;

  void startTimer(BuildContext context) {
    Timer(
      Duration(seconds: 2),
      () {
        chcekToken(context);
      },
    );
  }

  @override
  void initState() {}

  @override
  Widget build(BuildContext context) {
    startTimer(context);
    return SafeArea(
      child: Scaffold(
        backgroundColor: appTheme.deepOrange5001,
        body: Container(
          width: double.maxFinite,
          padding: getPadding(
            left: 44,
            right: 44,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomImageView(
                imagePath: ImageConstant.imgImage248,
                height: getVerticalSize(
                  86,
                ),
                width: getHorizontalSize(
                  325,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  chcekToken(BuildContext context) async {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => RegisterCreateAccountScreen()),
    );
  }
}
