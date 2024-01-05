import 'package:pds/core/app_export.dart';
import 'package:pds/core/utils/color_constant.dart';
import 'package:pds/presentation/%20new/newbottembar.dart';

import 'package:pds/presentation/Login_Screen/Login_Screen.dart';
import 'package:pds/widgets/app_bar/appbar_image.dart';
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
          Stack(
            children: [
              Container(
                height: _height / 2.5,
                width: _width,
                child: CustomImageView(
                  imagePath: ImageConstant.register,
                  fit: BoxFit.fill,
                ),
              ),
              Container(
                alignment: Alignment.topLeft,
                child: AppbarImage(
                    height: 23,
                    width: 24,
                    svgPath: ImageConstant.imgArrowleft,
                    margin: EdgeInsets.only(
                      left: 20,
                      top: 50,
                    ),
                    onTap: () {
                     /*  Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  NewBottomBar(buttomIndex: 0)),
                          (route) => false); */
                       Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return NewBottomBar(buttomIndex: 0);
                      }));
                    }),
              ),
            ],
          ),
          SizedBox(
            height: 30,
          ),
          Container(
            margin: EdgeInsets.only(top: 5),
            height: 40,
            child: Center(
              child: Text(
                "Welcome to consultant app",
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.left,
                style: TextStyle(
                    fontFamily: 'outfit',
                    fontWeight: FontWeight.bold,
                    fontSize: 23),
                // style: TextThemeHelper.titleLarge22,
              ),
            ),
          ),
          Container(
            child: Text(
              "Create a New Account or ",
              style: TextStyle(
                  fontFamily: 'outfit',
                  fontWeight: FontWeight.w400,
                  color: Colors.grey,
                  fontSize: 15),
            ),
          ),
          Container(
            child: Text(
              "Login Now",
              style: TextStyle(
                  fontFamily: 'outfit',
                  fontWeight: FontWeight.w400,
                  color: Colors.grey,
                  fontSize: 15),
            ),
          ),
          Spacer(),
          Container(
            height: 100,
          ),
          GestureDetector(
            onTap: () {
              print('this is the data fget');
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return CreateAccountScreen();
              }));
            },
            child: Padding(
              padding: EdgeInsets.only(left: 30, right: 30, bottom: 30),
              child: Container(
                alignment: Alignment.center,
                height: _height * 0.055,
                width: _width,
                decoration: BoxDecoration(
                  color: ColorConstant.primary_color,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Text(
                  'Create Account',
                  style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'outfit',
                      fontSize: 15,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return LoginScreen();
              }));
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
                    border: Border.all(color: ColorConstant.primary_color)),
                child: Text(
                  'Log In',
                  style: TextStyle(
                      color: ColorConstant.primary_color,
                      fontFamily: 'outfit',
                      fontSize: 15,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
