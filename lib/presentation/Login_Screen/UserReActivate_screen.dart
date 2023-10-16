import 'dart:io';

import 'package:another_flushbar/flushbar.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:pds/API/Bloc/Fatch_All_PRoom_Bloc/Fatch_PRoom_cubit.dart';
import 'package:pds/API/Bloc/GetAllPrivateRoom_Bloc/GetAllPrivateRoom_cubit.dart';
import 'package:pds/API/Bloc/GuestAllPost_Bloc/GuestAllPost_cubit.dart';
import 'package:pds/API/Bloc/Invitation_Bloc/Invitation_cubit.dart';
import 'package:pds/API/Bloc/PublicRoom_Bloc/CreatPublicRoom_cubit.dart';
import 'package:pds/API/Bloc/UserReActivate_Bloc/UserReActivate_state.dart';
import 'package:pds/API/Bloc/auth/register_Block.dart';
import 'package:pds/API/Bloc/senMSG_Bloc/senMSG_cubit.dart';
import 'package:pds/core/utils/color_constant.dart';
import 'package:pds/core/utils/image_constant.dart'; 
import 'package:pds/presentation/%20new/newbottembar.dart';

import 'package:shared_preferences/shared_preferences.dart';

import '../../API/Bloc/UserReActivate_Bloc/UserReActivate_cubit.dart';
import '../../API/Model/UserReActivateModel/UserReActivate_model.dart';
import '../../core/utils/sharedPreferences.dart';

class UserReActivateDailog extends StatefulWidget {
  String? userName;
  String? password;

  UserReActivateDailog({
    Key? key,
    this.userName,
    this.password,
  }) : super(key: key);
  @override
  State<StatefulWidget> createState() => UserReActivateDailogState();
}

class UserReActivateDailogState extends State<UserReActivateDailog>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> scaleAnimation;

  // TextEditingController reasonController = TextEditingController();
  // String? User_ID;

  bool saveDeviceInfo = true;
  UserReActivateModel? loginModelData;

  @override
  void initState() {
    super.initState();

    controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 450));
    scaleAnimation =
        CurvedAnimation(parent: controller, curve: Curves.elasticInOut);

    controller.addListener(() {
      setState(() {});
    });

    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    // double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Center(
      child: Material(
        color: Color.fromARGB(0, 255, 255, 255),
        child: ScaleTransition(
          scale: scaleAnimation,
          child: Container(
            height: 250,
            width: MediaQuery.of(context).size.width / 1.17,
            decoration: ShapeDecoration(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
            ),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  BlocConsumer<UserReActivateCubit, UserReActivateState>(
                    listener: (context, state) async {
                      if (state is UserReActivateErrorState) {
                        if (state.error != "error in fetch room") {
                          SnackBar snackBar = SnackBar(
                            content: Text(state.error),
                            backgroundColor: ColorConstant.primary_color,
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        }
                      }
                      if (state is UserReActivateLoadedState) {
                        loginModelData = await state.LoginOutModel;

                        getDataStroe(
                            state.LoginOutModel.object?.uuid.toString() ?? "",
                            state.LoginOutModel.object?.jwt.toString() ?? "",
                            loginModelData?.object?.module.toString() ?? "",
                            ""

                            // state.loginModel.object!.verified.toString(),
                            );
                        if (saveDeviceInfo == true) {
                          savePhoneData();
                        }

                        Navigator.pushAndRemoveUntil(context,
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
                            /// ---------------------------------------------------------------------------
                  BlocProvider<GetGuestAllPostCubit>(
                    create: (context) => GetGuestAllPostCubit(),
                  ),
                          ], child: NewBottomBar(buttomIndex: 0));
                        }), (route) => false);
                      }
                    },
                    builder: (context, state) {
                      return Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: Colors.white,
                          // color: Theme.of(context).brightness == Brightness.light
                          //     ? Color(0XFFEFEFEF)
                          //     : Color(0XFF212121),
                        ),
                        child: Column(
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: Container(
                                margin: EdgeInsets.only(right: 4),
                                height: 50,
                                color: Colors.transparent,
                                child: Align(
                                  alignment: Alignment.centerRight,
                                  child: Image.asset(
                                    ImageConstant.closeimage,
                                    height: 40,
                                    width: 40,
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 10),
                              child: Text(
                                  "Are you Sure you want to \n Reactivate your Account?",
                                  textScaleFactor: 1.0,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontFamily: 'outfit',
                                    fontSize: 22,
                                    fontWeight: FontWeight.w600,
                                    color: ColorConstant
                                        .primary_color, /* textCenter: true, */
                                  )),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 35, left: 30, right: 30),
                              child: Row(
                                children: [
                                  Flexible(
                                    flex: 2,
                                    fit: FlexFit.tight,
                                    child: GestureDetector(
                                      onTap: () async {
                                        Map<String, dynamic> dataPassing = {
                                          "username": widget.userName,
                                          "password": widget.password,
                                          "isFromAdmin": false
                                        };
                                        BlocProvider.of<UserReActivateCubit>(
                                                context)
                                            .UserReActivateApi(
                                                dataPassing, context);
                                      },
                                      child: Container(
                                        width: 163,
                                        height: 48,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: ColorConstant.primary_color,
                                        ),
                                        child: Center(
                                          child: Text("Yes",
                                              textScaleFactor: 1.0,
                                              style: TextStyle(
                                                  fontFamily: 'outfit',
                                                  fontSize: 16,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w600)),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 20,
                                  ), //SizedBox
                                  Flexible(
                                      flex: 2,
                                      fit: FlexFit.tight,
                                      child: GestureDetector(
                                        onTap: () {
                                          Navigator.pop(context);
                                        },
                                        child: Container(
                                            width: 163,
                                            height: 48,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              // color: ColorConstant.whiteA700,
                                              color: Theme.of(context)
                                                          .brightness ==
                                                      Brightness.light
                                                  ? Colors.white
                                                  : Colors.black,
                                              border: Border.all(
                                                // color: ColorConstant.orangeA700,
                                                color: Theme.of(context)
                                                            .brightness ==
                                                        Brightness.light
                                                    ? ColorConstant
                                                        .primary_color
                                                    : ColorConstant
                                                        .primary_color,
                                                width: 1.5,
                                                style: BorderStyle.solid,
                                                strokeAlign: BorderSide
                                                    .strokeAlignInside,
                                              ),
                                            ),
                                            child: Center(
                                              child: Text(
                                                "No",
                                                textScaleFactor: 1.0,
                                                style: TextStyle(
                                                    fontFamily: 'outfit',
                                                    fontSize: 16,
                                                    // color: ColorConstant.orangeA700,
                                                    color: Theme.of(context)
                                                                .brightness ==
                                                            Brightness.light
                                                        ? Colors.black
                                                        : ColorConstant
                                                            .primary_color,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                            )),
                                      ))
                                ],
                                mainAxisAlignment: MainAxisAlignment.center,
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                          ],
                        ),
                      );
                    },
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void show_Icon_Flushbar(BuildContext context, {String? msg}) {
    Flushbar(
        backgroundColor: ColorConstant.primary_color,
        animationDuration: Duration(milliseconds: 500),
        duration: Duration(seconds: 3),
        message: msg)
      ..show(context);
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

    await BlocProvider.of<UserReActivateCubit>(context)
        .DeviceInfo(details, context);

    print(details);
  }
}
