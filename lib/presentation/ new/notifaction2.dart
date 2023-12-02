import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:pds/API/Bloc/Invitation_Bloc/Invitation_cubit.dart';
import 'package:pds/API/Bloc/Invitation_Bloc/Invitation_state.dart';
import 'package:pds/API/Bloc/NewProfileScreen_Bloc/NewProfileScreen_cubit.dart';
import 'package:pds/API/Model/InvitationModel/Invitation_Model.dart';
import 'package:pds/API/Model/acceptRejectInvitaionModel/RequestList_Model.dart';
import 'package:pds/API/Model/acceptRejectInvitaionModel/accept_rejectModel.dart';
import 'package:pds/core/utils/color_constant.dart';
import 'package:pds/core/utils/image_constant.dart';
import 'package:pds/presentation/%20new/newbottembar.dart';
import 'package:pds/presentation/%20new/profileNew.dart';
import 'package:pds/presentation/room_members/room_members_screen.dart';
import 'package:pds/widgets/custom_image_view.dart';

import '../rooms/room_details_screen.dart';

class NewNotifactionScreen extends StatefulWidget {
  const NewNotifactionScreen({Key? key}) : super(key: key);

  @override
  State<NewNotifactionScreen> createState() => _NewNotifactionScreenState();
}

class _NewNotifactionScreenState extends State<NewNotifactionScreen>
    with SingleTickerProviderStateMixin {
  TabController? _tabController;
  RequestListModel? RequestListModelData;
  InvitationModel? invitationRoomData;

  bool apiDataGet = false;
  bool dataGet = false;
  bool? Show_NoData_Image;

  void initState() {
    BlocProvider.of<InvitationCubit>(context).seetinonExpried(context);
    BlocProvider.of<InvitationCubit>(context).RequestListAPI(context);
    BlocProvider.of<InvitationCubit>(context).InvitationAPI(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var _height = MediaQuery.of(context).size.height;
    var _width = MediaQuery.of(context).size.width;
    accept_rejectModel? accept_rejectData;
    return WillPopScope(
      onWillPop: () async {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
                builder: (context) => NewBottomBar(buttomIndex: 0)),
            (Route<dynamic> route) => false);

        return true;
      },
      child: BlocConsumer<InvitationCubit, InvitationState>(
        listener: (context, state) {
          if (state is RequestListLoadedState) {
            apiDataGet = true;
            RequestListModelData = state.RequestListModelData;
          }
          if (state is InvitationErrorState) {
            if (state.error == "not found") {
              Show_NoData_Image = true;
            } else {
              SnackBar snackBar = SnackBar(
                content: Text(state.error),
                backgroundColor: ColorConstant.primary_color,
              );
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            }
          }
          if (state is InvitationLoadedState) {
            dataGet = true;
            invitationRoomData = state.InvitationRoomData;
            print(invitationRoomData?.message);

            if (invitationRoomData?.object?.length == null ||
                invitationRoomData?.object?.length == 0) {
              Show_NoData_Image = false;
            } else {
              Show_NoData_Image = true;
            }
          }

          if (state is InvitationLoadingState) {
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
        },
        builder: (context, state) {
          return DefaultTabController(
            length: 3,
            child: SafeArea(
              child: Scaffold(
                backgroundColor: Colors.white,
                body: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Center(
                      child: Text(
                        'Notifications',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 22,
                          fontFamily: "outfit",
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      decoration:
                          BoxDecoration(border: Border.all(color: Colors.grey)),
                      child: TabBar(
                        onTap: (value) {},
                        controller: _tabController,
                        unselectedLabelStyle: TextStyle(
                          color: Colors.black,
                        ),
                        unselectedLabelColor: Colors.black,
                        indicator: BoxDecoration(
                            // borderRadius: BorderRadius.circular(8.0),
                            color: Color(0xFFED1C25)),
                        tabs: [
                          Container(
                            width: 150,
                            height: 50,
                            // color: Color(0xFFED1C25),
                            child: Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Spacer(),
                                  Text(
                                    "All",
                                    textScaleFactor: 1.0,
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontFamily: 'Outfit',
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Spacer(),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            height: 50,
                            // color: Color(0xFFED1C25),
                            child: Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Requests",
                                    textScaleFactor: 1.0,
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontFamily: 'Outfit',
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    width: 4,
                                  ),
                                  Container(
                                    child: Text(
                                     RequestListModelData?.object?.length!= 0? '${RequestListModelData?.object?.length?? ""}'
                                     :'',
                                      style: TextStyle(
                                          overflow: TextOverflow.ellipsis,
                                          fontFamily: "outfit",
                                          fontWeight: FontWeight.bold,
                                          fontSize: 13),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 1,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            height: 50,
                            // color: Color(0xFFED1C25),
                            child: Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Invitations",
                                    textScaleFactor: 1.0,
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontFamily: 'Outfit',
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    width: 4,
                                  ),
                                  Text(
                                    '${invitationRoomData?.object?.length ?? ""}',
                                    style: TextStyle(
                                        overflow: TextOverflow.ellipsis,
                                        fontFamily: "outfit",
                                        fontWeight: FontWeight.bold,
                                        fontSize: 13),
                                  ),
                                  SizedBox(
                                    width: 1,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: TabBarView(children: [
                        Center(
                            child: Text(
                          'No Record Available',
                          style: TextStyle(
                            fontFamily: 'outfit',
                            fontSize: 20,
                            color: Color(0XFFED1C25),
                            fontWeight: FontWeight.bold,
                          ),
                        )),
                        RequestOrderClass(
                            apiDataGet: apiDataGet,
                            requestListModelData: RequestListModelData),
                        InviationClass(
                          InvitationRoomData: invitationRoomData,
                          dataGet: dataGet,
                          Show_NoData_Image: Show_NoData_Image ?? false,
                        )
                      ]),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class RequestOrderClass extends StatefulWidget {
  RequestListModel? requestListModelData;
  bool apiDataGet;
  RequestOrderClass(
      {required this.requestListModelData, required this.apiDataGet});
  @override
  State<RequestOrderClass> createState() => _RequestOrderClassState();
}

class _RequestOrderClassState extends State<RequestOrderClass> {
  @override
  void initState() {
    BlocProvider.of<InvitationCubit>(context).seetinonExpried(context);
    // BlocProvider.of<InvitationCubit>(context).RequestListAPI(context);
    super.initState();
  }

  accept_rejectModel? accept_rejectData;

  @override
  Widget build(BuildContext context) {
    var _height = MediaQuery.of(context).size.height;
    var _width = MediaQuery.of(context).size.width;

    return BlocConsumer<InvitationCubit, InvitationState>(
        listener: (context, state) {
      if (state is InvitationErrorState) {
        if (state.error == "not found") {
        } else {
          SnackBar snackBar = SnackBar(
            content: Text(state.error),
            backgroundColor: ColorConstant.primary_color,
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
      }

      if (state is InvitationLoadingState) {
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

      if (state is accept_rejectLoadedState) {
        SnackBar snackBar = SnackBar(
          content: Text("${state.accept_rejectData.message}"),
          backgroundColor: ColorConstant.primary_color,
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        accept_rejectData = state.accept_rejectData;
        print(
            "accept_rejectData  accept_rejectData  accept_rejectData  accept_rejectData  accept_rejectData  accept_rejectData  ");
        BlocProvider.of<InvitationCubit>(context).RequestListAPI(context);

        print(accept_rejectData?.message);
      }
    }, builder: (context, state) {
      return widget.apiDataGet != true
          ? Center(
              child: Container(
                margin: EdgeInsets.only(bottom: 100),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.asset(ImageConstant.loader,
                      fit: BoxFit.cover, height: 100.0, width: 100),
                ),
              ),
            )
          : widget.requestListModelData?.object?.isNotEmpty == true
              ? SingleChildScrollView(
                  child: Column(
                  children: [
                    // requestsection_previous_request(context),
                    /*  Padding(
                padding: const EdgeInsets.only(left: 35),
                child: Row(
                  children: [
                    Text(
                      "Previous Requests",
                      style: TextStyle(
                          fontFamily: 'outfit',
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ), */
                    ListView.builder(
                        shrinkWrap: true,
                        physics: BouncingScrollPhysics(),
                        itemCount: widget.requestListModelData?.object?.length,
                        // itemCount: 5,
                        itemBuilder: (BuildContext context, int index) {
                          return Container(
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    children: [
                                      Container(
                                        height: 80,
                                        width: _width / 1.2,
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                color: Colors.grey, width: 1),
                                            color: Colors.white.withOpacity(1),
                                            borderRadius:
                                                BorderRadius.circular(15)),
                                        child: Row(children: [
                                          SizedBox(
                                            width: 5,
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              Navigator.push(context,
                                                  MaterialPageRoute(
                                                      builder: (context) {
                                                return MultiBlocProvider(
                                                    providers: [
                                                      BlocProvider<
                                                          NewProfileSCubit>(
                                                        create: (context) =>
                                                            NewProfileSCubit(),
                                                      ),
                                                    ],
                                                    child: ProfileScreen(
                                                        User_ID:
                                                            "${widget.requestListModelData?.object?[index].followedByUserUid}",
                                                        isFollowing:
                                                            "REQUESTED"));
                                              }));
                                            },
                                            child: widget
                                                            .requestListModelData
                                                            ?.object?[index]
                                                            .followedByUserProfilePic !=
                                                        null &&
                                                    widget
                                                            .requestListModelData
                                                            ?.object?[index]
                                                            .followedByUserProfilePic !=
                                                        ""
                                                ? CustomImageView(
                                                    url:
                                                        "${widget.requestListModelData?.object?[index].followedByUserProfilePic}",
                                                    height: 70,
                                                    width: 70,
                                                    fit: BoxFit.fill,
                                                    radius:
                                                        BorderRadius.circular(
                                                            35),
                                                  )
                                                : CustomImageView(
                                                    imagePath:
                                                        ImageConstant.tomcruse,
                                                    height: 70,
                                                    width: 70,
                                                    fit: BoxFit.fill,
                                                    radius:
                                                        BorderRadius.circular(
                                                            35),
                                                  ),
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                children: [
                                                  Text(
                                                    "${widget.requestListModelData?.object?[index].followedByUserName}",
                                                    style: TextStyle(
                                                        fontFamily: "outfit",
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 13),
                                                  ),
                                                  /* SizedBox(
                                                      width: 4,
                                                    ),
                                                    Text(
                                                      "started following you.",
                                                      style: TextStyle(
                                                          fontFamily: "outfit",
                                                          fontWeight:
                                                              FontWeight.w200,
                                                          fontSize: 13),
                                                    ), */
                                                ],
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Row(
                                                children: [
                                                  GestureDetector(
                                                    onTap: () {
                                                      BlocProvider.of<
                                                                  InvitationCubit>(
                                                              context)
                                                          .accept_rejectAPI(
                                                              context,
                                                              true,
                                                              "${widget.requestListModelData?.object?[index].followUuid}");
                                                    },
                                                    child: Container(
                                                      height: 28,
                                                      width: 100,
                                                      decoration: BoxDecoration(
                                                          color:
                                                              Color(0xFFED1C25),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(6)),
                                                      child: Center(
                                                          child: Text(
                                                        "Accept",
                                                        style: TextStyle(
                                                            fontFamily:
                                                                'outfit',
                                                            color:
                                                                Colors.white),
                                                      )),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 5,
                                                  ),
                                                  GestureDetector(
                                                    onTap: () {
                                                      BlocProvider.of<
                                                                  InvitationCubit>(
                                                              context)
                                                          .accept_rejectAPI(
                                                              context,
                                                              false,
                                                              "${widget.requestListModelData?.object?[index].followUuid}");
                                                    },
                                                    child: Container(
                                                      height: 28,
                                                      width: 100,
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(6),
                                                          border: Border.all(
                                                              color: Color(
                                                                  0xFFED1C25))),
                                                      child: Center(
                                                          child: Text(
                                                        "Reject",
                                                        style: TextStyle(
                                                            fontFamily:
                                                                'outfit',
                                                            color: Color(
                                                                0xFFED1C25)),
                                                      )),
                                                    ),
                                                  )
                                                ],
                                              ),
                                              SizedBox(
                                                height: 3,
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 100),
                                                child: Text(
                                                  customFormat(DateTime.now()),
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  maxLines: 2,
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color: Colors.grey,
                                                      fontFamily: "outfit",
                                                      fontSize: 13),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ]),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        }),
                    // requestsection_previous_request(context),
                    SizedBox(
                      height: 30,
                    ),
                  ],
                ))
              : Center(
                  child: Text(
                    "No Requests For Now",
                    style: TextStyle(
                      fontFamily: 'outfit',
                      fontSize: 20,
                      color: Color(0XFFED1C25),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                );
    });
  }
}

class InviationClass extends StatefulWidget {
  InvitationModel? InvitationRoomData;
  bool dataGet;
  bool Show_NoData_Image;
  InviationClass(
      {required this.InvitationRoomData,
      required this.dataGet,
      required this.Show_NoData_Image});
  @override
  State<InviationClass> createState() => _InviationClassState();
}

class _InviationClassState extends State<InviationClass> {
  @override
  String? User_Mood;
  @override
  void initState() {
    BlocProvider.of<InvitationCubit>(context).seetinonExpried(context);

    BlocProvider.of<InvitationCubit>(context).InvitationAPI(context);
    super.initState();
  }

  Widget build(BuildContext context) {
    var _height = MediaQuery.of(context).size.height;
    var _width = MediaQuery.of(context).size.width;

    return BlocConsumer<InvitationCubit, InvitationState>(
      listener: (context, state) {
        if (state is InvitationErrorState) {
          if (state.error == "not found") {
          } else {
            SnackBar snackBar = SnackBar(
              content: Text(state.error),
              backgroundColor: ColorConstant.primary_color,
            );
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          }
        }

        if (state is InvitationLoadingState) {
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

        if (state is AcceptRejectInvitationModelLoadedState) {
          SnackBar snackBar = SnackBar(
            content: Text(state.acceptRejectInvitationModel.message.toString()),
            backgroundColor: ColorConstant.primary_color,
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
          BlocProvider.of<InvitationCubit>(context).InvitationAPI(context);
        }
      },
      builder: (context, state) {
        return widget.dataGet == true
            ? widget.Show_NoData_Image == false
                ? Center(
                    child: Text(
                      "No Invitations For Now",
                      style: TextStyle(
                        fontFamily: 'outfit',
                        fontSize: 20,
                        color: Color(0XFFED1C25),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                : Column(
                    children: [
                      ListView.builder(
                        itemCount: widget.InvitationRoomData?.object?.length,
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          print(
                              "InvitationRoomData-->${widget.InvitationRoomData?.object?[index].createdAt}");
                          DateTime parsedDateTime = DateTime.parse(
                              '${widget.InvitationRoomData?.object?[index].createdAt}');
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 35, vertical: 5),
                            child: GestureDetector(
                              onTap: () {},
                              child: Container(
                                width: _width / 1.2,
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: const Color(0XFFED1C25),
                                        width: 1),
                                    borderRadius: BorderRadius.circular(5)),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(
                                          left: 8.0,
                                          top: 10,
                                          right: 10,
                                          bottom: 10),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            customFormat(parsedDateTime),
                                            maxLines: 2,
                                            textScaleFactor: 1.0,
                                            style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                color: Colors.grey,
                                                fontFamily: "outfit",
                                                fontSize: 14),
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              print('EXPERT');

                                              Navigator.push(context,
                                                  MaterialPageRoute(
                                                builder: (context) {
                                                  return RoomDetailScreen(
                                                    uuid: widget
                                                        .InvitationRoomData
                                                        ?.object?[index]
                                                        .roomUid
                                                        .toString(),
                                                  );
                                                },
                                              ));
                                            },
                                            child: Icon(
                                                Icons.remove_red_eye_outlined),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 10),
                                          child: Text(
                                            "${widget.InvitationRoomData?.object?[index].companyName}",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black,
                                                fontFamily: "outfit",
                                                fontSize: 14),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 10),
                                          child: Container(
                                            // color: Colors.amber,
                                            width: _width / 1.3,
                                            child: Text(
                                              "${widget.InvitationRoomData?.object?[index].roomQuestion}",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black,
                                                  fontFamily: "outfit",
                                                  fontSize: 14),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 8.0),
                                      child: Text(
                                        "${widget.InvitationRoomData?.object?[index].description}",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w400,
                                            color:
                                                Colors.black.withOpacity(0.5),
                                            fontFamily: "outfit",
                                            fontSize: 14),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.push(context,
                                            MaterialPageRoute(
                                          builder: (context) {
                                            return RoomMembersScreen(
                                                roomname:
                                                    "${widget.InvitationRoomData?.object?[index].roomQuestion}",
                                                RoomOwner: false,
                                                roomdescription:
                                                    "${widget.InvitationRoomData?.object?[index].description}",
                                                room_Id:
                                                    '${widget.InvitationRoomData?.object?[index].roomUid.toString()}');
                                          },
                                        ));
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            left: 10.0, right: 10),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            widget
                                                            .InvitationRoomData
                                                            ?.object?[index]
                                                            .roomMembers
                                                            ?.length ==
                                                        0 ||
                                                    widget
                                                            .InvitationRoomData
                                                            ?.object?[index]
                                                            .roomMembers
                                                            ?.isEmpty ==
                                                        true
                                                ? SizedBox()
                                                : widget
                                                            .InvitationRoomData
                                                            ?.object?[index]
                                                            .roomMembers
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
                                                                  decoration: BoxDecoration(
                                                                      color: ColorConstant
                                                                          .primary_color,
                                                                      shape: BoxShape
                                                                          .circle),
                                                                  child: widget
                                                                              .InvitationRoomData
                                                                              ?.object?[index]
                                                                              .roomMembers?[0]
                                                                              .userProfilePic
                                                                              ?.isNotEmpty ??
                                                                          false
                                                                      ? CustomImageView(
                                                                          url:
                                                                              "${widget.InvitationRoomData?.object?[index].roomMembers?[0].userProfilePic}",
                                                                          radius:
                                                                              BorderRadius.circular(20),
                                                                          width:
                                                                              20,
                                                                          fit: BoxFit
                                                                              .fill,
                                                                        )
                                                                      : CustomImageView(
                                                                          imagePath:
                                                                              ImageConstant.tomcruse,
                                                                          radius:
                                                                              BorderRadius.circular(20),
                                                                          width:
                                                                              20,
                                                                          fit: BoxFit
                                                                              .fill,
                                                                        )),
                                                            ),
                                                          ],
                                                        ),
                                                      )
                                                    : widget
                                                                .InvitationRoomData
                                                                ?.object?[index]
                                                                .roomMembers
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
                                                                      child: widget.InvitationRoomData?.object?[index].roomMembers?[0].userProfilePic?.isNotEmpty ?? false
                                                                          ? CustomImageView(
                                                                              url: "${widget.InvitationRoomData?.object?[index].roomMembers?[0].userProfilePic}",
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
                                                                      child: widget.InvitationRoomData?.object?[index].roomMembers?[1].userProfilePic?.isNotEmpty ?? false
                                                                          ? CustomImageView(
                                                                              url: "${widget.InvitationRoomData?.object?[index].roomMembers?[1].userProfilePic}",
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
                                                        : widget
                                                                    .InvitationRoomData
                                                                    ?.object?[
                                                                        index]
                                                                    .roomMembers
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
                                                                          child: widget.InvitationRoomData?.object?[index].roomMembers?[0].userProfilePic?.isNotEmpty ?? false
                                                                              ? CustomImageView(
                                                                                  url: "${widget.InvitationRoomData?.object?[index].roomMembers?[0].userProfilePic}",
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
                                                                          child: widget.InvitationRoomData?.object?[index].roomMembers?[1].userProfilePic?.isNotEmpty ?? false
                                                                              ? CustomImageView(
                                                                                  url: "${widget.InvitationRoomData?.object?[index].roomMembers?[1].userProfilePic}",
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
                                                                    // error get
                                                                    Positioned(
                                                                      left:
                                                                          45.12,
                                                                      top: 0,
                                                                      child: Container(
                                                                          width: 26.88,
                                                                          height: 26.87,
                                                                          decoration: BoxDecoration(color: ColorConstant.primary_color, shape: BoxShape.circle),
                                                                          child: widget.InvitationRoomData?.object?[index].roomMembers?[2].userProfilePic?.isNotEmpty ?? false
                                                                              ? CustomImageView(
                                                                                  url: "${widget.InvitationRoomData?.object?[index].roomMembers?[2].userProfilePic}",
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
                                                                          child: widget.InvitationRoomData?.object?[index].roomMembers?[0].userProfilePic?.isNotEmpty ?? false
                                                                              ? CustomImageView(
                                                                                  url: "${widget.InvitationRoomData?.object?[index].roomMembers?[0].userProfilePic}",
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
                                                                          child: widget.InvitationRoomData?.object?[index].roomMembers?[1].userProfilePic?.isNotEmpty ?? false
                                                                              ? CustomImageView(
                                                                                  url: "${widget.InvitationRoomData?.object?[index].roomMembers?[1].userProfilePic}",
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
                                                                          child: widget.InvitationRoomData?.object?[index].roomMembers?[2].userProfilePic?.isNotEmpty ?? false
                                                                              ? CustomImageView(
                                                                                  url: "${widget.InvitationRoomData?.object?[index].roomMembers?[2].userProfilePic}",
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
                                                                      left: 78,
                                                                      top: 7,
                                                                      child:
                                                                          SizedBox(
                                                                        width:
                                                                            21,
                                                                        height:
                                                                            16,
                                                                        child:
                                                                            Text(
                                                                          "+${(widget.InvitationRoomData?.object?[index].roomMembers?.length ?? 0) - 3}",
                                                                          style:
                                                                              TextStyle(
                                                                            color:
                                                                                Color(0xFF2A2A2A),
                                                                            fontSize:
                                                                                14,
                                                                            fontFamily:
                                                                                'Outfit',
                                                                            fontWeight:
                                                                                FontWeight.w400,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          flex: 2,
                                          child: GestureDetector(
                                            onTap: () {
                                              BlocProvider.of<InvitationCubit>(
                                                      context)
                                                  .GetRoomInvitations(
                                                      false,
                                                      widget
                                                              .InvitationRoomData
                                                              ?.object?[index]
                                                              .invitationLink
                                                              .toString() ??
                                                          "",
                                                      context);
                                            },
                                            child: Container(
                                              height: 40,
                                              width: _width / 2.48,
                                              decoration: BoxDecoration(
                                                  // color: Color(0XFF9B9B9B),
                                                  color: Color(0XFF9B9B9B),
                                                  borderRadius:
                                                      BorderRadius.only(
                                                          bottomLeft:
                                                              Radius.circular(
                                                                  4))),
                                              child: Center(
                                                child: Text(
                                                  "Reject",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      color: Colors.white,
                                                      fontFamily: "outfit",
                                                      fontSize: 15),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 1,
                                        ),
                                        Expanded(
                                          flex: 2,
                                          child: GestureDetector(
                                            onTap: () {
                                              BlocProvider.of<InvitationCubit>(
                                                      context)
                                                  .GetRoomInvitations(
                                                      true,
                                                      widget
                                                              .InvitationRoomData
                                                              ?.object?[index]
                                                              .invitationLink
                                                              .toString() ??
                                                          "",
                                                      context);
                                            },
                                            child: Container(
                                              height: 40,
                                              width: _width / 2.48,
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.only(
                                                  bottomRight:
                                                      Radius.circular(4),
                                                ),
                                                color: Color(0xFFED1C25),
                                              ),
                                              child: Center(
                                                child: Text(
                                                  "Accept",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      color: Colors.white,
                                                      fontFamily: "outfit",
                                                      fontSize: 15),
                                                ),
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
                    ],
                  )
            : SizedBox.shrink();
      },
    );
  }
}

String customFormat(DateTime date) {
  String day = date.day.toString();
  String month = _getMonthName(date.month);
  String year = date.year.toString();
  String time = DateFormat('h:mm a').format(date);

  String formattedDate = '$day $month $year $time';
  return formattedDate;
}

String _getMonthName(int month) {
  switch (month) {
    case 1:
      return 'Jan';
    case 2:
      return 'Feb';
    case 3:
      return 'Mar';
    case 4:
      return 'Apr';
    case 5:
      return 'May';
    case 6:
      return 'June';
    case 7:
      return 'July';
    case 8:
      return 'Aug';
    case 9:
      return 'Sept';
    case 10:
      return 'Oct';
    case 11:
      return 'Nov';
    case 12:
      return 'Dec';
    default:
      return '';
  }
}
