import 'package:archit_s_application1/API/Bloc/Fatch_All_PRoom_Bloc/Fatch_PRoom_cubit.dart';
import 'package:archit_s_application1/API/Bloc/PublicRoom_Bloc/CreatPublicRoom_cubit.dart';
import 'package:archit_s_application1/API/Bloc/auth/login_Block.dart';
import 'package:archit_s_application1/API/Bloc/auth/login_state.dart';
import 'package:archit_s_application1/API/Bloc/auth/otp_block.dart';
import 'package:archit_s_application1/API/Bloc/auth/register_Block.dart';
import 'package:archit_s_application1/API/Bloc/senMSG_Bloc/senMSG_cubit.dart';
import 'package:archit_s_application1/core/app_export.dart';
import 'package:archit_s_application1/core/utils/color_constant.dart';
import 'package:archit_s_application1/core/utils/sharedPreferences.dart';
import 'package:archit_s_application1/custom_bottom_bar/custom_bottom_bar.dart';
import 'package:archit_s_application1/presentation/otp_verification_screen/otp_verification_screen.dart';
import 'package:archit_s_application1/widgets/custom_elevated_button.dart';
import 'package:archit_s_application1/widgets/custom_outlined_button.dart';
import 'package:archit_s_application1/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../API/Bloc/GetAllPrivateRoom_Bloc/GetAllPrivateRoom_cubit.dart';
import '../../API/Model/authModel/getUserDetailsMdoel.dart';
import '../../API/Model/authModel/loginModel.dart';
import '../../widgets/app_bar/appbar_image.dart';
import '../forget_password_screen/forget_password_screen.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key? key})
      : super(
          key: key,
        );

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController mobilenumberController = TextEditingController();

  TextEditingController passwordoneController = TextEditingController();

  TextEditingController emailAndMobileController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  LoginModel? loginModelData;
  GetUserDataModel? getUserDataModelData;

  bool Show_Password = true;
  bool isPhone = false;

  @override
  Widget build(BuildContext context) {
    var _height = MediaQuery.of(context).size.height;
    var _width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        backgroundColor: theme.colorScheme.onPrimary,
        resizeToAvoidBottomInset: true,
        body: BlocProvider<LoginCubit>(
          create: (context) => LoginCubit(),
          child: BlocConsumer<LoginCubit, LoginState>(
            listener: (context, state) {
              if (state is LoginErrorState) {
                print("error");
                SnackBar snackBar = SnackBar(
                  content: Text(state.error),
                  backgroundColor: ColorConstant.primary_color,
                );
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              }
              if (state is LoginLoadingState) {
                print("loading");
                Center(
                  child: Container(
                    margin: EdgeInsets.only(bottom: 100),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.asset(ImageConstant.loader,
                          fit: BoxFit.cover, height: 100.0, width: 100),
                    ),
                  ),
                );
              }
              if (state is LoginLoadedState) {
                loginModelData = state.loginModel;
                if (state.loginModel.object?.verified == false) {
                  BlocProvider.of<LoginCubit>(context).getUserDetails(
                      state.loginModel.object?.uuid.toString() ?? "");
                }
                if (state.loginModel.object?.verified == true) {
                  BlocProvider.of<LoginCubit>(context).getUserDetails(
                      state.loginModel.object?.uuid.toString() ?? "");
                  getDataStroe(
                      state.loginModel.object?.uuid.toString() ?? "",
                      state.loginModel.object?.jwt.toString() ?? "",
                      loginModelData?.object?.module.toString() ?? ""

                      // state.loginModel.object!.verified.toString(),
                      );
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return MultiBlocProvider(
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
                        ],
                        child: BottombarPage(
                          buttomIndex: 0,
                        ));
                  }));
                }

                SnackBar snackBar = SnackBar(
                  content: Text(state.loginModel.message ?? ""),
                  backgroundColor: ColorConstant.primary_color,
                );
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
                print(
                    'check Status--${state.loginModel.object!.verified.toString()}');

                // Navigator.push(context,MaterialPageRoute(builder: (context)=> HomeScreen()));
              }
              if (state is GetUserLoadedState) {
                getUserDataModelData = state.getUserDataModel;
                saveUserProfile();
                print("Get Profile");
                if (loginModelData?.object?.verified == true) {
                  getDataStroe(
                      loginModelData?.object?.uuid.toString() ?? "",
                      loginModelData?.object?.jwt.toString() ?? "",
                      loginModelData?.object?.module.toString() ?? ""
                      // state.loginModel.object!.verified.toString(),
                      );
                  print('this condison is calling');
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return MultiBlocProvider(
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
                        ],
                        child: BottombarPage(
                          buttomIndex: 0,
                        ));
                  }));
                } else {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return MultiBlocProvider(
                        providers: [
                          BlocProvider<OtpCubit>(
                            create: (context) => OtpCubit(),
                          )
                        ],
                        child: OtpVerificationScreen(
                          flowCheck: 'login',
                          phonNumber: state.getUserDataModel.object?.mobileNo,
                          userId: loginModelData?.object?.uuid.toString(),
                        ));
                  }));
                }
              }
            },
            builder: (context, state) {
              return SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: SizedBox(
                    // width: double.maxFinite,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 348,
                          // width: double.maxFinite,
                          child: Stack(
                            children: [
                              CustomImageView(
                                imagePath: ImageConstant.LoginImage,
                                height: 348,
                                width: 414,
                                alignment: Alignment.center,
                              ),
                              Container(
                                alignment: Alignment.topLeft,
                                child: AppbarImage(
                                    height: 23,
                                    width: 24,
                                    svgPath: ImageConstant.imgArrowleft,
                                    margin: EdgeInsets.only(
                                        left: 20,
                                        top: 19,
                                        bottom: 13,
                                        right: 15),
                                    onTap: () {
                                      Navigator.pop(context);
                                    }),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            top: 39,
                          ),
                          child: Text(
                            "Log In",
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                fontFamily: 'outfit',
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: EdgeInsets.only(
                              left: 30,
                              top: 41,
                            ),
                            child: Text(
                              "Email / Mobile number",
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  fontFamily: 'outfit',
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                        ),
                        CustomTextFormField(
                          validator: (value) {
                            final RegExp nameRegExp = RegExp(
                                r"^[a-zA-Z]+(([',. -][a-zA-Z ])?[a-zA-Z]*)*$");
                            if (value!.isEmpty) {
                              return 'Please Enter Name';
                            }
                            return null;
                          },
                          onChanged: (value) {
                            print("onchange");
                            final RegExp regex = RegExp('[a-zA-Z]');
                            if (emailAndMobileController.text == null ||
                                emailAndMobileController.text.isEmpty ||
                                !regex
                                    .hasMatch(emailAndMobileController.text)) {
                              setState(() {
                                isPhone = true;
                              });
                            } else {
                              setState(() {
                                isPhone = false;
                              });
                            }
                          },
                          maxLength: isPhone == true ? 10 : 30,
                          // focusNode: FocusNode(),
                          controller: emailAndMobileController,
                          margin: EdgeInsets.only(
                            left: 30,
                            right: 30,
                          ),
                          contentPadding: EdgeInsets.only(
                            left: 12,
                            top: 14,
                            right: 12,
                            bottom: 14,
                          ),
                          // textStyle: theme.textTheme.titleMedium!,
                          hintText: "Email / Mobile number",
                          hintStyle: TextStyle(
                              fontFamily: 'outfit',
                              fontSize: 15,
                              fontWeight: FontWeight.w400),
                          textInputAction: TextInputAction.next,
                          textInputType: TextInputType.emailAddress,
                          filled: true,
                          // fillColor: appTheme.gray100,
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: EdgeInsets.only(
                              left: 30,
                              top: 19,
                            ),
                            child: Text(
                              "Password",
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  fontFamily: 'outfit',
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                        ),
                        CustomTextFormField(
                          // focusNode: FocusNode(),
                          // autofocus: true,

                          validator: (value) {
                            final RegExp passwordRegExp = RegExp(
                                r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');

                            if (value!.isEmpty) {
                              return 'Please Enter Password';
                            } else if (!passwordRegExp.hasMatch(value)) {
                              return 'please Enter Password';
                            }
                            return null;
                          },
                          controller: passwordoneController,
                          // textInputType: TextInputType. number,
                          margin: EdgeInsets.only(
                            left: 30,
                            top: 5,
                            right: 30,
                          ),
                          contentPadding: EdgeInsets.only(
                            left: 20,
                            top: 14,
                            bottom: 14,
                          ),
                          // textStyle: theme.textTheme.titleMedium!,
                          hintText: "Password",
                          hintStyle: TextStyle(
                              fontFamily: 'outfit',
                              fontSize: 15,
                              fontWeight: FontWeight.w400),
                          textInputType: TextInputType.emailAddress,
                          suffix: Container(
                            margin: EdgeInsets.only(
                              left: 30,
                              top: 15,
                              right: 15,
                              bottom: 15,
                            ),
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  Show_Password = !Show_Password;
                                });
                              },
                              child: Show_Password
                                  ? CustomImageView(
                                      svgPath: ImageConstant.imgEye,
                                    )
                                  : Icon(
                                      Icons.remove_red_eye_sharp,
                                      color: Colors.grey,
                                    ),
                            ),
                          ),
                          suffixConstraints: BoxConstraints(maxHeight: 50),
                          obscureText: Show_Password ? true : false,
                          maxLength: 30,
                          filled: true,
                          inputFormatters: [
                            FilteringTextInputFormatter.deny(RegExp(r'\s')),
                          ],
                          fillColor: appTheme.gray100,
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: EdgeInsets.only(
                              left: 30,
                              top: 13,
                            ),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) =>
                                        ForgetPasswordScreen()));
                              },
                              child: Text(
                                "Forget Password?",
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.left,
                                // style: theme.textTheme.titleSmall,
                                style: TextStyle(
                                    fontFamily: 'outfit',
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500,
                                    color: Color(0xFFED1C25)),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 30, right: 30, top: 10),
                          child: CustomElevatedButton(
                            onTap: () {
                              if (_formKey.currentState!.validate()) {
                                var dataPassing = {
                                  "username": emailAndMobileController.text,
                                  "password": passwordoneController.text
                                };
                                print('dataPassing-$dataPassing');
                                BlocProvider.of<LoginCubit>(context)
                                    .loginApidata(dataPassing);
                              }
                            },
                            text: "Log In",
                            buttonStyle: ButtonThemeHelper.outlineOrangeA7000c
                                .copyWith(
                                    fixedSize: MaterialStateProperty.all<Size>(
                                        Size(double.infinity, 50))),
                            // buttonTextStyle:
                            //     TextThemeHelper.titleMediumOnPrimary,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            top: 25,
                            bottom: 5,
                          ),
                          child: RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: "Connect with us at  ",
                                  style: TextStyle(
                                    color: appTheme.black900,
                                    fontSize: 14,
                                    fontFamily: 'Outfit',
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                TextSpan(
                                  text: "Support",
                                  style: TextStyle(
                                    color: theme.colorScheme.primary,
                                    fontSize: 14,
                                    fontFamily: 'Outfit',
                                    fontWeight: FontWeight.w500,
                                    decoration: TextDecoration.underline,
                                  ),
                                ),
                              ],
                            ),
                            textAlign: TextAlign.left,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 30, right: 30, top: 10),
                          child: CustomOutlinedButton(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          OtpVerificationScreen()),
                                );
                              },
                              text: "Log In With OTP",
                              margin: EdgeInsets.only(
                                left: 30,
                                right: 30,
                                bottom: 51,
                              ),
                              buttonStyle: ButtonThemeHelper.outlinePrimaryTL6
                                  .copyWith(
                                      fixedSize:
                                          MaterialStateProperty.all<Size>(
                                              Size(double.maxFinite, 50))),
                              buttonTextStyle: TextStyle(
                                  color: Color(0xFFED1C25),
                                  fontFamily: 'outfit',
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold)),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  getDataStroe(String userId, String jwt, String user_Module) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(PreferencesKey.loginUserID, userId);
    prefs.setString(PreferencesKey.loginJwt, jwt);
    prefs.setString(PreferencesKey.module, user_Module);
    // prefs.setString(PreferencesKey.loginVerify, verify);
    print('userId-$userId');
    print('jwt-$jwt');
    // print('verify-$verify');
  }

  saveUserProfile() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.setString(PreferencesKey.ProfileUserName,
        "${getUserDataModelData?.object?.userName}");
    prefs.setString(
        PreferencesKey.ProfileName, "${getUserDataModelData?.object?.name}");
    prefs.setString(
        PreferencesKey.ProfileEmail, "${getUserDataModelData?.object?.email}");
    prefs.setString(PreferencesKey.ProfileModule,
        "${getUserDataModelData?.object?.module}");
    prefs.setString(PreferencesKey.ProfileMobileNo,
        "${getUserDataModelData?.object?.mobileNo}");
  }
}
