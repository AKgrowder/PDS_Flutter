import 'package:archit_s_application1/API/Bloc/auth/register_Block.dart';
import 'package:archit_s_application1/theme/theme_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'API/Bloc/Fatch_All_PRoom_Bloc/Fatch_PRoom_cubit.dart';
import 'API/Bloc/GetAllPrivateRoom_Bloc/GetAllPrivateRoom_cubit.dart';
import 'API/Bloc/Invitation_Bloc/Invitation_cubit.dart';
import 'API/Bloc/PublicRoom_Bloc/CreatPublicRoom_cubit.dart';
import 'API/Bloc/senMSG_Bloc/senMSG_cubit.dart';
import 'custom_bottom_bar/custom_bottom_bar.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);

  ///Please update theme as per your need if required.
  ThemeHelper().changeTheme('primary');

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
