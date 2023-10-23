import 'dart:io';
import 'dart:math';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pds/API/Bloc/NewProfileScreen_Bloc/NewProfileScreen_cubit.dart';
import 'package:pds/API/Bloc/NewProfileScreen_Bloc/NewProfileScreen_state.dart';
import 'package:pds/API/Model/NewProfileScreenModel/NewProfileScreen_Model.dart';
import 'package:pds/core/app_export.dart';
import 'package:pds/core/utils/color_constant.dart';
import 'package:pds/presentation/%20new/commetTabbar.dart';
import 'package:pds/presentation/%20new/editproilescreen.dart';
import 'package:pds/presentation/%20new/savedScrren.dart';
import 'package:pds/presentation/settings/setting_screen.dart';
import 'package:pds/widgets/custom_text_form_field.dart';

import 'mypofiileScreencustom.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class NotificationModel {
  int id;
  String title;
  bool isSelected;

  NotificationModel(this.id, this.title, {this.isSelected = false});
}

class _ProfileScreenState extends State<ProfileScreen>
    with SingleTickerProviderStateMixin {
  List<String> tabData = ["Details", "Post", "Comments", "Saved"];
  List<String> soicalScreen = [
    "Details",
    "Post",
    "Comments",
  ];
  List<String> SaveList = ["Post", "Blog"];

  TimeOfDay? _startTime;
  TimeOfDay? _endTime;
  String? dopcument;
  String? filepath;
  double value2 = 0.0;
  TabController? _tabController;
  String selctedValue = 'Newest to oldest';
  String selctedValue1 = 'All Date';
  String selctedValue2 = 'All Users';
  TextEditingController jobprofileController = TextEditingController();
  TextEditingController IndustryType = TextEditingController();
  TextEditingController priceContrller = TextEditingController();
  TextEditingController FeesContrller = TextEditingController();
  TextEditingController uplopdfile = TextEditingController();
  TextEditingController CompanyName = TextEditingController();
  NewProfileScreen_Model? PublicRoomData;

  var arrNotiyTypeList = [
    NotificationModel(
      1,
      " ",
      isSelected: true,
    ),
    NotificationModel(
      2,
      " ",
    ),
    NotificationModel(
      3,
      " ",
    ),
    NotificationModel(
      4,
      " ",
    ),
  ];

  @override
  void initState() {
    _tabController = TabController(length: tabData.length, vsync: this);
    BlocProvider.of<NewProfileSCubit>(context).NewProfileSAPI(context);
    super.initState();
  }

  @override
  void dispose() {
    _tabController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var _height = MediaQuery.of(context).size.height;
    var _width = MediaQuery.of(context).size.width;
    return BlocConsumer<NewProfileSCubit, NewProfileSState>(
        listener: (context, state) async {
      if (state is NewProfileSErrorState) {
        SnackBar snackBar = SnackBar(
          content: Text(state.error),
          backgroundColor: ColorConstant.primary_color,
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }

      if (state is NewProfileSLoadingState) {
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

      if (state is NewProfileSLoadedState) {
        PublicRoomData = state.PublicRoomData;
        print(
            "++++++++++++++++++++++++++++++++++++++++++ ++++++++++++++++++++++++++++++++++++++++++");
        print(PublicRoomData?.object?.module);
      }
    }, builder: (context, state) {
      return Scaffold(
          body: DefaultTabController(
        length: tabData.length,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: _height / 2.6,
                child: Stack(
                  children: [
                    Container(
                      child: Image.asset(
                        ImageConstant.myprofile,
                        fit: BoxFit.contain,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 55, left: 16),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Container(
                          height: 30,
                          width: 30,
                          color: Color.fromRGBO(255, 255, 255, 0.3),
                          child: Center(
                            child: Image.asset(
                              ImageConstant.backArrow,
                              fit: BoxFit.fill,
                              height: 25,
                              width: 25,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        height: 150,
                        width: 150,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle, color: Colors.white),
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Image.asset(ImageConstant.palchoder4),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 20),
                child: Center(
                  child: Text(
                    'Kriston Watshon',
                    style: TextStyle(
                        fontSize: 26,
                        fontFamily: "outfit",
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Center(
                child: Text(
                  '@Kriston_Watshon',
                  style: TextStyle(
                      fontFamily: "outfit",
                      fontWeight: FontWeight.bold,
                      color: Color(0xff444444)),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Center(
                child: Text(
                  'About...Lorem ipsum dolor sit amet',
                  style: TextStyle(
                      fontSize: 16,
                      fontFamily: "outfit",
                      fontWeight: FontWeight.bold,
                      color: Color(0xff444444)),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              "soicalScreens" != 'soicalScreen'
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => EditProfileScreen()));
                          },
                          child: Container(
                            alignment: Alignment.center,
                            height: 45,
                            width: _width / 3,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(color: Color(0xffED1C25))),
                            child: Text(
                              'Edit Profile',
                              style: TextStyle(
                                  fontFamily: "outfit",
                                  fontSize: 18,
                                  color: Color(0xffED1C25),
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SettingScreen()));
                          },
                          child: Container(
                            margin: EdgeInsets.only(left: 10),
                            height: 45,
                            width: 50,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Color(0XFFED1C25)),
                            child: Icon(
                              Icons.settings,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    )
                  : Container(
                      alignment: Alignment.center,
                      height: 45,
                      width: _width / 3,
                      decoration: BoxDecoration(
                        color: Color(0xffED1C25),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        'Follow',
                        style: TextStyle(
                            fontFamily: "outfit",
                            fontSize: 18,
                            color: Colors.white,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
              SizedBox(
                height: 12,
              ),
              Center(
                child: Container(
                  height: 80,
                  width: _width / 1.1,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: Color(0xffD2D2D2),
                      )),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 35,
                      ),
                      Container(
                        // height: 55,
                        width: 55,
                        // color: Colors.amber,
                        child: Column(
                          children: [
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              '50',
                              style: TextStyle(
                                  fontFamily: "outfit",
                                  fontSize: 25,
                                  color: Color(0xff000000),
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              'Post',
                              style: TextStyle(
                                  fontFamily: "outfit",
                                  fontSize: 16,
                                  color: Color(0xff444444),
                                  fontWeight: FontWeight.w500),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20, bottom: 20),
                        child: VerticalDivider(
                          thickness: 1.5,
                          color: Color(0xffC2C2C2),
                        ),
                      ),
                      SizedBox(
                        width: 25,
                      ),
                      Container(
                        // height: 55,
                        width: 90,
                        // color: Colors.amber,
                        child: Column(
                          children: [
                            SizedBox(
                              height: 11,
                            ),
                            Text(
                              '5k',
                              style: TextStyle(
                                  fontFamily: "outfit",
                                  fontSize: 25,
                                  color: Color(0xff000000),
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              'Followers',
                              style: TextStyle(
                                  fontFamily: "outfit",
                                  fontSize: 16,
                                  color: Color(0xff444444),
                                  fontWeight: FontWeight.w500),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20, bottom: 20),
                        child: VerticalDivider(
                          thickness: 1.5,
                          color: Color(0xffC2C2C2),
                        ),
                      ),
                      Container(
                        // height: 55,
                        width: 90,
                        // color: Colors.amber,
                        child: Column(
                          children: [
                            SizedBox(
                              height: 11,
                            ),
                            Text(
                              '3k',
                              style: TextStyle(
                                  fontFamily: "outfit",
                                  fontSize: 25,
                                  color: Color(0xff000000),
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              'Following',
                              style: TextStyle(
                                  fontFamily: "outfit",
                                  fontSize: 16,
                                  color: Color(0xff444444),
                                  fontWeight: FontWeight.w500),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              // SizedBox(
              //   height: 50,
              // child: TabBar(
              //     indicatorColor: Colors.black,
              //     unselectedLabelColor: Color(0xff444444),
              //     labelColor: Color(0xff000000),
              //     controller: _tabController,
              //     tabs: List.generate(
              //         tabData.length,
              //         (index) => Tab(
              //                 child: Text(
              //               tabData[index].toString(),
              //               style: TextStyle(
              //                 fontWeight: FontWeight.bold,
              //                 fontFamily: "outfit",
              //                 fontSize: 14,
              //               ),
              //             )))),
              // ),
              SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: GestureDetector(
                      child: Column(
                        children: [
                          Container(
                            height: 40,
                            // color: arrNotiyTypeList[0].isSelected
                            //     ? Color(0xFFED1C25)
                            //     : Theme.of(context).brightness == Brightness.light
                            //         ? Colors.white
                            //         : Colors.black,
                            child: Center(
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      const Spacer(),
                                      Text("Details",
                                          textScaleFactor: 1.0,
                                          style: TextStyle(
                                              // color: arrNotiyTypeList[3].isSelected
                                              //     ? Colors.white
                                              //     : Colors.black,
                                              fontSize: 18,
                                              fontFamily: 'Outfit',
                                              fontWeight: FontWeight.bold)),
                                      Spacer(),
                                    ],
                                  ),
                                  arrNotiyTypeList[0].isSelected
                                      ? Divider(
                                          endIndent: 20,
                                          indent: 20,
                                          color: Colors.black,
                                        )
                                      : SizedBox(),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      onTap: () {
                        setState(() {
                          updateType();
                          arrNotiyTypeList[0].isSelected = true;
                          print("abcd");
                        });
                      },
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      child: Column(
                        children: [
                          Container(
                            height: 40,
                            // color: arrNotiyTypeList[1].isSelected
                            //     ? Color(0xFFED1C25)
                            //     : Theme.of(context).brightness == Brightness.light
                            //         ? Colors.white
                            //         : Colors.black,
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    const Spacer(),
                                    Text("Post",
                                        textScaleFactor: 1.0,
                                        style: TextStyle(
                                            // color: arrNotiyTypeList[3].isSelected
                                            //     ? Colors.white
                                            //     : Colors.black,
                                            fontSize: 18,
                                            fontFamily: 'Outfit',
                                            fontWeight: FontWeight.bold)),
                                    Spacer(),
                                  ],
                                ),
                                arrNotiyTypeList[1].isSelected
                                    ? Divider(
                                        endIndent: 30,
                                        indent: 30,
                                        color: Colors.black,
                                      )
                                    : SizedBox(),
                              ],
                            ),
                          )
                        ],
                      ),
                      onTap: () {
                        setState(() {
                          updateType();
                          arrNotiyTypeList[1].isSelected = true;
                          print("abcd");
                        });
                      },
                    ),
                  ),
                  Container(
                    height: 1,
                    color: Colors.black12,
                  ),
                  Expanded(
                    child: GestureDetector(
                      child: Column(
                        children: [
                          Container(
                              height: 40,
                              alignment: Alignment.center,
                              // color: arrNotiyTypeList[2].isSelected
                              //     ? Color(0xFFED1C25)
                              //     : Theme.of(context).brightness == Brightness.light
                              //         ? Colors.white
                              //         : Colors.black,
                              child: Center(
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        const Spacer(),
                                        Text("Comments",
                                            textScaleFactor: 1.0,
                                            style: TextStyle(
                                                // color: arrNotiyTypeList[3].isSelected
                                                //     ? Colors.white
                                                //     : Colors.black,
                                                fontSize: 18,
                                                fontFamily: 'Outfit',
                                                fontWeight: FontWeight.bold)),
                                        Spacer(),
                                      ],
                                    ),
                                    arrNotiyTypeList[2].isSelected
                                        ? Divider(
                                            endIndent: 5,
                                            indent: 5,
                                            color: Colors.black,
                                          )
                                        : SizedBox(),
                                  ],
                                ),
                              )),
                        ],
                      ),
                      onTap: () {
                        setState(() {
                          updateType();
                          arrNotiyTypeList[2].isSelected = true;
                        });
                        print("abcd");
                      },
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      child: Container(
                          height: 40,
                          alignment: Alignment.center,
                          // color: arrNotiyTypeList[3].isSelected
                          //     ? Color(0xFFED1C25)
                          //     : Theme.of(context).brightness == Brightness.light
                          //         ? Colors.white
                          //         : Colors.black,
                          child: Center(
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    const Spacer(),
                                    Text("Saved",
                                        textScaleFactor: 1.0,
                                        style: TextStyle(
                                            // color: arrNotiyTypeList[3].isSelected
                                            //     ? Colors.white
                                            //     : Colors.black,
                                            fontSize: 18,
                                            fontFamily: 'Outfit',
                                            fontWeight: FontWeight.bold)),
                                    Spacer(),
                                  ],
                                ),
                                arrNotiyTypeList[3].isSelected
                                    ? Divider(
                                        endIndent: 25,
                                        indent: 25,
                                        color: Colors.black,
                                      )
                                    : SizedBox(),
                              ],
                            ),
                          )),
                      onTap: () {
                        setState(() {
                          updateType();
                          arrNotiyTypeList[3].isSelected = true;
                        });
                        print("abcd");
                      },
                    ),
                  ),
                ],
              ),
              Container(
                color: Colors.red,
                height: _height * 1.35,
                child: Column(
                  children: <Widget>[
                    /// Content of Tab 1
                    arrNotiyTypeList[0].isSelected
                        ? Padding(
                            padding: const EdgeInsets.only(
                                left: 16, right: 16, top: 14),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Card(
                                    color: Colors.white,
                                    borderOnForeground: true,
                                    elevation: 10,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15.0),
                                    ),
                                    child: ListTile(
                                      leading: Container(
                                        width: 35,
                                        height: 35,
                                        decoration: ShapeDecoration(
                                          color: Color(0xFFED1C25),
                                          shape: OvalBorder(),
                                        ),
                                      ),
                                      title: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            height: 15,
                                          ),
                                          Text(
                                            'About Me',
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 18,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Text(
                                            'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fringilla natoque id aenean.',
                                          ),
                                          SizedBox(
                                            height: 12,
                                          ),
                                        ],
                                      ),
                                      trailing: Icon(
                                        Icons.edit,
                                        color: Colors.black,
                                      ),
                                    )),
                                Card(
                                  color: Colors.white,
                                  borderOnForeground: true,
                                  elevation: 10,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15.0),
                                  ),
                                  /*  child: expertUser(_height, _width) */
                                  child: expertUser(_height, _width),
                                ),
                                Card(
                                  color: Colors.white,
                                  borderOnForeground: true,
                                  elevation: 10,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15.0),
                                  ),
                                  /*  child: expertUser(_height, _width) */
                                  child: compnayUser(_height, _width),
                                )
                              ],
                            ),
                          )
                        : SizedBox(),

                    /// Content of Tab 2
                    // PostTabbarView(image: image),

                    arrNotiyTypeList[1].isSelected
                        ? Container(
                            height: _height / 1.5,
                            child: Padding(
                              padding:
                                  EdgeInsets.only(left: 16, right: 16, top: 14),
                              child: GridView.builder(
                                physics: NeverScrollableScrollPhysics(),
                                padding: EdgeInsets.zero,
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2, // Number of columns
                                  mainAxisSpacing:
                                      0.0, // Vertical spacing between items
                                  crossAxisSpacing:
                                      20, // Horizontal spacing between items
                                ),
                                itemCount: image.length,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding:
                                        EdgeInsets.only(bottom: 10, top: 10),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(12.0),
                                      child: Container(
                                        margin: EdgeInsets.all(0.0),
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(
                                                20)), // Remove margin
                                        child: Image.asset(
                                          image[index],
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ) /*  GridItem(imagePath: image[index]) */,
                                  );
                                },
                              ),
                            ),
                          )
                        : SizedBox(),

                    /// Content of Tab 3
                    arrNotiyTypeList[2].isSelected
                        ? Container(
                            height: _height,
                            child: MyWidget(
                                selctedValue: selctedValue,
                                selctedValue1: selctedValue1,
                                selctedValue2: selctedValue2),
                          )
                        : SizedBox(),

                    /// Content of Tab 4
                    if ("soicalScreens" != 'soicalScreen')
                      arrNotiyTypeList[3].isSelected
                          ? Container(
                              height: _height,
                              child: ListSaveScreen(
                                  tabs: SaveList, value2: 1, image: image),
                            )
                          : SizedBox(),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              )
            ],
          ),
        ),
      ));
    });

    /*  Scaffold(
        body: DefaultTabController(
      length: tabData.length,
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: _height / 2.6,
              child: Stack(
                children: [
                  Container(
                    child: Image.asset(
                      ImageConstant.myprofile,
                      fit: BoxFit.contain,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 55, left: 16),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        height: 30,
                        width: 30,
                        color: Color.fromRGBO(255, 255, 255, 0.3),
                        child: Center(
                          child: Image.asset(
                            ImageConstant.backArrow,
                            fit: BoxFit.fill,
                            height: 25,
                            width: 25,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      height: 150,
                      width: 150,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle, color: Colors.white),
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Image.asset(ImageConstant.palchoder4),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 20),
              child: Center(
                child: Text(
                  'Kriston Watshon',
                  style: TextStyle(
                      fontSize: 26,
                      fontFamily: "outfit",
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Center(
              child: Text(
                '@Kriston_Watshon',
                style: TextStyle(
                    fontFamily: "outfit",
                    fontWeight: FontWeight.bold,
                    color: Color(0xff444444)),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Center(
              child: Text(
                'About...Lorem ipsum dolor sit amet',
                style: TextStyle(
                    fontSize: 16,
                    fontFamily: "outfit",
                    fontWeight: FontWeight.bold,
                    color: Color(0xff444444)),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            "soicalScreens" != 'soicalScreen'
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => EditProfileScreen()));
                        },
                        child: Container(
                          alignment: Alignment.center,
                          height: 45,
                          width: _width / 3,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: Color(0xffED1C25))),
                          child: Text(
                            'Edit Profile',
                            style: TextStyle(
                                fontFamily: "outfit",
                                fontSize: 18,
                                color: Color(0xffED1C25),
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SettingScreen()));
                        },
                        child: Container(
                          margin: EdgeInsets.only(left: 10),
                          height: 45,
                          width: 50,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Color(0XFFED1C25)),
                          child: Icon(
                            Icons.settings,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  )
                : Container(
                    alignment: Alignment.center,
                    height: 45,
                    width: _width / 3,
                    decoration: BoxDecoration(
                      color: Color(0xffED1C25),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      'Follow',
                      style: TextStyle(
                          fontFamily: "outfit",
                          fontSize: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
            SizedBox(
              height: 12,
            ),
            Center(
              child: Container(
                height: 80,
                width: _width / 1.1,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: Color(0xffD2D2D2),
                    )),
                child: Row(
                  children: [
                    SizedBox(
                      width: 35,
                    ),
                    Container(
                      // height: 55,
                      width: 55,
                      // color: Colors.amber,
                      child: Column(
                        children: [
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            '50',
                            style: TextStyle(
                                fontFamily: "outfit",
                                fontSize: 25,
                                color: Color(0xff000000),
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            'Post',
                            style: TextStyle(
                                fontFamily: "outfit",
                                fontSize: 16,
                                color: Color(0xff444444),
                                fontWeight: FontWeight.w500),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20, bottom: 20),
                      child: VerticalDivider(
                        thickness: 1.5,
                        color: Color(0xffC2C2C2),
                      ),
                    ),
                    SizedBox(
                      width: 25,
                    ),
                    Container(
                      // height: 55,
                      width: 90,
                      // color: Colors.amber,
                      child: Column(
                        children: [
                          SizedBox(
                            height: 11,
                          ),
                          Text(
                            '5k',
                            style: TextStyle(
                                fontFamily: "outfit",
                                fontSize: 25,
                                color: Color(0xff000000),
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            'Followers',
                            style: TextStyle(
                                fontFamily: "outfit",
                                fontSize: 16,
                                color: Color(0xff444444),
                                fontWeight: FontWeight.w500),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20, bottom: 20),
                      child: VerticalDivider(
                        thickness: 1.5,
                        color: Color(0xffC2C2C2),
                      ),
                    ),
                    Container(
                      // height: 55,
                      width: 90,
                      // color: Colors.amber,
                      child: Column(
                        children: [
                          SizedBox(
                            height: 11,
                          ),
                          Text(
                            '3k',
                            style: TextStyle(
                                fontFamily: "outfit",
                                fontSize: 25,
                                color: Color(0xff000000),
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            'Following',
                            style: TextStyle(
                                fontFamily: "outfit",
                                fontSize: 16,
                                color: Color(0xff444444),
                                fontWeight: FontWeight.w500),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // SizedBox(
            //   height: 50,
            // child: TabBar(
            //     indicatorColor: Colors.black,
            //     unselectedLabelColor: Color(0xff444444),
            //     labelColor: Color(0xff000000),
            //     controller: _tabController,
            //     tabs: List.generate(
            //         tabData.length,
            //         (index) => Tab(
            //                 child: Text(
            //               tabData[index].toString(),
            //               style: TextStyle(
            //                 fontWeight: FontWeight.bold,
            //                 fontFamily: "outfit",
            //                 fontSize: 14,
            //               ),
            //             )))),
            // ),
            SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: GestureDetector(
                    child: Column(
                      children: [
                        Container(
                          height: 40,
                          // color: arrNotiyTypeList[0].isSelected
                          //     ? Color(0xFFED1C25)
                          //     : Theme.of(context).brightness == Brightness.light
                          //         ? Colors.white
                          //         : Colors.black,
                          child: Center(
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    const Spacer(),
                                    Text("Details",
                                        textScaleFactor: 1.0,
                                        style: TextStyle(
                                            // color: arrNotiyTypeList[3].isSelected
                                            //     ? Colors.white
                                            //     : Colors.black,
                                            fontSize: 18,
                                            fontFamily: 'Outfit',
                                            fontWeight: FontWeight.bold)),
                                    Spacer(),
                                  ],
                                ),
                                arrNotiyTypeList[0].isSelected
                                    ? Divider(
                                        endIndent: 20,
                                        indent: 20,
                                        color: Colors.black,
                                      )
                                    : SizedBox(),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    onTap: () {
                      setState(() {
                        updateType();
                        arrNotiyTypeList[0].isSelected = true;
                        print("abcd");
                      });
                    },
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    child: Column(
                      children: [
                        Container(
                          height: 40,
                          // color: arrNotiyTypeList[1].isSelected
                          //     ? Color(0xFFED1C25)
                          //     : Theme.of(context).brightness == Brightness.light
                          //         ? Colors.white
                          //         : Colors.black,
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  const Spacer(),
                                  Text("Post",
                                      textScaleFactor: 1.0,
                                      style: TextStyle(
                                          // color: arrNotiyTypeList[3].isSelected
                                          //     ? Colors.white
                                          //     : Colors.black,
                                          fontSize: 18,
                                          fontFamily: 'Outfit',
                                          fontWeight: FontWeight.bold)),
                                  Spacer(),
                                ],
                              ),
                              arrNotiyTypeList[1].isSelected
                                  ? Divider(
                                      endIndent: 30,
                                      indent: 30,
                                      color: Colors.black,
                                    )
                                  : SizedBox(),
                            ],
                          ),
                        )
                      ],
                    ),
                    onTap: () {
                      setState(() {
                        updateType();
                        arrNotiyTypeList[1].isSelected = true;
                        print("abcd");
                      });
                    },
                  ),
                ),
                Container(
                  height: 1,
                  color: Colors.black12,
                ),
                Expanded(
                  child: GestureDetector(
                    child: Column(
                      children: [
                        Container(
                            height: 40,
                            alignment: Alignment.center,
                            // color: arrNotiyTypeList[2].isSelected
                            //     ? Color(0xFFED1C25)
                            //     : Theme.of(context).brightness == Brightness.light
                            //         ? Colors.white
                            //         : Colors.black,
                            child: Center(
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      const Spacer(),
                                      Text("Comments",
                                          textScaleFactor: 1.0,
                                          style: TextStyle(
                                              // color: arrNotiyTypeList[3].isSelected
                                              //     ? Colors.white
                                              //     : Colors.black,
                                              fontSize: 18,
                                              fontFamily: 'Outfit',
                                              fontWeight: FontWeight.bold)),
                                      Spacer(),
                                    ],
                                  ),
                                  arrNotiyTypeList[2].isSelected
                                      ? Divider(
                                          endIndent: 5,
                                          indent: 5,
                                          color: Colors.black,
                                        )
                                      : SizedBox(),
                                ],
                              ),
                            )),
                      ],
                    ),
                    onTap: () {
                      setState(() {
                        updateType();
                        arrNotiyTypeList[2].isSelected = true;
                      });
                      print("abcd");
                    },
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    child: Container(
                        height: 40,
                        alignment: Alignment.center,
                        // color: arrNotiyTypeList[3].isSelected
                        //     ? Color(0xFFED1C25)
                        //     : Theme.of(context).brightness == Brightness.light
                        //         ? Colors.white
                        //         : Colors.black,
                        child: Center(
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  const Spacer(),
                                  Text("Saved",
                                      textScaleFactor: 1.0,
                                      style: TextStyle(
                                          // color: arrNotiyTypeList[3].isSelected
                                          //     ? Colors.white
                                          //     : Colors.black,
                                          fontSize: 18,
                                          fontFamily: 'Outfit',
                                          fontWeight: FontWeight.bold)),
                                  Spacer(),
                                ],
                              ),
                              arrNotiyTypeList[3].isSelected
                                  ? Divider(
                                      endIndent: 25,
                                      indent: 25,
                                      color: Colors.black,
                                    )
                                  : SizedBox(),
                            ],
                          ),
                        )),
                    onTap: () {
                      setState(() {
                        updateType();
                        arrNotiyTypeList[3].isSelected = true;
                      });
                      print("abcd");
                    },
                  ),
                ),
              ],
            ),
            Container(
              color: Colors.red,
              height: _height * 1.35,
              child: Column(
                children: <Widget>[
                  /// Content of Tab 1
                  arrNotiyTypeList[0].isSelected
                      ? Padding(
                          padding: const EdgeInsets.only(
                              left: 16, right: 16, top: 14),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Card(
                                  color: Colors.white,
                                  borderOnForeground: true,
                                  elevation: 10,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15.0),
                                  ),
                                  child: ListTile(
                                    leading: Container(
                                      width: 35,
                                      height: 35,
                                      decoration: ShapeDecoration(
                                        color: Color(0xFFED1C25),
                                        shape: OvalBorder(),
                                      ),
                                    ),
                                    title: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          height: 15,
                                        ),
                                        Text(
                                          'About Me',
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 18,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fringilla natoque id aenean.',
                                        ),
                                        SizedBox(
                                          height: 12,
                                        ),
                                      ],
                                    ),
                                    trailing: Icon(
                                      Icons.edit,
                                      color: Colors.black,
                                    ),
                                  )),
                              Card(
                                color: Colors.white,
                                borderOnForeground: true,
                                elevation: 10,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                ),
                                /*  child: expertUser(_height, _width) */
                                child: expertUser(_height, _width),
                              ),
                              Card(
                                color: Colors.white,
                                borderOnForeground: true,
                                elevation: 10,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                ),
                                /*  child: expertUser(_height, _width) */
                                child: compnayUser(_height, _width),
                              )
                            ],
                          ),
                        )
                      : SizedBox(),

                  /// Content of Tab 2
                  // PostTabbarView(image: image),

                  arrNotiyTypeList[1].isSelected
                      ? Container(
                          height: _height / 1.5,
                          child: Padding(
                            padding:
                                EdgeInsets.only(left: 16, right: 16, top: 14),
                            child: GridView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              padding: EdgeInsets.zero,
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2, // Number of columns
                                mainAxisSpacing:
                                    0.0, // Vertical spacing between items
                                crossAxisSpacing:
                                    20, // Horizontal spacing between items
                              ),
                              itemCount: image.length,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: EdgeInsets.only(bottom: 10, top: 10),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(12.0),
                                    child: Container(
                                      margin: EdgeInsets.all(0.0),
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                              20)), // Remove margin
                                      child: Image.asset(
                                        image[index],
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ) /*  GridItem(imagePath: image[index]) */,
                                );
                              },
                            ),
                          ),
                        )
                      : SizedBox(),

                  /// Content of Tab 3
                  arrNotiyTypeList[2].isSelected
                      ? Container(
                          height: _height,
                          child: MyWidget(
                              selctedValue: selctedValue,
                              selctedValue1: selctedValue1,
                              selctedValue2: selctedValue2),
                        )
                      : SizedBox(),

                  /// Content of Tab 4
                  if ("soicalScreens" != 'soicalScreen')
                    arrNotiyTypeList[3].isSelected
                        ? Container(
                            height: _height,
                            child: ListSaveScreen(
                                tabs: SaveList, value2: 1, image: image),
                          )
                        : SizedBox(),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            )
          ],
        ),
      ),
    ));
  */
  }

  Widget expertUser(_height, _width) {
    return Column(
      children: [
        ListTile(
          leading: Container(
            width: 35,
            height: 35,
            decoration: ShapeDecoration(
              color: Color(0xFFED1C25),
              shape: OvalBorder(),
            ),
          ),
          title: Text(
            'Work/ Business Details',
            style: TextStyle(
              color: Colors.black,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          trailing: Icon(
            Icons.edit,
            color: Colors.black,
          ),
        ),
        Transform.translate(
          offset: Offset(72, 0),
          child: Container(
            height: 550,
            width: _width,
            //  color: Colors.amber,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Job Profile",
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontFamily: 'outfit',
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Container(
                  width: _width / 1.46,
                  child: CustomTextFormField(
                    controller: jobprofileController,
                    margin: EdgeInsets.only(
                      top: 10,
                    ),

                    validator: (value) {
                      RegExp nameRegExp = RegExp(r"^[a-zA-Z0-9\s'@]+$");
                      if (value!.isEmpty) {
                        return 'Please Enter Name';
                      } else if (!nameRegExp.hasMatch(value)) {
                        return 'Input cannot contains prohibited special characters';
                      } else if (value.length <= 0 || value.length > 50) {
                        return 'Minimum length required';
                      } else if (value.contains('..')) {
                        return 'username does not contain is correct';
                      }

                      return null;
                    },
                    // textStyle: theme.textTheme.titleMedium!,
                    hintText: "Job Profile",
                    // hintStyle: theme.textTheme.titleMedium!,
                    textInputAction: TextInputAction.next,
                    filled: true,
                    maxLength: 100,
                    fillColor: appTheme.gray100,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Industry Type",
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontFamily: 'outfit',
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Container(
                  width: _width / 1.46,
                  child: CustomTextFormField(
                    controller: IndustryType,
                    margin: EdgeInsets.only(
                      top: 10,
                    ),

                    validator: (value) {
                      RegExp nameRegExp = RegExp(r"^[a-zA-Z0-9\s'@]+$");
                      if (value!.isEmpty) {
                        return 'Please Enter Name';
                      } else if (!nameRegExp.hasMatch(value)) {
                        return 'Input cannot contains prohibited special characters';
                      } else if (value.length <= 0 || value.length > 50) {
                        return 'Minimum length required';
                      } else if (value.contains('..')) {
                        return 'username does not contain is correct';
                      }

                      return null;
                    },
                    // textStyle: theme.textTheme.titleMedium!,
                    hintText: "Industry Type",
                    // hintStyle: theme.textTheme.titleMedium!,
                    textInputAction: TextInputAction.next,
                    filled: true,
                    maxLength: 100,
                    fillColor: appTheme.gray100,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Expertise in",
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontFamily: 'outfit',
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Container(
                  width: _width / 1.46,
                  child: CustomTextFormField(
                    controller: IndustryType,
                    margin: EdgeInsets.only(
                      top: 10,
                    ),

                    validator: (value) {
                      RegExp nameRegExp = RegExp(r"^[a-zA-Z0-9\s'@]+$");
                      if (value!.isEmpty) {
                        return 'Please Enter Name';
                      } else if (!nameRegExp.hasMatch(value)) {
                        return 'Input cannot contains prohibited special characters';
                      } else if (value.length <= 0 || value.length > 50) {
                        return 'Minimum length required';
                      } else if (value.contains('..')) {
                        return 'username does not contain is correct';
                      }

                      return null;
                    },
                    // textStyle: theme.textTheme.titleMedium!,
                    hintText: "Expertise in",
                    // hintStyle: theme.textTheme.titleMedium!,
                    textInputAction: TextInputAction.next,
                    filled: true,
                    maxLength: 100,
                    fillColor: appTheme.gray100,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Fees",
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontFamily: 'outfit',
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Container(
                  width: _width / 1.46,
                  child: CustomTextFormField(
                    controller: priceContrller,
                    margin: EdgeInsets.only(
                      top: 10,
                    ),

                    validator: (value) {
                      RegExp nameRegExp = RegExp(r"^[a-zA-Z0-9\s'@]+$");
                      if (value!.isEmpty) {
                        return 'Please Enter Name';
                      } else if (!nameRegExp.hasMatch(value)) {
                        return 'Input cannot contains prohibited special characters';
                      } else if (value.length <= 0 || value.length > 50) {
                        return 'Minimum length required';
                      } else if (value.contains('..')) {
                        return 'username does not contain is correct';
                      }

                      return null;
                    },
                    // textStyle: theme.textTheme.titleMedium!,
                    hintText: "Price / hr",
                    // hintStyle: theme.textTheme.titleMedium!,
                    textInputAction: TextInputAction.next,
                    filled: true,
                    maxLength: 100,
                    fillColor: appTheme.gray100,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Working Hours",
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontFamily: 'outfit',
                    fontWeight: FontWeight.w500,
                  ),
                  // style: theme.textTheme.bodyLarge,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          _selectStartTime(context);
                        },
                        child: Container(
                          height: 40,
                          width: 120,
                          decoration: BoxDecoration(
                              color: Color(0xffF6F6F6),
                              borderRadius: BorderRadius.circular(10)),
                          child: Row(
                            children: [
                              Padding(
                                  padding: EdgeInsets.only(left: 20),
                                  child: Text(
                                    _startTime != null
                                        ? _startTime!
                                            .format(context)
                                            .toString()
                                            .split(' ')
                                            .first
                                        : '00:00',
                                    style: TextStyle(
                                        fontSize: 16, color: Color(0xff989898)),
                                  )),
                              SizedBox(
                                width: 7,
                              ),
                              VerticalDivider(
                                thickness: 2,
                                color: Color(0xff989898),
                              ),
                              Text(
                                  _startTime != null
                                      ? _startTime!
                                          .format(context)
                                          .toString()
                                          .split(' ')
                                          .last
                                      : 'AM',
                                  style: TextStyle(
                                      fontSize: 16, color: Color(0xff989898))),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        'TO',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontFamily: "outfit",
                          fontWeight: FontWeight.bold,
                          height: 0,
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      GestureDetector(
                        onTap: () {
                          _selectEndTime(context);
                        },
                        child: Container(
                          height: 40,
                          width: 120,
                          decoration: BoxDecoration(
                              color: Color(0xffF6F6F6),
                              borderRadius: BorderRadius.circular(10)),
                          child: Row(
                            children: [
                              Padding(
                                  padding: EdgeInsets.only(left: 20),
                                  child: Text(
                                    _endTime != null
                                        ? _endTime!
                                            .format(context)
                                            .toString()
                                            .split(' ')
                                            .first
                                        : '00:00',
                                    style: TextStyle(
                                        fontSize: 16, color: Color(0xff989898)),
                                  )),
                              SizedBox(
                                width: 7,
                              ),
                              VerticalDivider(
                                thickness: 2,
                                color: Color(0xff989898),
                              ),
                              Text(
                                  _endTime != null
                                      ? _endTime!
                                          .format(context)
                                          .toString()
                                          .split(' ')
                                          .last
                                      : 'PM',
                                  style: TextStyle(
                                      fontSize: 16, color: Color(0xff989898))),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Document",
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontFamily: 'outfit',
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Row(
                  children: [
                    Container(
                        height: 50,
                        width: _width / 2.2,
                        decoration: BoxDecoration(
                            color: Color(0XFFF6F6F6),
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(5),
                                bottomLeft: Radius.circular(5))),
                        child: Padding(
                          padding: const EdgeInsets.only(top: 15, left: 20),
                          child: Text(
                            '${dopcument.toString()}',
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(fontSize: 16),
                          ),
                        )),
                    dopcument == "Upload Image"
                        ? GestureDetector(
                            onTap: () async {
                              print(
                                  'dopcument.toString()--${dopcument.toString()}');
                              filepath = await prepareTestPdf(0);
                            },
                            child: Container(
                              height: 50,
                              width: _width / 4.5,
                              decoration: BoxDecoration(
                                  color: Color(0XFF777777),
                                  borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(5),
                                      bottomRight: Radius.circular(5))),
                              child: Center(
                                child: Text(
                                  "Choose",
                                  style: TextStyle(
                                    fontFamily: 'outfit',
                                    fontSize: 15,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),
                          )
                        : Container(
                            height: 50,
                            width: _width / 4.5,
                            decoration: BoxDecoration(
                                color: Color.fromARGB(255, 228, 228, 228),
                                borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(5),
                                    bottomRight: Radius.circular(5))),
                            child: GestureDetector(
                                onTap: () async {
                                  dopcument = "Upload Image";

                                  setState(() {});
                                },
                                child: Icon(
                                  Icons.delete_forever,
                                  color: ColorConstant.primary_color,
                                )),
                          ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget compnayUser(_height, _width) {
    return Column(
      children: [
        ListTile(
          leading: Container(
            width: 35,
            height: 35,
            decoration: ShapeDecoration(
              color: Color(0xFFED1C25),
              shape: OvalBorder(),
            ),
          ),
          title: Text(
            'Work/ Business Details',
            style: TextStyle(
              color: Colors.black,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          trailing: Icon(
            Icons.edit,
            color: Colors.black,
          ),
        ),
        Transform.translate(
          offset: Offset(72, 0),
          child: Container(
            height: 350,
            width: _width,
            //  color: Colors.amber,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Company Name",
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontFamily: 'outfit',
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Container(
                  width: _width / 1.46,
                  child: CustomTextFormField(
                    controller: CompanyName,
                    margin: EdgeInsets.only(
                      top: 10,
                    ),

                    validator: (value) {
                      RegExp nameRegExp = RegExp(r"^[a-zA-Z0-9\s'@]+$");
                      if (value!.isEmpty) {
                        return 'Please Enter Name';
                      } else if (!nameRegExp.hasMatch(value)) {
                        return 'Input cannot contains prohibited special characters';
                      } else if (value.length <= 0 || value.length > 50) {
                        return 'Minimum length required';
                      } else if (value.contains('..')) {
                        return 'username does not contain is correct';
                      }

                      return null;
                    },
                    // textStyle: theme.textTheme.titleMedium!,
                    hintText: "Company Name",
                    // hintStyle: theme.textTheme.titleMedium!,
                    textInputAction: TextInputAction.next,
                    filled: true,
                    maxLength: 100,
                    fillColor: appTheme.gray100,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Job Profile",
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontFamily: 'outfit',
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Container(
                  width: _width / 1.46,
                  child: CustomTextFormField(
                    controller: jobprofileController,
                    margin: EdgeInsets.only(
                      top: 10,
                    ),

                    validator: (value) {
                      RegExp nameRegExp = RegExp(r"^[a-zA-Z0-9\s'@]+$");
                      if (value!.isEmpty) {
                        return 'Please Enter Name';
                      } else if (!nameRegExp.hasMatch(value)) {
                        return 'Input cannot contains prohibited special characters';
                      } else if (value.length <= 0 || value.length > 50) {
                        return 'Minimum length required';
                      } else if (value.contains('..')) {
                        return 'username does not contain is correct';
                      }

                      return null;
                    },
                    // textStyle: theme.textTheme.titleMedium!,
                    hintText: "Job profile",
                    // hintStyle: theme.textTheme.titleMedium!,
                    textInputAction: TextInputAction.next,
                    filled: true,
                    maxLength: 100,
                    fillColor: appTheme.gray100,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Industry Type",
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontFamily: 'outfit',
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Container(
                  width: _width / 1.46,
                  child: CustomTextFormField(
                    controller: IndustryType,
                    margin: EdgeInsets.only(
                      top: 10,
                    ),

                    validator: (value) {
                      RegExp nameRegExp = RegExp(r"^[a-zA-Z0-9\s'@]+$");
                      if (value!.isEmpty) {
                        return 'Please Enter Name';
                      } else if (!nameRegExp.hasMatch(value)) {
                        return 'Input cannot contains prohibited special characters';
                      } else if (value.length <= 0 || value.length > 50) {
                        return 'Minimum length required';
                      } else if (value.contains('..')) {
                        return 'username does not contain is correct';
                      }

                      return null;
                    },
                    // textStyle: theme.textTheme.titleMedium!,
                    hintText: "Industry Type",
                    // hintStyle: theme.textTheme.titleMedium!,
                    textInputAction: TextInputAction.next,
                    filled: true,
                    maxLength: 100,
                    fillColor: appTheme.gray100,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Document",
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontFamily: 'outfit',
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Row(
                  children: [
                    Container(
                        height: 50,
                        width: _width / 2.2,
                        decoration: BoxDecoration(
                            color: Color(0XFFF6F6F6),
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(5),
                                bottomLeft: Radius.circular(5))),
                        child: Padding(
                          padding: const EdgeInsets.only(top: 15, left: 20),
                          child: Text(
                            '${dopcument.toString()}',
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(fontSize: 16),
                          ),
                        )),
                    dopcument == "Upload Image"
                        ? GestureDetector(
                            onTap: () async {
                              print(
                                  'dopcument.toString()--${dopcument.toString()}');
                              filepath = await prepareTestPdf(0);
                            },
                            child: Container(
                              height: 50,
                              width: _width / 4.5,
                              decoration: BoxDecoration(
                                  color: Color(0XFF777777),
                                  borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(5),
                                      bottomRight: Radius.circular(5))),
                              child: Center(
                                child: Text(
                                  "Choose",
                                  style: TextStyle(
                                    fontFamily: 'outfit',
                                    fontSize: 15,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),
                          )
                        : Container(
                            height: 50,
                            width: _width / 4.5,
                            decoration: BoxDecoration(
                                color: Color.fromARGB(255, 228, 228, 228),
                                borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(5),
                                    bottomRight: Radius.circular(5))),
                            child: GestureDetector(
                                onTap: () async {
                                  dopcument = "Upload Image";

                                  setState(() {});
                                },
                                child: Icon(
                                  Icons.delete_forever,
                                  color: ColorConstant.primary_color,
                                )),
                          ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Future<void> _selectStartTime(BuildContext context) async {
    TimeOfDay initialTime = TimeOfDay(hour: 0, minute: 0);

    final pickedTime = await showTimePicker(
      context: context,
      initialTime: initialTime,
    );

    if (pickedTime != null && pickedTime != _startTime) {
      setState(() {
        _startTime = pickedTime;
      });
    }
  }

  Future<void> _selectEndTime(BuildContext context) async {
    TimeOfDay initialTime = TimeOfDay(hour: 0, minute: 0);

    final pickedTime = await showTimePicker(
      context: context,
      initialTime: initialTime,
    );

    if (pickedTime != null && pickedTime != _endTime) {
      setState(() {
        _endTime = pickedTime;
      });
    }
  }

  prepareTestPdf(
    int Index,
  ) async {
    PlatformFile file;

    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf', 'png', 'doc', 'jpg'],
    );
    {
      if (result != null) {
        file = result.files.first;

        if ((file.path?.contains(".mp4") ?? false) ||
            (file.path?.contains(".mov") ?? false) ||
            (file.path?.contains(".mp3") ?? false) ||
            (file.path?.contains(".m4a") ?? false)) {
          showDialog(
            context: context,
            builder: (ctx) => AlertDialog(
              title: Text(
                "Selected File Error",
                textScaleFactor: 1.0,
              ),
              content: Text(
                "Only PDF, PNG, JPG Supported.",
                textScaleFactor: 1.0,
              ),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(ctx).pop();
                  },
                  child: Container(
                    // color: Colors.green,
                    padding: const EdgeInsets.all(10),
                    child: const Text("Okay"),
                  ),
                ),
              ],
            ),
          );
        } else {
          getFileSize(
            file.path!,
            1,
            result.files.first,
            Index,
          );
        }
      } else {}
    }
    return "";
    // "${fileparth}";
  }

  getFileSize(
    String filepath,
    int decimals,
    PlatformFile file1,
    int Index,
  ) async {
    var file = File(filepath);
    int bytes = await file.length();
    if (bytes <= 0) return "0 B";
    const suffixes = ["B", "KB", "MB", "GB", "TB", "PB", "EB", "ZB", "YB"];
    var i = (log(bytes) / log(1024)).floor();
    var STR = ((bytes / pow(1024, i)).toStringAsFixed(decimals));
    print('getFileSizevariable-${file1.path}');
    value2 = double.parse(STR);
/* 
    print("value2-->$value2"); */
    switch (i) {
      case 0:
        print("Done file size B");
        switch (Index) {
          case 1:
            if (file1.name.isNotEmpty || file1.name.toString() == null) {
              setState(() {
                uplopdfile.text = file1.name;
                dopcument = file1.name;
              });
            }

            break;
          default:
        }
        print('xfjsdjfjfilenamecheckKB-${file1.path}');

        break;
      case 1:
        print("Done file size KB");
        switch (Index) {
          case 0:
            print("file1.name-->${file1.name}");
            if (file1.name.isNotEmpty || file1.name.toString() == null) {
              setState(() {
                uplopdfile.text = file1.name;
                dopcument = file1.name;
              });
            }
            print('filenamecheckdocmenut-${dopcument}');

            break;
          default:
        }
        print('filenamecheckKB-${file1.path}');
        /* BlocProvider.of<FetchExprtiseRoomCubit>(context)
            .chooseDocumentprofile(dopcument.toString(), file1.path!, context); */
        setState(() {});

        break;
      case 2:
        if (value2 > 10) {
          showDialog(
            context: context,
            builder: (ctx) => AlertDialog(
              title: Text("Max Size ${10}MB"),
              content: Text(
                  "This file size ${value2} ${suffixes[i]} Selected Max size ${10}MB"),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(ctx).pop();
                  },
                  child: Container(
                    // color: Colors.green,
                    padding: const EdgeInsets.all(10),
                    child: const Text("Okay"),
                  ),
                ),
              ],
            ),
          );
        } else {
          print("Done file Size 12MB");
          print("file1.namedata-->${file1.name}");
          switch (Index) {
            case 1:
              setState(() {
                uplopdfile.text = file1.name;
                dopcument = file1.name;
              });
              print("DOCUMENT IN MB ---->$dopcument");
              break;
            default:
          }
          print('filecheckPath1-${file1.name}');
          setState(() {
            uplopdfile.text = file1.name;
            dopcument = file1.name;
          });
          /* BlocProvider.of<FetchExprtiseRoomCubit>(context)
              .chooseDocumentprofile(
                  dopcument.toString(), file1.path!, context); */
        }

        break;
      default:
    }

    return STR;
  }

  updateType() {
    arrNotiyTypeList.forEach((element) {
      element.isSelected = false;
    });
  }
}
