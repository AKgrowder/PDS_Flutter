import 'package:archit_s_application1/core/app_export.dart';
import 'package:archit_s_application1/presentation/register_screen/register_screen.dart';
import 'package:archit_s_application1/widgets/custom_elevated_button.dart';
import 'package:archit_s_application1/widgets/custom_outlined_button.dart';
import 'package:flutter/material.dart';

import '../create_account_screen/create_account_screen.dart';

class RegisterCreateAccountScreen extends StatefulWidget {
  @override
  State<RegisterCreateAccountScreen> createState() => _RegisterCreateAccountScreenState();
}

class _RegisterCreateAccountScreenState extends State<RegisterCreateAccountScreen> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: theme.colorScheme.onPrimary,
      body: SizedBox(
        width: double.maxFinite,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              height: height / 2.5,
              width: width,
              // color: Colors.cyan,
              child: CustomImageView(
                imagePath: ImageConstant.register,
              ),
            ),
            Padding(
              padding: getPadding(
                top: 61,
              ),
              child: Text(
                "Welcome to  consultant app",
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.left,
                style: TextThemeHelper.titleLarge22,
              ),
            ),
            Container( 
              width: getHorizontalSize(
                200,
              ),
              margin: getMargin(
                top: 7,
              ),
              child: Text(
                "Create a New Account or\n Register Now",
                // maxLines: 2,
                // overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: TextThemeHelper.bodyMediumBlack90015,
              ),
            ),
            Spacer(),
            Padding(
              padding: const EdgeInsets.only(left: 30, right: 30, bottom: 15),
              child: CustomElevatedButton( 
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => CreateAccountScreen()),
                  );
                },
                text: "Create Account",
                buttonStyle: ButtonThemeHelper.outlineOrangeA7000c.copyWith(
                    fixedSize: MaterialStateProperty.all<Size>(Size(
                  double.maxFinite,
                  getVerticalSize(
                    50,
                  ),
                ))),
                buttonTextStyle: TextThemeHelper.titleMediumOnPrimary,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 30, right: 30, bottom: 30),
              child: CustomOutlinedButton(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => RegisterScreen()),
                  );
                },
                text: "Log In",
                buttonStyle: ButtonThemeHelper.outlinePrimary.copyWith(
                    fixedSize: MaterialStateProperty.all<Size>(Size(
                  double.maxFinite,
                  getVerticalSize(
                    50,
                  ),
                ))),
                buttonTextStyle: TextThemeHelper.titleMediumPrimarySemiBold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
