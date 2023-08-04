import 'dart:async';

import 'package:archit_s_application1/core/utils/sharedPreferences.dart';
import 'package:archit_s_application1/presentation/home/home.dart';
import 'package:archit_s_application1/presentation/register_create_account_screen/register_create_account_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

// import 'package:growder/presentation/Buy_Screen/Buy_screen.dart';
// import 'package:growder/presentation/Profile_Screen/Profile_screen.dart';

import '../connection_status/connection_status_singleton.dart';
import '../core/utils/image_constant.dart';
import '../presentation/history_screen/history_screen.dart';
import '../presentation/notifications/notification_screen.dart';
import '../presentation/rooms/rooms_screen.dart';
import '../presentation/settings/setting_screen.dart';
// import 'package:growder/presentation/save_screen/save_Screen.dart';

class BottombarPage extends StatefulWidget {
  final int? buttomIndex;
  bool? isGuest = false;

  BottombarPage({required this.buttomIndex, this.isGuest});

  @override
  State<BottombarPage> createState() => _BottombarPageState();
}

class _BottombarPageState extends State<BottombarPage> {
  bool keyboardOpen = false;
  var ProfileURL = "";
  int selectedIndex = 0;
  var IsGuestUserEnabled;
  var GetTimeSplash;
  var UserLogin_ID;

  List widgetOptions = [
    HomeScreen(),
    RoomsScreen(),
    HistoryScreen(),
    NotificationsScreen(),
    SettingScreen(),

    // ViewDetailsScreen(),
    // ViewCommentScreen(),
    // // BuyScreen(),
    // RoomMembersScreen(),
    // RoomsScreen()
  ];

  late StreamSubscription _connectionChangeStream;

  bool isOffline = false;
  @override
  initState() {
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
        ? Text("NOt Connected")
        : WillPopScope(
            onWillPop: () async => false,
            child: Scaffold(
              resizeToAvoidBottomInset: false,
              floatingActionButton: Stack(
                children: const [],
              ),
              bottomNavigationBar: BottomAppBar(
                // color: Color(0xFFFFFFFF),
                color: Theme.of(context).brightness == Brightness.light
                    ? Color(0xFFFFFFFF)
                    : Color(0xFF0D0D0D),
                height: 70,
                shape: const CircularNotchedRectangle(),
                child: Padding(
                  padding: EdgeInsets.only(top: 17, bottom: 0),
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
                          // color: Colors.white,
                          color:
                              Theme.of(context).brightness == Brightness.light
                                  ? Color(0xFFFFFFFF)
                                  : Color(0xFF0D0D0D),
                          height: 55,
                          width: 40,
                          child: Column(
                            children: [
                              Container(
                                child: selectedIndex != 0
                                    ? Image.asset(
                                        "${ImageConstant.bottomhome}",
                                        height: 30,
                                        width: 30,
                                      )
                                    : Container(
                                        height: 30,
                                        width: 30,
                                        child: Column(
                                          children: [
                                            Image.asset(
                                              "${ImageConstant.bottomhome}",
                                              color: Color(0XFFED1C25),
                                            ),
                                          ],
                                        ),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(20),
                                              topRight: Radius.circular(20),
                                              bottomLeft: Radius.circular(20),
                                              bottomRight: Radius.circular(20)),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Color.fromARGB(
                                                  255, 250, 166, 170),
                                              spreadRadius: 5,
                                              blurRadius: 7,
                                              offset: Offset(0, 3),
                                            ),
                                          ],
                                        ),
                                      ),
                              ),
                              Spacer(),
                            ],
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
                          height: 65,
                          width: 40,
                          // color: Colors.white,
                          color:
                              Theme.of(context).brightness == Brightness.light
                                  ? Color(0xFFFFFFFF)
                                  : Color(0xFF0D0D0D),
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 3.0),
                                child: Container(
                                  child: selectedIndex != 1
                                      ? Image.asset(
                                          "${ImageConstant.bottomgroup}",
                                          height: 30,
                                          width: 25,
                                        )
                                      : Padding(
                                          padding: const EdgeInsets.only(
                                              bottom: .0, top: 0),
                                          child: Container(
                                            height: 30,
                                            width: 25,
                                            child: Column(
                                              children: [
                                                Image.asset(
                                                  "${ImageConstant.bottomgroup}",
                                                  color: Color(0XFFED1C25),
                                                  height: 30,
                                                ),
                                              ],
                                            ),
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.only(
                                                  topLeft: Radius.circular(40),
                                                  topRight: Radius.circular(40),
                                                  bottomLeft:
                                                      Radius.circular(40),
                                                  bottomRight:
                                                      Radius.circular(40)),
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Color.fromARGB(
                                                      255, 250, 166, 170),
                                                  spreadRadius: 5,
                                                  blurRadius: 7,
                                                  offset: Offset(0, 3),
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
                          height: 65,
                          width: 40,
                          // color: Colors.white,
                          color:
                              Theme.of(context).brightness == Brightness.light
                                  ? Color(0xFFFFFFFF)
                                  : Color(0xFF0D0D0D),
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 5),
                                child: Container(
                                  child: selectedIndex != 2
                                      ? Image.asset(
                                          "${ImageConstant.bottomtimer}",
                                          height: 24,
                                          width: 24,
                                        )
                                      : Container(
                                          height: 30,
                                          width: 30,
                                          child: Column(
                                            children: [
                                              Image.asset(
                                                "${ImageConstant.bottomtimer}",
                                                color: Color(0XFFED1C25),
                                                height: 24,
                                                width: 24,
                                              ),
                                            ],
                                          ),
                                          decoration: BoxDecoration(
                                            // color: Colors.white,
                                            borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(20),
                                                topRight: Radius.circular(20),
                                                bottomLeft: Radius.circular(20),
                                                bottomRight:
                                                    Radius.circular(20)),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Color.fromARGB(
                                                    255, 250, 166, 170),
                                                spreadRadius: 5,
                                                blurRadius: 7,
                                                offset: Offset(0, 3),
                                              )
                                            ],
                                          ),
                                        ),
                                ),
                              ),
                              Spacer(),
                            ],
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
                          height: 65,
                          width: 40,
                          // color: Colors.white,
                          color:
                              Theme.of(context).brightness == Brightness.light
                                  ? Color(0xFFFFFFFF)
                                  : Color(0xFF0D0D0D),
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 5),
                                child: Container(
                                  child: selectedIndex != 3
                                      ? Image.asset(
                                          "${ImageConstant.bottombell}",
                                          height: 26,
                                          width: 26,
                                        )
                                      : Container(
                                          height: 30,
                                          width: 30,
                                          child: Column(
                                            children: [
                                              Image.asset(
                                                "${ImageConstant.bottombell}",
                                                color: Color(0XFFED1C25),
                                                height: 26,
                                                width: 26,
                                              ),
                                            ],
                                          ),
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(20),
                                                topRight: Radius.circular(20),
                                                bottomLeft: Radius.circular(20),
                                                bottomRight:
                                                    Radius.circular(20)),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Color.fromARGB(
                                                    255, 250, 166, 170),
                                                spreadRadius: 5,
                                                blurRadius: 7,
                                                offset: Offset(0, 3),
                                              ),
                                            ],
                                          ),
                                        ),
                                ),
                              ),
                              Spacer(),
                            ],
                          ),
                        ),
                      ),
                      // / ------------------------------------------------------------------
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
                          height: 65,
                          width: 40,
                          // color: Colors.white,
                          color:
                              Theme.of(context).brightness == Brightness.light
                                  ? Color(0xFFFFFFFF)
                                  : Color(0xFF0D0D0D),
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 5),
                                child: Container(
                                  // height: 35,
                                  child: selectedIndex != 4
                                      ? Image.asset(
                                          "${ImageConstant.bottomprofile}",
                                          height: 26,
                                          width: 26,
                                        )
                                      : Container(
                                          // color: Colors.indigo,
                                          height: 30,
                                          width: 30,
                                          child: Column(
                                            children: [
                                              Image.asset(
                                                "${ImageConstant.bottomprofile}",
                                                color: Color(0XFFED1C25),
                                                // fit: BoxFit.cover,
                                                // fit: BoxFit.scaleDown,
                                                height: 26,
                                                width: 26,
                                              ),
                                            ],
                                          ),
                                          decoration: BoxDecoration(
                                            // color: Colors.white,
                                            borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(20),
                                                topRight: Radius.circular(20),
                                                bottomLeft: Radius.circular(20),
                                                bottomRight:
                                                    Radius.circular(20)),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Color.fromARGB(
                                                    255, 250, 166, 170),
                                                //  Colors.grey.withOpacity(0.5),
                                                spreadRadius: 5,
                                                blurRadius: 7,
                                                offset: Offset(0,
                                                    3), // changes position of shadow
                                              ),
                                            ],
                                          ),
                                        ),
                                ),
                              ),
                              Spacer(),
                            ],
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
