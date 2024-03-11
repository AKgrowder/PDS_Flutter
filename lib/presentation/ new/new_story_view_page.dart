import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:pds/API/Bloc/GuestAllPost_Bloc/GuestAllPost_cubit.dart';
import 'package:pds/API/Bloc/NewProfileScreen_Bloc/NewProfileScreen_cubit.dart';
import 'package:pds/API/Bloc/viewStory_Bloc/viewStory_cubit.dart';
import 'package:pds/API/Bloc/viewStory_Bloc/viewStory_state.dart';
import 'package:pds/API/Model/ViewStoryModel/StoryViewList_Model.dart';
import 'package:pds/StoryFile/controller/story_controller.dart';
import 'package:pds/StoryFile/src/story_button.dart';
import 'package:pds/StoryFile/widgets/story_view.dart';
import 'package:pds/core/utils/color_constant.dart';
import 'package:pds/core/utils/image_constant.dart';
import 'package:pds/core/utils/sharedPreferences.dart';
import 'package:pds/presentation/%20new/newbottembar.dart';
import 'package:pds/presentation/%20new/profileNew.dart';
import 'package:pds/widgets/custom_image_view.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NewStoryViewPage extends StatefulWidget {
  final StoryButtonData data;
  final List<StoryButtonData> datas;
  final int index;
  final String userId;
  const NewStoryViewPage(this.data,this.datas,this.index,this.userId,{key});

  @override
  State<NewStoryViewPage> createState() => _NewStoryViewPageState();
}

class _NewStoryViewPageState extends State<NewStoryViewPage> {
  final StoryController controller = StoryController();


  StoryViewListModel? StoryViewListModelData;



  @override
  Widget build(BuildContext context) {
    return BlocListener<ViewStoryCubit, ViewStoryState>(
      listener: (context, state) async {
        if (state is ViewStoryErrorState) {
          SnackBar snackBar = SnackBar(
            content: Text(state.error),
            backgroundColor: ColorConstant.primary_color,
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }

        if (state is ViewStoryLoadingState) {
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
        if (state is ViewStoryLoadedState) {
          if (controller != null) {
            controller!.dispose();
          }
        }
        if (state is StoryViewListLoadedState) {
          StoryViewListModelData = state.StoryViewListModelData;
        }
        if (state is DeleteSotryLodedState) {

          SnackBar snackBar = SnackBar(
            content: Text(state.deleteStory.object.toString()),
            backgroundColor: ColorConstant.primary_color,
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(
                  builder: (context) => NewBottomBar(
                    buttomIndex: 0,
                  )),
                  (Route<dynamic> route) => false);
        }
      },
  child: Column(
      children: [
        Expanded(child: StoryView(
          controller: controller,
          userId: widget.userId,
          buttonData: widget.data,
          storyItems: List.generate(widget.data.images.length, (index) {
            print  ("story view count : ${widget.data.images[index].storyViewCount!}");

            return widget.data.images[index].image!.endsWith(".mp4") ? StoryItem.pageVideo(widget.data.images[index].image!,controller: controller,duration:Duration(seconds: widget.data.images[index].duration!),views: widget.data.images[index].userUid == widget.userId ? widget.data.images[index].storyViewCount ?? 0:-1,index: index,caption:
            Material(
              color: Colors.transparent,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 15.0,
                  vertical: 10.0,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      children: [
                        Expanded(
                            child: SizedBox(
                              child: Row(
                                children: [
                                  GestureDetector(
                                    onTap: () async{
                                      await BlocProvider.of<GetGuestAllPostCubit>(
                                          context)
                                          .seetinonExpried(context);
                                      Navigator.pushAndRemoveUntil(context,
                                        MaterialPageRoute(builder: (context) {
                                          return ProfileScreen(
                                              Screen: 'Proifile',
                                              User_ID: "${widget.data.images[index].userUid}",
                                              isFollowing: "");
                                        }),(route) => false,);
                                    },
                                    child: widget.data.images[index].profileImage != null &&
                                        widget.data.images[index].profileImage != ""
                                        ? CustomImageView(
                                      url:
                                      "${widget.data.images[index].profileImage}",
                                      height: 32,
                                      width: 32,
                                      fit: BoxFit.fill,
                                      radius: BorderRadius.circular(25),
                                    )
                                        : CustomImageView(
                                      imagePath: ImageConstant.tomcruse,
                                      height: 32,
                                      width: 32,
                                      fit: BoxFit.fill,
                                      radius: BorderRadius.circular(25),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 12,
                                  ),
                                  GestureDetector(
                                    onTap: () async{
                                      await BlocProvider.of<GetGuestAllPostCubit>(
                                          context)
                                          .seetinonExpried(context);
                                      Navigator.pushAndRemoveUntil(context,
                                        MaterialPageRoute(builder: (context) {
                                          return ProfileScreen(
                                              Screen: 'Proifile',
                                              User_ID: "${widget.data.images[index].userUid}",
                                              isFollowing: "");
                                        }),(route) => false,);
                                    },
                                    child: Text(
                                      '${widget.data.images[index].username}',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontFamily: 'outfit',
                                        fontWeight: FontWeight.w400,
                                        height: 0.08,
                                        letterSpacing: -0.17,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 8,
                                  ),
                                  Opacity(
                                    opacity: 0.50,
                                    child: Text(
                                      '${formatDateTime(DateTime.parse(widget.data.images[index].date!))}',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 14,
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.w400,
                                        height: 0.08,
                                        letterSpacing: -0.17,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            )),
                      ],
                    ),
                  ],
                ),
              ),
            ),onTap: ()async{
              BlocProvider.of<ViewStoryCubit>(
                  context)
                  .StoryViewList(context,
                  "${widget.data.images[index].storyUid}");
              controller.pause();
              showBs(context,widget.data.images[index].storyUid!,widget.data.images[index].userUid!);
            }
            ):StoryItem.pageImage(url:widget.data.images[index].image!,controller: controller,views: widget.data.images[index].userUid == widget.userId ? widget.data.images[index].storyViewCount!:-1,index: index,onTap: ()async{
              controller.pause();
              BlocProvider.of<ViewStoryCubit>(
                  context)
                  .StoryViewList(context,
                  "${widget.data.images[index].storyUid}");
              showBs(context,widget.data.images[index].storyUid!,widget.data.images[index].userUid!);
            },caption: Material(
              color: Colors.transparent,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 15.0,
                  vertical: 10.0,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      children: [
                        Expanded(
                            child: SizedBox(
                              child: Row(
                                children: [
                                  GestureDetector(
                                    onTap: () async{
                                      await BlocProvider.of<GetGuestAllPostCubit>(
                                          context)
                                          .seetinonExpried(context);
                                      Navigator.pushAndRemoveUntil(context,
                                        MaterialPageRoute(builder: (context) {
                                          return ProfileScreen(
                                              Screen: 'Proifile',
                                              User_ID: "${widget.data.images[index].userUid}",
                                              isFollowing: "");
                                        }),(route) => false,);
                                    },
                                    child: widget.data.images[index].profileImage != null &&
                                        widget.data.images[index].profileImage != ""
                                        ? CustomImageView(
                                      url:
                                      "${widget.data.images[index].profileImage}",
                                      height: 32,
                                      width: 32,
                                      fit: BoxFit.fill,
                                      radius: BorderRadius.circular(25),
                                    )
                                        : CustomImageView(
                                      imagePath: ImageConstant.tomcruse,
                                      height: 32,
                                      width: 32,
                                      fit: BoxFit.fill,
                                      radius: BorderRadius.circular(25),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 12,
                                  ),
                                  GestureDetector(
                                    onTap: () async{
                                      await BlocProvider.of<GetGuestAllPostCubit>(
                                          context)
                                          .seetinonExpried(context);
                                      Navigator.pushAndRemoveUntil(context,
                                        MaterialPageRoute(builder: (context) {
                                          return ProfileScreen(
                                              Screen: 'Proifile',
                                              User_ID: "${widget.data.images[index].userUid}",
                                              isFollowing: "");
                                        }),(route) => false,);
                                    },
                                    child: Text(
                                      '${widget.data.images[index].username}',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontFamily: 'outfit',
                                        fontWeight: FontWeight.w400,
                                        height: 0.08,
                                        letterSpacing: -0.17,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 8,
                                  ),
                                  Opacity(
                                    opacity: 0.50,
                                    child: Text(
                                      '${formatDateTime(DateTime.parse(widget.data.images[index].date!))}',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 14,
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.w400,
                                        height: 0.08,
                                        letterSpacing: -0.17,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            )),
                      ],
                    ),
                  ],
                ),
              ),
            ));
          }),
          onStoryShow: (storyItem, index) {
            print("Showing a story");
          },
          onComplete: () {
            print("current index : ${widget.index}");
            if(widget.index + 1 < widget.datas.length && widget.userId != widget.datas[widget.index].images[0].userUid ) {
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
                return NewStoryViewPage(widget.datas[widget.index + 1], widget.datas, widget.index + 1,widget.userId);
              }));
            }else{
              Navigator.pop(context);
            }
          },
          progressPosition: ProgressPosition.top,
          repeat: false,
        ))
      ],
    ),
);
  }

  String formatDateTime(DateTime dateTime) {
    final now = DateTime.now();
    final yesterday = now.subtract(Duration(days: 1));
    final formatter = DateFormat('h:mm a');

    if (dateTime.year == now.year &&
        dateTime.month == now.month &&
        dateTime.day == now.day) {
      // Today
      return 'Today, ${formatter.format(dateTime)}';
    } else if (dateTime.year == yesterday.year &&
        dateTime.month == yesterday.month &&
        dateTime.day == yesterday.day) {
      // Yesterday
      return 'Yesterday, ${formatter.format(dateTime)}';
    } else {
      // A different day, you can format it as you wish
      return '${DateFormat('MMMM d').format(dateTime)}, ${formatter.format(dateTime)}';
    }
  }

  showBs(BuildContext context,String storyUid, String uid) {
    var _height = MediaQuery
        .of(context)
        .size
        .height;
    var _width = MediaQuery
        .of(context)
        .size
        .width;
    showModalBottomSheet(
        isScrollControlled: true,
        useSafeArea: true,
        isDismissible: true,
        showDragHandle: false,
        enableDrag: true,
        context: context,
        builder: (context) {
          return StatefulBuilder(builder:
              (BuildContext context,
              StateSetter setState) {
            return BlocConsumer<ViewStoryCubit,
                ViewStoryState>(
              listener: (context, state) {
                if (state is PostLikeLoadedState) {
                  print(
                      "check State-${state.likePost.message.toString()}");
                  BlocProvider.of<ViewStoryCubit>(
                      context)
                      .StoryViewList(context,
                      "${storyUid}");
                } else if (state is StoryViewListLoadedState) {
                  StoryViewListModelData = state.StoryViewListModelData;
                }
              },
              builder: (context, state) {
                return Column(
                  children: [
                    SizedBox(
                      height: 30,
                    ),
                    Container(
                      width: _width,
                      child: Row(
                        children: [
                          SizedBox(
                            width: _width / 2.3,
                          ),
                          // Spacer(),
                          Container(
                            height: 2,
                            width: 50,
                            alignment:
                            Alignment.center,
                            padding:
                            EdgeInsets.all(8.0),
                            decoration: BoxDecoration(
                              color: Colors.grey,
                            ),
                          ),
                          Spacer(),
                          GestureDetector(
                            onTap: () async {
                              await BlocProvider.of<
                                  ViewStoryCubit>(
                                  context)
                                  .delete_story(
                                  context,
                                  "${storyUid}");
                            },
                            child: Icon(
                              Icons.delete,
                              color: ColorConstant
                                  .primary_color,
                            ),
                          ),
                          SizedBox(
                            width: 30,
                          )
                        ],
                      ),
                    ),
                    Expanded(
                      child: ListView.separated(
                          shrinkWrap: true,
                          primary: true,
                          itemCount:
                          StoryViewListModelData
                              ?.object?.length ??
                              0,
                          separatorBuilder:
                              (BuildContext context,
                              int index) =>
                          const Divider(),
                          itemBuilder:
                              (BuildContext context,
                              int index) {
                            return Container(
                              // height: 40,
                              width: _width,
                              // color: Colors.green,
                              child: ListTile(
                                leading:
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder:
                                                (context) {
                                              return MultiBlocProvider(
                                                  providers: [
                                                    BlocProvider<
                                                        NewProfileSCubit>(
                                                      create: (context) =>
                                                          NewProfileSCubit(),
                                                    ),
                                                  ],
                                                  child:
                                                  ProfileScreen(
                                                    User_ID:
                                                    "${StoryViewListModelData?.object?[index].userUid}",
                                                    isFollowing:
                                                    "${StoryViewListModelData?.object?[index].isFollowing}",
                                                  ));
                                            }));

                                    // Navigator.push(
                                    //     context,
                                    //     MaterialPageRoute(
                                    //         builder: (context) =>
                                    //             ProfileScreen(
                                    //               User_ID:
                                    //                   "${StoryViewListModelData?.object?[index].userUid}",
                                    //               isFollowing:
                                    //                   "${StoryViewListModelData?.object?[index].isFollowing}",
                                    //             )));
                                  },
                                  child: StoryViewListModelData
                                      ?.object?[
                                  index]
                                      .profilePic !=
                                      null &&
                                      StoryViewListModelData
                                          ?.object?[
                                      index]
                                          .profilePic !=
                                          ""
                                      ? CircleAvatar(
                                    backgroundColor:
                                    Colors
                                        .white,
                                    backgroundImage:
                                    NetworkImage(
                                        "${StoryViewListModelData?.object?[index].profilePic}"),
                                    radius: 25,
                                  )
                                      : CustomImageView(
                                      imagePath:
                                      (ImageConstant
                                          .tomcruse)),
                                ),
                                title: Column(
                                  crossAxisAlignment:
                                  CrossAxisAlignment
                                      .start,
                                  children: [
                                    SizedBox(
                                      height: 6,
                                    ),
                                    Container(
                                      // color: Colors.amber,
                                      child: Text(
                                        "${StoryViewListModelData?.object?[index].userName}",
                                        style: TextStyle(
                                            fontSize:
                                            20,
                                            fontFamily:
                                            "outfit",
                                            fontWeight:
                                            FontWeight
                                                .bold),
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
                                trailing: widget.userId != uid
                                    ? SizedBox()
                                    : GestureDetector(
                                  onTap:
                                      () async {
                                    BlocProvider.of<ViewStoryCubit>(context).followWIngMethodd(
                                        StoryViewListModelData
                                            ?.object?[index]
                                            .userUid,
                                        context);
                                  },
                                  child:
                                  Container(
                                    height: 25,
                                    alignment:
                                    Alignment
                                        .center,
                                    width: 65,
                                    margin: EdgeInsets.only(
                                        bottom:
                                        5),
                                    decoration: BoxDecoration(
                                        color: ColorConstant
                                            .primary_color,
                                        borderRadius:
                                        BorderRadius.circular(4)),
                                    child: StoryViewListModelData?.object?[index].isFollowing ==
                                        'FOLLOW'
                                        ? Text(
                                      'Follow',
                                      style: TextStyle(
                                          fontFamily: "outfit",
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white),
                                    )
                                        : StoryViewListModelData?.object?[index].isFollowing ==
                                        'REQUESTED'
                                        ? Text(
                                      'Requested',
                                      style: TextStyle(fontFamily: "outfit", fontSize: 12, fontWeight: FontWeight.bold, color: Colors.white),
                                    )
                                        : Text(
                                      'Following ',
                                      style: TextStyle(fontFamily: "outfit", fontSize: 12, fontWeight: FontWeight.bold, color: Colors.white),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }),
                    ),
                  ],
                );
              },
            );
          });
        }).then((value) {
      controller.play();
    });
  }
}
