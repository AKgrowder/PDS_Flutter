// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_downloader/flutter_downloader.dart';
// import 'package:flutter_mentions/flutter_mentions.dart';
// import 'package:pds/API/Bloc/BlogComment_BLoc/BlogComment_cubit.dart';
// import 'package:pds/API/Bloc/CreateRoom_Bloc/CreateRoom_cubit.dart';
// import 'package:pds/API/Bloc/CreateStory_Bloc/CreateStory_Cubit.dart';
// import 'package:pds/API/Bloc/Edit_room_bloc/edit_room_cubit.dart';
// import 'package:pds/API/Bloc/Fatch_All_PRoom_Bloc/Fatch_PRoom_cubit.dart';
// import 'package:pds/API/Bloc/Fatch_all_members/fatch_all_members_cubit.dart';
// import 'package:pds/API/Bloc/FetchExprtise_Bloc/fetchExprtise_cubit.dart';
// import 'package:pds/API/Bloc/Fetchroomdetails_Bloc/Fetchroomdetails_cubit.dart';
// import 'package:pds/API/Bloc/Forget_password_Bloc/forget_password_cubit.dart';
// import 'package:pds/API/Bloc/GetAllPrivateRoom_Bloc/GetAllPrivateRoom_cubit.dart';
// import 'package:pds/API/Bloc/GuestAllPost_Bloc/GetPostAllLike_Bloc/GetPostAllLike_cubit.dart';
// import 'package:pds/API/Bloc/GuestAllPost_Bloc/GuestAllPost_cubit.dart';
// import 'package:pds/API/Bloc/HashTag_Bloc/HashTag_cubit.dart';
// import 'package:pds/API/Bloc/Invitation_Bloc/Invitation_cubit.dart';
// import 'package:pds/API/Bloc/NewProfileScreen_Bloc/NewProfileScreen_cubit.dart';
// import 'package:pds/API/Bloc/OpenSaveImagepost_Bloc/OpenSaveImagepost_cubit.dart';
// import 'package:pds/API/Bloc/PersonalChatList_Bloc/PersonalChatList_cubit.dart';
// import 'package:pds/API/Bloc/PublicRoom_Bloc/CreatPublicRoom_cubit.dart';
// import 'package:pds/API/Bloc/RePost_Bloc/RePost_cubit.dart';
// import 'package:pds/API/Bloc/RoomExists_bloc/RoomExists_cubit.dart';
// import 'package:pds/API/Bloc/SelectChat_bloc/SelectChat_cubit.dart';
// import 'package:pds/API/Bloc/SelectRoom_Bloc/SelectRoom_cubit.dart';
// import 'package:pds/API/Bloc/System_Config_Bloc/system_config_cubit.dart';
// import 'package:pds/API/Bloc/ViewDetails_Bloc/ViewDetails_cubit.dart';
// import 'package:pds/API/Bloc/accounttype_bloc/account_cubit.dart';
// import 'package:pds/API/Bloc/add_comment_bloc/add_comment_cubit.dart';
// import 'package:pds/API/Bloc/auth/login_Block.dart';
// import 'package:pds/API/Bloc/auth/otp_block.dart';
// import 'package:pds/API/Bloc/auth/register_Block.dart';
// import 'package:pds/API/Bloc/creatForum_Bloc/creat_Forum_cubit.dart';
// import 'package:pds/API/Bloc/device_info_Bloc/device_info_bloc.dart';
// import 'package:pds/API/Bloc/dmInbox_bloc/dminbox_blcok.dart';
// import 'package:pds/API/Bloc/followerBlock/followBlock.dart';
// import 'package:pds/API/Bloc/my_account_Bloc/my_account_cubit.dart';
// import 'package:pds/API/Bloc/senMSG_Bloc/senMSG_cubit.dart';
// import 'package:pds/API/Bloc/sherinvite_Block/sherinvite_cubit.dart';
// import 'package:pds/API/Bloc/viewStory_Bloc/viewStory_cubit.dart';
// import 'package:pds/core/utils/sharedPreferences.dart';
// import 'package:pds/theme/theme_helper.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'API/Bloc/postData_Bloc/postData_Bloc.dart';
// import 'presentation/splash_screen/splash_screen.dart';
// import 'package:flutter_langdetect/flutter_langdetect.dart' as langdetect;
// import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';
// import 'package:zego_uikit_signaling_plugin/zego_uikit_signaling_plugin.dart';

// Future<void> _messageHandler(RemoteMessage message) async {
//   await Firebase.initializeApp();
//   print('background message ${message.notification!.body}');
//   print("value Gey-${message.data}");
// }

// final navigatorKey = GlobalKey<NavigatorState>();


// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await FlutterDownloader.initialize();
//   await WidgetsFlutterBinding.ensureInitialized();

//    ZegoUIKitPrebuiltCallInvitationService().setNavigatorKey(navigatorKey);


//   await Firebase.initializeApp();
//   await langdetect.initLangDetect();
//   SystemChrome.setPreferredOrientations([
//     DeviceOrientation.portraitUp,
//   ]);

//   ///Please update theme as per your need if required.
//   ThemeHelper().changeTheme('primary');

//   FirebaseMessaging.onBackgroundMessage(_messageHandler);
//   FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) async {
//     final SharedPreferences prefs = await SharedPreferences.getInstance();
//     print("/* onMessageOpenedApp: */ ${message.notification?.body}");
//     print("/* onMessageOpenedApp: */ ${message.notification?.title}");
//     print("/* onMessageOpenedApp: */ ${message.data}");
//     print("/* onMessageOpenedApp: */ ${message.data['uid']}");
//     print("/* onMessageOpenedApp: */ ${message.data['Subject']}");
//     prefs.setString(
//         PreferencesKey.PushNotificationUID, "${message.data['uid']}");
//     prefs.setString(
//         PreferencesKey.PushNotificationSubject, "${message.data['Subject']}");
//   });

//   FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

//   await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
//     alert: true,
//     badge: true,
//     sound: true,
//   );

//   _firebaseMessaging.requestPermission(
//     sound: true,
//     badge: true,
//     alert: true,
//     provisional: false,
//   );


//   ZegoUIKit().initLog().then((value) {
//     ZegoUIKitPrebuiltCallInvitationService().useSystemCallingUI(
//       [ZegoUIKitSignalingPlugin()],
//     );

//     runApp(MyApp());
//   });
// }

// class MyApp extends StatefulWidget {
//   final GlobalKey<NavigatorState>? navigatorKey;

//   const MyApp({
//     this.navigatorKey,
//     Key? key,
//   }) : super(key: key);

//   @override
//   State<MyApp> createState() => _MyAppState();
// }

// class _MyAppState extends State<MyApp> {
//   @override
//   Widget build(BuildContext context) {
//     SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
//       statusBarColor: Colors.transparent,
//       statusBarIconBrightness: Brightness.dark,
//     ));
//     return MultiBlocProvider(
//       providers: [
//         BlocProvider<SystemConfigCubit>(
//           create: (context) => SystemConfigCubit(),
//         ),
//         BlocProvider<GetGuestAllPostCubit>(
//           create: (context) => GetGuestAllPostCubit(),
//         ),
//         BlocProvider<AddPostCubit>(
//           create: (context) => AddPostCubit(),
//         ),
//         BlocProvider<NewProfileSCubit>(
//           create: (context) => NewProfileSCubit(),
//         ),
//         BlocProvider<CreateStoryCubit>(
//           create: (context) => CreateStoryCubit(),
//         ),
//         BlocProvider<SelectChatMemberListCubit>(
//           create: (context) => SelectChatMemberListCubit(),
//         ),
//         BlocProvider<GetPostAllLikeCubit>(
//           create: (context) => GetPostAllLikeCubit(),
//         ),
//         BlocProvider<AddcommentCubit>(
//           create: (context) => AddcommentCubit(),
//         ),
//         BlocProvider<CreatFourmCubit>(
//           create: (context) => CreatFourmCubit(),
//         ),
//         BlocProvider<HashTagCubit>(
//           create: (context) => HashTagCubit(),
//         ),
//         BlocProvider<FetchExprtiseRoomCubit>(
//           create: (context) => FetchExprtiseRoomCubit(),
//         ),
//         BlocProvider<FetchAllPublicRoomCubit>(
//           create: (context) => FetchAllPublicRoomCubit(),
//         ),
//         BlocProvider<CreatPublicRoomCubit>(
//           create: (context) => CreatPublicRoomCubit(),
//         ),
//         BlocProvider<senMSGCubit>(
//           create: (context) => senMSGCubit(),
//         ),
//         BlocProvider<FollowerBlock>(
//           create: (context) => FollowerBlock(),
//         ),
//         BlocProvider<RegisterCubit>(
//           create: (context) => RegisterCubit(),
//         ),
//         BlocProvider<CreateRoomCubit>(
//           create: (context) => CreateRoomCubit(),
//         ),
//         BlocProvider<GetAllPrivateRoomCubit>(
//           create: (context) => GetAllPrivateRoomCubit(),
//         ),
//         BlocProvider<InvitationCubit>(
//           create: (context) => InvitationCubit(),
//         ),
//         BlocProvider<SherInviteCubit>(
//           create: (_) => SherInviteCubit(),
//         ),
//         BlocProvider<FetchRoomDetailCubit>(
//           create: (_) => FetchRoomDetailCubit(),
//         ),
//         BlocProvider<LoginCubit>(
//           create: (context) => LoginCubit(),
//         ),
//         BlocProvider<DevicesInfoCubit>(
//           create: (context) => DevicesInfoCubit(),
//         ),
//         BlocProvider<FatchAllMembersCubit>(
//           create: (context) => FatchAllMembersCubit(),
//         ),
//         BlocProvider<ForgetpasswordCubit>(
//           create: (context) => ForgetpasswordCubit(),
//         ),
//         BlocProvider<SelectedRoomCubit>(
//           create: (context) => SelectedRoomCubit(),
//         ),
//         BlocProvider<OtpCubit>(
//           create: (context) => OtpCubit(),
//         ),
//         BlocProvider<MyAccountCubit>(
//           create: (context) => MyAccountCubit(),
//         ),
//         BlocProvider<ViewDetailsCubit>(
//           create: (context) => ViewDetailsCubit(),
//         ),
//         BlocProvider<EditroomCubit>(
//           create: (context) => EditroomCubit(),
//         ),
//         BlocProvider<OpenSaveCubit>(
//           create: (context) => OpenSaveCubit(),
//         ),
//         BlocProvider<ViewStoryCubit>(
//           create: (context) => ViewStoryCubit(),
//         ),
//         BlocProvider<PersonalChatListCubit>(
//           create: (context) => PersonalChatListCubit(),
//         ),
//         BlocProvider<RePostCubit>(
//           create: (context) => RePostCubit(),
//         ),
//         BlocProvider<RoomExistsCubit>(
//           create: (context) => RoomExistsCubit(),
//         ),
//         BlocProvider<AccountCubit>(
//           create: (context) => AccountCubit(),
//         ),
//         BlocProvider<DmInboxCubit>(
//           create: (context) => DmInboxCubit(),
//         ),
//         BlocProvider<BlogcommentCubit>(
//           create: (context) => BlogcommentCubit(),
//         ),
        
//       ],
//       child: Portal(
//         child: MaterialApp(
//           theme: ThemeData(
//             visualDensity: VisualDensity.standard,
//           ),
//           title: 'InPackaging',
//           debugShowCheckedModeBanner: false,
//           navigatorKey: navigatorKey,
//           home: SplashScreen(),
//           builder: (BuildContext context, Widget? child) {
//             return Stack(
//               children: [
//                 child!,
//                 ZegoUIKitPrebuiltCallMiniOverlayPage(
//                   contextQuery: () {
//                     return widget.navigatorKey!.currentState!.context;
//                   },
//                 ),
//               ],
//             );
//           },
//           //BottombarPage(buttomIndex: 0),
//         ),
//       ),
//     );
//   }
// }



import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_mentions/flutter_mentions.dart';
import 'package:pds/API/Bloc/BlogComment_BLoc/BlogComment_cubit.dart';
import 'package:pds/API/Bloc/CreateRoom_Bloc/CreateRoom_cubit.dart';
import 'package:pds/API/Bloc/CreateStory_Bloc/CreateStory_Cubit.dart';
import 'package:pds/API/Bloc/Edit_room_bloc/edit_room_cubit.dart';
import 'package:pds/API/Bloc/Fatch_All_PRoom_Bloc/Fatch_PRoom_cubit.dart';
import 'package:pds/API/Bloc/Fatch_all_members/fatch_all_members_cubit.dart';
import 'package:pds/API/Bloc/FetchExprtise_Bloc/fetchExprtise_cubit.dart';
import 'package:pds/API/Bloc/Fetchroomdetails_Bloc/Fetchroomdetails_cubit.dart';
import 'package:pds/API/Bloc/Forget_password_Bloc/forget_password_cubit.dart';
import 'package:pds/API/Bloc/GetAllPrivateRoom_Bloc/GetAllPrivateRoom_cubit.dart';
import 'package:pds/API/Bloc/GuestAllPost_Bloc/GetPostAllLike_Bloc/GetPostAllLike_cubit.dart';
import 'package:pds/API/Bloc/GuestAllPost_Bloc/GuestAllPost_cubit.dart';
import 'package:pds/API/Bloc/HashTag_Bloc/HashTag_cubit.dart';
import 'package:pds/API/Bloc/Invitation_Bloc/Invitation_cubit.dart';
import 'package:pds/API/Bloc/NewProfileScreen_Bloc/NewProfileScreen_cubit.dart';
import 'package:pds/API/Bloc/OpenSaveImagepost_Bloc/OpenSaveImagepost_cubit.dart';
import 'package:pds/API/Bloc/PersonalChatList_Bloc/PersonalChatList_cubit.dart';
import 'package:pds/API/Bloc/PublicRoom_Bloc/CreatPublicRoom_cubit.dart';
import 'package:pds/API/Bloc/RePost_Bloc/RePost_cubit.dart';
import 'package:pds/API/Bloc/RoomExists_bloc/RoomExists_cubit.dart';
import 'package:pds/API/Bloc/SelectChat_bloc/SelectChat_cubit.dart';
import 'package:pds/API/Bloc/SelectRoom_Bloc/SelectRoom_cubit.dart';
import 'package:pds/API/Bloc/System_Config_Bloc/system_config_cubit.dart';
import 'package:pds/API/Bloc/ViewDetails_Bloc/ViewDetails_cubit.dart';
import 'package:pds/API/Bloc/accounttype_bloc/account_cubit.dart';
import 'package:pds/API/Bloc/add_comment_bloc/add_comment_cubit.dart';
import 'package:pds/API/Bloc/auth/login_Block.dart';
import 'package:pds/API/Bloc/auth/otp_block.dart';
import 'package:pds/API/Bloc/auth/register_Block.dart';
import 'package:pds/API/Bloc/creatForum_Bloc/creat_Forum_cubit.dart';
import 'package:pds/API/Bloc/device_info_Bloc/device_info_bloc.dart';
import 'package:pds/API/Bloc/dmInbox_bloc/dminbox_blcok.dart';
import 'package:pds/API/Bloc/followerBlock/followBlock.dart';
import 'package:pds/API/Bloc/my_account_Bloc/my_account_cubit.dart';
import 'package:pds/API/Bloc/senMSG_Bloc/senMSG_cubit.dart';
import 'package:pds/API/Bloc/sherinvite_Block/sherinvite_cubit.dart';
import 'package:pds/API/Bloc/viewStory_Bloc/viewStory_cubit.dart';
import 'package:pds/theme/theme_helper.dart';
import 'API/Bloc/postData_Bloc/postData_Bloc.dart';
import 'presentation/splash_screen/splash_screen.dart';
import 'package:flutter_langdetect/flutter_langdetect.dart' as langdetect;

Future<void> _messageHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print('background message ${message.notification!.body}');
  print("value Gey-${message.data}");
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FlutterDownloader.initialize();
  await WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await langdetect.initLangDetect();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);

  ///Please update theme as per your need if required.
  ThemeHelper().changeTheme('primary');

  FirebaseMessaging.onBackgroundMessage(_messageHandler);
  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) async {
    print("/* onMessageOpenedApp: */ ${message.notification?.body}");
    print("/* onMessageOpenedApp: */ ${message.notification?.title}");
    print("/* onMessageOpenedApp: */ ${message.data}");
  });

  FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );

  _firebaseMessaging.requestPermission(
    sound: true,
    badge: true,
    alert: true,
    provisional: false,
  );

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarBrightness: Brightness.light,
      statusBarIconBrightness: Brightness.dark,
    ));
    return MultiBlocProvider(
      providers: [
        BlocProvider<SystemConfigCubit>(
          create: (context) => SystemConfigCubit(),
        ),
        BlocProvider<GetGuestAllPostCubit>(
          create: (context) => GetGuestAllPostCubit(),
        ),
        BlocProvider<AddPostCubit>(
          create: (context) => AddPostCubit(),
        ),
        BlocProvider<NewProfileSCubit>(
          create: (context) => NewProfileSCubit(),
        ),
        BlocProvider<CreateStoryCubit>(
          create: (context) => CreateStoryCubit(),
        ),
        BlocProvider<SelectChatMemberListCubit>(
          create: (context) => SelectChatMemberListCubit(),
        ),
        BlocProvider<GetPostAllLikeCubit>(
          create: (context) => GetPostAllLikeCubit(),
        ),
        BlocProvider<AddcommentCubit>(
          create: (context) => AddcommentCubit(),
        ),
        BlocProvider<CreatFourmCubit>(
          create: (context) => CreatFourmCubit(),
        ),
        BlocProvider<HashTagCubit>(
          create: (context) => HashTagCubit(),
        ),
        BlocProvider<FetchExprtiseRoomCubit>(
          create: (context) => FetchExprtiseRoomCubit(),
        ),
        BlocProvider<FetchAllPublicRoomCubit>(
          create: (context) => FetchAllPublicRoomCubit(),
        ),
        BlocProvider<CreatPublicRoomCubit>(
          create: (context) => CreatPublicRoomCubit(),
        ),
        BlocProvider<senMSGCubit>(
          create: (context) => senMSGCubit(),
        ),
        BlocProvider<FollowerBlock>(
          create: (context) => FollowerBlock(),
        ),
        BlocProvider<RegisterCubit>(
          create: (context) => RegisterCubit(),
        ),
        BlocProvider<CreateRoomCubit>(
          create: (context) => CreateRoomCubit(),
        ),
        BlocProvider<GetAllPrivateRoomCubit>(
          create: (context) => GetAllPrivateRoomCubit(),
        ),
        BlocProvider<InvitationCubit>(
          create: (context) => InvitationCubit(),
        ),
        BlocProvider<SherInviteCubit>(
          create: (_) => SherInviteCubit(),
        ),
        BlocProvider<FetchRoomDetailCubit>(
          create: (_) => FetchRoomDetailCubit(),
        ),
        BlocProvider<LoginCubit>(
          create: (context) => LoginCubit(),
        ),
        BlocProvider<DevicesInfoCubit>(
          create: (context) => DevicesInfoCubit(),
        ),
        BlocProvider<FatchAllMembersCubit>(
          create: (context) => FatchAllMembersCubit(),
        ),
        BlocProvider<ForgetpasswordCubit>(
          create: (context) => ForgetpasswordCubit(),
        ),
        BlocProvider<SelectedRoomCubit>(
          create: (context) => SelectedRoomCubit(),
        ),
        BlocProvider<OtpCubit>(
          create: (context) => OtpCubit(),
        ),
        BlocProvider<MyAccountCubit>(
          create: (context) => MyAccountCubit(),
        ),
        BlocProvider<ViewDetailsCubit>(
          create: (context) => ViewDetailsCubit(),
        ),
        BlocProvider<EditroomCubit>(
          create: (context) => EditroomCubit(),
        ),
        BlocProvider<OpenSaveCubit>(
          create: (context) => OpenSaveCubit(),
        ),
        BlocProvider<ViewStoryCubit>(
          create: (context) => ViewStoryCubit(),
        ),
        BlocProvider<PersonalChatListCubit>(
          create: (context) => PersonalChatListCubit(),
        ),
        BlocProvider<RePostCubit>(
          create: (context) => RePostCubit(),
        ),
        BlocProvider<RoomExistsCubit>(
          create: (context) => RoomExistsCubit(),
        ),
        BlocProvider<AccountCubit>(
          create: (context) => AccountCubit(),
        ),
        BlocProvider<DmInboxCubit>(
          create: (context) => DmInboxCubit(),
        ),
        BlocProvider<BlogcommentCubit>(
          create: (context) => BlogcommentCubit(),
        ),
      ],
      child: Portal(
        child: MaterialApp(
            theme: ThemeData(
              visualDensity: VisualDensity.standard,
            ),
            title: 'pds',
            debugShowCheckedModeBanner: false,
            home: SplashScreen()
            //BottombarPage(buttomIndex: 0),
            ),
      ),
    );
  }
}
