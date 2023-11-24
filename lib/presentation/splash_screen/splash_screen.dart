import 'dart:async';
import 'dart:io';

import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:pds/API/Bloc/System_Config_Bloc/system_config_cubit.dart';
import 'package:pds/API/Bloc/System_Config_Bloc/system_config_state.dart';
import 'package:pds/API/Model/System_Config_model/system_config_model.dart';
import 'package:pds/core/utils/color_constant.dart';
import 'package:pds/core/utils/sharedPreferences.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pds/presentation/%20new/newbottembar.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/utils/image_constant.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen();

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  int GetTimeSplash = 0;
  bool setLOGOUTValue = false;
  var user_Module = "";
  var User_profile = "";
  var UserID = "";
  var deepLink1 = "";

  String? appApkMinVersion;
  String? appApkLatestVersion;
  String? appApkRouteVersion;
  String? ipaIosLatestVersion;
  String? ipaIosRoutVersion;
  String? ipaIosMainversion;

  String? ApkMinVersion;
  String? ApkLatestVersion;
  String? ApkRouteVersion;
  String? IosLatestVersion;
  String? IosRoutVersion;
  String? IosMainversion;

  SystemConfigModel? systemConfigModel;

  void startTimer() {
    Timer(
      Duration(seconds: 1),
      () async {
        if (UserID != "") {
          await BlocProvider.of<SystemConfigCubit>(context).UserModel(context);
        }
        await BlocProvider.of<SystemConfigCubit>(context).SystemConfig(context);
      },
    );
  }

  @override
  void initState() {
    super.initState();
    initDynamicLinks(context);
    getData();
    startTimer();
  }

  @override
  Widget build(BuildContext context) {
    /* 
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height; */

    return BlocConsumer<SystemConfigCubit, SystemConfigState>(
        listener: (context, state) async {
      if (state is SystemConfigErrorState) {
        SnackBar snackBar = SnackBar(
          content: Text(state.error),
          backgroundColor: ColorConstant.primary_color,
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }

      if (state is SystemConfigLoadingState) {
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
      if (state is fetchUserModulemodelLoadedState) {
        user_Module = state.fetchUserModule.object?.userModule ?? "";
        User_profile = state.fetchUserModule.object?.userProfilePic ?? "";
        saveUSerProfileAndUserModel();
      }
      if (state is SystemConfigLoadedState) {
        systemConfigModel = state.systemConfigModel;
        await SetUi();
      }
    }, builder: (context, state) {
      return Container(
          padding: EdgeInsets.all(8),
          color: Color(0XFFFFD9DA),
          alignment: Alignment.center,
          width: double.infinity,
          child: Image.asset(
            ImageConstant.splashImage,
            // fit: BoxFit.fill,
            height: 150,
          ));
    });
  }

  getData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    UserID = prefs.getString(PreferencesKey.loginUserID) ?? "";
  }

  saveUSerProfileAndUserModel() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(PreferencesKey.module, user_Module);
    prefs.setString(PreferencesKey.UserProfile, User_profile);
  }

  SetUi() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(PreferencesKey.appApkMinVersion, "2");
    prefs.setString(PreferencesKey.appApkLatestVersion, "1");
    prefs.setString(PreferencesKey.appApkRouteVersion, "1");

    prefs.setString(PreferencesKey.IPAIosMainversion, "1");
    prefs.setString(PreferencesKey.IPAIosLatestVersion, "1");
    prefs.setString(PreferencesKey.IPAIosRoutVersion, "2");

    // prefs.setBool(PreferencesKey.RoutURlChnage, false);

    systemConfigModel?.object?.forEach((element) async {
      if (element.name == "MaxDocUploadSizeInMB") {
        var fileSize = element.value!;
        prefs.setString(PreferencesKey.fileSize, fileSize);
      } else if (element.name == "MaxMediaUploadSizeInMB") {
        var mediaSize = int.parse(element.value!);
        prefs.setInt(PreferencesKey.mediaSize, mediaSize);
      } else if (element.name == "ResendTimerInSeconds") {
        var otpTimer = int.parse(element.value!);
        print(" otp timer  ${otpTimer}");
        prefs.setInt(PreferencesKey.otpTimer, otpTimer);
      } else if (element.name == "ApkMinVersion") {
        var ApkMinVersion = element.value ?? "";
        print("ApkMinVersion  ${ApkMinVersion}");
        prefs.setString(PreferencesKey.ApkMinVersion, ApkMinVersion);
      } else if (element.name == "ApkLatestVersion") {
        var ApkLatestVersion = element.value ?? "";
        print(" ApkLatestVersion  ${ApkLatestVersion}");
        prefs.setString(PreferencesKey.ApkLatestVersion, ApkLatestVersion);
      } else if (element.name == "ApkRouteVersion") {
        var ApkRouteVersion = element.value ?? "";
        print(" ApkRouteVersion  ${ApkRouteVersion}");
        prefs.setString(PreferencesKey.ApkRouteVersion, ApkRouteVersion);
      } else if (element.name == "MaxPostUploadSizeInMB") {
        print(" ApkRouteVersion  ${ApkRouteVersion}");
        prefs.setString(
            PreferencesKey.MaxPostUploadSizeInMB, element.value ?? '');
      }

      /// -----

      else if (element.name == "IosLatestVersion") {
        var IosLatestVersion = element.value ?? "";
        print(" IosLatestVersion  ${IosLatestVersion}");
        prefs.setString(PreferencesKey.IosLatestVersion, IosLatestVersion);
      } else if (element.name == "IosRoutVersion") {
        var IosRoutVersion = element.value ?? "";
        print("IosRoutVersion  ${IosRoutVersion}");
        prefs.setString(PreferencesKey.IosRoutVersion, IosRoutVersion);
      } else if (element.name == "IosMainversion") {
        var IosMainversion = element.value ?? "";
        print(" IosMainversion  ${IosMainversion}");
        prefs.setString(PreferencesKey.IosMainversion, IosMainversion);
      }

      /// ---------

      else if (element.name == "SocketLink") {
        var SocketLink = element.value ?? "";
        print(" SocketLink  ${SocketLink}");
        prefs.setString(PreferencesKey.SocketLink, SocketLink);
      } else if (element.name == "ApkRouteURL") {
        var RoutURL = element.value ?? "";
        print(" RoutURL  ${RoutURL}");
        prefs.setString(PreferencesKey.RoutURL, RoutURL);
      } else if (element.name == "SupportEmailId") {
        var SupportEmailId = element.value ?? "";
        print(" SupportEmailId  ${SupportEmailId}");
        prefs.setString(PreferencesKey.SupportEmailId, SupportEmailId);
      } else if (element.name == "SupportPhoneNumber") {
        var SupportPhoneNumber = element.value ?? "";
        print(" SupportPhoneNumber  ${SupportPhoneNumber}");
        prefs.setString(PreferencesKey.SupportPhoneNumber, SupportPhoneNumber);
      } else if (element.name == "MaxPublicRoomSave") {
        var MaxPublicRoomSave = element.value ?? "";
        print("SupportPhoneNumber  ${MaxPublicRoomSave}");
        prefs.setString(PreferencesKey.MaxPublicRoomSave, MaxPublicRoomSave);
      }
    });
    VersionControll();
  }

  VersionControll() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    ApkMinVersion = prefs.getString(PreferencesKey.ApkMinVersion);
    ApkLatestVersion = prefs.getString(PreferencesKey.ApkLatestVersion);
    ApkRouteVersion = prefs.getString(PreferencesKey.ApkRouteVersion);

    IosMainversion = prefs.getString(PreferencesKey.IosMainversion);
    IosLatestVersion = prefs.getString(PreferencesKey.IosLatestVersion);
    IosRoutVersion = prefs.getString(PreferencesKey.IosRoutVersion);

    appApkMinVersion = prefs.getString(PreferencesKey.appApkMinVersion);
    appApkLatestVersion = prefs.getString(PreferencesKey.appApkLatestVersion);
    appApkRouteVersion = prefs.getString(PreferencesKey.appApkRouteVersion);

    ipaIosMainversion = prefs.getString(PreferencesKey.IPAIosMainversion);
    ipaIosLatestVersion = prefs.getString(PreferencesKey.IPAIosLatestVersion);
    ipaIosRoutVersion = prefs.getString(PreferencesKey.IPAIosRoutVersion);

    // ShowSoftAlert = prefs.getBool(PreferencesKey.ShowSoftAlert);
    VersionAlert();
  }

  initDynamicLinks(BuildContext context) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    final PendingDynamicLinkData? initialLink =
        await FirebaseDynamicLinks.instance.getInitialLink();
    if (initialLink != null) {
      final Uri deepLink = initialLink.link;
      deepLink1 = deepLink.toString().split("=")[1];
      // deepLink2 = deepLink1.toString().split("&")[0];

      print('Deeplinks uri:${deepLink.path}');
      setState(() {
        prefs.setString(PreferencesKey.AutoSetRoomID, deepLink1);
      });
    }
  }

  VersionAlert() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    if (Platform.isAndroid) {
      // if (int.parse(ApkMinVersion ?? "") >
      //     (int.parse(appApkMinVersion ?? ""))) {
      //   print("Moti1");
      //   AlertHardUpdate();
      // }

      // if (int.parse(ApkLatestVersion ?? "") >
      //     (int.parse(appApkLatestVersion ?? ""))) {
      //   print("Moti2");
      //   // if (ShowSoftAlert == false || ShowSoftAlert == null) {
      //   AlertSoftUpdate();
      //   // }
      // }

      if (int.parse(ApkRouteVersion ?? "") ==
          (int.parse(appApkRouteVersion ?? ""))) {
        print("same");
        if (setLOGOUTValue == false) {
          setLOGOUT(context);
        }
      } else {
        Future.delayed(Duration(seconds: 0), () {
          Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
            builder: (context) {
              return NewBottomBar(buttomIndex: 0);
            },
          ), (route) => false);
        });
      }
    }

    /// -----------------------------------------
    if (Platform.isIOS) {
      // if (int.parse(IosMainversion ?? "") >
      //     (int.parse(ipaIosMainversion ?? ""))) {
      //   print("Moti1");
      //   AlertHardUpdate();
      // }

      // if (int.parse(IosLatestVersion ?? "") >
      //     (int.parse(ipaIosLatestVersion ?? ""))) {
      //   print("Moti2");
      //   AlertSoftUpdate();
      // }

      if (int.parse(IosRoutVersion ?? "") ==
          (int.parse(ipaIosRoutVersion ?? ""))) {
        print("same");
        if (setLOGOUTValue == false) {
          setLOGOUT(context);
        }
      } else {
        Future.delayed(Duration(seconds: 0), () {
          Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
            builder: (context) {
              return NewBottomBar(buttomIndex: 0);
            },
          ), (route) => false);
        });
      }
    }
  }

  setLOGOUT(BuildContext context) async {
    setLOGOUTValue = true;
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(PreferencesKey.OnetimeRoutChange, true);
    prefs.remove(PreferencesKey.loginUserID);
    prefs.remove(PreferencesKey.loginJwt);
    prefs.remove(PreferencesKey.module);
    prefs.remove(PreferencesKey.UserProfile);

    prefs.setBool(PreferencesKey.RoutURlChnage, true);
    prefs.setBool(PreferencesKey.UpdateURLinSplash, true);

    Future.delayed(Duration(seconds: 0), () {
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
        builder: (context) {
          return NewBottomBar(buttomIndex: 0);
        },
      ), (route) => false);
    });

    // if (UserID != "") {
    //   BlocProvider.of<SystemConfigCubit>(context).UserModel(context);
    // }
  }

  AlertHardUpdate() {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return WillPopScope(
            onWillPop: () async => false,
            child: Dialog(
              elevation: 0,
              backgroundColor: Colors.transparent,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              child: Container(
                height: height / 2,
                width: width,
                // color: Colors.white,
                child: Column(
                  children: [
                    Image.asset(
                      ImageConstant.alertimage,
                      height: height / 4.8,
                      width: width,
                      fit: BoxFit.fill,
                    ),
                    Container(
                      height: height / 7,
                      width: width,
                      color: Colors.white,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "New Version Alert",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                              color: ColorConstant.primary_color,
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            "New application version is available",
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 15,
                                color: Colors.black),
                          ),
                          Text(
                            "please download latest version",
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 15,
                                color: Colors.black),
                          ),
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        height: 45,
                        width: width,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(10),
                                bottomRight: Radius.circular(10)),
                            color: ColorConstant.primary_color),
                        child: Center(
                            child: Text(
                          "Update",
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 17,
                            color: Colors.white,
                          ),
                        )),
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }

  AlertSoftUpdate() {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return WillPopScope(
            onWillPop: () async => false,
            child: Dialog(
              elevation: 0,
              backgroundColor: Colors.transparent,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              child: Container(
                height: height / 2,
                width: width,
                // color: Colors.white,
                child: Column(
                  children: [
                    Image.asset(
                      ImageConstant.alertimage,
                      height: height / 4.8,
                      width: width,
                      fit: BoxFit.fill,
                    ),
                    Container(
                      height: height / 7,
                      width: width,
                      color: Colors.white,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "New Version Alert",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                              color: ColorConstant.primary_color,
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            "New application version is available",
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 15,
                                color: Colors.black),
                          ),
                          Text(
                            "please download latest version",
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 15,
                                color: Colors.black),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            saveAlertStatus();
                            Navigator.pop(context);
                          },
                          child: Container(
                            height: 50,
                            width: width / 2.5,
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: ColorConstant.primary_color),
                                color: Colors.white),
                            child: Center(
                                child: Text(
                              "Later",
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 17,
                                color: ColorConstant.primary_color,
                              ),
                            )),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Container(
                            height: 50,
                            width: width / 2.5,
                            decoration: BoxDecoration(
                                color: ColorConstant.primary_color),
                            child: Center(
                                child: Text(
                              "Update",
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 17,
                                color: Colors.white,
                              ),
                            )),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }

  saveAlertStatus() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(PreferencesKey.ShowSoftAlert, true);
  }
}
