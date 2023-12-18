import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pds/API/Bloc/PersonalChatList_Bloc/PersonalChatList_State.dart';
import 'package:pds/API/Bloc/PersonalChatList_Bloc/PersonalChatList_cubit.dart';
import 'package:pds/API/Model/serchForInboxModel/serchForinboxModel.dart';
import 'package:pds/core/utils/color_constant.dart';
import 'package:pds/core/utils/image_constant.dart';
import 'package:pds/presentation/DMAll_Screen/Dm_Screen.dart';
import 'package:pds/widgets/pagenation.dart';

class InviteMeesage extends StatefulWidget {
  const InviteMeesage({Key? key}) : super(key: key);

  @override
  State<InviteMeesage> createState() => _InviteMeesageState();
}

class _InviteMeesageState extends State<InviteMeesage> {
  TextEditingController searchController = TextEditingController();
  bool isDataGet = false;
  String? UserIndexUUID = "";
  ScrollController scrollController = ScrollController();
  SearchUserForInbox? searchUserForInbox1;

  FocusNode _focusNode = FocusNode();
   @override
  void dispose() {
    searchController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
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
          'Invite Meesage',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: BlocConsumer<PersonalChatListCubit, PersonalChatListState>(
        listener: (context, state) {
          if (state is SearchHistoryDataAddxtends) {
            isDataGet = true;
            searchUserForInbox1 = state.searchUserForInbox;
          }
          if (state is DMChatListLoadedState) {
            print(state.DMChatList.object);
            UserIndexUUID = state.DMChatList.object;
          }
        },
        builder: (context, state) {
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 15, left: 16, right: 16),
                child: Container(
                  height: 48,
                  decoration: BoxDecoration(
                      color: Color(0xffFBD8D9),
                      border: Border.all(
                        color: ColorConstant.primary_color,
                      ),
                      borderRadius: BorderRadius.circular(10)),
                  child: TextFormField(
                       focusNode: _focusNode,
                    onChanged: (value) {
                      print("value check if their-$value");
                      if (value.isNotEmpty) {
                        BlocProvider.of<PersonalChatListCubit>(context)
                            .search_user_for_inbox(
                                context, searchController.text.trim(), '1');
                      } else if (value.isEmpty) {
                        print("Check value-${value}");
                        searchController.clear();
                        setState(() {
                          isDataGet = false;
                        });
                      }
                    },
                    controller: searchController,
                    cursorColor: ColorConstant.primary_color,
                    decoration: InputDecoration(
                        suffixIcon: IconButton(
                            onPressed: () {
                              print("vgfdghdfgh");
                              searchController.clear();
                              setState(() {
                                _focusNode.unfocus();
                                isDataGet = false;
                              });
                              print("dhfdsfbdf-$isDataGet");
                            },
                            icon: Icon(
                              Icons.close,
                              color: Colors.black,
                            )),
                        hintText: "Search....",
                        hintStyle:
                            TextStyle(color: ColorConstant.primary_color),
                        border: InputBorder.none,
                        prefixIcon: Icon(
                          Icons.search,
                          color: ColorConstant.primary_color,
                        )),
                  ),
                ),
              ),
              isDataGet == true ? serInboxdata(width) : SizedBox()
            ],
          );
        },
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
                  }));
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
}
