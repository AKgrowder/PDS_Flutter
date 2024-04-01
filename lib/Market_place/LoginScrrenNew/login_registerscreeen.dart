// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pds/Market_place/commenWiget.dart/commenButton.dart';
import 'package:pds/core/utils/color_constant.dart';
import 'package:pds/presentation/policy_of_company/policy_screen.dart';
import 'package:pds/presentation/policy_of_company/privecy_policy.dart';
import 'package:pds/theme/theme_helper.dart';
import 'package:pds/widgets/custom_text_form_field.dart';

import '../Cubit/LoginCubit.dart';

class LoginAndRegistrstionScreen extends StatefulWidget {
  String screenName;
  String? registrationName;
  String? category;

  LoginAndRegistrstionScreen(
      {Key? key,
      required this.screenName,
      this.registrationName,
      this.category})
      : super(key: key);

  @override
  State<LoginAndRegistrstionScreen> createState() =>
      _LoginAndRegistrstionScreenState();
}

class _LoginAndRegistrstionScreenState
    extends State<LoginAndRegistrstionScreen> {
  TextEditingController mobilenumberController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool isPhonee = false;
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
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.only(left: 16),
          child: BlocBuilder<LoginRegisterCubit, LoginRegtistrtionState>(
            builder: (context, state) {
              if (state is LoginRegtistrtionResponceGetState) {
                print("this Condison is working");
              }
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Registration for ${widget.registrationName}",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                  ),
                  Divider(
                    color: ColorConstant.primary_color,
                    endIndent: 300,
                    thickness: 1.5,
                  ),
                  Text(
                    'Welcome onboard with us!',
                    style: TextStyle(
                        fontFamily: 'outfit',
                        fontWeight: FontWeight.w500,
                        fontSize: 15),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Text(
                    'Mobile number',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.black),
                  ),
                  SizedBox(
                    height: 10,
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
                              fontSize: 15, fontWeight: FontWeight.w400),
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

                          maxLength: 10,
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
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        height: 5,
                        child: Checkbox(
                          activeColor: ColorConstant.primary_color,
                          visualDensity: VisualDensity(
                            horizontal: -4.0,
                            vertical: -2.0,
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
                          fontSize: 13,
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
                            fontSize: 13,
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
                          fontSize: 13,
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
                                fontSize: 13,
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
                  if (isChecked)
                    CommonButton(
                      height: 40,
                      margin: EdgeInsets.only(right: 10),
                      radius: 8,
                      child: Center(
                          child: Text(
                        "Login With OTP",
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'outfit',
                            fontSize: 15,
                            fontWeight: FontWeight.w500),
                      )),
                      color: ColorConstant.primary_color,
                      onTap: onSubmitMethod,
                    )
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  onSubmitMethod() {
    if (_formKey.currentState!.validate()) {
      Map<String, dynamic> params = {
        'mobile': mobilenumberController.text,
        'terms': isChecked,
        'ipServices': widget.category,
      };
      if (widget.registrationName == 'Business Asscociate') {
        params['productServices'] = 'BA';
      } else if (widget.registrationName == 'Franchise Owner') {
        params['productServices'] = 'FRANCHISE';
      } else {
        params['rmServices'] = widget.registrationName?.split('/').first.toUpperCase();
        params['productServices'] = widget.registrationName?.split('/').last.toUpperCase();

      }
      BlocProvider.of<LoginRegisterCubit>(context).loginApidata(params, context);
    }
  }
}
