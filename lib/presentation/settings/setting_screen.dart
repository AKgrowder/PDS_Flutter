import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pds/API/Bloc/DeleteUser_Bloc/DeleteUser_cubit.dart';
import 'package:pds/API/Bloc/Forget_password_Bloc/forget_password_cubit.dart';
import 'package:pds/API/Bloc/logOut_bloc/logOut_cubit.dart';
import 'package:pds/API/Bloc/my_account_Bloc/my_account_cubit.dart';
import 'package:pds/presentation/change_password_screen/change_password_screen.dart';
import 'package:pds/presentation/settings/LogOut_dailog.dart';
import 'package:pds/widgets/delete_dailog.dart';
import 'package:pds/widgets/rateUS_dailog.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/utils/image_constant.dart';
import '../../core/utils/sharedPreferences.dart';
import '../../widgets/app_bar/custom_app_bar.dart';
import '../my account/my_account_screen.dart';
import '../policy_of_company/policy_screen.dart';
import '../policy_of_company/privecy_policy.dart';
import '../view_details_screen/view_public_forum_screen.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen();
  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

var status;

var Setting_Array = [
  "My Details",
  "Saved Threads",
  "Saved Pins",
  "Change Password",
  "Prefrences",
  "Support",
  "Policies",
  "Invite Friends",
  "Rate Us",
  "Delete Account",
  "Log Out",
];

// var Setting_Array2 = [
//   "My Details",
//   "Theme",
//   "Support",
//   "Policies",
//   "Rate Us",
// ];

var SettingImage_Array = [
  ImageConstant.setting_profile,
  // ImageConstant.setting_shouteprofile,
  ImageConstant.setting_save,
  ImageConstant.pin,
  ImageConstant.setting_lock,
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

class _SettingScreenState extends State<SettingScreen> {
  String? userStatus;
  String? rejcteReson;
  bool? UserProfileOpen;
  @override
  void initState() {
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
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return MultiBlocProvider(providers: [
                                BlocProvider<MyAccountCubit>(
                                  create: (context) => MyAccountCubit(),
                                )
                              ], child: MyAccountScreen());
                            }));
                          },
                          child: Container(
                              height: 60,
                              width: MediaQuery.of(context).size.width,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Color(0xffED1C25)),
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

    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: CustomAppBar(
            height: 100,
            leadingWidth: 74,
            centerTitle: true,
            title: Container(
                height: 50.58,
                // width: getHorizontalSize(139),
                child: Stack(alignment: Alignment.bottomCenter, children: [
                  Align(
                      alignment: Alignment.topCenter,
                      child: Padding(
                          padding:
                              EdgeInsets.only(left: 21, right: 22, bottom: 24),
                          child: Text(
                            'My Account',
                            textScaleFactor: 1.0,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.left,
                            style: TextStyle(color: Colors.black),
                          ))),

                /*   IsGuestUserEnabled == "true"
                      ? SizedBox.shrink()
                      : Align(
                          alignment: Alignment.bottomCenter,
                          child: Padding(
                            padding: EdgeInsets.only(top: 22),
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text("Status:",
                                      textScaleFactor: 1.0,
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 18,
                                          fontFamily: 'Outfit',
                                          fontWeight: FontWeight.w400)),
                                  Text("${userStatus}",
                                      style: TextStyle(
                                          color: Colors.green,
                                          fontSize: 18,
                                          fontFamily: 'Outfit',
                                          fontWeight: FontWeight.w400))
                                ]),
                          )) */

                ]))),
        body: Container(
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
                  if (index == 1 || index == 2) {
                    return SizedBox();
                  }
                  return GestureDetector(
                    onTap: () {
                      switch (index) {
                        case 0:
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return MultiBlocProvider(providers: [
                              BlocProvider<MyAccountCubit>(
                                create: (context) => MyAccountCubit(),
                              )
                            ], child: MyAccountScreen());
                          }));

                          break;
                        // case 1:
                        //   // Navigator.push(
                        //   //     context,
                        //   //     MaterialPageRoute(
                        //   //         builder: (context) => OtpVerificationScreen()));

                        //   break;
                        case 1:
                          // Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //       builder: (context) => ExpertsScreen(),
                          //     ));
                          break;
                        case 2:
                          // Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //       builder: (context) => RoomMembersScreen(room_Id: ""),
                          //     ));
                          break;
                        case 3:
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return MultiBlocProvider(
                                providers: [
                                  BlocProvider<ForgetpasswordCubit>(
                                    create: (context) => ForgetpasswordCubit(),
                                  )
                                ],
                                child: ChangePasswordScreen(
                                  isProfile: true,
                                ));
                          }));
                          break;
                        case 4:
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(
                          //       builder: (context) => ChangePasswordScreen()),
                          // );

                          break;
                        case 5:
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ViewDetailsScreen()

                                  // AddDeliveryAddressScreen();
                                  ));
                          break;
                        /*    case 6:
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return PreferencesScreen();
                          }));
            
                          break; */
                        case 6:
                        Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Policies(
                                    title: " ",
                                    data: Policy_Data.privacy_policy1,
                                  ),
                                ));
                          break;
                        case 7:
                          // Navigator.push(context,
                          //     MaterialPageRoute(builder: (context) {
                          //   return RoomDetailScreen();
                          // }));

                          break;
                        case 8:
                          // Navigator.push(context,
                          //     MaterialPageRoute(builder: (context) {
                          //   return ExpertsDetailsScreen();
                          // }));

                          showDialog(
                              context: context, builder: (_) => rateUSdialog());

                          break;
                        /* case 8:
                          SnackBar snackBar = SnackBar(
                            content: Text("No Invite Friends Screen"),
                            backgroundColor: ColorConstant.orangeA700,
                          );
                          ScaffoldMessenger.of(context)
                              .showSnackBar(snackBar);
            
                          break; */
                        case 9:
                          showDialog(
                              context: context,
                              builder: (_) => BlocProvider<DeleteUserCubit>(
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
                        case 10:
                          showDialog(
                              context: context,
                              builder: (_) => BlocProvider<LogOutCubit>(
                                    create: (context) => LogOutCubit(),
                                    child: LogOutdailog(),
                                  ));

                          break;
                        // case 11:
                        //   // showDialog(
                        //   //     context: context, builder: (_) => RoomsScreen());

                        //   break;

                        /* case 6:
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) =>
                                  const RaiseQueryScreen()));
                          break;
                        case 7:
                          showDialog(
                            context: context,
                            builder: (_) => FunkyOverlay(),
                          );
                          break; */
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
                                color: Color(0XFFF6F6F6),
                                border: Border.all(
                                    width: 1,
                                    // color: ColorConstant.gray200,
                                    color: Color(0XFFEFEFEF))),
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 15, right: 15),
                                  child: Container(
                                    height: 25,
                                    width: 25,
                                    child: index == 2
                                        ? Image.asset(
                                            "${SettingImage_Array[index]}",
                                            color: Colors.grey,
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
                                      color: index == 0
                                          ? Color(0xFFED1C25)
                                          : Colors.black,
                                      fontWeight: index == 0
                                          ? FontWeight.bold
                                          : FontWeight.w500),
                                ),
                                Spacer(),
                                Padding(
                                  padding: const EdgeInsets.only(right: 0),
                                  child: Container(
                                    // color: Colors.amber,
                                    height: 30,
                                    width: 60,
                                    child: Icon(
                                      Icons.arrow_forward_ios,
                                      color:
                                          index == 0 ? Colors.red : Colors.grey,
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
      ),
    );
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
        return MultiBlocProvider(providers: [
          BlocProvider<MyAccountCubit>(
            create: (context) => MyAccountCubit(),
          )
        ], child: MyAccountScreen());
      }));
    }
    userStatus =
        userStatus != 'APPROVED' ? userStatus?.split('-').first : userStatus;

    setState(() {});
  }
}
