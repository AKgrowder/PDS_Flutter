import 'package:archit_s_application1/theme/theme_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'API/Bloc/Fatch_All_PRoom_Bloc/Fatch_PRoom_cubit.dart';
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
        theme: ThemeData(
          visualDensity: VisualDensity.standard,
        ),
        title: 'archit_s_application1',
        debugShowCheckedModeBanner: false,
        // initialRoute: AppRoutes.splashScreen,
        // routes: AppRoutes.routes,
        home: MultiBlocProvider(
          providers: [
            BlocProvider<FetchAllPublicRoomCubit>(
              create: (context) => FetchAllPublicRoomCubit(),
            ),
          ],
          child: BottombarPage(buttomIndex: 0),
        )
        // BottombarPage(buttomIndex: 0),
        );
  }
}
