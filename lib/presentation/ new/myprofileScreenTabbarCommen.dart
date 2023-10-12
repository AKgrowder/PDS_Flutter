// ignore_for_file: must_be_immutable

import 'dart:io';
import 'dart:math';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:pds/core/utils/color_constant.dart';
import 'package:pds/core/utils/image_constant.dart';
import 'package:pds/presentation/%20new/editproilescreen.dart';
import 'package:pds/presentation/%20new/posttabbar.dart';
import 'package:pds/presentation/%20new/savedScrren.dart';
import 'package:pds/theme/theme_helper.dart';
import 'package:pds/widgets/custom_text_form_field.dart';

import 'commetTabbar.dart';

class MyAcoountTabbarScreen extends StatefulWidget {
  String userProfile;
  List<String> tabScreen;
  MyAcoountTabbarScreen({required this.tabScreen, required this.userProfile});
  @override
  _MyAcoountTabbarScreenState createState() => _MyAcoountTabbarScreenState();
}

class _MyAcoountTabbarScreenState extends State<MyAcoountTabbarScreen>
    with SingleTickerProviderStateMixin {
  TabController? _tabController;
  TextEditingController jobprofileController = TextEditingController();
  TextEditingController IndustryType = TextEditingController();
  TextEditingController priceContrller = TextEditingController();
  TextEditingController FeesContrller = TextEditingController();
  TextEditingController uplopdfile = TextEditingController();
  TextEditingController CompanyName = TextEditingController();

  TimeOfDay? _startTime;
  TimeOfDay? _endTime;
  String? dopcument;
  String? filepath;
  double value2 = 0.0;
  List<String> image = [
    ImageConstant.post1,
    ImageConstant.post2,
    ImageConstant.post3,
    ImageConstant.post4,
    ImageConstant.post5,
    ImageConstant.post6,
  ];
  List<String> newesData = [
    'Newest to oldest',
  ];
  String selctedValue = 'Newest to oldest';
  String selctedValue1 = 'All Date';
  String selctedValue2 = 'All Users';
  List tabsData = ["Posts", "Blogs"];
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

  @override
  void initState() {
    super.initState();
    dopcument = 'Upload Image';
    _tabController =
        TabController(length: widget.tabScreen.length, vsync: this);
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
    return DefaultTabController(
      length: widget.tabScreen.length,
      child: Scaffold(
        // Remove the app bar
        body: Column(
          // Use a Column to display TabBar and TabBarView
          children: <Widget>[
            TabBar(
                unselectedLabelColor: Color(0xff444444),
                labelColor: Color(0xff000000),
                controller: _tabController,
                tabs: List.generate(
                    widget.tabScreen.length,
                    (index) => Tab(
                            child: Text(
                          widget.tabScreen[index].toString(),
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontFamily: "outfit",
                            fontSize: 14,
                          ),
                        )))),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: <Widget>[
                  // Content of Tab 1
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 16, right: 16, top: 14),
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
                                crossAxisAlignment: CrossAxisAlignment.start,
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
                        )
                      ],
                    ),
                  ),
                  // Content of Tab 2

                  PostTabbarView(image: image),

                  // Content of Tab 3
                  MyWidget(
                      selctedValue: selctedValue,
                      selctedValue1: selctedValue1,
                      selctedValue2: selctedValue2),
                  if (widget.userProfile != 'soicalScreen')
                    ListSaveScreen(tabs: tabsData, value2: 1, image: image)
                ],
              ),
            ),
          ],
        ),
      ),
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
}
