import 'dart:async';
import 'dart:io';

import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:pds/API/Bloc/Fatch_All_PRoom_Bloc/Fatch_PRoom_cubit.dart';
import 'package:pds/API/Bloc/GuestAllPost_Bloc/GuestAllPost_cubit.dart';
import 'package:pds/API/Bloc/Invitation_Bloc/Invitation_cubit.dart';
import 'package:pds/API/Bloc/PublicRoom_Bloc/CreatPublicRoom_cubit.dart';
import 'package:pds/API/Bloc/System_Config_Bloc/system_config_cubit.dart';
import 'package:pds/API/Bloc/System_Config_Bloc/system_config_state.dart';
import 'package:pds/API/Bloc/auth/register_Block.dart';
import 'package:pds/API/Bloc/senMSG_Bloc/senMSG_cubit.dart';
import 'package:pds/API/Model/System_Config_model/system_config_model.dart';
import 'package:pds/core/utils/color_constant.dart';
import 'package:pds/core/utils/sharedPreferences.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pds/presentation/%20new/newbottembar.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../API/Bloc/GetAllPrivateRoom_Bloc/GetAllPrivateRoom_cubit.dart';
import '../../core/utils/image_constant.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen();

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  int GetTimeSplash = 0;
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
          BlocProvider.of<SystemConfigCubit>(context).UserModel(context);
        }

        BlocProvider.of<SystemConfigCubit>(context).SystemConfig(context);
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
      }
      if (state is SystemConfigLoadedState) {
        systemConfigModel = state.systemConfigModel;
        await SetUi();

        Future.delayed(Duration(seconds: 0), () {
          Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
            builder: (context) {
              return MultiBlocProvider(
                providers: [
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
                ],
                child: NewBottomBar(buttomIndex: 0),
              );
            },
          ), (route) => false);
        });
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

  SetUi() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(PreferencesKey.module, user_Module);
    prefs.setString(PreferencesKey.UserProfile, User_profile);

    prefs.setString(PreferencesKey.appApkRouteVersion, "1");
    prefs.setString(PreferencesKey.appApkLatestVersion, "1");
    prefs.setString(PreferencesKey.appApkMinVersion, "1");

    prefs.setString(PreferencesKey.IPAIosLatestVersion, "1");
    prefs.setString(PreferencesKey.IPAIosRoutVersion, "1");
    prefs.setString(PreferencesKey.IPAIosMainversion, "1");

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
      }else if (element.name == "MaxPostUploadSizeInMB") {
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
      } else if (element.name == "RoutURL") {
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

    IosLatestVersion = prefs.getString(PreferencesKey.IosLatestVersion);
    IosRoutVersion = prefs.getString(PreferencesKey.IosRoutVersion);
    IosMainversion = prefs.getString(PreferencesKey.IosMainversion);

    appApkRouteVersion = prefs.getString(PreferencesKey.appApkRouteVersion);
    appApkLatestVersion = prefs.getString(PreferencesKey.appApkLatestVersion);
    appApkMinVersion = prefs.getString(PreferencesKey.appApkMinVersion);

    ipaIosLatestVersion = prefs.getString(PreferencesKey.IPAIosLatestVersion);
    ipaIosRoutVersion = prefs.getString(PreferencesKey.IPAIosRoutVersion);
    ipaIosMainversion = prefs.getString(PreferencesKey.IPAIosMainversion);

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

  VersionAlert() {
    if (Platform.isAndroid) {
      // if (int.parse(ApkMinVersion ?? "") >
      //     (int.parse(appApkMinVersion ?? ""))) {
      //   print("Moti1");
      //   // AlertHardUpdate();
      // }

      // if (int.parse(ApkLatestVersion ?? "") >
      //     (int.parse(appApkLatestVersion ?? ""))) {
      //   print("Moti2");
      //   // if (ShowSoftAlert == false || ShowSoftAlert == null) {
      //   //   // AlertSoftUpdate();
      //   // }
      // }

      if (int.parse(ApkRouteVersion ?? "") ==
          (int.parse(appApkRouteVersion ?? ""))) {
        print("same");
        // setLOGOUT(context);
      }
    }

    /// -----------------------------------------
    if (Platform.isIOS) {
      // if (int.parse(IosMainversion ?? "") >
      //     (int.parse(ipaIosMainversion ?? ""))) {
      //   print("Moti1");
      //   // AlertHardUpdate();
      // }

      // if (int.parse(IosLatestVersion ?? "") >
      //     (int.parse(ipaIosLatestVersion ?? ""))) {
      //   print("Moti2");
      //   // AlertSoftUpdate();
      // }

      if (int.parse(IosRoutVersion ?? "") ==
          (int.parse(ipaIosRoutVersion ?? ""))) {
        print("same");
        // setLOGOUT(context);
      }
    }
  }

  setLOGOUT(BuildContext context) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    // prefs.clear();

    prefs.remove(PreferencesKey.loginUserID);
    prefs.remove(PreferencesKey.loginJwt);
    prefs.remove(PreferencesKey.module);
    prefs.remove(PreferencesKey.UserProfile);

    prefs.setBool(PreferencesKey.RoutURl, true);
    prefs.setBool(PreferencesKey.UpdateURLinSplash, true);

    if (UserID != "") {
      BlocProvider.of<SystemConfigCubit>(context).UserModel(context);
    }

    BlocProvider.of<SystemConfigCubit>(context).SystemConfig(context);

    // final SharedPreferences prefs = await SharedPreferences.getInstance();

    // setLogOut(context);
  }

  // setLogOut(BuildContext context) async {
  //   final SharedPreferences prefs = await SharedPreferences.getInstance();
  //   prefs.clear();
  //   await Navigator.pushAndRemoveUntil(
  //       context,
  //       MaterialPageRoute(
  //           builder: (context) => MultiBlocProvider(
  //                 providers: [
  //                   BlocProvider<SystemConfigCubit>(
  //                     create: (context) => SystemConfigCubit(),
  //                   ),
  //                 ],
  //                 child: SplashScreen(),
  //               )),
  //       (route) => false);
  // }
}
