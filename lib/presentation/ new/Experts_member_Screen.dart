// import 'package:pds/core/utils/size_utils.dart';
// ignore_for_file: must_be_immutable

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pds/API/Bloc/Fatch_all_members/fatch_all_members_cubit.dart';
import 'package:pds/API/Bloc/Fatch_all_members/fatch_all_members_state.dart';
import 'package:pds/API/Bloc/GetAllPrivateRoom_Bloc/GetAllPrivateRoom_cubit.dart';
import 'package:pds/API/Bloc/GetAllPrivateRoom_Bloc/GetAllPrivateRoom_state.dart';
import 'package:pds/API/Bloc/RateUs_Bloc/RateUs_cubit.dart';
import 'package:pds/API/Bloc/ViewDetails_Bloc/ViewDetails_cubit.dart';
import 'package:pds/API/Bloc/ViewDetails_Bloc/ViewDetails_state.dart';
import 'package:pds/API/Model/FatchAllMembers/fatchallmembers_model.dart';
import 'package:pds/core/utils/color_constant.dart';
import 'package:pds/core/utils/sharedPreferences.dart';
import 'package:pds/dialogs/assigh_adminn_dilog.dart';
import 'package:pds/dilogs/assigh_adminn_dilog..dart';
import 'package:pds/presentation/%20new/profileNew.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/utils/image_constant.dart';
import '../../theme/theme_helper.dart';
import '../../widgets/custom_image_view.dart';
import '../view_details_screen/view_details_screen.dart';

class ExpertMemberScreen extends StatefulWidget {
  String? userID;
  String? userProfile;
  String? fullName;
  String? roomname;
  String? roomdescription;

  ExpertMemberScreen({
    Key? key,
    this.userID,
    this.userProfile,
    this.fullName,
    this.roomname,
    this.roomdescription,
  }) : super(key: key);

  @override
  State<ExpertMemberScreen> createState() => _ExpertMemberScreenState();
}

class _ExpertMemberScreenState extends State<ExpertMemberScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    double _height = MediaQuery.of(context).size.height;
    return Scaffold(
        backgroundColor: theme.colorScheme.onPrimary,
        appBar: AppBar(
          leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
          ),
          centerTitle: true,
          elevation: 0,
          backgroundColor: theme.colorScheme.onPrimary,
          title: Text(
            "Experts Members",
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontFamily: "outfit",
                fontSize: 20),
          ),
        ),
        body: SingleChildScrollView(
            child: Column(
          children: [
            Center(
              child: Container(
                height: _height / 9,
                width: _width / 1.2,
                decoration: BoxDecoration(
                  color: Color(0xFFFFE7E7),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              height: 40,
                              width: _width / 1.85,
                              // color: Colors.amber,
                              child: Text(
                                "${widget.roomname}", maxLines: 2,
                                // "Room Name",
                                style: TextStyle(
                                    overflow: TextOverflow.ellipsis,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                    fontFamily: "outfit",
                                    fontSize: 15),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Container(
                          height: 40,
                          width: _width,
                          // color: Colors.amber,
                          child: Text(
                            "${widget.roomdescription}",
                            maxLines: 2,
                            style: TextStyle(
                                fontWeight: FontWeight.w400,
                                overflow: TextOverflow.ellipsis,
                                color: Colors.black,
                                fontFamily: "outfit",
                                fontSize: 13),
                          ),
                        ),
                      ),
                    ]),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 35, right: 35, top: 20),
              child: Container(
                height: _height / 12,
                width: _width / 1.2,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return ProfileScreen(
                                User_ID: "${widget.userID}", isFollowing: "");
                          }));
                        },
                        child: widget.userProfile != null
                            ? CustomImageView(
                                url: "${widget.userProfile}",
                                height: 50,
                                radius: BorderRadius.circular(25),
                                width: 50,
                                fit: BoxFit.fill,
                              )
                            : CustomImageView(
                                imagePath: ImageConstant.tomcruse,
                                height: 50,
                                radius: BorderRadius.circular(25),
                                width: 50,
                                fit: BoxFit.fill,
                              ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        "${widget.fullName ?? ""}",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            fontFamily: "outfit",
                            fontSize: 15),
                      ),
                      // _data?.object?[index].isExpert == true
                      //     ? Container(
                      //         color:ColorConstant.primary_color,
                      //         height: 20,
                      //         width: 20,
                      //       )
                      //     : SizedBox(),
                      Spacer(),
                      GestureDetector(
                        onTapDown: (details) {
                          print("yes i am meet ");
                          _showPopupMenu(0, details.globalPosition, context);
                        },
                        child: Container(
                          height: 50,
                          color: Colors.white,
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Container(
                              child: CustomImageView(
                                imagePath: ImageConstant.popupimage,
                                height: 20,
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        )));
  }

  void _showPopupMenu(
    int MemberIndex,
    Offset offset,
    BuildContext context,
  ) async {
    print("_showPopupMenu");
    double right = offset.dx;
    double top = offset.dy;
    double _width = MediaQuery.of(context).size.width;
    double _height = MediaQuery.of(context).size.height;
    await showMenu(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(20),
        ),
      ),
      position: RelativeRect.fromLTRB(
        right,
        top,
        50,
        10,
      ),
      items: [
        PopupMenuItem(
            value: 0,
            onTap: () {
              print("yes i sm comming!!");
            },
            enabled: true,
            child: Container(
              width: 150,
              child: Row(
                children: [
                  CustomImageView(
                    imagePath: ImageConstant.infoimage,
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "View Details",
                      style: TextStyle(color: Colors.black),
                      textScaleFactor: 1.0,
                    ),
                  ),
                ],
              ),
            )),
      ],
    ).then((value) async {
      if (value != null) {
        if (kDebugMode) {
          print("selected==>$value");
        }
        if (value == 0) {
          print(
              "object object object object object object object object object ");

          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ViewDetailsScreen(
                        uuID: widget.userID,
                      )));
        }
      }
    });
  }
}
