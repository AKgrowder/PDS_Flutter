import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pds/API/Bloc/Forget_password_Bloc/forget_password_cubit.dart';
import 'package:pds/API/Bloc/auth/login_Block.dart';
import 'package:pds/API/Bloc/auth/otp_block.dart';
import 'package:pds/API/Bloc/auth/otp_state.dart';
import 'package:pds/core/app_export.dart';
import 'package:pds/core/utils/color_constant.dart';
import 'package:pds/custom_bottom_bar/custom_bottom_bar.dart';
import 'package:pds/presentation/change_password_screen/change_password_screen.dart';
import 'package:pds/presentation/register_create_account_screen/register_create_account_screen.dart';
import 'package:pds/widgets/app_bar/appbar_image.dart';
import 'package:pds/widgets/app_bar/custom_app_bar.dart';
import 'package:pinput/pinput.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../API/Bloc/Fatch_All_PRoom_Bloc/Fatch_PRoom_cubit.dart';
import '../../API/Bloc/GetAllPrivateRoom_Bloc/GetAllPrivateRoom_cubit.dart';
import '../../API/Bloc/Invitation_Bloc/Invitation_cubit.dart';
import '../../API/Bloc/PublicRoom_Bloc/CreatPublicRoom_cubit.dart';
import '../../API/Bloc/auth/register_Block.dart';
import '../../API/Bloc/device_info_Bloc/device_info_bloc.dart';
import '../../API/Bloc/senMSG_Bloc/senMSG_cubit.dart';
import '../../API/Model/authModel/loginModel.dart';
import '../../core/utils/sharedPreferences.dart';
import '../Login_Screen/Login_Screen.dart';

// ignore_for_file: must_be_immutable
class OtpVerificationScreen extends StatefulWidget {
  String? phonNumber;
  String? flowCheck;
  String? userId;
  bool? isProfile;

  bool? forgetpassword;
  LoginModel? loginModelData;

  OtpVerificationScreen(
      {Key? key,
      this.phonNumber,
      this.flowCheck,
      this.userId,
      this.isProfile = false,
      this.forgetpassword = false,
      this.loginModelData})
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
  int otpTimer = 0;
  bool tm = false;

  timer() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    otpTimer = await prefs.getInt(PreferencesKey.otpTimer) ?? 0;
    print(" otp timer  ${otpTimer}");
    setState(() {
      _secondsRemaining = otpTimer;
    });
  }

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

  @override
  void initState() {
    print(widget.loginModelData?.object);
    super.initState();
    timer();
    _startTimer();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var _height = MediaQuery.of(context).size.height;
    var _width = MediaQuery.of(context).size.width;
    return SafeArea(
        child: WillPopScope(
      onWillPop: () async {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => RegisterCreateAccountScreen()));
        return true;
      },
      child: Scaffold(
          backgroundColor: theme.colorScheme.onPrimary,
          resizeToAvoidBottomInset: false,
          appBar: CustomAppBar(
              height: 83,
              leadingWidth: 54,
              leading: AppbarImage(
                  height: 23,
                  width: 24,
                  svgPath: ImageConstant.imgArrowleft,
                  margin:
                      EdgeInsets.only(left: 20, top: 19, bottom: 13, right: 15),
                  onTap: () {
                    // onTapArrowleft(context);
                    Navigator.pop(context);
                  }),
              centerTitle: true,
              title: AppbarImage(
                  height: 37,
                  width: 140,
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
                  OTPController.clear();
                  print('i want flow checlk-${widget.flowCheck}');
                  if (widget.flowCheck != null) {
                    SnackBar snackBar = SnackBar(
                      content: Text('Otp verification Successfully'),
                      backgroundColor: ColorConstant.primary_color,
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    SnackBar snackBar2 = SnackBar(
                      content: Text('Signup Successfully'),
                      backgroundColor: ColorConstant.primary_color,
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snackBar2);
                  }

                  print('wiget flowcheck-${widget.flowCheck}');
                  if (widget.flowCheck == "Rgister") {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return MultiBlocProvider(
                          providers: [
                            BlocProvider<LoginCubit>(
                              create: (context) => LoginCubit(),
                            ),
                            BlocProvider<DevicesInfoCubit>(
                              create: (context) => DevicesInfoCubit(),
                            )
                          ],
                          child: LoginScreen(
                            flagCheck: 'otp done',
                          ));
                    }));
                  } else if (widget.forgetpassword == true) {
                    SnackBar snackBar = SnackBar(
                      content: Text('Otp verify Successfully'),
                      backgroundColor: ColorConstant.primary_color,
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    print("hhhhhhh ${widget.isProfile}");
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return MultiBlocProvider(
                          providers: [
                            BlocProvider<ForgetpasswordCubit>(
                              create: (context) => ForgetpasswordCubit(),
                            )
                          ],
                          child: ChangePasswordScreen(
                            mobile: widget.phonNumber,
                            isProfile: widget.isProfile == true ? true : false,
                          ));
                    }));
                  } else {
                    getDataStroe(
                        widget.loginModelData?.object?.uuid.toString() ?? "",
                        widget.loginModelData?.object?.jwt.toString() ?? "",
                        widget.loginModelData?.object?.module.toString() ?? ""
                        // state.loginModel.object!.verified.toString(),
                        );
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return MultiBlocProvider(providers: [
                        BlocProvider<FetchAllPublicRoomCubit>(
                          create: (context) => FetchAllPublicRoomCubit(),
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
                        BlocProvider<GetAllPrivateRoomCubit>(
                          create: (context) => GetAllPrivateRoomCubit(),
                        ),
                        BlocProvider<InvitationCubit>(
                          create: (context) => InvitationCubit(),
                        ),
                      ], child: BottombarPage(buttomIndex: 0));
                    }));
                  }
                }
              },
              builder: (context, state) {
                return Container(
                    // width: double.maxFinite,
                    padding: EdgeInsets.only(
                        left: 15, top: 38, right: 15, bottom: 38),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text("OTP Verification",
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  fontFamily: 'outfit',
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold)),
                          Padding(
                              padding: EdgeInsets.only(top: 4),
                              child: RichText(
                                  text: TextSpan(children: [
                                    TextSpan(
                                        text:
                                            "One time Password to be sent to ",
                                        style: TextStyle(
                                            color: appTheme.gray50001,
                                            fontSize: 16,
                                            fontFamily: 'Outfit',
                                            fontWeight: FontWeight.w400)),
                                    TextSpan(
                                        text: widget.phonNumber,
                                        style: TextStyle(
                                            color: appTheme.gray50001,
                                            fontSize: 16,
                                            fontFamily: 'Outfit',
                                            fontWeight: FontWeight.w400))
                                  ]),
                                  textAlign: TextAlign.left)),
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
                            padding: EdgeInsets.only(
                              top: 11,
                            ),
                            child: Pinput(
                              length: 6,
                              inputFormatters: <TextInputFormatter>[
                                FilteringTextInputFormatter.digitsOnly
                              ],
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
                              if (OTPController.text.isEmpty) {
                                SnackBar snackBar = SnackBar(
                                  content: Text('Please Enter Valid OTP'),
                                  backgroundColor: ColorConstant.primary_color,
                                );
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(snackBar);
                              } else if (OTPController.text.length < 6) {
                                SnackBar snackBar = SnackBar(
                                  content: Text('Please Enter Valid OTP'),
                                  backgroundColor: ColorConstant.primary_color,
                                );
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(snackBar);
                              } else {
                                print('vhbghghg');
                                BlocProvider.of<OtpCubit>(context).OtpApi(
                                    OTPController.text,
                                    widget.phonNumber.toString(),
                                    context);
                              }
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(top: 20),
                              child: Container(
                                height: _height / 16,
                                width: _width,
                                decoration: BoxDecoration(
                                  color: Color(0XFFED1C25),
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
                                            setState(() {
                                              tm = false;
                                              _startTimer();
                                            });
                                          },
                                          child: Text("Resend",
                                              textScaleFactor: 1.0,
                                              style: TextStyle(
                                                  color: Colors.red,
                                                  fontSize: 16,
                                                  fontFamily: 'Outfit',
                                                  fontWeight: FontWeight.w500,
                                                  decoration: TextDecoration
                                                      .underline)),
                                        )
                                      : Text("Resend",
                                          textScaleFactor: 1.0,
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 16,
                                              fontFamily: 'Outfit',
                                              fontWeight: FontWeight.w500,
                                              decoration:
                                                  TextDecoration.underline)),
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
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => RegisterCreateAccountScreen()));
  }

  getDataStroe(String userId, String jwt, String user_Module) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(PreferencesKey.loginUserID, userId);
    prefs.setString(PreferencesKey.loginJwt, jwt);
    prefs.setString(PreferencesKey.module, user_Module);
    // prefs.setString(PreferencesKey.loginVerify, verify);
    print('userId-$userId');
    print('jwt-$jwt');
    // print('verify-$verify');
  }
}
