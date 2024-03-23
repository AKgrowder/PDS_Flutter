import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pds/API/Bloc/BlockUser_Bloc/Block_user_state.dart';
import 'package:pds/core/app_export.dart';
import 'package:pds/presentation/%20new/profileNew.dart';
import 'package:pds/widgets/UnBlocked_dailog.dart';

import '../../API/Bloc/BlockUser_Bloc/Block_user_cubit.dart';
import '../../API/Model/BlockeUserModel/BlockUser_list_model.dart';
import '../../core/utils/color_constant.dart';

class BlockedUserScreen extends StatefulWidget {
  const BlockedUserScreen({Key? key}) : super(key: key);

  @override
  State<BlockedUserScreen> createState() => _BlockedUserScreenState();
}

class _BlockedUserScreenState extends State<BlockedUserScreen> {
  BlockUserListModel? blockUserListModel;
  void initState() {
    super.initState();

    BlocProvider.of<BlockUserCubit>(context).BlockUserListAPI(context);
  }

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    double _height = MediaQuery.of(context).size.height;
    return Scaffold(
        appBar: AppBar(
          leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              Icons.arrow_back,
              color: Colors.grey,
            ),
          ),
          elevation: 0,
          backgroundColor: Colors.transparent,
          title: Text(
            "Block",
            style: TextStyle(
              // fontFamily: 'outfit',
              color: Colors.black, fontWeight: FontWeight.bold,
              fontSize: 25,
            ),
          ),
          centerTitle: true,
        ),
        body: BlocConsumer<BlockUserCubit, BlockUserState>(
          listener: (context, state) {
            if (state is BlockUserErrorState) {
              SnackBar snackBar = SnackBar(
                content: Text(state.error),
                backgroundColor: ColorConstant.primary_color,
              );
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            }
            if (state is BlockUserListLoadedState) {
              blockUserListModel = state.blockUserListModel;
            }
          },
          builder: (context, state) {
            if (state is BlockUserLoadingState) {
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
            }
            return blockUserListModel?.object?.isEmpty ?? true
                ? Center(
                    child: Image.asset(
                    ImageConstant.no_blocked_user,
                    height: _height / 3,
                  ))
                : ListView.builder(
                    itemCount: blockUserListModel?.object?.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.only(left: 15,right: 15,bottom: 10),
                        child: Container(
                          height: 70,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10, right: 15),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                         SnackBar snackBar = SnackBar(
                                          content:
                                              Text('User Blocked.'),
                                          backgroundColor:
                                              ColorConstant.primary_color,
                                        );
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(snackBar);
                                      },
                                      child: blockUserListModel?.object?[index]
                                                  .userProfilePic !=
                                              null
                                          ? CustomImageView(
                                              url:
                                                  "${blockUserListModel?.object?[index].userProfilePic}",
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
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 15, bottom: 15, left: 10),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Flexible(
                                            child: Container(
                                              width: _width / 2.5,
                                              child: Text(
                                                "${blockUserListModel?.object?[index].name}",
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w600,
                                                  color: Colors.black,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Flexible(
                                            child: Container(
                                              width: _width / 2.5,
                                              child: Text(
                                                "@${blockUserListModel?.object?[index].userName}",
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w400,
                                                  color: Colors.black,
                                                ),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                GestureDetector(
                                  onTap: () {
                                    showDialog(
                                      context: context,
                                      builder: (_) => UnBlockUserdailog(
                                        blockUserID: blockUserListModel
                                            ?.object?[index].userUid,
                                        userName: blockUserListModel
                                            ?.object?[index].userName,
                                      ),
                                    );
                                  },
                                  child: Container(
                                    width: 90,
                                    height: 30,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      color: ColorConstant.primary_color,
                                    ),
                                    child: Center(
                                      child: Text("Unblock",
                                          textScaleFactor: 1.0,
                                          style: TextStyle(
                                              fontFamily: 'outfit',
                                              fontSize: 16,
                                              color: Colors.white,
                                              fontWeight: FontWeight.w600)),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  );
          },
        ));
  }
}
