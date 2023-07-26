import 'dart:async';

import 'package:archit_s_application1/core/app_export.dart';
import 'package:archit_s_application1/widgets/app_bar/appbar_image.dart';
import 'package:archit_s_application1/widgets/app_bar/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart' as fs;
import 'package:pinput/pinput.dart';

// ignore_for_file: must_be_immutable
class OtpVerificationScreen extends StatefulWidget {
  OtpVerificationScreen({Key? key}) : super(key: key);

  @override
  State<OtpVerificationScreen> createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen> {
  TextEditingController groupfourController = TextEditingController();

  TextEditingController OTPController = TextEditingController();

  Timer? _timer;

  int GetTime = 0;

  int _secondsRemaining = 0;
  

  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (_secondsRemaining > 0) {
          _secondsRemaining--;
        } else {
          _timer!.cancel();
          // model!.data!.forEach((element) {
          //   if (element.name == "ResendTimerInSeconds") {
          //     GetTime = int.parse(element.value!);
          //     SetUi();
          //   }
          // });
          _secondsRemaining = GetTime;
        }
      });
    });
  }
 
  String get _timerText {
    Duration duration = Duration(seconds: _secondsRemaining);
    return '${duration.inMinutes.remainder(60).toString().padLeft(2, '0')}:${duration.inSeconds.remainder(60).toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return SafeArea(
        child: Scaffold(
            backgroundColor: theme.colorScheme.onPrimary,
            resizeToAvoidBottomInset: false,
            appBar: CustomAppBar(
                height: getVerticalSize(83),
                leadingWidth: 54,
                leading: AppbarImage(
                    height: getVerticalSize(23),
                    width: getHorizontalSize(24),
                    svgPath: ImageConstant.imgArrowleft,
                    margin: getMargin(left: 20, top: 19, bottom: 13, right: 15),
                    onTap: () {
                      onTapArrowleft(context);
                    }),
                centerTitle: true,
                title: AppbarImage(
                    height: getVerticalSize(37),
                    width: getHorizontalSize(140),
                    imagePath: ImageConstant.imgImage248)),
            body: Container(
                width: double.maxFinite,
                padding: getPadding(left: 15, top: 38, right: 15, bottom: 38),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text("OTP Verification",
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.left,
                          style: theme.textTheme.titleLarge),
                      Padding(
                          padding: getPadding(top: 4),
                          child: RichText(
                              text: TextSpan(children: [
                                TextSpan(
                                    text: "One time Password to be sent to ",
                                    style: TextStyle(
                                        color: appTheme.gray50001,
                                        fontSize: getFontSize(16),
                                        fontFamily: 'Outfit',
                                        fontWeight: FontWeight.w400)),
                                TextSpan(
                                    text: "1234 567 890",
                                    style: TextStyle(
                                        color: appTheme.gray50001,
                                        fontSize: getFontSize(16),
                                        fontFamily: 'Outfit',
                                        fontWeight: FontWeight.w400))
                              ]),
                              textAlign: TextAlign.left)),
                      Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                              padding: getPadding(left: 14, top: 33),
                              child: Text("Enter OTP",
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.left,
                                  style: theme.textTheme.bodyLarge))),
                      Padding(
                        padding: getPadding(
                          top: 11,
                        ),
                        child: Pinput(
                          length: 6,
                          controller: OTPController,
                          defaultPinTheme: PinTheme(
                            width: 50,
                            height: 56,
                            margin: EdgeInsets.all(2),
                            textStyle: TextStyle(
                                fontSize: 20,
                                color: Colors.grey,
                                fontWeight: FontWeight.w500),
                            decoration: BoxDecoration(
                              // color: ColorConstant.gray100,
                              color: Colors.grey.shade100,
                              border: Border.all(
                                  color: Color.fromRGBO(234, 239, 243, 1)),
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          pinputAutovalidateMode:
                              PinputAutovalidateMode.onSubmit,
                          showCursor: true,
                          onCompleted: (pin) => print(pin),
                        ),
                      ),
                      SizedBox(
                        width: double.maxFinite,
                        child: Container(
                          margin: getMargin(top: 22),
                          height: height / 16,
                          // padding: getPadding(
                          //     left: 150, top: 15, right: 150, bottom: 15),
                          decoration: BoxDecoration(
                            color: Color(0XFFED1C25),
                            borderRadius: BorderRadiusStyle.roundedBorder6,
                            image: DecorationImage(
                                image: fs.Svg(ImageConstant.imgGroup1000003011),
                                fit: BoxFit.cover),
                          ),
                          child: Column(
                            // mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("Verify OTP",
                                  // overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.center,
                                  style: TextThemeHelper.titleMediumOnPrimary),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: getPadding(top: 19, bottom: 5),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("Valid for ${_timerText} minutes",
                                  textScaleFactor: 1.0,
                                  style: TextStyle(
                                      // color: ColorConstant.black90066,
                                      color: Colors.grey,
                                      fontSize: getFontSize(16),
                                      fontFamily: 'Outfit',
                                      fontWeight: FontWeight.w500)),
                              GestureDetector(
                                onTap: () {
                                  if (_secondsRemaining == GetTime ||
                                      _secondsRemaining == 0) {
                                    _startTimer();
                                  }
                                },
                                child: Text("Resend",
                                    textScaleFactor: 1.0,
                                    style: TextStyle(
                                        color: (_secondsRemaining != GetTime &&
                                                _secondsRemaining != 0)
                                            ? Theme.of(context).brightness ==
                                                    Brightness.light
                                                ? Colors.black
                                                : Colors
                                                    .white /* ColorConstant.black90066 */
                                            : Colors.red,
                                        fontSize: getFontSize(16),
                                        fontFamily: 'Outfit',
                                        fontWeight: FontWeight.w500,
                                        decoration: TextDecoration.underline)),
                              ),
                            ]),
                      )
                    ]))));
  }

  /// Navigates back to the previous screen.
  ///
  /// This function takes a [BuildContext] object as a parameter, which is used
  /// to navigate back to the previous screen.
  onTapArrowleft(BuildContext context) {
    Navigator.pop(context);
  }
}
