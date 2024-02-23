// import 'dart:developer';

// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/material.dart';
// import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';
// import 'package:zego_uikit_signaling_plugin/zego_uikit_signaling_plugin.dart';

// void onUserLogin(String userid, String name) {
//   print("zego init : $name $userid");
//   try {
//     ZegoUIKitPrebuiltCallInvitationService().init(
//       appID: 1430307354,
//       appSign:
//           '2ffeafa3c1c4816b11db133042c612ea80a007b534751d0c9596953e5286a994',
//       userID: userid,
//       userName: name,
//       plugins: [ZegoUIKitSignalingPlugin()],
//       requireConfig: (ZegoCallInvitationData data) {
//         final config = (data.invitees.length > 1)
//             ? ZegoCallType.videoCall == data.type
//                 ? ZegoUIKitPrebuiltCallConfig.groupVideoCall()
//                 : ZegoUIKitPrebuiltCallConfig.groupVoiceCall()
//             : ZegoCallType.videoCall == data.type
//                 ? ZegoUIKitPrebuiltCallConfig.oneOnOneVideoCall()
//                 : ZegoUIKitPrebuiltCallConfig.oneOnOneVoiceCall();

//         /// custom avatar
//         config.avatarBuilder = customAvatarBuilder;

//         /// support minimizing, show minimizing button
//         config.topMenuBar.isVisible = true;
//         config.topMenuBar.buttons
//             .insert(0, ZegoCallMenuBarButtonName.minimizingButton);
//         print("zego config -${config}");
//         return config;
//       },
//     );
//   } catch (e) {
//     print("zego init error $e");
//   }
// }

// Widget customAvatarBuilder(
//   BuildContext context,
//   Size size,
//   ZegoUIKitUser? user,
//   Map<String, dynamic> extraInfo,
// ) {
//   return CachedNetworkImage(
//     imageUrl: 'https://robohash.org/${user?.id}.png',
//     imageBuilder: (context, imageProvider) => Container(
//       decoration: BoxDecoration(
//         shape: BoxShape.circle,
//         image: DecorationImage(
//           image: imageProvider,
//           fit: BoxFit.cover,
//         ),
//       ),
//     ),
//     progressIndicatorBuilder: (context, url, downloadProgress) =>
//         CircularProgressIndicator(value: downloadProgress.progress),
//     errorWidget: (context, url, error) {
//       ZegoLoggerService.logInfo(
//         '$user avatar url is invalid',
//         tag: 'live audio',
//         subTag: 'live page',
//       );
//       return ZegoAvatar(user: user, avatarSize: size);
//     },
//   );
// }

// Widget sendCallButton({
//   required bool isVideoCall,
//   required String inviteeUsersIDTextCtrl,
//   required String inviterusername,
//   void Function(String code, String message, List<String>)? onCallFinished,
// }) {
//   final invitees = <ZegoUIKitUser>[];
//   print('sdfsdgsdfgsdgf-${inviteeUsersIDTextCtrl}-${inviterusername}');
//   invitees.add(ZegoUIKitUser(
//     id: inviteeUsersIDTextCtrl,
//     name: 'user_$inviterusername',
//   ));
//   log("check invation data-${invitees}");
//   return ZegoSendCallInvitationButton(
//     isVideoCall: isVideoCall,
//     invitees: invitees,
//     resourceID: 'zego_data',
//     iconSize: const Size(40, 40),
//     buttonSize: const Size(50, 50),
//     onPressed: onCallFinished,
//   );
// }
