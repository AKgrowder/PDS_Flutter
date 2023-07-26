import 'package:archit_s_application1/core/app_export.dart';
import 'package:archit_s_application1/presentation/otp_verification_screen/otp_verification_screen.dart';
import 'package:archit_s_application1/widgets/custom_elevated_button.dart';
import 'package:archit_s_application1/widgets/custom_outlined_button.dart';
import 'package:archit_s_application1/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';

import '../forget_password_screen/forget_password_screen.dart';

class RegisterScreen extends StatefulWidget {
  RegisterScreen({Key? key})
      : super(
          key: key,
        );

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController mobilenumberController = TextEditingController();

  TextEditingController passwordoneController = TextEditingController();

  TextEditingController emailAndMobileController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool Show_Password = true;
  bool isPhone = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: theme.colorScheme.onPrimary,
        resizeToAvoidBottomInset: true,
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: SizedBox(
              width: double.maxFinite,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    height: getVerticalSize(
                      348,
                    ),
                    width: double.maxFinite,
                    child: Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        CustomImageView(
                          imagePath: ImageConstant.imgRectangle19250,
                          height: getVerticalSize(
                            348,
                          ),
                          width: getHorizontalSize(
                            414,
                          ),
                          alignment: Alignment.center,
                        ),
                        CustomImageView(
                          svgPath: ImageConstant.imgGroup,
                          height: getVerticalSize(
                            242,
                          ),
                          width: getHorizontalSize(
                            337,
                          ),
                          alignment: Alignment.bottomCenter,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: getPadding(
                      top: 39,
                    ),
                    child: Text(
                      "Log In",
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.left,
                      style: TextThemeHelper.titleLarge22,
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: getPadding(
                        left: 30,
                        top: 41,
                      ),
                      child: Text(
                        "Email / Mobile number",
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.left,
                        style: theme.textTheme.bodyLarge,
                      ),
                    ),
                  ),  CustomTextFormField(
                      onChanged: (value) {
                        print("onchange");
                        final RegExp regex = RegExp('[a-zA-Z]');
                        if (emailAndMobileController.text == null ||
                            emailAndMobileController.text.isEmpty ||
                            !regex.hasMatch(emailAndMobileController.text)) {
                          setState(() {
                            isPhone = true;
                          });
                        } else {
                          setState(() {
                            isPhone = false;
                          });
                        }
                      },
                      maxLength: isPhone == true ? 10 : 30,
                      // focusNode: FocusNode(),
                      controller: emailAndMobileController,
                       margin: getMargin(
                      left: 30,
          
                      right: 30,
                    ),
                    contentPadding: getPadding(
                      left: 12,
                      top: 14,
                      right: 12,
                      bottom: 14,
                    ),
                    textStyle: theme.textTheme.titleMedium!,
                    hintText: "Enter Email / Mobile number",
                    hintStyle: theme.textTheme.titleMedium!,
                    textInputAction: TextInputAction.next,
                    textInputType: TextInputType.emailAddress,
                    filled: true,
                    fillColor: appTheme.gray100,
                    ),
                 
                 
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: getPadding(
                        left: 30,
                        top: 19,
                      ),
                      child: Text(
                        "Password",
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.left,
                        style: theme.textTheme.bodyLarge,
                      ),
                    ),
                  ),
                  CustomTextFormField(
                    // focusNode: FocusNode(),
                    // autofocus: true,

                    controller: passwordoneController,
                    // textInputType: TextInputType. number,
                    margin: getMargin(
                      left: 30,
                      top: 5,
                      right: 30,
                    ),
                    contentPadding: getPadding(
                      left: 20,
                      top: 14,
                      bottom: 14,
                    ),
                    textStyle: theme.textTheme.titleMedium!,
                    hintText: "Password",
                    hintStyle: theme.textTheme.titleMedium!,
                    textInputType: TextInputType.emailAddress,
                    suffix: Container(
                      margin: getMargin(
                        left: 30,
                        top: 15,
                        right: 15,
                        bottom: 15,
                      ),
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            Show_Password = !Show_Password;
                          });
                        },
                        child: Show_Password
                            ? CustomImageView(
                                svgPath: ImageConstant.imgEye,
                              )
                            : Icon(
                                Icons.remove_red_eye_sharp,
                                color: Colors.grey,
                              ),
                      ),
                    ),
                    suffixConstraints: BoxConstraints(
                      maxHeight: getVerticalSize(
                        50,
                      ),
                    ),
                    obscureText: Show_Password ? true : false,
                    filled: true,
                    fillColor: appTheme.gray100,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: getPadding(
                        left: 30,
                        top: 13,
                      ),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => ForgetPasswordScreen()));
                        },
                        child: Text(
                          "Forget Password?",
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.left,
                          style: theme.textTheme.titleSmall,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 30, right: 30, top: 10),
                    child: CustomElevatedButton(
                      text: "Log In",
                      buttonStyle:
                          ButtonThemeHelper.outlineOrangeA7000c.copyWith(
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
                    padding: getPadding(
                      top: 25,
                      bottom: 5,
                    ),
                    child: RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: "Connect with us at  ",
                            style: TextStyle(
                              color: appTheme.black900,
                              fontSize: getFontSize(
                                14,
                              ),
                              fontFamily: 'Outfit',
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          TextSpan(
                            text: "Support",
                            style: TextStyle(
                              color: theme.colorScheme.primary,
                              fontSize: getFontSize(
                                14,
                              ),
                              fontFamily: 'Outfit',
                              fontWeight: FontWeight.w500,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ],
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 30, right: 30, top: 10),
                    child: CustomOutlinedButton(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => OtpVerificationScreen()),
                        );
                      },
                      text: "Log In With OTP",
                      margin: getMargin(
                        left: 30,
                        right: 30,
                        bottom: 51,
                      ),
                      buttonStyle: ButtonThemeHelper.outlinePrimaryTL6.copyWith(
                          fixedSize: MaterialStateProperty.all<Size>(Size(
                        double.maxFinite,
                        getVerticalSize(
                          50,
                        ),
                      ))),
                      buttonTextStyle:
                          TextThemeHelper.titleMediumPrimarySemiBold,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
