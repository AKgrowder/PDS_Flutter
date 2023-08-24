import 'package:archit_s_application1/API/Bloc/Fatch_All_PRoom_Bloc/Fatch_PRoom_cubit.dart';
import 'package:archit_s_application1/API/Bloc/PublicRoom_Bloc/CreatPublicRoom_cubit.dart';
import 'package:archit_s_application1/API/Bloc/auth/register_Block.dart';
import 'package:archit_s_application1/API/Bloc/senMSG_Bloc/senMSG_cubit.dart';
import 'package:archit_s_application1/API/Bloc/sherinvite_Block/sherinvite_cubit.dart';
import 'package:archit_s_application1/core/app_export.dart';
import 'package:archit_s_application1/custom_bottom_bar/custom_bottom_bar.dart';
import 'package:archit_s_application1/presentation/Login_Screen/Login_Screen.dart';
import 'package:archit_s_application1/widgets/app_bar/appbar_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../API/Bloc/GetAllPrivateRoom_Bloc/GetAllPrivateRoom_cubit.dart';
import '../../API/Bloc/Invitation_Bloc/Invitation_cubit.dart';
import '../create_account_screen/create_account_screen.dart';
import '../../API/Bloc/auth/login_Block.dart';
import '../../API/Bloc/device_info_Bloc/device_info_bloc.dart';

class RegisterCreateAccountScreen extends StatefulWidget {
  @override
  State<RegisterCreateAccountScreen> createState() =>
      _RegisterCreateAccountScreenState();
}

class _RegisterCreateAccountScreenState
    extends State<RegisterCreateAccountScreen> {
  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    double _height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: theme.colorScheme.onPrimary,
      body: Column(
        children: [
          Stack(
            children: [
              Container(
                //-----------------------------
                height: _height / 2.5,
                //----------------------------
                width: _width,
                // color: Colors.red,
                child: CustomImageView(
                  imagePath: ImageConstant.register,
                  fit: BoxFit.fill,
                ),
              ),
              Container(
                alignment: Alignment.topLeft,
                child: AppbarImage(
                    height: 23,
                    width: 24,
                    svgPath: ImageConstant.imgArrowleft,
                    margin: EdgeInsets.only(
                      left: 20,
                      top: 50,
                    ),
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return MultiBlocProvider(providers: [
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
                        ], child: BottombarPage(buttomIndex: 0));
                      }));
                    }),
              ),
            ],
          ),
          SizedBox(
            height: 30,
          ),
          Container(
            margin: EdgeInsets.only(top: 5),
            height: 40,
            child: Center(
              child: Text(
                "Welcome to consultant app",
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.left,
                style: TextStyle(
                    fontFamily: 'outfit',
                    fontWeight: FontWeight.bold,
                    fontSize: 23),
                // style: TextThemeHelper.titleLarge22,
              ),
            ),
          ),
          Container(
            child: Text(
              "Create a New Account or ",
              style: TextStyle(
                  fontFamily: 'outfit',
                  fontWeight: FontWeight.w400,
                  color: Colors.grey,
                  fontSize: 15),
            ),
          ),
          Container(
            child: Text(
              "Login Now",
              style: TextStyle(
                  fontFamily: 'outfit',
                  fontWeight: FontWeight.w400,
                  color: Colors.grey,
                  fontSize: 15),
            ),
          ),
          Spacer(),
          Container(
            height: 100,
          ),
          GestureDetector(
            onTap: () {
              print('this is the data fget');
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return MultiBlocProvider(providers: [
                  BlocProvider<RegisterCubit>(
                    create: (context) => RegisterCubit(),
                  )
                ], child: CreateAccountScreen());
              }));
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(builder: (context) => CreateAccountScreen()),
              // );
            },
            child: Padding(
              padding: EdgeInsets.only(left: 30, right: 30, bottom: 30),
              child: Container(
                alignment: Alignment.center,
                height: _height * 0.055,
                width: _width,
                decoration: BoxDecoration(
                  color: Color(0xffED1C25),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Text(
                  'Create Account',
                  style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'outfit',
                      fontSize: 15,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return MultiBlocProvider(providers: [
                  BlocProvider<LoginCubit>(
                    create: (context) => LoginCubit(),
                  ),
                  BlocProvider<DevicesInfoCubit>(
                    create: (context) => DevicesInfoCubit(),
                  )
                ], child: LoginScreen());
              }));
            },
            child: Padding(
              padding: EdgeInsets.only(left: 30, right: 30, bottom: 30),
              child: Container(
                alignment: Alignment.center,
                height: _height * 0.055,
                width: _width,
                decoration: BoxDecoration(
                    color: Color(0xffFFD9DA),
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(color: Color(0xffED1C25))),
                child: Text(
                  'Log In',
                  style: TextStyle(
                      color: Color(0xffED1C25),
                      fontFamily: 'outfit',
                      fontSize: 15,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
