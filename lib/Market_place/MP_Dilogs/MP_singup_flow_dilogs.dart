import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pinput/pinput.dart';

import '../../core/utils/color_constant.dart';
import '../../core/utils/image_constant.dart';
import '../../theme/app_decoration.dart';
import '../../theme/theme_helper.dart';
import '../../widgets/custom_image_view.dart';
import '../../widgets/custom_text_form_field.dart';

class ForgetPasswordDilog extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => ForgetPasswordDilogState();
}

class ForgetPasswordDilogState extends State<ForgetPasswordDilog>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> scaleAnimation;
  TextEditingController OTPController = TextEditingController();
  bool isPhonee = false;
  TextEditingController contectnumberrController = TextEditingController();

  @override
  void initState() {
    super.initState();

    controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 450));
    scaleAnimation =
        CurvedAnimation(parent: controller, curve: Curves.elasticInOut);

    controller.addListener(() {
      super.setState(() {});
    });

    controller.forward();
  }

  @override
  void dispose() {
    // TODO: implement dispose

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var _height = MediaQuery.of(context).size.height;
    var _width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: Material(
          color: Color.fromARGB(0, 255, 255, 255),
          child: ScaleTransition(
            scale: scaleAnimation,
            child: Container(
              height: 420,
              width: MediaQuery.of(context).size.width / 1.17,
              decoration: ShapeDecoration(
                color: Color.fromARGB(0, 0, 0, 0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
              ),
              child: Column(
                children: [
                  Container(
                    height: 350,
                    width: MediaQuery.of(context).size.width / 1.17,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: const Color.fromARGB(255, 255, 255, 255)),
                    child: Column(
                      children: [
                        Stack(
                          children: [
                            Column(
                              children: [
                                Align(
                                  alignment: Alignment.center,
                                  child: Padding(
                                      padding: const EdgeInsets.only(top: 20),
                                      child: CustomImageView(
                                        svgPath: ImageConstant.splashImage,
                                        height: 50,
                                      )),
                                ),
                                Padding(
                                    padding: const EdgeInsets.only(top: 0),
                                    child: Text(
                                      "forgot password",
                                      textAlign: TextAlign.center,
                                      textScaleFactor: 1.0,
                                      style: TextStyle(
                                        fontFamily: 'outfit',
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    )),
                              ],
                            ),
                            Positioned(
                              right: 0,
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: Padding(
                                  padding:
                                      const EdgeInsets.only(right: 7, top: 7),
                                  child: Container(
                                    height: 50,
                                    width: 50,
                                    // color: Colors.red,
                                    child: Align(
                                      alignment: Alignment.centerRight,
                                      child: Image.asset(
                                        ImageConstant.closeimage,
                                        fit: BoxFit.fill,
                                        height: 40,
                                        width: 40,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 5, left: 15),
                          child: Align(
                              alignment: Alignment.center,
                              child: Text(
                                "OTP will be sent to Registered Mobile Number",
                                textScaleFactor: 1.0,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontFamily: 'outfit',
                                  fontSize: 15,
                                  fontWeight: FontWeight.w300,
                                ),
                              )),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Align(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                                padding: EdgeInsets.only(left: 14, top: 33),
                                child: Text("Enter Registered Mobile Number",
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        fontFamily: 'outfit',
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500)))),
                        Padding(
                          padding:
                              EdgeInsets.only(top: 11, left: 14, right: 14),
                          child: Container(
                            width: _width / 1.4,
                            child: CustomTextFormField(
                              onChanged: (value) {
                                print("onchange");
                                final RegExp regex = RegExp('[a-zA-Z]');
                                if (contectnumberrController.text.isEmpty ||
                                    !regex.hasMatch(
                                        contectnumberrController.text)) {
                                  super.setState(() {
                                    isPhonee = true;
                                  });
                                } else {
                                  super.setState(() {
                                    isPhonee = false;
                                  });
                                }
                              },
                              maxLength: isPhonee == true ? 10 : 50,
                              // focusNode: FocusNode(),
                              controller: contectnumberrController,
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
                              hintText: "Mobile Number",
                              filled: true,
                              fillColor: appTheme.gray100,
                              textInputAction: TextInputAction.done,
                              textInputType: TextInputType.number,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 0, top: 15),
                          child: GestureDetector(
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  top: 10, left: 20, right: 20),
                              child: Container(
                                height: _height / 18,
                                width: _width,
                                decoration: BoxDecoration(
                                  color: ColorConstant.primary_color,
                                  borderRadius:
                                      BorderRadiusStyle.roundedBorder6,
                                ),
                                child: Center(
                                  child: Text("send OTP",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontFamily: 'outfit',
                                          color: Colors.white,
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold)),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
//----------------------------------------------------------------------------------------------------------------------
class OtpVarificationDilog extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => OtpVarificationDilogState();
}

class OtpVarificationDilogState extends State<OtpVarificationDilog>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> scaleAnimation;
  TextEditingController OTPController = TextEditingController();
  Timer? _timer;
  int GetTime = 0;
  int _secondsRemaining = 0;
  int otpTimer = 0;
  bool tm = false;

  @override
  void initState() {
    super.initState();

    controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 450));
    scaleAnimation =
        CurvedAnimation(parent: controller, curve: Curves.elasticInOut);

    controller.addListener(() {
      super.setState(() {});
    });

    controller.forward();
  }

  @override
  void dispose() {
    // TODO: implement dispose

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var _height = MediaQuery.of(context).size.height;
    var _width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: Material(
          color: Color.fromARGB(0, 255, 255, 255),
          child: ScaleTransition(
            scale: scaleAnimation,
            child: Container(
              height: 420,
              width: MediaQuery.of(context).size.width / 1.17,
              decoration: ShapeDecoration(
                color: Color.fromARGB(0, 0, 0, 0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
              ),
              child: Column(
                children: [
                  Container(
                    height: 420,
                    width: MediaQuery.of(context).size.width / 1.17,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: const Color.fromARGB(255, 255, 255, 255)),
                    child: Column(
                      children: [
                        Stack(
                          children: [
                            Column(
                              children: [
                                Align(
                                  alignment: Alignment.center,
                                  child: Padding(
                                      padding: const EdgeInsets.only(top: 20),
                                      child: CustomImageView(
                                        svgPath: ImageConstant.splashImage,
                                        height: 50,
                                      )),
                                ),
                                Padding(
                                    padding: const EdgeInsets.only(top: 0),
                                    child: Text(
                                      "OTP Verification",
                                      textAlign: TextAlign.center,
                                      textScaleFactor: 1.0,
                                      style: TextStyle(
                                        fontFamily: 'outfit',
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    )),
                              ],
                            ),
                            Positioned(
                              right: 0,
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: Padding(
                                  padding:
                                      const EdgeInsets.only(right: 7, top: 7),
                                  child: Container(
                                    height: 50,
                                    width: 50,
                                    // color: Colors.red,
                                    child: Align(
                                      alignment: Alignment.centerRight,
                                      child: Image.asset(
                                        ImageConstant.closeimage,
                                        fit: BoxFit.fill,
                                        height: 40,
                                        width: 40,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 5, left: 15),
                          child: Align(
                              alignment: Alignment.center,
                              child: Text(
                                "One time Password to be sent to 1234 567 890",
                                textScaleFactor: 1.0,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontFamily: 'outfit',
                                  fontSize: 15,
                                  fontWeight: FontWeight.w300,
                                ),
                              )),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Align(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                                padding: EdgeInsets.only(left: 14, top: 33),
                                child: Text("Enter OTP",
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        fontFamily: 'outfit',
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500)))),
                        Padding(
                          padding:
                              EdgeInsets.only(top: 11, left: 14, right: 14),
                          child: Pinput(
                            length: 6,
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            controller: OTPController,
                            defaultPinTheme: PinTheme(
                              width: 50,
                              height: 45,
                              margin: EdgeInsets.all(2),
                              textStyle: TextStyle(
                                  fontSize: 20,
                                  color: Colors.grey,
                                  fontWeight: FontWeight.w500),
                              decoration: BoxDecoration(
                                // color: ColorConstant.gray100,
                                color: Colors.white,
                                border: Border.all(color: Colors.grey),
                                borderRadius: BorderRadius.circular(5),
                              ),
                            ),
                            pinputAutovalidateMode:
                                PinputAutovalidateMode.onSubmit,
                            showCursor: true,
                            onCompleted: (pin) => print(pin),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 0, top: 15),
                          child: GestureDetector(
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  top: 10, left: 20, right: 20),
                              child: Container(
                                height: _height / 18,
                                width: _width,
                                decoration: BoxDecoration(
                                  color: ColorConstant.primary_color,
                                  borderRadius:
                                      BorderRadiusStyle.roundedBorder6,
                                ),
                                child: Center(
                                  child: Text("Verify OTP",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontFamily: 'outfit',
                                          color: Colors.white,
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold)),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 19, bottom: 5),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("Valid for ${_timerText} minutes",
                                    textScaleFactor: 1.0,
                                    style: TextStyle(
                                        // color: ColorConstant.black90066,
                                        color: Colors.grey,
                                        fontSize: 16,
                                        fontFamily: 'Outfit',
                                        fontWeight: FontWeight.w500)),
                                tm
                                    ? GestureDetector(
                                        onTap: () {
                                          super.setState(() {
                                            OTPController.clear();
                                            tm = false;
                                            _startTimer();
                                          });
                                        },
                                        child: Text("Resend",
                                            textScaleFactor: 1.0,
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 16,
                                                fontFamily: 'Outfit',
                                                fontWeight: FontWeight.w500,
                                                decoration:
                                                    TextDecoration.underline)),
                                      )
                                    : Text("Resend",
                                        textScaleFactor: 1.0,
                                        style: TextStyle(
                                            color: ColorConstant.primary_color,
                                            fontSize: 16,
                                            fontFamily: 'Outfit',
                                            fontWeight: FontWeight.w500,
                                            decoration:
                                                TextDecoration.underline)),
                              ]),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      super.setState(() {
        if (_secondsRemaining > 0) {
          _secondsRemaining--;
        } else {
          _timer!.cancel();
          tm = true;
          _secondsRemaining = otpTimer;
        }
      });
    });
  }

  String get _timerText {
    Duration duration = Duration(seconds: _secondsRemaining);
    return '${duration.inMinutes.remainder(60).toString().padLeft(2, '0')}:${duration.inSeconds.remainder(60).toString().padLeft(2, '0')}';
  }
}
//----------------------------------------------------------------------------------------------------------------------
class ChangePasswordDilog extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => ChangePasswordDilogState();
}

class ChangePasswordDilogState extends State<ChangePasswordDilog>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> scaleAnimation;
  TextEditingController OTPController = TextEditingController();
  bool isPhonee = false;
  var Show_Password = true;
  var Show_Passwordd = true;

  TextEditingController newpasswordController = TextEditingController();
  TextEditingController conformpasswordController = TextEditingController();

  @override
  void initState() {
    super.initState();

    controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 450));
    scaleAnimation =
        CurvedAnimation(parent: controller, curve: Curves.elasticInOut);

    controller.addListener(() {
      super.setState(() {});
    });

    controller.forward();
  }

  @override
  void dispose() {
    // TODO: implement dispose

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var _height = MediaQuery.of(context).size.height;
    var _width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: Material(
          color: Color.fromARGB(0, 255, 255, 255),
          child: ScaleTransition(
            scale: scaleAnimation,
            child: Container(
              height: 500,
              width: MediaQuery.of(context).size.width / 1.17,
              decoration: ShapeDecoration(
                color: Color.fromARGB(0, 0, 0, 0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
              ),
              child: Column(
                children: [
                  Container(
                    height: 400,
                    width: MediaQuery.of(context).size.width / 1.17,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: const Color.fromARGB(255, 255, 255, 255)),
                    child: Column(
                      children: [
                        Stack(
                          children: [
                            Column(
                              children: [
                                Align(
                                  alignment: Alignment.center,
                                  child: Padding(
                                      padding: const EdgeInsets.only(top: 20),
                                      child: CustomImageView(
                                        svgPath: ImageConstant.splashImage,
                                        height: 50,
                                      )),
                                ),
                                Padding(
                                    padding: const EdgeInsets.only(top: 0),
                                    child: Text(
                                      "Change Password",
                                      textAlign: TextAlign.center,
                                      textScaleFactor: 1.0,
                                      style: TextStyle(
                                        fontFamily: 'outfit',
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    )),
                              ],
                            ),
                            Positioned(
                              right: 0,
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: Padding(
                                  padding:
                                      const EdgeInsets.only(right: 7, top: 7),
                                  child: Container(
                                    height: 50,
                                    width: 50,
                                    // color: Colors.red,
                                    child: Align(
                                      alignment: Alignment.centerRight,
                                      child: Image.asset(
                                        ImageConstant.closeimage,
                                        fit: BoxFit.fill,
                                        height: 40,
                                        width: 40,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Align(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                                padding: EdgeInsets.only(left: 14, top: 33),
                                child: Text("New Password",
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        fontFamily: 'outfit',
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500)))),
                        Padding(
                          padding:
                              EdgeInsets.only(top: 11, left: 14, right: 14),
                          child: Container(
                            // width: _width / 1.4,
                            child: CustomTextFormField(
                              controller: newpasswordController,
                              textStyle: theme.textTheme.titleMedium!,
                              hintText: "Enter Password",
                              maxLength: 50,
                              hintStyle: theme.textTheme.titleMedium!,
                              textInputType: TextInputType.visiblePassword,
                              errorMaxLines: 3,
                              inputFormatters: [
                                FilteringTextInputFormatter.deny(RegExp(r'\s')),
                              ],
                              validator: (value) {
                                value?.trim();
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
                              suffix: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  child: GestureDetector(
                                    onTap: () {
                                      if (mounted) {
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
                              ),
                              suffixConstraints: BoxConstraints(maxHeight: 50),
                              obscureText: Show_Password ? true : false,
                              filled: true,
                              fillColor: appTheme.gray100,
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 14.0, top: 10),
                            child: Text(
                              "Confirm Password",
                              overflow: TextOverflow.ellipsis,
                              // textAlign: TextAlign.left,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                  fontFamily: "outfit",
                                  fontSize: 14),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 11, left: 14, right: 14),
                          child: Container(
                            child: CustomTextFormField(
                              // focusNode: FocusNode(),
                              // autofocus: true,
                              controller: conformpasswordController,

                              textStyle: theme.textTheme.titleMedium!,
                              hintText: "Confirm Password", maxLength: 50,
                              hintStyle: theme.textTheme.titleMedium!,
                              textInputType: TextInputType.visiblePassword,
                              inputFormatters: [
                                FilteringTextInputFormatter.deny(RegExp(r'\s')),
                              ],
                              errorMaxLines: 3,
                              validator: (value) {
                                value?.trim();
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
                              suffix: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  child: GestureDetector(
                                    onTap: () {
                                      super.setState(() {
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
                              ),
                              suffixConstraints: BoxConstraints(maxHeight: 50),
                              obscureText: Show_Passwordd ? true : false,
                              filled: true,
                              fillColor: appTheme.gray100,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 0, top: 15),
                          child: GestureDetector(
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  top: 10, left: 20, right: 20),
                              child: GestureDetector(
                                onTap: () {
                                  if (conformpasswordController.text !=
                                      newpasswordController.text) {
                                    SnackBar snackBar = SnackBar(
                                      content: Text(
                                          'New Password and Confirm Password Are Not Same'),
                                      backgroundColor:
                                          ColorConstant.primary_color,
                                    );

                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(snackBar);
                                  }
                                },
                                child: Container(
                                  height: _height / 18,
                                  width: _width,
                                  decoration: BoxDecoration(
                                    color: ColorConstant.primary_color,
                                    borderRadius:
                                        BorderRadiusStyle.roundedBorder6,
                                  ),
                                  child: Center(
                                    child: Text("Change Password",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontFamily: 'outfit',
                                            color: Colors.white,
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold)),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
//----------------------------------------------------------------------------------------------------------------------
