// ignore_for_file: must_be_immutable, sort_child_properties_last

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:pds/connection_status/connection_status_singleton.dart';
import 'package:pds/core/utils/image_constant.dart';
import 'package:pds/core/utils/sharedPreferences.dart';
import 'package:pds/presentation/%20new/Inbox_screen.dart';
import 'package:pds/presentation/%20new/home_screen_new.dart';
import 'package:pds/presentation/%20new/notifaction2.dart';
import 'package:pds/presentation/register_create_account_screen/register_create_account_screen.dart';
import 'package:pds/presentation/rooms/rooms_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'SearchBar_screen.dart';

// import 'package:growder/presentation/Buy_Screen/Buy_screen.dart';
// import 'package:growder/presentation/Profile_Screen/Profile_screen.dart';

// import 'package:growder/presentation/save_screen/save_Screen.dart';

class NewBottomBar extends StatefulWidget {
  final int? buttomIndex;
  bool? isGuest = false;

  NewBottomBar({required this.buttomIndex, this.isGuest});

  @override
  State<NewBottomBar> createState() => _NewBottomBarState();
}

class _NewBottomBarState extends State<NewBottomBar> {
  bool keyboardOpen = false;
  var ProfileURL = "";
  int selectedIndex = 0;
  var IsGuestUserEnabled;
  var GetTimeSplash;
  var UserLogin_ID;

  List widgetOptions = [
    // HomeScreen(),
    HomeScreenNew(),
    RoomsScreen(),
    // HistoryScreen(),
    SearchBarScreen(value2: 1),
    // NotificationsScreen(),

    InboxScreen(),
    NewNotifactionScreen(),
    // SettingScreen(),

    // ViewDetailsScreen(),
    // ViewCommentScreen(),
    // // BuyScreen(),
    // RoomMembersScreen(),
    // RoomsScreen()
  ];

  late StreamSubscription _connectionChangeStream;

  bool isOffline = false;
  @override
  void initState() {
    super.initState();
    checkGuestUser();
    ConnectionStatusSingleton connectionStatus =
        ConnectionStatusSingleton.getInstance();
    _connectionChangeStream =
        connectionStatus.connectionChange.listen(connectionChanged);
    selectedIndex = widget.buttomIndex!;
  }

  void connectionChanged(dynamic hasConnection) {
    setState(() {
      isOffline = !hasConnection;
    });
  }

  @override
  Widget build(BuildContext context) {
    return (isOffline)
        ? const Text("NOt Connected")
        : WillPopScope(
            onWillPop: () async => true,
            child: Scaffold(
              resizeToAvoidBottomInset: false,
              floatingActionButton: const Stack(
                children: [],
              ),
              bottomNavigationBar: BottomAppBar(
                // color: Colors.amber,
                // color: Theme.of(context).brightness == Brightness.light
                //     ? const Color(0xFFFFFFFF)
                //     : const Color(0xFF0D0D0D),
                height: 65,
                shape: const CircularNotchedRectangle(),
                child: Padding(
                  padding: const EdgeInsets.only(top: 0, bottom: 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            // setUI();
                            selectedIndex = 0;
                          });
                        },
                        child: Container(
                          // color: Colors.amber,
                          // color:
                          //     Theme.of(context).brightness == Brightness.light
                          //         ? const Color(0xFFFFFFFF)
                          //         : const Color(0xFF0D0D0D),
                          height: 50,
                          width: 50,
                          child: Container(
                            child: selectedIndex != 0
                                ? Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Image.asset(ImageConstant.homePng
                                        // height: 50,
                                        // width: 30,
                                        ),
                                  )
                                : Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Container(
                                      // height: 50,
                                      // width: 60,
                                      // ignore: sort_child_properties_last
                                      child: Image.asset(
                                        ImageConstant.homePng,
                                        color: const Color(0XFFED1C25),
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
                          setState(() {
                            if (UserLogin_ID != null) {
                              selectedIndex = 1;
                            } else {
                              NaviRegisterScreen();
                            }
                          });
                        },
                        child: Container(
                          height: 50,
                          width: 50,
                          // color: Colors.amber,
                          // color:
                          //     Theme.of(context).brightness == Brightness.light
                          //         ? const Color(0xFFFFFFFF)
                          //         : const Color(0xFF0D0D0D),
                          child: Container(
                            child: selectedIndex != 1
                                ? Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Image.asset(
                                      ImageConstant.groupPng,
                                      // height: 30,
                                      // width: 25,
                                    ),
                                  )
                                : Container(
                                    // height: 30,
                                    // width: 25,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Image.asset(
                                        ImageConstant.groupPng,
                                        color: const Color(0XFFED1C25),
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
                          setState(() {
                            if (UserLogin_ID != null) {
                              selectedIndex = 2;
                            } else {
                              NaviRegisterScreen();
                            }
                          });
                        },
                        child: Container(
                          height: 50,
                          width: 50,
                          // color: Colors.amber,
                          // color:
                          // Theme.of(context).brightness == Brightness.light
                          //     ? const Color(0xFFFFFFFF)
                          //     : const Color(0xFF0D0D0D),
                          child: Container(
                            child: selectedIndex != 2
                                ? Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: Image.asset(
                                      ImageConstant.serchpng,
                                      color: Colors.grey.shade800,
                                      // height: 24,
                                      // width: 24,
                                    ),
                                  )
                                : Container(
                                    height: 30,
                                    width: 30,
                                    child: Padding(
                                      padding: const EdgeInsets.all(12.0),
                                      child: Image.asset(
                                        ImageConstant.serchpng,
                                        color: const Color(0XFFED1C25),
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
                          setState(() {
                            if (UserLogin_ID != null) {
                              selectedIndex = 3;
                            } else {
                              NaviRegisterScreen();
                            }
                          });
                        },
                        child: Container(
                          height: 50,
                          width: 50,
                          // color: Colors.amber,
                          // color:
                          //     Theme.of(context).brightness == Brightness.light
                          //         ? const Color(0xFFFFFFFF)
                          //         : const Color(0xFF0D0D0D),
                          child: Container(
                            child: selectedIndex != 3
                                ? Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: Image.asset(
                                      ImageConstant.meesagePng,
                                      // height: 26,
                                      // width: 26,
                                    ),
                                  )
                                : Container(
                                    // height: 30,
                                    // width: 30,
                                    child: Padding(
                                      padding: const EdgeInsets.all(12.0),
                                      child: Image.asset(
                                        ImageConstant.meesagePng,
                                        color: const Color(0XFFED1C25),
                                        // height: 26,
                                        // width: 26,
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
                          setState(() {
                            if (UserLogin_ID != null) {
                              selectedIndex = 4;
                            } else {
                              NaviRegisterScreen();
                            }
                          });
                        },
                        child: Container(
                          height: 50,
                          width: 50,
                          // color: Colors.amber,
                          // color:
                          //     Theme.of(context).brightness == Brightness.light
                          //         ? const Color(0xFFFFFFFF)
                          //         : const Color(0xFF0D0D0D),
                          child: Container(
                            // height: 35,
                            child: selectedIndex != 4
                                ? Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Image.asset(
                                      ImageConstant.nottifactionpng,
                                      height: 30,
                                      width: 26,
                                    ),
                                  )
                                : Container(
                                    // color: Colors.indigo,
                                    height: 30,
                                    width: 30,
                                    child: Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Image.asset(
                                        ImageConstant.nottifactionpng,
                                        color: const Color(0XFFED1C25),
                                        // fit: BoxFit.cover,
                                        // fit: BoxFit.scaleDown,
                                        // height: 30,
                                        // width: 26,
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
