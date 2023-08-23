import 'package:archit_s_application1/API/Bloc/auth/register_Block.dart';
import 'package:archit_s_application1/theme/theme_helper.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';


import 'API/Bloc/Fatch_All_PRoom_Bloc/Fatch_PRoom_cubit.dart';
import 'API/Bloc/GetAllPrivateRoom_Bloc/GetAllPrivateRoom_cubit.dart';
import 'API/Bloc/Invitation_Bloc/Invitation_cubit.dart';
import 'API/Bloc/PublicRoom_Bloc/CreatPublicRoom_cubit.dart';
import 'API/Bloc/senMSG_Bloc/senMSG_cubit.dart';
import 'core/utils/sharedPreferences.dart';
import 'custom_bottom_bar/custom_bottom_bar.dart';



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
    print("onMessageOpenedApp: $message");

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
    return MaterialApp(
        // navigatorObservers: [FlutterSmartDialog.observer],
        // here
        // builder: FlutterSmartDialog.init(),
        theme: ThemeData(
          visualDensity: VisualDensity.standard,
        ),
        title: 'archit_s_application1',
        debugShowCheckedModeBanner: false,
        //  initialRoute: AppRoutes.splashScreen,
        //  routes: AppRoutes.routes,
        home: MultiBlocProvider(
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
        )
        //BottombarPage(buttomIndex: 0),
        );
  }
}
