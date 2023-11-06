import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:pds/API/Bloc/OpenSaveImagepost_Bloc/OpenSaveImagepost_cubit.dart';
import 'package:pds/API/Bloc/add_comment_bloc/add_comment_cubit.dart';
import 'package:pds/API/Model/OpenSaveImagepostModel/OpenSaveImagepost_Model.dart';
import 'package:pds/core/utils/color_constant.dart';
import 'package:pds/core/utils/image_constant.dart';
import 'package:pds/presentation/%20new/ShowAllPostLike.dart';
import 'package:pds/presentation/%20new/comment_bottom_sheet.dart';
import 'package:pds/presentation/register_create_account_screen/register_create_account_screen.dart';
import 'package:pds/widgets/custom_image_view.dart';

import '../../API/Bloc/OpenSaveImagepost_Bloc/OpenSaveImagepost_state.dart';

class OpenSavePostImage extends StatefulWidget {
  String? PostID;

  OpenSavePostImage({required this.PostID});
  @override
  State<OpenSavePostImage> createState() => _OpenSavePostImageState();
}

class _OpenSavePostImageState extends State<OpenSavePostImage> {
  OpenSaveImagepostModel? OpenSaveModelData;
  String formattedDate = DateFormat('dd-MM-yyyy').format(DateTime.now());
  DateTime? parsedDateTimeBlogs;
  final ScrollController scroll = ScrollController();

  @override
  void initState() {
    BlocProvider.of<OpenSaveCubit>(context)
        .openSaveImagePostAPI(context, "${widget.PostID}");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var _height = MediaQuery.of(context).size.height;
    var _width = MediaQuery.of(context).size.width;
    return BlocConsumer<OpenSaveCubit, OpenSaveState>(
        listener: (context, state) async {
      if (state is OpenSaveErrorState) {
        SnackBar snackBar = SnackBar(
          content: Text(state.error),
          backgroundColor: ColorConstant.primary_color,
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }

      // if (state is OpenSaveLoadingState) {
      //   Center(
      //     child: Container(
      //       margin: EdgeInsets.only(bottom: 100),
      //       child: ClipRRect(
      //         borderRadius: BorderRadius.circular(20),
      //         child: Image.asset(ImageConstant.loader,
      //             fit: BoxFit.cover, height: 100.0, width: 100),
      //       ),
      //     ),
      //   );
      // }
      if (state is OpenSaveLoadedState) {
        OpenSaveModelData = state.OpenSaveData;
        print(OpenSaveModelData?.object?.postUserName);
        parsedDateTimeBlogs =
            DateTime.parse('${OpenSaveModelData?.object?.createdAt ?? ""}');
      }
      if (state is PostLikeLoadedState) {
        print("${state.likePost.object}");
        // SnackBar snackBar = SnackBar(
        //   content: Text(state.likePost.object ?? ""),
        //   backgroundColor: ColorConstant.primary_color,
        // );
        // ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    }, builder: (context, state) {
      if (state is OpenSaveLoadingState) {
        return Center(
            child: Container(
                margin: EdgeInsets.only(bottom: 100),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.asset(ImageConstant.loader,
                      fit: BoxFit.cover, height: 100.0, width: 100),
                )));
      }
      return SafeArea(
        child: Scaffold(
          backgroundColor: Colors.black,
          body: Padding(
            padding: const EdgeInsets.only(left: 16, right: 16),
            child: Column(
              children: [
                Container(
                  height: 55,
                  width: _width,
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Container(
                          height: 25,
                          width: 25,
                          color: Color.fromRGBO(255, 255, 255, 0.3),
                          child: Center(
                            child: Image.asset(
                              ImageConstant.whiteClose,
                              fit: BoxFit.fill,
                              height: 20,
                              width: 20,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.only(top: 15, bottom: 15),
                    child: Row(children: [
                      CustomImageView(
                        url: "${OpenSaveModelData?.object?.userProfilePic}",
                        height: 50,
                        width: 50,
                        fit: BoxFit.fill,
                        radius: BorderRadius.circular(25),
                      ),
                      SizedBox(width: 10),
                      Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${OpenSaveModelData?.object?.postUserName}',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontFamily: 'outfit',
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(height: 7),
                            Text(customFormat(parsedDateTimeBlogs!),
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontFamily: 'outfit',
                                  fontWeight: FontWeight.w600,
                                ))
                          ])
                    ])),
                CustomImageView(
                  height: _height / 1.6,
                  url: "${OpenSaveModelData?.object?.postData?[0]}",
                  fit: BoxFit.fill,
                  radius: BorderRadius.circular(5),
                ),
                OpenSaveModelData?.object?.description == null
                    ? SizedBox()
                    : Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "${OpenSaveModelData?.object?.description ?? ""}",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontFamily: 'outfit',
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                Container(
                  // color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 3, right: 16),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 14,
                        ),
                        GestureDetector(
                          onTap: () async {
                            await soicalFunation(
                              apiName: 'like_post',
                            );
                          },
                          child: OpenSaveModelData?.object?.isLiked != true
                              ? Image.asset(
                                  ImageConstant.likewithout,
                                  height: 20,
                                  color: Colors.white,
                                )
                              : Image.asset(
                                  ImageConstant.like,
                                  height: 20,
                                ),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        GestureDetector(
                          onTap: () {
                            /* Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                      
                                                          ShowAllPostLike("${AllGuestPostRoomData?.object?[index].postUid}"))); */

                            Navigator.push(context, MaterialPageRoute(
                              builder: (context) {
                                return ShowAllPostLike(
                                    "${OpenSaveModelData?.object?.postUid}");
                              },
                            ));
                          },
                          child: Text(
                            "${OpenSaveModelData?.object?.likedCount}",
                            style: TextStyle(
                              fontFamily: "outfit",
                              fontSize: 14,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 18,
                        ),
                        GestureDetector(
                          onTap: () async {
                            BlocProvider.of<AddcommentCubit>(context)
                                .Addcomment(context,
                                    '${OpenSaveModelData?.object?.postUid}');

                            _settingModalBottomSheet1(context, 0, _width);

                            /*     await Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                  builder:
                                                                      (context) {
                                                            return CommentsScreen(
                                                              image:
                                                                  AllGuestPostRoomData
                                                                      ?.object
                                                                      ?.content?[
                                                                          index]
                                                                      .userProfilePic,
                                                              userName:
                                                                  AllGuestPostRoomData
                                                                      ?.object
                                                                      ?.content?[
                                                                          index]
                                                                      .postUserName,
                                                              description:
                                                                  AllGuestPostRoomData
                                                                      ?.object
                                                                      ?.content?[
                                                                          index]
                                                                      .description,
                                                              PostUID:
                                                                  '${AllGuestPostRoomData?.object?.content?[index].postUid}',
                                                              date: AllGuestPostRoomData
                                                                      ?.object
                                                                      ?.content?[
                                                                          index]
                                                                      .createdAt ??
                                                                  "",
                                                            );
                                                          })).then((value) =>
                                                              methodtoReffrser()); */
                          },
                          child: Image.asset(
                            ImageConstant.meesage,
                            height: 14,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          "${OpenSaveModelData?.object?.commentCount}",
                          style: TextStyle(
                            fontFamily: "outfit",
                            fontSize: 14,
                            color: Colors.white,
                          ),
                        ),
                        /*  SizedBox(
                                                        width: 18,
                                                      ),
                                                      Image.asset(
                                                        ImageConstant.vector2,
                                                        height: 12,
                                                      ),
                                                      SizedBox(
                                                        width: 5,
                                                      ),
                                                      Text(
                                                        '1335',
                                                        style: TextStyle(
                                                            fontFamily: "outfit",
                                                            fontSize: 14),
                                                      ), */
                        Spacer(),
                        GestureDetector(
                          onTap: () async {
                            await soicalFunation(
                              apiName: 'savedata',
                            );
                          },
                          child: Image.asset(
                            OpenSaveModelData?.object?.isSaved == false
                                ? ImageConstant.savePin
                                : ImageConstant.Savefill,
                            height: 16,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }

  String customFormat(DateTime date) {
    String day = date.day.toString();
    String month = _getMonthName(date.month);
    String year = date.year.toString();
    String time = DateFormat('dd-MM-yyyy     h:mm a').format(date);

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

  void _settingModalBottomSheet1(context, index, _width) {
    void _goToElement() {
      scroll.animateTo((1000 * 20),
          duration: const Duration(milliseconds: 300), curve: Curves.easeOut);
    }

    showModalBottomSheet(
        isScrollControlled: true,
        useSafeArea: true,
        isDismissible: true,
        showDragHandle: true,
        enableDrag: true,
        constraints: BoxConstraints.tight(Size.infinite),
        context: context,
        builder: (BuildContext bc) {
          return CommentBottomSheet(
              userProfile: OpenSaveModelData?.object?.userProfilePic ?? "",
              UserName: OpenSaveModelData?.object?.postUserName ?? "",
              desc: OpenSaveModelData?.object?.description ?? "",
              postUuID: OpenSaveModelData?.object?.postUid ?? "");
        });
  }

  soicalFunation({
    String? apiName,
  }) async {
    print("fghdfghdfgh");
    if (apiName == 'like_post') {
      await BlocProvider.of<OpenSaveCubit>(context)
          .like_post(OpenSaveModelData?.object?.postUid, context);

      if (OpenSaveModelData?.object?.isLiked == true) {
        OpenSaveModelData?.object?.isLiked = false;
        int a = OpenSaveModelData?.object?.likedCount ?? 0;
        int b = 1;
        OpenSaveModelData?.object?.likedCount = a - b;
      } else {
        OpenSaveModelData?.object?.isLiked = true;
        OpenSaveModelData?.object?.likedCount;
        int a = OpenSaveModelData?.object?.likedCount ?? 0;
        int b = 1;
        OpenSaveModelData?.object?.likedCount = a + b;
      }
    } else if (apiName == 'savedata') {
      await BlocProvider.of<OpenSaveCubit>(context)
          .savedData(OpenSaveModelData?.object?.postUid, context);

      if (OpenSaveModelData?.object?.isSaved == true) {
        OpenSaveModelData?.object?.isSaved = false;
      } else {
        OpenSaveModelData?.object?.isSaved = true;
      }
    }
  }
}
