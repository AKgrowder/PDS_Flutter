import 'package:archit_s_application1/core/app_export.dart';
import 'package:archit_s_application1/presentation/Login_Screen/Login_Screen.dart';
import 'package:flutter/material.dart';

import '../create_account_screen/create_account_screen.dart';

class RegisterCreateAccountScreen extends StatefulWidget {
  @override
  State<RegisterCreateAccountScreen> createState() =>
      _RegisterCreateAccountScreenState();
}

class _RegisterCreateAccountScreenState
    extends State<RegisterCreateAccountScreen> {
  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    double _height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: theme.colorScheme.onPrimary,
      body: Column(
        children: [
          Container(
            // height: _height /2.5/,
            width: _width,
            // color: Colors.red,
            child: CustomImageView(
              imagePath: ImageConstant.register,
              fit: BoxFit.fill,
            ),
          ),
          Container(
            height: 40,
            child: Center(
              child: Text(
                "Welcome to consultant app",
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.left,
                style: TextStyle(fontFamily: 'outfit',),
                // style: TextThemeHelper.titleLarge22,
              ),
            ),
          ),
          Container(
            child: Text("Create a New Account or ",style: TextStyle(fontFamily: 'outfit',),),
          ),
          Container(
            child: Text("register Now",style: TextStyle(fontFamily: 'outfit',),),
          ),
          Spacer(),
          Container(
            height: 100,
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CreateAccountScreen()),
              );
            },
            child: Padding(
              padding: EdgeInsets.only(left: 30, right: 30, bottom: 30),
              child: Container(
                alignment: Alignment.center,
                height: _height * 0.055,
                width: _width,
                decoration: BoxDecoration(
                  color: Color(0xffED1C25),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Text(
                  'Create Account',
                  style: TextStyle(color: Colors.white,fontFamily: 'outfit',),
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => LoginScreen()),
              );
            },
            child: Padding(
              padding: EdgeInsets.only(left: 30, right: 30, bottom: 30),
              child: Container(
                alignment: Alignment.center,
                height: _height * 0.055,
                width: _width,
                decoration: BoxDecoration(
                    color: Color(0xffFFD9DA),
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(color: Color(0xffED1C25))),
                child: Text(
                  'Log In',
                  style: TextStyle(color: Color(0xffED1C25),fontFamily: 'outfit',),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
