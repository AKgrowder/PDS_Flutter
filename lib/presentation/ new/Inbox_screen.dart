import 'dart:async';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:pds/API/Bloc/PersonalChatList_Bloc/PersonalChatList_State.dart';
import 'package:pds/API/Bloc/PersonalChatList_Bloc/PersonalChatList_cubit.dart';
import 'package:pds/API/Model/PersonalChatListModel/PersonalChatList_Model.dart';
import 'package:pds/API/Model/serchForInboxModel/serchForinboxModel.dart';
import 'package:pds/core/app_export.dart';
import 'package:pds/core/utils/color_constant.dart';
import 'package:pds/presentation/%20new/SelectChatMember.dart';
import 'package:pds/presentation/%20new/inboxScreenInviteScreen.dart';
import 'package:pds/presentation/DMAll_Screen/Dm_Screen.dart';
import 'package:pds/widgets/pagenation.dart';

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
  FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    BlocProvider.of<PersonalChatListCubit>(context).PersonalChatList(context);
    super.initState();
  }

  @override
  void dispose() {
    searchController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
        resizeToAvoidBottomInset: false,
        floatingActionButton: FloatingActionButton(
            onPressed: () {
              /*           Navigator.push(context,
                                        MaterialPageRoute(builder: (context) {
                                      return MultiBlocProvider(
                                          providers: [
                                            BlocProvider<MyAccountCubit>(
                                              create: (context) =>
                                                  MyAccountCubit(),
                                            ),
                                          ],
                                          child: EditProfileScreen(
                                            newProfileData: NewProfileData,
                                          )); */
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
          if (state is PersonalChatListLoadedState) {
            apiData = true;
            PersonalChatListModelData = state.PersonalChatListModelData;
          }
          if (state is DMChatListLoadedState) {
            print(state.DMChatList.object);
            UserIndexUUID = state.DMChatList.object;
            setState(() {});
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
                                  /*   if (value.isNotEmpty) {
                                    BlocProvider.of<PersonalChatListCubit>(
                                            context)
                                        .search_user_for_inbox(context,
                                            searchController.text.trim(), '1');
                                  } else if (value.isEmpty) {
                                    isDataGet = false;
                                    setState(() {});
                                  } */
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
        }));
  }

  intaldatashow() {
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
              return Slidable(
                enabled: true,
                dragStartBehavior: DragStartBehavior.start,
                endActionPane: ActionPane(
                    extentRatio: 0.2,
                    motion: ScrollMotion(),
                    children: [
                      GestureDetector(
                        onTap: () {
                          print("tap on search Profile");
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
                      )
                    ]),
                child: Padding(
                  padding: const EdgeInsets.only(top: 15),
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
                          UserName:
                              "${PersonalChatListModelData?.object?[index].userName}",
                          ChatInboxUid:
                              "${PersonalChatListModelData?.object?[index].userChatInboxUid}",
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
                                  Positioned(
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
                                      ))
                                ]),
                                Padding(
                                  padding: const EdgeInsets.all(6),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "${PersonalChatListModelData?.object?[index].userName}",
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      PersonalChatListModelData?.object?[index]
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
                                                    fontWeight: FontWeight.w600,
                                                    color: Colors.grey,
                                                  ),
                                                ),
                                              ],
                                            )
                                          : Text(
                                              "${PersonalChatListModelData?.object?[index].message}",
                                              style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.w600,
                                                color: Colors.grey,
                                              ),
                                            )
                                    ],
                                  ),
                                )
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 6),
                              child: Text(
                                customFormat(parsedDateTime),
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.grey,
                                ),
                              ),
                            )
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
        totalSize: searchUserForInbox1?.object?.totalElements,
        offSet: searchUserForInbox1?.object?.pageable?.pageNumber,
        onPagination: (p0) async {
          BlocProvider.of<PersonalChatListCubit>(context)
              .search_user_for_inboxPagantion(
            context,
            searchController.text.trim(),
            '${(p0 + 1)}',
          );
        },
        items: ListView.builder(
          shrinkWrap: true,
          itemCount: searchUserForInbox1?.object?.content?.length,
          padding: EdgeInsets.zero,
          physics: NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                // DMChatListm
                BlocProvider.of<PersonalChatListCubit>(context).DMChatListm(
                    "${searchUserForInbox1?.object?.content?[index].userUid}",
                    context);
                if (UserIndexUUID != "" || UserIndexUUID != null) {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return DmScreen(
                      UserName:
                          "${searchUserForInbox1?.object?.content?[index].userName}",
                      ChatInboxUid: UserIndexUUID ?? "",
                    );
                  })).then((value) => CallBackFunc()
                      /* BlocProvider.of<PersonalChatListCubit>(context)
                          .PersonalChatList(context) */

                      );
                  // UserIndexUUID = "";
                }
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
                    searchUserForInbox1
                                    ?.object?.content?[index].userProfilePic !=
                                null &&
                            searchUserForInbox1?.object?.content?[index]
                                    .userProfilePic?.isNotEmpty ==
                                true
                        ? Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: CircleAvatar(
                              radius: 30.0,
                              backgroundImage: NetworkImage(
                                  "${searchUserForInbox1?.object?.content?[index].userProfilePic}"),
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
                          searchUserForInbox1
                                  ?.object?.content?[index].userName ??
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

    String formattedDate = '$time';
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
