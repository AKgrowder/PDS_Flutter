// ignore_for_file: must_be_immutable, sort_child_properties_last

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:pds/Market_place/MP_Prasantation/Charge_Payment_Screen/charge_payment_screen.dart';
import 'package:pds/Market_place/MP_Prasantation/home/MP_home_screen.dart';
import 'package:pds/core/utils/color_constant.dart';
import 'package:pds/core/utils/image_constant.dart';
import 'package:pds/core/utils/sharedPreferences.dart';
import 'package:pds/presentation/register_create_account_screen/register_create_account_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

// import 'package:growder/presentation/Buy_Screen/Buy_screen.dart';
// import 'package:growder/presentation/Profile_Screen/Profile_screen.dart';

// import 'package:growder/presentation/save_screen/save_Screen.dart';
bool? isShowScreen = false;

class MpBottomBarScreen extends StatefulWidget {
  final int? buttomIndex;
  bool? isGuest = false;

  // ScrollController? hometopcontroller;

  MpBottomBarScreen({
    required this.buttomIndex,
    this.isGuest,

    /* this.hometopcontroller */
  });

  @override
  State<MpBottomBarScreen> createState() => _MpBottomBarScreenState();
}

ScrollController scrollController = ScrollController();

class _MpBottomBarScreenState extends State<MpBottomBarScreen> {
  bool keyboardOpen = false;
  var ProfileURL = "";
  int selectedIndex = 0;
  var IsGuestUserEnabled;
  var GetTimeSplash;
  var UserLogin_ID;

  List widgetOptions = [
    MpHomeScreen(),
    PaymentAndChargeScreen(),
    PaymentAndChargeScreen(),
    PaymentAndChargeScreen(),
    PaymentAndChargeScreen(),
    PaymentAndChargeScreen(),
  ];
  late StreamSubscription _connectionChangeStream;
  bool isOffline = false;
  @override
  void initState() {
    super.initState();
  }

  /* void connectionChanged(dynamic hasConnection) {
    super.setState(() {
      isOffline = !hasConnection;
    });
  }
 */
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return (isOffline)
        ? const Text("NOt Connected")
        : WillPopScope(
            onWillPop: () async => true,
            child: Scaffold(
              bottomNavigationBar: BottomAppBar(
                height: 60,
                shape: const CircularNotchedRectangle(),
                child: Padding(
                  padding: const EdgeInsets.only(top: 0, bottom: 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      GestureDetector(
                        onTap: () {
                          super.setState(() {
                            print("objecaaaaaaaaaaaaaaaaat");
                            scrollController.animateTo(0,
                                duration: Duration(milliseconds: 500),
                                curve: Curves.easeInOut);

                            selectedIndex = 0;
                          });
                        },
                        child: Container(
                          height: 50,
                          width: 50,
                          child: Container(
                            child: selectedIndex != 0
                                ? Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: Image.asset(ImageConstant.homePng
                                        // height: 50,
                                        // width: 30,
                                        ),
                                  )
                                : Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: Container(
                                      // height: 50,
                                      // width: 60,
                                      // ignore: sort_child_properties_last
                                      child: Image.asset(
                                        ImageConstant.homePng,
                                        color: ColorConstant.primary_color,
                                      ),
                                      decoration: const BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(50)),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Color(0xFFFFE9E9),
                                            spreadRadius: 9,
                                            blurRadius: 0,
                                            offset: Offset(0, 2),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          super.setState(() {
                            
                              selectedIndex = 1;
                          
                          });
                        },
                        child: Container(
                          height: 50,
                          width: 50,
                          child: Container(
                            child: selectedIndex != 1
                                ? Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: Image.asset(
                                      ImageConstant.productimage,
                                      // height: 30,
                                      // width: 25,
                                    ),
                                  )
                                : Container(
                                    // height: 30,
                                    // width: 25,
                                    child: Padding(
                                      padding: const EdgeInsets.all(12.0),
                                      child: Image.asset(
                                        ImageConstant.productimage,
                                        color: ColorConstant.primary_color,
                                      ),
                                    ),
                                    decoration: const BoxDecoration(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(50)),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Color(0xFFFFE9E9),
                                          spreadRadius: 0,
                                          blurRadius: 0,
                                          offset: Offset(0, 2),
                                        ),
                                      ],
                                    ),
                                  ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          super.setState(() {
                            // if (UserLogin_ID != null) {
                            selectedIndex = 2;
                            // } else {
                            //   NaviRegisterScreen();
                            // }
                          });
                        },
                        child: Container(
                          height: 50,
                          width: 50,
                          child: Container(
                            child: selectedIndex != 2
                                ? Padding(
                                    padding: const EdgeInsets.all(13.0),
                                    child: Image.asset(
                                      ImageConstant.cartimage,
                                      color: Colors.grey.shade800,
                                      // height: 24,
                                      // width: 24,
                                    ),
                                  )
                                : Container(
                                    height: 30,
                                    width: 30,
                                    child: Padding(
                                      padding: const EdgeInsets.all(13.0),
                                      child: Image.asset(
                                        ImageConstant.cartimage,
                                        color: ColorConstant.primary_color,
                                        // height: 24,
                                        // width: 24,
                                      ),
                                    ),
                                    decoration: const BoxDecoration(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(50)),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Color(0xFFFFE9E9),
                                          spreadRadius: 0,
                                          blurRadius: 0,
                                          offset: Offset(0, 2),
                                        ),
                                      ],
                                    ),
                                  ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          super.setState(() {
                             
                              selectedIndex = 3;
                            
                          });
                        },
                        child: Container(
                          height: 50,
                          width: 50,
                          child: Container(
                            child: selectedIndex != 3
                                ? Padding(
                                    padding: const EdgeInsets.all(13.0),
                                    child: Image.asset(
                                      ImageConstant.wishlistimage,
                                    ),
                                  )
                                : Container(
                                    child: Padding(
                                      padding: const EdgeInsets.all(13.0),
                                      child: Image.asset(
                                        ImageConstant.wishlistimage,
                                        color: ColorConstant.primary_color,
                                      ),
                                    ),
                                    decoration: const BoxDecoration(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(50)),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Color(0xFFFFE9E9),
                                          spreadRadius: 0,
                                          blurRadius: 0,
                                          offset: Offset(0, 2),
                                        ),
                                      ],
                                    ),
                                  ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          super.setState(() {
                           
                              selectedIndex = 4;
                            
                          });
                        },
                        child: Container(
                          height: 50,
                          width: 50,
                          child: Container(
                            child: selectedIndex != 4
                                ? Padding(
                                    padding: const EdgeInsets.all(13.0),
                                    child: Image.asset(
                                      ImageConstant.orderimage,
                                      height: 30,
                                      width: 26,
                                    ),
                                  )
                                : Container(
                                    height: 30,
                                    width: 30,
                                    child: Padding(
                                      padding: const EdgeInsets.all(13.0),
                                      child: Image.asset(
                                        ImageConstant.orderimage,
                                        color: ColorConstant.primary_color,
                                      ),
                                    ),
                                    decoration: const BoxDecoration(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(50)),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Color(0xFFFFE9E9),
                                          spreadRadius: 0,
                                          blurRadius: 0,
                                          offset: Offset(0, 2),
                                        ),
                                      ],
                                    ),
                                  ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          super.setState(() {
                            
                              selectedIndex = 5;
                            
                          });
                        },
                        child: Container(
                          height: 50,
                          width: 50,
                          child: Container(
                            child: selectedIndex != 5
                                ? Padding(
                                    padding: const EdgeInsets.all(14.0),
                                    child: Image.asset(
                                      ImageConstant.userimage,
                                      height: 30,
                                      width: 26,
                                    ),
                                  )
                                : Container(
                                    height: 30,
                                    width: 30,
                                    child: Padding(
                                      padding: const EdgeInsets.all(14.0),
                                      child: Image.asset(
                                        ImageConstant.userimage,
                                        color: ColorConstant.primary_color,
                                      ),
                                    ),
                                    decoration: const BoxDecoration(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(50)),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Color(0xFFFFE9E9),
                                          spreadRadius: 0,
                                          blurRadius: 0,
                                          offset: Offset(0, 2),
                                        ),
                                      ],
                                    ),
                                  ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              body: widgetOptions[selectedIndex],
            ),
          );
  }

  checkGuestUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    UserLogin_ID = prefs.getString(PreferencesKey.loginUserID);
  }

  NaviRegisterScreen() {
    Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => RegisterCreateAccountScreen()));
  }
}
