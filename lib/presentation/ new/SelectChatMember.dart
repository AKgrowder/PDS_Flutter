import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pds/API/Bloc/NewProfileScreen_Bloc/NewProfileScreen_cubit.dart';
import 'package:pds/API/Bloc/SelectChat_bloc/SelectChat_cubit.dart';
import 'package:pds/API/Bloc/SelectChat_bloc/SelectChat_state.dart';
import 'package:pds/API/Model/PersonalChatListModel/SelectChatMember_Model.dart';
import 'package:pds/core/utils/color_constant.dart';
import 'package:pds/core/utils/image_constant.dart';
import 'package:pds/presentation/%20new/profileNew.dart';
import 'package:pds/theme/theme_helper.dart';

class SelectChatMember extends StatefulWidget {
  const SelectChatMember();

  @override
  State<SelectChatMember> createState() => _SelectChatMemberState();
}

class _SelectChatMemberState extends State<SelectChatMember> {
  @override
  void initState() {
    BlocProvider.of<SelectChatMemberListCubit>(context)
        .SelectChatMemberList(context);

    super.initState();
  }
    SelectChatMemberModel? SelectChatMemberListModelData;

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    double _height = MediaQuery.of(context).size.height;
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
            "Post Likes",
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontFamily: "outfit",
                fontSize: 20),
          ),
        ),
        body:
            BlocConsumer<SelectChatMemberListCubit, SelectChatMemberListState>(
                listener: (context, state) async {
          if (state is SelectChatMemberListErrorState) {
            /* 
            SnackBar snackBar = SnackBar(
              content: Text(state.error),
              backgroundColor: ColorConstant.primary_color,
            );
            ScaffoldMessenger.of(context).showSnackBar(snackBar); */
          }

          if (state is SelectChatMemberListLoadingState) {
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
          if (state is SelectChatMemberListLoadedState) {
          

            print(state.SelectChatMemberListModelData.message);
            SelectChatMemberListModelData = state.SelectChatMemberListModelData;
          }
        }, builder: (context, state) {
          if (state is SelectChatMemberListLoadedState) {
            return Padding(
                padding: EdgeInsets.only(top: 0),
                child: ListView.separated(
                    itemCount:
                        SelectChatMemberListModelData?.object?.length ?? 0,
                    separatorBuilder: (BuildContext context, int index) =>
                        const Divider(),
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        height: 40,
                        child: ListTile(
                          leading: GestureDetector(
                            onTap: () {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return MultiBlocProvider(
                                    providers: [
                                      BlocProvider<NewProfileSCubit>(
                                        create: (context) => NewProfileSCubit(),
                                      ),
                                    ],
                                    child: ProfileScreen(
                                      User_ID:
                                          "${SelectChatMemberListModelData?.object?[index].userUid}",
                                      isFollowing: "",
                                      // "${SelectChatMemberListModelData?.object?[index].isFollowing}",
                                    ));
                              }));
                            },
                            child: CircleAvatar(
                              backgroundColor: Colors.white,
                              backgroundImage: SelectChatMemberListModelData
                                          ?.object?[index].userProfilePic !=
                                      null
                                  ? NetworkImage(
                                      "${SelectChatMemberListModelData?.object?[index].userProfilePic}")
                                  : NetworkImage(
                                      "https://images.unsplash.com/photo-1494790108377-be9c29b29330?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1974&q=80"),
                              radius: 25,
                            ),
                          ),
                          title: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 6,
                              ),
                              Expanded(
                                child: Text(
                                  "${SelectChatMemberListModelData?.object?[index].userName}",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontFamily: "outfit",
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              // Text(
                              //   customFormat(
                              //       parsedDateTime),
                              //   style: TextStyle(
                              //     fontSize: 12,
                              //     fontFamily: "outfit",
                              //   ),
                              // ),
                            ],
                          ),
                          trailing: /*  User_ID ==
                            GetPostAllLikeRoomData?.object?[index].userUid
                        ? SizedBox()
                        : */
                              GestureDetector(
                            onTap: () {
                              // followFunction(
                              //   apiName: 'Follow',
                              //   index: index,
                              // );
                              print("Chat");
                            },
                            child: Container(
                              height: 25,
                              alignment: Alignment.center,
                              width: 65,
                              margin: EdgeInsets.only(bottom: 5),
                              decoration: BoxDecoration(
                                  color: ColorConstant.primary_color,
                                  borderRadius: BorderRadius.circular(4)),
                              child: Text(
                                'Chat',
                                style: TextStyle(
                                    fontFamily: "outfit",
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                      );
                    }));
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
        }));
  }
}
