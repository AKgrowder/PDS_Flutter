import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:pds/API/Bloc/Fatch_all_members/fatch_all_members_cubit.dart';
import 'package:pds/API/Bloc/Invitation_Bloc/Invitation_cubit.dart';
import 'package:pds/API/Bloc/Invitation_Bloc/Invitation_state.dart';
import 'package:pds/API/Model/InvitationModel/Invitation_Model.dart';
import 'package:pds/core/utils/color_constant.dart';
import 'package:pds/core/utils/image_constant.dart';
import 'package:pds/presentation/room_members/room_members_screen.dart';
import 'package:pds/widgets/custom_image_view.dart';

class NewNotifactionScreen extends StatefulWidget {
  const NewNotifactionScreen({Key? key}) : super(key: key);

  @override
  State<NewNotifactionScreen> createState() => _NewNotifactionScreenState();
}

class _NewNotifactionScreenState extends State<NewNotifactionScreen>
    with SingleTickerProviderStateMixin {
  TabController? _tabController;

  @override
  Widget build(BuildContext context) {
    var _height = MediaQuery.of(context).size.height;
    var _width = MediaQuery.of(context).size.width;
    return DefaultTabController(
      length: 3,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          body: Stack(
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
              Column(
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
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey)),
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
                                      fontSize: 18,
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
                                      fontSize: 18,
                                      fontFamily: 'Outfit',
                                      fontWeight: FontWeight.bold),
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
                                      fontSize: 18,
                                      fontFamily: 'Outfit',
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SingleChildScrollView(
                    child: Column(
                      children: [
                        Container(
                          // color: Colors.red,
                          height: MediaQuery.of(context).size.height * 0.746,
                          child: TabBarView(children: [
                            Center(child: Text('Tab 1 Content')),
                            RequestOrderClass(),
                            MultiBlocProvider(providers: [
                              BlocProvider<InvitationCubit>(
                            create: (context) => InvitationCubit(),
                              ),
                            ], child: InviationClass())
                          ]),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class RequestOrderClass extends StatelessWidget {
  const RequestOrderClass({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var _height = MediaQuery.of(context).size.height;
    var _width = MediaQuery.of(context).size.width;
    return SingleChildScrollView(
      child: Column(
        children: [
          requestsection_previous_request(context),
          Padding(
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
          ),
          requestsection_previous_request(context),
          SizedBox(
            height: 30,
          ),
        ],
      ),
    );
  }

  requestsection_previous_request(context) {
    var _height = MediaQuery.of(context).size.height;
    var _width = MediaQuery.of(context).size.width;
    return ListView.builder(
        shrinkWrap: true,
        physics: BouncingScrollPhysics(),
        itemCount: 5,
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
                            border: Border.all(color: Colors.grey, width: 1),
                            color: Colors.white.withOpacity(1),
                            borderRadius: BorderRadius.circular(15)),
                        child: Row(children: [
                          Image.asset(
                            ImageConstant.expertone,
                          ),
                          Column(
                            children: [
                              Row(
                                children: [
                                  Text(
                                    "Karennne Watsaon",
                                    style: TextStyle(
                                        fontFamily: "outfit",
                                        fontWeight: FontWeight.bold,
                                        fontSize: 13),
                                  ),
                                  SizedBox(
                                    width: 4,
                                  ),
                                  Text(
                                    "started following you.",
                                    style: TextStyle(
                                        fontFamily: "outfit",
                                        fontWeight: FontWeight.w200,
                                        fontSize: 13),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 30.0),
                                child: Row(
                                  children: [
                                    Container(
                                      height: 30,
                                      width: 100,
                                      decoration: BoxDecoration(
                                          color: Color(0xFFED1C25),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: Center(
                                          child: Text(
                                        "Accept",
                                        style: TextStyle(
                                            fontFamily: 'outfit',
                                            color: Colors.white),
                                      )),
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Container(
                                      height: 30,
                                      width: 100,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          border: Border.all(
                                              color: Color(0xFFED1C25))),
                                      child: Center(
                                          child: Text(
                                        "Reject",
                                        style: TextStyle(
                                            fontFamily: 'outfit',
                                            color: Color(0xFFED1C25)),
                                      )),
                                    )
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 85),
                                child: Text(
                                  customFormat(DateTime.now()),
                                  maxLines: 2,
                                  textScaleFactor: 1.0,
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      color: Colors.grey,
                                      fontFamily: "outfit",
                                      fontSize: 14),
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
        });
  }
}

class InviationClass extends StatefulWidget {
  const InviationClass({Key? key}) : super(key: key);

  @override
  State<InviationClass> createState() => _InviationClassState();
}

class _InviationClassState extends State<InviationClass> {
  @override
  InvitationModel? InvitationRoomData;
  @override
  void initState() {
    BlocProvider.of<InvitationCubit>(context).InvitationAPI(context);
    super.initState();
  }

  bool dataGet = false;
  bool? Show_NoData_Image;

  Widget build(BuildContext context) {
    var _height = MediaQuery.of(context).size.height;
    var _width = MediaQuery.of(context).size.width;

    return BlocConsumer<InvitationCubit, InvitationState>(
      listener: (context, state) {
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
        if (state is InvitationLoadedState) {
          dataGet = true;
          InvitationRoomData = state.InvitationRoomData;
          print(InvitationRoomData?.message);

          if (InvitationRoomData?.object?.length == null ||
              InvitationRoomData?.object?.length == 0) {
            Show_NoData_Image = false;
          } else {
            Show_NoData_Image = true;
          }
        }
        if (state is AcceptRejectInvitationModelLoadedState) {
          SnackBar snackBar = SnackBar(
            content:
                Text(state.acceptRejectInvitationModel.message.toString()),
            backgroundColor: ColorConstant.primary_color,
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
          BlocProvider.of<InvitationCubit>(context).InvitationAPI(context);
        }
      },
      builder: (context, state) {
        print("dataGet == $dataGet");

        return dataGet == true
            ? Column(
                children: [
                  Show_NoData_Image == false
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
                      : ListView.builder(
                          itemCount: InvitationRoomData?.object?.length,
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            print(
                                "InvitationRoomData-->${InvitationRoomData?.object?[index].createdAt}");
                            DateTime parsedDateTime = DateTime.parse(
                                '${InvitationRoomData?.object?[index].createdAt}');
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                            padding: const EdgeInsets.only(
                                                left: 10),
                                            child: Text(
                                              "${InvitationRoomData?.object?[index].companyName}",
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
                                            padding: const EdgeInsets.only(
                                                left: 10),
                                            child: Container(
                                              // color: Colors.amber,
                                              width: _width / 1.3,
                                              child: Text(
                                                "${InvitationRoomData?.object?[index].roomQuestion}",
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
                                        padding:
                                            const EdgeInsets.only(left: 8.0),
                                        child: Text(
                                          "${InvitationRoomData?.object?[index].description}",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w400,
                                              color: Colors.black
                                                  .withOpacity(0.5),
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
                                              return MultiBlocProvider(
                                                providers: [
                                                  BlocProvider(
                                                    create: (context) =>
                                                        FatchAllMembersCubit(),
                                                  ),
                                                ],
                                                child: RoomMembersScreen(
                                                    roomname:
                                                        "${InvitationRoomData?.object?[index].roomQuestion}",
                                                    RoomOwner: false,
                                                    roomdescription:
                                                        "${InvitationRoomData?.object?[index].description}",
                                                    room_Id:
                                                        '${InvitationRoomData?.object?[index].roomUid.toString()}'),
                                              );
                                            },
                                          ));
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              left: 10.0, right: 10),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment
                                                    .spaceBetween,
                                            children: [
                                              InvitationRoomData
                                                              ?.object?[index]
                                                              .roomMembers
                                                              ?.length ==
                                                          0 ||
                                                      InvitationRoomData
                                                              ?.object?[index]
                                                              .roomMembers
                                                              ?.isEmpty ==
                                                          true
                                                  ? SizedBox()
                                                  : InvitationRoomData
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
                                                                    decoration: BoxDecoration(color: ColorConstant.primary_color, shape: BoxShape.circle),
                                                                    child: CustomImageView(
                                                                      url: InvitationRoomData?.object?[index].roomMembers?[0].userProfilePic?.isNotEmpty ??
                                                                              false
                                                                          ? "${InvitationRoomData?.object?[index].roomMembers?[0].userProfilePic}"
                                                                          : "https://t3.ftcdn.net/jpg/03/46/83/96/360_F_346839683_6nAPzbhpSkIpb8pmAwufkC7c5eD7wYws.jpg",
                                                                      height:
                                                                          20,
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
                                                      : InvitationRoomData
                                                                  ?.object?[
                                                                      index]
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
                                                                        child: CustomImageView(
                                                                          url: InvitationRoomData?.object?[index].roomMembers?[0].userProfilePic?.isNotEmpty ?? false
                                                                              ? "${InvitationRoomData?.object?[index].roomMembers?[0].userProfilePic}"
                                                                              : "https://t3.ftcdn.net/jpg/03/46/83/96/360_F_346839683_6nAPzbhpSkIpb8pmAwufkC7c5eD7wYws.jpg",
                                                                          height:
                                                                              20,
                                                                          radius:
                                                                              BorderRadius.circular(20),
                                                                          width:
                                                                              20,
                                                                          fit:
                                                                              BoxFit.fill,
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
                                                                        child: CustomImageView(
                                                                          url: InvitationRoomData?.object?[index].roomMembers?[1].userProfilePic?.isNotEmpty ?? false
                                                                              ? "${InvitationRoomData?.object?[index].roomMembers?[1].userProfilePic}"
                                                                              : "https://t3.ftcdn.net/jpg/03/46/83/96/360_F_346839683_6nAPzbhpSkIpb8pmAwufkC7c5eD7wYws.jpg",
                                                                          height:
                                                                              20,
                                                                          radius:
                                                                              BorderRadius.circular(20),
                                                                          width:
                                                                              20,
                                                                          fit:
                                                                              BoxFit.fill,
                                                                        )),
                                                                  ),
                                                                ],
                                                              ),
                                                            )
                                                          : InvitationRoomData
                                                                      ?.object?[
                                                                          index]
                                                                      .roomMembers
                                                                      ?.length ==
                                                                  3
                                                              ? Container(
                                                                  width: 99,
                                                                  height:
                                                                      27.88,
                                                                  child:
                                                                      Stack(
                                                                    children: [
                                                                      Positioned(
                                                                        left:
                                                                            0,
                                                                        top:
                                                                            0,
                                                                        child: Container(
                                                                            width: 26.88,
                                                                            height: 26.87,
                                                                            decoration: BoxDecoration(color: ColorConstant.primary_color, shape: BoxShape.circle),
                                                                            child: CustomImageView(
                                                                              url: InvitationRoomData?.object?[index].roomMembers?[0].userProfilePic?.isNotEmpty ?? false ? "${InvitationRoomData?.object?[index].roomMembers?[0].userProfilePic}" : "https://t3.ftcdn.net/jpg/03/46/83/96/360_F_346839683_6nAPzbhpSkIpb8pmAwufkC7c5eD7wYws.jpg",
                                                                              height: 20,
                                                                              radius: BorderRadius.circular(20),
                                                                              width: 20,
                                                                              fit: BoxFit.fill,
                                                                            )),
                                                                      ),
                                                                      Positioned(
                                                                        left:
                                                                            22.56,
                                                                        top:
                                                                            0,
                                                                        child: Container(
                                                                            width: 26.88,
                                                                            height: 26.87,
                                                                            decoration: BoxDecoration(color: ColorConstant.primary_color, shape: BoxShape.circle),
                                                                            child: CustomImageView(
                                                                              url: InvitationRoomData?.object?[index].roomMembers?[1].userProfilePic?.isNotEmpty ?? false ? "${InvitationRoomData?.object?[index].roomMembers?[1].userProfilePic}" : "https://t3.ftcdn.net/jpg/03/46/83/96/360_F_346839683_6nAPzbhpSkIpb8pmAwufkC7c5eD7wYws.jpg",
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
                                                                        top:
                                                                            0,
                                                                        child: Container(
                                                                            width: 26.88,
                                                                            height: 26.87,
                                                                            decoration: BoxDecoration(color: ColorConstant.primary_color, shape: BoxShape.circle),
                                                                            child: CustomImageView(
                                                                              url: InvitationRoomData?.object?[index].roomMembers?[2].userProfilePic?.isNotEmpty ?? false ? "${InvitationRoomData?.object?[index].roomMembers?[2].userProfilePic}" : "https://t3.ftcdn.net/jpg/03/46/83/96/360_F_346839683_6nAPzbhpSkIpb8pmAwufkC7c5eD7wYws.jpg",
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
                                                                  height:
                                                                      27.88,
                                                                  child:
                                                                      Stack(
                                                                    children: [
                                                                      Positioned(
                                                                        left:
                                                                            0,
                                                                        top:
                                                                            0,
                                                                        child: Container(
                                                                            width: 26.88,
                                                                            height: 26.87,
                                                                            decoration: BoxDecoration(color: ColorConstant.primary_color, shape: BoxShape.circle),
                                                                            child: CustomImageView(
                                                                              url: InvitationRoomData?.object?[index].roomMembers?[0].userProfilePic?.isNotEmpty ?? false ? "${InvitationRoomData?.object?[index].roomMembers?[0].userProfilePic}" : "https://t3.ftcdn.net/jpg/03/46/83/96/360_F_346839683_6nAPzbhpSkIpb8pmAwufkC7c5eD7wYws.jpg",
                                                                              height: 20,
                                                                              radius: BorderRadius.circular(20),
                                                                              width: 20,
                                                                              fit: BoxFit.fill,
                                                                            )),
                                                                      ),
                                                                      Positioned(
                                                                        left:
                                                                            22.56,
                                                                        top:
                                                                            0,
                                                                        child: Container(
                                                                            width: 26.88,
                                                                            height: 26.87,
                                                                            decoration: BoxDecoration(color: ColorConstant.primary_color, shape: BoxShape.circle),
                                                                            child: CustomImageView(
                                                                              url: InvitationRoomData?.object?[index].roomMembers?[1].userProfilePic?.isNotEmpty ?? false ? "${InvitationRoomData?.object?[index].roomMembers?[1].userProfilePic}" : "https://t3.ftcdn.net/jpg/03/46/83/96/360_F_346839683_6nAPzbhpSkIpb8pmAwufkC7c5eD7wYws.jpg",
                                                                              height: 20,
                                                                              radius: BorderRadius.circular(20),
                                                                              width: 20,
                                                                              fit: BoxFit.fill,
                                                                            )),
                                                                      ),
                                                                      Positioned(
                                                                        left:
                                                                            45.12,
                                                                        top:
                                                                            0,
                                                                        child: Container(
                                                                            width: 26.88,
                                                                            height: 26.87,
                                                                            decoration: BoxDecoration(color: ColorConstant.primary_color, shape: BoxShape.circle),
                                                                            child: CustomImageView(
                                                                              url: InvitationRoomData?.object?[index].roomMembers?[2].userProfilePic?.isNotEmpty ?? false ? "${InvitationRoomData?.object?[index].roomMembers?[2].userProfilePic}" : "https://t3.ftcdn.net/jpg/03/46/83/96/360_F_346839683_6nAPzbhpSkIpb8pmAwufkC7c5eD7wYws.jpg",
                                                                              height: 20,
                                                                              radius: BorderRadius.circular(20),
                                                                              width: 20,
                                                                              fit: BoxFit.fill,
                                                                            )),
                                                                      ),
                                                                      Positioned(
                                                                        left:
                                                                            78,
                                                                        top:
                                                                            7,
                                                                        child:
                                                                            SizedBox(
                                                                          width:
                                                                              21,
                                                                          height:
                                                                              16,
                                                                          child:
                                                                              Text(
                                                                            "+${(InvitationRoomData?.object?[index].roomMembers?.length ?? 0) - 3}",
                                                                            style: TextStyle(
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
                                                print(
                                                    'chek data get-${InvitationRoomData?.object?[index].invitationLink.toString()}');
                                                BlocProvider.of<
                                                            InvitationCubit>(
                                                        context)
                                                    .GetRoomInvitations(
                                                        false,
                                                        InvitationRoomData
                                                                ?.object?[
                                                                    index]
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
                                                            bottomLeft: Radius
                                                                .circular(
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
                                                BlocProvider.of<
                                                            InvitationCubit>(
                                                        context)
                                                    .GetRoomInvitations(
                                                        true,
                                                        InvitationRoomData
                                                                ?.object?[
                                                                    index]
                                                                .invitationLink
                                                                .toString() ??
                                                            "",
                                                        context);
                                              },
                                              child: Container(
                                                height: 40,
                                                width: _width / 2.48,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.only(
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

  String formattedDate = '$day$month $year $time';
  return formattedDate;
}

String _getMonthName(int month) {
  switch (month) {
    case 1:
      return 'st January';
    case 2:
      return 'nd February';
    case 3:
      return 'rd March';
    case 4:
      return 'th April';
    case 5:
      return 'th May';
    case 6:
      return 'th June';
    case 7:
      return 'th July';
    case 8:
      return 'th August';
    case 9:
      return 'th September';
    case 10:
      return 'th October';
    case 11:
      return 'th November';
    case 12:
      return 'th December';
    default:
      return '';
  }
}
