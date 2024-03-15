import 'package:flutter/cupertino.dart';
import 'package:pds/core/utils/sharedPreferences.dart';
import 'package:pds/videocallCommenClass.dart/videocommeninviation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';
import 'package:zego_uikit_signaling_plugin/zego_uikit_signaling_plugin.dart';

void onUserLogin(
  String userUid,
  String userName,
) async {
  print("all type Data checl -$userUid,$userName");
  ZegoUIKitPrebuiltCallInvitationService().init(
    appID: 1842777423,
    appSign: 'e468becf6ba255deb47581539b4cc3142dd115142203073f3cff895e50d966bc',
    userID: userUid,
    userName: userName,
    plugins: [ZegoUIKitSignalingPlugin()],
    notificationConfig: ZegoCallInvitationNotificationConfig(
        androidNotificationConfig: ZegoCallAndroidNotificationConfig(
      showFullScreen: true,
      channelID: "ZegoUIKit",
      channelName: "Call Notifications",
      sound: "call",
      icon: "call",
    )),
    requireConfig: (ZegoCallInvitationData data) {
      final config = /* (data.invitees.length > 1)
          ? ZegoCallType.videoCall == data.type
              ? ZegoUIKitPrebuiltCallConfig.groupVideoCall()
              : ZegoUIKitPrebuiltCallConfig.groupVoiceCall()
          : ZegoCallType.videoCall == data.type
              ? ZegoUIKitPrebuiltCallConfig.oneOnOneVideoCall()
              :  */
          ZegoCallType.videoCall == data.type
              ? ZegoUIKitPrebuiltCallConfig.oneOnOneVideoCall()
              : ZegoUIKitPrebuiltCallConfig.oneOnOneVoiceCall();

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

sendCallButton({
  required bool isVideoCall,
  required List<ZegoUIKitUser> invitees,
  void Function(String code, String message, List<String>)? onCallFinished,
  required String url,
}) {
  return ZegoSendCallInvitationButton(

    iconVisible: true,
    isVideoCall: isVideoCall,
    invitees: invitees,
    resourceID: 'zego_data',
    iconSize: const Size(45, 40),
    buttonSize: const Size(40, 40),
    onPressed: onCallFinished,
    
  );
}

void onUserLogout() async {
  ZegoUIKitPrebuiltCallInvitationService().uninit();
}
