import 'dart:io';
import 'dart:math';

import 'package:pds/API/Bloc/my_account_Bloc/my_account_cubit.dart';
import 'package:pds/API/Bloc/my_account_Bloc/my_account_state.dart';
import 'package:pds/API/Model/FetchExprtiseModel/fetchExprtiseModel.dart';
import 'package:pds/API/Model/createDocumentModel/createDocumentModel.dart';
import 'package:pds/API/Model/myaccountModel/myaccountModel.dart';
import 'package:pds/core/utils/color_constant.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pds/core/utils/sharedPreferences.dart';
import 'package:pds/presentation/rooms/rooms_screen.dart';
import 'package:pds/widgets/commentPdf.dart';
// import 'package:pds/widgets/commentPdf.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../core/utils/image_constant.dart';
import '../../theme/theme_helper.dart';
import '../../widgets/app_bar/custom_app_bar.dart';
import '../../widgets/custom_image_view.dart';
import '../settings/setting_screen.dart';

class MyAccountScreen extends StatefulWidget {
  const MyAccountScreen({Key? key}) : super(key: key);

  @override
  State<MyAccountScreen> createState() => _MyAccountScreenState();
}

class _MyAccountScreenState extends State<MyAccountScreen> {
  TextEditingController uplopdfile = TextEditingController();
  double documentuploadsize = 0;

  MyAccontDetails? myAccontDetails;
  getDocumentSize() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    int? a = prefs.getInt(PreferencesKey.mediaSize);
    documentuploadsize = double.parse("${a}");
    print('scdhfggfgdf-$documentuploadsize.');
    setState(() {});
  }

  @override
  void initState() {
    getDocumentSize();
    BlocProvider.of<MyAccountCubit>(context).MyAccount(context);
    localDataGet();
    super.initState();
  }

  ImagePicker _imagePicker = ImagePicker();
  TextEditingController userId = TextEditingController();
  TextEditingController userName = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController mobileNo = TextEditingController();
  TextEditingController jobProfile = TextEditingController();
  TextEditingController expertIn = TextEditingController();
  TextEditingController fees = TextEditingController();
  TextEditingController compayName = TextEditingController();
  String? User_ID;
  XFile? pickedFile;
  File? pickedImage;
  double value2 = 0.0;
  FetchExprtise? _fetchExprtise;
  List<Expertiseclass> expertiseData = [];
  Expertiseclass? selectedExpertise;

  String? dopcument;
  TimeOfDay? _startTime;
  TimeOfDay? _endTime;
  bool isupdate = true;
  bool? expertBool = false;
  String? workignStart;
  String? workignend;
  String setTime = 'Am';
  String? filepath;
  double finalFileSize = 12.0;

  String? start;
  String? startAm;
  String? end;
  String? endAm;

  ChooseDocument? chooseDocumentuploded2;
  ChooseDocument? chooseDocumentuploded;
  List<String>? workingInList;
  PermissionStatus _cameraPermissionStatus = PermissionStatus.denied;
  PermissionStatus _galleryPermissionStatus = PermissionStatus.denied;
  Uint8List? _pdfData;
  List<Expertiseclass> selctedexpertiseData = [];
  dataSetMethod(
      {String? useridSetdata,
      String? userNameSetdata,
      String? emailSetdata,
      String? mobileNoSetdata,
      String? jobProfileSetdata,
      String? expertInSetdata,
      dynamic feesInSetdata,
      String? companyNameSetData}) {
    userId.text = useridSetdata != null ? useridSetdata : '';
    userName.text = userNameSetdata != null ? userNameSetdata : '';
    email.text = emailSetdata != null ? emailSetdata : '';
    mobileNo.text = mobileNoSetdata != null ? mobileNoSetdata : '';
    jobProfile.text = jobProfileSetdata != null ? jobProfileSetdata : '';
    expertIn.text = expertInSetdata != null ? expertInSetdata : '';
    fees.text = feesInSetdata != null ? '${feesInSetdata.toString()}' : '';
    compayName.text =
        companyNameSetData != null ? '${companyNameSetData.toString()}' : '';
    setState(() {});
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
      workignStart =
          myAccontDetails?.object?.workingHours.toString().split(" to ").first;

      start = workignStart?.split(' ')[0];
      startAm = workignStart?.split(' ')[1];
    }

    if (pickedTime != null && pickedTime != _startTime) {
      setState(() {
        _startTime = pickedTime;
      });
    }
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
      workignend =
          myAccontDetails?.object?.workingHours.toString().split(" to ").last;
      end = workignend?.split(' ')[0];
      endAm = workignend?.split(' ')[1];
    }

    if (pickedTime != null && pickedTime != _endTime) {
      setState(() {
        _endTime = pickedTime;
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    double _height = MediaQuery.of(context).size.height;
    return BlocConsumer<MyAccountCubit, MyAccountState>(
      listener: (context, state) {
        if (state is MyAccountLoadingState) {
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
        if (state is MyAccountLoadedState) {
          myAccontDetails = state.myAccontDetails;
          print('fbddbgvdfb-${myAccontDetails?.object?.isEmailVerified}');
          if (myAccontDetails?.object?.module == 'EXPERT') {
            BlocProvider.of<MyAccountCubit>(context).fetchExprties(context);
          }
          expertBool = state.myAccontDetails.object?.expertise?.isNotEmpty;
          dataSetMethod(
            useridSetdata: state.myAccontDetails.object?.name,
            userNameSetdata: state.myAccontDetails.object?.userName,
            emailSetdata: state.myAccontDetails.object?.email,
            expertInSetdata: '',
            jobProfileSetdata: state.myAccontDetails.object?.jobProfile,
            mobileNoSetdata: state.myAccontDetails.object?.mobileNo,
            feesInSetdata: state.myAccontDetails.object?.fees,
            companyNameSetData: state.myAccontDetails.object?.companyName,
          );
          if (myAccontDetails?.object?.expertise?.isEmpty == false) {
            selctedexpertiseData.add(Expertiseclass(
                '${myAccontDetails?.object?.expertise?.first.uid}',
                '${myAccontDetails?.object?.expertise?.first.expertiseName}'));
          }
          if (myAccontDetails?.object?.workingHours != null) {
            workignStart = myAccontDetails?.object?.workingHours
                .toString()
                .split(" to ")
                .first;

            start = workignStart?.split(' ')[0];
            startAm = workignStart?.split(' ')[1];
            workignend = myAccontDetails?.object?.workingHours
                .toString()
                .split(" to ")
                .last;
            end = workignend?.split(' ')[0];
            endAm = workignend?.split(' ')[1];
          }
        }
        if (state is MyAccountErrorState) {
          SnackBar snackBar = SnackBar(
            content: Text(state.error.toString()),
            backgroundColor: ColorConstant.primary_color,
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
        if (state is AddExportLoadedState) {
          SnackBar snackBar = SnackBar(
            content: Text(state.addExpertProfile.message.toString()),
            backgroundColor: ColorConstant.primary_color,
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
          Navigator.pop(context);
        }
        if (state is chooseDocumentLoadedState) {
          chooseDocumentuploded = state.chooseDocumentuploded;
          myAccontDetails?.object?.userProfilePic = null;

          Navigator.pop(context);
        }
        if (state is chooseDocumentLoadedState2) {
          chooseDocumentuploded2 = state.chooseDocumentuploded;
        }
        if (state is FetchExprtiseRoomLoadedState) {
          state.fetchExprtise.object?.forEach((element) {
            expertiseData.add(Expertiseclass(
                element.uid.toString(), element.expertiseName.toString()));
          });

          expertiseData.forEach((element) {
            if (element.expertiseName ==
                myAccontDetails?.object?.expertise?[0].expertiseName) {
              selectedExpertise = element;
            }
          });
        }
        if (state is CreatFourmLoadedState) {
          SnackBar snackBar = SnackBar(
            content: Text(state.createForm.object.toString()),
            backgroundColor: ColorConstant.primary_color,
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
          Navigator.pop(context);
        }
        if (state is UpdateProfileLoadedState) {
          SnackBar snackBar = SnackBar(
            content: Text(state.updateProfile.object.toString()),
            backgroundColor: ColorConstant.primary_color,
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
          Navigator.pop(context);
        }
        if (state is EmailVerifactionLoadedState) {
          SnackBar snackBar = SnackBar(
            content: Text(state.emailVerifaction.message.toString()),
            backgroundColor: ColorConstant.primary_color,
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: theme.colorScheme.onPrimary,
          appBar: CustomAppBar(
              height: 100,
              leadingWidth: 74,
              centerTitle: true,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Icon(
                      Icons.arrow_back,
                      color: Colors.grey,
                    ),
                  ),
                  Container(
                    height: 50.58,
                    // width: getHorizontalSize(139),
                    child: Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        Align(
                            alignment: Alignment.topCenter,
                            child: Padding(
                                padding: EdgeInsets.only(
                                    left: 21, right: 22, bottom: 24),
                                child: Text(
                                  'My Details',
                                  textScaleFactor: 1.0,
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.left,
                                  style: TextStyle(color: Colors.black),
                                ))),
                        IsGuestUserEnabled == "true"
                            ? SizedBox.shrink()
                            : myAccontDetails?.object?.approvalStatus != null
                                ? Align(
                                    alignment: Alignment.bottomCenter,
                                    child: Padding(
                                      padding: EdgeInsets.only(top: 22),
                                      child: myAccontDetails?.object?.module !=
                                              'EMPLOYEE'
                                          ? Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                  Text("Status:",
                                                      textScaleFactor: 1.0,
                                                      style: TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 18,
                                                          fontFamily: 'Outfit',
                                                          fontWeight:
                                                              FontWeight.w400)),
                                                  Text(
                                                      "${myAccontDetails?.object?.approvalStatus}",
                                                      style: TextStyle(
                                                          color: Colors.green,
                                                          fontSize: 18,
                                                          fontFamily: 'Outfit',
                                                          fontWeight:
                                                              FontWeight.w400))
                                                ])
                                          : SizedBox(),
                                    ),
                                  )
                                : SizedBox(),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      isupdate = isupdate == true ? false : true;
                      dopcument = myAccontDetails?.object?.userDocument != null
                          ? myAccontDetails?.object?.userDocument
                          : 'Upload Image';
                      /*    if (selctedexpertiseData.length != null ||
                          selctedexpertiseData.isNotEmpty) {
                        print(
                            'check expertiseName-${selctedexpertiseData.first.expertiseName}');
                        print('check uid-${selctedexpertiseData.first.uid}');
                      } */
                      setState(() {});
                    },
                    child: Icon(
                      Icons.edit,
                      color: isupdate == false ? Colors.red : Colors.grey,
                    ),
                  )
                ],
              )),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(top: 50.0),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    myAccontDetails?.object?.userProfilePic != null
                        ? Align(
                            alignment: Alignment.center,
                            child: Stack(
                              alignment: Alignment.bottomRight,
                              children: [
                                Container(
                                  height: 120,
                                  child: ClipOval(
                                    child: FittedBox(
                                      child: CachedNetworkImage(
                                          imageUrl:
                                              '${myAccontDetails?.object?.userProfilePic}',
                                          height: 120,
                                          width: 120,
                                          fit: BoxFit.cover,
                                          placeholder: (context, url) =>
                                              CircularProgressIndicator(),
                                          errorWidget: (context, url, error) {
                                            return Icon(Icons.error);
                                          }),
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    if (isupdate == false) {
                                      _openBottomSheet(context);
                                    }
                                  },
                                  child: Container(
                                    height: 50,
                                    width: 30,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        // color: Colors.red,
                                        shape: BoxShape.circle),
                                    child: CustomImageView(
                                      svgPath: ImageConstant.imgCamera,
                                      alignment: Alignment.center,
                                    ),
                                    // child: CustomIconButton(
                                    //   height: 33,
                                    //   width: 33,
                                    //   alignment: Alignment.bottomRight,
                                    //   child: GestureDetector(
                                    //     onTap: () {
                                    //       pickImage();
                                    //     },
                                    //     child: CustomImageView(
                                    //       svgPath: ImageConstant.imgCamera,
                                    //     ),
                                    //   ),
                                    // ),
                                  ),
                                ),
                              ],
                            ),
                          )
                        : chooseDocumentuploded?.object != null
                            ? Align(
                                alignment: Alignment.center,
                                child: Stack(
                                  alignment: Alignment.bottomRight,
                                  children: [
                                    Container(
                                      height: 120,
                                      child: ClipOval(
                                        child: FittedBox(
                                          child: CachedNetworkImage(
                                              imageUrl:
                                                  '${chooseDocumentuploded?.object}',
                                              height: 120,
                                              width: 120,
                                              fit: BoxFit.cover,
                                              placeholder: (context, url) =>
                                                  CircularProgressIndicator(),
                                              errorWidget:
                                                  (context, url, error) {
                                                return Icon(Icons.error);
                                              }),
                                        ),
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        _openBottomSheet(context);
                                      },
                                      child: Container(
                                        height: 50,
                                        width: 30,
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            // color: Colors.red,
                                            shape: BoxShape.circle),
                                        child: CustomImageView(
                                          svgPath: ImageConstant.imgCamera,
                                          alignment: Alignment.center,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            : Align(
                                alignment: Alignment.center,
                                child: Container(
                                  height: 130,
                                  width: 130,
                                  margin: EdgeInsets.only(
                                    top: 20,
                                  ),
                                  child: Stack(
                                    alignment: Alignment.bottomRight,
                                    children: [
                                      CustomImageView(
                                        imagePath: ImageConstant.userProfie,
                                        height: 130,
                                        width: 130,
                                        radius: BorderRadius.circular(65),
                                        alignment: Alignment.center,
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          if (isupdate == false) {
                                            _openBottomSheet(context);
                                          }
                                        },
                                        child: Container(
                                          height: 50,
                                          width: 30,
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              // color: Colors.red,
                                              shape: BoxShape.circle),
                                          child: CustomImageView(
                                            svgPath: ImageConstant.imgCamera,
                                            alignment: Alignment.center,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                    myAccontDetails?.object?.uuid != null
                        ? Padding(
                            padding: const EdgeInsets.only(left: 36.0, top: 10),
                            child: Text(
                              "User ID",
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black,
                                  fontFamily: "outfit",
                                  fontSize: 15),
                            ),
                          )
                        : SizedBox(),
                    SizedBox(
                      height: 5,
                    ),
                    myAccontDetails?.object?.uuid != null
                        ? Center(
                            child: Container(
                              // height: 50,
                              width: _width / 1.2,
                              decoration: BoxDecoration(
                                  color: Color(0xFFF6F6F6),
                                  borderRadius: BorderRadius.circular(10)),
                              child: Padding(
                                padding: EdgeInsets.only(left: 10),
                                child: TextFormField(
                                  readOnly: true,
                                  controller: userId,
                                  cursorColor: Colors.grey,
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                  ),
                                ),
                              ),
                            ),
                          )
                        : SizedBox(),
                    Padding(
                      padding: const EdgeInsets.only(left: 36.0, top: 20),
                      child: Text(
                        "User Name",
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                            fontFamily: "outfit",
                            fontSize: 15),
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Center(
                      child: Container(
                        height: 50,
                        width: _width / 1.2,
                        decoration: BoxDecoration(
                            color: Color(0xFFF6F6F6),
                            borderRadius: BorderRadius.circular(10)),
                        child: Padding(
                          padding: EdgeInsets.only(left: 10),
                          child: TextFormField(
                            readOnly: true,
                            controller: userName,
                            cursorColor: Colors.grey,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 36.0, top: 20),
                          child: Text(
                            "Email",
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: Colors.black,
                                fontFamily: "outfit",
                                fontSize: 15),
                          ),
                        ),
                        Spacer(),
                        myAccontDetails?.object?.isEmailVerified == false
                            ? GestureDetector(
                                onTap: () {
                                  if (isupdate == false) {
                                    BlocProvider.of<MyAccountCubit>(context)
                                        .emailVerifaction(context,
                                            "${myAccontDetails?.object?.email}");
                                  }
                                },
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                    top: 20,
                                    right: 2,
                                  ),
                                  child: Text(
                                    'Not Verified',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black,
                                        fontFamily: "outfit",
                                        fontSize: 15),
                                  ),
                                ),
                              )
                            : Padding(
                                padding: const EdgeInsets.only(
                                  top: 20,
                                  right: 2,
                                ),
                                child: Text(
                                  'Verified',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black,
                                      fontFamily: "outfit",
                                      fontSize: 15),
                                ),
                              ),
                        myAccontDetails?.object?.isEmailVerified == false
                            ? GestureDetector(
                                onTap: () {
                                  /*   myAccontDetails?.object?.isEmailVerified =
                                      true;
                                  setState(() {}); */

                                  if (isupdate == false) {
                                    BlocProvider.of<MyAccountCubit>(context)
                                        .emailVerifaction(context,
                                            "${myAccontDetails?.object?.email}");
                                  }
                                },
                                child: Padding(
                                  padding:
                                      const EdgeInsets.only(top: 20, right: 38),
                                  child: SizedBox(
                                      height: 22,
                                      child: Image.asset(
                                        ImageConstant.notVerify,
                                        color: Colors.red,
                                      )),
                                ),
                              )
                            : Padding(
                                padding:
                                    const EdgeInsets.only(top: 20, right: 38),
                                child: SizedBox(
                                    height: 22,
                                    child: Image.asset(
                                      ImageConstant.Verified,
                                      color: Colors.green,
                                    )),
                              )
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Center(
                      child: Container(
                        height: 50,
                        width: _width / 1.2,
                        decoration: BoxDecoration(
                            color: Color(0xFFF6F6F6),
                            borderRadius: BorderRadius.circular(10)),
                        child: Padding(
                          padding: EdgeInsets.only(left: 10),
                          child: TextFormField(
                            readOnly: isupdate,
                            controller: email,
                            cursorColor: Colors.grey,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 36.0, top: 20),
                      child: Text(
                        "Contact no.",
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                            fontFamily: "outfit",
                            fontSize: 15),
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Center(
                      child: Container(
                        height: 50,
                        width: _width / 1.2,
                        decoration: BoxDecoration(
                            color: Color(0xFFF6F6F6),
                            borderRadius: BorderRadius.circular(10)),
                        child: Padding(
                          padding: EdgeInsets.only(left: 10),
                          child: TextFormField(
                            // maxLength : 10,
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(
                                  RegExp(r'[0-9]')),
                              LengthLimitingTextInputFormatter(10),
                            ],
                            keyboardType: TextInputType.numberWithOptions(
                              decimal: true,
                            ),
                            readOnly: true,
                            controller: mobileNo,
                            cursorColor: Colors.grey,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      ),
                    ),
                    myAccontDetails?.object?.jobProfile != null
                        ? Padding(
                            padding: const EdgeInsets.only(left: 36.0, top: 20),
                            child: Text(
                              "Job Profile",
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black,
                                  fontFamily: "outfit",
                                  fontSize: 15),
                            ),
                          )
                        : SizedBox(),
                    SizedBox(
                      height: 5,
                    ),
                    myAccontDetails?.object?.jobProfile != null
                        ? Center(
                            child: Container(
                              height: 50,
                              width: _width / 1.2,
                              decoration: BoxDecoration(
                                  color: Color(0xFFF6F6F6),
                                  borderRadius: BorderRadius.circular(10)),
                              child: Padding(
                                padding: EdgeInsets.only(left: 10),
                                child: TextFormField(
                                  readOnly: isupdate,
                                  controller: jobProfile,
                                  cursorColor: Colors.grey,
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                  ),
                                ),
                              ),
                            ),
                          )
                        : SizedBox(),
                    myAccontDetails?.object?.companyName != null
                        ? Padding(
                            padding: const EdgeInsets.only(left: 36.0, top: 20),
                            child: Text(
                              "Company Name",
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black,
                                  fontFamily: "outfit",
                                  fontSize: 15),
                            ),
                          )
                        : SizedBox(),
                    SizedBox(
                      height: 5,
                    ),
                    myAccontDetails?.object?.companyName != null
                        ? Center(
                            child: Container(
                              height: 50,
                              width: _width / 1.2,
                              decoration: BoxDecoration(
                                  color: Color(0xFFF6F6F6),
                                  borderRadius: BorderRadius.circular(10)),
                              child: Padding(
                                  padding: EdgeInsets.only(left: 10),
                                  child: TextFormField(
                                    readOnly: myAccontDetails
                                                ?.object?.approvalStatus ==
                                            'APPROVED'
                                        ? true
                                        : isupdate,
                                    controller: compayName,
                                    cursorColor: Colors.grey,
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                    ),
                                  )),
                            ),
                          )
                        : SizedBox(),
                    expertBool == true
                        ? Padding(
                            padding: const EdgeInsets.only(left: 36.0, top: 20),
                            child: Text(
                              "Expertise in",
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black,
                                  fontFamily: "outfit",
                                  fontSize: 15),
                            ),
                          )
                        : SizedBox(),
                    SizedBox(
                      height: 5,
                    ),
                    expertBool == true
                        ? isupdate == false
                            ? Container(
                                margin: EdgeInsets.only(left: 36, right: 36),
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
                                            print(
                                                "Selectedexpertise: ${newValue.uid}");
                                          });
                                        }
                                      },
                                      items: expertiseData.map<
                                              DropdownMenuItem<Expertiseclass>>(
                                          (Expertiseclass expertise) {
                                        return DropdownMenuItem<Expertiseclass>(
                                          value: expertise,
                                          child: Text(expertise.expertiseName),
                                        );
                                      }).toList(),
                                    ),
                                  ),
                                ),
                              )
                            : Center(
                                child: Container(
                                  height: 50,
                                  width: _width / 1.2,
                                  decoration: BoxDecoration(
                                      color: Color(0xFFF6F6F6),
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        top: 15.0, left: 10),
                                    child: Text(
                                      "${myAccontDetails?.object?.expertise?[0].expertiseName}",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          color: Colors.grey.shade700,
                                          fontFamily: "outfit",
                                          fontSize: 15),
                                    ),
                                  ),
                                ),
                              )
                        : SizedBox(),
                    myAccontDetails?.object?.fees != null
                        ? Padding(
                            padding: const EdgeInsets.only(left: 36.0, top: 20),
                            child: Text(
                              "Fees",
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black,
                                  fontFamily: "outfit",
                                  fontSize: 15),
                            ),
                          )
                        : SizedBox(),
                    SizedBox(
                      height: 5,
                    ),
                    myAccontDetails?.object?.fees != null
                        ? Center(
                            child: Container(
                                height: 50,
                                width: _width / 1.2,
                                decoration: BoxDecoration(
                                    color: Color(0xFFF6F6F6),
                                    borderRadius: BorderRadius.circular(10)),
                                child: Padding(
                                  padding: EdgeInsets.only(left: 10),
                                  child: TextFormField(
                                    readOnly: isupdate,
                                    controller: fees,
                                    inputFormatters: [
                                      FilteringTextInputFormatter.allow(
                                          RegExp(r'^\d{0,4}(\.\d{0,2})?')),
                                    ],
                                    keyboardType:
                                        TextInputType.numberWithOptions(
                                      decimal: true,
                                    ),
                                    cursorColor: Colors.grey,
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                    ),
                                  ),
                                )),
                          )
                        : SizedBox(),
                    myAccontDetails?.object?.workingHours != null
                        ? Padding(
                            padding: const EdgeInsets.only(left: 36.0, top: 20),
                            child: Text(
                              "Working Hours",
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black,
                                  fontFamily: "outfit",
                                  fontSize: 15),
                            ),
                          )
                        : SizedBox(),
                    SizedBox(
                      height: 5,
                    ),
                    myAccontDetails?.object?.workingHours != null
                        ? isupdate == false
                            ? Padding(
                                padding:
                                    const EdgeInsets.only(left: 36, right: 36),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
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
                                            borderRadius:
                                                BorderRadius.circular(5)),
                                        child: Row(
                                          children: [
                                            Padding(
                                                padding:
                                                    EdgeInsets.only(left: 20),
                                                child: Text(
                                                  start.toString(),
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      color: Color(0xff989898)),
                                                )),
                                            SizedBox(
                                              width: 20,
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 10, bottom: 6),
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
                                                    fontSize: 16,
                                                    color: Color(0xff989898))),
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
                                            borderRadius:
                                                BorderRadius.circular(5)),
                                        child: Row(
                                          children: [
                                            Padding(
                                                padding:
                                                    EdgeInsets.only(left: 20),
                                                child: Text(
                                                  end.toString(),
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      color: Color(0xff989898)),
                                                )),
                                            SizedBox(
                                              width: 20,
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 10, bottom: 6),
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
                                                    fontSize: 16,
                                                    color: Color(0xff989898))),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            : Padding(
                                padding: const EdgeInsets.only(
                                    left: 30.0, right: 30),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Container(
                                      height: 50,
                                      width: 130,
                                      decoration: BoxDecoration(
                                          color: Color(0xFFF6F6F6),
                                          borderRadius:
                                              BorderRadius.circular(5)),
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            top: 0.0, left: 10),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            Text(
                                              '${start}',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w400,
                                                  color: Colors.grey.shade700,
                                                  fontFamily: "outfit",
                                                  fontSize: 15),
                                            ),
                                            Container(
                                              width: 1,
                                              height: 30,
                                              color: Colors.grey,
                                            ),
                                            Text(
                                              "${startAm}",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w400,
                                                  color: Colors.grey.shade700,
                                                  fontFamily: "outfit",
                                                  fontSize: 15),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Text(
                                      "TO",
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w400,
                                          fontFamily: 'outfit'),
                                    ),
                                    Container(
                                      height: 50,
                                      width: 130,
                                      decoration: BoxDecoration(
                                          color: Color(0xFFF6F6F6),
                                          borderRadius:
                                              BorderRadius.circular(5)),
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            top: 0.0, left: 10),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            Text(
                                              '${end}',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w400,
                                                  color: Colors.grey.shade700,
                                                  fontFamily: "outfit",
                                                  fontSize: 15),
                                            ),
                                            Container(
                                              width: 1,
                                              height: 30,
                                              color: Colors.grey,
                                            ),
                                            Text(
                                              '${endAm}',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w400,
                                                  color: Colors.grey.shade700,
                                                  fontFamily: "outfit",
                                                  fontSize: 15),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                        : SizedBox(),
                    myAccontDetails?.object?.userDocument != null &&
                            myAccontDetails?.object?.userDocument != ''
                        ? Padding(
                            padding: const EdgeInsets.only(
                                top: 10.0, left: 35, bottom: 5),
                            child: Text(
                              "Document",
                              style: TextStyle(
                                fontFamily: 'outfit',
                                fontSize: 15,
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          )
                        : SizedBox(),
                    myAccontDetails?.object?.userDocument != null &&
                            myAccontDetails?.object?.userDocument != ''
                        ? isupdate == false
                            ? Padding(
                                padding: const EdgeInsets.only(left: 36),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    DocumentViewScreen(
                                                      path: myAccontDetails
                                                          ?.object?.userDocument
                                                          .toString(),
                                                      title: 'Pdf',
                                                    )));
                                      },
                                      child: Container(
                                          height: 50,
                                          width: _width / 1.6,
                                          decoration: BoxDecoration(
                                              color: Color(0XFFF6F6F6),
                                              borderRadius: BorderRadius.only(
                                                  topLeft: Radius.circular(5),
                                                  bottomLeft:
                                                      Radius.circular(5))),
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                top: 15, left: 20),
                                            child: Text(
                                              '${dopcument.toString()}',
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(fontSize: 16),
                                            ),
                                          )),
                                    ),
                                    dopcument == "Upload Image"
                                        ? GestureDetector(
                                            onTap: () async {
                                              filepath =
                                                  await prepareTestPdf(0);
                                            },
                                            child: Container(
                                              height: 50,
                                              width: _width / 4.5,
                                              decoration: BoxDecoration(
                                                  color: Color(0XFF777777),
                                                  borderRadius:
                                                      BorderRadius.only(
                                                          topRight:
                                                              Radius.circular(
                                                                  5),
                                                          bottomRight:
                                                              Radius.circular(
                                                                  5))),
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
                                        : myAccontDetails
                                                    ?.object?.approvalStatus !=
                                                'APPROVED'
                                            ? Container(
                                                height: 50,
                                                width: _width / 4.5,
                                                decoration: BoxDecoration(
                                                    color: Color.fromARGB(
                                                        255, 228, 228, 228),
                                                    borderRadius:
                                                        BorderRadius.only(
                                                            topRight: Radius
                                                                .circular(5),
                                                            bottomRight:
                                                                Radius.circular(
                                                                    5))),
                                                child: GestureDetector(
                                                    onTap: () {
                                                      dopcument =
                                                          "Upload Image";
                                                      setState(() {});
                                                    },
                                                    child: Icon(
                                                      Icons.delete_forever,
                                                      color: ColorConstant
                                                          .primary_color,
                                                    )),
                                              )
                                            : GestureDetector(
                                                onTap: () {
                                                  SnackBar snackBar = SnackBar(
                                                    content: Text(
                                                        "Your Profile is Approved,You can't Change Document!"),
                                                    backgroundColor:
                                                        ColorConstant
                                                            .primary_color,
                                                  );
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(snackBar);

                                                  /*    showPdfDialog(
                                                      context,
                                                      myAccontDetails
                                                          ?.object?.userDocument
                                                          ?.toString()); */
                                                },
                                                child: Container(
                                                  height: 50,
                                                  width: _width / 4.5,
                                                  decoration: BoxDecoration(
                                                      color: Color.fromARGB(
                                                          255, 189, 189, 189),
                                                      borderRadius:
                                                          BorderRadius.only(
                                                              topRight: Radius
                                                                  .circular(5),
                                                              bottomRight:
                                                                  Radius
                                                                      .circular(
                                                                          5))),
                                                  child: Center(
                                                    child: Text(
                                                      "Change",
                                                      style: TextStyle(
                                                        fontFamily: 'outfit',
                                                        fontSize: 15,
                                                        color: Colors.black45,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                  ],
                                ),
                              )
                            : Padding(
                                padding: const EdgeInsets.only(left: 35.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        /*   Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    DocumentViewScreen(
                                                      path: myAccontDetails
                                                          ?.object?.userDocument
                                                          .toString(),
                                                      title: 'Pdf',
                                                    ))); */
                                      },
                                      child: Container(
                                        height: 50,
                                        width: _width / 1.65,
                                        decoration: BoxDecoration(
                                            color: Color(0XFFF6F6F6),
                                            borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(5),
                                                bottomLeft:
                                                    Radius.circular(5))),
                                        child: Padding(
                                            padding: const EdgeInsets.only(
                                                top: 13.0, left: 10),
                                            child: Text(
                                              '${myAccontDetails?.object?.userDocument}',
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                fontFamily: 'outfit',
                                                fontSize: 15,
                                                color: Colors.grey,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            )),
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    DocumentViewScreen(
                                                      path: myAccontDetails
                                                          ?.object?.userDocument
                                                          .toString(),
                                                      title: 'Pdf',
                                                    )));
                                      },
                                      child: Container(
                                        height: 50,
                                        width: _width / 4.5,
                                        decoration: BoxDecoration(
                                            color: Color.fromARGB(
                                                255, 226, 226, 226),
                                            borderRadius: BorderRadius.only(
                                                topRight: Radius.circular(5),
                                                bottomRight:
                                                    Radius.circular(5))),
                                        child: Center(
                                          child: Icon(
                                            Icons.remove_red_eye_outlined,
                                            color: Colors.red,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                        : SizedBox(),
                    SizedBox(
                      height: 30,
                    ),
                    GestureDetector(
                      onTap: () {
                        if (isupdate == false) {
                          RegExp nameRegExp = RegExp(r"^[a-zA-Z0-9\s'@]+$");
                          final RegExp emailRegExp = RegExp(
                              r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
                          final RegExp phoneRegExp =
                              RegExp(r'^(?!0+$)[0-9]{10}$');
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
                          } else if (myAccontDetails?.object?.module ==
                              'EMPLOYEE') {
                            if (isupdate == false) {
                              var params = {
                                "userProfilePic": myAccontDetails
                                            ?.object?.userProfilePic !=
                                        null
                                    ? myAccontDetails?.object?.userProfilePic
                                    : chooseDocumentuploded?.object != null
                                        ? chooseDocumentuploded?.object
                                            .toString()
                                        : null,
                                "uid": User_ID.toString(),
                                "email": email.text,
                              };
                              BlocProvider.of<MyAccountCubit>(context)
                                  .UpdateProfileEmployee(params, context);
                            }
                          }
                        }
                      },
                      child: isupdate == false
                          ? Center(
                              child: Container(
                                height: 50,
                                width: _width / 3,
                                decoration: BoxDecoration(
                                    color: Color(0xFFED1C25),
                                    borderRadius: BorderRadius.circular(5)),
                                child: Center(
                                  child: Text(
                                    "Save",
                                    style: TextStyle(
                                        fontFamily: 'outfit',
                                        fontSize: 18,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            )
                          : SizedBox(),
                    ),
                    SizedBox(
                      height: 10,
                    )
                  ]),
            ),
          ),
        );
      },
    );
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
        print("Done file size B");

        print('xfjsdjfjfilenamecheckKB-${file1.path}');
        BlocProvider.of<MyAccountCubit>(context)
            .upoldeProfilePic(pickedImage!, context);
        break;
      case 1:
        print("Done file size KB");

        print('filenamecheckKB-${file1.path}');
        BlocProvider.of<MyAccountCubit>(context)
            .upoldeProfilePic(pickedImage!, context);
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
              .upoldeProfilePic(pickedImage!, context);
        }

        break;
      default:
    }

    return STR;
  }

  Future<void> _requestPermissions() async {
    final cameraStatus = await Permission.camera.request();

    setState(() {
      _cameraPermissionStatus = cameraStatus;
    });
  }

  Future<void> _getImageFromSource(ImageSource source) async {
    try {
      pickedFile = await _imagePicker.pickImage(source: source);

      if (pickedFile != null) {
        if (!_isGifOrSvg(pickedFile!.path)) {
          pickedImage = File(pickedFile!.path);
          setState(() {});
          getUploadeProfile(pickedImage!.path, 1, pickedImage!, 0);
        } else {
          Navigator.pop(context);
          SnackBar snackBar = SnackBar(
            content: Text('GIF and SVG images are not allowed.'),
            backgroundColor: ColorConstant.primary_color,
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
      }
    } catch (e) {
      print('error-$e');
    }
  }

  Future<void> _openBottomSheet(BuildContext context) async {
    if (_cameraPermissionStatus.isGranted) {
      showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                leading: Icon(Icons.photo_camera),
                title: Text('Take a photo'),
                onTap: () => _getImageFromSource(ImageSource.camera),
              ),
              ListTile(
                leading: Icon(Icons.photo_library),
                title: Text('Choose from gallery'),
                onTap: () => _getImageFromSource(ImageSource.gallery),
              ),
            ],
          );
        },
      );
    } else {
      _requestPermissions();
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
          getFileSize(file.path!, 1, result.files.first, Index, context);
        }

        /*     setState(() {
          // fileparth = file.path!;

          switch (Index) {
            case 1:
              GSTName = "";
              // file.name;

              break;
            case 2:
              PanName = file.name;

              break;
            case 3:
              UdhyanName = file.name;

              break;
            default:
          }

          BlocProvider.of<DocumentUploadCubit>(context)
              .documentUpload(file.path!);
        });  */
      } else {}
    }
    return "";
    // "${fileparth}";
  }

  getFileSize(String filepath, int decimals, PlatformFile file1, int Index,
      context) async {
    var file = File(filepath);
    int bytes = await file.length();
    if (bytes <= 0) return "0 B";
    const suffixes = ["B", "KB", "MB", "GB", "TB", "PB", "EB", "ZB", "YB"];
    var i = (log(bytes) / log(1024)).floor();
    var STR = ((bytes / pow(1024, i)).toStringAsFixed(decimals));
    print('getFileSizevariable-${file1.path}');
    value2 = double.parse(STR);

    print(value2);
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
        BlocProvider.of<MyAccountCubit>(context)
            .chooseDocumentprofile(dopcument.toString(), file1.path!, context);

        setState(() {});

        break;
      case 2:
        if (value2 > finalFileSize) {
          print(
              "this file size ${value2} ${suffixes[i]} Selected Max size ${finalFileSize}MB");

          showDialog(
            context: context,
            builder: (ctx) => AlertDialog(
              title: Text("Max Size ${finalFileSize}MB"),
              content: Text(
                  "This file size ${value2} ${suffixes[i]} Selected Max size ${finalFileSize}MB"),
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

          switch (Index) {
            case 1:
              setState(() {
                uplopdfile.text = file1.name;
                dopcument = file1.name;
              });
              break;

            default:
          }
          print('filecheckPath-${file1.path}');
          print('filecheckPath-${file1.path}');
          BlocProvider.of<MyAccountCubit>(context).chooseDocumentprofile(
              dopcument.toString(), file1.path!, context);
        }

        break;
      default:
    }

    return STR;
  }

  localDataGet() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    User_ID = prefs.getString(PreferencesKey.loginUserID);
    prefs.setBool(PreferencesKey.OpenProfile, false);

    setState(() {});
  }
}

class Expertiseclass {
  final String uid;
  final String expertiseName;

  Expertiseclass(this.uid, this.expertiseName);
}
