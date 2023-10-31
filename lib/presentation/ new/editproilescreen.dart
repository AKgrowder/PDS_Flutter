// ignore_for_file: must_be_immutable

import 'dart:io';
import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:pds/API/Bloc/my_account_Bloc/my_account_cubit.dart';
import 'package:pds/API/Bloc/my_account_Bloc/my_account_state.dart';
import 'package:pds/API/Model/NewProfileScreenModel/NewProfileScreen_Model.dart';
import 'package:pds/API/Model/createDocumentModel/createDocumentModel.dart';
import 'package:pds/core/utils/color_constant.dart';
import 'package:pds/core/utils/image_constant.dart';
import 'package:pds/core/utils/sharedPreferences.dart';
import 'package:pds/presentation/%20new/stroycommenwoget.dart';
import 'package:pds/presentation/my%20account/my_account_screen.dart';
import 'package:pds/widgets/commentPdf.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../create_foram/create_foram_screen.dart';

class EditProfileScreen extends StatefulWidget {
  NewProfileScreen_Model? newProfileData;
  EditProfileScreen({this.newProfileData});
  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

var userProfile;

class _EditProfileScreenState extends State<EditProfileScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController userNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController contactController = TextEditingController();
  TextEditingController companyName = TextEditingController();
  TextEditingController jobProfile = TextEditingController();
  TextEditingController expertIn = TextEditingController();
  TextEditingController fees = TextEditingController();
  TextEditingController compayName = TextEditingController();
  List<MultiSelectItem<IndustryType>>? _industryTypes = [];
  List<IndustryType> selectedIndustryTypes = [];
  List<IndustryType> selectedIndustryTypes2 = [];
  String? dopcument;
  File? _image;
  File? _image1;
  double value2 = 0.0;
  String? User_Module;
  double documentuploadsize = 0;
  ChooseDocument? chooseDocumentuploded;
  ChooseDocument1? chooseDocumentuploded1;
  String? start;
  String? startAm;
  TimeOfDay? _startTime;
  TimeOfDay? _endTime;

  String? workignStart;
  String? workignend;
  String? end;
  String? endAm;
  List<Expertiseclass> expertiseData = [];
  Expertiseclass? selectedExpertise;
  List<String> industryUUID = [];

  dataSetUpMethod() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    User_Module = prefs.getString(PreferencesKey.module);
    int? a = prefs.getInt(PreferencesKey.mediaSize);
    documentuploadsize = double.parse("${a}");
    nameController.text = widget.newProfileData?.object?.name?.toString() ?? '';
    userNameController.text =
        widget.newProfileData?.object?.userName?.toString() ?? '';
    emailController.text =
        widget.newProfileData?.object?.email?.toString() ?? '';
    contactController.text =
        widget.newProfileData?.object?.mobileNo?.toString() ?? '';

    setState(() {});
  }

  userStatusGet() async {
    if (widget.newProfileData?.object?.module != 'EMPLOYEE') {
      await BlocProvider.of<MyAccountCubit>(context).IndustryTypeAPI(context);
      await BlocProvider.of<MyAccountCubit>(context).fetchExprties(context);
    }
    if (widget.newProfileData?.object?.companyName != null) {
      companyName.text =
          widget.newProfileData?.object?.companyName.toString() ?? '';
    }
    if (widget.newProfileData?.object?.jobProfile != null) {
      jobProfile.text =
          widget.newProfileData?.object?.jobProfile.toString() ?? '';
    }
    if (widget.newProfileData?.object?.workingHours != null) {
      workignStart = widget.newProfileData?.object?.workingHours
          .toString()
          .split(" to ")
          .first;

      start = workignStart?.split(' ')[0];
      startAm = workignStart?.split(' ')[1];
      workignend = widget.newProfileData?.object?.workingHours
          .toString()
          .split(" to ")
          .last;
      end = workignend?.split(' ')[0];
      endAm = workignend?.split(' ')[1];
    }
  }

  Future<void> _selectEndTime(BuildContext context) async {
    TimeOfDay initialTime = TimeOfDay(hour: 0, minute: 0);

    final pickedTime = await showTimePicker(
      context: context,
      initialTime: initialTime,
    );

    String? time = pickedTime?.format(context);
    if (time?.isNotEmpty ?? false) {
      end = time?.split(' ')[0];
      endAm = time?.split(' ')[1];
    } else {
      workignend = widget.newProfileData?.object?.workingHours
          .toString()
          .split(" to ")
          .last;
      end = workignend?.split(' ')[0];
      endAm = workignend?.split(' ')[1];
    }

    if (pickedTime != null && pickedTime != _endTime) {
      setState(() {
        _endTime = pickedTime;
      });
    }
  }

  Future<void> _selectStartTime(BuildContext context) async {
    TimeOfDay initialTime = TimeOfDay(hour: 0, minute: 0);

    final pickedTime = await showTimePicker(
      context: context,
      initialTime: initialTime,
    );

    String? time = pickedTime?.format(context);
    if (time?.isNotEmpty ?? false) {
      start = time?.split(' ')[0];
      startAm = time?.split(' ')[1];
    } else {
      workignStart = widget.newProfileData?.object?.workingHours
          .toString()
          .split(" to ")
          .first;

      start = workignStart?.split(' ')[0];
      startAm = workignStart?.split(' ')[1];
    }

    if (pickedTime != null && pickedTime != _startTime) {
      setState(() {
        _startTime = pickedTime;
      });
    }
  }

  void initState() {
    dataSetUpMethod();
    userStatusGet();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    double _height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: BlocConsumer<MyAccountCubit, MyAccountState>(
          listener: (context, state) {
            if (state is chooseDocumentLoadedState) {
              print("chooseDocumentLoadedState");
              Navigator.pop(context);

              widget.newProfileData?.object?.userProfilePic = null;

              chooseDocumentuploded = state.chooseDocumentuploded;
            }
            if (state is FetchExprtiseRoomLoadedState) {
              state.fetchExprtise.object?.forEach((element) {
                expertiseData.add(Expertiseclass(
                    element.uid.toString(), element.expertiseName.toString()));
              });
              expertiseData.forEach((element) {
                if (element.expertiseName ==
                    widget
                        .newProfileData?.object?.expertise?[0].expertiseName) {
                  selectedExpertise = element;
                }
              });
            }
            if (state is chooseDocumentLoadedState1) {
              print("chooseDocumentLoadedState1");

              Navigator.pop(context);
              widget.newProfileData?.object?.userBackgroundPic = null;
              chooseDocumentuploded1 = state.chooseDocumentuploded1;
            }
            if (state is IndustryTypeLoadedState) {
              widget.newProfileData?.object?.industryTypes?.forEach((element) {
                selectedIndustryTypes2.add((IndustryType(
                  element.industryTypeUid.toString(),
                  element.industryTypeName.toString(),
                )));
              });

              List<IndustryType> industryTypeData1 = state
                  .industryTypeModel.object!
                  .map((industryType) => IndustryType(
                      industryType.industryTypeUid ?? '',
                      industryType.industryTypeName ?? ''))
                  .toList();
              _industryTypes = industryTypeData1
                  .map((industryType) => MultiSelectItem(
                      industryType, industryType.industryTypeName))
                  .toList();
              WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                setState(() {});
              });
            }
          },
          builder: (context, state) {
            return Column(
              children: [
                Container(
                  height: _height / 2.6,
                  width: _width,
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(20)),
                  child: Stack(
                    children: [
                      widget.newProfileData?.object?.userBackgroundPic != null
                          ? Container(
                              height: _height / 3,
                              width: _width,
                              decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20))),
                              child: CachedNetworkImage(
                                imageUrl:
                                    '${widget.newProfileData?.object?.userBackgroundPic?.toString()}',
                                errorWidget: (context, url, error) =>
                                    Icon(Icons.error),
                                fit: BoxFit.fill,
                              ),
                            )
                          : chooseDocumentuploded1?.object != null
                              ? Container(
                                  height: _height / 3,
                                  width: _width,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(20))),
                                  child: CachedNetworkImage(
                                    imageUrl:
                                        '${chooseDocumentuploded1?.object.toString()}',
                                    errorWidget: (context, url, error) =>
                                        Icon(Icons.error),
                                    fit: BoxFit.fill,
                                  ),
                                )
                              : Container(
                                  height: _height / 3,
                                  width: _width,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(20))),
                                  // color: Colors.red,
                                  child: Image.asset(
                                    ImageConstant.placeholder,
                                    fit: BoxFit.cover,
                                    height: 150,
                                    width: 150,
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
                      Positioned(
                          bottom: 70,
                          right: 5,
                          child: userProfile != 'soicalScreen'
                              ? GestureDetector(
                                  onTap: () {
                                    if (widget.newProfileData?.object
                                            ?.userBackgroundPic !=
                                        null) {
                                      _settingModalBottomSheet1(context);
                                    }
                                  },
                                  child: Container(
                                    height: 45,
                                    width: 45,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          color: Color(0xffFFFFFF), width: 4),
                                      shape: BoxShape.circle,
                                      color: Color(0xffFBD8D9),
                                    ),
                                    child: Icon(
                                      Icons.camera_alt_outlined,
                                      color: Colors.red,
                                    ),
                                  ),
                                )
                              : SizedBox()),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          height: 150,
                          width: 150,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle, color: Colors.white),
                          child: Stack(
                            children: [
                              widget.newProfileData?.object?.userProfilePic !=
                                      null
                                  ? Padding(
                                      padding: const EdgeInsets.all(4.0),
                                      child: ClipOval(
                                        child: FittedBox(
                                          child: CachedNetworkImage(
                                            height: 150,
                                            width: 150,
                                            imageUrl:
                                                '${widget.newProfileData?.object?.userProfilePic?.toString()}',
                                            errorWidget:
                                                (context, url, error) =>
                                                    Icon(Icons.error),
                                            fit: BoxFit.fill,
                                          ),
                                        ),
                                      ),
                                    )
                                  : chooseDocumentuploded?.object.toString() !=
                                          null
                                      ? Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: ClipOval(
                                            child: FittedBox(
                                              child: CachedNetworkImage(
                                                height: 150,
                                                width: 150,
                                                imageUrl:
                                                    '${chooseDocumentuploded?.object.toString()}',
                                                errorWidget:
                                                    (context, url, error) =>
                                                        Icon(Icons.error),
                                                fit: BoxFit.fill,
                                              ),
                                            ),
                                          ),
                                        )
                                      : Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: ClipOval(
                                            child: FittedBox(
                                              child: Image.asset(
                                                ImageConstant.placeholder2,
                                                fit: BoxFit.cover,
                                                height: 150,
                                                width: 150,
                                              ),
                                            ),
                                          ),
                                        ),
                              userProfile != 'soicalScreen'
                                  ? Positioned(
                                      bottom: 7,
                                      right: -0,
                                      child: GestureDetector(
                                        onTap: () {
                                          print(
                                              "user profile -- ${widget.newProfileData?.object?.userProfilePic}");

                                          _settingModalBottomSheet(context);
                                        },
                                        child: Container(
                                          height: 40,
                                          width: 40,
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                                color: Color(0xffFFFFFF),
                                                width: 4),
                                            shape: BoxShape.circle,
                                            color: Color(0xffFBD8D9),
                                          ),
                                          child: Icon(
                                            Icons.camera_alt_outlined,
                                            color: Colors.red,
                                          ),
                                        ),
                                      ),
                                    )
                                  : SizedBox()
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Edit Profile",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: "Approved",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: Color(0xff019801),
                        ),
                      )
                    ],
                    text: "Status:",
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: Colors.black),
                  ),
                ),
                Container(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 36, right: 36),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10, bottom: 10),
                          child: Text(
                            "Name",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        customTextFeild(
                          controller: nameController,
                          width: _width / 1.1,
                          hintText: "Enter Name",
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10, bottom: 10),
                          child: Text(
                            "User Name",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        customTextFeild(
                          controller: userNameController,
                          width: _width / 1.1,
                          hintText: "Enter User Name",
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10, bottom: 10),
                          child: Text(
                            "Email",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        customTextFeild(
                          controller: emailController,
                          width: _width / 1.1,
                          hintText: "Email Address",
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10, bottom: 10),
                          child: Text(
                            "Contact no.",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        customTextFeild(
                          controller: contactController,
                          width: _width / 1.1,
                          hintText: "Contact no.",
                        ),
                        TextFiledCommenWiget(_width),
                        GestureDetector(
                          onTap: () {
                            userAllRqureidData();
                            if (User_Module == 'COMPANY') {
                              companyUserData();
                            }
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(top: 40),
                            child: Center(
                              child: Container(
                                height: 40,
                                width: 100,
                                decoration: BoxDecoration(
                                    color: ColorConstant.primary_color,
                                    borderRadius: BorderRadius.circular(10)),
                                child: Center(
                                  child: Text(
                                    "Save",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 15,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  userAllRqureidData() {
    RegExp nameRegExp = RegExp(r"^[a-zA-Z0-9\s'@]+$");
    final RegExp emailRegExp =
        RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
    final RegExp phoneRegExp = RegExp(r'^(?!0+$)[0-9]{10}$');
    if (nameController.text.isEmpty) {
      SnackBar snackBar = SnackBar(
        content: Text('Please Enter Name'),
        backgroundColor: ColorConstant.primary_color,
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } else if (nameController.text.trim().isEmpty) {
      SnackBar snackBar = SnackBar(
        content: Text('Name can\'t be just blank spaces'),
        backgroundColor: ColorConstant.primary_color,
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } else if (!nameRegExp.hasMatch(nameController.text)) {
      SnackBar snackBar = SnackBar(
        content: Text('Input cannot contains prohibited special characters'),
        backgroundColor: ColorConstant.primary_color,
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } else if (nameController.text.length <= 3 ||
        nameController.text.length > 50) {
      SnackBar snackBar = SnackBar(
        content: Text('Minimum length required'),
        backgroundColor: ColorConstant.primary_color,
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } else if (nameController.text.contains('..')) {
      SnackBar snackBar = SnackBar(
        content: Text('username does not contain is correct'),
        backgroundColor: ColorConstant.primary_color,
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } else if (emailController.text.isEmpty) {
      SnackBar snackBar = SnackBar(
        content: Text('Please Enter Email'),
        backgroundColor: ColorConstant.primary_color,
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } else if (!emailRegExp.hasMatch(emailController.text)) {
      SnackBar snackBar = SnackBar(
        content: Text('please Enter vaild Email'),
        backgroundColor: ColorConstant.primary_color,
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } else if (contactController.text.isEmpty) {
      SnackBar snackBar = SnackBar(
        content: Text('Please Enter Mobile Number'),
        backgroundColor: ColorConstant.primary_color,
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } else if (!phoneRegExp.hasMatch(contactController.text)) {
      SnackBar snackBar = SnackBar(
        content: Text('Invalid Mobile Number'),
        backgroundColor: ColorConstant.primary_color,
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  companyUserData() {
    if (jobProfile.text == null || jobProfile.text == '') {
      SnackBar snackBar = SnackBar(
        content: Text('Please Enter Job profile '),
        backgroundColor: ColorConstant.primary_color,
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } else if (jobProfile.text.trim().isEmpty || jobProfile.text.trim() == '') {
      SnackBar snackBar = SnackBar(
        content: Text('Job profile can\'t be just blank spaces '),
        backgroundColor: ColorConstant.primary_color,
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } else if (jobProfile.text.toString().length <= 3 ||
        jobProfile.text.toString().length > 50) {
      SnackBar snackBar = SnackBar(
        content: Text('Please fill full Job Profile'),
        backgroundColor: ColorConstant.primary_color,
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } else if (companyName.text == null || companyName.text == '') {
      SnackBar snackBar = SnackBar(
        content: Text('Please Enter Company Name '),
        backgroundColor: ColorConstant.primary_color,
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } else if (companyName.text.trim().isEmpty ||
        companyName.text.trim() == '') {
      SnackBar snackBar = SnackBar(
        content: Text('Company Name can\'t be just blank spaces '),
        backgroundColor: ColorConstant.primary_color,
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } else if (companyName.text.toString().length <= 3 ||
        companyName.text.toString().length > 50) {
      SnackBar snackBar = SnackBar(
        content: Text('Please fill full Company Name '),
        backgroundColor: ColorConstant.primary_color,
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } else if (dopcument == 'Upload Image') {
      SnackBar snackBar = SnackBar(
        content: Text('Please Upload Image'),
        backgroundColor: ColorConstant.primary_color,
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } else {
      Map<String, dynamic> params = {};
      /*    params['document'] = chooseDocumentuploded2?.object != null
          ? "${chooseDocumentuploded2?.object.toString()}"
          : '${myAccontDetails?.object?.userDocument}'; */
      /*  params['userProfilePic'] = myAccontDetails?.object?.userProfilePic != null
          ? myAccontDetails?.object?.userProfilePic
          : chooseDocumentuploded?.object != null
              ? chooseDocumentuploded?.object.toString()
              : null; */
      params['companyName'] = companyName.text;
      params['jobProfile'] = jobProfile.text;
      params['name'] = nameController.text;
      params['uuid'] = widget.newProfileData?.object?.uuid?.toString();

      params['email'] = emailController.text;
      BlocProvider.of<MyAccountCubit>(context)
          .cretaForumUpdate(params, context);
    }
  }

/*  editProfileScreen(){
   if (userName.text.isEmpty) {
                            SnackBar snackBar = SnackBar(
                              content: Text('Please Enter Name'),
                              backgroundColor: ColorConstant.primary_color,
                            );
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                          } else if (userName.text.trim().isEmpty) {
                            SnackBar snackBar = SnackBar(
                              content: Text('Name can\'t be just blank spaces'),
                              backgroundColor: ColorConstant.primary_color,
                            );
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                          } else if (!nameRegExp.hasMatch(userName.text)) {
                            SnackBar snackBar = SnackBar(
                              content: Text(
                                  'Input cannot contains prohibited special characters'),
                              backgroundColor: ColorConstant.primary_color,
                            );
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                          } else if (userName.text.length <= 3 ||
                              userName.text.length > 50) {
                            SnackBar snackBar = SnackBar(
                              content: Text('Minimum length required'),
                              backgroundColor: ColorConstant.primary_color,
                            );
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                          } else if (userName.text.contains('..')) {
                            SnackBar snackBar = SnackBar(
                              content:
                                  Text('username does not contain is correct'),
                              backgroundColor: ColorConstant.primary_color,
                            );
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                          } else if (email.text.isEmpty) {
                            SnackBar snackBar = SnackBar(
                              content: Text('Please Enter Email'),
                              backgroundColor: ColorConstant.primary_color,
                            );
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                          } else if (!emailRegExp.hasMatch(email.text)) {
                            SnackBar snackBar = SnackBar(
                              content: Text('please Enter vaild Email'),
                              backgroundColor: ColorConstant.primary_color,
                            );
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                          } else if (mobileNo.text.isEmpty) {
                            SnackBar snackBar = SnackBar(
                              content: Text('Please Enter Mobile Number'),
                              backgroundColor: ColorConstant.primary_color,
                            );
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                          } else if (!phoneRegExp.hasMatch(mobileNo.text)) {
                            SnackBar snackBar = SnackBar(
                              content: Text('Invalid Mobile Number'),
                              backgroundColor: ColorConstant.primary_color,
                            );
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                          }
                          if (myAccontDetails?.object?.module == 'COMPANY') {
                            if (isupdate == false) {
                              if (jobProfile.text == null ||
                                  jobProfile.text == '') {
                                SnackBar snackBar = SnackBar(
                                  content: Text('Please Enter Job profile '),
                                  backgroundColor: ColorConstant.primary_color,
                                );
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(snackBar);
                              } else if (jobProfile.text.trim().isEmpty ||
                                  jobProfile.text.trim() == '') {
                                SnackBar snackBar = SnackBar(
                                  content: Text(
                                      'Job profile can\'t be just blank spaces '),
                                  backgroundColor: ColorConstant.primary_color,
                                );
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(snackBar);
                              } else if (jobProfile.text.toString().length <=
                                      3 ||
                                  jobProfile.text.toString().length > 50) {
                                SnackBar snackBar = SnackBar(
                                  content: Text('Please fill full Job Profile'),
                                  backgroundColor: ColorConstant.primary_color,
                                );
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(snackBar);
                              } else if (compayName.text == null ||
                                  compayName.text == '') {
                                SnackBar snackBar = SnackBar(
                                  content: Text('Please Enter Company Name '),
                                  backgroundColor: ColorConstant.primary_color,
                                );
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(snackBar);
                              } else if (compayName.text.trim().isEmpty ||
                                  compayName.text.trim() == '') {
                                SnackBar snackBar = SnackBar(
                                  content: Text(
                                      'Company Name can\'t be just blank spaces '),
                                  backgroundColor: ColorConstant.primary_color,
                                );
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(snackBar);
                              } else if (compayName.text.toString().length <=
                                      3 ||
                                  compayName.text.toString().length > 50) {
                                SnackBar snackBar = SnackBar(
                                  content:
                                      Text('Please fill full Company Name '),
                                  backgroundColor: ColorConstant.primary_color,
                                );
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(snackBar);
                              } else if (dopcument == 'Upload Image') {
                                SnackBar snackBar = SnackBar(
                                  content: Text('Please Upload Image'),
                                  backgroundColor: ColorConstant.primary_color,
                                );
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(snackBar);
                              } else {
                                Map<String, dynamic> params = {};
                                params['document'] = chooseDocumentuploded2
                                            ?.object !=
                                        null
                                    ? "${chooseDocumentuploded2?.object.toString()}"
                                    : '${myAccontDetails?.object?.userDocument}';
                                params['userProfilePic'] = myAccontDetails
                                            ?.object?.userProfilePic !=
                                        null
                                    ? myAccontDetails?.object?.userProfilePic
                                    : chooseDocumentuploded?.object != null
                                        ? chooseDocumentuploded?.object
                                            .toString()
                                        : null;
                                params['companyName'] = compayName.text;
                                params['jobProfile'] = jobProfile.text;
                                params['name'] = userName.text;
                                params['uuid'] =
                                    myAccontDetails?.object?.uuid.toString();

                                params['email'] = email.text;
                                BlocProvider.of<MyAccountCubit>(context)
                                    .cretaForumUpdate(params, context);
                              }
                            }
                          } else if (myAccontDetails?.object?.module ==
                              'EXPERT') {
                            if (jobProfile.text == null ||
                                jobProfile.text == "") {
                              SnackBar snackBar = SnackBar(
                                content: Text('Please Enter Job Profile'),
                                backgroundColor: ColorConstant.primary_color,
                              );
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                            } else if (jobProfile.text.isNotEmpty &&
                                jobProfile.text.length < 4) {
                              SnackBar snackBar = SnackBar(
                                content: Text(
                                    'Minimum length required in Job Profiie'),
                                backgroundColor: ColorConstant.primary_color,
                              );
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                            } else if (selectedExpertise?.expertiseName
                                    .toString() ==
                                null) {
                              SnackBar snackBar = SnackBar(
                                content: Text('Please select Expertise in'),
                                backgroundColor: ColorConstant.primary_color,
                              );
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                            } else if (fees.text == null || fees.text == '') {
                              SnackBar snackBar = SnackBar(
                                content: Text('Please select Fees'),
                                backgroundColor: ColorConstant.primary_color,
                              );
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                            } else if (fees.text == null || fees.text == '') {
                              SnackBar snackBar = SnackBar(
                                content: Text('Please select Fees'),
                                backgroundColor: ColorConstant.primary_color,
                              );
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                            } else if ((start?.isEmpty ?? false) &&
                                (startAm?.isEmpty ?? false) &&
                                (end?.isEmpty ?? false) &&
                                (endAm?.isEmpty ?? false)) {
                              SnackBar snackBar = SnackBar(
                                content: Text('Please select Working Hours'),
                                backgroundColor: ColorConstant.primary_color,
                              );
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                            } else if (dopcument == 'Upload Image') {
                              SnackBar snackBar = SnackBar(
                                content: Text('Please Upload Image'),
                                backgroundColor: ColorConstant.primary_color,
                              );
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                            } else {
                              String time =
                                  '${start} ${startAm} to ${end} ${endAm}';

                              var params = {
                                "document": chooseDocumentuploded2?.object !=
                                        null
                                    ? "${chooseDocumentuploded2?.object.toString()}"
                                    : '${myAccontDetails?.object?.userDocument}',
                                "expertUId": [
                                  "${selectedExpertise?.uid.toString()}"
                                ],
                                "fees": '${fees.text}',
                                "jobProfile": '${jobProfile.text}',
                                "uid": User_ID.toString(),
                                "workingHours": time.toString(),
                                "profilePic": myAccontDetails
                                            ?.object?.userProfilePic !=
                                        null
                                    ? myAccontDetails?.object?.userProfilePic
                                    : chooseDocumentuploded?.object != null
                                        ? chooseDocumentuploded?.object
                                            .toString()
                                        : null,
                                "email": email.text
                              };

                              BlocProvider.of<MyAccountCubit>(context)
                                  .addExpertProfile(params, context);
                            }
 } */

  TextFiledCommenWiget(_width) {
    print(selectedIndustryTypes2);
    selectedIndustryTypes2.forEach((element) {
      print("industry name : ${element.industryTypeName}");
      print("industry name : ${element.industryTypeUid}");
    });
    print("Fgdfhgdfhgdfhdfgh-${widget.newProfileData?.object?.jobProfile}");
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.newProfileData?.object?.companyName != null)
          Padding(
            padding: const EdgeInsets.only(top: 10, bottom: 10),
            child: Text(
              'CompanyName',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
          ),
        if (widget.newProfileData?.object?.companyName != null)
          customTextFeild(
            controller: companyName,
            width: _width / 1.1,
          ),
        if (widget.newProfileData?.object?.jobProfile != null)
          Padding(
            padding: const EdgeInsets.only(top: 10, bottom: 10),
            child: Text(
              'jobProfile',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
          ),
        if (widget.newProfileData?.object?.jobProfile != null)
          customTextFeild(
            controller: jobProfile,
            width: _width / 1.1,
          ),
        if (widget.newProfileData?.object?.industryTypes?.isNotEmpty == true)
          Padding(
            padding: const EdgeInsets.only(top: 10, bottom: 10),
            child: Text(
              'IndustryTypes',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
          ),
        if (widget.newProfileData?.object?.industryTypes?.isNotEmpty == true)
          Container(
            // width: _width / 1.2,
            decoration: BoxDecoration(color: Color(0xffEFEFEF)),
            child: DropdownButtonHideUnderline(
              child: Padding(
                padding: EdgeInsets.only(left: 12),
                child: MultiSelectDialogField<IndustryType>(
                  initialValue: selectedIndustryTypes2,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.transparent)),
                  buttonIcon: Icon(
                    Icons.expand_more,
                    color: Colors.black,
                  ),
                  items: _industryTypes!,
                  listType: MultiSelectListType.LIST,
                  onConfirm: (values) {
                    selectedIndustryTypes2 = values;
                    selectedIndustryTypes2.forEach((element) {
                      industryUUID.add("${element.industryTypeUid}");
                    });
                    setState(() {});
                  },
                ),
              ),
            ),
          ),
        if (widget.newProfileData?.object?.expertise != null)
          Padding(
            padding: const EdgeInsets.only(top: 10, bottom: 10),
            child: Text(
              'Expertise',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
          ),
        if (widget.newProfileData?.object?.expertise != null)
          Container(
            height: 50,
            width: _width,
            decoration: BoxDecoration(
                color: Color(0xffEFEFEF),
                borderRadius: BorderRadius.circular(10)),
            child: DropdownButtonHideUnderline(
              child: Padding(
                padding: EdgeInsets.only(left: 12),
                child: DropdownButton<Expertiseclass>(
                  value: selectedExpertise,
                  // value: Expertiseclass(uid, expertiseName),
                  /*   value: Expertiseclass(selctedexpertiseData[0].uid,selctedexpertiseData[0].expertiseName), */
                  onChanged: (Expertiseclass? newValue) {
                    // When the user selects an option from the dropdown.
                    if (newValue != null) {
                      setState(() {
                        selectedExpertise = newValue;
                        print("Selectedexpertise: ${newValue.uid}");
                      });
                    }
                  },
                  items: expertiseData.map<DropdownMenuItem<Expertiseclass>>(
                      (Expertiseclass expertise) {
                    return DropdownMenuItem<Expertiseclass>(
                      value: expertise,
                      child: Text(expertise.expertiseName),
                    );
                  }).toList(),
                ),
              ),
            ),
          ),
        if (widget.newProfileData?.object?.workingHours != null)
          Padding(
            padding: const EdgeInsets.only(top: 10, bottom: 10),
            child: Text(
              'workingHours',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
          ),
        if (widget.newProfileData?.object?.workingHours != null)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () {
                  _selectStartTime(context);
                },
                child: Container(
                  height: 50,
                  width: 140,
                  decoration: BoxDecoration(
                      color: Color(0xffF6F6F6),
                      borderRadius: BorderRadius.circular(5)),
                  child: Row(
                    children: [
                      Padding(
                          padding: EdgeInsets.only(left: 20),
                          child: Text(
                            start.toString(),
                            style: TextStyle(
                                fontSize: 16, color: Color(0xff989898)),
                          )),
                      SizedBox(
                        width: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10, bottom: 6),
                        child: VerticalDivider(
                          thickness: 2,
                          color: Color(0xff989898),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(startAm.toString(),
                          style: TextStyle(
                              fontSize: 16, color: Color(0xff989898))),
                    ],
                  ),
                ),
              ),
              Text('To'),
              GestureDetector(
                onTap: () {
                  _selectEndTime(context);
                },
                child: Container(
                  height: 50,
                  width: 140,
                  decoration: BoxDecoration(
                      color: Color(0xffF6F6F6),
                      borderRadius: BorderRadius.circular(5)),
                  child: Row(
                    children: [
                      Padding(
                          padding: EdgeInsets.only(left: 20),
                          child: Text(
                            end.toString(),
                            style: TextStyle(
                                fontSize: 16, color: Color(0xff989898)),
                          )),
                      SizedBox(
                        width: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10, bottom: 6),
                        child: VerticalDivider(
                          thickness: 2,
                          color: Color(0xff989898),
                        ),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(endAm.toString(),
                          style: TextStyle(
                              fontSize: 16, color: Color(0xff989898))),
                    ],
                  ),
                ),
              ),
            ],
          )
      ],
    );
  }

  customTextFeild(
      {double? width, TextEditingController? controller, String? hintText}) {
    return Container(
      // height: 50,
      width: width,
      decoration: BoxDecoration(
          color: Color(0xffFFF3F4),
          border: Border.all(
            color: Color(0xffFFC8CA),
          ),
          borderRadius: BorderRadius.circular(5)),
      child: Padding(
        padding: EdgeInsets.only(left: 12),
        child: TextFormField(
          controller: controller,
          autofocus: false,
          cursorColor: ColorConstant.primary_color,
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: TextStyle(color: Color(0xff565656)),
            border: InputBorder.none,
          ),
        ),
      ),
    );
  }

  void _settingModalBottomSheet(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return Container(
            height: 180,
            child: new Wrap(
              children: [
                Container(
                  height: 20,
                  width: 50,
                  color: Colors.transparent,
                ),
                Center(
                    child: Container(
                  height: 5,
                  width: 150,
                  decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(25)),
                )),
                SizedBox(
                  height: 35,
                ),
                Center(
                  child: new ListTile(
                      leading: new Image.asset(
                        ImageConstant.galleryimage,
                        height: 45,
                      ),
                      title: new Text('See Profile Picture'),
                      onTap: () => {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => DocumentViewScreen1(
                                      path:
                                          '${widget.newProfileData?.object?.userProfilePic}',
                                      title: 'Pdf',
                                    )))
                          }),
                ),
                SizedBox(
                  height: 20,
                ),
                Center(
                  child: new ListTile(
                    leading: new Image.asset(
                      ImageConstant.uplodimage,
                      height: 45,
                    ),
                    title: new Text('Upload Profile Picture'),
                    onTap: () => {
                      gallerypicker(),
                    },
                  ),
                ),
              ],
            ),
          );
        });
  }

  void _settingModalBottomSheet1(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return Container(
            height: 180,
            child: new Wrap(
              children: [
                Container(
                  height: 20,
                  width: 50,
                  color: Colors.transparent,
                ),
                Center(
                    child: Container(
                  height: 5,
                  width: 150,
                  decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(25)),
                )),
                SizedBox(
                  height: 35,
                ),
                Center(
                  child: new ListTile(
                      leading: new Image.asset(
                        ImageConstant.galleryimage,
                        height: 45,
                      ),
                      title: new Text('See Profile Picture'),
                      onTap: () => {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => DocumentViewScreen1(
                                      path:
                                          '${widget.newProfileData?.object?.userBackgroundPic}',
                                      title: 'Pdf',
                                    )))
                          }),
                ),
                SizedBox(
                  height: 20,
                ),
                Center(
                  child: new ListTile(
                    leading: new Image.asset(
                      ImageConstant.uplodimage,
                      height: 45,
                    ),
                    title: new Text('Upload Profile Picture'),
                    onTap: () => {
                      gallerypicker1(),
                    },
                  ),
                ),
              ],
            ),
          );
        });
  }

  bool _isGifOrSvg(String imagePath) {
    // Check if the image file has a .gif or .svg extension
    final lowerCaseImagePath = imagePath.toLowerCase();
    return lowerCaseImagePath.endsWith('.gif') ||
        lowerCaseImagePath.endsWith('.svg') ||
        lowerCaseImagePath.endsWith('.pdf') ||
        lowerCaseImagePath.endsWith('.doc') ||
        lowerCaseImagePath.endsWith('.mp4') ||
        lowerCaseImagePath.endsWith('.mov') ||
        lowerCaseImagePath.endsWith('.mp3') ||
        lowerCaseImagePath.endsWith('.m4a');
  }

  Future<void> gallerypicker() async {
    print("this is the gallerypicker");
    var pickedImageFile = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = File(pickedImageFile?.path ?? '');
    });
    if (_image != null) {
      if (!_isGifOrSvg(_image!.path)) {
        _image = File(_image!.path);
        setState(() {});
        getUploadeProfile(_image!.path, 1, _image!, 0);
      }
    }
    print("image selcted Path set-->$_image");
  }

  Future<void> gallerypicker1() async {
    print("this is the gallerypicker1");

    var pickedImageFile = await picker.pickImage(source: ImageSource.gallery);
    _image1 = File(pickedImageFile?.path ?? '');
    setState(() {});

    if (_image1 != null) {
      if (!_isGifOrSvg(_image1!.path)) {
        _image1 = File(_image1!.path);
        setState(() {});
        getUploadeProfile1(_image1!.path, 1, _image1!, 0);
      }
    }

    print("image selcted Path set-->$_image");
  }

  getUploadeProfile(
      String filepath, int decimals, File file1, int Index) async {
    var file = File(filepath);
    int bytes = await file.length();
    if (bytes <= 0) return "0 B";
    const suffixes = ["B", "KB", "MB", "GB", "TB", "PB", "EB", "ZB", "YB"];
    var i = (log(bytes) / log(1024)).floor();
    var STR = ((bytes / pow(1024, i)).toStringAsFixed(decimals));
    print('getFileSizevariable-${file1.path}');
    value2 = double.parse(STR);
    print(file1);
    print(value2);
    switch (i) {
      case 0:
        BlocProvider.of<MyAccountCubit>(context)
            .upoldeProfilePic(_image!, context);
        break;
      case 1:
        print("Done file size KB");

        print('filenamecheckKB-${file1.path}');
        BlocProvider.of<MyAccountCubit>(context)
            .upoldeProfilePic(_image!, context);
        setState(() {});

        break;
      case 2:
        if (value2 > documentuploadsize) {
          print(
              "this file size ${value2} ${suffixes[i]} Selected Max size ${documentuploadsize}MB");

          showDialog(
            context: context,
            builder: (ctx) => AlertDialog(
              title: Text("Max Size ${documentuploadsize}MB"),
              content: Text(
                  "This file size ${value2} ${suffixes[i]} Selected Max size ${documentuploadsize}MB"),
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
          print('filecheckPath-${file1.path}');
          print('filecheckPath-${file1.path}');
          BlocProvider.of<MyAccountCubit>(context)
              .upoldeProfilePic(_image!, context);
        }

        break;
      default:
    }

    return STR;
  }

  getUploadeProfile1(
      String filepath, int decimals, File file1, int Index) async {
    var file = File(filepath);
    int bytes = await file.length();
    if (bytes <= 0) return "0 B";
    const suffixes = ["B", "KB", "MB", "GB", "TB", "PB", "EB", "ZB", "YB"];
    var i = (log(bytes) / log(1024)).floor();
    var STR = ((bytes / pow(1024, i)).toStringAsFixed(decimals));
    print('getFileSizevariable-${file1.path}');
    value2 = double.parse(STR);
    print(file1);
    print(value2);
    switch (i) {
      case 0:
        BlocProvider.of<MyAccountCubit>(context)
            .upoldeProfilePic1(_image1!, context);
        break;
      case 1:
        print("Done file size KB");

        print('filenamecheckKB-${file1.path}');
        BlocProvider.of<MyAccountCubit>(context)
            .upoldeProfilePic1(_image1!, context);
        setState(() {});

        break;
      case 2:
        if (value2 > documentuploadsize) {
          print(
              "this file size ${value2} ${suffixes[i]} Selected Max size ${documentuploadsize}MB");

          showDialog(
            context: context,
            builder: (ctx) => AlertDialog(
              title: Text("Max Size ${documentuploadsize}MB"),
              content: Text(
                  "This file size ${value2} ${suffixes[i]} Selected Max size ${documentuploadsize}MB"),
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
          print('filecheckPath-${file1.path}');
          print('filecheckPath-${file1.path}');
          BlocProvider.of<MyAccountCubit>(context)
              .upoldeProfilePic1(_image1!, context);
        }

        break;
      default:
    }

    return STR;
  }
}
