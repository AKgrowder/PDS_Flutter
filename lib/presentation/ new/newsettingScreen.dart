import 'package:flutter/material.dart';
import 'package:pds/core/app_export.dart';

class SettingScreenNew extends StatefulWidget {
  const SettingScreenNew({Key? key}) : super(key: key);

  @override
  State<SettingScreenNew> createState() => _SettingScreenNewState();
}

class _SettingScreenNewState extends State<SettingScreenNew> {
  List a = ['1', '2', '3', '4'];
  List<String> image = [
    ImageConstant.expert2,
    ImageConstant.expert2,
    ImageConstant.expert2,
    ImageConstant.expert2,
  ];
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
  @override
  Widget build(BuildContext context) {
    var _height = MediaQuery.of(context).size.height;
    var _width = MediaQuery.of(context).size.width;
    return Scaffold(
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
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Stack(
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
                                    margin: EdgeInsets.only(
                                        top: index == 0 ? 0 : 600),
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
                        height: _height / 1,
                        // color: Colors.white.withOpacity(0.2),
                        // color: Theme.of(context).brightness == Brightness.light
                        // ? Color(0XFF161616)
                        // : Color(0XFF1D1D1D),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ListView.builder(
                                shrinkWrap: true,
                                physics: BouncingScrollPhysics(),
                                itemCount: Setting_Array.length,
                                // itemCount: 5,
                                itemBuilder: (BuildContext context, int index) {
                                  return GestureDetector(
                                    onTap: () {
                                      switch (index) {
                                        case 0:
                                          break;

                                        case 1:
                                          break;
                                        case 2:
                                          break;
                                        case 3:
                                          break;
                                        case 4:
                                          break;
                                        case 5:
                                          break;

                                        case 6:
                                        case 7:
                                          break;
                                        case 8:
                                          break;

                                        case 9:
                                          break;
                                        case 10:
                                          ;

                                          break;

                                        default:
                                      }
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 16,
                                          right: 16,
                                          top: 8,
                                          bottom: 8),
                                      child: Column(
                                        children: [
                                          Container(
                                            height: 60,
                                            width: _width,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                                // color: ColorConstant.CategoriesBackColor,
                                                color: Color(0XFFFBD8D9),
                                                border: Border.all(
                                                    width: 1,
                                                    // color: ColorConstant.gray200,
                                                    color: Color(0XFFFFB0B3))),
                                            child: Row(
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 15, right: 15),
                                                  child: Container(
                                                      height: 25,
                                                      width: 25,
                                                      child: Image.asset(
                                                        "${SettingImage_Array[index]}",
                                                        color:
                                                            Color(0xFF3F3F3F),
                                                      )),
                                                ),
                                                Text(
                                                  "${Setting_Array[index]}",
                                                  style: TextStyle(
                                                      fontFamily: 'outfit',
                                                      fontSize: 18,
                                                      color: Color(0xFF3F3F3F),
                                                      fontWeight: index == 0
                                                          ? FontWeight.bold
                                                          : FontWeight.w500),
                                                ),
                                                Spacer(),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          right: 0),
                                                  child: Container(
                                                    // color: Colors.amber,
                                                    height: 30,
                                                    width: 60,
                                                    child: Icon(
                                                        Icons.arrow_forward_ios,
                                                        color:
                                                            Color(0xFF3F3F3F)),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                }),
                          ],
                        )),
                  ],
                ),
              ],
            ),
          ),
        ));
  }
}