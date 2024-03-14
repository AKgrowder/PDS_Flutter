import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:pds/presentation/%20new/editproilescreen.dart';
import 'package:pds/videocallCommenClass.dart/videocommeninviation.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';
import 'package:zego_uikit_signaling_plugin/zego_uikit_signaling_plugin.dart';

void onUserLogin(String userUid, String userName) {
  print("all type Data checl -$userUid,$userName");
  ZegoUIKitPrebuiltCallInvitationService().init(
    appID: 1842777423,
    appSign: 'e468becf6ba255deb47581539b4cc3142dd115142203073f3cff895e50d966bc',
    userID: userUid,
    userName: userName,
    plugins: [ZegoUIKitSignalingPlugin()],
    requireConfig: (ZegoCallInvitationData data) {
      final config = /* (data.invitees.length > 1)
          ? ZegoCallType.videoCall == data.type
              ? ZegoUIKitPrebuiltCallConfig.groupVideoCall()
              : ZegoUIKitPrebuiltCallConfig.groupVoiceCall()
          : ZegoCallType.videoCall == data.type
              ? ZegoUIKitPrebuiltCallConfig.oneOnOneVideoCall()
              :  */
          ZegoUIKitPrebuiltCallConfig.oneOnOneVoiceCall();

      /// custom avatar
      config.avatarBuilder = customAvatarBuilder;

      /// support minimizing, show minimizing button
      config.topMenuBar.isVisible = true;
      config.topMenuBar.buttons
          .insert(0, ZegoCallMenuBarButtonName.minimizingButton);

      return config;
    },
  );
}

Widget sendCallButton({
  required bool isVideoCall,
  required List<ZegoUIKitUser> invitees,
}) {
  return ZegoSendCallInvitationButton(
    isVideoCall: isVideoCall,
    invitees: invitees,
    resourceID: 'zego_data',
    iconSize: const Size(40, 40),
    buttonSize: const Size(50, 50),
    onPressed: (code, message, p2) {},
  );
}
