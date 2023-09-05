import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pds/API/Bloc/Forget_password_Bloc/forget_password_cubit.dart';
import 'package:pds/API/Bloc/Forget_password_Bloc/forget_password_state.dart';
import 'package:pds/API/Bloc/auth/login_Block.dart';
import 'package:pds/presentation/Login_Screen/Login_Screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../API/Bloc/device_info_Bloc/device_info_bloc.dart';
import '../../core/utils/color_constant.dart';
import '../../core/utils/image_constant.dart';
import '../../core/utils/sharedPreferences.dart';
import '../../theme/theme_helper.dart';
import '../../widgets/custom_image_view.dart';
import '../../widgets/custom_text_form_field.dart';

class ChangePasswordScreen extends StatefulWidget {
  String? mobile;
  bool? isProfile;

  ChangePasswordScreen({Key? key, this.mobile, this.isProfile = false})
      : super(key: key);

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

var Show_Password = true;
var Show_Passwordd = true;
TextEditingController newpasswordController = TextEditingController();
TextEditingController conformpasswordController = TextEditingController();

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  String? userUid;
  @override
  void initState() {
    SetData();
    super.initState();
  }

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    double _height = MediaQuery.of(context).size.height;
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: theme.colorScheme.onPrimary,
          elevation: 0,
          leading: GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Icon(
              Icons.arrow_back,
              color: Colors.grey,
            ),
          ),
          title: Text(
            "Change Password",
            style: TextStyle(
              fontFamily: 'outfit',
              fontSize: 23,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        backgroundColor: theme.colorScheme.onPrimary,
        body: BlocConsumer<ForgetpasswordCubit, ForgetpasswordState>(
            listener: (context, state) async {
          if (state is ForgetpasswordErrorState) {
            print("error");
            SnackBar snackBar = SnackBar(
              content: Text(state.error),
              backgroundColor: ColorConstant.primary_color,
            );
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          }

          if (state is ForgetpasswordLoadingState) {
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
          if (state is ChangePasswordLoadedState) {
            if (state.changePasswordModel.success == true) {
              newpasswordController.clear();
              conformpasswordController.clear();

              SnackBar snackBar = SnackBar(
                content: Text("Password Change Successfully"),
                backgroundColor: ColorConstant.primary_color,
              );
              ScaffoldMessenger.of(context).showSnackBar(snackBar);

              Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
                builder: (context) {
                  return MultiBlocProvider(
                    providers: [
                      BlocProvider<LoginCubit>(
                        create: (context) => LoginCubit(),
                      ),
                      BlocProvider<DevicesInfoCubit>(
                        create: (context) => DevicesInfoCubit(),
                      ),
                    ],
                    child: LoginScreen(),
                  );
                },
              ), (route) => false);
            }
          }
          if (state is ChangePasswordInSettingScreenLoadedState) {
            SnackBar snackBar = SnackBar(
              content: Text(state.changePasswordModel.message.toString()),
              backgroundColor: ColorConstant.primary_color,
            );
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
            Navigator.pop(context);
          }
        }, builder: (context, state) {
          return Form(
            key: _formKey,
            child: Padding(
              padding: EdgeInsets.only(left: 35.0, right: 35),
              child: Column(children: [
                SizedBox(
                  height: 40,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "New Password",
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontFamily: "outfit",
                        fontSize: 14),
                  ),
                ),
                CustomTextFormField(
                  controller: newpasswordController,
                  textStyle: theme.textTheme.titleMedium!,
                  hintText: "New Password",
                  hintStyle: theme.textTheme.titleMedium!,
                  textInputType: TextInputType.visiblePassword,
                  errorMaxLines: 3,
                  validator: (value) {
                    String pattern =
                        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$%^&*(),.?":{}|<>])[A-Za-z0-9!@#\$%^&*(),.?":{}|<>]{8,}$';

                    if (value!.isEmpty) {
                      return 'Please Enter Password';
                    }

                    if (!RegExp(pattern).hasMatch(value)) {
                      return 'Password should contain at least 1 uppercase, 1 lowercase, 1 digit, 1 special character and be at least 8 characters long';
                    }

                    return null;
                  },
                  suffix: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
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
                  ),
                  suffixConstraints: BoxConstraints(maxHeight: 50),
                  obscureText: Show_Password ? true : false,
                  filled: true,
                  fillColor: appTheme.gray100,
                ),
                SizedBox(
                  height: 20,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Confirm Password",
                    overflow: TextOverflow.ellipsis,
                    // textAlign: TextAlign.left,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontFamily: "outfit",
                        fontSize: 14),
                  ),
                ),
                CustomTextFormField(
                  // focusNode: FocusNode(),
                  // autofocus: true,
                  controller: conformpasswordController,

                  textStyle: theme.textTheme.titleMedium!,
                  hintText: "Confirm Password",
                  hintStyle: theme.textTheme.titleMedium!,
                  textInputType: TextInputType.visiblePassword,
                  errorMaxLines: 3,
                  validator: (value) {
                    String pattern =
                        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$%^&*(),.?":{}|<>])[A-Za-z0-9!@#\$%^&*(),.?":{}|<>]{8,}$';

                    if (value!.isEmpty) {
                      return 'Please Enter Password';
                    }

                    if (!RegExp(pattern).hasMatch(value)) {
                      return 'Password should contain at least 1 uppercase, 1 lowercase, 1 digit, 1 special character and be at least 8 characters long';
                    }

                    return null;
                  },
                  suffix: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            Show_Passwordd = !Show_Passwordd;
                          });
                        },
                        child: Show_Passwordd
                            ? CustomImageView(
                                svgPath: ImageConstant.imgEye,
                              )
                            : Icon(
                                Icons.remove_red_eye_sharp,
                                color: Colors.grey,
                              ),
                      ),
                    ),
                  ),
                  suffixConstraints: BoxConstraints(maxHeight: 50),
                  obscureText: Show_Passwordd ? true : false,
                  filled: true,
                  fillColor: appTheme.gray100,
                ),
                SizedBox(
                  height: 30,
                ),
                GestureDetector(
                  onTap: () {
                    if (_formKey.currentState!.validate()) {
                      if (conformpasswordController.text !=
                          newpasswordController.text) {
                        SnackBar snackBar = SnackBar(
                          content: Text(
                              'New Password and Current Password are not same'),
                          backgroundColor: ColorConstant.primary_color,
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      } else {
                        if (widget.isProfile == true) {
                          print('this is condions');

                          var params = {
                            "uuid": userUid.toString(),
                            "password": conformpasswordController.text,
                          };
                          BlocProvider.of<ForgetpasswordCubit>(context)
                              .ChangepasswordinSetitngScreenwork(
                                  params, context);
                        } else {
                          var params = {
                            "mobileNo": widget.mobile.toString(),
                            "changePassword": conformpasswordController.text,
                          };

                          BlocProvider.of<ForgetpasswordCubit>(context)
                              .Changepassword(context, params);
                        }
                      }
                    }
                    /*    if (newpasswordController.text.isEmpty) {
                      SnackBar snackBar = SnackBar(
                        content: Text('Please Enter New Password'),
                        backgroundColor: ColorConstant.primary_color,
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    } else if (conformpasswordController.text.isEmpty) {
                      SnackBar snackBar = SnackBar(
                        content: Text('Please Enter Confirm Password'),
                        backgroundColor: ColorConstant.primary_color,
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    } else if (conformpasswordController.text !=
                        newpasswordController.text) {
                      SnackBar snackBar = SnackBar(
                        content: Text(
                            'New Password and Current Password are not same'),
                        backgroundColor: ColorConstant.primary_color,
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    } else {
                      if (widget.isProfile == true) {
                        print('this is condions');
                        var params = {
                          "uuid": userUid.toString(),
                          "password": conformpasswordController.text,
                        };
          
                        BlocProvider.of<ForgetpasswordCubit>(context)
                            .ChangepasswordinSetitngScreenwork(params, context);
                      } else {
                        var params = {
                          "mobileNo": widget.mobile,
                          "changePassword": conformpasswordController.text
                        };
          
                        BlocProvider.of<ForgetpasswordCubit>(context)
                            .Changepassword(params, context);
                      }
                    } */
                  },
                  child: Container(
                    height: 50,
                    width: _width / 1.2,
                    decoration: BoxDecoration(
                        color: Color(0XFFED1C25),
                        borderRadius: BorderRadius.circular(6)),
                    child: Center(
                        child: Text(
                      "Change Password",
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          color: Colors.white,
                          fontFamily: "outfit",
                          fontSize: 16),
                    )),
                  ),
                ),
              ]),
            ),
          );
        }));
  }

  SetData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    userUid = prefs.getString(
      PreferencesKey.loginUserID,
    );
    setState(() {});
  }
}
