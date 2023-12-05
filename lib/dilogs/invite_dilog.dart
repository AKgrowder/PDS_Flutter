// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pds/API/Bloc/sherinvite_Block/sherinvite_cubit.dart';
import 'package:pds/API/Bloc/sherinvite_Block/sherinvite_state.dart';
import 'package:pds/core/utils/color_constant.dart';

import '../core/utils/image_constant.dart';
import '../widgets/custom_image_view.dart';

class InviteDilogScreen extends StatefulWidget {
  String? Room_UUID;
  String? Room_Link;
  InviteDilogScreen({required this.Room_UUID, required this.Room_Link});
  @override
  State<StatefulWidget> createState() => _InviteDilogScreenState();
}

TextEditingController RateUSController = TextEditingController();

class _InviteDilogScreenState extends State<InviteDilogScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> scaleAnimation;
  TextEditingController email = TextEditingController();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  double? rateStar = 5.0;
  bool SubmitOneTime = false;
  var IsGuestUserEnabled;
  var GetTimeSplash;
  @override
  void initState() {
    // setUserRating();
    super.initState();

    controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 450));
    scaleAnimation =
        CurvedAnimation(parent: controller, curve: Curves.elasticInOut);

    controller.addListener(() {
      setState(() {});
    });

    controller.forward();
  }

  var userRating;

  @override
  void dispose() {
    // TODO: implement dispose
    RateUSController.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return BlocConsumer<SherInviteCubit, SherInviteState>(
      listener: (context, state) {
        if (state is SherInviteErrorState) {
          SnackBar snackBar = SnackBar(
            content: Text(state.error.message),
            backgroundColor: ColorConstant.primary_color,
          );
          SubmitOneTime = false;
           Future.delayed(const Duration(seconds: 4), () {
            Navigator.pop(context);
          });
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
        if (state is SherInviteLoadingState) {
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
        if (state is SherInviteLoadedState) {
          SnackBar snackBar = SnackBar(
            content: Text(state.sherInvite.message ?? ""),
            backgroundColor: ColorConstant.primary_color,
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
          Future.delayed(const Duration(seconds: 1), () {
            Navigator.pop(context);
          });
        }
      },
      builder: (context, state) {
        return Center(
          child: Material(
            color: Color.fromARGB(0, 255, 255, 255),
            child: ScaleTransition(
              scale: scaleAnimation,
              child: Container(
                height: height / 2,
                width: width / 1.17,
                decoration: ShapeDecoration(
                  // color: Colors.black,

                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                ),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Center(
                        child: Container(
                          // height: 230,
                          height: 280,
                          width: width / 1.25,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 8.0, left: 20),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Invite",
                                      style: TextStyle(
                                        fontFamily: 'outfit',
                                        fontSize: 20,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () => Navigator.pop(context),
                                      child: CustomImageView(
                                        imagePath: ImageConstant.closeimage,
                                        height: 40,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Divider(
                                color: Colors.grey,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 22.0),
                                child: Text(
                                  "Enter Email ID",
                                  style: TextStyle(
                                    fontFamily: 'outfit',
                                    fontSize: 15,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Center(
                                child: Container(
                                  // height: 40,
                                  width: width / 1.45,
                                  decoration: BoxDecoration(
                                      border: Border.all(color: Colors.grey),
                                      borderRadius: BorderRadius.circular(5)),
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        top: 0.0, left: 10),
                                    child: TextFormField(
                                      inputFormatters: [
                                        LengthLimitingTextInputFormatter(50),
                                      ],
                                      // validator: (value) {
                                      //   final RegExp emailRegExp = RegExp(
                                      //       r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');

                                      //   if (value!.isEmpty) {
                                      //     return 'Please Enter Email';
                                      //   } else if (!emailRegExp
                                      //       .hasMatch(value)) {
                                      //     return 'please Enter vaild Email';
                                      //   }
                                      //   return null;
                                      // },
                                      controller: email,
                                      cursorColor: Colors.grey,
                                      decoration: InputDecoration(
                                          border: InputBorder.none,
                                          hintText: 'Email'),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 30,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  GestureDetector(
                                    onTap: () => Navigator.pop(context),
                                    child: Container(
                                      height: 43,
                                      width: width / 3.5,
                                      decoration: BoxDecoration(
                                          color: Colors.transparent,
                                          border: Border.all(
                                              color: Colors.grey.shade400),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: Center(
                                          child: Text(
                                        "Cancel",
                                        style: TextStyle(
                                          fontFamily: 'outfit',
                                          fontSize: 15,
                                          color: Color(0xFFED1C25),
                                          fontWeight: FontWeight.w400,
                                        ),
                                      )),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      final RegExp emailRegExp = RegExp(
                                          r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
                                      // if (email.text.toString() != null) {
                                      //   print('uid-${widget.Room_UUID}');
                                      //   print('email -${email.text}');
                                      //   BlocProvider.of<SherInviteCubit>(
                                      //           context)
                                      //       .sherInviteApi(
                                      //           widget.Room_UUID.toString(),
                                      //           email.text.toString());
                                      // }
                                      // else if(!emailRegExp.hasMatch(email.text)){

                                      // }
                                      if (email.text.toString().isEmpty) {
                                        SnackBar snackBar = SnackBar(
                                          content: Text('Please Enter Email'),
                                          backgroundColor:
                                              ColorConstant.primary_color,
                                        );
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(snackBar);
                                      } else if (email.text.trim().isEmpty ||
                                          email.text.trim() == '') {
                                        SnackBar snackBar = SnackBar(
                                          content: Text(
                                              'email can\'t be just blank spaces'),
                                          backgroundColor:
                                              ColorConstant.primary_color,
                                        );
                                        ScaffoldMessenger.of(context);
                                      } else if (!emailRegExp
                                          .hasMatch(email.text.toString())) {
                                        SnackBar snackBar = SnackBar(
                                          content:
                                              Text('please Enter vaild Email'),
                                          backgroundColor:
                                              ColorConstant.primary_color,
                                        );
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(snackBar);
                                      } else {
                                        print('uid-${widget.Room_UUID}');
                                        print('email -${email.text}');
                                        if (SubmitOneTime == false) {
                                          SubmitOneTime = true;
                                          BlocProvider.of<SherInviteCubit>(
                                                  context)
                                              .sherInviteApi(
                                                  widget.Room_UUID.toString(),
                                                  email.text.toString(),
                                                  context);
                                        }
                                      }
                                      // if (_formKey.currentState!.validate()) {
                                    },
                                    child: Container(
                                      height: 43,
                                      width: width / 3.5,
                                      decoration: BoxDecoration(
                                          color: Color(0xFFED1C25),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: Center(
                                          child: Text(
                                        "Invite",
                                        style: TextStyle(
                                          fontFamily: 'outfit',
                                          fontSize: 15,
                                          color: Colors.white,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      )),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              Divider(
                                color: Colors.black,
                              ),
                              GestureDetector(
                                onTap: () {
                                  Clipboard.setData(ClipboardData(
                                      text: "${widget.Room_Link}"));
                                  SnackBar snackBar = SnackBar(
                                    content: Text("Copy Room Link."),
                                    backgroundColor:
                                        ColorConstant.primary_color,
                                  );
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(snackBar);
                                },
                                child: Container(
                                  color: Colors.transparent,
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 10.0),
                                    child: Row(
                                      children: [
                                        CustomImageView(
                                          imagePath: ImageConstant.copyimage,
                                          height: 20,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            "Copy Link",
                                            style: TextStyle(
                                              fontFamily: 'outfit',
                                              fontSize: 15,
                                              color: Color(0xFFED1C25),
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
