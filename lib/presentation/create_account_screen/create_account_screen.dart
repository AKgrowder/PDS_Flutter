import 'package:archit_s_application1/API/Bloc/auth/register_Block.dart';
import 'package:archit_s_application1/API/Bloc/auth/register_state.dart';
import 'package:archit_s_application1/core/app_export.dart';
import 'package:archit_s_application1/core/utils/color_constant.dart';
import 'package:archit_s_application1/core/utils/sharedPreferences.dart';
import 'package:archit_s_application1/presentation/otp_verification_screen/otp_verification_screen.dart';
import 'package:archit_s_application1/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CreateAccountScreen extends StatefulWidget {
  CreateAccountScreen({Key? key})
      : super(
          key: key,
        );

  @override
  State<CreateAccountScreen> createState() => _CreateAccountScreenState();
}

class _CreateAccountScreenState extends State<CreateAccountScreen> {
  TextEditingController personaldetailsController = TextEditingController();
  TextEditingController enteruseridController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailAndMobileController = TextEditingController();
  TextEditingController contectnumberController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool Show_Password = true;
  bool isPhone = false;
  bool isPhonee = false;
  Future pickImage() async {
    ImagePicker().pickImage(source: ImageSource.gallery);
  }

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    double _height = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        // backgroundColor: theme.colorScheme.onPrimary,
        resizeToAvoidBottomInset: true,
        body: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    left: 30,
                    right: 30,
                    bottom: 19,
                  ),
                  child: BlocProvider<RegisterCubit>(
                      create: (context) => RegisterCubit(),
                      child: BlocConsumer<RegisterCubit, RegisterState>(
                        listener: (context, state) {
                          if (state is RegisterErrorState) {
                            print("error");
                            SnackBar snackBar = SnackBar(
                              content: Text(state.error),
                              backgroundColor: ColorConstant.primary_color,
                            );
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                          }
                          if (state is RegisterLoadingState) {
                            print("loading");
                            Center(
                              child: Container(
                                margin: EdgeInsets.only(bottom: 100),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: Image.asset(ImageConstant.loader,
                                      fit: BoxFit.cover,
                                      height: 100.0,
                                      width: 100),
                                ),
                              ),
                            );
                          }
                          if (state is RegisterLoadedState) {
                            dataSet(state.registerClass.success);
                            SnackBar snackBar = SnackBar(
                              content: Text(state.registerClass.message ?? ""),
                              backgroundColor: ColorConstant.primary_color,
                            );
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => OtpVerificationScreen(
                                        phonNumber:
                                            contectnumberController.text,
                                        flowCheck: 'Rgister',
                                      )),
                            );
                          }
                        },
                        builder: (context, state) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              CustomImageView(
                                imagePath: ImageConstant.imgImage248,
                                height: 37,
                                alignment: Alignment.center,
                              ),
                              Container(
                                alignment: Alignment.center,
                                height: 70,
                                child: Text(
                                  "Create Account",
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      fontFamily: 'outfit',
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                  // style: theme.textTheme.titleLarge,
                                ),
                              ),
                              Container(
                                height: _height / 15,
                                width: _width / 1,
                                decoration: BoxDecoration(
                                    color: Color(0xFFFFE7E7),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5))),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                    top: 20.0,
                                    left: 10,
                                  ),
                                  child: Text(
                                    "Personal Details",
                                    style: TextStyle(
                                        fontFamily: 'outfit',
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15),
                                  ),
                                ),
                              ),
                              Align(
                                alignment: Alignment.center,
                                child: Container(
                                  height: 130,
                                  width: 130,
                                  margin: EdgeInsets.only(
                                    top: 20,
                                  ),
                                  child: Stack(
                                    alignment: Alignment.bottomRight,
                                    children: [
                                      CustomImageView(
                                        imagePath:
                                            ImageConstant.imgRectangle39829,
                                        height: 130,
                                        width: 130,
                                        radius: BorderRadius.circular(65),
                                        alignment: Alignment.center,
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          pickImage();
                                        },
                                        child: Container(
                                          height: 50,
                                          width: 30,
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              // color: Colors.red,
                                              shape: BoxShape.circle),
                                          child: CustomImageView(
                                            svgPath: ImageConstant.imgCamera,
                                            alignment: Alignment.center,
                                          ),
                                          // child: CustomIconButton(
                                          //   height: 33,
                                          //   width: 33,
                                          //   alignment: Alignment.bottomRight,
                                          //   child: GestureDetector(
                                          //     onTap: () {
                                          //       pickImage();
                                          //     },
                                          //     child: CustomImageView(
                                          //       svgPath: ImageConstant.imgCamera,
                                          //     ),
                                          //   ),
                                          // ),
                                        ),
                                      ),

                                      // CustomIconButton(
                                      //   height: 33,+-----+-
                                      //   width: 33,
                                      //   alignment: Alignment.bottomRight,
                                      //   child: GestureDetector(
                                      //     onTap: () {
                                      //       pickImage();
                                      //     },
                                      //     child: CustomImageView(
                                      //       svgPath: ImageConstant.imgCamera,
                                      //     ),
                                      //   ),
                                      // ),
                                    ],
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                  top: 18,
                                ),
                                child: Text(
                                  "User ID",
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    fontFamily: 'outfit',
                                    fontWeight: FontWeight.w500,
                                  ),
                                  // style: theme.textTheme.bodyLarge,
                                ),
                              ),
                              CustomTextFormField(
                                // focusNode: FocusNode(),
                                // autofocus: true,
                                controller: enteruseridController,
                                margin: EdgeInsets.only(
                                  top: 4,
                                ),
                                contentPadding: EdgeInsets.only(
                                  left: 12,
                                  top: 14,
                                  right: 12,
                                  bottom: 14,
                                ),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Please Enter User Id';
                                  } else if (!RegExp(r'^[a-zA-Z0-9._]+$')
                                      .hasMatch(value)) {
                                    return 'Input cannot contains prohibited special characters';
                                  } else if (value.length < 1 ||
                                      value.length > 50) {
                                    return 'userId length is between 1 and 50 characters';
                                  }
                                  return null;
                                },
                                // textStyle: theme.textTheme.titleMedium!,
                                hintText: "Enter User ID",
                                // hintStyle: theme.textTheme.titleMedium!,
                                textInputAction: TextInputAction.next,
                                filled: true,
                                maxLength: 50,
                                fillColor: appTheme.gray100,
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                  top: 20,
                                ),
                                child: Text(
                                  "Your Name",
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    fontFamily: 'outfit',
                                    fontWeight: FontWeight.w500,
                                  ),

                                  // style: theme.textTheme.bodyLarge,
                                ),
                              ),
                              CustomTextFormField(
                                validator: (value) {
                                  final RegExp nameRegExp = RegExp(
                                      r"^[a-zA-Z]+(([',. -][a-zA-Z ])?[a-zA-Z]*)*$");
                                  if (value!.isEmpty) {
                                    return 'Please Enter Name';
                                  } else if (!nameRegExp.hasMatch(value)) {
                                    return 'Input cannot contains prohibited special characters';
                                  } else if (value.length < 1 ||
                                      value.length > 50) {
                                    return 'username length is between 1 and 50 characters';
                                  } else if (value.contains('..')) {
                                    return 'username does not contain is correct';
                                  }

                                  return null;
                                },
                                // focusNode: FocusNode(),
                                // autofocus: true,
                                controller: nameController,
                                margin: EdgeInsets.only(
                                  top: 4,
                                ),
                                contentPadding: EdgeInsets.only(
                                  left: 12,
                                  top: 14,
                                  right: 12,
                                  bottom: 14,
                                ),
                                // textStyle: theme.textTheme.titleMedium!,
                                hintText: "Enter name",
                                // hintStyle: theme.textTheme.titleMedium!,
                                textInputAction: TextInputAction.next,
                                filled: true,
                                  maxLength: 50,
                                fillColor: appTheme.gray100,
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                  top: 19,
                                ),
                                child: Text(
                                  "Email",
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    fontFamily: 'outfit',
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              CustomTextFormField(
                                validator: (value) {
                                  final RegExp emailRegExp = RegExp(
                                      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');

                                  if (value!.isEmpty) {
                                    return 'Please Enter Email';
                                  } else if (!emailRegExp.hasMatch(value)) {
                                    return 'please Enter vaild Email';
                                  }
                                  return null;
                                },
                                onChanged: (value) {
                                  print("onchange");
                                  final RegExp regex = RegExp('[a-zA-Z]');
                                  if (emailAndMobileController.text == null ||
                                      emailAndMobileController.text.isEmpty ||
                                      !regex.hasMatch(
                                          emailAndMobileController.text)) {
                                    setState(() {
                                      isPhone = true;
                                    });
                                  } else {
                                    setState(() {
                                      isPhone = false;
                                    });
                                  }
                                },
                                maxLength: isPhone == true ? 10 : 50,
                                // focusNode: FocusNode(),
                                controller: emailAndMobileController,
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
                                hintText: "Email address",
                                // hintStyle: theme.textTheme.titleMedium!,
                                textInputAction: TextInputAction.next,
                                textInputType: TextInputType.emailAddress,
                                filled: true,
                                
                                   
                                
                                fillColor: appTheme.gray100,
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                  top: 19,
                                ),
                                child: Text(
                                  "Contact no.",
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    
                                    fontFamily: 'outfit',
                                  ),
                                  // style: theme.textTheme.bodyLarge,
                                ),
                              ),
                              CustomTextFormField(
                                validator: (value) {
                                  final RegExp phoneRegExp =
                                      RegExp(r'^(?!0+$)[0-9]{10}$');

                                  if (value!.isEmpty) {
                                    return 'Please Enter phonNumber';
                                  } else if (!phoneRegExp.hasMatch(value)) {
                                    return 'Invalid phone number.';
                                  }
                                  return null;
                                },
                                onChanged: (value) {
                                  print("onchange");
                                  final RegExp regex = RegExp('[a-zA-Z]');
                                  if (contectnumberController.text == null ||
                                      contectnumberController.text.isEmpty ||
                                      !regex.hasMatch(
                                          contectnumberController.text)) {
                                    setState(() {
                                      isPhonee = true;
                                    });
                                  } else {
                                    setState(() {
                                      isPhonee = false;
                                    });
                                  }
                                },
                                maxLength: isPhonee == true ? 10 : 30,
                                // focusNode: FocusNode(),
                                controller: contectnumberController,
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
                                hintText: "Contact no.",
                                // hintStyle: theme.textTheme.titleMedium!,
                                textInputAction: TextInputAction.next,
                                textInputType: TextInputType.emailAddress,
                                filled: true,
                                fillColor: appTheme.gray100,
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                  top: 19,
                                ),
                                child: Text(
                                  "Set Password",
                                  overflow: TextOverflow.ellipsis,
                                  // textAlign: TextAlign.left,
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black,
                                      fontFamily: "outfit",
                                      fontSize: 14),
                                ),
                              ),
                              CustomTextFormField(
                                maxLength: 50,
                                inputFormatters: [
                                  FilteringTextInputFormatter.deny(
                                      RegExp(r'\s')),
                                ],
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
                                controller: passwordController,
                                margin: EdgeInsets.only(
                                  top: 5,
                                ),
                                contentPadding: EdgeInsets.only(
                                  left: 20,
                                  top: 14,
                                  bottom: 14,
                                ),
                                // textStyle: theme.textTheme.titleMedium!,
                                hintText: "Password",
                                // hintStyle: theme.textTheme.titleMedium!,
                                textInputType: TextInputType.visiblePassword,
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
                                suffixConstraints:
                                    BoxConstraints(maxHeight: 50),
                                obscureText: Show_Password ? true : false,
                                filled: true,
                                fillColor: appTheme.gray100,
                              ),
                              GestureDetector(
                                onTap: () {
                                  if (_formKey.currentState!.validate()) {
                                    var datapPassing = {
                                      "name": nameController.text,
                                      "userName": enteruseridController.text,
                                      "email": emailAndMobileController.text,
                                      "mobileNo": contectnumberController.text,
                                      "password": passwordController.text,
                                      "module": "EMPLOYEE"
                                    };
                                    print('dataoassing-$datapPassing');
                                    BlocProvider.of<RegisterCubit>(context)
                                        .registerApi(datapPassing);
                                  }
                                },
                                child: Container(
                                  alignment: Alignment.center,
                                  margin: EdgeInsets.only(top: 15),
                                  height: 50,
                                  width: _width,
                                  decoration: BoxDecoration(
                                      color: Color(0xffED1C25),
                                      borderRadius: BorderRadius.circular(5)),
                                  child: Text(
                                    'Submit',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: 'outfit',
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                              ),
                              // CustomElevatedButton(
                              //   onTap: () {
                              //     if (_formKey.currentState!.validate()) {
                              //       var datapPassing = {
                              //         "name": nameController.text,
                              //         "userName": nameController.text,
                              //         "email": emailAndMobileController.text,
                              //         "mobileNo": contectnumberController.text,
                              //         "password": passwordController.text,
                              //         "module": "EMPLOYEE"
                              //       };
                              //       print('dataoassing-$datapPassing');
                              //       BlocProvider.of<RegisterCubit>(context)
                              //           .registerApi(datapPassing);
                              //     }
                              //   },
                              //   text: "Submit",
                              //   margin: EdgeInsets.only(
                              //     top: 18,
                              //   ),
                              //   buttonStyle: ButtonThemeHelper
                              //       .outlineOrangeA7000c
                              //       .copyWith(
                              //           fixedSize:
                              //               MaterialStateProperty.all<Size>(
                              //                   Size(double.maxFinite, 50))),
                              //   buttonTextStyle:
                              //       TextThemeHelper.titleMediumOnPrimary,
                              // ),
                              Align(
                                // alignment: Alignment.center,
                                child: Container(
                                  // width: 330,
                                  margin: EdgeInsets.only(
                                    left: 10,
                                    top: 16,
                                    right: 10,
                                  ),
                                  child: RichText(
                                    text: TextSpan(
                                      children: [
                                        TextSpan(
                                          text:
                                              "By Submitting you are agreeing to ",
                                          style: TextStyle(
                                            color: appTheme.black900,
                                            fontSize: 14,
                                            fontFamily: 'Outfit',
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        TextSpan(
                                          text:
                                              "Terms & Conditions  Privacy & Policy  of PDS Terms",
                                          style: TextStyle(
                                            color: theme.colorScheme.primary,
                                            fontSize: 14,
                                            fontFamily: 'Outfit',
                                            fontWeight: FontWeight.w500,
                                            decoration:
                                                TextDecoration.underline,
                                          ),
                                        ),
                                      ],
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      )),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  dataSet(bool? success) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(PreferencesKey.registerSuccess, success!);
  }
}
