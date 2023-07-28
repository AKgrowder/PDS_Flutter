import 'package:archit_s_application1/core/app_export.dart';
import 'package:archit_s_application1/widgets/custom_elevated_button.dart';
import 'package:archit_s_application1/widgets/custom_icon_button.dart';
import 'package:archit_s_application1/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

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

  TextEditingController emailoneController = TextEditingController();

  TextEditingController contactnoController = TextEditingController();
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
    return SafeArea(
      child: Scaffold(
        backgroundColor: theme.colorScheme.onPrimary,
        resizeToAvoidBottomInset: true,
        body: Form(
          key: _formKey,
          child: SizedBox(
            width: double.maxFinite,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    padding: getPadding(
                      top: 37,
                    ),
                    child: Padding(
                      padding: getPadding(
                        left: 30,
                        right: 30,
                        bottom: 19,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          CustomImageView(
                            imagePath: ImageConstant.imgImage248,
                            height: getVerticalSize(
                              37,
                            ),
                            width: getHorizontalSize(
                              140,
                            ),
                            alignment: Alignment.center,
                          ),
                          Align(
                            alignment: Alignment.center,
                            child: Padding(
                              padding: getPadding(top: 60, bottom: 25),
                              child: Text(
                                "Create Account",
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.left,
                                style: theme.textTheme.titleLarge,
                              ),
                            ),
                          ),
                          Container(
                            height: height / 15,
                            width: width / 1,
                            decoration: BoxDecoration(
                                color: Color(0xFFFFE7E7),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5))),
                            child: Padding(
                              padding: const EdgeInsets.only(
                                top: 15.0,
                                left: 10,
                              ),
                              child: Text(
                                "Personal Details",
                                style: TextStyle(
                                    fontFamily: 'outfit',
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.center,
                            child: Container(
                              height: getSize(
                                130,
                              ),
                              width: getSize(
                                130,
                              ),
                              margin: getMargin(
                                top: 22,
                              ),
                              child: Stack(
                                alignment: Alignment.bottomRight,
                                children: [
                                  CustomImageView(
                                    imagePath: ImageConstant.imgRectangle39829,
                                    height: getSize(
                                      130,
                                    ),
                                    width: getSize(
                                      130,
                                    ),
                                    radius: BorderRadius.circular(
                                      getHorizontalSize(
                                        65,
                                      ),
                                    ),
                                    alignment: Alignment.center,
                                  ),
                                  CustomIconButton(
                                    height: 33,
                                    width: 33,
                                    padding: getPadding(
                                      all: 8,
                                    ),
                                    alignment: Alignment.bottomRight,
                                    child: GestureDetector(
                                      onTap: () {
                                        pickImage();
                                      },
                                      child: CustomImageView(
                                        svgPath: ImageConstant.imgCamera,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: getPadding(
                              top: 18,
                            ),
                            child: Text(
                              "User ID",
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.left,
                              style: theme.textTheme.bodyLarge,
                            ),
                          ),
                          CustomTextFormField(
                            // focusNode: FocusNode(),
                            // autofocus: true,
                            controller: enteruseridController,
                            margin: getMargin(
                              top: 4,
                            ),
                            contentPadding: getPadding(
                              left: 12,
                              top: 14,
                              right: 12,
                              bottom: 14,
                            ),
                            textStyle: theme.textTheme.titleMedium!,
                            hintText: "Enter User ID",
                            hintStyle: theme.textTheme.titleMedium!,
                            textInputAction: TextInputAction.next,
                            filled: true,
                            fillColor: appTheme.gray100,
                          ),
                          Padding(
                            padding: getPadding(
                              top: 20,
                            ),
                            child: Text(
                              "Your Name",
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.left,
                              style: theme.textTheme.bodyLarge,
                            ),
                          ),
                          CustomTextFormField(
                            // focusNode: FocusNode(),
                            // autofocus: true,
                            controller: nameController,
                            margin: getMargin(
                              top: 4,
                            ),
                            contentPadding: getPadding(
                              left: 12,
                              top: 14,
                              right: 12,
                              bottom: 14,
                            ),
                            textStyle: theme.textTheme.titleMedium!,
                            hintText: "Enter name",
                            hintStyle: theme.textTheme.titleMedium!,
                            textInputAction: TextInputAction.next,
                            filled: true,
                            fillColor: appTheme.gray100,
                          ),
                          Padding(
                            padding: getPadding(
                              top: 19,
                            ),
                            child: Text(
                              "Email",
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.left,
                              style: theme.textTheme.bodyLarge,
                            ),
                          ),
                          CustomTextFormField(
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
                            maxLength: isPhone == true ? 10 : 30,
                            // focusNode: FocusNode(),
                            controller: emailAndMobileController,
                            margin: getMargin(
                              left: 0,
                              right: 0,
                            ),
                            contentPadding: getPadding(
                              left: 12,
                              top: 14,
                              right: 12,
                              bottom: 14,
                            ),
                            textStyle: theme.textTheme.titleMedium!,
                            hintText: "Email address",
                            hintStyle: theme.textTheme.titleMedium!,
                            textInputAction: TextInputAction.next,
                            textInputType: TextInputType.emailAddress,
                            filled: true,
                            fillColor: appTheme.gray100,
                          ),
                          Padding(
                            padding: getPadding(
                              top: 19,
                            ),
                            child: Text(
                              "Contact no.",
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.left,
                              style: theme.textTheme.bodyLarge,
                            ),
                          ),
                          CustomTextFormField(
                      onChanged: (value) {
                        print("onchange");
                        final RegExp regex = RegExp('[a-zA-Z]');
                        if (contectnumberController.text == null ||
                            contectnumberController.text.isEmpty ||
                            !regex.hasMatch(contectnumberController.text)) {
                          setState(() {
                            isPhonee = true;
                          });
                        } else {
                          setState(() {
                            isPhonee = false;
                          });
                        }
                      },
                      maxLength: isPhonee== true ? 10 : 30,
                      // focusNode: FocusNode(),
                      controller: contectnumberController,
                       margin: getMargin(
                      left: 0,
          
                      right: 0,
                    ),
                    contentPadding: getPadding(
                      left: 12,
                      top: 14,
                      right: 12,
                      bottom: 14,
                    ),
                    textStyle: theme.textTheme.titleMedium!,
                    hintText: "Contact no.",
                    hintStyle: theme.textTheme.titleMedium!,
                    textInputAction: TextInputAction.next,
                    textInputType: TextInputType.emailAddress,
                    filled: true,
                    fillColor: appTheme.gray100,
                    ),
                          Padding(
                            padding: getPadding(
                              top: 19,
                            ),
                            child: Text(
                              "Set Password",
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
                            controller: passwordController,
                            margin: getMargin(
                              top: 5,
                            ),
                            contentPadding: getPadding(
                              left: 20,
                              top: 14,
                              bottom: 14,
                            ),
                            textStyle: theme.textTheme.titleMedium!,
                            hintText: "Password",
                            hintStyle: theme.textTheme.titleMedium!,
                            textInputType: TextInputType.visiblePassword,
                            suffix: Container(
                              margin: getMargin(
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
                            suffixConstraints: BoxConstraints(
                              maxHeight: getVerticalSize(
                                50,
                              ),
                            ),
                            obscureText: Show_Password ? true : false,
                            filled: true,
                            fillColor: appTheme.gray100,
                          ),
                          CustomElevatedButton(
                            text: "Submit",
                            margin: getMargin(
                              top: 18,
                            ),
                            buttonStyle: ButtonThemeHelper.outlineOrangeA7000c
                                .copyWith(
                                    fixedSize:
                                        MaterialStateProperty.all<Size>(Size(
                              double.maxFinite,
                              getVerticalSize(
                                50,
                              ),
                            ))),
                            buttonTextStyle:
                                TextThemeHelper.titleMediumOnPrimary,
                          ),
                          Align(
                            alignment: Alignment.center,
                            child: Container(
                              width: getHorizontalSize(
                                330,
                              ),
                              margin: getMargin(
                                left: 11,
                                top: 16,
                                right: 11,
                              ),
                              child: RichText(
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text:
                                          "By Submitting you are agreeing to ",
                                      style: TextStyle(
                                        color: appTheme.black900,
                                        fontSize: getFontSize(
                                          14,
                                        ),
                                        fontFamily: 'Outfit',
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    TextSpan(
                                      text:
                                          "Terms & Conditions  Privacy & Policy  of PDS Terms",
                                      style: TextStyle(
                                        color: theme.colorScheme.primary,
                                        fontSize: getFontSize(
                                          14,
                                        ),
                                        fontFamily: 'Outfit',
                                        fontWeight: FontWeight.w500,
                                        decoration: TextDecoration.underline,
                                      ),
                                    ),
                                  ],
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
