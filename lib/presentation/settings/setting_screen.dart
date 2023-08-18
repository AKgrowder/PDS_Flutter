import 'package:archit_s_application1/presentation/experts_details_screen/experts_details_screen.dart';
import 'package:flutter/material.dart';

import '../../core/utils/image_constant.dart';
import '../../widgets/app_bar/custom_app_bar.dart';
import '../experts/experts_screen.dart';
import '../forget_password_screen/forget_password_screen.dart';
import '../my account/my_account_screen.dart';
import '../rooms/room_details_screen.dart';
import '../view_details_screen/view_public_forum_screen.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen();
  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

var status;

var Setting_Array = [
  "My Details",
  "Forum Details",
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
  ImageConstant.setting_shouteprofile,
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
  ImageConstant.setting_power,
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
  @override
  void initState() {
    // BlocProvider.of<StatusCubit>(context).getStatus();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
     var _height = MediaQuery.of(context).size.height;
    var _width = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
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
                          padding: EdgeInsets.only(left: 21, right: 22, bottom: 24),
                          child: Text(
                            'My Account',
                            textScaleFactor: 1.0,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.left,
                            style: TextStyle(color: Colors.black),
                          ))),
                  IsGuestUserEnabled == "true"
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
                                  Text("Approved",
                                      style: TextStyle(
                                          color: Colors.green,
                                          fontSize: 18,
                                          fontFamily: 'Outfit',
                                          fontWeight: FontWeight.w400))
                                ]),
                          ))
                ]))),
        body: Container(
            height: _height - 100,
            color: Colors.white.withOpacity(0.2),
            // color: Theme.of(context).brightness == Brightness.light
            // ? Color(0XFF161616)
            // : Color(0XFF1D1D1D),
            child: ListView.builder(physics: BouncingScrollPhysics(),
                itemCount: 12,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () {
                      switch (index) {
                        case 0:
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>  MyAccountScreen(),
                              ));

                          break;
                        case 1:
                          // Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //         builder: (context) => RoomsScreen()));

                          break;
                        case 2:
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ExpertsScreen(),
                              ));
                          break;
                        case 3:
                          // Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //       builder: (context) => RoomMembersScreen(room_Id: ""),
                          //     ));
                          break;
                        case 4:
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ForgetPasswordScreen()));

                          break;
                        case 5:
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(
                          //       builder: (context) => ChangePasswordScreen()),
                          // );

                          break;
                        case 6:
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
                        case 7:





                          break;
                        case 8:
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return RoomDetailScreen();
                          }));

                          break;
                        case 9:
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return ExpertsDetailsScreen();
                          }));

                          break;
                        /* case 8:
                          SnackBar snackBar = SnackBar(
                            content: Text("No Invite Friends Screen"),
                            backgroundColor: ColorConstant.orangeA700,
                          );
                          ScaffoldMessenger.of(context)
                              .showSnackBar(snackBar);

                          break; */
                        case 10:
                          // showDialog(
                          //     context: context, builder: (_) => RoomsScreen());
                          /*  SnackBar snackBar = SnackBar(
                            content: Text("No Rate US Screen"),
                            backgroundColor: ColorConstant.orangeA700,
                          );
                          ScaffoldMessenger.of(context)
                              .showSnackBar(snackBar); */

                          break;
                        case 11:
                          // showDialog(
                          //     context: context, builder: (_) => RoomsScreen());

                          break;
                        case 12:
                          // showDialog(
                          //     context: context, builder: (_) => RoomsScreen());

                          break;

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
                                    child: Image.asset(
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
                                      fontWeight: FontWeight.w500),
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
}
