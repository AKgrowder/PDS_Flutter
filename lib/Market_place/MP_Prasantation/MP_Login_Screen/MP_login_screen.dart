import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pds/Market_place/MP_Dilogs/MP_singup_flow_dilogs.dart';
import 'package:pds/Market_place/MP_Prasantation/MP_Login_Screen/MP_mobile_number_login_screen.dart';

import '../../../core/utils/color_constant.dart';
import '../../../core/utils/image_constant.dart';
import '../../../theme/theme_helper.dart';
import '../../../widgets/custom_image_view.dart';
import '../../../widgets/custom_text_form_field.dart';

class RmLoginScreen extends StatefulWidget {
  const RmLoginScreen({Key? key}) : super(key: key);

  @override
  State<RmLoginScreen> createState() => _RmLoginScreenState();
}

class _RmLoginScreenState extends State<RmLoginScreen> {
  TextEditingController usernameController = TextEditingController();
  bool Show_Password = true;
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back,
            color: Colors.grey,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.only(left: 25.0, right: 25),
        child: SingleChildScrollView(
          child: Column(crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Login for Buyer",
              style: TextStyle(
                  fontFamily: 'outfit',
                  fontSize: 20,
                  fontWeight: FontWeight.w500),
            ),
            Divider(
              color: ColorConstant.primary_color,
              // indent: 80,
              endIndent: 280,
              thickness: 1.5,
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              "Welcome onboard with us!",
              style: TextStyle(
                  fontFamily: 'outfit',
                  fontSize: 18,
                  fontWeight: FontWeight.w400),
            ),
            SizedBox(height: 25),
            Text(
              "User Name",
              style: TextStyle(
                  fontFamily: 'outfit',
                  fontSize: 15,
                  color: Colors.black,
                  fontWeight: FontWeight.w500),
            ),
            CustomTextFormField(
              // focusNode: FocusNode(),
              // autofocus: true,
        
              controller: usernameController,
              margin: EdgeInsets.only(
                top: 4,
              ),
              contentPadding: EdgeInsets.only(
                left: 12,
                top: 14,
                right: 12,
                bottom: 14,
              ),
              validator: (value) {
                RegExp nameRegExp = RegExp(r"^[a-zA-Z0-9\s'@]+$");
                if (value!.isEmpty) {
                  return 'Please Enter User Name';
                } else if (!nameRegExp.hasMatch(value)) {
                  return 'Input cannot contains prohibited special characters';
                } else if (value.length <= 0 || value.length > 50) {
                  return 'Minimum length required';
                } else if (value.contains('..')) {
                  return 'username does not contain is correct';
                }
        
                return null;
              },
        
              hintText: "Enter your username",
        
              textInputAction: TextInputAction.next,
              filled: true,
              maxLength: 100,
              fillColor: appTheme.gray100,
            ),
            SizedBox(
              height: 10,
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              "Password",
              style: TextStyle(
                  fontFamily: 'outfit',
                  fontSize: 15,
                  color: Colors.black,
                  fontWeight: FontWeight.w500),
            ),
            CustomTextFormField(
              maxLength: 50,
              inputFormatters: [
                FilteringTextInputFormatter.deny(RegExp(r'\s')),
              ],
              errorMaxLines: 3,
              // focusNode: FocusNode(),
              // autofocus: true,
        
              validator: (value) {
                String pattern =
                    r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$%^&*(),.?":{}|<>])[A-Za-z0-9!@#\$%^&*(),.?":{}|<>]{8,}$';
                if (value!.isEmpty) {
                  return 'Please Enter Password';
                }
                if (!RegExp(pattern).hasMatch(value)) {
                  return 'Password should contain at least 1 uppercase, 1 lowercase, 1 digit, 1 special character and be at least 8 characters long';
                }
        
                return null;
              },
              controller: passwordController,
              margin: EdgeInsets.only(
                top: 5,
              ),
              contentPadding: EdgeInsets.only(
                left: 20,
                top: 14,
                bottom: 14,
              ),
              // textStyle: theme.textTheme.titleMedium!,
              hintText: "Enter your password",
              // hintStyle: theme.textTheme.titleMedium!,
              textInputType: TextInputType.visiblePassword,
              suffix: Container(
                margin: EdgeInsets.only(
                  left: 30,
                  top: 15,
                  right: 15,
                  bottom: 15,
                ),
                child: GestureDetector(
                  onTap: () {
                    if (this.mounted) {
                      super.setState(() {
                        Show_Password = !Show_Password;
                      });
                    }
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
              suffixConstraints: BoxConstraints(maxHeight: 50),
              obscureText: Show_Password ? true : false,
              filled: true,
        
              fillColor: appTheme.gray100,
            ),
            SizedBox(
              height: 10,
            ),
            GestureDetector(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (_) => ChangePasswordDilog(),
                );
              },
              child: Container(
                child: Text(
                  "Forget Password",
                  style: TextStyle(
                      fontFamily: 'outfit',
                      fontSize: 15,
                      color: ColorConstant.primary_color,
                      fontWeight: FontWeight.w500),
                ),
              ),
            ),
            SizedBox(
              height: 50,
            ),
            Container(
              height: 50,
              // width: _width / 1.2,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                color: ColorConstant.primary_color,
              ),
              child: Center(
                  child: Text(
                "LOGIN",
                style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'outfit',
                    fontSize: 18,
                    fontWeight: FontWeight.w500),
              )),
            ),
            SizedBox(
              height: 20,
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MobileNumberLoginScreen(),
                    ));
              },
              child: GestureDetector(
                child: Container(
                  height: 40,
                  // width: _width / 1.2,
                  decoration: BoxDecoration(
                    border: Border.all(color: ColorConstant.primary_color),
                    borderRadius: BorderRadius.circular(6),
                    color: Colors.white,
                  ),
                  child: Center(
                      child: Text(
                    "Login With OTP",
                    style: TextStyle(
                        color: ColorConstant.primary_color,
                        fontFamily: 'outfit',
                        fontSize: 18,
                        fontWeight: FontWeight.w500),
                  )),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 50.0),
              child: Row(
                children: [
                  Text(
                    "New to InPackaging?",
                    style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'outfit',
                        fontSize: 15,
                        fontWeight: FontWeight.w500),
                  ),
                  Text(
                    "Register",
                    style: TextStyle(
                        color: ColorConstant.primary_color,
                        fontFamily: 'outfit',
                        fontSize: 15,
                        fontWeight: FontWeight.w500),
                  ),
                  Text(
                    "Here",
                    style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'outfit',
                        fontSize: 15,
                        fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            )
          ]),
        ),
      ),
    );
  }
}

 