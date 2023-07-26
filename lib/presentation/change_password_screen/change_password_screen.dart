import 'package:flutter/material.dart';

import '../../core/utils/image_constant.dart';
import '../../core/utils/size_utils.dart';
import '../../theme/theme_helper.dart';
import '../../widgets/custom_image_view.dart';
import '../../widgets/custom_text_form_field.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({Key? key}) : super(key: key);

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

var Show_Password = true;
var Show_Passwordd = true;
TextEditingController passwordController = TextEditingController();

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: theme.colorScheme.onPrimary,
        elevation: 0,
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Icon(
            Icons.arrow_back,
            color: Colors.grey,
          ),
        ),
        title: Text(
          "Change Password",
          style: TextStyle(
            fontFamily: 'outfit',
            fontSize: 23,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      backgroundColor: theme.colorScheme.onPrimary,
      body: Padding(
        padding: const EdgeInsets.only(left: 35.0, right: 35),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 40,
              ),
              Text(
                "New Password",
                overflow: TextOverflow.ellipsis,
                // textAlign: TextAlign.left,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontFamily: "outfit",
                    fontSize: 14),
              ),
              CustomTextFormField(
                // focusNode: FocusNode(),
                // autofocus: true,
                controller: passwordController,
                margin: getMargin(
                  top: 5,
                ),
                contentPadding: getPadding(
                  left: 20,
                  top: 14,
                  bottom: 14,
                ),
                textStyle: theme.textTheme.titleMedium!,
                hintText: "Password",
                hintStyle: theme.textTheme.titleMedium!,
                textInputType: TextInputType.visiblePassword,
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
              SizedBox(
                height: 20,
              ),
              Text(
                "Conform Password",
                overflow: TextOverflow.ellipsis,
                // textAlign: TextAlign.left,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontFamily: "outfit",
                    fontSize: 14),
              ),
              CustomTextFormField(
                // focusNode: FocusNode(),
                // autofocus: true,
                controller: passwordController,
                margin: getMargin(
                  top: 5,
                ),
                contentPadding: getPadding(
                  left: 20,
                  top: 14,
                  bottom: 14,
                ),
                textStyle: theme.textTheme.titleMedium!,
                hintText: "Password",
                hintStyle: theme.textTheme.titleMedium!,
                textInputType: TextInputType.visiblePassword,
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
                        Show_Passwordd = !Show_Passwordd;
                      });
                    },
                    child: Show_Passwordd
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
                obscureText: Show_Passwordd ? true : false,
                filled: true,
                fillColor: appTheme.gray100,
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                height: 50,
                width: width / 1.2,
                decoration: BoxDecoration(
                    color: Color(0XFFED1C25),
                    borderRadius: BorderRadius.circular(6)),
                child: Center(
                    child: Text(
                  "View More",
                  style: TextStyle(
                      fontWeight: FontWeight.w400,
                      color: Colors.white,
                      fontFamily: "outfit",
                      fontSize: 16),
                )),
              ),
            ]),
      ),
    );
  }
}
