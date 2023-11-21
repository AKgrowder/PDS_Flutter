// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pds/API/Bloc/Fatch_All_PRoom_Bloc/Fatch_PRoom_cubit.dart';
import 'package:pds/API/Bloc/Fatch_All_PRoom_Bloc/Fatch_PRoom_state.dart';
import 'package:pds/API/Bloc/senMSG_Bloc/senMSG_cubit.dart';
import 'package:pds/API/Model/getCountOfSavedRoomModel/getCountOfSavedRoomModel.dart';
import 'package:pds/core/utils/color_constant.dart';
import 'package:pds/core/utils/image_constant.dart';
import 'package:pds/core/utils/sharedPreferences.dart';
import 'package:pds/presentation/view_comments/view_comments_screen.dart';
import 'package:pds/widgets/animatedwiget.dart';
import 'package:pds/widgets/custom_image_view.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../API/Model/HomeScreenModel/PublicRoomModel.dart';
import '../../API/Model/HomeScreenModel/getLoginPublicRoom_model.dart';
import '../../theme/theme_helper.dart';

class PublicRoomList extends StatefulWidget {
  PublicRoomModel? PublicRoomModelData;
  LoginPublicRoomModel? FetchPublicRoomModelData;
  PublicRoomList({this.PublicRoomModelData, this.FetchPublicRoomModelData});

  @override
  State<PublicRoomList> createState() => _PublicRoomListState();
}

class _PublicRoomListState extends State<PublicRoomList> {
  dynamic PublicRoomModelData;
  String? userId;
  int? mexcount;
  String? maxPublicRoomSave;
  GetCountOfSavedRoomModel? getCountOfSavedRoomModel;
  method() async {
    if (/* widget.PublicRoomModelData?.object?.isNotEmpty == false */ widget
            .PublicRoomModelData ==
        null) {
      print('if condison workxfcdf');
      PublicRoomModelData = widget.FetchPublicRoomModelData;
      print('PublicRoomModelData-$PublicRoomModelData');
    } else {
      PublicRoomModelData = widget.PublicRoomModelData;
      print('else condsion work');
    }
  }

  UserLogin() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    userId = prefs.getString(PreferencesKey.loginUserID);
    maxPublicRoomSave = prefs.getString(PreferencesKey.MaxPublicRoomSave);
    setState(() {});
    print("userId check-->$userId");
    if (userId != '' || userId != null) {
      BlocProvider.of<FetchAllPublicRoomCubit>(context)
          .getCountOfSavedRoom(context);
    }
  }

  @override
  void initState() {
    super.initState();
    method();
    UserLogin();
  }

  @override
  Widget build(BuildContext context) {
    var _height = MediaQuery.of(context).size.height;
    var _width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: theme.colorScheme.onPrimary,
        centerTitle: true,
        elevation: 0,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back,
            color: Colors.grey,
          ),
        ),
        title: Text(
          "Public Room",
          style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black,
              fontFamily: "outfit",
              fontSize: 20),
        ),
      ),
      body: BlocConsumer<FetchAllPublicRoomCubit, FetchAllPublicRoomState>(
        listener: (context, state) {
          if (state is GetTotalSavedataCount) {
            print("dataCheckDataGet-${state.getCountOfSavedRoomModel.object}");
            mexcount = state.getCountOfSavedRoomModel.object;
            getCountOfSavedRoomModel = state.getCountOfSavedRoomModel;
          }
          if (state is SelectedDataPinAndUnpin) {
            BlocProvider.of<FetchAllPublicRoomCubit>(context)
                .FetchPublicRoom("${userId}", context);
            SnackBar snackBar = SnackBar(
              content: Text(state.unPinModel.object.toString()),
              backgroundColor: ColorConstant.primary_color,
            );
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          }
          if (state is FetchPublicRoomLoadedState) {
            PublicRoomModelData = state.FetchPublicRoomData;
          }
        },
        builder: (context, state) {
          return SingleChildScrollView(
            child: Container(
              child: ListView.builder(
                itemCount: PublicRoomModelData?.object?.length,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  print(
                      "checlk index-${PublicRoomModelData?.object[index].saved}");
                  return Padding(
                    padding:
                        const EdgeInsets.only(left: 16, right: 16, bottom: 10),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return ViewCommentScreen(
                            Room_ID:
                                "${PublicRoomModelData?.object?[index].uid ?? ""}",
                            Title:
                                "${PublicRoomModelData?.object?[index].roomQuestion ?? ""}",
                          );
                        }));
                      },
                      child: Container(
                        // height: demo.contains(index) ? null: height / 16,
                        width: _width,
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: const Color(0XFFD9D9D9), width: 2),
                            borderRadius: BorderRadius.circular(5)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Padding(
                                    padding: const EdgeInsets.only(left: 10),
                                    child: PublicRoomModelData
                                                ?.object?[index]
                                                .ownerUsreProfilePic != null && PublicRoomModelData
                                                ?.object?[index]
                                                .ownerUsreProfilePic != ""
                                                
                                        ? CustomImageView(
                                            url:
                                                "${PublicRoomModelData?.object?[index].ownerUsreProfilePic}",
                                            height: 18,
                                            width: 18,
                                            fit: BoxFit.fill,
                                            radius: BorderRadius.circular(18),
                                          )
                                        : CustomImageView(
                                            imagePath: ImageConstant.tomcruse,
                                            height: 18,
                                            width: 18,
                                          )),
                                Padding(
                                  padding: const EdgeInsets.only(left: 5),
                                  child: Text(
                                    "${PublicRoomModelData?.object?[index].ownerUserName ?? ""}",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w800,
                                        color: Colors.black,
                                        fontFamily: "outfit",
                                        fontSize: 12),
                                  ),
                                ),
                                Spacer(),
                                PublicRoomModelData?.object?[index].saved ==
                                        true
                                    ? GestureDetector(
                                        onTap: () {
                                          print(
                                              "PublicRoomModelData?.object?[index].saved true");
                                          print(PublicRoomModelData
                                              ?.object?[index].saved);
                                          pinanDUnPinMethod(
                                              PublicRoomModelData
                                                      ?.object?[index].saved ??
                                                  false,
                                              '${PublicRoomModelData?.object?[index].uid}',
                                              mexcount ?? 0);
                                        },
                                        child: CustomImageView(
                                          imagePath: ImageConstant.savedPin,
                                          height: 17,
                                        ),
                                      )
                                    : PublicRoomModelData
                                                ?.object?[index].saved !=
                                            null
                                        ? GestureDetector(
                                            onTap: () {
                                              print(
                                                  "PublicRoomModelData?.object?[index].saved flase");
                                              print(PublicRoomModelData
                                                  ?.object?[index].saved);
                                              pinanDUnPinMethod(
                                                  PublicRoomModelData
                                                          ?.object?[index]
                                                          .saved ??
                                                      false,
                                                  '${PublicRoomModelData?.object?[index].uid}',
                                                  mexcount ?? 0);
                                            },
                                            child: CustomImageView(
                                              imagePath: ImageConstant.pin,
                                              height: 17,
                                            ),
                                          )
                                        : SizedBox()

                                /* PublicRoomModelData?.object?[index].saved == true
                                      ? CustomImageView(
                                          imagePath: ImageConstant.savedPin,
                                          height: 17,
                                        )
                                      : CustomImageView(
                                          imagePath: ImageConstant.pin,
                                          height: 17,
                                        ), */
                                ,
                                SizedBox(
                                  width: 10,
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(
                                      left: 8.0, top: 10, bottom: 10),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 2.0, top: 5),
                                        child: CircleAvatar(
                                            backgroundColor: Colors.black,
                                            maxRadius: 3),
                                      ),
                                      SizedBox(
                                        width: 3,
                                      ),
                                      Container(
                                        width: _width / 1.4,
                                        child: Text(
                                          "${PublicRoomModelData?.object?[index].description}",
                                          maxLines: 2,
                                          textScaleFactor: 1.0,
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              overflow: TextOverflow.ellipsis,
                                              color: Colors.black,
                                              fontFamily: "outfit",
                                              fontSize: 16),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 5),
                                  child: Container(
                                    width: _width / 1.4,
                                    child: Align(
                                      alignment: Alignment.centerRight,
                                      child: Text(
                                        "${PublicRoomModelData?.object?[index].message?.userName ?? ""}",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w800,
                                            color: Colors.black,
                                            fontFamily: "outfit",
                                            fontSize: 12),
                                      ),
                                    ),
                                  ),
                                ),
                                PublicRoomModelData
                                            ?.object?[index].message?.message ==
                                        null
                                    ? SizedBox()
                                    : Padding(
                                        padding: const EdgeInsets.only(
                                            left: 5, right: 15),
                                        child: PublicRoomModelData
                                                    ?.object?[index]
                                                    .message
                                                    ?.userProfilePic
                                                   != null && PublicRoomModelData
                                                    ?.object?[index]
                                                    .message
                                                    ?.userProfilePic != ""
                                            ? CustomImageView(
                                                url:
                                                    "${PublicRoomModelData?.object?[index].message?.userProfilePic}",
                                                height: 18,
                                                width: 18,
                                                fit: BoxFit.fill,
                                                radius:
                                                    BorderRadius.circular(18),
                                              )
                                            : CustomImageView(
                                                imagePath:
                                                    ImageConstant.tomcruse,
                                                height: 18,
                                                width: 18,
                                              )),
                              ],
                            ),
                            PublicRoomModelData
                                        ?.object?[index].message?.messageType ==
                                    'TEXT'
                                ? Padding(
                                    padding: const EdgeInsets.only(
                                        left: 20, top: 2, right: 15),
                                    child: Align(
                                      alignment: Alignment.centerRight,
                                      child: Text(
                                        "${PublicRoomModelData?.object?[index].message?.message ?? ""}",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w400,
                                            color: Colors.black,
                                            fontFamily: "outfit",
                                            fontSize: 16),
                                      ),
                                    ),
                                  )
                                : PublicRoomModelData
                                            ?.object?[index].message?.message !=
                                        null
                                    ? Padding(
                                        padding: EdgeInsets.only(right: 10),
                                        child: Align(
                                          alignment: Alignment.centerRight,
                                          child: Container(
                                            child: AnimatedNetworkImage(
                                                imageUrl:
                                                    "${PublicRoomModelData?.object?[index].message?.message}"),
                                          ),
                                        ),
                                      )
                                    : SizedBox(),
                            Divider(
                              color: Colors.black,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(context,
                                        MaterialPageRoute(builder: (context) {
                                      return ViewCommentScreen(
                                        Room_ID:
                                            "${PublicRoomModelData?.object?[index].uid ?? ""}",
                                        Title:
                                            "${PublicRoomModelData?.object?[index].roomQuestion ?? ""}",
                                      );
                                    }));
                                  },
                                  child: Text(
                                    "Add New Comment",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        color: Colors.black,
                                        fontFamily: "outfit",
                                        fontSize: 15),
                                  ),
                                ),
                                // Spacer(),
                                Flexible(
                                  flex: 0,
                                  child: Padding(
                                    padding: const EdgeInsets.only(right: 5),
                                    child: Container(
                                      //  height: 50,
                                      alignment: Alignment.centerRight,
                                      // width: 150,
                                      // color: Colors.amber,
                                      child: Text(
                                        "${PublicRoomModelData?.object?[index].message?.messageCount ?? "0"} Comments",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w400,
                                            color: Colors.grey,
                                            fontFamily: "outfit",
                                            fontSize: 13),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }

  pinanDUnPinMethod(
    bool isSaved,
    String uuid,
    int mexcount,
  ) async {
    if (isSaved == true) {
      await BlocProvider.of<FetchAllPublicRoomCubit>(context)
          .pinAndunPinMethod(context, uuid);
      await BlocProvider.of<FetchAllPublicRoomCubit>(context)
          .getCountOfSavedRoom(context);
    } else {
      if (mexcount < int.parse(maxPublicRoomSave.toString())) {
        //mexCount is savde
        await BlocProvider.of<FetchAllPublicRoomCubit>(context)
            .pinAndunPinMethod(context, uuid);
        await BlocProvider.of<FetchAllPublicRoomCubit>(context)
            .getCountOfSavedRoom(context);
      } else {
        SnackBar snackBar = SnackBar(
          content: Text("Max 3 Pin is allowed"),
          backgroundColor: ColorConstant.primary_color,
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    }
  }
}
