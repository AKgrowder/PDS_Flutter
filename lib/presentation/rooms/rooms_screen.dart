import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:pds/API/Bloc/CreateRoom_Bloc/CreateRoom_state.dart';
import 'package:pds/dialogs/edit_dilog.dart';
import 'package:pds/dilogs/invite_dilog.dart';
import 'package:pds/presentation/%20new/newbottembar.dart';
import 'package:pds/presentation/experts/experts_screen.dart';
import 'package:pds/presentation/room_members/room_members_screen.dart';
import 'package:pds/presentation/rooms/room_details_screen.dart';
import 'package:pds/presentation/view_comments/view_comments_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../API/Bloc/CreateRoom_Bloc/CreateRoom_cubit.dart';
import '../../API/Bloc/GetAllPrivateRoom_Bloc/GetAllPrivateRoom_cubit.dart';
import '../../API/Bloc/GetAllPrivateRoom_Bloc/GetAllPrivateRoom_state.dart';
import '../../API/Model/GetAllPrivateRoom/GetAllPrivateRoom_Model.dart';
import '../../core/utils/color_constant.dart';
import '../../core/utils/image_constant.dart';
import '../../core/utils/sharedPreferences.dart';
import '../../theme/theme_helper.dart';
import '../../widgets/custom_image_view.dart';
import '../create_foram/create_foram_screen.dart';
import '../register_create_account_screen/register_create_account_screen.dart';

class RoomsScreen extends StatefulWidget {
  const RoomsScreen({Key? key}) : super(key: key);

  @override
  State<RoomsScreen> createState() => _RoomsScreenState();
}

// var formattedDate = new DateTime.Format('yyyy-MM-dd').DateTime.now();
List? image = [];
List? imagee = [];
List? close = [];
List? closee = [];
GetAllPrivateRoomModel? PriveateRoomData;
String? User_Mood;
DateTime now = DateTime.now();

String formattedDate = DateFormat('dd-MM-yyyy').format(now);

class _RoomsScreenState extends State<RoomsScreen> {
  var Show_NoData_Image = false;
  var checkuserdata = "";
  List<bool> ExpertList = [];
  List ExpertList2 = [];
  var Show_Expert = false;
  bool SubmitOneTime = false;
  String? userId;

  sherPerffrence() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    userId = prefs.getString(
      PreferencesKey.loginUserID,
    );
    setState(() {});
  }

  @override
  void initState() {
    Show_NoData_Image = true;
    sherPerffrence();
    // BlocProvider.of<GetAllPrivateRoomCubit>(context).GetAllPrivateRoomAPI();
    // BlocProvider.of<GetAllPrivateRoomCubit>(context).GetAllPrivateRoomAPI();
    // BlocProvider.of<GetAllPrivateRoomCubit>(context).chckUserStaus();
    method();
    // BlocProvider.of<GetAllPrivateRoomCubit>(context).chckUserStaus();
    super.initState();
  }

  method() async {
    print('this methosd perint or not');

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    User_Mood = prefs.getString(PreferencesKey.module);
    var User_ID = prefs.getString(PreferencesKey.loginUserID);
    if (User_ID != "" && User_ID?.isNotEmpty == true) {
      await BlocProvider.of<GetAllPrivateRoomCubit>(context)
          .seetinonExpried(context);
      await BlocProvider.of<GetAllPrivateRoomCubit>(context)
          .chckUserStaus(context);
    }

    await BlocProvider.of<GetAllPrivateRoomCubit>(context)
        .GetAllPrivateRoomAPI(context);
  }

  String customFormat(DateTime date) {
    String day = date.day.toString();
    String month = _getMonthName(date.month);
    String year = date.year.toString();
    String time = DateFormat('h:mm a').format(date);

    String formattedDate = '$day$month $year $time';
    return formattedDate;
  }

  String _getMonthName(int month) {
    switch (month) {
      case 1:
        return ' January';
      case 2:
        return ' February';
      case 3:
        return ' March';
      case 4:
        return ' April';
      case 5:
        return ' May';
      case 6:
        return ' June';
      case 7:
        return ' July';
      case 8:
        return ' August';
      case 9:
        return ' September';
      case 10:
        return ' October';
      case 11:
        return ' November';
      case 12:
        return ' December';
      default:
        return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    print('build method ');
    method();
    // method();
    var _width = MediaQuery.of(context).size.width;
    var _height = MediaQuery.of(context).size.height;

    return WillPopScope(
      onWillPop: () async {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
                builder: (context) => NewBottomBar(buttomIndex: 0)),
            (Route<dynamic> route) => false);
        return true;
      },
      child: Scaffold(
          backgroundColor: theme.colorScheme.onPrimary,
          appBar: AppBar(
            backgroundColor: theme.colorScheme.onPrimary,
            elevation: 0,
            centerTitle: true,
            title: Text(
              "Rooms",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontFamily: "outfit",
                  fontSize: 20),
            ),
          ),
          body: BlocConsumer<GetAllPrivateRoomCubit, GetAllPrivateRoomState>(
              listener: (context, state) async {
            if (state is GetAllPrivateRoomErrorState) {
              if (state.error == "not found") {
                print("Show Image");
                Show_NoData_Image = true;
              } else {
                SnackBar snackBar = SnackBar(
                  content: Text(state.error),
                  backgroundColor: ColorConstant.primary_color,
                );
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              }
            }

            if (state is GetAllPrivateRoomLoadingState) {
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
            if (state is GetAllPrivateRoomLoadedState) {
              print("GetAllPrivateRoomLoadedState");
              PriveateRoomData = state.PublicRoomData;
              if (PriveateRoomData?.object?.length == 0 ||
                  PriveateRoomData?.object?.length == null) {
                Show_NoData_Image = true;
              } else {
                Show_NoData_Image = false;
              }

              print(PriveateRoomData?.message);
            }

            if (state is CheckuserLoadedState) {
              print('User Create Forum -${state.checkUserStausModel.object}');
              checkuserdata = state.checkUserStausModel.object ?? "";
            }
          }, builder: (context, state) {
            print('hear this builder can build');

            if (state is GetAllPrivateRoomLoadedState) {
              return Show_NoData_Image == false
                  ? Stack(
                      children: [
                        SingleChildScrollView(
                          child: Column(children: [
                            ListView.builder(
                              // itemCount: aa.length,
                              itemCount: PriveateRoomData?.object?.length,
                              /* (image?.contains(index) ?? false)
                                ? aa.length
                                : aa.length, */
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) {
                                print(
                                    "####################################${PriveateRoomData?.object?[index]}");
                                // final apiDate = DateTime.parse(PublicRoomData
                                //         ?.object?[index].createdDate
                                //         .toString() ??
                                //     '');

                                DateTime parsedDateTime = DateTime.parse(
                                    '${PriveateRoomData?.object?[index].createdDate ?? ""}');
                                return Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 35, vertical: 5),
                                  child: GestureDetector(
                                    onTap: () {},
                                    child: Container(
                                      // height: demo.contains(index) ? null: height / 16,
                                      width: _width / 1.2,
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: const Color(0XFFED1C25),
                                              width: 1),
                                          borderRadius:
                                              BorderRadius.circular(5)),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              SizedBox(
                                                width: 10,
                                              ),
                                              // Text(formattedDate),

                                              Text(
                                                customFormat(parsedDateTime),
                                                // "${parsedDateTime}"  ,
                                                maxLines: 2,
                                                textScaleFactor: 1.0,
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w500,
                                                    color: Colors.grey,
                                                    fontFamily: "outfit",
                                                    fontSize: 14),
                                              ),
                                              Spacer(),
                                              checkuserdata ==
                                                      "PARTIALLY_REGISTERED"
                                                  ? SizedBox()
                                                  : User_Mood == "EXPERT"
                                                      ? SizedBox()
                                                      : PriveateRoomData
                                                                  ?.object?[
                                                                      index]
                                                                  .createdBy ==
                                                              userId
                                                          ? Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      right:
                                                                          35.0),
                                                              child:
                                                                  GestureDetector(
                                                                onTap: () {
                                                                  showDialog(
                                                                    context:
                                                                        context,
                                                                    builder:
                                                                        (context) =>
                                                                            ScaffoldMessenger(
                                                                      child:
                                                                          Builder(
                                                                        builder:
                                                                            (context) =>
                                                                                Scaffold(
                                                                          backgroundColor:
                                                                              Colors.transparent,
                                                                          body:
                                                                              EditDilogScreen(
                                                                            parentName:
                                                                                PriveateRoomData?.object?[index].roomQuestion,
                                                                            uid:
                                                                                PriveateRoomData?.object?[index].uid.toString(),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  );

                                                                  // showDialog(
                                                                  //   context: context,
                                                                  //   builder:
                                                                  //       (BuildContext context) {
                                                                  //     print(
                                                                  //         'uid print-${PublicRoomData?.object?[index].uid}');
                                                                  //     return MultiBlocProvider(
                                                                  //         providers: [
                                                                  //           BlocProvider<
                                                                  //               EditroomCubit>(
                                                                  //             create: (context) =>
                                                                  //                 EditroomCubit(),
                                                                  //           )
                                                                  //         ],
                                                                  //         child:
                                                                  //             EditDilogScreen(
                                                                  //           parentName:
                                                                  //               PublicRoomData
                                                                  //                   ?.object?[
                                                                  //                       index]
                                                                  //                   .roomQuestion,
                                                                  //           uid: PublicRoomData
                                                                  //               ?.object?[index]
                                                                  //               .uid
                                                                  //               .toString(),
                                                                  //         ));
                                                                  //   },
                                                                  // );
                                                                  // editProfile(PublicRoomData?.object?[index].uid.toString());
                                                                  // showDialog(
                                                                  //     context: context,
                                                                  //     builder: (_) =>
                                                                  //         EditDilogScreen());
                                                                },
                                                                child:
                                                                    CustomImageView(
                                                                  imagePath:
                                                                      ImageConstant
                                                                          .pen,
                                                                  height: 15,
                                                                ),
                                                              ),
                                                            )
                                                          : SizedBox(),
                                              checkuserdata ==
                                                      "PARTIALLY_REGISTERED"
                                                  ? SizedBox()
                                                  : User_Mood == "EXPERT"
                                                      ? SizedBox()
                                                      : PriveateRoomData
                                                                  ?.object?[
                                                                      index]
                                                                  .createdBy ==
                                                              userId
                                                          ? GestureDetector(
                                                              onTap: () {
                                                                showDialog(
                                                                    context:
                                                                        context,
                                                                    builder:
                                                                        (context) {
                                                                      return Center(
                                                                        child:
                                                                            Container(
                                                                          color:
                                                                              Colors.white,
                                                                          margin: EdgeInsets.only(
                                                                              left: 20,
                                                                              right: 20),
                                                                          height:
                                                                              200,
                                                                          width:
                                                                              _width,
                                                                          // color: Colors.amber,
                                                                          child: BlocConsumer<
                                                                              GetAllPrivateRoomCubit,
                                                                              GetAllPrivateRoomState>(
                                                                            listener:
                                                                                (context, state) {
                                                                              if (state is DeleteRoomLoadedState) {
                                                                                SnackBar snackBar = SnackBar(
                                                                                  content: Text(state.DeleteRoom.object ?? ""),
                                                                                  backgroundColor: ColorConstant.primary_color,
                                                                                );
                                                                                ScaffoldMessenger.of(context).showSnackBar(snackBar);

                                                                                method();
                                                                                Navigator.pop(context);
                                                                              }
                                                                            },
                                                                            builder:
                                                                                (context, state) {
                                                                              return Column(
                                                                                children: [
                                                                                  SizedBox(
                                                                                    height: 10,
                                                                                  ),
                                                                                  Text(
                                                                                    "Exit Room",
                                                                                    style: TextStyle(
                                                                                      fontFamily: 'outfit',
                                                                                      fontSize: 20,
                                                                                      color: Colors.black,
                                                                                      fontWeight: FontWeight.bold,
                                                                                    ),
                                                                                  ),
                                                                                  Divider(
                                                                                    color: Colors.grey,
                                                                                  ),
                                                                                  SizedBox(
                                                                                    height: 5,
                                                                                  ),
                                                                                  Center(
                                                                                      child: Text(
                                                                                    "Are You Sure You Want To Exit This Room",
                                                                                    style: TextStyle(
                                                                                      fontFamily: 'outfit',
                                                                                      fontSize: 15,
                                                                                      color: Colors.black,
                                                                                      fontWeight: FontWeight.w500,
                                                                                    ),
                                                                                  )),
                                                                                  SizedBox(
                                                                                    height: 50,
                                                                                  ),
                                                                                  Row(
                                                                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                                                    children: [
                                                                                      GestureDetector(
                                                                                        onTap: () => Navigator.pop(context),
                                                                                        child: Container(
                                                                                          height: 43,
                                                                                          width: _width / 3.5,
                                                                                          decoration: BoxDecoration(color: Colors.transparent, border: Border.all(color: Colors.grey.shade400), borderRadius: BorderRadius.circular(10)),
                                                                                          child: Center(
                                                                                              child: Text(
                                                                                            "Cancel",
                                                                                            style: TextStyle(
                                                                                              fontFamily: 'outfit',
                                                                                              fontSize: 15,
                                                                                              color: Color(0xFFED1C25),
                                                                                              fontWeight: FontWeight.w400,
                                                                                            ),
                                                                                          )),
                                                                                        ),
                                                                                      ),
                                                                                      GestureDetector(
                                                                                        onTap: () {
                                                                                          BlocProvider.of<GetAllPrivateRoomCubit>(context).DeleteRoomm(PriveateRoomData!.object![index].uid.toString(), context);
                                                                                        },
                                                                                        child: Container(
                                                                                          height: 43,
                                                                                          width: _width / 3.5,
                                                                                          decoration: BoxDecoration(color: Color(0xFFED1C25), borderRadius: BorderRadius.circular(10)),
                                                                                          child: Center(
                                                                                              child: Text(
                                                                                            "Exit",
                                                                                            style: TextStyle(
                                                                                              fontFamily: 'outfit',
                                                                                              fontSize: 15,
                                                                                              color: Colors.white,
                                                                                              fontWeight: FontWeight.w400,
                                                                                            ),
                                                                                          )),
                                                                                        ),
                                                                                      ),
                                                                                    ],
                                                                                  ),
                                                                                ],
                                                                              );
                                                                            },
                                                                          ),
                                                                        ),
                                                                      );
                                                                    });
                                                                // showDialog(
                                                                //   context: context,
                                                                //   builder:
                                                                //       (BuildContext context) {
                                                                //     return MultiBlocProvider(
                                                                //         providers: [
                                                                //           BlocProvider<
                                                                //               DeleteRoomCubit>(
                                                                //             create: (context) =>
                                                                //                 DeleteRoomCubit(),
                                                                //           )
                                                                //         ],
                                                                //         child:
                                                                //             DeleteDilogScreen(
                                                                //           userId:
                                                                //               PublicRoomData
                                                                //                   ?.object?[
                                                                //                       index]
                                                                //                   .uid
                                                                //                   .toString(),
                                                                //         ));
                                                                //   },
                                                                // );
                                                              },
                                                              child:
                                                                  CustomImageView(
                                                                imagePath:
                                                                    ImageConstant
                                                                        .delete,
                                                                height: 20,
                                                                color: Colors
                                                                    .black,
                                                              ),
                                                            )
                                                          : SizedBox(),
                                              User_Mood == "EXPERT"
                                                  ? GestureDetector(
                                                      onTap: () {
                                                        print('EXPERT');
                                                        print(
                                                            "check UserId Print-->${PriveateRoomData?.object?[index].uid.toString()}");
                                                        Navigator.push(context,
                                                            MaterialPageRoute(
                                                          builder: (context) {
                                                            return RoomDetailScreen(
                                                              uuid: PriveateRoomData
                                                                  ?.object?[
                                                                      index]
                                                                  .uid
                                                                  .toString(),
                                                            );
                                                          },
                                                        ));
                                                      },
                                                      child: Icon(Icons
                                                          .remove_red_eye_outlined),
                                                    )
                                                  : SizedBox(),
                                              SizedBox(
                                                width: 10,
                                              ),
                                            ],
                                          ),
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 10),
                                                child: Container(
                                                  // color: Colors.amber,
                                                  width: _width / 1.3,
                                                  child: Text(
                                                    "${PriveateRoomData?.object?[index].roomQuestion}",
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.black,
                                                        fontFamily: "outfit",
                                                        fontSize: 14),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 8.0),
                                            child: Text(
                                              "${PriveateRoomData?.object?[index].description}",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w400,
                                                  color: Colors.black
                                                      .withOpacity(0.5),
                                                  fontFamily: "outfit",
                                                  fontSize: 14),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 20,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 8.0),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceAround,
                                                children: [
                                                  CustomImageView(
                                                    imagePath: ImageConstant
                                                        .messageimage,
                                                    height: 15,
                                                  ),
                                                  // SizedBox(
                                                  //   width: 10,
                                                  // ),
                                                  Text(
                                                    "Consultancy Stage",
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        color: Colors.black,
                                                        fontFamily: "outfit",
                                                        fontSize: 14),
                                                  ),
                                                  // Spacer(),
                                                  // SizedBox(width: 10,),
                                                  GestureDetector(
                                                    onTap: () {
                                                      // setState(() {
                                                      //   if (imagee?.contains(
                                                      //           index) ??
                                                      //       false) {
                                                      //     imagee?.remove(index);
                                                      //   } else {
                                                      //     imagee?.add(index);
                                                      //   }
                                                      // });
                                                    },
                                                    child:
                                                        (imagee?.contains(
                                                                    index) ??
                                                                false)
                                                            ? Container(
                                                                width: 66,
                                                                height: 19,
                                                                decoration:
                                                                    ShapeDecoration(
                                                                  shape:
                                                                      RoundedRectangleBorder(
                                                                    side: BorderSide(
                                                                        width:
                                                                            0.50,
                                                                        color: Color(
                                                                            0xFF9B9B9B)),
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            49.46),
                                                                  ),
                                                                ),
                                                                child: Center(
                                                                    child: Text(
                                                                  "Start",
                                                                  style: TextStyle(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w400,
                                                                      color: Colors
                                                                          .black,
                                                                      fontFamily:
                                                                          "outfit",
                                                                      fontSize:
                                                                          13),
                                                                )),
                                                                //---------------------------------------
                                                              )
                                                            : Container(
                                                                width: 66,
                                                                height: 19,
                                                                decoration:
                                                                    ShapeDecoration(
                                                                  shape:
                                                                      RoundedRectangleBorder(
                                                                    side: BorderSide(
                                                                        width:
                                                                            0.50,
                                                                        color: Color(
                                                                            0xFFED1C25)),
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            49.46),
                                                                  ),
                                                                ),
                                                                child: Center(
                                                                    child: Text(
                                                                  "Start",
                                                                  style: TextStyle(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w400,
                                                                      color: Color(
                                                                          0XFFED1C25),
                                                                      fontFamily:
                                                                          "outfit",
                                                                      fontSize:
                                                                          13),
                                                                )),
                                                              ),
                                                    //------------------------------------------
                                                  ),
                                                  // SizedBox(
                                                  //   width: 10,
                                                  // ),
                                                  GestureDetector(
                                                    onTap: () {
                                                      // setState(() {
                                                      //   if (closee?.contains(
                                                      //           index) ??
                                                      //       false) {
                                                      //     closee?.remove(index);
                                                      //   } else {
                                                      //     closee?.add(index);
                                                      //   }
                                                      // });
                                                    },
                                                    child:
                                                        (closee?.contains(
                                                                    index) ??
                                                                false)
                                                            ? Container(
                                                                width: 66,
                                                                height: 19,
                                                                decoration:
                                                                    ShapeDecoration(
                                                                  shape:
                                                                      RoundedRectangleBorder(
                                                                    side: BorderSide(
                                                                        width:
                                                                            0.50,
                                                                        color: Color(
                                                                            0xFF9B9B9B)),
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            49.46),
                                                                  ),
                                                                ),
                                                                child: Center(
                                                                    child: Text(
                                                                  "Close",
                                                                  style: TextStyle(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w400,
                                                                      color: Colors
                                                                          .black,
                                                                      fontFamily:
                                                                          "outfit",
                                                                      fontSize:
                                                                          13),
                                                                )),
                                                                //---------------------------------------
                                                              )
                                                            : Container(
                                                                width: 66,
                                                                height: 19,
                                                                decoration:
                                                                    ShapeDecoration(
                                                                  shape:
                                                                      RoundedRectangleBorder(
                                                                    side: BorderSide(
                                                                        width:
                                                                            0.50,
                                                                        color: Color(
                                                                            0xFFED1C25)),
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            49.46),
                                                                  ),
                                                                ),
                                                                child: Center(
                                                                    child: Text(
                                                                  "Close",
                                                                  style: TextStyle(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w400,
                                                                      color: Color(
                                                                          0XFFED1C25),
                                                                      fontFamily:
                                                                          "outfit",
                                                                      fontSize:
                                                                          13),
                                                                )),
                                                              ),
                                                    //------------------------------------------
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),

                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 8.0),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceAround,
                                                children: [
                                                  CustomImageView(
                                                    imagePath:
                                                        ImageConstant.editimage,
                                                    height: 15,
                                                  ),
                                                  // SizedBox(
                                                  //   width: 10,
                                                  // ),
                                                  Text(
                                                    "Designing Stage",
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        color: Colors.black,
                                                        fontFamily: "outfit",
                                                        fontSize: 14),
                                                  ),
                                                  // Spacer(),
                                                  GestureDetector(
                                                    onTap: () {
                                                      // setState(() {
                                                      //   if (image?.contains(
                                                      //           index) ??
                                                      //       false) {
                                                      //     image?.remove(index);
                                                      //   } else {
                                                      //     image?.add(index);
                                                      //   }
                                                      // });
                                                    },
                                                    child:
                                                        (image?.contains(
                                                                    index) ??
                                                                false)
                                                            ? Container(
                                                                width: 66,
                                                                height: 19,
                                                                decoration:
                                                                    ShapeDecoration(
                                                                  shape:
                                                                      RoundedRectangleBorder(
                                                                    side: BorderSide(
                                                                        width:
                                                                            0.50,
                                                                        color: Color(
                                                                            0xFF9B9B9B)),
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            49.46),
                                                                  ),
                                                                ),
                                                                child: Center(
                                                                    child: Text(
                                                                  "Start",
                                                                  style: TextStyle(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w400,
                                                                      color: Colors
                                                                          .black,
                                                                      fontFamily:
                                                                          "outfit",
                                                                      fontSize:
                                                                          13),
                                                                )),
                                                                //---------------------------------------
                                                              )
                                                            : Container(
                                                                width: 66,
                                                                height: 19,
                                                                decoration:
                                                                    ShapeDecoration(
                                                                  shape:
                                                                      RoundedRectangleBorder(
                                                                    side: BorderSide(
                                                                        width:
                                                                            0.50,
                                                                        color: Color(
                                                                            0xFFED1C25)),
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            49.46),
                                                                  ),
                                                                ),
                                                                child: Center(
                                                                    child: Text(
                                                                  "Start",
                                                                  style: TextStyle(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w400,
                                                                      color: Color(
                                                                          0XFFED1C25),
                                                                      fontFamily:
                                                                          "outfit",
                                                                      fontSize:
                                                                          13),
                                                                )),
                                                              ),
                                                    //------------------------------------------
                                                  ),
                                                  // SizedBox(
                                                  //   width: 10,
                                                  // ),
                                                  GestureDetector(
                                                    onTap: () {
                                                      // setState(() {
                                                      //   if (close?.contains(
                                                      //           index) ??
                                                      //       false) {
                                                      //     close?.remove(index);
                                                      //   } else {
                                                      //     close?.add(index);
                                                      //   }
                                                      // });
                                                    },
                                                    child:
                                                        (close?.contains(
                                                                    index) ??
                                                                false)
                                                            ? Container(
                                                                width: 66,
                                                                height: 19,
                                                                decoration:
                                                                    ShapeDecoration(
                                                                  shape:
                                                                      RoundedRectangleBorder(
                                                                    side: BorderSide(
                                                                        width:
                                                                            0.50,
                                                                        color: Color(
                                                                            0xFF9B9B9B)),
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            49.46),
                                                                  ),
                                                                ),
                                                                child: Center(
                                                                    child: Text(
                                                                  "Close",
                                                                  style: TextStyle(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w400,
                                                                      color: Colors
                                                                          .black,
                                                                      fontFamily:
                                                                          "outfit",
                                                                      fontSize:
                                                                          13),
                                                                )),
                                                                //---------------------------------------
                                                              )
                                                            : Container(
                                                                width: 66,
                                                                height: 19,
                                                                decoration:
                                                                    ShapeDecoration(
                                                                  shape:
                                                                      RoundedRectangleBorder(
                                                                    side: BorderSide(
                                                                        width:
                                                                            0.50,
                                                                        color: Color(
                                                                            0xFFED1C25)),
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            49.46),
                                                                  ),
                                                                ),
                                                                child: Center(
                                                                    child: Text(
                                                                  "Close",
                                                                  style: TextStyle(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w400,
                                                                      color: Color(
                                                                          0XFFED1C25),
                                                                      fontFamily:
                                                                          "outfit",
                                                                      fontSize:
                                                                          13),
                                                                )),
                                                              ),
                                                    //------------------------------------------
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              Navigator.push(context,
                                                  MaterialPageRoute(
                                                builder: (context) {
                                                  return RoomMembersScreen(
                                                      roomname:
                                                          "${PriveateRoomData?.object?[index].roomQuestion}",
                                                      RoomOwner: PriveateRoomData
                                                                  ?.object?[
                                                                      index]
                                                                  .createdBy ==
                                                              userId
                                                          ? true
                                                          : false,
                                                      CreateUserID: userId,
                                                      roomdescription:
                                                          "${PriveateRoomData?.object?[index].description}",
                                                      room_Id:
                                                          '${PriveateRoomData?.object?[index].uid.toString()}');
                                                },
                                              )).then((value) => method());
                                            },
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 10.0, right: 10),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  PriveateRoomData
                                                              ?.object?[index]
                                                              .usersList
                                                              ?.length ==
                                                          1
                                                      ? Container(
                                                          width: 99,
                                                          height: 27.88,
                                                          child: Stack(
                                                            children: [
                                                              Positioned(
                                                                left: 0,
                                                                top: 0,
                                                                child: Container(
                                                                    width: 26.88,
                                                                    height: 26.87,
                                                                    decoration: BoxDecoration(color: ColorConstant.primary_color, shape: BoxShape.circle),
                                                                    child: PriveateRoomData?.object?[index].usersList?[0].userProfilePic?.isNotEmpty ?? false
                                                                        ? CustomImageView(
                                                                            url:
                                                                                "${PriveateRoomData?.object?[index].usersList?[0].userProfilePic}",
                                                                            height:
                                                                                20,
                                                                            radius:
                                                                                BorderRadius.circular(20),
                                                                            width:
                                                                                20,
                                                                            fit:
                                                                                BoxFit.fill,
                                                                          )
                                                                        : CustomImageView(
                                                                            imagePath:
                                                                                ImageConstant.tomcruse,
                                                                            height:
                                                                                20,
                                                                            radius:
                                                                                BorderRadius.circular(20),
                                                                            width:
                                                                                20,
                                                                            fit:
                                                                                BoxFit.fill,
                                                                          )
                                                                    /* Image.network(
                                                                      "",
                                                                      
                                                                      size: 20,
                                                                      color: Colors
                                                                          .white,
                                                                    ) */
                                                                    ),
                                                              ),
                                                            ],
                                                          ),
                                                        )
                                                      : PriveateRoomData
                                                                  ?.object?[
                                                                      index]
                                                                  .usersList
                                                                  ?.length ==
                                                              2
                                                          ? Container(
                                                              width: 99,
                                                              height: 27.88,
                                                              child: Stack(
                                                                children: [
                                                                  Positioned(
                                                                    left: 0,
                                                                    top: 0,
                                                                    child: Container(
                                                                        width: 26.88,
                                                                        height: 26.87,
                                                                        decoration: BoxDecoration(color: ColorConstant.primary_color, shape: BoxShape.circle),
                                                                        child: PriveateRoomData?.object?[index].usersList?[0].userProfilePic?.isNotEmpty ?? false
                                                                            ? CustomImageView(
                                                                                url: "${PriveateRoomData?.object?[index].usersList?[0].userProfilePic}",
                                                                                height: 20,
                                                                                radius: BorderRadius.circular(20),
                                                                                width: 20,
                                                                                fit: BoxFit.fill,
                                                                              )
                                                                            : CustomImageView(
                                                                                imagePath: ImageConstant.tomcruse,
                                                                                height: 20,
                                                                                radius: BorderRadius.circular(20),
                                                                                width: 20,
                                                                                fit: BoxFit.fill,
                                                                              )),
                                                                  ),
                                                                  Positioned(
                                                                    left: 22.56,
                                                                    top: 0,
                                                                    child: Container(
                                                                        width: 26.88,
                                                                        height: 26.87,
                                                                        decoration: BoxDecoration(color: ColorConstant.primary_color, shape: BoxShape.circle),
                                                                        child: PriveateRoomData?.object?[index].usersList?[1].userProfilePic?.isNotEmpty ?? false
                                                                            ? CustomImageView(
                                                                                url: "${PriveateRoomData?.object?[index].usersList?[1].userProfilePic}",
                                                                                height: 20,
                                                                                radius: BorderRadius.circular(20),
                                                                                width: 20,
                                                                                fit: BoxFit.fill,
                                                                              )
                                                                            : CustomImageView(
                                                                                imagePath: ImageConstant.tomcruse,
                                                                                height: 20,
                                                                                radius: BorderRadius.circular(20),
                                                                                width: 20,
                                                                                fit: BoxFit.fill,
                                                                              )),
                                                                  ),
                                                                ],
                                                              ),
                                                            )
                                                          : PriveateRoomData
                                                                      ?.object?[
                                                                          index]
                                                                      .usersList
                                                                      ?.length ==
                                                                  3
                                                              ? Container(
                                                                  width: 99,
                                                                  height: 27.88,
                                                                  child: Stack(
                                                                    children: [
                                                                      Positioned(
                                                                        left: 0,
                                                                        top: 0,
                                                                        child: Container(
                                                                            width: 26.88,
                                                                            height: 26.87,
                                                                            decoration: BoxDecoration(color: ColorConstant.primary_color, shape: BoxShape.circle),
                                                                            child: PriveateRoomData?.object?[index].usersList?[0].userProfilePic?.isNotEmpty ?? false
                                                                                ? CustomImageView(
                                                                                    url: "${PriveateRoomData?.object?[index].usersList?[0].userProfilePic}",
                                                                                    height: 20,
                                                                                    radius: BorderRadius.circular(20),
                                                                                    width: 20,
                                                                                    fit: BoxFit.fill,
                                                                                  )
                                                                                : CustomImageView(
                                                                                    imagePath: ImageConstant.tomcruse,
                                                                                    height: 20,
                                                                                    radius: BorderRadius.circular(20),
                                                                                    width: 20,
                                                                                    fit: BoxFit.fill,
                                                                                  )),
                                                                      ),
                                                                      Positioned(
                                                                        left:
                                                                            22.56,
                                                                        top: 0,
                                                                        child: Container(
                                                                            width: 26.88,
                                                                            height: 26.87,
                                                                            decoration: BoxDecoration(color: ColorConstant.primary_color, shape: BoxShape.circle),
                                                                            child: PriveateRoomData?.object?[index].usersList?[1].userProfilePic?.isNotEmpty ?? false
                                                                                ? CustomImageView(
                                                                                    url: "${PriveateRoomData?.object?[index].usersList?[1].userProfilePic}",
                                                                                    height: 20,
                                                                                    radius: BorderRadius.circular(20),
                                                                                    width: 20,
                                                                                    fit: BoxFit.fill,
                                                                                  )
                                                                                : CustomImageView(
                                                                                    imagePath: ImageConstant.tomcruse,
                                                                                    height: 20,
                                                                                    radius: BorderRadius.circular(20),
                                                                                    width: 20,
                                                                                    fit: BoxFit.fill,
                                                                                  )),
                                                                      ),
                                                                      Positioned(
                                                                        left:
                                                                            45.12,
                                                                        top: 0,
                                                                        child: Container(
                                                                            width: 26.88,
                                                                            height: 26.87,
                                                                            decoration: BoxDecoration(color: ColorConstant.primary_color, shape: BoxShape.circle),
                                                                            child: PriveateRoomData?.object?[index].usersList?[2].userProfilePic?.isNotEmpty ?? false
                                                                                ? CustomImageView(
                                                                                    url: "${PriveateRoomData?.object?[index].usersList?[2].userProfilePic}",
                                                                                    height: 20,
                                                                                    radius: BorderRadius.circular(20),
                                                                                    width: 20,
                                                                                    fit: BoxFit.fill,
                                                                                  )
                                                                                : CustomImageView(
                                                                                    imagePath: ImageConstant.tomcruse,
                                                                                    height: 20,
                                                                                    radius: BorderRadius.circular(20),
                                                                                    width: 20,
                                                                                    fit: BoxFit.fill,
                                                                                  )),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                )
                                                              : Container(
                                                                  width: 99,
                                                                  height: 27.88,
                                                                  child: Stack(
                                                                    children: [
                                                                      Positioned(
                                                                        left: 0,
                                                                        top: 0,
                                                                        child: Container(
                                                                            width: 26.88,
                                                                            height: 26.87,
                                                                            decoration: BoxDecoration(color: ColorConstant.primary_color, shape: BoxShape.circle),
                                                                            child: PriveateRoomData?.object?[index].usersList?[0].userProfilePic?.isNotEmpty ?? false
                                                                                ? CustomImageView(
                                                                                    url: "${PriveateRoomData?.object?[index].usersList?[0].userProfilePic}",
                                                                                    height: 20,
                                                                                    radius: BorderRadius.circular(20),
                                                                                    width: 20,
                                                                                    fit: BoxFit.fill,
                                                                                  )
                                                                                : CustomImageView(
                                                                                    imagePath: ImageConstant.tomcruse,
                                                                                    height: 20,
                                                                                    radius: BorderRadius.circular(20),
                                                                                    width: 20,
                                                                                    fit: BoxFit.fill,
                                                                                  )),
                                                                      ),
                                                                      Positioned(
                                                                        left:
                                                                            22.56,
                                                                        top: 0,
                                                                        child: Container(
                                                                            width: 26.88,
                                                                            height: 26.87,
                                                                            decoration: BoxDecoration(color: ColorConstant.primary_color, shape: BoxShape.circle),
                                                                            child: PriveateRoomData?.object?[index].usersList?[1].userProfilePic?.isNotEmpty ?? false
                                                                                ? CustomImageView(
                                                                                    url: "${PriveateRoomData?.object?[index].usersList?[1].userProfilePic}",
                                                                                    height: 20,
                                                                                    radius: BorderRadius.circular(20),
                                                                                    width: 20,
                                                                                    fit: BoxFit.fill,
                                                                                  )
                                                                                : CustomImageView(
                                                                                    imagePath: ImageConstant.tomcruse,
                                                                                    height: 20,
                                                                                    radius: BorderRadius.circular(20),
                                                                                    width: 20,
                                                                                    fit: BoxFit.fill,
                                                                                  )),
                                                                      ),
                                                                      Positioned(
                                                                        left:
                                                                            45.12,
                                                                        top: 0,
                                                                        child: Container(
                                                                            width: 26.88,
                                                                            height: 26.87,
                                                                            decoration: BoxDecoration(color: ColorConstant.primary_color, shape: BoxShape.circle),
                                                                            child: PriveateRoomData?.object?[index].usersList?[2].userProfilePic?.isNotEmpty ?? false
                                                                                ? CustomImageView(
                                                                                    url: "${PriveateRoomData?.object?[index].usersList?[2].userProfilePic}",
                                                                                    height: 20,
                                                                                    radius: BorderRadius.circular(20),
                                                                                    width: 20,
                                                                                    fit: BoxFit.fill,
                                                                                  )
                                                                                : CustomImageView(
                                                                                    imagePath: ImageConstant.tomcruse,
                                                                                    height: 20,
                                                                                    radius: BorderRadius.circular(20),
                                                                                    width: 20,
                                                                                    fit: BoxFit.fill,
                                                                                  )),
                                                                      ),
                                                                      Positioned(
                                                                        left:
                                                                            78,
                                                                        top: 7,
                                                                        child:
                                                                            SizedBox(
                                                                          width:
                                                                              21,
                                                                          height:
                                                                              16,
                                                                          child:
                                                                              Text(
                                                                            "+${(PriveateRoomData?.object?[index].usersList?.length ?? 0) - 3}",
                                                                            style:
                                                                                TextStyle(
                                                                              color: Color(0xFF2A2A2A),
                                                                              fontSize: 14,
                                                                              fontFamily: 'Outfit',
                                                                              fontWeight: FontWeight.w400,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                  User_Mood == "EXPERT"
                                                      ? SizedBox()
                                                      : checkuserdata ==
                                                              "PARTIALLY_REGISTERED"
                                                          ? SizedBox()
                                                          : GestureDetector(
                                                              onTap: () {
                                                                print("Room invited Link --> " +
                                                                    "${PriveateRoomData?.object?[index].roomLink}");

                                                                showDialog(
                                                                  context:
                                                                      context,
                                                                  builder:
                                                                      (context) =>
                                                                          ScaffoldMessenger(
                                                                    child:
                                                                        Builder(
                                                                      builder:
                                                                          (context) =>
                                                                              Scaffold(
                                                                        backgroundColor:
                                                                            Colors.transparent,
                                                                        body:
                                                                            InviteDilogScreen(
                                                                          Room_UUID:
                                                                              "${PriveateRoomData?.object?[index].uid}",
                                                                          Room_Link: PriveateRoomData
                                                                              ?.object?[index]
                                                                              .roomLink,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                );
                                                              },
                                                              child: PriveateRoomData
                                                                          ?.object?[
                                                                              index]
                                                                          .createdBy ==
                                                                      userId
                                                                  ? Container(
                                                                      width:
                                                                          140,
                                                                      height:
                                                                          22.51,
                                                                      decoration:
                                                                          ShapeDecoration(
                                                                        color: Color(
                                                                            0xFFFFD9DA),
                                                                        shape:
                                                                            RoundedRectangleBorder(
                                                                          side:
                                                                              BorderSide(
                                                                            width:
                                                                                1,
                                                                            color:
                                                                                Color(0xFFED1C25),
                                                                          ),
                                                                          borderRadius:
                                                                              BorderRadius.circular(50),
                                                                        ),
                                                                      ),
                                                                      child: Center(
                                                                          child: Text(
                                                                        "Invite User",
                                                                        style: TextStyle(
                                                                            fontWeight: FontWeight
                                                                                .w400,
                                                                            color: Color(
                                                                                0xFFED1C25),
                                                                            fontFamily:
                                                                                "outfit",
                                                                            fontSize:
                                                                                13),
                                                                      )),
                                                                    )
                                                                  : SizedBox(),
                                                            )
                                                ],
                                              ),
                                            ),
                                          ),

                                          // PriveateRoomData?.object?[index].usersList?[0]
                                          // PriveateRoomData?.object?[index].usersList?.forEach((element) {

                                          // })
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(top: 2),
                                            child: Container(
                                              height: 0.5,
                                              color: Colors.grey,
                                            ),
                                          ),

                                          PriveateRoomData?.object?[index]
                                                      .expertUserProfile !=
                                                  null
                                              ? Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Row(
                                                    children: [
                                                      CustomImageView(
                                                        url:
                                                            "${PriveateRoomData?.object?[index].expertUserProfile?.userProfilePic}",
                                                        height: 30,
                                                        radius: BorderRadius
                                                            .circular(15),
                                                        width: 30,
                                                        fit: BoxFit.fill,
                                                      ),
                                                      Text(
                                                          " ${PriveateRoomData?.object?[index].expertUserProfile?.userName}"),
                                                      Spacer(),
                                                      Container(
                                                        width: 80,
                                                        height: 20,
                                                        decoration:
                                                            ShapeDecoration(
                                                          color:
                                                              Color(0xFFED1C25),
                                                          shape:
                                                              RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        49.46),
                                                          ),
                                                        ),
                                                        child: Center(
                                                            child: Text(
                                                          "Expert",
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                              color:
                                                                  Colors.white,
                                                              fontFamily:
                                                                  "outfit",
                                                              fontSize: 10),
                                                        )),
                                                      )
                                                    ],
                                                  ),
                                                )
                                              : SizedBox(),

                                          // index == 1 || index == 2 || index == 3
                                          //     ? Divider(color: Colors.grey)
                                          //     : SizedBox(),

                                          // index == 1 || index == 3
                                          //     ? Padding(
                                          //         padding:
                                          //             const EdgeInsets.all(8.0),
                                          //         child: Row(
                                          //           children: [
                                          //             CustomImageView(
                                          //               imagePath: ImageConstant
                                          //                   .workimage,
                                          //               height: 30,
                                          //             ),
                                          //             Text("Expert 1"),
                                          //             Spacer(),
                                          //             Container(
                                          //               width: 80,
                                          //               height: 20,
                                          //               decoration:
                                          //                   ShapeDecoration(
                                          //                 color:
                                          //                     Color(0xFFED1C25),
                                          //                 shape:
                                          //                     RoundedRectangleBorder(
                                          //                   borderRadius:
                                          //                       BorderRadius
                                          //                           .circular(
                                          //                               49.46),
                                          //                 ),
                                          //               ),
                                          //               child: Center(
                                          //                   child: Text(
                                          //                 "Switch Expert",
                                          //                 style: TextStyle(
                                          //                     fontWeight:
                                          //                         FontWeight.w400,
                                          //                     color: Colors.white,
                                          //                     fontFamily:
                                          //                         "outfit",
                                          //                     fontSize: 10),
                                          //               )),
                                          //             )
                                          //           ],
                                          //         ),
                                          //       )
                                          //     : SizedBox(),

                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Expanded(
                                                flex: 2,
                                                child: GestureDetector(
                                                  onTap: () {
                                                    Navigator.push(context,
                                                        MaterialPageRoute(
                                                            builder: (context) {
                                                      return ViewCommentScreen(
                                                        Room_ID:
                                                            "${PriveateRoomData?.object?[index].uid ?? ""}",
                                                        Title:
                                                            "${PriveateRoomData?.object?[index].roomQuestion ?? ""}",
                                                      );
                                                    }));
                                                  },
                                                  child: Container(
                                                    height: 40,
                                                    width: _width / 2.48,
                                                    decoration: BoxDecoration(
                                                        // color: Color(0XFF9B9B9B),
                                                        color:
                                                            Color(0xFFED1C25),
                                                        borderRadius:
                                                            BorderRadius.only(
                                                                bottomLeft: Radius
                                                                    .circular(
                                                                        4))),
                                                    child: Center(
                                                      child: Text(
                                                        "Chat",
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            color: Colors.white,
                                                            fontFamily:
                                                                "outfit",
                                                            fontSize: 15),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                width: PriveateRoomData
                                                            ?.object?[index]
                                                            .expertUserProfile ==
                                                        null
                                                    ? 1
                                                    : 0,
                                              ),
                                              PriveateRoomData?.object?[index]
                                                          .expertUserProfile ==
                                                      null
                                                  ? User_Mood == "EXPERT"
                                                      ? SizedBox()
                                                      : checkuserdata ==
                                                              "PARTIALLY_REGISTERED"
                                                          ? SizedBox()
                                                          : Expanded(
                                                              flex: 2,
                                                              child:
                                                                  GestureDetector(
                                                                onTap: () {
                                                                  Navigator.push(
                                                                      context,
                                                                      MaterialPageRoute(
                                                                        builder:
                                                                            (context) =>
                                                                                ExpertsScreen(RoomUUID: PriveateRoomData?.object?[index].uid),
                                                                        // ExpertsScreen(RoomUUID:  PriveateRoomData?.object?[index].uid),
                                                                      ));
                                                                },
                                                                child:
                                                                    Container(
                                                                  height: 40,
                                                                  width:
                                                                      _width /
                                                                          2.48,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    borderRadius:
                                                                        BorderRadius
                                                                            .only(
                                                                      bottomRight:
                                                                          Radius.circular(
                                                                              4),
                                                                    ),
                                                                    color: Color(
                                                                        0XFF9B9B9B),
                                                                  ),
                                                                  child: Center(
                                                                    child: Text(
                                                                      "Select Expert",
                                                                      style: TextStyle(
                                                                          fontWeight: FontWeight
                                                                              .w400,
                                                                          color: Colors
                                                                              .white,
                                                                          fontFamily:
                                                                              "outfit",
                                                                          fontSize:
                                                                              15),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            )
                                                  : SizedBox(),
                                            ],
                                          ),

                                          // Container(
                                          //   color: Colors.amber,
                                          //   child: Stack(
                                          //     children: [
                                          //       Row(
                                          //         children: [
                                          //           CustomImageView(
                                          //             imagePath: ImageConstant.expertone,
                                          //             height: 30,
                                          //           ),
                                          //           CustomImageView(
                                          //             imagePath: ImageConstant.experttwo,
                                          //             height: 30,
                                          //           ),
                                          //           CustomImageView(
                                          //             imagePath: ImageConstant.expertthree,
                                          //             height: 30,
                                          //           ),
                                          //         ],
                                          //       ),
                                          //     ],
                                          //   ),
                                          // ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ]),
                        ),
                        checkuserdata == "PARTIALLY_REGISTERED"
                            ? SizedBox()
                            : User_Mood == "EXPERT"
                                ? SizedBox()
                                : Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: GestureDetector(
                                      onTap: () {
                                        /* showDialog(
                              context: context,
                              builder: (_) => BlocProvider<CreateRoomCubit>(
                                  create: (context) => CreateRoomCubit(),
                                  child: CreateRoomScreen()),
                            ); */
                                        CreatRoom(_height, _width);
                                      },
                                      child: CustomImageView(
                                        imagePath: ImageConstant.addroomimage,
                                        height: 55,
                                        alignment: Alignment.bottomRight,
                                      ),
                                    ),
                                  ),
                      ],
                    )
                  : Stack(
                      children: [
                        Center(
                          child: Container(
                            height: _height / 2.5,

                            child: CustomImageView(
                              imagePath: checkuserdata == "PARTIALLY_REGISTERED"
                                  ? ImageConstant.CreateForum
                                  : checkuserdata == "PENDING"
                                      ? ImageConstant.InPending
                                      : checkuserdata == "APPROVED"
                                          ? ImageConstant.noRoom
                                          : ImageConstant.Rejected,
                            ),

                            // color: Colors.red,
                          ),
                        ),
                        // checkuserdata == false
                        // ? SizedBox()
                        // :
                        User_Mood == "EXPERT"
                            ? SizedBox()
                            : Padding(
                                padding: const EdgeInsets.all(18.0),
                                child: GestureDetector(
                                  onTap: () {
                                    /*  showDialog(
                              context: context,
                              builder: (_) => BlocProvider<CreateRoomCubit>(
                                  create: (context) => CreateRoomCubit(),
                                  child: CreateRoomScreen()),
                            ); */

                                    //  CreatRoom(_height, _width)
                                    //                                     : CreateForum()

                                    checkuserdata == "PARTIALLY_REGISTERED"
                                        ? CreateForum()
                                        : checkuserdata == "PENDING"
                                            ? showAlert()
                                            : checkuserdata == "APPROVED"
                                                ? CreatRoom(_height, _width)
                                                : showAlert1();
                                  },
                                  child: CustomImageView(
                                    imagePath: ImageConstant.addroomimage,
                                    height: 55,
                                    alignment: Alignment.bottomRight,
                                  ),
                                ),
                              ),
                      ],
                    );
            }
            return Center(
              child: Container(
                margin: EdgeInsets.only(bottom: 100),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.asset(ImageConstant.loader,
                      fit: BoxFit.cover, height: 100.0, width: 100),
                ),
              ),
            );
          })),
    );
  }

  showAlert() {
    SnackBar snackBar = SnackBar(
      content: Text("Your Account in Process"),
      backgroundColor: ColorConstant.primary_color,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  showAlert1() {
    SnackBar snackBar = SnackBar(
      content: Text("Your Account REJECTED"),
      backgroundColor: ColorConstant.primary_color,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  CreateForum() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var UserLogin_ID = prefs.getString(PreferencesKey.loginUserID);

    if (UserLogin_ID == null) {
      print("user login Mood");
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => RegisterCreateAccountScreen()));
    } else {
      print('no login');
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return CreateForamScreen();
      }));
    }
  }

  CreatRoom(_height, _width) {
    TextEditingController _roomName = TextEditingController();
    TextEditingController _DescriptionText = TextEditingController();
    print('createroom');
    showDialog(
      context: context,
      builder: (context) => Padding(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Center(
          child: Material(
            color: Color.fromARGB(0, 255, 255, 255),
            child: BlocConsumer<CreateRoomCubit, CreateRoomState>(
              listener: (context, state) {
                if (state is CreateRoomLoadingState) {
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
                if (state is CreateRoomLoadedState) {
                  print('this is the data get');
                  method();
                  _roomName.clear();
                  _DescriptionText.clear();

                  SnackBar snackBar = SnackBar(
                    content: Text(state.PublicRoomData.message ?? ""),
                    backgroundColor: ColorConstant.primary_color,
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  SubmitOneTime = false;
                  Navigator.pop(context);
                }
                if (state is CreateRoomErrorState) {
                  print('CreateRoomErrorState');
                  SnackBar snackBar = SnackBar(
                    content: Text(state.error.message),
                    backgroundColor: ColorConstant.primary_color,
                  );
                  SubmitOneTime = false;
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                }
              },
              builder: (context, state) {
                return Container(
                  height: _height / 1.8,
                  width: _width / 1.17,
                  decoration: ShapeDecoration(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                  ),
                  child: Column(
                    children: [
                      Center(
                        child: Container(
                          height: 380,
                          width: _width / 1.2,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 8.0, left: 20),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Create Room",
                                      style: TextStyle(
                                        fontFamily: 'outfit',
                                        fontSize: 20,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.pop(context);
                                        SubmitOneTime = false;
                                      },
                                      child: CustomImageView(
                                        imagePath: ImageConstant.closeimage,
                                        height: 40,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Divider(
                                color: Colors.grey,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                  left: 5.0,
                                ),
                                child: Text(
                                  "Room Name",
                                  style: TextStyle(
                                    fontFamily: 'outfit',
                                    fontSize: 15,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                              Center(
                                child: Padding(
                                  padding: EdgeInsets.only(
                                    top: 10.0,
                                    left: 10,
                                    right: 20,
                                  ),
                                  child: TextField(
                                    // maxLength: 50,
                                    controller: _roomName,
                                    cursorColor: Colors.grey,
                                    inputFormatters: [
                                      LengthLimitingTextInputFormatter(50)
                                    ],
                                    decoration: InputDecoration(
                                      hintText: 'Room Name',
                                      // counterText: '',
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          borderSide: BorderSide(
                                              color: Color(0xffDBDBDB))),
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 15.0, top: 20, bottom: 10),
                                child: Text(
                                  "Description",
                                  style: TextStyle(
                                    fontFamily: 'outfit',
                                    fontSize: 15,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                              Center(
                                child: Container(
                                  height: 80,
                                  width: _width / 1.3,
                                  decoration: BoxDecoration(
                                      color: Colors.transparent,
                                      border: Border.all(
                                          color: Colors.grey.shade300),
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Padding(
                                    padding:
                                        EdgeInsets.only(top: 0.0, left: 10),
                                    child: TextField(
                                      // maxLength: 255,
                                      controller: _DescriptionText,
                                      maxLines: 5,
                                      cursorColor: Colors.grey,
                                      // maxLength: 500,
                                      inputFormatters: [
                                        LengthLimitingTextInputFormatter(500),
                                      ],
                                      decoration: InputDecoration(
                                        // counterText: "",
                                        hintText:
                                            'Describe your problem or topic here..',
                                        border: InputBorder.none,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 30,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  GestureDetector(
                                    onTap: () => Navigator.pop(context),
                                    child: Container(
                                      height: 43,
                                      width: _width / 3,
                                      decoration: BoxDecoration(
                                          color: Colors.transparent,
                                          border: Border.all(
                                              color: Colors.grey.shade400),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: Center(
                                          child: Text(
                                        "Cancel",
                                        style: TextStyle(
                                          fontFamily: 'outfit',
                                          fontSize: 15,
                                          color: Color(0xFFED1C25),
                                          fontWeight: FontWeight.w400,
                                        ),
                                      )),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      if (_roomName.text.isEmpty) {
                                        show_Icon_Flushbar(context,
                                            msg: "Please Enter Room Name");
                                      } else if (_roomName.text
                                              .trim()
                                              .isEmpty ||
                                          _roomName.text.trim() == '') {
                                        show_Icon_Flushbar(context,
                                            msg:
                                                'Room Name can\'t be just blank spaces');
                                      } else if (_DescriptionText
                                              .text.isEmpty ||
                                          _DescriptionText.text == '') {
                                        show_Icon_Flushbar(context,
                                            msg: 'Please Enter Description');
                                      } else if (_DescriptionText.text
                                              .trim()
                                              .isEmpty ||
                                          _DescriptionText.text.trim() == '') {
                                        show_Icon_Flushbar(context,
                                            msg:
                                                'Description can\'t be just blank spaces');
                                      } else {
                                        var params = {
                                          "roomQuestion": _roomName.text,
                                          "description": _DescriptionText.text,
                                          "roomType": "PRIVTAE"
                                        };

                                        print(params);

                                        if (SubmitOneTime == false) {
                                          SubmitOneTime = true;
                                          BlocProvider.of<CreateRoomCubit>(
                                                  context)
                                              .CreateRoomAPI(params, context);
                                        }
                                      }
                                      // if (roomName.text == null ||
                                      //     roomName.text.isEmpty) {
                                      //   SnackBar snackBar = SnackBar(
                                      //     content: Text('Please Enter Room Name'),
                                      //     backgroundColor:
                                      //         ColorConstant.primary_color,
                                      //   );
                                      //   ScaffoldMessenger.of(context)
                                      //       .showSnackBar(snackBar);
                                      // }
                                      // if (DescriptionText.text == null ||
                                      //     DescriptionText.text.isEmpty) {
                                      //   SnackBar snackBar = SnackBar(
                                      //     content:
                                      //         Text('Please Enter Description'),
                                      //     backgroundColor:
                                      //         ColorConstant.primary_color,
                                      //   );
                                      //   ScaffoldMessenger.of(context)
                                      //       .showSnackBar(snackBar);
                                      // }
                                    },
                                    child: Container(
                                      height: 43,
                                      width: _width / 3,
                                      decoration: BoxDecoration(
                                          color: Color(0xFFED1C25),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: Center(
                                          child: Text(
                                        "Create",
                                        style: TextStyle(
                                          fontFamily: 'outfit',
                                          fontSize: 15,
                                          color: Colors.white,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      )),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );

    // showDialog(
    //     context: context,
    //     builder: (context) {
    //       return
    //     });
  }

  void show_Icon_Flushbar(BuildContext context, {String? msg}) {
    Flushbar(
        backgroundColor: ColorConstant.primary_color,
        animationDuration: Duration(milliseconds: 500),
        duration: Duration(seconds: 3),
        message: msg)
      ..show(context);
  }
  // editProfile(String? roomId) {
  //   print('roomId -$roomId');
  //   showDialog(
  //     context: context,
  //     builder: (context) => ScaffoldMessenger(
  //       child: Builder(
  //         builder: (context) => Scaffold(
  //           backgroundColor: Colors.transparent,
  //           body: MultiBlocProvider(
  //             providers: [
  //               BlocProvider<EditroomCubit>(
  //                 create: (context) => EditroomCubit(),
  //               ),
  //             ],
  //             child: EditDilogScreen(
  //               uid: roomId,
  //             ),
  //           ),
  //         ),
  //       ),
  //     ),
  //   );
  // }
}
