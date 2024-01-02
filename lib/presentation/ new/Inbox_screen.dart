import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:pds/API/Bloc/PersonalChatList_Bloc/PersonalChatList_State.dart';
import 'package:pds/API/Bloc/PersonalChatList_Bloc/PersonalChatList_cubit.dart';
import 'package:pds/API/Model/GetUsersChatByUsernameModel/GetUsersChatByUsernameModel.dart';
import 'package:pds/API/Model/PersonalChatListModel/PersonalChatList_Model.dart';
import 'package:pds/API/Model/serchForInboxModel/serchForinboxModel.dart';
import 'package:pds/core/app_export.dart';
import 'package:pds/core/utils/color_constant.dart';
import 'package:pds/core/utils/sharedPreferences.dart';
import 'package:pds/presentation/%20new/SelectChatMember.dart';
import 'package:pds/presentation/%20new/inboxScreenInviteScreen.dart';
import 'package:pds/presentation/DMAll_Screen/Dm_Screen.dart';
import 'package:pds/widgets/pagenation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'newbottembar.dart';

class InboxScreen extends StatefulWidget {
  const InboxScreen({Key? key}) : super(key: key);

  @override
  State<InboxScreen> createState() => _InboxScreenState();
}

class _InboxScreenState extends State<InboxScreen> {
  PersonalChatListModel? PersonalChatListModelData;
  String formattedDate = DateFormat('dd-MM-yyyy').format(DateTime.now());
  bool isDataGet = false;
  SearchUserForInbox? searchUserForInbox1;
  ScrollController scrollController = ScrollController();
  String? UserIndexUUID = "";
  bool apiData = false;
  int Index = 0;
  FocusNode _focusNode = FocusNode();
  GetUsersChatByUsername? getUsersChatByUsername;
  String? userID;
  TextEditingController searchController = TextEditingController();
  @override
  void initState() {
    getDocumentSize();
    BlocProvider.of<PersonalChatListCubit>(context).PersonalChatList(context);
    BlocProvider.of<PersonalChatListCubit>(context)
        .getAllNoticationsCountAPI(context);

        
    super.initState();
  }

  getDocumentSize() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    userID = prefs.getString(PreferencesKey.loginUserID);
    print("userid-chelc-${userID}");
    setState(() {});
  }

  @override
  void dispose() {
    searchController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  Future<bool> isMethod() async {
    if (isDataGet == false) {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => NewBottomBar(buttomIndex: 0)),
          (Route<dynamic> route) => false);
      return true;
    } else {
      isDataGet = false;
      searchController.clear();
      setState(() {});
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return WillPopScope(
      onWillPop: isMethod,
      child: Scaffold(
          resizeToAvoidBottomInset: false,
          floatingActionButton: FloatingActionButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return MultiBlocProvider(
                    providers: [
                      BlocProvider<PersonalChatListCubit>(
                        create: (context) => PersonalChatListCubit(),
                      ),
                    ],
                    child: InviteMeesage(),
                  );
                })).then((value) =>
                    BlocProvider.of<PersonalChatListCubit>(context)
                        .PersonalChatList(context));
              },
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: ColorConstant.primary_color,
                ),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Image.asset(ImageConstant.addIcon),
                  ),
                ),
              )),
          body: BlocConsumer<PersonalChatListCubit, PersonalChatListState>(
              listener: (context, state) async {
            if (state is PersonalChatListErrorState) {
              SnackBar snackBar = SnackBar(
                content: Text(state.error),
                backgroundColor: ColorConstant.primary_color,
              );
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            }
            if (state is SearchHistoryDataAddxtends) {
              isDataGet = true;
              searchUserForInbox1 = state.searchUserForInbox;
            }
            if (state is GetNotificationCountLoadedState) {
              print(state.GetNotificationCountData.object);
              saveNotificationCount(state.GetNotificationCountData.object?.notificationCount ?? 0,state.GetNotificationCountData.object?.messageCount ?? 0);
            }
            if (state is PersonalChatListLoadedState) {
              apiData = true;
              PersonalChatListModelData = state.PersonalChatListModelData;
            }
            if (state is DMChatListLoadedState) {
              print(state.DMChatList.object);
              UserIndexUUID = state.DMChatList.object;

              if (UserIndexUUID != "" || UserIndexUUID != null) {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return DmScreen(
                     UserUID:
                          "${getUsersChatByUsername?.object?.content?[Index].userUuid}",
                      UserName:
                          "${getUsersChatByUsername?.object?.content?[Index].username}",
                      ChatInboxUid: UserIndexUUID ?? "",
                      UserImage:
                          "${getUsersChatByUsername?.object?.content?[Index].userProfilePic}");
                })).then((value) => CallBackFunc()
                    /* BlocProvider.of<PersonalChatListCubit>(context)
                          .PersonalChatList(context) */

                    );
                // UserIndexUUID = "";
              }

              setState(() {});
            }
            if (state is UserChatDeleteLoaded) {
              print(state.DeleteUserChatData.object);
              SnackBar snackBar = SnackBar(
                content: Text(state.DeleteUserChatData.object.toString()),
                backgroundColor: ColorConstant.primary_color,
              );
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
              if (state.DeleteUserChatData.object ==
                  "Chat Deleted Successfully") {
                setState(() {
                  BlocProvider.of<PersonalChatListCubit>(context)
                      .PersonalChatList(context);
                });
              }
            }
            if (state is PersonalChatListLoadingState) {
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

            if (state is GetUsersChatByUsernameLoaded) {
              isDataGet = true;
              getUsersChatByUsername = state.getUsersChatByUsername;
              if (getUsersChatByUsername?.object?.content?.isNotEmpty == true) {
                getUsersChatByUsername?.object?.content?.forEach((element) {
                  if (userID == element.userUuid) {
                    getUsersChatByUsername?.object?.content?.remove(element);
                  }
                });
              }
            }
          }, builder: (context, state) {
            return apiData == true
                ? Container(
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 15, right: 15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: height * 0.06,
                            ),
                            Text(
                              "Inbox",
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.w600,
                                color: Colors.black,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 15),
                              child: Container(
                                height: 48,
                                decoration: BoxDecoration(
                                    color: Color(0xffFBD8D9),
                                    border: Border.all(
                                      color: ColorConstant.primary_color,
                                    ),
                                    borderRadius: BorderRadius.circular(10)),
                                child: TextFormField(
                                  onChanged: (value) {
                                    if (value.isNotEmpty) {
                                      BlocProvider.of<PersonalChatListCubit>(
                                              context)
                                          .get_UsersChatByUsernameMethod(
                                        searchController.text.trim(),
                                        '1',
                                        context,
                                      );
                                    } else if (value.isEmpty) {
                                      isDataGet = false;
                                      setState(() {});
                                    }
                                  },
                                  focusNode: _focusNode,
                                  controller: searchController,
                                  cursorColor: ColorConstant.primary_color,
                                  decoration: InputDecoration(
                                      suffixIcon: IconButton(
                                          onPressed: () {
                                            searchController.clear();
                                            isDataGet = false;
                                            _focusNode.unfocus();
                                            setState(() {});
                                          },
                                          icon: Icon(
                                            Icons.close,
                                            color: Colors.black,
                                          )),
                                      hintText: "Search....",
                                      hintStyle: TextStyle(
                                          color: ColorConstant.primary_color),
                                      border: InputBorder.none,
                                      prefixIcon: Icon(
                                        Icons.search,
                                        color: ColorConstant.primary_color,
                                      )),
                                ),
                              ),
                            ),
                            isDataGet == true
                                ? serInboxdata(width)
                                : intaldatashow(),
                          ],
                        ),
                      ),
                    ),
                  )
                : Center(
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

  saveNotificationCount(int NotificationCount,int MessageCount) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt(PreferencesKey.NotificationCount, NotificationCount);
    prefs.setInt(PreferencesKey.MessageCount, MessageCount);
  }

  intaldatashow() {
    var _height = MediaQuery.of(context).size.height;
    var _width = MediaQuery.of(context).size.width;
    return Expanded(
      child: SingleChildScrollView(
        child: ListView.builder(
            shrinkWrap: true,
            padding: EdgeInsets.zero,
            physics: NeverScrollableScrollPhysics(),
            itemCount: PersonalChatListModelData?.object?.length,
            itemBuilder: (context, index) {
              DateTime parsedDateTime = DateTime.parse(
                  '${PersonalChatListModelData?.object?[index].createdDate ?? ""}');
              return Padding(
                padding: const EdgeInsets.only(top: 15),
                child: Slidable(
                  enabled: true,
                  dragStartBehavior: DragStartBehavior.start,
                  endActionPane: ActionPane(
                      // dragDismissible: true,
                      extentRatio: 0.2,
                      motion: ScrollMotion(),
                      // dismissible: DismissiblePane(onDismissed: () {
                      //   setState(() {
                      //     BlocProvider.of<PersonalChatListCubit>(context)
                      //         .UserChatDelete(
                      //             "${PersonalChatListModelData?.object?[index].userChatInboxUid}",
                      //             context);
                      //   });
                      //   print("tap on Delete icon 2");
                      // }),
                      children: [
                        SlidableAction(
                          borderRadius: BorderRadius.circular(10),
                          onPressed: (context) {
                            setState(() {
                              BlocProvider.of<PersonalChatListCubit>(context)
                                  .UserChatDelete(
                                      "${PersonalChatListModelData?.object?[index].userChatInboxUid}",
                                      context);
                            });
                            print("tap on Delete icon 1");
                          },
                          backgroundColor: Colors.transparent,
                          foregroundColor: ColorConstant.primary_color,
                          icon: Icons.delete,
                          // label: '',
                        ),
                        /*  GestureDetector(
                          onTap: () {
                            setState(() {
                              BlocProvider.of<PersonalChatListCubit>(context)
                                  .UserChatDelete(
                                      "${PersonalChatListModelData?.object?[index].userChatInboxUid}",
                                      context);
                            });
                            print("tap on Delete icon 1");
                          },
                          child: Container(
                            margin: EdgeInsets.only(left: 20, top: 5),
                            height: 50,
                            width: 50,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle, color: Color(0xffFBD8D9)),
                            child: Center(
                                child: Padding(
                              padding: const EdgeInsets.all(15),
                              child: Image.asset(
                                ImageConstant.deleteIcon,
                                color: ColorConstant.primary_color,
                              ),
                            )),
                          ),
                        ) */
                      ]),
                  child: GestureDetector(
                    onTap: () {
                      /* Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return DM_InboxScreen(
                          UserName:
                              "${PersonalChatListModelData?.object?[index].userName}",
                          ChatInboxUid:
                              "${PersonalChatListModelData?.object?[index].userChatInboxUid}",
                        );
                      })); */
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return DmScreen(
                          
                          UserUID:
                              "${PersonalChatListModelData?.object?[index].userUid}",
                          UserName:
                              "${PersonalChatListModelData?.object?[index].userName}",
                          ChatInboxUid:
                              "${PersonalChatListModelData?.object?[index].userChatInboxUid}",
                          UserImage:
                              "${PersonalChatListModelData?.object?[index].userProfilePic}",
                          // UserUID: "${PersonalChatListModelData?.object?[index].}",
                        );
                      })).then((value) =>
                          BlocProvider.of<PersonalChatListCubit>(context)
                              .PersonalChatList(context));
                    },
                    child: Container(
                      height: 80,
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey.shade400),
                          borderRadius: BorderRadius.circular(10)),
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Stack(children: [
                                  Container(
                                      height: 55,
                                      width: 55,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                      ),
                                      child: PersonalChatListModelData
                                                      ?.object?[index]
                                                      .userProfilePic !=
                                                  null &&
                                              PersonalChatListModelData
                                                      ?.object?[index]
                                                      .userProfilePic !=
                                                  ""
                                          ? CustomImageView(
                                              url:
                                                  "${PersonalChatListModelData?.object?[index].userProfilePic}",
                                              height: 60,
                                              width: 60,
                                              fit: BoxFit.cover,
                                              radius: BorderRadius.circular(30),
                                            )
                                          : CustomImageView(
                                              imagePath:
                                                  ImageConstant.tomcruse)),
                                  /* Positioned(
                                      bottom: 1,
                                      right: 5,
                                      child: Container(
                                        height: 12,
                                        width: 12,
                                        decoration: BoxDecoration(
                                            color: ColorConstant.primary_color,
                                            shape: BoxShape.circle,
                                            border: Border.all(
                                                color: Colors.white, width: 2)),
                                      )) */
                                ]),
                                Padding(
                                  padding: EdgeInsets.only(
                                    top: 8,
                                    left: 8,
                                  ),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        width: _width / 1.4,
                                        child: Row(
                                          children: [
                                            Text(
                                              "${PersonalChatListModelData?.object?[index].userName ?? ""}",
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                            Spacer(),
                                            Text(
                                              getTimeDifference(parsedDateTime),
                                              style: TextStyle(
                                                fontSize: 11,
                                                fontWeight: FontWeight.w400,
                                                color: Colors.grey,
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(bottom: 7),
                                        child: Container(
                                          width: _width / 1.7,
                                          height: 20,
                                          child: PersonalChatListModelData
                                                      ?.object?[index]
                                                      .messageType ==
                                                  "IMAGE"
                                              ? Row(
                                                  children: [
                                                    CustomImageView(
                                                        height: 19,
                                                        width: 19,
                                                        imagePath: ImageConstant
                                                            .ChatimageIcon),
                                                    SizedBox(
                                                      width: 7,
                                                    ),
                                                    Text(
                                                      "Photo",
                                                      style: TextStyle(
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        color: Colors.grey,
                                                      ),
                                                    ),
                                                  ],
                                                )
                                              : Text(
                                                  "${PersonalChatListModelData?.object?[index].message}",
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.w600,
                                                    color: Colors.grey,
                                                  ),
                                                ),
                                        ),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              );
            }),
      ),
    );
  }

  serInboxdata(width) {
    return Expanded(
        child: SingleChildScrollView(
      controller: scrollController,
      child: PaginationWidget(
        scrollController: scrollController,
        totalSize: getUsersChatByUsername?.object?.totalElements,
        offSet: getUsersChatByUsername?.object?.pageable?.pageNumber,
        onPagination: (p0) async {
          BlocProvider.of<PersonalChatListCubit>(context)
              .get_UsersChatByUsernamePagantion(
            searchController.text.trim(),
            '${(p0 + 1)}',
            context,
          );
        },
        items: ListView.builder(
          shrinkWrap: true,
          itemCount: getUsersChatByUsername?.object?.content?.length,
          padding: EdgeInsets.zero,
          physics: NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                // DMChatListm
                print(
                    "${getUsersChatByUsername?.object?.content?[index].userUuid}");
                print(
                    "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++");
                Index = index;
                BlocProvider.of<PersonalChatListCubit>(context).DMChatListm(
                    "${getUsersChatByUsername?.object?.content?[index].userUuid}",
                    context);
                /* if (UserIndexUUID != "" || UserIndexUUID != null) {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return DmScreen(
                      UserName:
                          "${searchUserForInbox1?.object?.content?[index].userName}",
                      ChatInboxUid: UserIndexUUID ?? "",
                      UserImage : ""
                    );
                  })).then((value) => CallBackFunc()
                      /* BlocProvider.of<PersonalChatListCubit>(context)
                          .PersonalChatList(context) */

                      );
                  // UserIndexUUID = "";
                } */
              },
              child: Container(
                margin: EdgeInsets.all(10),
                height: 70,
                width: 110,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Color(0xffE6E6E6))),
                child: Row(
                  children: [
                    getUsersChatByUsername
                                    ?.object?.content?[index].userProfilePic !=
                                null &&
                            getUsersChatByUsername?.object?.content?[index]
                                    .userProfilePic?.isNotEmpty ==
                                true
                        ? Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: CircleAvatar(
                              radius: 30.0,
                              backgroundImage: NetworkImage(
                                  "${getUsersChatByUsername?.object?.content?[index].userProfilePic}"),
                              backgroundColor: Colors.transparent,
                            ),
                          )
                        : Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: CircleAvatar(
                              radius: 30.0,
                              backgroundImage:
                                  AssetImage(ImageConstant.tomcruse),
                              backgroundColor: Colors.transparent,
                            ),
                          ),
                    Container(
                      width: width / 1.6,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Text(
                          getUsersChatByUsername
                                  ?.object?.content?[index].username ??
                              '',
                          style: TextStyle(
                            overflow: TextOverflow.ellipsis,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            );
          },
        ),
      ),
    ));
  }

  CallBackFunc() {
    // UserIndexUUID = "";
    BlocProvider.of<PersonalChatListCubit>(context).PersonalChatList(context);
  }

  String customFormat(DateTime date) {
    String day = date.day.toString();
    String month = _getMonthName(date.month);
    String year = date.year.toString();
    String time = DateFormat('h:mm a').format(date);
    String WeekDay = DateFormat('EEEE').format(date);
    String formattedDate = '$day$month $time';
    return formattedDate;
  }

  String _getMonthName(int month) {
    switch (month) {
      case 1:
        return ' th January';
      case 2:
        return 'th February';
      case 3:
        return 'th March';
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
}

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

class InboxScreen1 extends StatelessWidget {
  const InboxScreen1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const SelectChatMember()),
            );
          },
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: ColorConstant.primary_color,
            ),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Image.asset(ImageConstant.addIcon),
              ),
            ),
          )),
    );
  }
}
