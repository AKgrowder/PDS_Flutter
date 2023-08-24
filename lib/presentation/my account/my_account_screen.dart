import 'package:archit_s_application1/API/Bloc/my_account_Bloc/my_account_cubit.dart';
import 'package:archit_s_application1/API/Bloc/my_account_Bloc/my_account_state.dart';
import 'package:archit_s_application1/API/Model/myaccountModel/myaccountModel.dart';
import 'package:archit_s_application1/core/utils/color_constant.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/utils/image_constant.dart';
import '../../theme/theme_helper.dart';
import '../../widgets/app_bar/custom_app_bar.dart';
import '../../widgets/custom_icon_button.dart';
import '../../widgets/custom_image_view.dart';
import '../settings/setting_screen.dart';

class MyAccountScreen extends StatefulWidget {
  const MyAccountScreen({Key? key}) : super(key: key);

  @override
  State<MyAccountScreen> createState() => _MyAccountScreenState();
}

TextEditingController uplopdfile = TextEditingController();

class _MyAccountScreenState extends State<MyAccountScreen> {
  MyAccontDetails? myAccontDetails;
  @override
  void initState() {
    BlocProvider.of<MyAccountCubit>(context).MyAccount(context);
    super.initState();
  }

  TextEditingController userId = TextEditingController();
  TextEditingController userName = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController mobileNo = TextEditingController();
  TextEditingController jobProfile = TextEditingController();
  TextEditingController expertIn = TextEditingController();
  TextEditingController fees = TextEditingController();
  bool isupdate = true;
  bool? expertBool = false;
  dataSetMethod(
      {String? useridSetdata,
      String? userNameSetdata,
      String? emailSetdata,
      String? mobileNoSetdata,
      String? jobProfileSetdata,
      String? expertInSetdata,
      dynamic feesInSetdata}) {
    userId.text = useridSetdata != null ? useridSetdata : '';
    userName.text = userNameSetdata != null ? userNameSetdata : '';
    email.text = emailSetdata != null ? emailSetdata : '';
    mobileNo.text = mobileNoSetdata != null ? mobileNoSetdata : '';
    jobProfile.text = jobProfileSetdata != null ? jobProfileSetdata : '';
    expertIn.text = expertInSetdata != null ? expertInSetdata : '';
    fees.text = feesInSetdata != null ? '${feesInSetdata.toString()}' : '';
    setState(() {});
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
          expertBool = state.myAccontDetails.object?.expertise?.isNotEmpty;
          print('check expertbool-${expertBool}');  
          dataSetMethod(
            useridSetdata: state.myAccontDetails.object?.uuid,
            userNameSetdata: state.myAccontDetails.object?.userName,
            emailSetdata: state.myAccontDetails.object?.email,
            expertInSetdata: '',
            jobProfileSetdata: state.myAccontDetails.object?.jobProfile,
            mobileNoSetdata: state.myAccontDetails.object?.mobileNo,
            feesInSetdata: state.myAccontDetails.object?.fees,
          );
          print('printstatment-${myAccontDetails?.object?.expertise?.isEmpty}');
        }
        if (state is MyAccountErrorState) {
          SnackBar snackBar = SnackBar(
            content: Text(state.error.toString()),
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
                                              Text("Approved",
                                                  style: TextStyle(
                                                      color: Colors.green,
                                                      fontSize: 18,
                                                      fontFamily: 'Outfit',
                                                      fontWeight:
                                                          FontWeight.w400))
                                            ])
                                      : SizedBox(),
                                ),
                              ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      isupdate = false;
                      setState(() {});
                      print('isupdate-$isupdate');
                    },
                    child: Icon(
                      Icons.edit,
                      color: Colors.grey,
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
                                      // fit: BoxFit.cover,
                                      child: CachedNetworkImage(
                                        imageUrl:
                                            '${myAccontDetails?.object?.userProfilePic}',
                                        height: 120,
                                        width: 120,
                                        fit: BoxFit.cover,
                                        placeholder: (context, url) =>
                                            CircularProgressIndicator(),
                                        errorWidget: (context, url, error) {
                                          print('url print-$url');
                                          print('error$error');

                                          return  Icon(Icons.error);
                                        }
                                      ),
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {},
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
                        : Align(
                            alignment: Alignment.center,
                            child: Container(
                              height: _height / 8,
                              width: _width / 3.7,
                              child: Stack(
                                alignment: Alignment.bottomRight,
                                children: [
                                  CustomImageView(
                                    imagePath: ImageConstant.viewdetailsimage,
                                    height: 130,
                                    width: 130,
                                    radius: BorderRadius.circular(65),
                                    alignment: Alignment.center,
                                  ),
                                  CustomIconButton(
                                    height: 33,
                                    width: 33,
                                    alignment: Alignment.bottomRight,
                                    child: GestureDetector(
                                      onTap: () {},
                                      child: CustomImageView(
                                        svgPath: ImageConstant.imgCamera,
                                        color: Colors.black,
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
                                  readOnly: isupdate,
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
                        "Your Name",
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
                            readOnly: isupdate,
                            controller: userName,
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
                        "Email",
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
                            readOnly: isupdate,
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
                                  readOnly: true,
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
                   expertBool == true?  Center(
                      child: Container(
                        height: 50,
                        width: _width / 1.2,
                        decoration: BoxDecoration(
                            color: Color(0xFFF6F6F6),
                            borderRadius: BorderRadius.circular(10)),
                        child: Padding(
                          padding: const EdgeInsets.only(top: 15.0, left: 10),
                          child: Text(
                            "Expertise in",
                            style: TextStyle(
                                fontWeight: FontWeight.w400,
                                color: Colors.grey.shade700,
                                fontFamily: "outfit",
                                fontSize: 15),
                          ),
                        ),
                      ),
                    ):SizedBox(),
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
                                    controller: jobProfile,
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
                        ? Padding(
                            padding:
                                const EdgeInsets.only(left: 30.0, right: 30),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Container(
                                  height: 50,
                                  width: 130,
                                  decoration: BoxDecoration(
                                      color: Color(0xFFF6F6F6),
                                      borderRadius: BorderRadius.circular(5)),
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        top: 0.0, left: 10),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Text(
                                          '${myAccontDetails?.object?.workingHours?.split('to').first}',
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
                                          "AM",
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
                                      borderRadius: BorderRadius.circular(5)),
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        top: 0.0, left: 10),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Text(
                                          '${myAccontDetails?.object?.workingHours?.split('to').last}',
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
                                          "AM",
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
                    myAccontDetails?.object?.userDocument != null
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
                    myAccontDetails?.object?.userDocument != null
                        ? Padding(
                            padding: const EdgeInsets.only(left: 35.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  height: 50,
                                  width: _width / 1.65,
                                  decoration: BoxDecoration(
                                      color: Color(0XFFF6F6F6),
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(5),
                                          bottomLeft: Radius.circular(5))),
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
                                GestureDetector(
                                  onTap: () {},
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
                                        "Change",
                                        style: TextStyle(
                                          fontFamily: 'outfit',
                                          fontSize: 15,
                                          color: Colors.white,
                                          fontWeight: FontWeight.w500,
                                        ),
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
                    Center(
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
}
