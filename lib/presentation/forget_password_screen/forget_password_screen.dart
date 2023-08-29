import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pds/API/Bloc/Forget_password_Bloc/forget_password_cubit.dart';
import 'package:pds/API/Bloc/Forget_password_Bloc/forget_password_state.dart';
import 'package:pds/API/Bloc/auth/otp_block.dart';
import 'package:pds/core/app_export.dart';
import 'package:pds/presentation/otp_verification_screen/otp_verification_screen.dart';
import 'package:pds/widgets/app_bar/appbar_image.dart';
import 'package:pds/widgets/app_bar/custom_app_bar.dart';
import 'package:pds/widgets/custom_elevated_button.dart';
import 'package:pds/widgets/custom_text_form_field.dart';

import '../../API/Model/forget_password_model/forget_password_model.dart';
import '../../core/utils/color_constant.dart';

// ignore_for_file: must_be_immutable
class ForgetPasswordScreen extends StatefulWidget {
  ForgetPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController contectnumberrController = TextEditingController();
  bool isPhonee = false;
  ForgetPasswordModel? forgetPasswordmodel;

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    double _height = MediaQuery.of(context).size.height;
    return SafeArea(
        child: Scaffold(
            backgroundColor: theme.colorScheme.onPrimary,
            resizeToAvoidBottomInset: false,
            appBar: CustomAppBar(
                height: 89,
                leadingWidth: 54,
                leading: AppbarImage(
                    height: 23,
                    width: 24,
                    svgPath: ImageConstant.imgArrowleft,
                    margin: EdgeInsets.only(
                        left: 30, top: 13, bottom: 19, right: 5),
                    onTap: () {
                      onTapArrowleft1(context);
                    }),
                centerTitle: true,
                title: Text("Forget Password",
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        fontFamily: 'outfit',
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black))),
            body: BlocConsumer<ForgetpasswordCubit, ForgetpasswordState>(
              listener: (context, state) {
                if (state is ForgetpasswordErrorState) {
                  SnackBar snackBar = SnackBar(
                    content: Text(state.error),
                    backgroundColor: ColorConstant.primary_color,
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                }

                if (state is ForgetpasswordLoadingState) {
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
                if (state is ForgetpasswordLoadedState) {
                    Navigator.pop(context);
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return MultiBlocProvider(
                        providers: [
                          BlocProvider<OtpCubit>(
                            create: (context) => OtpCubit(),
                          )
                        ],
                        child: OtpVerificationScreen(
                          phonNumber: contectnumberrController.text,
                          otp_verfiaction: true,
                        ));
                  }));
                  SnackBar snackBar = SnackBar(
                    content: Text(state.Forgetpassword.message.toString()),
                    backgroundColor: ColorConstant.primary_color,
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                }
              },
              builder: (context, state) {
                return Form(
                    key: _formKey,
                    child: Container(
                        width: double.maxFinite,
                        padding: EdgeInsets.only(left: 30, right: 30),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Center(
                                child: Text(
                                  "OTP will be sent to Registered Mobile Number",
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      fontFamily: 'outfit',
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.grey),
                                  // style: TextThemeHelper.bodyMediumBlack900
                                ),
                              ),
                              Padding(
                                  padding: EdgeInsets.only(top: 35),
                                  child: Text(
                                    "Enter Registered Mobile Number",
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        fontFamily: 'outfit',
                                        fontSize: 13,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.black),
                                  )),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  Container(
                                    height: 45,
                                    width: 45,
                                    decoration: BoxDecoration(
                                        color: Colors.grey.shade300,
                                        borderRadius: BorderRadius.circular(6)),
                                    child: Center(
                                        child: Text(
                                      "+91",
                                      style: TextStyle(
                                          // fontFamily: 'outfit',
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold),
                                    )),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Container(
                                    width: _width / 1.4,
                                    child: CustomTextFormField(
                                      validator: (value) {
                                        final RegExp phoneRegExp =
                                            RegExp(r'^(?!0+$)[0-9]{10}$');
                                        if (value!.isEmpty) {
                                          return 'Please Enter Mobile Number';
                                        } else if (!phoneRegExp
                                            .hasMatch(value)) {
                                          return 'Invalid Mobile Number';
                                        }
                                        return null;
                                      },
                                      onChanged: (value) {
                                        print("onchange");
                                        final RegExp regex = RegExp('[a-zA-Z]');
                                        if (contectnumberrController
                                                .text.isEmpty ||
                                            !regex.hasMatch(
                                                contectnumberrController
                                                    .text)) {
                                          setState(() {
                                            isPhonee = true;
                                          });
                                        } else {
                                          setState(() {
                                            isPhonee = false;
                                          });
                                        }
                                      },
                                      maxLength: isPhonee == true ? 10 : 50,
                                      // focusNode: FocusNode(),
                                      controller: contectnumberrController,
                                      margin: EdgeInsets.only(
                                        left: 0,
                                        right: 0,
                                      ),
                                      contentPadding: EdgeInsets.only(
                                        left: 12,
                                        top: 14,
                                        right: 12,
                                        bottom: 14,
                                      ),
                                      // textStyle: theme.textTheme.titleMedium!,
                                      hintText: "Mobile Number",
                                      filled: true,
                                      fillColor: appTheme.gray100,
                                      textInputAction: TextInputAction.next,
                                      textInputType: TextInputType.number,
                                      inputFormatters: [
                                        FilteringTextInputFormatter.digitsOnly
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              CustomElevatedButton(
                                onTap: () {
                                  if (contectnumberrController.text.isEmpty) {
                                    SnackBar snackBar = SnackBar(
                                      content: Text(
                                        'Please Enter Mobile Number',
                                      ),
                                      backgroundColor:
                                          ColorConstant.primary_color,
                                    );
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(snackBar);
                                  } else {
                                    BlocProvider.of<ForgetpasswordCubit>(
                                            context)
                                        .Forgetpassword(
                                            contectnumberrController.text,
                                            context);
                                    // Navigator.push(
                                    //     context,

                                    // MultiBlocProvider(
                                    //                           providers: [
                                    //                             BlocProvider<FetchAllPublicRoomCubit>(
                                    //                               create: (context) => FetchAllPublicRoomCubit(),
                                    //                             ),
                                    //                             BlocProvider<CreatPublicRoomCubit>(
                                    //                               create: (context) => CreatPublicRoomCubit(),
                                    //                             ),
                                    //                             BlocProvider<senMSGCubit>(
                                    //                               create: (context) => senMSGCubit(),
                                    //                             ),
                                    //                             BlocProvider<RegisterCubit>(
                                    //                               create: (context) => RegisterCubit(),
                                    //                             ),
                                    //                             BlocProvider<GetAllPrivateRoomCubit>(
                                    //                               create: (context) => GetAllPrivateRoomCubit(),
                                    //                             ),
                                    //                             BlocProvider<InvitationCubit>(
                                    //                               create: (context) => InvitationCubit(),
                                    //                             ),
                                    //                           ],
                                    //                           child: BottombarPage(
                                    //                             buttomIndex: 0,
                                    //                           ));

                                    // MaterialPageRoute(
                                    //     builder: (context) =>
                                    //         OtpVerificationScreen(
                                    //           forgetpassword: true,
                                    //           phonNumber:
                                    //               contectnumberrController
                                    //                   .text,
                                    //         ))
                                    // );
                                  }
                                },
                                text: "Send OTP",
                                margin: EdgeInsets.only(top: 51, bottom: 5),
                                buttonStyle: ButtonThemeHelper
                                    .outlineOrangeA7000c
                                    .copyWith(
                                        fixedSize:
                                            MaterialStateProperty.all<Size>(
                                                Size(double.infinity, 50))),
                                buttonTextStyle: TextStyle(
                                    fontFamily: 'outfit',
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              )
                            ])));
              },
            )));
  }

  /// Navigates back to the previous screen.
  ///
  /// This function takes a [BuildContext] object as a parameter, which is used
  /// to navigate back to the previous screen.
  onTapArrowleft1(BuildContext context) {
    Navigator.pop(context);
  }
}
