import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
import 'package:pds/API/Bloc/PublicRoom_Bloc/CreatPublicRoom_cubit.dart';
import 'package:pds/API/Bloc/SelectRoom_Bloc/SelectRoom_cubit.dart';
import 'package:pds/API/Bloc/System_Config_Bloc/system_config_cubit.dart';
import 'package:pds/API/Bloc/ViewDetails_Bloc/ViewDetails_cubit.dart';
import 'package:pds/API/Bloc/add_comment_bloc/add_comment_cubit.dart';
import 'package:pds/API/Bloc/auth/login_Block.dart';
import 'package:pds/API/Bloc/auth/otp_block.dart';
import 'package:pds/API/Bloc/auth/register_Block.dart';
import 'package:pds/API/Bloc/creatForum_Bloc/creat_Forum_cubit.dart';
import 'package:pds/API/Bloc/device_info_Bloc/device_info_bloc.dart';
import 'package:pds/API/Bloc/my_account_Bloc/my_account_cubit.dart';
import 'package:pds/API/Bloc/senMSG_Bloc/senMSG_cubit.dart';
import 'package:pds/API/Bloc/sherinvite_Block/sherinvite_cubit.dart';
import 'package:pds/theme/theme_helper.dart';

import 'API/Bloc/postData_Bloc/postData_Bloc.dart';
import 'presentation/splash_screen/splash_screen.dart';

Future<void> _messageHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print('background message ${message.notification!.body}');
}

void main() async {
  await WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);

  ///Please update theme as per your need if required.
  ThemeHelper().changeTheme('primary');

  FirebaseMessaging.onBackgroundMessage(_messageHandler);
  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) async {
    print("/* onMessageOpenedApp: */ $message");
    // if (message.data["navigation"] == "/your_route") {
    //   int _yourId = int.tryParse(message.data["id"]) ?? 0;
    //   Navigator.push(
    //       navigatorKey.currentState.context,
    //       MaterialPageRoute(
    //           builder: (context) => YourScreen(
    //                 yourId: _yourId,
    //               )));
    // }
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
    return MultiBlocProvider(
      providers: [
        BlocProvider<SystemConfigCubit>(
          create: (context) => SystemConfigCubit(),
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
        
      ],
      child: MaterialApp(
          theme: ThemeData(
            visualDensity: VisualDensity.standard,
          ),
          title: 'pds',
          debugShowCheckedModeBanner: false,
          home: SplashScreen()
          //BottombarPage(buttomIndex: 0),
          ),
    );
  }
}
