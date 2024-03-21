import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pds/Market_place/MP_Dilogs/MP_singup_flow_dilogs.dart';
import 'package:pds/widgets/custom_image_view.dart';
import 'package:pds/widgets/custom_text_form_field.dart';
import 'package:pinput/pinput.dart';

import '../../../core/utils/color_constant.dart';
import '../../../core/utils/image_constant.dart';
import '../../../presentation/policy_of_company/policy_screen.dart';
import '../../../presentation/policy_of_company/privecy_policy.dart';
import '../../../theme/app_decoration.dart';
import '../../../theme/theme_helper.dart';

class MobileNumberLoginScreen extends StatefulWidget {
  const MobileNumberLoginScreen({Key? key}) : super(key: key);

  @override
  State<MobileNumberLoginScreen> createState() =>
      _MobileNumberLoginScreenState();
}

class _MobileNumberLoginScreenState extends State<MobileNumberLoginScreen> {
  bool isPhonee = false;
  TextEditingController mobilenumberController = TextEditingController();

  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    var _height = MediaQuery.of(context).size.height;
    var _width = MediaQuery.of(context).size.width;
    return Scaffold(
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
      body: Padding(
        padding: const EdgeInsets.only(left: 25, right: 25),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                width: 100,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Login",
                      style: TextStyle(
                          fontFamily: 'outfit',
                          fontSize: 25,
                          fontWeight: FontWeight.w400),
                    ),
                    Divider(
                      color: ColorConstant.primary_color,
                      // // indent: 80,
                      // endIndent: 80,
                      thickness: 1.5,
                    ),
                  ],
                ),
              ),
              Text(
                "Welcome onboard with us!",
                style: TextStyle(
                    fontFamily: 'outfit',
                    fontSize: 18,
                    fontWeight: FontWeight.w400),
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
                    "I have Read and Agree to",
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
                height: 50,
              ),
              GestureDetector(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (_) => OtpVarificationDilog(),
                  );
                },
                child: Container(
                  height: 40,
                  // width: _width / 1.2,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    color: ColorConstant.primary_color,
                  ),
                  child: Center(
                      child: Text(
                    "Login With OTP",
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'outfit',
                        fontSize: 18,
                        fontWeight: FontWeight.w500),
                  )),
                ),
              ),
            ]),
      ),
    );
  }
}

