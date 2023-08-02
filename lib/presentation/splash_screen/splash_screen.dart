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
    double _width = MediaQuery.of(context).size.width;
    double _height = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        backgroundColor: appTheme.deepOrange5001,
        body: Container(
          width: _width,
          // color: Colors.red[100],
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(50.0),
              child: CustomImageView(
                imagePath: ImageConstant.imgImage248,
                // height: _height / 10,
                // width:_width 
              ),
            ),
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
