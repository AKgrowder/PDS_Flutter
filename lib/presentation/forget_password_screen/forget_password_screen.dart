import 'package:archit_s_application1/core/app_export.dart';
import 'package:archit_s_application1/presentation/change_password_screen/change_password_screen.dart';
import 'package:archit_s_application1/widgets/app_bar/appbar_image.dart';
import 'package:archit_s_application1/widgets/app_bar/custom_app_bar.dart';
import 'package:archit_s_application1/widgets/custom_elevated_button.dart';
import 'package:archit_s_application1/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';

// ignore_for_file: must_be_immutable
class ForgetPasswordScreen extends StatefulWidget {
  ForgetPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  TextEditingController mobilenumberController = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController contectnumberController = TextEditingController();
  bool isPhonee = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            backgroundColor: theme.colorScheme.onPrimary,
            resizeToAvoidBottomInset: false,
            appBar: CustomAppBar(
                height: 89,
                leadingWidth: 54,
                leading: AppbarImage(
                    height: 23,
                    width: 24,
                    svgPath: ImageConstant.imgArrowleft,
                    margin: EdgeInsets.only(
                        left: 30, top: 13, bottom: 19, right: 5),
                    onTap: () {
                      onTapArrowleft1(context);
                    }),
                centerTitle: true,
                title: Text("Forget Password",
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        fontFamily: 'outfit',
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black))),
            body: Form(
                key: _formKey,
                child: Container(
                    width: double.maxFinite,
                    padding: EdgeInsets.only(left: 30, right: 30),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Center(
                            child: Text(
                              "OTP will be sent to Registered Mobile Number",
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  fontFamily: 'outfit',
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.grey),
                              // style: TextThemeHelper.bodyMediumBlack900
                            ),
                          ),
                          Padding(
                              padding: EdgeInsets.only(top: 35),
                              child: Text(
                                "Enter Registered Mobile Number",
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    fontFamily: 'outfit',
                                    fontSize: 13,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.black),
                              )),
                          CustomTextFormField(
                            onChanged: (value) {
                              print("onchange");
                              final RegExp regex = RegExp('[a-zA-Z]');
                              if (contectnumberController.text == null ||
                                  contectnumberController.text.isEmpty ||
                                  !regex
                                      .hasMatch(contectnumberController.text)) {
                                setState(() {
                                  isPhonee = true;
                                });
                              } else {
                                setState(() {
                                  isPhonee = false;
                                });
                              }
                            },
                            maxLength: isPhonee == true ? 10 : 30,
                            // focusNode: FocusNode(),
                            controller: contectnumberController,
                            margin: EdgeInsets.only(
                              left: 0,
                              right: 0,
                            ),
                            contentPadding: EdgeInsets.only(
                              left: 12,
                              top: 14,
                              right: 12,
                              bottom: 14,
                            ),
                            // textStyle: theme.textTheme.titleMedium!,
                            hintText: "Enter Mobile Number",
                            hintStyle: TextStyle(
                              fontFamily: 'outfit',
                              fontSize: 13,
                              fontWeight: FontWeight.w400,
                            ),
                            textInputAction: TextInputAction.next,
                            textInputType: TextInputType.emailAddress,
                            filled: true,
                            fillColor: appTheme.gray100,
                          ),
                          CustomElevatedButton(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        ChangePasswordScreen(),
                                  ));
                            },
                            text: "Send OTP",
                            margin: EdgeInsets.only(top: 51, bottom: 5),
                            buttonStyle: ButtonThemeHelper.outlineOrangeA7000c
                                .copyWith(
                                    fixedSize: MaterialStateProperty.all<Size>(
                                        Size(double.infinity, 50))),
                            buttonTextStyle: TextStyle(
                                fontFamily: 'outfit',
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          )
                        ])))));
  }

  /// Navigates back to the previous screen.
  ///
  /// This function takes a [BuildContext] object as a parameter, which is used
  /// to navigate back to the previous screen.
  onTapArrowleft1(BuildContext context) {
    Navigator.pop(context);
  }
}
