import 'dart:io';

import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:pds/core/utils/color_constant.dart';
import 'package:pds/core/utils/image_constant.dart';
import 'package:pds/widgets/custom_text_form_field.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import '../API/Bloc/RateUs_Bloc/RateUs_cubit.dart';
import '../core/utils/sharedPreferences.dart';

class rateUSdialog extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => rateUSdialogState();
}

TextEditingController RateUSController = TextEditingController();

class rateUSdialogState extends State<rateUSdialog>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> scaleAnimation;
  double? rateStar = 5.0;
  var GetTimeSplash;
  @override
  void initState() {
    setUserRating();
    super.initState();

    controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 450));
    scaleAnimation =
        CurvedAnimation(parent: controller, curve: Curves.elasticInOut);

    controller.addListener(() {
      super.setState(() {});
    });

    controller.forward();
  }

  var userRating;
  var User_ID;

  @override
  void dispose() {
    // TODO: implement dispose
    RateUSController.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Center(
      child: Material(
        color: Color.fromARGB(0, 255, 255, 255),
        child: ScaleTransition(
          scale: scaleAnimation,
          child: Container(
            height: 420,
            width: MediaQuery.of(context).size.width / 1.17,
            decoration: ShapeDecoration(
              color: Color.fromARGB(0, 0, 0, 0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
            ),
            child: Column(
              children: [
                Container(
                  height: 420,
                  width: MediaQuery.of(context).size.width / 1.17,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color: const Color.fromARGB(255, 255, 255, 255)),
                  child: Column(
                    children: [
                      Stack(
                        children: [
                          Column(
                            children: [
                              Align(
                                alignment: Alignment.center,
                                child: Padding(
                                    padding: const EdgeInsets.only(top: 20),
                                    child: Text(
                                      "Rate Us",
                                      textScaleFactor: 1.0,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontFamily: 'outfit',
                                        fontSize: 22,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    )),
                              ),
                              Padding(
                                  padding: const EdgeInsets.only(top: 0),
                                  child: Text(
                                    "Tap a star to rate",
                                    textAlign: TextAlign.center,
                                    textScaleFactor: 1.0,
                                    style: TextStyle(
                                      fontFamily: 'outfit',
                                      fontSize: 20,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  )),
                            ],
                          ),
                          Positioned(
                            right: 0,
                            child: GestureDetector(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(right: 7, top: 7),
                                child: Container(
                                  height: 50,
                                  width: 50,
                                  // color: Colors.red,
                                  child: Align(
                                    alignment: Alignment.centerRight,
                                    child: Image.asset(
                                      ImageConstant.closeimage,
                                      fit: BoxFit.fill,
                                      height: 40,
                                      width: 40,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 30),
                        child: RatingBar.builder(
                          initialRating: userRating != null ? userRating : 5,
                          minRating: 1,
                          direction: Axis.horizontal,
                          allowHalfRating: true,
                          itemSize: 50,
                          itemCount: 5,
                          itemPadding: EdgeInsets.only(left: 1, right: 1),
                          itemBuilder: (context, _) => Icon(
                            Icons.star,
                            color: ColorConstant.primary_color,
                          ),
                          onRatingUpdate: (rating) {
                            rateStar = rating;
                            print(rating);
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 5, left: 15),
                        child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Let us know your suggestions !",
                              textScaleFactor: 1.0,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontFamily: 'outfit',
                                fontSize: 18,
                                fontWeight: FontWeight.w400,
                              ),
                            )),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 15, right: 15),
                        child: Container(
                          decoration: BoxDecoration(
                              border: Border.all(),
                              borderRadius: BorderRadius.circular(7)),
                          child: CustomTextFormField(
                            textInputAction: TextInputAction.done,
                            controller: RateUSController,
                            hintText: "Description",
                            maxLength: 150,
                            maxLines: 5,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10, top: 30),
                        child: GestureDetector(
                          onTap: () async {
                            final SharedPreferences prefs =
                                await SharedPreferences.getInstance();
                            User_ID =
                                prefs.getString(PreferencesKey.loginUserID);
                            var params = {
                              "userUid": User_ID,
                              "description": RateUSController.text,
                              "star": rateStar
                            };
                            print(params);
                            print(User_ID);

                            if (rateStar! <= 3.0) {
                              if (RateUSController.text.isEmpty) {
                                show_Icon_Flushbar(context,
                                    msg: "Please Enter Description");
                              } else {
                                BlocProvider.of<RateUsCubit>(context)
                                    .RateUsApi(params, context);
                                SnackBar snackBar = SnackBar(
                                  content:
                                      Text("Your Rate is Successfully Submit!"),
                                  backgroundColor: ColorConstant.primary_color,
                                );
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(snackBar);

                                print(rateStar);

                                final SharedPreferences prefs =
                                    await SharedPreferences.getInstance();
                                prefs.setDouble(PreferencesKey.rating,
                                    rateStar!.toDouble());

                                Navigator.pop(context);
                              }
                            } else {
                              Navigator.pop(context);

                              if (Platform.isAndroid) {
                                final SharedPreferences prefs =
                                    await SharedPreferences.getInstance();
                                prefs.setDouble(PreferencesKey.rating,
                                    rateStar!.toDouble());
                                final Uri url = Uri.parse(
                                    "https://play.google.com/store/apps/");

                                launchUrl(url,
                                    mode: LaunchMode.externalApplication);
                              } else if (Platform.isIOS) {
                                final SharedPreferences prefs =
                                    await SharedPreferences.getInstance();
                                prefs.setDouble(PreferencesKey.rating,
                                    rateStar!.toDouble());
                                final Uri url =
                                    Uri.parse("https://apps.apple.com/in/app/");

                                if (await canLaunchUrl(url)) {
                                  await launchUrl(url,
                                      mode: LaunchMode.externalApplication);
                                } else {
                                  throw 'Could not launch $url';
                                }
                              }
                            }
                          },
                          child: Container(
                            width: 163,
                            height: 48,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white,
                              border: Border.all(
                                color: ColorConstant.primary_color,
                                width: 1.5,
                                style: BorderStyle.solid,
                                strokeAlign: BorderSide.strokeAlignInside,
                              ),
                            ),
                            child: Center(
                              child: Text("Submit",
                                  textScaleFactor: 1.0,
                                  style: TextStyle(
                                      fontFamily: 'outfit',
                                      fontSize: 20,
                                      color: ColorConstant.primary_color,
                                      fontWeight: FontWeight.w600)),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  setUserRating() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    userRating = prefs.getDouble(PreferencesKey.rating);
    print('UserRating........${userRating}');

    // prefs.getString(PreferencesKey.ProfileUserName);
  }

  void show_Icon_Flushbar(BuildContext context, {String? msg}) {
    Flushbar(
        backgroundColor: ColorConstant.primary_color,
        animationDuration: Duration(milliseconds: 500),
        duration: Duration(seconds: 3),
        message: msg)
      ..show(context);
  }
}
