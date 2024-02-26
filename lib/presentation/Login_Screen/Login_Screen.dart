import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pds/API/Bloc/auth/login_Block.dart';
import 'package:pds/API/Bloc/auth/login_state.dart';
import 'package:pds/core/app_export.dart';
import 'package:pds/core/utils/color_constant.dart';
import 'package:pds/core/utils/sharedPreferences.dart';
import 'package:pds/presentation/%20new/newbottembar.dart';
import 'package:pds/presentation/Login_Screen/UserReActivate_screen.dart';
import 'package:pds/presentation/otp_verification_screen/otp_verification_screen.dart';
import 'package:pds/presentation/register_create_account_screen/register_create_account_screen.dart';
import 'package:pds/widgets/custom_elevated_button.dart';
import 'package:pds/widgets/custom_text_form_field.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../API/Bloc/UserReActivate_Bloc/UserReActivate_cubit.dart';
import '../../API/Bloc/device_info_Bloc/device_info_bloc.dart';
import '../../API/Model/authModel/getUserDetailsMdoel.dart';
import '../../API/Model/authModel/loginModel.dart';
import '../../widgets/app_bar/appbar_image.dart';
import '../forget_password_screen/forget_password_screen.dart';

class LoginScreen extends StatefulWidget {
  String? flagCheck;
  LoginScreen({Key? key, this.flagCheck})
      : super(
          key: key,
        );

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController mobilenumberController = TextEditingController();

  TextEditingController passwordoneController = TextEditingController();

  TextEditingController emailAndMobileController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  LoginModel? loginModelData;
  GetUserDataModel? getUserDataModelData;

  bool Show_Password = true;
  bool isPhone = false;
  bool saveDeviceInfo = true;
  bool SubmitOneTime = false;

  @override
  Widget build(BuildContext context) {
    var _height = MediaQuery.of(context).size.height;
    var _width = MediaQuery.of(context).size.width;
    return WillPopScope(
      onWillPop: () async {
        if (widget.flagCheck != null || widget.flagCheck == 'otp done') {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => RegisterCreateAccountScreen()));
        } else {
          Navigator.pop(context);
        }
        return true;
      },
      child: Scaffold(
        backgroundColor: theme.colorScheme.onPrimary,
        resizeToAvoidBottomInset: true,
        body: BlocProvider<LoginCubit>(
          create: (context) => LoginCubit(),
          child: BlocConsumer<LoginCubit, LoginState>(
            listener: (context, state) async {
              if (state is LoginErrorState) {
                print("vxcvxcv-${state.error.message}");
                SubmitOneTime = false;
                SnackBar snackBar = SnackBar(
                  content: Text(state.error.message),
                  backgroundColor: ColorConstant.primary_color,
                );

                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              }
              if (state is LoginLoadingState) {
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
              if (state is LoginLoadedState) {
                SubmitOneTime = false;
                if (state.loginModel.message == "User Deleted") {
                  showDialog(
                      context: context,
                      builder: (_) => BlocProvider<UserReActivateCubit>(
                            create: (context) {
                              return UserReActivateCubit();
                            },
                            child: UserReActivateDailog(
                              userName: emailAndMobileController.text,
                              password: passwordoneController.text,
                            ),
                          ));
                } else if (state.loginModel.success == false) {
                  SnackBar snackBar = SnackBar(
                    content: Text(state.loginModel.message.toString()),
                    backgroundColor: ColorConstant.primary_color,
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                } else {
                  loginModelData = await state.loginModel;
                  if (state.loginModel.object?.verified == false) {
                    BlocProvider.of<LoginCubit>(context).getUserDetails(
                        state.loginModel.object?.uuid.toString() ?? "",
                        context);
                  }

                  if (state.loginModel.object?.verified == true) {
                    BlocProvider.of<LoginCubit>(context).getUserDetails(
                        state.loginModel.object?.uuid.toString() ?? "",
                        context);
                    getDataStroe(
                        state.loginModel.object?.uuid.toString() ?? "",
                        state.loginModel.object?.jwt.toString() ?? "",
                        loginModelData?.object?.module.toString() ?? "",
                        loginModelData?.object?.profilePic.toString() ?? ""

                        // state.loginModel.object!.verified.toString(),
                        );
                    if (saveDeviceInfo == true) {
                      savePhoneData();
                    }
                    /*   Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return NewBottomBar(
                        buttomIndex: 0,
                      );
                    })); */

                    /* Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return MultiBlocProvider(
                          providers: [
                            BlocProvider<GetGuestAllPostCubit>(
                              create: (context) => GetGuestAllPostCubit(),
                            ),
                          ],
                          child: NewBottomBar(
                            buttomIndex: 0,
                          ));
                    })); */

                    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
                      builder: (context) {
                        return NewBottomBar(buttomIndex: 0);
                      },
                    ), (route) => false);
                  }

                  SnackBar snackBar = SnackBar(
                    content: Text(state.loginModel.message ?? ""),
                    backgroundColor: ColorConstant.primary_color,
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  print('check Status--${state.loginModel.message}');
                }
              }
              if (state is GetUserLoadedState) {
                getUserDataModelData = state.getUserDataModel;
                saveUserProfile();
                print("Get Profile");
                if (loginModelData?.object?.verified == true) {
                  getDataStroe(
                      loginModelData?.object?.uuid.toString() ?? "",
                      loginModelData?.object?.jwt.toString() ?? "",
                      loginModelData?.object?.module.toString() ?? "",
                      loginModelData?.object?.profilePic.toString() ?? "");
                  if (saveDeviceInfo == true) {
                    savePhoneData();
                  }
                  print('this condison is calling');
                  /*    Navigator.push(context,
                      MaterialPageRoute(builder: (context) {
                    return NewBottomBar(
                      buttomIndex: 0,
                    );
                  })); */

                  /* Navigator.push(context,
                      MaterialPageRoute(builder: (context) {
                    return MultiBlocProvider(
                        providers: [
                          BlocProvider<GetGuestAllPostCubit>(
                            create: (context) => GetGuestAllPostCubit(),
                          ),
                        ],
                        child: NewBottomBar(
                          buttomIndex: 0,
                        ));
                  })); */

                  Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
                    builder: (context) {
                      return NewBottomBar(buttomIndex: 0);
                    },
                  ), (route) => false);
                } else {
                  SnackBar snackBar = SnackBar(
                    content: Text('OTP send successfully'),
                    backgroundColor: ColorConstant.primary_color,
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return OtpVerificationScreen(
                      loginModelData: loginModelData,
                      flowCheck: 'login',
                      phonNumber: state.getUserDataModel.object?.mobileNo,
                      userId: loginModelData?.object?.uuid.toString(),
                    );
                  }));
                }
              }
            },
            builder: (context, state) {
              return SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: SizedBox(
                    // width: double.maxFinite,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: _height/2,
                          // height: 348,
                          // width: double.maxFinite,
                          child: Stack(
                            children: [
                              CustomImageView(
                                imagePath: ImageConstant.LoginImage,
                                height: 348,
                                width: 414,
                                alignment: Alignment.center,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 30),
                                child: Container(
                                  alignment: Alignment.topLeft,
                                  child: AppbarImage(
                                      height: 23,
                                      width: 24,
                                      svgPath: ImageConstant.imgArrowleft,
                                      margin: EdgeInsets.only(
                                          left: 20,
                                          top: 19,
                                          bottom: 13,
                                          right: 15),
                                      onTap: () {
                                        if (widget.flagCheck != null ||
                                            widget.flagCheck == 'otp done') {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      RegisterCreateAccountScreen()));
                                        } else {
                                          Navigator.pop(context);
                                        }
                                      }),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            top: 39,
                          ),
                          child: Text(
                            "Log In",
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                fontFamily: 'outfit',
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: EdgeInsets.only(
                              left: 30,
                              top: 41,
                            ),
                            child: Text(
                              "User ID / Mobile Number",
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  fontFamily: 'outfit',
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                        ),
                        CustomTextFormField(
                          validator: (value) {
                            RegExp nameRegExp = RegExp(r"^[a-zA-Z0-9\s'@]+$");
                            if (value!.isEmpty) {
                              return ' Please Enter User ID / Mobile Number';
                            } else if (value.trim().isEmpty) {
                              return 'Name can\'t be just blank spaces';
                            } else if (!nameRegExp.hasMatch(value)) {
                              return 'Input cannot contains prohibited special characters';
                            } else if (value.length <= 3 || value.length > 50) {
                              return 'Minimum length required';
                            } else if (value.contains('..')) {
                              return 'username does not contain is correct';
                            }

                            return null;
                          },
                          onChanged: (value) {
                            print("onchange");
                            final RegExp regex = RegExp('[a-zA-Z]');
                            if (emailAndMobileController.text == null ||
                                emailAndMobileController.text.isEmpty ||
                                !regex
                                    .hasMatch(emailAndMobileController.text)) {
                              super.setState(() {
                                isPhone = true;
                              });
                            } else {
                              super.setState(() {
                                isPhone = false;
                              });
                            }
                          },
                          maxLength: isPhone == true ? 10 : 50,
                          // focusNode: FocusNode(),
                          controller: emailAndMobileController,
                          margin: EdgeInsets.only(
                            left: 30,
                            right: 30,
                          ),
                          contentPadding: EdgeInsets.only(
                            left: 12,
                            top: 14,
                            right: 12,
                            bottom: 14,
                          ),
                          // textStyle: theme.textTheme.titleMedium!,
                          hintText: "User Id / Mobile Number",
                          hintStyle: TextStyle(
                              fontFamily: 'outfit',
                              fontSize: 15,
                              fontWeight: FontWeight.w400),
                          textInputAction: TextInputAction.next,
                          textInputType: TextInputType.emailAddress,
                          filled: true,

                          // fillColor: appTheme.gray100,
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: EdgeInsets.only(
                              left: 30,
                              top: 19,
                            ),
                            child: Text(
                              "Password",
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  fontFamily: 'outfit',
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                        ),
                        CustomTextFormField(
                          // focusNode: FocusNode(),
                          // autofocus: true,

                          inputFormatters: [
                            FilteringTextInputFormatter.deny(RegExp(r'\s')),
                          ],
                          errorMaxLines: 3,

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
                          controller: passwordoneController,
                          // textInputType: TextInputType. number,
                          margin: EdgeInsets.only(
                            left: 30,
                            top: 5,
                            right: 30,
                          ),
                          contentPadding: EdgeInsets.only(
                            left: 20,
                            top: 14,
                            bottom: 14,
                          ),
                          // textStyle: theme.textTheme.titleMedium!,
                          hintText: "Password",
                          hintStyle: TextStyle(
                              fontFamily: 'outfit',
                              fontSize: 15,
                              fontWeight: FontWeight.w400),
                          textInputType: TextInputType.emailAddress,
                          suffix: Container(
                            margin: EdgeInsets.only(
                              left: 30,
                              top: 15,
                              right: 15,
                              bottom: 15,
                            ),
                            child: GestureDetector(
                              onTap: () {
                                super.setState(() {
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
                          suffixConstraints: BoxConstraints(maxHeight: 50),
                          obscureText: Show_Password ? true : false,
                          filled: true,
                          maxLength: 30,

                          fillColor: appTheme.gray100,
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: EdgeInsets.only(
                              left: 30,
                              top: 13,
                            ),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) {
                                  return ForgetPasswordScreen();
                                }));
                              },
                              child: Text(
                                "Forgot Password?",
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.left,
                                // style: theme.textTheme.titleSmall,
                                style: TextStyle(
                                    fontFamily: 'outfit',
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500,
                                    color: ColorConstant.primary_color),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 30, right: 30, top: 10),
                          child: CustomElevatedButton(
                            onTap: () {
                              if (_formKey.currentState!.validate()) {
                                Map<String, dynamic> dataPassing = {
                                  "username": emailAndMobileController.text,
                                  "password": passwordoneController.text,
                                  "isFromAdmin": false
                                };

                                print('dataPassing-$dataPassing');

                                // if (SubmitOneTime == false) {
                                //   SubmitOneTime = true;
                                BlocProvider.of<LoginCubit>(context)
                                    .loginApidata(dataPassing, context);
                                // }
                              }
                            },
                            text: "Log In",
                            buttonStyle: ButtonThemeHelper.outlineOrangeA7000c
                                .copyWith(
                                    fixedSize: MaterialStateProperty.all<Size>(
                                        Size(double.infinity, 50))),
                            // buttonTextStyle:
                            //     TextThemeHelper.titleMediumOnPrimary,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 30, right: 30, top: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("Connect with us at",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 14,
                                    fontFamily: 'Outfit',
                                    fontWeight: FontWeight.bold,
                                  )),
                              SizedBox(
                                width: 5,
                              ),
                              GestureDetector(
                                onTap: () async {
                                  String email = Uri.encodeComponent(
                                      "Connect@inpackaging.com");
                                  launchEmail(email);
                                },
                                child: Text(
                                  "Support",
                                  style: TextStyle(
                                    color: theme.colorScheme.primary,
                                    fontSize: 14,
                                    fontFamily: 'Outfit',
                                    fontWeight: FontWeight.w500,
                                    decoration: TextDecoration.underline,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        // Padding(
                        //   padding: const EdgeInsets.only(
                        //       left: 30, right: 30, top: 10),
                        //   child: CustomOutlinedButton(
                        //       onTap: () {
                        //         if (state is GetUserLoadedState) {
                        //           Navigator.push(
                        //             context,
                        //             MaterialPageRoute(
                        //                 builder: (context) =>
                        //                     OtpVerificationScreen(
                        //                       loginModelData: loginModelData,
                        //                     )),
                        //           );
                        //         }
                        //       },
                        //       text: "Log In With OTP",
                        //       margin: EdgeInsets.only(
                        //         left: 30,
                        //         right: 30,
                        //         bottom: 51,
                        //       ),
                        //       buttonStyle: ButtonThemeHelper.outlinePrimaryTL6
                        //           .copyWith(
                        //               fixedSize:
                        //                   MaterialStateProperty.all<Size>(
                        //                       Size(double.maxFinite, 50))),
                        //       buttonTextStyle: TextStyle(
                        //           color: ColorConstant.primary_color,
                        //           fontFamily: 'outfit',
                        //           fontSize: 15,
                        //           fontWeight: FontWeight.bold)),
                        // ),
                        SizedBox(
                          height: 10,
                        )
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  getDataStroe(
      String userId, String jwt, String user_Module, String UserProfile) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(PreferencesKey.loginUserID, userId);
    prefs.setString(PreferencesKey.loginJwt, jwt);
    prefs.setString(PreferencesKey.module, user_Module);
    prefs.setString(PreferencesKey.UserProfile, UserProfile);

    // prefs.setString(PreferencesKey.loginVerify, verify);
    print('userId-$userId');
    print('jwt-$jwt');
    // print('verify-$verify');
  }

  saveUserProfile() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
        print("dsfsdgfsdfg${getUserDataModelData?.object?.userName}");
    prefs.setString(PreferencesKey.ProfileUserName,
        "${getUserDataModelData?.object?.userName}");

       print("chehck value-${getUserDataModelData?.object?.userName}"); 
    prefs.setString(
        PreferencesKey.ProfileName, "${getUserDataModelData?.object?.name}");
    prefs.setString(
        PreferencesKey.ProfileEmail, "${getUserDataModelData?.object?.email}");
    prefs.setString(PreferencesKey.ProfileModule,
        "${getUserDataModelData?.object?.module}");
    prefs.setString(PreferencesKey.ProfileMobileNo,
        "${getUserDataModelData?.object?.mobileNo}");
  }

  savePhoneData() async {
    final fcmToken = await FirebaseMessaging.instance.getToken();
    print('UUID is------> ${fcmToken}');
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(PreferencesKey.fcmToken, "${fcmToken}");

    saveDeviceInfo = false;

    var deviceTokne = prefs.getString(PreferencesKey.fcmToken);

    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();

    AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
    IosDeviceInfo iosInfo = await deviceInfo.iosInfo;

    var androidMOdel = "";
    var androidVersion = "";
    var iosModel = "";

    if (Platform.isAndroid) {
      androidMOdel = androidInfo.model;
      androidVersion = androidInfo.version.release;
    } else if (Platform.isIOS) {
      iosModel = "${iosInfo.utsname.machine}";
    }

    var details = {
      "deviceModel": iosModel == "" ? androidMOdel : iosModel,
      "deviceType": Platform.isIOS ? "ios" : "Android",
      "mobileNumber": "${loginModelData?.object?.mobileNo ?? ""}",
      "module": "${loginModelData?.object?.module ?? ""}",
      "userId": 0,
      "fcmToken": deviceTokne ?? "",
      "version":
          iosModel == "" ? androidVersion : Platform.operatingSystemVersion,
    };
// DeviceInfo

    await BlocProvider.of<DevicesInfoCubit>(context)
        .DeviceInfo(details, context);

    print(details);
  }

  void launchEmail(String emailAddress) async {
    final Uri emailLaunchUri = Uri(
      // scheme: 'Test',
      path: emailAddress,
    );
    Uri mailto = Uri.parse("mailto:$emailLaunchUri");
    // if (Platform.isAndroid && Platform.isIOS) {
      await launchUrl(mailto);
    // } else {
    //   print("Somthing went wrong!");
    // }
    /* if (await canLaunch(emailLaunchUri.toString())) {
    await launch(emailLaunchUri.toString());
  } else {
    throw 'Could not launch email';
  } */
  }
}
