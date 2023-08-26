import 'dart:async';

import 'package:pds/API/Bloc/Fatch_All_PRoom_Bloc/Fatch_PRoom_cubit.dart';
import 'package:pds/API/Bloc/Invitation_Bloc/Invitation_cubit.dart';
import 'package:pds/API/Bloc/PublicRoom_Bloc/CreatPublicRoom_cubit.dart';
import 'package:pds/API/Bloc/System_Config_Bloc/system_config_cubit.dart';
import 'package:pds/API/Bloc/System_Config_Bloc/system_config_state.dart';
import 'package:pds/API/Bloc/auth/register_Block.dart';
import 'package:pds/API/Bloc/senMSG_Bloc/senMSG_cubit.dart';
import 'package:pds/API/Model/System_Config_model/system_config_model.dart';
import 'package:pds/core/utils/color_constant.dart';
import 'package:pds/core/utils/sharedPreferences.dart';
import 'package:pds/custom_bottom_bar/custom_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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

  SystemConfigModel? systemConfigModel;

  void startTimer() {
    Timer(
      Duration(seconds: 1),
      () async {
        await BlocProvider.of<SystemConfigCubit>(context).SystemConfig(context);
      },
    );
  }

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  @override
  Widget build(BuildContext context) {
    /* 
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height; */

    return BlocConsumer<SystemConfigCubit, SystemConfigState>(
        listener: (context, state) {
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
      if (state is SystemConfigLoadedState) {
        systemConfigModel = state.systemConfigModel;
        print("@@@@@@@@@@@@@@@@@@${systemConfigModel?.object}");
        SetUi();

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
              ],
              child: BottombarPage(buttomIndex: 0),
            );
          },
        ), (route) => false);
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

  SetUi() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

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
        await prefs.setInt(PreferencesKey.otpTimer, otpTimer);
      }
    });
  }
}
