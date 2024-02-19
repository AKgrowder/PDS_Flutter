import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:pds/API/Bloc/Invitation_Bloc/Invitation_cubit.dart';
import 'package:pds/API/Bloc/Invitation_Bloc/Invitation_state.dart';
import 'package:pds/API/Bloc/NewProfileScreen_Bloc/NewProfileScreen_cubit.dart';
import 'package:pds/API/Model/InvitationModel/Invitation_Model.dart';
import 'package:pds/API/Model/acceptRejectInvitaionModel/GetAllNotificationModel.dart';
import 'package:pds/API/Model/acceptRejectInvitaionModel/RequestList_Model.dart';
import 'package:pds/API/Model/acceptRejectInvitaionModel/accept_rejectModel.dart';
import 'package:pds/core/utils/color_constant.dart';
import 'package:pds/core/utils/image_constant.dart';
import 'package:pds/core/utils/sharedPreferences.dart';
import 'package:pds/presentation/%20new/OpenSavePostImage.dart';
import 'package:pds/presentation/%20new/newbottembar.dart';
import 'package:pds/presentation/%20new/profileNew.dart';
import 'package:pds/presentation/room_members/room_members_screen.dart';
import 'package:pds/widgets/custom_image_view.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../rooms/room_details_screen.dart';
import 'ReadAll_dailog.dart';


 int NotificationCount = 0;
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
  GetAllNotificationModel? AllNotificationData;
 
  bool apiDataGet = false;
  bool dataGet = false;
  bool? Show_NoData_Image;

  void initState() {
    AllAPICall();
    super.initState();   
  }

  AllAPICall() async {
    await BlocProvider.of<InvitationCubit>(context).readnotificationscount(context);
    await BlocProvider.of<InvitationCubit>(context).seetinonExpried(context);
    await BlocProvider.of<InvitationCubit>(context).AllNotification(context);
    await BlocProvider.of<InvitationCubit>(context).RequestListAPI(context);
    await BlocProvider.of<InvitationCubit>(context).InvitationAPI(context);
    await BlocProvider.of<InvitationCubit>(context).getAllNoticationsCountAPI(context);
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
           if (state is GetNotificationCountLoadedState) {
                print(state.GetNotificationCountData.object);
                saveNotificationCount(state.GetNotificationCountData.object?.notificationCount ?? 0,state.GetNotificationCountData.object?.messageCount ?? 0);
              }

          if (state is GetAllNotificationLoadedState) {
            NotificationCount = 0;
            AllNotificationData = state.AllNotificationData;
            AllNotificationData?.object?.forEach((element) async {
              if (element.isSeen == false) {
                NotificationCount = NotificationCount + 1;
              }
            });
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

                      Row( mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                
                                 Text(
                            'Notifications',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 22,
                              fontFamily: "outfit",
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                                
                              
                              ],
                            ),
                  
                    SizedBox(
                      height: 20,
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
                            color: ColorConstant.primary_color,),
                        tabs: [
                          Container(
                            width: 150,
                            height: 50,
                            // color: ColorConstant.primary_color,
                            child: Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  // Spacer(),
                                  Text(
                                    "All",
                                    textScaleFactor: 1.0,
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontFamily: 'Outfit',
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    width: 4,
                                  ),
                                  AllNotificationData?.object?.length == 0 ||
                                          AllNotificationData?.object?.length ==
                                              null
                                      ? SizedBox()
                                      : Container(
                                          child: NotificationCount == 0 ? SizedBox() : Text(
                                            '${NotificationCount}',
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
                                  // Spacer(),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            height: 50,
                            // color: ColorConstant.primary_color,
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
                                  RequestListModelData?.object?.length == 0 ||
                                          RequestListModelData
                                                  ?.object?.length ==
                                              null
                                      ? SizedBox()
                                      : Container(
                                          child: Text(
                                            '${RequestListModelData?.object?.length ?? ""}',
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
                            // color: ColorConstant.primary_color,
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
                                  invitationRoomData?.object?.length == 0 ||
                                          invitationRoomData?.object?.length ==
                                              null
                                      ? SizedBox()
                                      : Text(
                                          '${invitationRoomData?.object?.length}',
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
                        // Center(
                        //     child: Text(
                        //   'No Record Available',
                        //   style: TextStyle(
                        //     fontFamily: 'outfit',
                        //     fontSize: 20,
                        //     color: ColorConstant.primary_color,
                        //     fontWeight: FontWeight.bold,
                        //   ),
                        // )),
                        SingleChildScrollView(
                          child: AllNotificationClass(),
                        ),
                        SingleChildScrollView(
                          child: RequestOrderClass(
                              apiDataGet: apiDataGet,
                              requestListModelData: RequestListModelData),
                        ),
                        SingleChildScrollView(
                          child: InviationClass(
                            InvitationRoomData: invitationRoomData,
                            dataGet: dataGet,
                            Show_NoData_Image: Show_NoData_Image ?? false,
                          ),
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
  
  saveNotificationCount(int NotificationCount,int MessageCount) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt(PreferencesKey.NotificationCount, NotificationCount);
    prefs.setInt(PreferencesKey.MessageCount, MessageCount);
  }
}

class AllNotificationClass extends StatefulWidget {
  const AllNotificationClass();

  @override
  State<AllNotificationClass> createState() => _AllNotificationClassState();
}

class _AllNotificationClassState extends State<AllNotificationClass> {
  String getTimeDifference(DateTime dateTime) {
    final difference = DateTime.now().difference(dateTime);
    if (difference.inDays > 0) {
      if (difference.inDays == 1) {
        return '1 day ago';
      } else if (difference.inDays < 7) {
        return '${difference.inDays} days ago';
      } else {
        final weeks = (difference.inDays / 7).floor();
        return '$weeks week${weeks == 1 ? '' : 's'} ago';
      }
    } else if (difference.inHours > 0) {
      if (difference.inHours == 1) {
        return '1 hour ago';
      } else {
        return '${difference.inHours} hours ago';
      }
    } else if (difference.inMinutes > 0) {
      if (difference.inMinutes == 1) {
        return '1 minute ago';
      } else {
        return '${difference.inMinutes} minutes ago';
      }
    } else {
      return 'Just now';
    }
  }

  @override
  void initState() {
    
    AllAPICall();
    // BlocProvider.of<InvitationCubit>(context).RequestListAPI(context);
    super.initState();
  }

    AllAPICall() async {
    await BlocProvider.of<InvitationCubit>(context).seetinonExpried(context);
    await BlocProvider.of<InvitationCubit>(context).AllNotification(context);
  }

  bool? isdata = false;
  GetAllNotificationModel? AllNotificationData;
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

      if (state is GetAllNotificationLoadedState) {
        isdata = true;
        AllNotificationData = state.AllNotificationData;
      }
if(state is ReadAllMSGLoadedState){
                // Navigator.pop(context);
                BlocProvider.of<InvitationCubit>(context).AllNotification(context);

              }
      if (state is SeenNotificationLoadedState) {
        BlocProvider.of<InvitationCubit>(context).AllNotification(context);
      }
    }, builder: (context, state) {
      return isdata == false
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
          : AllNotificationData?.object?.isNotEmpty == true
              ? Column(
                children: [SizedBox(height: 10,),
              NotificationCount == 0 ? SizedBox() : Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              GestureDetector(
                 onTap: () {
                   BlocProvider.of<InvitationCubit>(context)
                                        .ReadAllMassagesAPI(context);
                                      //  showDialog(
                                      // context: context,
                                      // builder: (_) => ReadAlldailog());
                                    },
                child: Text("Mark all as read",
                    style: TextStyle(
                        decoration: TextDecoration.underline,
                        color: ColorConstant.primary_color,
                        fontWeight: FontWeight.bold)),
              ),SizedBox(width: 10,),
            ],
          ),
                  ListView.builder(
                      itemCount: AllNotificationData?.object?.length,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        DateTime? parsedDateTime;
                        if (AllNotificationData?.object?[index].receivedAt !=
                            null) {
                          parsedDateTime = DateTime.parse(
                              '${AllNotificationData?.object?[index].receivedAt ?? ""}');
                        }

                        return AllNotificationData?.object?[index].receivedAt !=
                                null
                            ? Padding(
                                padding: const EdgeInsets.only(
                                    top: 16, left: 16, right: 16),
                                child: GestureDetector(
                                  onTap: () {
                                    AllNotificationData?.object?[index].subject == "TAG_POST" ||
                                            AllNotificationData?.object?[index].subject ==
                                                "RE_POST"
                                        ? Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    OpenSavePostImage(
                                                      PostID: AllNotificationData
                                                          ?.object?[index]
                                                          .accessCode,
                                                      index: 0,
                                                    )),
                                          )
                                        // print("opne Save Image screen RE_POST & TAG_POST");

                                        : AllNotificationData?.object?[index].subject ==
                                                "INVITE_ROOM"
                                            ? print("Notification Seen INVITE_ROOM")
                                            : AllNotificationData?.object?[index].subject == "EXPERT_LEFT_ROOM" ||
                                                    AllNotificationData?.object?[index].subject ==
                                                        "MEMBER_LEFT_ROOM" ||
                                                    AllNotificationData?.object?[index].subject ==
                                                        "DELETE_ROOM" ||
                                                    AllNotificationData?.object?[index].subject ==
                                                        "EXPERT_ACCEРТ_INVITE" ||
                                                    AllNotificationData?.object?[index].subject ==
                                                        "EXPERT_REJECT_INVITE"
                                                ? print(
                                                    "Notification Seen  EXPERT_LEFT_ROOM & MEMBER_LEFT_ROOM & DELETE_ROOM & EXPERT_ACCEРТ_INVITE & EXPERT_REJECT_INVITE")
                                                : AllNotificationData?.object?[index].subject ==
                                                        "EXPERT_REJECT_INVITE"
                                                    ? print(
                                                        "Seen Notification EXPERT_REJECT_INVITE")
                                                    : AllNotificationData?.object?[index].subject ==
                                                                "LIKE_POST" ||
                                                            AllNotificationData
                                                                    ?.object?[index]
                                                                    .subject ==
                                                                "COMMENT_POST" ||
                                                            AllNotificationData
                                                                    ?.object?[index]
                                                                    .subject ==
                                                                "TAG_COMMENT_POST"
                                                        ? Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                                builder: (context) =>
                                                                    OpenSavePostImage(
                                                                      PostID: AllNotificationData
                                                                          ?.object?[
                                                                              index]
                                                                          .accessCode,
                                                                      index: 0,
                                                                      profileTure: AllNotificationData?.object?[index].subject ==
                                                                                  "COMMENT_POST" ||
                                                                              AllNotificationData?.object?[index].subject ==
                                                                                  "TAG_COMMENT_POST"
                                                                          ? true
                                                                          : false,
                                                                    )),
                                                          )
                                                        // print("opne Save Image screen LIKE_POST & COMMENT_POST & TAG_COMMENT_POST")
                                                        : AllNotificationData?.object?[index].subject == "FOLLOW_PUBLIC_ACCOUNT" ||
                                                                AllNotificationData?.object?[index].subject ==
                                                                    "FOLLOW_PRIVATE_ACCOUNT_REQUEST" ||
                                                                AllNotificationData?.object?[index].subject ==
                                                                    "FOLLOW_REQUEST_ACCEPTED" ||
                                                                AllNotificationData?.object?[index].subject ==
                                                                    "PROFILE_APPROVED" ||
                                                                AllNotificationData
                                                                        ?.object?[index]
                                                                        .subject ==
                                                                    "PROFILE_REJECTED" || AllNotificationData
                                                                        ?.object?[index]
                                                                        .subject == "PROFILE_VIEWED"
                                                            ? Navigator.push(context, MaterialPageRoute(builder: (context) {
                                                                return ProfileScreen(
                                                                    User_ID:
                                                                        "${AllNotificationData?.object?[index].accessCode}",
                                                                    isFollowing:
                                                                        "",ProfileNotification : true);
                                                              }))
                                                            //  print("open User Profile FOLLOW_PUBLIC_ACCOUNT & FOLLOW_PRIVATE_ACCOUNT_REQUEST & FOLLOW_REQUEST_ACCEPTED")
                                                            : print("");


                                    // AllNotificationData?.object?[index].isSeen == true;
                                    BlocProvider.of<InvitationCubit>(context)
                                        .SeenNotification(context,
                                            "${AllNotificationData?.object?[index].postNotificationUid}");
    BlocProvider.of<InvitationCubit>(context).getAllNoticationsCountAPI(context);

                                  },
                                  child: Container(
                                    // height: 90,
                                    // color: const Color.fromARGB(255, 232, 207, 207),
                                    decoration: BoxDecoration(
                                        // color: Colors.green[100],
                                        border: Border.all(
                                            color: const Color(0XFFF1F1F1),
                                            width: 1),
                                        borderRadius: BorderRadius.circular(5)),
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            AllNotificationData
                                                        ?.object?[index].isSeen ==
                                                    false
                                                ? Padding(
                                                    padding: const EdgeInsets.only(
                                                        left: 2, right: 3, top: 5),
                                                    child: Align(
                                                      alignment: Alignment.topLeft,
                                                      child: Container(
                                                        height: 10,
                                                        width: 10,
                                                        decoration: BoxDecoration(
                                                          color: ColorConstant
                                                              .primary_color,
                                                          borderRadius:
                                                              BorderRadius.circular(
                                                                  12),
                                                        ),
                                                      ),
                                                    ),
                                                  )
                                                : Padding(
                                                    padding: const EdgeInsets.only(
                                                        left: 2, right: 3, top: 5),
                                                    child: Align(
                                                      alignment: Alignment.topLeft,
                                                      child: Container(
                                                        height: 10,
                                                        width: 10,
                                                        decoration: BoxDecoration(
                                                          color: Colors.transparent,
                                                          borderRadius:
                                                              BorderRadius.circular(
                                                                  12),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.only(top: 3),
                                              child: Container(
                                                height: 60,
                                                width: 60,
                                                child:  AllNotificationData
                                                                ?.object?[index]
                                                                .image != null ?
                                                                CustomImageView(
                                                                          url: "${AllNotificationData?.object?[index].image}",
                                                                          height: 60,
                                                                          width: 60,
                                                                          fit: BoxFit
                                                                              .fill,
                                                                          radius: BorderRadius
                                                                              .circular(
                                                                                  30),
                                                                        )
                                                               :  AllNotificationData
                                                                ?.object?[index]
                                                                .subject ==
                                                            "TAG_POST" ||
                                                        AllNotificationData
                                                                ?.object?[index]
                                                                .subject ==
                                                            "RE_POST" ||
                                                        AllNotificationData
                                                                ?.object?[index]
                                                                .subject ==
                                                            "INVITE_ROOM" ||
                                                        AllNotificationData
                                                                ?.object?[index]
                                                                .subject ==
                                                            "PROFILE_APPROVED" ||
                                                        AllNotificationData
                                                                ?.object?[index]
                                                                .subject ==
                                                            "PROFILE_REJECTED"
                                                    ? Image.asset(ImageConstant
                                                        .InviteAcceptepLogo)
                                                    : AllNotificationData
                                                                    ?.object?[index]
                                                                    .subject ==
                                                                "EXPERT_LEFT_ROOM" ||
                                                            AllNotificationData
                                                                    ?.object?[index]
                                                                    .subject ==
                                                                "MEMBER_LEFT_ROOM" ||
                                                            AllNotificationData
                                                                    ?.object?[index]
                                                                    .subject ==
                                                                "DELETE_ROOM"
                                                        ? Image.asset(ImageConstant.RoomDeleteLogo)
                                                        : AllNotificationData?.object?[index].subject == "EXPERT_REJECT_INVITE"
                                                            ? Image.asset(ImageConstant.Invite_Rejected)
                                                            : AllNotificationData?.object?[index].subject == "LIKE_POST"
                                                                ? Image.asset(ImageConstant.Like_Post)
                                                                : AllNotificationData?.object?[index].subject == "COMMENT_POST"
                                                                    ? Image.asset(ImageConstant.Comment_Post)
                                                                    : AllNotificationData?.object?[index].subject == "TAG_COMMENT_POST"
                                                                        ? Image.asset(ImageConstant.Tag_Comment_Post)
                                                                        : AllNotificationData?.object?[index].subject == "EXPERT_ACCEРТ_INVITE" || AllNotificationData?.object?[index].subject == "INVITE_EXPERT_ROOM"
                                                                            ? Image.asset(ImageConstant.Expert_Accept_Invite)
                                                                            : AllNotificationData?.object?[index].subject == "EXPERT_REJECT_INVITE"
                                                                                ? Image.asset(ImageConstant.Expert_Reject_Invite)
                                                                                : AllNotificationData?.object?[index].subject == "FOLLOW_PUBLIC_ACCOUNT" || AllNotificationData?.object?[index].subject == "PROFILE_VIEWED"
                                                                                    ? Image.asset(ImageConstant.Follow_Public_Account)
                                                                                    : AllNotificationData?.object?[index].subject == "FOLLOW_PRIVATE_ACCOUNT_REQUEST"
                                                                                        ? Image.asset(ImageConstant.Follow_Private_Account_Request)
                                                                                        : AllNotificationData?.object?[index].subject == "FOLLOW_REQUEST_ACCEPTED"
                                                                                            ? Image.asset(ImageConstant.Follow_Request_Accept)
                                                                                            : SizedBox(),
                                              ),
                                            ),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                SizedBox(
                                                  height: 3,
                                                ),
                                               /*  Text(
                                                  "${AllNotificationData?.object?[index].title}",
                                                  // "${AllNotificationData?.object?[index].title.toString()[0].toUpperCase()}${AllNotificationData?.object?[index].title?.toString().substring(1).toLowerCase()}",
                                                  style: TextStyle(
                                                      fontSize: 17,
                                                      fontFamily: "outfit",
                                                      fontWeight: FontWeight.bold),
                                                ),
                                                SizedBox(
                                                  height: 3,
                                                ), */
                                                Container(
                                                  // color: Colors.green,
                                                  // height: 40,
                                                  width: _width / 1.4,
                                                  child: Text(
                                                    "${AllNotificationData?.object?[index].notificationMessage}",
                                                    // maxLines: 3,
                                                    // overflow: TextOverflow.ellipsis,
                                                    style: TextStyle(
                                                        fontSize: 16,
                                                        fontFamily: "outfit",
                                                        fontWeight:
                                                            FontWeight.w500),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        Padding(
                                            padding: const EdgeInsets.only(
                                                top: 5, bottom: 5, right: 2),
                                            child: Align(
                                              alignment: Alignment.bottomRight,
                                              child: Container(
                                                height: 15,
                                                // width: 130,
                                                // color: Colors.red,
                                                child: Text(
                                                  getTimeDifference(
                                                      parsedDateTime!),
                                                  style: TextStyle(
                                                    fontSize: 12,
                                                    fontFamily: "outfit",
                                                  ),
                                                ),
                                              ),
                                            )),
                                      ],
                                    ),
                                  ),
                                ),
                              )
                            : SizedBox();
                      }),
                ],
              )
              : Center(
                  child: Text(
                    "No New Notification",
                    style: TextStyle(
                      fontFamily: 'outfit',
                      fontSize: 20,
                      color: ColorConstant.primary_color,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                );
    });
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
    AllAPICall();
    // BlocProvider.of<InvitationCubit>(context).RequestListAPI(context);
    super.initState();
  }
    AllAPICall() async {
    await BlocProvider.of<InvitationCubit>(context).seetinonExpried(context);
    
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
                           DateTime? parsedDateTime1;
                    if (widget.requestListModelData?.object?[index].createdAt !=
                        null) {
                      parsedDateTime1 = DateTime.parse(
                          '${widget.requestListModelData?.object?[index].createdAt ?? ""}');
                    }
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
                                                              ColorConstant.primary_color,
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
                                                              color: ColorConstant.primary_color,)),
                                                      child: Center(
                                                          child: Text(
                                                        "Reject",
                                                        style: TextStyle(
                                                            fontFamily:
                                                                'outfit',
                                                            color: ColorConstant.primary_color,),
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
                                                    left: 150),
                                                child: Text(
                                                  getTimeDifference1(
                                                  parsedDateTime1!),
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
                      color: ColorConstant.primary_color,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                );
    });
  }

   String getTimeDifference1(DateTime dateTime) {
    final difference = DateTime.now().difference(dateTime);
    if (difference.inDays > 0) {
      if (difference.inDays == 1) {
        return '1 day ago';
      } else if (difference.inDays < 7) {
        return '${difference.inDays} days ago';
      } else {
        final weeks = (difference.inDays / 7).floor();
        return '$weeks week${weeks == 1 ? '' : 's'} ago';
      }
    } else if (difference.inHours > 0) {
      if (difference.inHours == 1) {
        return '1 hour ago';
      } else {
        return '${difference.inHours} hours ago';
      }
    } else if (difference.inMinutes > 0) {
      if (difference.inMinutes == 1) {
        return '1 minute ago';
      } else {
        return '${difference.inMinutes} minutes ago';
      }
    } else {
      return 'Just now';
    }
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
AllAPICall();
    super.initState();
  }


  AllAPICall() async {
    await BlocProvider.of<InvitationCubit>(context).seetinonExpried(context);
    await BlocProvider.of<InvitationCubit>(context).InvitationAPI(context);
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
                        color: ColorConstant.primary_color,
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
                                        color:   ColorConstant.primary_color,
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
                                                MoveNotification: true,
                                                RoomOwnerCount: 0,
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
                                                color: ColorConstant.primary_color,
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

String customFormat1(DateTime date) {
  String day = date.day.toString();
  String month = _getMonthName1(date.month);
  String year = date.year.toString();
  String time = DateFormat('h:mm a').format(date);

  String formattedDate = '$day$month $year | $time';
  return formattedDate;
}

String _getMonthName1(int month) {
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
