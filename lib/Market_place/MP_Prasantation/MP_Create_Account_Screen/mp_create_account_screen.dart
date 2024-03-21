import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pds/core/utils/image_constant.dart';
import 'package:pds/presentation/policy_of_company/policy_screen.dart';

import '../../../core/utils/color_constant.dart';
import '../../../presentation/policy_of_company/privecy_policy.dart';
import '../../../theme/theme_helper.dart';
import '../../../widgets/custom_image_view.dart';
import '../../../widgets/custom_text_form_field.dart';

class CaPershonalDetailScreen extends StatefulWidget {
  const CaPershonalDetailScreen({Key? key}) : super(key: key);

  @override
  State<CaPershonalDetailScreen> createState() =>
      _CaPershonalDetailScreenState();
}

class _CaPershonalDetailScreenState extends State<CaPershonalDetailScreen> {
  bool isPhonee = false;
  bool Show_Password = true;
  bool isChecked = false;

  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController mobilenumberController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController referralcodeController = TextEditingController();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool SubmitOneTime = false;

  @override
  Widget build(BuildContext context) {
    var _height = MediaQuery.of(context).size.height;
    var _width = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back,
            color: Colors.grey,
          ),
        ),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 25.0, right: 25),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Center(
                child: Text(
                  "Create Account",
                  style: TextStyle(
                      fontFamily: 'outfit',
                      fontSize: 20,
                      fontWeight: FontWeight.w500),
                ),
              ),
              Divider(
                color: ColorConstant.primary_color,
                indent: 80,
                endIndent: 80,
                thickness: 1.5,
              ),
              SizedBox(
                height: 20,
              ),
              Image.asset(ImageConstant.createaccount),
              SizedBox(
                height: 20,
              ),
              Text(
                "Create Account",
                style: TextStyle(
                    fontFamily: 'outfit',
                    fontSize: 20,
                    fontWeight: FontWeight.w500),
              ),
              Divider(
                color: ColorConstant.primary_color,
                // indent: 80,
                endIndent: 220,
                thickness: 1,
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "Personal Details",
                style: TextStyle(
                    fontFamily: 'outfit',
                    fontSize: 15,
                    color: ColorConstant.primary_color,
                    fontWeight: FontWeight.w500),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "User Name",
                style: TextStyle(
                    fontFamily: 'outfit',
                    fontSize: 15,
                    color: Colors.black,
                    fontWeight: FontWeight.w500),
              ),
              CustomTextFormField(
                // focusNode: FocusNode(),
                // autofocus: true,

                controller: usernameController,
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
                  RegExp nameRegExp = RegExp(r"^[a-zA-Z0-9\s'@]+$");
                  if (value!.isEmpty) {
                    return 'Please Enter User Name';
                  } else if (!nameRegExp.hasMatch(value)) {
                    return 'Input cannot contains prohibited special characters';
                  } else if (value.length <= 0 || value.length > 50) {
                    return 'Minimum length required';
                  } else if (value.contains('..')) {
                    return 'username does not contain is correct';
                  }

                  return null;
                },

                hintText: "User Name",

                textInputAction: TextInputAction.next,
                filled: true,
                maxLength: 100,
                fillColor: appTheme.gray100,
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "Email",
                style: TextStyle(
                    fontFamily: 'outfit',
                    fontSize: 15,
                    color: Colors.black,
                    fontWeight: FontWeight.w500),
              ),
              CustomTextFormField(
                // focusNode: FocusNode(),
                // autofocus: true,

                controller: emailController,
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
                  final RegExp emailRegExp = RegExp(
                      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');

                  if (value!.isEmpty) {
                    return 'Please Enter Email';
                  } else if (!emailRegExp.hasMatch(value)) {
                    return 'please Enter vaild Email';
                  }
                  return null;
                },

                hintText: "Email",

                textInputAction: TextInputAction.next,
                filled: true,
                maxLength: 100,
                fillColor: appTheme.gray100,
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "Mobile Number",

                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 15,
                  color: Colors.black,
                  fontFamily: 'outfit',
                ),
                // style: theme.textTheme.bodyLarge,
              ),
              Row(
                children: [
                  Container(
                    height: 45,
                    width: 45,
                    decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(6)),
                    child: Center(
                        child: Text(
                      "+91",
                      style: TextStyle(
                          // fontFamily: 'outfit',
                          fontSize: 15,
                          fontWeight: FontWeight.w400),
                    )),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Container(
                    width: _width - 100,
                    child: CustomTextFormField(
                      validator: (value) {
                        final RegExp phoneRegExp = RegExp(r'^[6-9]\d{9}$');
                        if (value!.isEmpty) {
                          return 'Please Enter Mobile Number';
                        } else if (!phoneRegExp.hasMatch(value)) {
                          return 'Invalid Mobile Number';
                        }
                        return null;
                      },
                      onChanged: (value) {
                        print("onchange");
                        final RegExp regex = RegExp('[a-zA-Z]');
                        if (mobilenumberController.text == null ||
                            mobilenumberController.text.isEmpty ||
                            !regex.hasMatch(mobilenumberController.text)) {
                          if (this.mounted) {
                            super.setState(() {
                              isPhonee = true;
                            });
                          }
                        } else {
                          if (this.mounted) {
                            super.setState(() {
                              isPhonee = false;
                            });
                          }
                        }
                      },
                      maxLength: isPhonee == true ? 10 : 50,
                      // focusNode: FocusNode(),
                      controller: mobilenumberController,
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
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "Sales Referral Code",
                style: TextStyle(
                    fontFamily: 'outfit',
                    fontSize: 15,
                    color: Colors.black,
                    fontWeight: FontWeight.w500),
              ),
              CustomTextFormField(
                // focusNode: FocusNode(),
                // autofocus: true,

                controller: referralcodeController,
                margin: EdgeInsets.only(
                  top: 4,
                ),
                contentPadding: EdgeInsets.only(
                  left: 12,
                  top: 14,
                  right: 12,
                  bottom: 14,
                ),

                /* validator: (value) {
                  RegExp nameRegExp = RegExp(r"^[a-zA-Z0-9\s'@]+$");
                  if (value!.isEmpty) {
                    return 'Please Enter Referral Code';
                  } else if (!nameRegExp.hasMatch(value)) {
                    return 'Input cannot contains prohibited special characters';
                  } else if (value.length <= 0 || value.length > 50) {
                    return 'Minimum length required';
                  } else if (value.contains('..')) {
                    return 'Referral Code not contain is correct';
                  }

                  return null;
                }, */

                hintText: "Sales Referral Code",

                textInputAction: TextInputAction.next,
                filled: true,
                maxLength: 100,
                fillColor: appTheme.gray100,
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "Set Password",
                style: TextStyle(
                    fontFamily: 'outfit',
                    fontSize: 15,
                    color: Colors.black,
                    fontWeight: FontWeight.w500),
              ),
              CustomTextFormField(
                maxLength: 50,
                inputFormatters: [
                  FilteringTextInputFormatter.deny(RegExp(r'\s')),
                ],
                errorMaxLines: 3,
                // focusNode: FocusNode(),
                // autofocus: true,

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
                      if (this.mounted) {
                        super.setState(() {
                          Show_Password = !Show_Password;
                        });
                      }
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
                filled: true,

                fillColor: appTheme.gray100,
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  SizedBox(
                    height: 5,
                    child: Checkbox(
                      activeColor: ColorConstant.primary_color,
                      visualDensity: VisualDensity(
                        horizontal:
                            -4.0, // Adjust this value to change the size
                        vertical: -2.0, // Adjust this value to change the size
                      ),
                      checkColor: Colors.white,
                      value: isChecked,
                      onChanged: (bool? value) {
                        super.setState(() {
                          isChecked = value!;
                        });
                      },
                    ),
                  ),
                  Text(
                    "By Submitting you are agreeing to",
                    style: TextStyle(
                      fontSize: 12,
                      fontFamily: 'outfit',
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Policies(
                              title: " ",
                              data: Policy_Data.turms_of_use,
                            ),
                          ));
                    },
                    child: Text(
                      "Terms of Use ",
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: theme.colorScheme.primary,
                        // fontSize: _width / 34,
                        fontSize: 10,
                        fontFamily: 'Outfit',
                        fontWeight: FontWeight.w500,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                  Text(
                    "&",
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: theme.colorScheme.primary,
                      // fontSize: _width / 34,
                      fontSize: 10,
                      fontFamily: 'Outfit',
                      fontWeight: FontWeight.w500,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 2),
                    child: Center(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Policies(
                                  title: " ",
                                  data: Policy_Data.privacy_policy1,
                                ),
                              ));
                        },
                        child: Text(
                          "Privacy & Policy",
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: theme.colorScheme.primary,
                            // fontSize: _width / 30,
                            fontSize: 10,
                            fontFamily: 'Outfit',
                            fontWeight: FontWeight.w500,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              GestureDetector(
                onTap: () {
                  if (_formKey.currentState!.validate()) {
                    if (isChecked == true) {
                      var datapPassing = {
                        "userName": usernameController.text,
                        "email": emailController.text,
                        "mobileNo": mobilenumberController.text,
                        "password": passwordController.text,
                        "checkTermsAndConditions": isChecked,
                      };

                      print('dataPassing-$datapPassing');
                    } else {
                      SnackBar snackBar = SnackBar(
                        content: Text(
                            'Please Cheak Terms Of Use And Privacy Policy'),
                        backgroundColor: ColorConstant.primary_color,
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    }
                  }
                },
                child: Container(
                  height: 40,
                  // width: _width / 1.2,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: ColorConstant.primary_color,
                  ),
                  child: Center(
                      child: Text(
                    "Next",
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'outfit',
                        fontSize: 18,
                        fontWeight: FontWeight.w500),
                  )),
                ),
              ),
              SizedBox(
                height: 20,
              )
            ]),
          ),
        ),
      ),
    );
  }
}

//----------------------------------------------------------------------------------------------------------------------
class CaBusinessDetailsScreen extends StatefulWidget {
  const CaBusinessDetailsScreen({Key? key}) : super(key: key);

  @override
  State<CaBusinessDetailsScreen> createState() =>
      _CaBusinessDetailsScreenState();
}

class _CaBusinessDetailsScreenState extends State<CaBusinessDetailsScreen> {
  bool isPhonee = false;
  bool Show_Password = true;
  bool isChecked = false;

  TextEditingController GSTController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  TextEditingController areaController = TextEditingController();
  TextEditingController businesspanController = TextEditingController();
  TextEditingController BusinessNameController = TextEditingController();
  TextEditingController businessaddressController = TextEditingController();
  TextEditingController PinController = TextEditingController();
  TextEditingController CountryController = TextEditingController();
  TextEditingController CityController = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool SubmitOneTime = false;

  @override
  Widget build(BuildContext context) {
    var _height = MediaQuery.of(context).size.height;
    var _width = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back,
            color: Colors.grey,
          ),
        ),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 25.0, right: 25),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              SizedBox(
                height: 20,
              ),
              Text(
                "Create Account",
                style: TextStyle(
                    fontFamily: 'outfit',
                    fontSize: 20,
                    fontWeight: FontWeight.w500),
              ),
              Divider(
                color: ColorConstant.primary_color,
                // indent: 80,
                endIndent: 220,
                thickness: 1,
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "business details",
                style: TextStyle(
                    fontFamily: 'outfit',
                    fontSize: 15,
                    color: ColorConstant.primary_color,
                    fontWeight: FontWeight.w500),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "GST Number",
                style: TextStyle(
                    fontFamily: 'outfit',
                    fontSize: 15,
                    color: Colors.black,
                    fontWeight: FontWeight.w500),
              ),
              CustomTextFormField(
                suffix: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Text(
                    "Verify",
                    style: TextStyle(color: ColorConstant.primary_color),
                  ),
                ),
                // focusNode: FocusNode(),
                // autofocus: true,

                controller: GSTController,
                margin: EdgeInsets.only(
                  top: 4,
                ),
                contentPadding: EdgeInsets.only(
                  left: 12,
                  top: 14,
                  right: 12,
                  bottom: 14,
                ),
                /*   validator: (value) {
                  RegExp nameRegExp = RegExp(r"^[a-zA-Z0-9\s'@]+$");
                  if (value!.isEmpty) {
                    return 'Please Enter User Name';
                  } else if (!nameRegExp.hasMatch(value)) {
                    return 'Input cannot contains prohibited special characters';
                  } else if (value.length <= 0 || value.length > 50) {
                    return 'Minimum length required';
                  } else if (value.contains('..')) {
                    return 'username does not contain is correct';
                  }

                  return null;
                }, */

                hintText: "27ABCDR5055K2Z6",

                textInputAction: TextInputAction.next,
                filled: true,
                maxLength: 100,
                fillColor: appTheme.gray100,
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "Business PAN *",
                style: TextStyle(
                    fontFamily: 'outfit',
                    fontSize: 15,
                    color: Colors.black,
                    fontWeight: FontWeight.w500),
              ),
              CustomTextFormField(
                // focusNode: FocusNode(),
                // autofocus: true,

                controller: businesspanController,
                margin: EdgeInsets.only(
                  top: 4,
                ),
                contentPadding: EdgeInsets.only(
                  left: 12,
                  top: 14,
                  right: 12,
                  bottom: 14,
                ),
                /* validator: (value) {
                  final RegExp emailRegExp = RegExp(
                      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');

                  if (value!.isEmpty) {
                    return 'Please Enter Email';
                  } else if (!emailRegExp.hasMatch(value)) {
                    return 'please Enter vaild Email';
                  }
                  return null;
                }, */

                hintText: "ABCDR5055K",

                textInputAction: TextInputAction.next,
                filled: true,
                maxLength: 100,
                fillColor: appTheme.gray100,
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "Business Type *",

                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 15,
                  color: Colors.black,
                  fontFamily: 'outfit',
                ),
                // style: theme.textTheme.bodyLarge,
              ),
              SizedBox(
                width: 5,
              ),
              Container(
                child: CustomTextFormField(
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
                  hintText: "partnership",
                  filled: true,
                  fillColor: appTheme.gray100,
                  textInputAction: TextInputAction.next,
                  textInputType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "Business Name *",
                style: TextStyle(
                    fontFamily: 'outfit',
                    fontSize: 15,
                    color: Colors.black,
                    fontWeight: FontWeight.w500),
              ),
              CustomTextFormField(
                // focusNode: FocusNode(),
                // autofocus: true,

                controller: BusinessNameController,
                margin: EdgeInsets.only(
                  top: 4,
                ),
                contentPadding: EdgeInsets.only(
                  left: 12,
                  top: 14,
                  right: 12,
                  bottom: 14,
                ),

                /* validator: (value) {
                  RegExp nameRegExp = RegExp(r"^[a-zA-Z0-9\s'@]+$");
                  if (value!.isEmpty) {
                    return 'Please Enter Referral Code';
                  } else if (!nameRegExp.hasMatch(value)) {
                    return 'Input cannot contains prohibited special characters';
                  } else if (value.length <= 0 || value.length > 50) {
                    return 'Minimum length required';
                  } else if (value.contains('..')) {
                    return 'Referral Code not contain is correct';
                  }

                  return null;
                }, */

                hintText: "Enter Business Name",

                textInputAction: TextInputAction.next,
                filled: true,
                maxLength: 100,
                fillColor: appTheme.gray100,
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "Business Address *",
                style: TextStyle(
                    fontFamily: 'outfit',
                    fontSize: 15,
                    color: Colors.black,
                    fontWeight: FontWeight.w500),
              ),
              CustomTextFormField(
                maxLength: 50, maxLines: 4,

                errorMaxLines: 5,
                // focusNode: FocusNode(),
                // autofocus: true,

                /* validator: (value) {
                  String pattern =
                      r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$%^&*(),.?":{}|<>])[A-Za-z0-9!@#\$%^&*(),.?":{}|<>]{8,}$';
                  if (value!.isEmpty) {
                    return 'Please Enter Password';
                  }
                  if (!RegExp(pattern).hasMatch(value)) {
                    return 'Password should contain at least 1 uppercase, 1 lowercase, 1 digit, 1 special character and be at least 8 characters long';
                  }

                  return null;
                }, */
                controller: businessaddressController,
                margin: EdgeInsets.only(
                  top: 5,
                ),
                contentPadding: EdgeInsets.only(
                  left: 20,
                  top: 14,
                  bottom: 14,
                ),
                // textStyle: theme.textTheme.titleMedium!,
                hintText: "203, ram park, varachha, surat ",
                // hintStyle: theme.textTheme.titleMedium!,

                filled: true,

                fillColor: appTheme.gray100,
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "Pincode *",
                style: TextStyle(
                    fontFamily: 'outfit',
                    fontSize: 15,
                    color: Colors.black,
                    fontWeight: FontWeight.w500),
              ),
              CustomTextFormField(
                textInputType: TextInputType.number,
                maxLength: 50,

                errorMaxLines: 5,
                // focusNode: FocusNode(),
                // autofocus: true,

                /* validator: (value) {
                  String pattern =
                      r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$%^&*(),.?":{}|<>])[A-Za-z0-9!@#\$%^&*(),.?":{}|<>]{8,}$';
                  if (value!.isEmpty) {
                    return 'Please Enter Password';
                  }
                  if (!RegExp(pattern).hasMatch(value)) {
                    return 'Password should contain at least 1 uppercase, 1 lowercase, 1 digit, 1 special character and be at least 8 characters long';
                  }

                  return null;
                }, */
                controller: PinController,
                margin: EdgeInsets.only(
                  top: 5,
                ),
                contentPadding: EdgeInsets.only(
                  left: 20,
                  top: 14,
                  bottom: 14,
                ),
                // textStyle: theme.textTheme.titleMedium!,
                hintText: "25362536",
                // hintStyle: theme.textTheme.titleMedium!,

                filled: true,

                fillColor: appTheme.gray100,
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "Country *",
                style: TextStyle(
                    fontFamily: 'outfit',
                    fontSize: 15,
                    color: Colors.black,
                    fontWeight: FontWeight.w500),
              ),
              CustomTextFormField(
                // focusNode: FocusNode(),
                // autofocus: true,

                controller: CountryController,
                margin: EdgeInsets.only(
                  top: 4,
                ),
                contentPadding: EdgeInsets.only(
                  left: 12,
                  top: 14,
                  right: 12,
                  bottom: 14,
                ),

                /* validator: (value) {
                  RegExp nameRegExp = RegExp(r"^[a-zA-Z0-9\s'@]+$");
                  if (value!.isEmpty) {
                    return 'Please Enter Referral Code';
                  } else if (!nameRegExp.hasMatch(value)) {
                    return 'Input cannot contains prohibited special characters';
                  } else if (value.length <= 0 || value.length > 50) {
                    return 'Minimum length required';
                  } else if (value.contains('..')) {
                    return 'Referral Code not contain is correct';
                  }

                  return null;
                }, */

                hintText: "india",

                textInputAction: TextInputAction.next,
                filled: true,
                maxLength: 100,
                fillColor: appTheme.gray100,
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "State *",
                style: TextStyle(
                    fontFamily: 'outfit',
                    fontSize: 15,
                    color: Colors.black,
                    fontWeight: FontWeight.w500),
              ),
              CustomTextFormField(
                // focusNode: FocusNode(),
                // autofocus: true,

                controller: stateController,
                margin: EdgeInsets.only(
                  top: 4,
                ),
                contentPadding: EdgeInsets.only(
                  left: 12,
                  top: 14,
                  right: 12,
                  bottom: 14,
                ),

                /* validator: (value) {
                  RegExp nameRegExp = RegExp(r"^[a-zA-Z0-9\s'@]+$");
                  if (value!.isEmpty) {
                    return 'Please Enter Referral Code';
                  } else if (!nameRegExp.hasMatch(value)) {
                    return 'Input cannot contains prohibited special characters';
                  } else if (value.length <= 0 || value.length > 50) {
                    return 'Minimum length required';
                  } else if (value.contains('..')) {
                    return 'Referral Code not contain is correct';
                  }

                  return null;
                }, */

                hintText: "gujarat",

                textInputAction: TextInputAction.next,
                filled: true,
                maxLength: 100,
                fillColor: appTheme.gray100,
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "City *",
                style: TextStyle(
                    fontFamily: 'outfit',
                    fontSize: 15,
                    color: Colors.black,
                    fontWeight: FontWeight.w500),
              ),
              CustomTextFormField(
                // focusNode: FocusNode(),
                // autofocus: true,

                controller: CityController,
                margin: EdgeInsets.only(
                  top: 4,
                ),
                contentPadding: EdgeInsets.only(
                  left: 12,
                  top: 14,
                  right: 12,
                  bottom: 14,
                ),

                /* validator: (value) {
                  RegExp nameRegExp = RegExp(r"^[a-zA-Z0-9\s'@]+$");
                  if (value!.isEmpty) {
                    return 'Please Enter Referral Code';
                  } else if (!nameRegExp.hasMatch(value)) {
                    return 'Input cannot contains prohibited special characters';
                  } else if (value.length <= 0 || value.length > 50) {
                    return 'Minimum length required';
                  } else if (value.contains('..')) {
                    return 'Referral Code not contain is correct';
                  }

                  return null;
                }, */

                hintText: "suart",

                textInputAction: TextInputAction.next,
                filled: true,
                maxLength: 100,
                fillColor: appTheme.gray100,
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "Area *",
                style: TextStyle(
                    fontFamily: 'outfit',
                    fontSize: 15,
                    color: Colors.black,
                    fontWeight: FontWeight.w500),
              ),
              CustomTextFormField(
                // focusNode: FocusNode(),
                // autofocus: true,

                controller: areaController,
                margin: EdgeInsets.only(
                  top: 4,
                ),
                contentPadding: EdgeInsets.only(
                  left: 12,
                  top: 14,
                  right: 12,
                  bottom: 14,
                ),

                /* validator: (value) {
                  RegExp nameRegExp = RegExp(r"^[a-zA-Z0-9\s'@]+$");
                  if (value!.isEmpty) {
                    return 'Please Enter Referral Code';
                  } else if (!nameRegExp.hasMatch(value)) {
                    return 'Input cannot contains prohibited special characters';
                  } else if (value.length <= 0 || value.length > 50) {
                    return 'Minimum length required';
                  } else if (value.contains('..')) {
                    return 'Referral Code not contain is correct';
                  }

                  return null;
                }, */

                hintText: "adajan",

                textInputAction: TextInputAction.next,
                filled: true,
                maxLength: 100,
                fillColor: appTheme.gray100,
              ),
              SizedBox(
                height: 20,
              ),
              GestureDetector(
                child: Container(
                  height: 40,
                  // width: _width / 1.2,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: ColorConstant.primary_color,
                  ),
                  child: Center(
                      child: Text(
                    "Next",
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'outfit',
                        fontSize: 18,
                        fontWeight: FontWeight.w500),
                  )),
                ),
              ),
              SizedBox(
                height: 20,
              ),
            ]),
          ),
        ),
      ),
    );
  }
}

//----------------------------------------------------------------------------------------------------------------------
class CaUplodDocumentScreen extends StatefulWidget {
  const CaUplodDocumentScreen({Key? key}) : super(key: key);

  @override
  State<CaUplodDocumentScreen> createState() => _CaUplodDocumentScreenState();
}

class _CaUplodDocumentScreenState extends State<CaUplodDocumentScreen> {
  TextEditingController DocumenttypeController = TextEditingController();
  TextEditingController DocumentnumberController = TextEditingController();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool SubmitOneTime = false;

  @override
  Widget build(BuildContext context) {
    var _height = MediaQuery.of(context).size.height;
    var _width = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back,
            color: Colors.grey,
          ),
        ),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 25.0, right: 25),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(
                "Create Account",
                style: TextStyle(
                    fontFamily: 'outfit',
                    fontSize: 20,
                    fontWeight: FontWeight.w500),
              ),
              Divider(
                color: ColorConstant.primary_color,
                // indent: 80,
                endIndent: 220,
                thickness: 1,
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "Upload Documents",
                style: TextStyle(
                    fontFamily: 'outfit',
                    fontSize: 15,
                    color: ColorConstant.primary_color,
                    fontWeight: FontWeight.w500),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "GST Certificate *",
                style: TextStyle(
                    fontFamily: 'outfit',
                    fontSize: 15,
                    color: Colors.black,
                    fontWeight: FontWeight.w500),
              ),
              Container(
                height: 50,
                width: _width,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.grey.shade300),
                    color: Colors.grey.shade100),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "test9700GJ6N1",
                        style: TextStyle(
                          fontFamily: 'outfit',
                          fontSize: 15,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        width: 80,
                        decoration: BoxDecoration(
                            border: Border.all(
                              color: ColorConstant.primaryLight_color,
                            ),
                            color: ColorConstant.primaryLight_color,
                            borderRadius: BorderRadius.all(
                              Radius.circular(8),
                            )),
                        child: Row(children: [
                          Image.asset(
                            ImageConstant.uplodimage,
                            height: 25,
                          ),
                          Text(
                            "Upload",
                            style: TextStyle(
                                fontFamily: 'outfit',
                                color: ColorConstant.primary_color),
                          )
                        ]),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "PAN Card *",
                style: TextStyle(
                    fontFamily: 'outfit',
                    fontSize: 15,
                    color: Colors.black,
                    fontWeight: FontWeight.w500),
              ),
              Container(
                height: 50,
                width: _width,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.grey.shade300),
                    color: Colors.grey.shade100),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "test9700GJ6N1",
                        style: TextStyle(
                          fontFamily: 'outfit',
                          fontSize: 15,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        width: 80,
                        decoration: BoxDecoration(
                            border: Border.all(
                              color: ColorConstant.primaryLight_color,
                            ),
                            color: ColorConstant.primaryLight_color,
                            borderRadius: BorderRadius.all(
                              Radius.circular(8),
                            )),
                        child: Row(children: [
                          Image.asset(
                            ImageConstant.uplodimage,
                            height: 25,
                          ),
                          Text(
                            "Upload",
                            style: TextStyle(
                                fontFamily: 'outfit',
                                color: ColorConstant.primary_color),
                          )
                        ]),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "Other Document",
                style: TextStyle(
                    fontFamily: 'outfit',
                    fontSize: 20,
                    color: ColorConstant.primary_color,
                    fontWeight: FontWeight.w500),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "Document Type",
                style: TextStyle(
                    fontFamily: 'outfit',
                    fontSize: 15,
                    color: Colors.black,
                    fontWeight: FontWeight.w500),
              ),
              CustomTextFormField(
                // focusNode: FocusNode(),
                // autofocus: true,

                controller: DocumenttypeController,
                margin: EdgeInsets.only(
                  top: 4,
                ),
                contentPadding: EdgeInsets.only(
                  left: 12,
                  top: 14,
                  right: 12,
                  bottom: 14,
                ),

                hintText: "admin@inpackaging.com",

                textInputAction: TextInputAction.next,
                filled: true,
                maxLength: 100,
                fillColor: appTheme.gray100,
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "Document No.",
                style: TextStyle(
                    fontFamily: 'outfit',
                    fontSize: 15,
                    color: Colors.black,
                    fontWeight: FontWeight.w500),
              ),
              CustomTextFormField(
                // focusNode: FocusNode(),
                // autofocus: true,

                controller: DocumentnumberController,
                margin: EdgeInsets.only(
                  top: 4,
                ),
                contentPadding: EdgeInsets.only(
                  left: 12,
                  top: 14,
                  right: 12,
                  bottom: 14,
                ),

                /* validator: (value) {
                  RegExp nameRegExp = RegExp(r"^[a-zA-Z0-9\s'@]+$");
                  if (value!.isEmpty) {
                    return 'Please Enter Referral Code';
                  } else if (!nameRegExp.hasMatch(value)) {
                    return 'Input cannot contains prohibited special characters';
                  } else if (value.length <= 0 || value.length > 50) {
                    return 'Minimum length required';
                  } else if (value.contains('..')) {
                    return 'Referral Code not contain is correct';
                  }

                  return null;
                }, */

                hintText: "9865323232",

                textInputAction: TextInputAction.next,
                filled: true,
                maxLength: 100,
                fillColor: appTheme.gray100,
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "Document Proof",
                style: TextStyle(
                    fontFamily: 'outfit',
                    fontSize: 15,
                    color: Colors.black,
                    fontWeight: FontWeight.w500),
              ),
              Container(
                height: 50,
                width: _width,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.grey.shade300),
                    color: Colors.grey.shade100),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "9865323232",
                        style: TextStyle(
                          fontFamily: 'outfit',
                          fontSize: 15,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        width: 80,
                        decoration: BoxDecoration(
                            border: Border.all(
                              color: ColorConstant.primaryLight_color,
                            ),
                            color: ColorConstant.primaryLight_color,
                            borderRadius: BorderRadius.all(
                              Radius.circular(8),
                            )),
                        child: Row(children: [
                          Image.asset(
                            ImageConstant.uplodimage,
                            height: 25,
                          ),
                          Text(
                            "Upload",
                            style: TextStyle(
                                fontFamily: 'outfit',
                                color: ColorConstant.primary_color),
                          )
                        ]),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "+ Add Document",
                style: TextStyle(
                    fontFamily: 'outfit',
                    fontWeight: FontWeight.w400,
                    color: ColorConstant.primary_color,
                    fontSize: 18),
              ),
              SizedBox(
                height: 20,
              ),
              GestureDetector(
                child: Container(
                  height: 40,
                  // width: _width / 1.2,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: ColorConstant.primary_color,
                  ),
                  child: Center(
                      child: Text(
                    "Submit",
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'outfit',
                        fontSize: 18,
                        fontWeight: FontWeight.w500),
                  )),
                ),
              ),
              SizedBox(
                height: 20,
              )
            ]),
          ),
        ),
      ),
    );
  }
}
//----------------------------------------------------------------------------------------------------------------------

class CaBusinessAssosiateScreen extends StatefulWidget {
  const CaBusinessAssosiateScreen({Key? key}) : super(key: key);

  @override
  State<CaBusinessAssosiateScreen> createState() =>
      _CaBusinessAssosiateScreenState();
}

class _CaBusinessAssosiateScreenState extends State<CaBusinessAssosiateScreen> {
  bool isPhonee = false;
  bool Show_Password = true;
  bool isChecked = false;

  TextEditingController assosiatecodeController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController mobilenumberController = TextEditingController();
   
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool SubmitOneTime = false;

  @override
  Widget build(BuildContext context) {
    var _height = MediaQuery.of(context).size.height;
    var _width = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back,
            color: Colors.grey,
          ),
        ),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 25.0, right: 25),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              SizedBox(
                height: 20,
              ),
              Text(
                "Create Account",
                style: TextStyle(
                    fontFamily: 'outfit',
                    fontSize: 20,
                    fontWeight: FontWeight.w500),
              ),
              Divider(
                color: ColorConstant.primary_color,
                // indent: 80,
                endIndent: 220,
                thickness: 1,
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "Business Associate",
                style: TextStyle(
                    fontFamily: 'outfit',
                    fontSize: 15,
                    color: ColorConstant.primary_color,
                    fontWeight: FontWeight.w500),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "Enter Business Associate Code",
                style: TextStyle(
                    fontFamily: 'outfit',
                    fontSize: 15,
                    color: Colors.black,
                    fontWeight: FontWeight.w500),
              ),
              CustomTextFormField(
                // focusNode: FocusNode(),
                // autofocus: true,

                controller: assosiatecodeController,
                margin: EdgeInsets.only(
                  top: 4,
                ),
                contentPadding: EdgeInsets.only(
                  left: 12,
                  top: 14,
                  right: 12,
                  bottom: 14,
                ),

                hintText: "test9700GJ6N1",

                textInputAction: TextInputAction.next,
                filled: true,
                maxLength: 100,
                fillColor: appTheme.gray100,
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "Name",
                style: TextStyle(
                    fontFamily: 'outfit',
                    fontSize: 15,
                    color: Colors.black,
                    fontWeight: FontWeight.w500),
              ),
              CustomTextFormField(
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

                hintText: "test9700GJ6N1",

                textInputAction: TextInputAction.next,
                filled: true,
                maxLength: 100,
                fillColor: appTheme.gray100,
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "E mail",

                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 15,
                  color: Colors.black,
                  fontFamily: 'outfit',
                ),
                // style: theme.textTheme.bodyLarge,
              ),
              SizedBox(
                width: 5,
              ),
              Container(
                child: CustomTextFormField(
                  controller: emailController,
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
                  hintText: "admin@inpackaging.com",
                  filled: true,
                  fillColor: appTheme.gray100,
                  textInputAction: TextInputAction.next,
                  textInputType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "Mobile Number",
                style: TextStyle(
                    fontFamily: 'outfit',
                    fontSize: 15,
                    color: Colors.black,
                    fontWeight: FontWeight.w500),
              ),
              CustomTextFormField(
                // focusNode: FocusNode(),
                // autofocus: true,
                textInputType: TextInputType.number,
                controller: mobilenumberController,
                margin: EdgeInsets.only(
                  top: 4,
                ),
                contentPadding: EdgeInsets.only(
                  left: 12,
                  top: 14,
                  right: 12,
                  bottom: 14,
                ),

                hintText: "9865323232",

                textInputAction: TextInputAction.next,
                filled: true,
                maxLength: 100,
                fillColor: appTheme.gray100,
              ),
              SizedBox(
                height: 20,
              ),
              GestureDetector(
                child: Container(
                  height: 40,
                  // width: _width / 1.2,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: ColorConstant.primary_color,
                  ),
                  child: Center(
                      child: Text(
                    "Next",
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'outfit',
                        fontSize: 18,
                        fontWeight: FontWeight.w500),
                  )),
                ),
              ),
              SizedBox(
                height: 20,
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
