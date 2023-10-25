import 'package:pds/API/Bloc/System_Config_Bloc/system_config_cubit.dart';
import 'package:pds/theme/theme_helper.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
    return MaterialApp(
        // navigatorObservers: [FlutterSmartDialog.observer],
        // here
        // builder: FlutterSmartDialog.init(),
        theme: ThemeData(
          visualDensity: VisualDensity.standard,
        ),
        title: 'pds',
        debugShowCheckedModeBanner: false,
        //  initialRoute: AppRoutes.splashScreen,
        //  routes: AppRoutes.routes,
        home: MultiBlocProvider(
          providers: [
            BlocProvider<SystemConfigCubit>(
              create: (context) => SystemConfigCubit(),
            ),
          ],
          child: SplashScreen(),
          // child: CameraAccsessScreen(),
        )
        //BottombarPage(buttomIndex: 0),
        );
  }
}
