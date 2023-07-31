import 'dart:async';

import 'package:archit_s_application1/API/Bloc/auth/login_Block.dart';
import 'package:archit_s_application1/API/Bloc/auth/otp_block.dart';
import 'package:archit_s_application1/API/Bloc/auth/otp_state.dart';
import 'package:archit_s_application1/core/app_export.dart';
import 'package:archit_s_application1/core/utils/color_constant.dart';
import 'package:archit_s_application1/presentation/home/home.dart';
import 'package:archit_s_application1/widgets/app_bar/appbar_image.dart';
import 'package:archit_s_application1/widgets/app_bar/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart' as fs;
import 'package:pinput/pinput.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../API/Bloc/Fatch_All_PRoom_Bloc/Fatch_PRoom_cubit.dart';
import '../../API/Bloc/PublicRoom_Bloc/CreatPublicRoom_cubit.dart';
import '../../API/Bloc/auth/register_Block.dart';
import '../../API/Bloc/senMSG_Bloc/senMSG_cubit.dart';
import '../../core/utils/sharedPreferences.dart';
import '../Login_Screen/Login_Screen.dart';

// ignore_for_file: must_be_immutable
class OtpVerificationScreen extends StatefulWidget {
  String? phonNumber;
  String? flowCheck;
  String? userId;
  OtpVerificationScreen(
      {Key? key, this.phonNumber, this.flowCheck, this.userId})
      : super(key: key);

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
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return SafeArea(
        child: WillPopScope(
      onWillPop: () async => await false,
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
          body: BlocProvider<OtpCubit>(
            create: (context) => OtpCubit(),
            child: BlocConsumer<OtpCubit, OtpState>(
              listener: (context, state) async {
                if (state is OtpErrorState) {
                  print("error");
                  SnackBar snackBar = SnackBar(
                    content: Text(state.error),
                    backgroundColor: ColorConstant.primary_color,
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                }

                if (state is OtpLoadingState) {
                  print("loading");
                  Center(
                    child: Container(
                      margin: EdgeInsets.only(bottom: 100),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.asset(ImageConstant.loader,
                            fit: BoxFit.cover, height: 100.0, width: 100),
                      ),
                    ),
                  );
                }
                if (state is OtpLoadedState) {
                  SnackBar snackBar = SnackBar(
                    content: Text(state.otpModel.message ?? ""),
                    backgroundColor: ColorConstant.primary_color,
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                   print('wiget flowcheck-${widget.flowCheck}');     
                  if (widget.flowCheck == "Rgister") {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return MultiBlocProvider(providers: [
                        BlocProvider<LoginCubit>(
                          create: (context) => LoginCubit(),
                        )
                      ], child: LoginScreen());
                    }));
                  
                  } else {
                     
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return MultiBlocProvider(providers: [
                        BlocProvider<FetchAllPublicRoomCubit>(
                          create: (context) =>   FetchAllPublicRoomCubit(),
                        ),
                        BlocProvider<CreatPublicRoomCubit>(
                          create: (context) => CreatPublicRoomCubit(),
                        ),
                        BlocProvider<senMSGCubit>(
                          create: (context) => senMSGCubit(),
                        ),
                        BlocProvider<RegisterCubit>(
                          create: (context) => RegisterCubit(),
                        ),
                      ], child: HomeScreen());
                    }));
                   
                  }
                }
              },
              builder: (context, state) {
                return Container(
                    width: double.maxFinite,
                    padding:
                        getPadding(left: 15, top: 38, right: 15, bottom: 38),
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
                                        text:
                                            "One time Password to be sent to ",
                                        style: TextStyle(
                                            color: appTheme.gray50001,
                                            fontSize: getFontSize(16),
                                            fontFamily: 'Outfit',
                                            fontWeight: FontWeight.w400)),
                                    TextSpan(
                                        text: widget.phonNumber,
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
                          GestureDetector(
                            onTap: () {
                              print('vhbghghg');
                              BlocProvider.of<OtpCubit>(context)
                                  .OtpApi(widget.phonNumber.toString());
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(top: 20),
                              child: Container(
                                height: height / 16,
                                width: width,
                                decoration: BoxDecoration(
                                  color: Color(0XFFED1C25),
                                  borderRadius:
                                      BorderRadiusStyle.roundedBorder6,
                                ),
                                child: Center(
                                  child: Text("Verify OTP",
                                      textAlign: TextAlign.center,
                                      style:
                                          TextThemeHelper.titleMediumOnPrimary),
                                ),
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
                                            color: (_secondsRemaining !=
                                                        GetTime &&
                                                    _secondsRemaining != 0)
                                                ? Theme.of(context)
                                                            .brightness ==
                                                        Brightness.light
                                                    ? Colors.black
                                                    : Colors
                                                        .white /* ColorConstant.black90066 */
                                                : Colors.red,
                                            fontSize: getFontSize(16),
                                            fontFamily: 'Outfit',
                                            fontWeight: FontWeight.w500,
                                            decoration:
                                                TextDecoration.underline)),
                                  ),
                                ]),
                          )
                        ]));
              },
            ),
          )),
    ));
  }

  /// Navigates back to the previous screen.
  ///
  /// This function takes a [BuildContext] object as a parameter, which is used
  /// to navigate back to the previous screen.
  onTapArrowleft(BuildContext context) {
    Navigator.pop(context);
  }

    getDataStroe(
    String userId,
    String jwt,
  ) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(PreferencesKey.loginUserID, userId);
    prefs.setString(PreferencesKey.loginJwt, jwt);
    // prefs.setString(PreferencesKey.loginVerify, verify);
    print('userId-$userId');
    print('jwt-$jwt');
    // print('verify-$verify');
  }
}
