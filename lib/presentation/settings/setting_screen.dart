import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pds/API/Bloc/DeleteUser_Bloc/DeleteUser_cubit.dart';
import 'package:pds/API/Bloc/RateUs_Bloc/RateUs_cubit.dart';
import 'package:pds/API/Bloc/accounttype_bloc/account_cubit.dart';
import 'package:pds/API/Bloc/accounttype_bloc/account_state.dart';
import 'package:pds/API/Bloc/logOut_bloc/logOut_cubit.dart';
import 'package:pds/core/utils/color_constant.dart';
import 'package:pds/presentation/%20new/Blocked_userList_screen.dart';
import 'package:pds/presentation/Comapny_page/Comapny_manage_screen.dart';
import 'package:pds/presentation/change_password_screen/change_password_screen.dart';
import 'package:pds/presentation/settings/LogOut_dailog.dart';
import 'package:pds/widgets/delete_dailog.dart';
import 'package:pds/widgets/rateUS_dailog.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../core/utils/image_constant.dart';
import '../../core/utils/sharedPreferences.dart';
import '../Support_screens/support_screen.dart';
import '../my account/my_account_screen.dart';
import '../policy_of_company/policies.dart';

class SettingScreen extends StatefulWidget {
  String accountType;
  String module;

  SettingScreen({required this.accountType, required this.module});
  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

var status;
var directory = getApplicationDocumentsDirectory();
var Setting_Array = [
  // "My Details",
  "Saved Threads",
  "Saved Pins",
  "Change Password",
  "Prefrences",
  "Support",
  "Policies",
  "Invite Friends",
  "Rate Us",
  "Delete Account",
  "Manage Company Page",
  "Public & Private Profile",
  "Block User",
  "Log Out",

  /* "Change Password",
  "Public & Private Profile",
  "Block User",
  "Policies",
  "Invite Friends",
  "Rate Us",
  "Delete Account",
  "Log Out", */
];

// var Setting_Array2 = [
//   "My Details",
//   "Theme",
//   "Support",
//   "Policies",
//   "Rate Us",
// ];

var SettingImage_Array = [
  // ImageConstant.setting_profile,
  // ImageConstant.setting_shouteprofile,

  ImageConstant.setting_save,
  ImageConstant.pin,
  // ImageConstant.setting_lock,
  ImageConstant.profileLock,
  ImageConstant.setting_settingimage,

  ImageConstant.setting_phone,
  // ImageConstant.Raised_Tickets,
  // ImageConstant.Delete,
  // ImageConstant.Prefrences,
  ImageConstant.setting_lock,
  ImageConstant.setting_share,
  ImageConstant.setting_star,
  // ImageConstant.Invite_Friends,
  ImageConstant.setting_delete,
  ImageConstant.setting_comanyManage,
  ImageConstant.profileLock, ImageConstant.block_user,
  ImageConstant.setting_power,

  // ImageConstant.setting_power,
  // ImageConstant.setting_phone,
];

// var SettingImage_Array2 = [
//   ImageConstant.pin,
//   ImageConstant.pin,
//   ImageConstant.pin,
//   ImageConstant.pin,
//   ImageConstant.pin,
// ];
var businessName;
var accountUrl;
var IsGuestUserEnabled;
var GetTimeSplash;
late String _localPath;

class _SettingScreenState extends State<SettingScreen> {
  bool? isSwitched;
  String? userStatus;
  String? rejcteReson;
  bool? UserProfileOpen;
  @override
  void initState() {
    print("accountcheck--${widget.accountType}");
    if (widget.accountType == 'PUBLIC') {
      super.setState(() {
        isSwitched = false;
      });
    } else {
      super.setState(() {
        isSwitched = true;
      });
    }
    getUserStausFuction();
    Future.delayed(Duration.zero, () {
      print('userStatus-$userStatus');
      if (userStatus == 'REJECTED') {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              content: SizedBox(
                  height: 570,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.asset(ImageConstant.rejctedPic),
                        SizedBox(
                          height: 30,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Text(
                            'Your Profile is rejected',
                            style:
                                TextStyle(fontSize: 25, fontFamily: 'Outfit'),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          'Reason:',
                          style: TextStyle(fontSize: 18, fontFamily: 'Outfit'),
                        ),
                        SizedBox(
                          height: 1,
                        ),
                        Container(
                          height: 80,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                              border: Border.all(color: Color(0xffE8E8E8)),
                              borderRadius: BorderRadius.circular(10)),
                          child: Padding(
                            padding: const EdgeInsets.only(top: 10, left: 10),
                            child: Text('${rejcteReson}'),
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return MyAccountScreen();
                            }));
                          },
                          child: Container(
                              height: 60,
                              width: MediaQuery.of(context).size.width,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: ColorConstant.primary_color),
                              child: Text(
                                'Please update',
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              )),
                        )
                      ])),
            );
          },
        );
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var _height = MediaQuery.of(context).size.height;
    var _width = MediaQuery.of(context).size.width;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back,
            color: Colors.grey,
          ),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
        actions: [
          Transform.translate(
            offset: Offset(
              200,
              -110,
            ),
            child: Container(
              height: 240,
              width: 150,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  //  color: Colors.amber,
                  boxShadow: [
                    BoxShadow(
                        // color: Colors.black,
                        color: Color(0xffFFE9E9),
                        blurRadius: 90,
                        spreadRadius: 150),
                  ]),
            ),
          )
        ],
        title: Text(
          "Settings",
          style: TextStyle(
            // fontFamily: 'outfit',
            color: Colors.black, fontWeight: FontWeight.bold,
            fontSize: 25,
          ),
        ),
        centerTitle: true,
      ),
      body: BlocConsumer<AccountCubit, AccountState>(
        listener: (context, state) {
          if (state is AccountLoadedState) {
            SnackBar snackBar = SnackBar(
              content: Text(state.accountType.object.toString()),
              backgroundColor: ColorConstant.primary_color,
            );
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          }
          if (state is AccountErrorState) {
            SnackBar snackBar = SnackBar(
              content: Text(state.error.toString()),
              backgroundColor: ColorConstant.primary_color,
            );
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          }
        },
        builder: (context, state) {
          return Stack(
            children: [
              Container(
                height: _height / 1,
                child: ListView.builder(
                    primary: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: 5,
                    shrinkWrap: true,
                    itemBuilder: ((context, index) => index % 2 == 0
                        ? Transform.translate(
                            offset: Offset(index == 0 ? -300 : -350,
                                index == 0 ? -90 : 150),
                            child: Container(
                              height: 240,
                              width: 150,
                              margin:
                                  EdgeInsets.only(top: index == 0 ? 0 : 600),
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  //  color: Colors.amber,
                                  boxShadow: [
                                    BoxShadow(
                                        // color: Colors.black,
                                        color: Color(0xffFFE9E9),
                                        blurRadius: 70,
                                        spreadRadius: 150),
                                  ]),
                            ),
                          )
                        : Transform.translate(
                            offset: Offset(index == 0 ? 50 : 290, 90),
                            child: Container(
                              height: 190,
                              width: 150,
                              margin: EdgeInsets.only(top: 400),
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  // color: Colors.red,
                                  boxShadow: [
                                    BoxShadow(
                                        // color: Colors.red,
                                        color: Color(0xffFFE9E9),
                                        blurRadius: 70.0,
                                        spreadRadius: 110),
                                  ]),
                            ),
                          ))),
              ),
              Container(
                  height: _height - 100,
                  color: Colors.white.withOpacity(0.2),
                  // color: Theme.of(context).brightness == Brightness.light
                  // ? Color(0XFF161616)
                  // : Color(0XFF1D1D1D),
                  child: ListView.builder(
                      shrinkWrap: true,
                      physics: BouncingScrollPhysics(),
                      itemCount: Setting_Array.length,
                      itemBuilder: (BuildContext context, int index) {
                        if (index == 1 ||
                                index == 4 ||
                                index == 0 ||
                                index ==
                                    3 /* ||
                            index == 10 */
                            ) {
                          return SizedBox();
                        }
                        if (widget.module != 'COMPANY' && index == 9) {
                          return SizedBox();
                        }
                        return GestureDetector(
                          onTap: () {
                            switch (index) {
                              /*  case 0:
                                    Navigator.push(context,
                                        MaterialPageRoute(builder: (context) {
                                      return MyAccountScreen();
                                    }));
      
                                    break; */
                              // case 1:
                              //   // Navigator.push(
                              //   //     context,
                              //   //     MaterialPageRoute(
                              //   //         builder: (context) => OtpVerificationScreen()));

                              //   break;
                              case 0:
                                // Navigator.push(
                                //     context,
                                //     MaterialPageRoute(
                                //       builder: (context) => ExpertsScreen(),
                                //     ));
                                break;
                              case 1:
                                // Navigator.push(
                                //     context,
                                //     MaterialPageRoute(
                                //       builder: (context) => RoomMembersScreen(room_Id: ""),
                                //     ));
                                break;
                              case 2:
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) {
                                  return ChangePasswordScreen(
                                    isProfile: true,
                                  );
                                }));
                                break;
                              case 3:
                                // Navigator.push(
                                //   context,
                                //   MaterialPageRoute(
                                //       builder: (context) => ChangePasswordScreen()),
                                // );

                                break;
                              case 4:
                                // launchEmail();
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) {
                                  return SupportScreen();
                                }));
                                break;
                              /*    case 6:
                                    Navigator.push(context,
                                        MaterialPageRoute(builder: (context) {
                                      return PreferencesScreen();
                                    }));
                      
                                    break; */
                              case 5:
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) {
                                  return PoliciesScreen();
                                }));
                                break;
                              case 6:
                                // Share.share(
                                //     'https://play.google.com/store/apps/details?id=com.pds.app');

                                _onShareXFileFromAssets(context);
                                // Navigator.push(context,
                                //     MaterialPageRoute(builder: (context) {
                                //   return RoomDetailScreen();
                                // }));

                                break;
                              case 7:
                                // Navigator.push(context,
                                //     MaterialPageRoute(builder: (context) {
                                //   return ExpertsDetailsScreen();
                                // }));
                                showDialog(
                                    context: context,
                                    builder: (_) => BlocProvider<RateUsCubit>(
                                          create: (context) {
                                            return RateUsCubit();
                                          },
                                          child: rateUSdialog(),
                                        ));

                                break;
                              /* case 8:
                                    SnackBar snackBar = SnackBar(
                                      content: Text("No Invite Friends Screen"),
                                      backgroundColor: ColorConstant.orangeA700,
                                    );
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(snackBar);
                      
                                    break; */
                              case 8:
                                showDialog(
                                    context: context,
                                    builder: (_) =>
                                        BlocProvider<DeleteUserCubit>(
                                          create: (context) {
                                            return DeleteUserCubit();
                                          },
                                          child: DeleteUserdailog(),
                                        ));

                                // showDialog(
                                //     context: context, builder: (_) => RoomsScreen());
                                /*  SnackBar snackBar = SnackBar(
                                      content: Text("No Rate US Screen"),
                                      backgroundColor: ColorConstant.orangeA700,
                                    );
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(snackBar); */

                                break;
                              case 9:
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) {
                                  return ComapnyManageScreen();
                                }));
                                print("profile");
                                break;
                              case 10:
                              print("this is the 10");
                                break;
                              // case 11:
                              //   // showDialog(
                              //   //     context: context, builder: (_) => RoomsScreen());

                              //   break;

                              case 11:
                                print("this is the 10");
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) =>
                                        const BlockedUserScreen()));

                                break;

                              case 12:
                                showDialog(
                                    context: context,
                                    builder: (_) => BlocProvider<LogOutCubit>(
                                          create: (context) => LogOutCubit(),
                                          child: LogOutdailog(),
                                        ));

                                break;
                              /*   case 7:
                                    showDialog(
                                      context: context,
                                      builder: (_) => FunkyOverlay(),
                                    ); 
                                    break;  */
                              default:
                            }
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: 16, right: 16, top: 8, bottom: 8),
                            child: Column(
                              children: [
                                Container(
                                  height: 60,
                                  width: _width,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      // color: ColorConstant.CategoriesBackColor,
                                      color: ColorConstant.primaryLight_color,
                                      border: Border.all(
                                          width: 1,
                                          // color: ColorConstant.gray200,
                                          color: Color(0XFFFFB0B3))),
                                  child: Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 10, right: 10),
                                        child: Container(
                                          height: 25,
                                          width: 25,
                                          child: index == 2
                                              ? Image.asset(
                                                  "${SettingImage_Array[index]}",
                                                  color: Color(0xFF3F3F3F),
                                                )
                                              : Image.asset(
                                                  "${SettingImage_Array[index]}",
                                                ),
                                        ),
                                      ),
                                      Text(
                                        "${Setting_Array[index]}",
                                        style: TextStyle(
                                            fontFamily: 'outfit',
                                            fontSize: 18,
                                            color: Color(0xFF3F3F3F),
                                            fontWeight: FontWeight.w500),
                                      ),
                                      Spacer(),
                                      index == 10
                                          ? Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 10),
                                              child: FlutterSwitch(
                                                width: 60.0,
                                                height: 30.0,
                                                value: isSwitched!,
                                                activeToggleColor:
                                                    ColorConstant.primary_color,
                                                activeColor: Colors.white,
                                                onToggle: (val) async {
                                                  print(
                                                      "check after--$isSwitched");
                                                  super.setState(() {
                                                    isSwitched = val;
                                                  });
                                                  print(
                                                      "check Data--$isSwitched");
                                                  if (isSwitched == true) {
                                                    //PRIVATE
                                                    await BlocProvider.of<
                                                                AccountCubit>(
                                                            context)
                                                        .accountTypeApi(
                                                            'PRIVATE', context);
                                                  } else {
                                                    await BlocProvider.of<
                                                                AccountCubit>(
                                                            context)
                                                        .accountTypeApi(
                                                            'PUBLIC', context);
                                                  }
                                                },
                                              ),
                                            )
                                          : Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 0),
                                              child: Container(
                                                // color: Colors.amber,
                                                height: 30,
                                                width: 60,
                                                child: Icon(
                                                  Icons.arrow_forward_ios,
                                                  color: Color(0xFF3F3F3F),
                                                ),
                                              ),
                                            ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      })),
            ],
          );
        },
      ),
    );
  }

  dynamic launchEmail() async {
    try {
      Uri email = Uri(
        scheme: 'mailto',
        path: "Connect@inpackaging.com",
      );

      await launchUrl(email);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  getUserStausFuction() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    userStatus = await prefs.getString(PreferencesKey.userStatus);
    UserProfileOpen = await prefs.getBool(PreferencesKey.OpenProfile);
    if (userStatus != 'APPROVED') {
      rejcteReson = userStatus?.split('-').last;
    }
    if (UserProfileOpen == true) {
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return MyAccountScreen();
      }));
    }
    userStatus =
        userStatus != 'APPROVED' ? userStatus?.split('-').first : userStatus;

    super.setState(() {});
  }

  void _onShareXFileFromAssets(BuildContext context) async {
    RenderBox? box = context.findAncestorRenderObjectOfType();
    var directory = await getApplicationDocumentsDirectory();
    if (Platform.isAndroid) {
      await Share.shareXFiles(
        [XFile("/sdcard/download/IP__image.jpg")],
        subject: "Share",
        text:
            "Try This Awesome App \n\n Android :- https://play.google.com/store/apps/details?id=com.ip.app",
        sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size,
      );
    } else {
      await Share.shareXFiles(
        [
          XFile(directory.path +
              Platform.pathSeparator +
              'Growder_Image/IP__image.jpg')
        ],
        subject: "Share",
        text:
            "Try This Awesome App \n\n iOS :- https://apps.apple.com/in/app/inpackaging-knowledge-forum/id6478194670",
        sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size,
      );
    }
  }
}
