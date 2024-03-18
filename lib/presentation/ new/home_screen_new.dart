import 'dart:async';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:chewie/chewie.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:dio/dio.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_observer/Observable.dart';
import 'package:flutter_observer/Observer.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:linkfy_text/linkfy_text.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pds/API/Bloc/BlogComment_BLoc/BlogComment_cubit.dart';
import 'package:pds/API/Bloc/GuestAllPost_Bloc/GuestAllPost_cubit.dart';
import 'package:pds/API/Bloc/GuestAllPost_Bloc/GuestAllPost_state.dart';
import 'package:pds/API/Bloc/NewProfileScreen_Bloc/NewProfileScreen_cubit.dart';
import 'package:pds/API/Bloc/System_Config_Bloc/system_config_cubit.dart';
import 'package:pds/API/Bloc/add_comment_bloc/add_comment_cubit.dart';
import 'package:pds/API/Bloc/sherinvite_Block/sherinvite_cubit.dart';
import 'package:pds/API/Model/Add_comment_model/add_comment_model.dart';
import 'package:pds/API/Model/BlogComment_Model/BlogComment_model.dart';
import 'package:pds/API/Model/CreateStory_Model/all_stories.dart';
import 'package:pds/API/Model/FetchAllExpertsModel/FetchAllExperts_Model.dart';
import 'package:pds/API/Model/GetGuestAllPostModel/GetGuestAllPost_Model.dart';
import 'package:pds/API/Model/System_Config_model/system_config_model.dart';
import 'package:pds/API/Model/deletecomment/delete_comment_model.dart';
import 'package:pds/API/Model/getall_compeny_page_model/getall_compeny_page.dart';
import 'package:pds/API/Model/like_Post_Model/like_Post_Model.dart';
import 'package:pds/API/Model/saveBlogModel/saveBlog_Model.dart';
import 'package:pds/API/Model/storyModel/stroyModel.dart';
import 'package:pds/API/Model/story_model.dart';
import 'package:pds/API/Repo/repository.dart';
import 'package:pds/StoryFile/src/story_button.dart';
import 'package:pds/StoryFile/src/story_page_transform.dart';
import 'package:pds/StoryFile/src/story_route.dart';
import 'package:pds/core/app_export.dart';
import 'package:pds/core/utils/color_constant.dart';
import 'package:pds/core/utils/image_utils.dart';
import 'package:pds/core/utils/sharedPreferences.dart';
import 'package:pds/fick_players/src/controls/flick_portrait_controls.dart';
import 'package:pds/fick_players/src/controls/flick_video_with_controls.dart';
import 'package:pds/fick_players/src/flick_video_player.dart';
import 'package:pds/fick_players/src/manager/flick_manager.dart';
import 'package:pds/presentation/%20new/BlogComment_screen.dart';
import 'package:pds/presentation/%20new/BlogLikeList_screen.dart';
import 'package:pds/presentation/%20new/HashTagView_screen.dart';
import 'package:pds/presentation/%20new/OpenSavePostImage.dart';
import 'package:pds/presentation/%20new/RePost_Screen.dart';
import 'package:pds/presentation/%20new/ShowAllPostLike.dart';
import 'package:pds/presentation/%20new/comment_bottom_sheet.dart';
import 'package:pds/presentation/%20new/new_story_view_page.dart';
import 'package:pds/presentation/%20new/newbottembar.dart';
import 'package:pds/presentation/%20new/profileNew.dart';
import 'package:pds/presentation/%20new/videoScreen.dart';
import 'package:pds/presentation/Create_Post_Screen/Ceratepost_Screen.dart';
import 'package:pds/presentation/create_foram/create_foram_screen.dart';
import 'package:pds/presentation/create_story/create_story.dart';
import 'package:pds/presentation/create_story/full_story_page.dart';
import 'package:pds/presentation/experts/experts_screen.dart';
import 'package:pds/presentation/recent_blog/recent_blog_screen.dart';
import 'package:pds/presentation/register_create_account_screen/register_create_account_screen.dart';
import 'package:pds/presentation/rooms/rooms_screen.dart';
import 'package:pds/presentation/splash_screen/splash_screen.dart';
import 'package:pds/videocallCommenClass.dart/commenFile.dart';
import 'package:pds/widgets/commentPdf.dart';
import 'package:pds/widgets/pagenation.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:pinch_zoom/pinch_zoom.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:video_player/video_player.dart';
import 'package:visibility_detector/visibility_detector.dart';

// import 'package:flutter_langdetect/flutter_langdetect.dart' as langdetect;
import '../../API/Model/Get_all_blog_Model/get_all_blog_model.dart';
import '../../API/Model/UserTagModel/UserTag_model.dart';
import '../become_an_expert_screen/become_an_expert_screen.dart';
import 'commenwigetReposrt.dart';
import 'switchProfilebootmSheet.dart';

GetGuestAllPostModel? AllGuestPostRoomData;
GetAllStoryModel? getAllStoryModel;
List<StoryButtonData> buttonDatas = [];
List<StoryButton?> storyButtons = [];
List<String> userName = [];
bool apiCalingdone = false;

class HomeScreenNew extends StatefulWidget {
  ScrollController scrollController;

  HomeScreenNew({
    Key? key,
    required this.scrollController,
  }) : super(key: key);

  @override
  State<HomeScreenNew> createState() => _HomeScreenNewState();
}

class _HomeScreenNewState extends State<HomeScreenNew>
    with WidgetsBindingObserver, Observer {
  late String _localPath;
  late bool _permissionReady;
  int? version;
  List a = ['1', '2', '3', '4'];
  List<String> data1 = ['Create Forum', 'Become an Expert'];
  String? uuid;
  bool isEmojiVisible = false;
  bool isKeyboardVisible = false;
  int indexx = 0;
  String? User_ID;
  String? User_Name;
  String? User_Module = "";

  List<String> image = [
    ImageConstant.placeholder4,
    ImageConstant.placeholder4,
    ImageConstant.placeholder4,
    ImageConstant.placeholder4,
  ];
  int imageCount = 1;
  int imageCount1 = 1;
  int imageCount2 = 1;
  Timer? timer;
  Uint8List? firstPageImage;
  double documentuploadsize = 0;
  double finalFileSize = 0;
  double documentVideosize = 0;
  double finalvideoSize = 0;
  BlogCommentModel? blogCommentModel;
  LikePost? likePost;
  DeleteCommentModel? DeletecommentDataa;
  saveBlogModel? saveBlogModeData;
  saveBlogModel? LikeBlogModeData;
  ScrollController scrollController = ScrollController();
  String formattedDate = DateFormat('dd-MM-yyyy').format(DateTime.now());
  bool showDraggableSheet = false;
  bool storyAdded = false;
  BuildContext? storycontext;
  List<Widget> storyPagedata = [];
  FetchAllExpertsModel? AllExperData;
  SystemConfigModel? systemConfigModel;
  int? secound;
  int sliderCurrentPosition = 0;
  List<PageController> _pageControllers = [];
  List<int> _currentPages = [];
  List<PageController> _pageControllers1 = [];
  List<int> _currentPages1 = [];
  List<PageController> _pageControllers2 = [];
  List<int> _currentPages2 = [];
  String? myUserId;
  String? UserProfileImage;
  String? UserStatus;
  String? User_IDStroy;
  GetallBlogModel? getallBlogModel1;
  bool isDataget = false;
  DateTime? parsedDateTimeBlogs;
  String? AutoSetRoomID;
  String? appApkMinVersion;
  String? appApkLatestVersion;
  bool isScrollingDown = false;
  bool _show = true;
  GetAllCompenyPageModel? getallcompenypagemodel;
  String? appApkRouteVersion;
  String? ipaIosLatestVersion;
  String? ipaIosRoutVersion;
  String? ipaIosMainversion;
  String? ApkMinVersion;
  String? ApkLatestVersion;
  String? ApkRouteVersion;
  String? IosLatestVersion;
  String? IosRoutVersion;
  String? IosMainversion;
  String language = "";
  String tempdata1 = "";
  String tempdata2 = "";
  bool checkLun = false;
  bool checkLun2 = false;
  // bool Translate1Bool = false;
  // bool Translate2Bool = false;
  // int? Selected1Value = 0;
  // int? Selected2Value = 0;
  String NotificationUID = "";
  String NotificationSubject = "";
  // bool isDataSet = true;
  String? initalData;

  bool AutoOpenPostBool = false;
  String? AutoOpenPostID;
  List<VideoPlayerController> mainPostControllers = []; //single cotroller
  List<VideoPlayerController> repostControllers = []; // repost cotrller
  List<VideoPlayerController> repostMainControllers = []; // repost
  List<String> videoUrls = [];
  UserTagModel? userTagModel;
  List<ChewieController> chewieController = [];
  ChewieController? inList;
  bool isExpanded = false;
  int maxLength = 60;
  List<bool> readmoree = [];
  GetGuestAllPostCubit? _postCubit;

  bool isWatch = false;
  @override
  update(Observable observable, String? notifyName, Map? map) async {
    AllGuestPostRoomData?.object?.content?[map?['index']].isReports = true;
    WidgetsBinding.instance.removeObserver(this);
    setState(() {});
  }

  getDocumentSize() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    documentuploadsize = await double.parse(
        prefs.getString(PreferencesKey.MaxPostUploadSizeInMB) ?? "0");

    finalFileSize = documentuploadsize;
    documentVideosize = await double.parse(
        prefs.getString(PreferencesKey.MaxStoryUploadSizeInMB) ?? "0");
    finalvideoSize = documentVideosize;
    super.setState(() {});
  }

  bool _isLink(String input) {
    RegExp linkRegex = RegExp(
        r'^https?:\/\/(?:www\.)?[a-zA-Z0-9-]+(?:\.[a-zA-Z]+)+(?:[^\s]*)$');
    return linkRegex.hasMatch(input);
  }

  final focusNode = FocusNode();
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
    Observable.instance.addObserver(this);
    if (apiCalingdone == true) {
      AllGuestPostRoomData?.object?.content?.forEach((element) {
        if (element.description != null) {
          readmoree.add((element.description?.length ?? 0) <= maxLength);
        } else if (element.repostOn?.description != null) {
          readmoree
              .add((element.repostOn?.description?.length ?? 0) <= maxLength);
        } else {
          readmoree.add(false);
        }

        if (element.postDataType == 'VIDEO') {
          if (element.postData?.isNotEmpty == true) {
            videoUrls.add(element.postData?.first ?? '');
          }
        } else if (element.repostOn?.postDataType == 'VIDEO') {
          videoUrls.add(element.repostOn?.postData?.first ?? '');
        } else {
          videoUrls.add('');
        }

        /*  chewieController.add(inList ??
                      ChewieController(videoPlayerController: _controller)); */
      });
    }
    super.initState();

    Get_UserToken();
    myScroll();

    storycontext = context;
    VersionControll();
    getDocumentSize();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    timer?.cancel();
    scrollController.removeListener(() {});
    WidgetsBinding.instance.removeObserver(this);

    super.dispose();
  }

  void hideFloting() {
    super.setState(() {
      _show = false;
    });
  }

  void showFloting() {
    super.setState(() {
      _show = true;
    });
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.resumed:
        Get_UserToken();
        print('1111111:-- Resumed');
        break;
      case AppLifecycleState.inactive:
        print('1111111:-- Inactive');
        break;
      case AppLifecycleState.paused:
        print('1111111:-- Paused');
        break;
      case AppLifecycleState.detached:
        print('1111111:-- Detached');
        break;
    }
  }

  void myScroll() async {
    widget.scrollController.addListener(() {
      if (widget.scrollController.position.userScrollDirection ==
          ScrollDirection.reverse) {
        if (!isScrollingDown) {
          isScrollingDown = true;

          hideFloting();
        }
      }
      if (widget.scrollController.position.userScrollDirection ==
          ScrollDirection.forward) {
        if (isScrollingDown) {
          isScrollingDown = false;

          showFloting();
        }
      }
    });
  }

  AddCommentModel? addCommentModeldata;
  final TextEditingController addcomment = TextEditingController();
  final ScrollController scroll = ScrollController();

  bool added = false;

  void showPopupMenu(BuildContext context, int index, buttonKey) {
    final RenderBox button =
        buttonKey.currentContext!.findRenderObject() as RenderBox;
    final RenderBox overlay =
        Overlay.of(context).context.findRenderObject() as RenderBox;

    final RelativeRect position = RelativeRect.fromRect(
      Rect.fromPoints(
        button.localToGlobal(Offset.zero, ancestor: overlay),
        button.localToGlobal(button.size.bottomLeft(Offset.zero),
            ancestor: overlay),
      ),
      Offset.zero & overlay.size,
    );

    showMenu(
      context: context,
      position: position,
      items: AllGuestPostRoomData?.object?.content?[index].description != null
          ? <PopupMenuItem<String>>[
              PopupMenuItem<String>(
                value: 'edit',
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CreateNewPost(
                            PostID: AllGuestPostRoomData
                                ?.object?.content?[index].postUid,
                            edittextdata: AllGuestPostRoomData
                                ?.object?.content?[index].description,
                            mutliplePost: AllGuestPostRoomData
                                ?.object?.content?[index].postData,
                            AllGuestPostRoomData: AllGuestPostRoomData,
                            date: AllGuestPostRoomData
                                ?.object?.content?[index].repostOn?.createdAt,
                            desc: AllGuestPostRoomData
                                ?.object?.content?[index].repostOn?.description,
                            postData: AllGuestPostRoomData
                                ?.object?.content?[index].repostOn?.postData,
                            postDataTypeRepost: AllGuestPostRoomData?.object
                                ?.content?[index].repostOn?.postDataType,
                            userProfile: AllGuestPostRoomData?.object
                                ?.content?[index].repostOn?.userProfilePic,
                            username: AllGuestPostRoomData?.object
                                ?.content?[index].repostOn?.postUserName,
                            thumbNailURL: AllGuestPostRoomData?.object
                                ?.content?[index].repostOn?.thumbnailImageUrl,
                            postDataType: AllGuestPostRoomData
                                ?.object?.content?[index].postDataType,
                          ),
                        )).then((value) {
                      Get_UserToken();
                      Navigator.pop(context);
                    });
                    /*   print(AllGuestPostRoomData
                        ?.object?.content?[index].description);
                    if (AllGuestPostRoomData
                                ?.object?.content?[index].postDataType ==
                            "IMAGE" &&
                        AllGuestPostRoomData
                                ?.object?.content?[index].postData?.length ==
                            1) {
                      print("sdfgsdvfsdfgsdfg");
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CreateNewPost(
                              PostID: AllGuestPostRoomData
                                  ?.object?.content?[index].postUid,
                              edittextdata: AllGuestPostRoomData
                                  ?.object?.content?[index].description,
                              editImage: AllGuestPostRoomData
                                  ?.object?.content?[index].postData?.first,
                            ),
                          )).then((value) {
                        Get_UserToken();
                        Navigator.pop(context);
                      });
                    } else if (AllGuestPostRoomData
                            ?.object?.content?[index].postDataType ==
                        "IMAGE") {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CreateNewPost(
                              PostID: AllGuestPostRoomData
                                  ?.object?.content?[index].postUid,
                              edittextdata: AllGuestPostRoomData
                                  ?.object?.content?[index].description,
                              mutliplePost: AllGuestPostRoomData
                                  ?.object?.content?[index].postData,
                            ),
                          )).then((value) {
                        Get_UserToken();
                        Navigator.pop(context);
                      });
                    } else {
                      print(
                          "dfhsdfhsdfhsdfh-${AllGuestPostRoomData?.object?.content?[index].postData?.length}");
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CreateNewPost(
                              PostID: AllGuestPostRoomData
                                  ?.object?.content?[index].postUid,
                              edittextdata: AllGuestPostRoomData
                                  ?.object?.content?[index].description,
                            ),
                          )).then((value) {
                        Get_UserToken();
                        Navigator.pop(context);
                      });
                    } */
                  },
                  child: Container(
                    width: 130,
                    height: 40,
                    child: Center(
                      child: Text(
                        'Edit',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    decoration: BoxDecoration(
                        color: ColorConstant.primary_color,
                        borderRadius: BorderRadius.circular(5)),
                  ),
                ),
              ),
              PopupMenuItem<String>(
                value: 'delete',
                child: Container(
                  width: 130,
                  height: 40,
                  child: Center(
                    child: Text(
                      'Delete',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  decoration: BoxDecoration(
                      color: ColorConstant.primary_color,
                      borderRadius: BorderRadius.circular(5)),
                ),
              ),
            ]
          : <PopupMenuItem<String>>[
              PopupMenuItem<String>(
                value: 'delete',
                child: Container(
                  width: 130,
                  height: 40,
                  child: Center(
                    child: Text(
                      'Delete',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  decoration: BoxDecoration(
                      color: ColorConstant.primary_color,
                      borderRadius: BorderRadius.circular(5)),
                ),
              ),
            ],
    ).then((value) {
      if (value == 'delete') {
        showDeleteConfirmationDialog(context,
            AllGuestPostRoomData?.object?.content?[index].postUid ?? "", index);
      }
    });
  }

  AlertHardUpdate() {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return WillPopScope(
            onWillPop: () async => false,
            child: Dialog(
              elevation: 0,
              backgroundColor: Colors.transparent,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              child: Container(
                height: height / 2,
                width: width,
                // color: Colors.white,
                child: Column(
                  children: [
                    Image.asset(
                      ImageConstant.alertimage,
                      height: height / 4.8,
                      width: width,
                      fit: BoxFit.fill,
                    ),
                    Container(
                      height: height / 7,
                      width: width,
                      color: Colors.white,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "New Version Alert",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                              color: ColorConstant.primary_color,
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            "New application version is available",
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 15,
                                color: Colors.black),
                          ),
                          Text(
                            "please download latest version",
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 15,
                                color: Colors.black),
                          ),
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        final Uri url = Uri.parse(Platform.isIOS == true
                            ? "https://apps.apple.com/in/app/inpackaging-knowledge-forum/id6478194670"
                            : "https://play.google.com/store/apps/details?id=com.pds.app");

                        launchUrl(url, mode: LaunchMode.externalApplication);
                      },
                      child: Container(
                        height: 45,
                        width: width,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(10),
                                bottomRight: Radius.circular(10)),
                            color: ColorConstant.primary_color),
                        child: Center(
                            child: Text(
                          "Update",
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 17,
                            color: Colors.white,
                          ),
                        )),
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }

  /* Future<String> translateText(String text, String toLanguage) async {
    final translator = GoogleTranslator();

    Translation translation = await translator.translate(text, to: toLanguage);

    return translation.text;
  }
 */
  AlertSoftUpdate() async {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return WillPopScope(
            onWillPop: () async => false,
            child: Dialog(
              elevation: 0,
              backgroundColor: Colors.transparent,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              child: Container(
                height: height / 2,
                width: width,
                // color: Colors.white,
                child: Column(
                  children: [
                    Image.asset(
                      ImageConstant.alertimage,
                      height: height / 4.8,
                      width: width,
                      fit: BoxFit.fill,
                    ),
                    Container(
                      height: height / 7,
                      width: width,
                      color: Colors.white,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "New Version Alert",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                              color: ColorConstant.primary_color,
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            "New application version is available",
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 15,
                                color: Colors.black),
                          ),
                          Text(
                            "please download latest version",
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 15,
                                color: Colors.black),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            saveAlertStatus();
                            Navigator.pop(context);
                          },
                          child: Container(
                            height: 50,
                            width: width / 2.5,
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: ColorConstant.primary_color),
                                color: Colors.white),
                            child: Center(
                                child: Text(
                              "Later",
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 17,
                                color: ColorConstant.primary_color,
                              ),
                            )),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            final Uri url = Uri.parse(Platform.isIOS == true
                                ? "https://apps.apple.com/in/app/inpackaging-knowledge-forum/id6478194670"
                                : "https://play.google.com/store/apps/details?id=com.pds.app");

                            launchUrl(url,
                                mode: LaunchMode.externalApplication);
                          },
                          child: Container(
                            height: 50,
                            width: width / 2.5,
                            decoration: BoxDecoration(
                                color: ColorConstant.primary_color),
                            child: Center(
                                child: Text(
                              "Update",
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 17,
                                color: Colors.white,
                              ),
                            )),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }

  LoginCheck() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    AutoSetRoomID = prefs.getString(PreferencesKey.AutoSetRoomID);
    if (AutoSetRoomID == "Done" ||
        AutoSetRoomID == "" ||
        AutoSetRoomID == null) {
      print("Auto Enter in Room");
    } else {
      if (User_ID != null) {
        print("User is Login!!:-  ${User_ID}");

        BlocProvider.of<GetGuestAllPostCubit>(context)
            .AutoEnterinRoom(context, AutoSetRoomID ?? "");
      } /*  else {
        if (AutoSetRoomID != "Done") {
          print("User is not Login!!${isLogin}");
          SnackBar snackBar = SnackBar(
            content: Text("After that login, you can go to the Room."),
            backgroundColor: ColorConstant.primary_color,
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
      } */
    }
  }

  saveAutoEnterINRoom() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(PreferencesKey.AutoSetRoomID, "Done");
    Navigator.push(context, MaterialPageRoute(
      builder: (context) {
        return NewBottomBar(
          buttomIndex: 1,
        );
      },
    ));
  }

  SetUi() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    systemConfigModel?.object?.forEach((element) async {
      if (element.name == "MaxDocUploadSizeInMB") {
        var fileSize = element.value!;
        prefs.setString(PreferencesKey.fileSize, fileSize);
      } else if (element.name == "MaxMediaUploadSizeInMB") {
        var mediaSize = int.parse(element.value!);
        prefs.setInt(PreferencesKey.mediaSize, mediaSize);
      } else if (element.name == "ResendTimerInSeconds") {
        var otpTimer = int.parse(element.value!);
        print(" otp timer  ${otpTimer}");
        prefs.setInt(PreferencesKey.otpTimer, otpTimer);
      } else if (element.name == "ApkMinVersion") {
        var ApkMinVersion = element.value ?? "";
        print("ApkMinVersion  ${ApkMinVersion}");
        prefs.setString(PreferencesKey.ApkMinVersion, ApkMinVersion);
      } else if (element.name == "ApkLatestVersion") {
        var ApkLatestVersion = element.value ?? "";
        print(" ApkLatestVersion  ${ApkLatestVersion}");
        prefs.setString(PreferencesKey.ApkLatestVersion, ApkLatestVersion);
      } else if (element.name == "ApkRouteVersion") {
        var ApkRouteVersion = element.value ?? "";
        print(" ApkRouteVersion  ${ApkRouteVersion}");
        prefs.setString(PreferencesKey.ApkRouteVersion, ApkRouteVersion);
      } else if (element.name == "MaxPostUploadSizeInMB") {
        prefs.setString(
            PreferencesKey.MaxPostUploadSizeInMB, element.value ?? '');
      } else if (element.name == "MaxInboxUploadSizeInMB") {
        prefs.setString(
            PreferencesKey.MaxInboxUploadSizeInMB, element.value ?? '');
      }

      /// -----

      else if (element.name == "IosLatestVersion") {
        var IosLatestVersion = element.value ?? "";
        print(" IosLatestVersion  ${IosLatestVersion}");
        prefs.setString(PreferencesKey.IosLatestVersion, IosLatestVersion);
      } else if (element.name == "IosRoutVersion") {
        var IosRoutVersion = element.value ?? "";
        print("IosRoutVersion  ${IosRoutVersion}");
        prefs.setString(PreferencesKey.IosRoutVersion, IosRoutVersion);
      } else if (element.name == "IosMainversion") {
        var IosMainversion = element.value ?? "";
        print(" IosMainversion  ${IosMainversion}");
        prefs.setString(PreferencesKey.IosMainversion, IosMainversion);
      } else if (element.name == "AwsImageInPackagingLogoUrl") {
        print(" ApkRouteVersion  ${ApkRouteVersion}");
        prefs.setString(
            PreferencesKey.AwsImageInPackagingLogoUrl, element.value ?? '');
      }

      /// ---------

      else if (element.name == "SocketLink") {
        var SocketLink = element.value ?? "";
        print(" SocketLink  ${SocketLink}");
        prefs.setString(PreferencesKey.SocketLink, SocketLink);
      } else if (element.name == "ApkRouteURL") {
        var RoutURL = element.value ?? "";
        print(" RoutURL  ${RoutURL}");
        prefs.setString(PreferencesKey.RoutURL, RoutURL);
      } else if (element.name == "SupportEmailId") {
        var SupportEmailId = element.value ?? "";
        print(" SupportEmailId  ${SupportEmailId}");
        prefs.setString(PreferencesKey.SupportEmailId, SupportEmailId);
      } else if (element.name == "SupportPhoneNumber") {
        var SupportPhoneNumber = element.value ?? "";
        print(" SupportPhoneNumber  ${SupportPhoneNumber}");
        prefs.setString(PreferencesKey.SupportPhoneNumber, SupportPhoneNumber);
      } else if (element.name == "MaxPublicRoomSave") {
        var MaxPublicRoomSave = element.value ?? "";
        print("SupportPhoneNumber  ${MaxPublicRoomSave}");
        prefs.setString(PreferencesKey.MaxPublicRoomSave, MaxPublicRoomSave);
      } else if (element.name == "MaxStoryUploadSizeInMB") {
        var maxStoryUploadSizeInMB = element.value ?? "";
        prefs.setString(
            PreferencesKey.MaxStoryUploadSizeInMB, maxStoryUploadSizeInMB);
      }
    });
    VersionControll();
  }

  VersionControll() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    ApkMinVersion = prefs.getString(PreferencesKey.ApkMinVersion);
    ApkLatestVersion = prefs.getString(PreferencesKey.ApkLatestVersion);
    ApkRouteVersion = prefs.getString(PreferencesKey.ApkRouteVersion);

    IosLatestVersion = prefs.getString(PreferencesKey.IosLatestVersion);
    IosRoutVersion = prefs.getString(PreferencesKey.IosRoutVersion);
    IosMainversion = prefs.getString(PreferencesKey.IosMainversion);

    appApkRouteVersion = prefs.getString(PreferencesKey.appApkRouteVersion);
    appApkLatestVersion = prefs.getString(PreferencesKey.appApkLatestVersion);
    appApkMinVersion = prefs.getString(PreferencesKey.appApkMinVersion);

    ipaIosLatestVersion = prefs.getString(PreferencesKey.IPAIosLatestVersion);
    ipaIosRoutVersion = prefs.getString(PreferencesKey.IPAIosRoutVersion);
    ipaIosMainversion = prefs.getString(PreferencesKey.IPAIosMainversion);

    bool ShowSoftAlert = prefs.getBool(PreferencesKey.ShowSoftAlert) ?? false;
    bool OnetimeRoutChange =
        prefs.getBool(PreferencesKey.OnetimeRoutChange) ?? false;
    VersionAlert(ShowSoftAlert, OnetimeRoutChange);
  }

  VersionAlert(bool ShowSoftAlert, bool OnetimeRoutChange) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    if (Platform.isAndroid) {
      if (int.parse(ApkMinVersion ?? "") >
          (int.parse(appApkMinVersion ?? ""))) {
        print("Moti1");
        AlertHardUpdate();
      }

      if (int.parse(ApkLatestVersion ?? "") >
          (int.parse(appApkLatestVersion ?? ""))) {
        print("Moti2");
        if (ShowSoftAlert == false || ShowSoftAlert == null) {
          AlertSoftUpdate();
        }
      }

      if (int.parse(ApkRouteVersion ?? "") ==
          (int.parse(appApkRouteVersion ?? ""))) {
        if (OnetimeRoutChange == false) {
          setLOGOUT(context);
        }
      } else {
        prefs.setBool(PreferencesKey.OnetimeRoutChange, false);
        prefs.setBool(PreferencesKey.RoutURlChnage, false);
      }
    }

    /// -----------------------------------------
    if (Platform.isIOS) {
      if (int.parse(IosMainversion ?? "") >
          (int.parse(ipaIosMainversion ?? ""))) {
        print("Moti1");
        AlertHardUpdate();
      }

      if (int.parse(IosLatestVersion ?? "") >
          (int.parse(ipaIosLatestVersion ?? ""))) {
        print("Moti2");
        if (ShowSoftAlert == false || ShowSoftAlert == null) {
          AlertSoftUpdate();
        }
      }

      if (int.parse(IosRoutVersion ?? "") ==
          (int.parse(ipaIosRoutVersion ?? ""))) {
        print("same");
        if (OnetimeRoutChange == false) {
          setLOGOUT(context);
        }
      } else {
        prefs.setBool(PreferencesKey.OnetimeRoutChange, false);
        prefs.setBool(PreferencesKey.RoutURlChnage, false);
      }
    }
  }

  saveAlertStatus() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(PreferencesKey.ShowSoftAlert, true);
  }

  setLOGOUT(BuildContext context) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    // prefs.clear();
    // prefs.setBool(PreferencesKey.OnetimeRoutChange, true);
    prefs.remove(PreferencesKey.loginUserID);
    prefs.remove(PreferencesKey.loginJwt);
    prefs.remove(PreferencesKey.module);
    prefs.remove(PreferencesKey.UserProfile);

    prefs.setBool(PreferencesKey.RoutURlChnage, true);
    prefs.setBool(PreferencesKey.UpdateURLinSplash, true);

    await Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
            builder: (context) => MultiBlocProvider(
                  providers: [
                    BlocProvider<SystemConfigCubit>(
                      create: (context) => SystemConfigCubit(),
                    ),
                  ],
                  child: SplashScreen(),
                )),
        (route) => false);
  }

  void showDeleteConfirmationDialog(
      BuildContext context, String PostUID, int index) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          contentPadding: EdgeInsets.all(10),
          title: Text('Confirm Delete'),
          titlePadding: EdgeInsets.all(10),
          content: Container(
            height: 100,
            child: Column(
              children: [
                Text('Are you sure you want to delete this Post?'),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    GestureDetector(
                      onTap: () async {
                        await soicalFunation(
                            apiName: 'Deletepost', index: index);

                        print('Deleted.');
                      },
                      child: Container(
                        height: 30,
                        width: 80,
                        decoration: BoxDecoration(
                            // color: Colors.green,
                            color: ColorConstant.primary_color,
                            borderRadius: BorderRadius.circular(5)),
                        child: Center(
                          child: Text(
                            "Yes",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pop();
                        print('Not deleted.');
                      },
                      child: Container(
                        margin: EdgeInsets.only(left: 10),
                        height: 30,
                        width: 80,
                        decoration: BoxDecoration(
                            border:
                                Border.all(color: ColorConstant.primary_color),
                            borderRadius: BorderRadius.circular(5)),
                        // color: Colors.green,
                        child: Center(
                          child: Text(
                            "No",
                            style:
                                TextStyle(color: ColorConstant.primary_color),
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
          actionsPadding: EdgeInsets.all(5),
          /* actions: <Widget>[
           
            SizedBox(
              width: 40,
              height: 50,
            ),
          ], */
        );
      },
    );
  }

  Get_UserToken() async {
    _postCubit = await BlocProvider.of<GetGuestAllPostCubit>(context);

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var Token = prefs.getString(PreferencesKey.loginJwt);
    var FCMToken = prefs.getString(PreferencesKey.fcmToken);
    User_ID = prefs.getString(PreferencesKey.loginUserID);
    User_Name = prefs.getString(PreferencesKey.ProfileName);
    User_Module = prefs.getString(PreferencesKey.module);
    uuid = prefs.getString(PreferencesKey.loginUserID);
    UserProfileImage = prefs.getString(PreferencesKey.UserProfile);
    String? videoCallUid = prefs.getString(PreferencesKey.vidoCallUid);
    print("---------------------->> : ${FCMToken}");
    print("User Token :--- " + "${Token}");
    print("User_id-${User_ID}");
    User_ID == null ? api() : NewApi();
    shareImageDownload();
    AutoOpenPostBool = prefs.getBool(PreferencesKey.AutoOpenPostBool) ?? false;
    if (AutoOpenPostBool == true) {
      AutoOpenPostID = prefs.getString(PreferencesKey.AutoOpenPostID);
      prefs.setBool(PreferencesKey.AutoOpenPostBool, false);
      prefs.setString(PreferencesKey.AutoOpenPostID, "");
      BlocProvider.of<GetGuestAllPostCubit>(context)
          .SharePost(context, AutoOpenPostID ?? "");
      /*   Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => OpenSavePostImage(
                  PostopenLink: AutoOpenPostID,
                  PostID: "0",
                  index: 0,
                )),
      ); */
    }
    if (User_ID != null) {
      PushNotificationAutoOpen();
      // onUserLogin(User_ID!,User_Name ?? '');
      // this is the
    }
    // if(videoCallUid !=null){
    //   onUserLogin(videoCallUid ?? '',User_Name ?? '');
    // }
  }

  PushNotificationAutoOpen() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    NotificationUID = prefs.getString(PreferencesKey.PushNotificationUID) ?? "";
    NotificationSubject =
        prefs.getString(PreferencesKey.PushNotificationSubject) ?? "";
    print("objectobjecobjecobjec-1:- ${NotificationUID}");
    print("objectobjecobjecobjec-2:- ${NotificationSubject}");

    /// ----------------------------------------------------------------------------------------------------------

    if (NotificationUID != "" || NotificationSubject != "") {
      print("objectobjecobjecobjec-3:- ${NotificationUID}");
      print("objectobjecobjecobjec-4:- ${NotificationSubject}");
      setState(() {
        isShowScreen = true;
      });
      NotificationSubject == "TAG_POST" || NotificationSubject == "RE_POST"
          ? Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => OpenSavePostImage(
                        PostID: NotificationUID,
                        Userid: User_ID,
                        index: 0,
                      )),
            ).then((value) {
              // Get_UserToken();

              setColorr();
            })
          // print("opne Save Image screen RE_POST & TAG_POST");

           : NotificationSubject == "INVITE_ROOM"
              ?

              /// jinal code  14022024
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(
                      builder: (context) => NewBottomBar(
                            buttomIndex: 4,
                          )),
                  (Route<dynamic> route) => false)

              // print("Notification Seen INVITE_ROOM")
              // : NotificationSubject == "DELETE_ROOM"
              //     ? print(
              //         "Notification Seen  EXPERT_LEFT_ROOM & MEMBER_LEFT_ROOM & DELETE_ROOM & EXPERT_ACCEРТ_INVITE & EXPERT_REJECT_INVITE")
              : NotificationSubject == "EXPERT_ACCEPT_INVITE"

                      /// jinal code 14032024
                      ||
                      NotificationSubject == "EXPERT_LEFT_ROOM" ||
                      // NotificationSubject == "MEMBER_LEFT_ROOM" ||
                      NotificationSubject == "EXPERT_REJECT_INVITE"
                  ?

                  /// jinal code 14032024
                
                   Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(
                      builder: (context) => NewBottomBar(
                            buttomIndex: 1,
                          )),
                  (Route<dynamic> route) => false)
                  // print("Seen Notification EXPERT_REJECT_INVITE")
                  :  NotificationSubject == "LIKE_POST" ||
                              NotificationSubject == "COMMENT_POST" ||
                              NotificationSubject == "TAG_COMMENT_POST"
                          ? Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => OpenSavePostImage(
                                        PostID: NotificationUID,
                                        index: 0,
                                        profileTure: NotificationSubject ==
                                                    "COMMENT_POST" ||
                                                NotificationSubject ==
                                                    "TAG_COMMENT_POST"
                                            ? true
                                            : false,
                                      )),
                            ).then((value) => setColorr())
                          // print("opne Save Image screen LIKE_POST & COMMENT_POST & TAG_COMMENT_POST")
                          : NotificationSubject == "FOLLOW_PUBLIC_ACCOUNT" ||
                                  NotificationSubject ==
                                      "FOLLOW_PRIVATE_ACCOUNT_REQUEST" ||
                                  NotificationSubject ==
                                      "FOLLOW_REQUEST_ACCEPTED" ||
                                  NotificationSubject == "PROFILE_APPROVED" ||
                                  NotificationSubject == "PROFILE_REJECTED" ||
                                  NotificationSubject == "PROFILE_VIEWED"
                              ? Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                  return ProfileScreen(
                                      User_ID: "${NotificationUID}",
                                      isFollowing: "",
                                      ProfileNotification: true);
                                }))
                              //  print("open User Profile FOLLOW_PUBLIC_ACCOUNT & FOLLOW_PRIVATE_ACCOUNT_REQUEST & FOLLOW_REQUEST_ACCEPTED")
                              : print("");

      prefs.remove(PreferencesKey.PushNotificationUID);
      prefs.remove(PreferencesKey.PushNotificationSubject);
    }

    /// ----------------------------------------------------------------------------------------------------------
  }

  Save_UserData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    print("22222222 User_Module:-  ${User_Module}");

    prefs.setString(PreferencesKey.module, User_Module ?? "");
    prefs.setString(PreferencesKey.UserProfile, UserProfileImage ?? "");
  }

  api() async {
    await BlocProvider.of<GetGuestAllPostCubit>(context)
        .SystemConfigHome(context);
    await BlocProvider.of<GetGuestAllPostCubit>(context)
        .GetGuestAllPostAPI(context, '1', showAlert: true);
  }

  NewApi() async {
    if (User_ID != null && User_Name != null) {
      String useruidsort = User_ID!.split('-').last.toString();
    onUserLogin('${useruidsort}', '${User_Name}');
    }
    timer = Timer.periodic(Duration(seconds: 15), (timer) async {
      setState(() {
        secound = timer.tick;
      });
      await BlocProvider.of<GetGuestAllPostCubit>(context)
          .seetinonExpried(context);
      await BlocProvider.of<GetGuestAllPostCubit>(context)
          .getAllNoticationsCountAPI(context);
    });
    await BlocProvider.of<GetGuestAllPostCubit>(context)
        .getallcompenypagee(context);
    await BlocProvider.of<GetGuestAllPostCubit>(context)
        .get_all_master_report_typeApiMethod(context);
    await BlocProvider.of<GetGuestAllPostCubit>(context)
        .getAllNoticationsCountAPI(context);
    await BlocProvider.of<GetGuestAllPostCubit>(context)
        .ChatOnline(context, true);

    await BlocProvider.of<GetGuestAllPostCubit>(context)
        .SystemConfigHome(context);
    print("1111111111111 :- ${User_ID}");
    // /user/api/get_all_post
    await BlocProvider.of<GetGuestAllPostCubit>(context)
        .GetUserAllPostAPI(context, '1', showAlert: true);

    await BlocProvider.of<GetGuestAllPostCubit>(context).get_all_story(
      context,
    );
    await BlocProvider.of<GetGuestAllPostCubit>(context)
        .GetallBlog(context, User_ID ?? "");
    await BlocProvider.of<GetGuestAllPostCubit>(context)
        .FetchAllExpertsAPI(context);
    await BlocProvider.of<GetGuestAllPostCubit>(context).MyAccount(context);
    LoginCheck();
  }

  soicalFunation({String? apiName, int index = 0}) async {
    print("fghdfghdfgh");
    if (uuid == null) {
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => RegisterCreateAccountScreen()));
    } /* else if (apiName == 'Follow') {
      print("dfhsdfhsdfhsdgf");
      await BlocProvider.of<GetGuestAllPostCubit>(context).followWIngMethod(
          AllGuestPostRoomData?.object?.content?[index ?? 0].userUid, context);
      if (AllGuestPostRoomData?.object?.content?[index ?? 0].isFollowing ==
          'FOLLOW') {
        AllGuestPostRoomData?.object?.content?[index ?? 0].isFollowing =
            'REQUESTED';
      } else {
        AllGuestPostRoomData?.object?.content?[index ?? 0].isFollowing =
            'FOLLOW';
      }
    }  */
    else if (apiName == 'Follow') {
      print("dfhsdfhsdfhsdgf");
      await BlocProvider.of<GetGuestAllPostCubit>(context).followWIngMethod(
          AllGuestPostRoomData?.object?.content?[index].userUid, context);
      if (AllGuestPostRoomData?.object?.content?[index].isFollowing ==
          'FOLLOW') {
        /* AllGuestPostRoomData?.object?.content?[index ?? 0].isFollowing =
            'REQUESTED'; */
        for (int i = 0;
            i < (AllGuestPostRoomData?.object?.content?.length ?? 0);
            i++) {
          print("i-${i}");
          if (AllGuestPostRoomData?.object?.content?[index ?? 0].userUid ==
              AllGuestPostRoomData?.object?.content?[i].userUid) {
            AllGuestPostRoomData?.object?.content?[i].isFollowing = 'REQUESTED';
            print(
                "check data-${AllGuestPostRoomData?.object?.content?[i].isFollowing}");
          }
        }
      } else {
        /* AllGuestPostRoomData?.object?.content?[index ?? 0].isFollowing =
            'FOLLOW'; */
        for (int i = 0;
            i < (AllGuestPostRoomData?.object?.content?.length ?? 0);
            i++) {
          if (AllGuestPostRoomData?.object?.content?[index ?? 0].userUid ==
              AllGuestPostRoomData?.object?.content?[i].userUid) {
            AllGuestPostRoomData?.object?.content?[i].isFollowing = 'FOLLOW';
          }
        }
      }
    } else if (apiName == 'like_post') {
      Content content = AllGuestPostRoomData!.object!.content![index];
      bool isLiked = content.isLiked ?? false;
      var likedCount = content.likedCount ?? 0;

      if (isLiked) {
        content.isLiked = false;
        content.likedCount = likedCount - 1;
      } else {
        content.isLiked = true;
        content.likedCount = likedCount + 1;
      }

      setState(() {
        _postCubit!.like_post(content.postUid, context);
      });
      //
    } else if (apiName == 'savedata') {
      await BlocProvider.of<GetGuestAllPostCubit>(context).savedData(
          AllGuestPostRoomData?.object?.content?[index ?? 0].postUid, context);

      if (AllGuestPostRoomData?.object?.content?[index ?? 0].isSaved == true) {
        AllGuestPostRoomData?.object?.content?[index ?? 0].isSaved = false;
      } else {
        AllGuestPostRoomData?.object?.content?[index ?? 0].isSaved = true;
      }
    } else if (apiName == 'Deletepost') {
      await BlocProvider.of<GetGuestAllPostCubit>(context).DeletePost(
          '${AllGuestPostRoomData?.object?.content?[index ?? 0].postUid}',
          context);
      AllGuestPostRoomData?.object?.content?.removeAt(index ?? 0);
      readmoree.removeAt(index ?? 0);
    }
  }

  methodtoReffrser() {
    print("method calling");
    print("user id-$User_ID");
    User_ID == null ? api() : NewApi();
  }

  Future<void> refreshdata() async {
    User_ID == null ? api() : NewApi();

    // await Future.delayed(Duration(seconds: 2));
  }

  LangDetect(String TextData, int index) async {
// await langdetect.initLangDetect();
// final language1 = langdetect.detect(TextData);
// language = "${language1}";

    //  LangIdResult result = await LangId.detectLanguage(inputString);

    // Access the detected language and confidence
    // language = result.language;
    // double confidence = result.confidence;
  }
  setColorr() {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.dark, // Light icons for status bar
        statusBarBrightness:
            Brightness.light // Dark == white status bar -- for IOS.
        ));
  }

  @override
  Widget build(BuildContext context) {
    var _height = MediaQuery.of(context).size.height;
    var _width = MediaQuery.of(context).size.width;
    setColorr();
    return WillPopScope(
        onWillPop: () async {
          return true;
        },
        child: Scaffold(
            resizeToAvoidBottomInset: false,
            floatingActionButton: _show
                ? FloatingActionButton(
                    backgroundColor: ColorConstant.primary_color,
                    onPressed: () {
                      if (uuid != null) {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return CreateNewPost();
                        })).then((value) {
                          return Get_UserToken();
                        });
                      } else {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) =>
                                RegisterCreateAccountScreen()));
                      }
                    },
                    child: Image.asset(
                      ImageConstant.huge,
                      height: 30,
                    ),
                    elevation: 0,
                  )
                : SizedBox(),
            appBar: _show
                ? AppBar(
                    systemOverlayStyle: SystemUiOverlayStyle(
                      // Status bar color
                      statusBarColor: Colors.transparent,

                      // Status bar brightness (optional)
                      statusBarIconBrightness:
                          Brightness.dark, // For Android (dark icons)
                      statusBarBrightness:
                          Brightness.light, // For iOS (dark icons)
                    ),
                    backgroundColor: Colors.transparent,
                    toolbarHeight: 80,
                    elevation: 0,
                    automaticallyImplyLeading: false,
                    title: SvgPicture.asset(
                      ImageConstant.splashImage,
                      height: 60,
                    ),
                    actions: [
                        Row(
                          children: [
                            /* InkWell(
                                    onTap: () {
                                      print("this seactin -${User_Module}");
                                    },
                                    child: SizedBox(
                                        height: 50,
                                        child: Image.asset(
                                            ImageConstant.splashImage)),
                                  ),
                                  Spacer(), */
                            UserStatus == 'REJECTED' ||
                                    User_Module == "EMPLOYEE" ||
                                    User_Module == "COMAPNY" ||
                                    User_Module == "EXPERT" ||
                                    User_Module == null ||
                                    User_Module == ''
                                ? GestureDetector(
                                    onTapDown: (TapDownDetails details) {
                                      User_Module == "EMPLOYEE"
                                          ? _showPopupMenu(
                                              details.globalPosition,
                                              context,
                                            )
                                          : _showPopupMenuSwitchAccount(
                                              details.globalPosition,
                                              context,
                                            );
                                    },
                                    child: Container(
                                      height: 50,
                                      width: 50,
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: ColorConstant.primary_color),
                                      child: Icon(
                                        Icons.person_add_alt,
                                        color: Colors.white,
                                      ),
                                    ),
                                  )
                                : SizedBox(),
                            SizedBox(
                              width: 17,
                            ),
                            GestureDetector(
                                onTap: () async {
                                  if (uuid == null) {
                                    /* Navigator.of(context).push(
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      RegisterCreateAccountScreen())); */
                                    /*     Navigator.removeRoute(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      RegisterCreateAccountScreen())); */
                                    Navigator.pushAndRemoveUntil(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                RegisterCreateAccountScreen()),
                                        (route) => true);
                                  } else {
                                    await BlocProvider.of<GetGuestAllPostCubit>(
                                            context)
                                        .seetinonExpried(context);
                                    Navigator.push(context,
                                        MaterialPageRoute(builder: (context) {
                                      return MultiBlocProvider(
                                          providers: [
                                            BlocProvider<NewProfileSCubit>(
                                              create: (context) =>
                                                  NewProfileSCubit(),
                                            ),
                                          ],
                                          child: ProfileScreen(
                                            User_ID: "${User_ID}",
                                            isFollowing: 'FOLLOW',
                                          ));
                                    })).then((value) => Get_UserToken());
                                    /////
                                  }
                                },
                                child: uuid == null
                                    ? Text(
                                        'Login',
                                        style: TextStyle(
                                            fontFamily: "outfit",
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            color: ColorConstant.primary_color),
                                      )
                                    : UserProfileImage != null &&
                                            UserProfileImage != ""
                                        ? GestureDetector(
                                            onLongPress: () {
                                              if (User_Module == 'COMPANY' &&
                                                  getallcompenypagemodel?.object
                                                          ?.isNotEmpty ==
                                                      true) {
                                                showProfileSwitchBottomSheet(
                                                    context,
                                                    getallcompenypagemodel!);
                                              }
                                            },
                                            child: CustomImageView(
                                              url: "${UserProfileImage}",
                                              // color: Colors.transparent,
                                              height: 50,
                                              width: 50,
                                              fit: BoxFit.fill,
                                              radius: BorderRadius.circular(25),
                                            ),
                                          )
                                        : GestureDetector(
                                            onLongPress: () {
                                              // this is the company user if
                                              if (User_Module == 'COMPANY' &&
                                                  (getallcompenypagemodel
                                                              ?.object
                                                              ?.length ??
                                                          0) >=
                                                      0) {
                                                showProfileSwitchBottomSheet(
                                                    context,
                                                    getallcompenypagemodel!);
                                              }
                                            },
                                            child: CustomImageView(
                                              imagePath: ImageConstant.tomcruse,
                                              // color: Colors.transparent,
                                              height: 50,
                                              width: 50,
                                              fit: BoxFit.fill,
                                              radius: BorderRadius.circular(25),
                                            ),
                                          )),
                          ],
                        ),
                        SizedBox(
                          width: 20,
                        )
                      ])
                : null,
            body: BlocConsumer<GetGuestAllPostCubit, GetGuestAllPostState>(
                listener: (context, state) async {
              if (state is GetGuestAllPostErrorState) {
                print("i want check responce---${state.error}");
                if (state.error['errorCode'] == '701') {
                } else if (state.error['status'] == '') {
                } else {
                  SnackBar snackBar = SnackBar(
                    content: Text(state.error),
                    backgroundColor: ColorConstant.primary_color,
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                }
              }
              if (state is Getallcompenypagelodedstate) {
                getallcompenypagemodel = state.getallcompenypagemodel;
              }

              if (state is FetchAllExpertsLoadedState) {
                AllExperData = state.AllExperData;
              }
              if (state is SystemConfigLoadedState) {
                systemConfigModel = state.SystemConfigModelData;
                SetUi();
              }
              if (state is GetGuestAllPostLoadingState) {
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
              if (state is DeletePostLoadedState) {
                SnackBar snackBar = SnackBar(
                  content: Text(state.DeletePost.object.toString()),
                  backgroundColor: ColorConstant.primary_color,
                );
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              }
              if (state is GetallblogsLoadedState) {
                // apiCalingdone = true;
                isDataget = true;
                getallBlogModel1 = state.getallBlogdata;
              }
              if (state is GetUserProfileLoadedState) {
                print('dsfgsgfgsd-${state.myAccontDetails.success.toString()}');
                User_Name = state.myAccontDetails.object?.userName;
                User_Module = state.myAccontDetails.object?.module;
                UserProfileImage = state.myAccontDetails.object?.userProfilePic;
                UserStatus = state.myAccontDetails.object?.approvalStatus;
                Save_UserData();
              }
              if (state is saveBlogLoadedState) {
                SnackBar snackBar = SnackBar(
                  content: Text(state.saveBlogModeData.object.toString()),
                  backgroundColor: ColorConstant.primary_color,
                );
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
                saveBlogModeData = state.saveBlogModeData;
              }

              if (state is likeBlogLoadedState) {
                // SnackBar snackBar = SnackBar(
                //   content: Text(state.LikeBlogModeData.object.toString()),
                //   backgroundColor: ColorConstant.primary_color,
                // );
                // ScaffoldMessenger.of(context).showSnackBar(snackBar);
                LikeBlogModeData = state.LikeBlogModeData;
              }
              if (state is Getallmasterreporttype) {
                reportOptions = [];
                state.get_all_master_report_type.forEach((e) {
                  reportOptions.add(ReportOption(
                    properString: e.toString(),
                    label: '${e.replaceAll(" ", '_').toUpperCase()}',
                  ));
                });
              }
              if (state is RePostLoadedState) {
                print(
                    "333333333333333333333333333333333333333333333333333333333333333333");
                print(state.RePost.object);
                SnackBar snackBar = SnackBar(
                  content: Text(state.RePost.object.toString()),
                  backgroundColor: ColorConstant.primary_color,
                );
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
                if (state.RePost.object != "You already reposted") {
                  Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
                    builder: (context) {
                      return NewBottomBar(
                        buttomIndex: 0,
                      );
                    },
                  ), (Route<dynamic> route) => false);
                }
              }

              if (state is GetAllStoryLoadedState) {
                getAllStoryModel = state.getAllStoryModel;
                buttonDatas.clear();
                storyButtons.clear();
                userName.clear();
                storyButtons = List.filled(1, null, growable: true);
                userName.add('');
                print("stroyButtonsData-${storyButtons.length}");
                if (state.getAllStoryModel.object != null ||
                    ((state.getAllStoryModel.object?.isNotEmpty == true) ??
                        false)) {
                  final SharedPreferences prefs =
                      await SharedPreferences.getInstance();
                  prefs.setInt(PreferencesKey.StroyLengthCheck,
                      state.getAllStoryModel.object?.length ?? 0);

                  state.getAllStoryModel.object?.forEach((element) {
                    if (element.userUid == User_ID) {
                      int count = 0;

                      element.storyData?.forEach((element) {
                        print("check count--${element.storySeen}");
                        if (element.storySeen != null) {
                          print("element get -${element.storySeen}");
                          if (element.storySeen == true) {
                            count++;
                          }
                        }
                      });
                      print("first -${count}");

                      userName.insert(0, element.userName.toString());
                      buttonDatas.insert(
                          0,
                          StoryButtonData(
                            // isWatch: isWatch == false ? true : false,  iswatch 0
                            isWatch: element.storyData?.length == count,
                            timelineBackgroundColor: Colors.grey,
                            buttonDecoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: element.profilePic != null &&
                                      element.profilePic != ""
                                  ? DecorationImage(
                                      image:
                                          NetworkImage("${element.profilePic}"),
                                      fit: BoxFit.fill)
                                  : DecorationImage(
                                      image: AssetImage(
                                        ImageConstant.brandlogo,
                                      ),
                                      fit: BoxFit.cover,
                                    ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(
                                    '',
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            images: List.generate(
                                element.storyData?.length ?? 0, (index) {
                              print(
                                  "index check -${element.storyData![index].userName}");
                              print(
                                  "index check1 -${element.storyData![index].storyUid}");
                              print(
                                  "index check2 -${element.storyData![index].userUid}");

                              return StoryModel(
                                  element.storyData![index].storyData!,
                                  element.storyData![index].createdAt!,
                                  element.storyData![index].profilePic,
                                  element.storyData![index].userName,
                                  element.storyData![index].storyUid,
                                  element.storyData![index].userUid,
                                  element.storyData![index].storyViewCount,
                                  element.storyData![index].videoDuration);
                            }),
                            borderDecoration: BoxDecoration(
                              borderRadius: const BorderRadius.all(
                                Radius.circular(60.0),
                              ),
                              border: Border.fromBorderSide(
                                BorderSide(
                                  color: Colors.red,
                                  width: 1.5,
                                ),
                              ),
                            ),
                            storyPages: List.generate(
                                element.storyData?.length ?? 0, (index) {
                              return FullStoryPage(
                                imageName:
                                    '${element.storyData?[index].storyData}',
                              );
                            }),
                            segmentDuration: const Duration(seconds: 3),
                          ));

                      storyButtons[0] = (StoryButton(
                          onPressed: (data) {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return NewStoryViewPage(
                                  data, buttonDatas, 0, User_ID!);
                            })).then((value) => Get_UserToken());
                            /* Navigator.of(storycontext!).push(
                              StoryRoute(
                                // hii working Date
                                onTap: () async {
                                  await BlocProvider.of<GetGuestAllPostCubit>(
                                          context)
                                      .seetinonExpried(context);
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (context) {
                                    return ProfileScreen(
                                        User_ID: "${element.userUid}",
                                        isFollowing: "");
                                  })).then((value) => Get_UserToken());
                                },
                                storyContainerSettings: StoryContainerSettings(
                                  buttonData: buttonDatas[0],
                                  tapPosition:
                                      buttonDatas[0].buttonCenterPosition!,
                                  curve: buttonDatas[0].pageAnimationCurve,
                                  allButtonDatas: buttonDatas,
                                  pageTransform: StoryPage3DTransform(),
                                  storyListScrollController: ScrollController(),
                                ),
                                duration: buttonDatas[0].pageAnimationDuration,
                              ),
                            ); */
                          },
                          buttonData: buttonDatas[0],
                          allButtonDatas: buttonDatas,
                          storyListViewController: ScrollController()));
                      userName.clear();
                      userName.add(element.userName ?? '');

                      storyAdded = true;
                    } else if (element.userUid != User_ID) {
                      print("check Data get -${element.userName.toString()}");
                      /*    if (!storyAdded)
                        // userName.add("Share Storyaaaa");
                        userName.add(element.userName.toString()); */

                      int count = 0;
                      element.storyData?.forEach((element) {
                        if (element.storySeen!) {
                          count++;
                        }
                      });

                      StoryButtonData buttonData1 = StoryButtonData(
                        isWatch: element.storyData?.length == count,
                        timelineBackgroundColor: Colors.grey,
                        buttonDecoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: element.profilePic != null &&
                                  element.profilePic != ''
                              ? DecorationImage(
                                  image: NetworkImage("${element.profilePic}"),
                                  fit: BoxFit.fill)
                              : DecorationImage(
                                  image: AssetImage(
                                    ImageConstant.brandlogo,
                                  ),
                                  fit: BoxFit.cover,
                                ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                '',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                        images: List.generate(
                            element.storyData?.length ?? 0,
                            (index) => StoryModel(
                                element.storyData![index].storyData!,
                                element.storyData![index].createdAt!,
                                element.storyData![index].profilePic,
                                element.storyData![index].userName,
                                element.storyData![index].storyUid,
                                element.storyData![index].userUid,
                                element.storyData![index].storyViewCount,
                                element.storyData![index].videoDuration)),
                        borderDecoration: BoxDecoration(
                          borderRadius: const BorderRadius.all(
                            Radius.circular(60.0),
                          ),
                          border: Border.fromBorderSide(
                            BorderSide(
                              color: Colors.red,
                              width: 1.5,
                            ),
                          ),
                        ),
                        storyPages: List.generate(
                            element.storyData?.length ?? 0, (index) {
                          return FullStoryPage(
                            imageName: '${element.storyData?[index].storyData}',
                          );
                        }),
                        segmentDuration: const Duration(seconds: 3),
                      );
                      buttonDatas.add(buttonData1);
                      int curIndex = buttonDatas.length - 1;
                      storyButtons.add(StoryButton(
                          onPressed: (data) {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return NewStoryViewPage(
                                  data, buttonDatas, curIndex, User_ID!);
                            })).then((value) => Get_UserToken());
                            /*Navigator.of(storycontext!).push(
                              StoryRoute(
                                onTap: () async {
                                  await BlocProvider.of<GetGuestAllPostCubit>(
                                          context)
                                      .seetinonExpried(context);
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (context) {
                                    return ProfileScreen(
                                        User_ID: "${element.userUid}",
                                        isFollowing: "");
                                  })).then((value) => Get_UserToken());
                                },
                                storyContainerSettings: StoryContainerSettings(
                                  buttonData: buttonData1,
                                  tapPosition:
                                      buttonData1.buttonCenterPosition!,
                                  curve: buttonData1.pageAnimationCurve,
                                  allButtonDatas: buttonDatas,
                                  pageTransform: StoryPage3DTransform(),
                                  storyListScrollController: ScrollController(),
                                ),
                                duration: buttonData1.pageAnimationDuration,
                              ),
                            );*/
                          },
                          buttonData: buttonData1,
                          allButtonDatas: buttonDatas,
                          storyListViewController: ScrollController()));
                      userName.add(element.userName.toString());
                    }
                  });
                }
              }
              if (state is AutoEnterinLoadedState) {
                print("Auto Inter in Room Done");
                print(state.AutoEnterinData.object);
                SnackBar snackBar = SnackBar(
                  content: Text(state.AutoEnterinData.object ?? ""),
                  backgroundColor: ColorConstant.primary_color,
                );
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
                saveAutoEnterINRoom();
              }
              if (state is GetNotificationCountLoadedState) {
                saveNotificationCount(
                    state.GetNotificationCountData.object?.notificationCount ??
                        0,
                    state.GetNotificationCountData.object?.messageCount ?? 0);
              }
              if (state is OpenSharePostLoadedState) {
                if (state.OpenSharePostData.object?.postUid != "" &&
                    state.OpenSharePostData.object?.postUid != null) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => OpenSavePostImage(
                              PostID:
                                  "${state.OpenSharePostData.object?.postUid}",
                              index: 0,
                            )),
                  ).then((value) {
                    // Get_UserToken();

                    setColorr();
                  });
                } else {
                  await BlocProvider.of<GetGuestAllPostCubit>(context)
                      .seetinonExpried(context);
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return ProfileScreen(
                        User_ID: "${state.OpenSharePostData.object?.userUid}",
                        isFollowing: "");
                  })).then((value) => Get_UserToken());
                }
              }
              if (state is GetGuestAllPostLoadedState) {
                readmoree.clear();
                mainPostControllers.clear();
                videoUrls.clear();
                VideoPlayerController _controller =
                    VideoPlayerController.networkUrl(Uri.parse(''));
                apiCalingdone = true;
                AllGuestPostRoomData = state.GetGuestAllPostRoomData;

                AllGuestPostRoomData?.object?.content?.forEach((element) {
                  if (element.description != null) {
                    readmoree
                        .add((element.description?.length ?? 0) <= maxLength);
                  } else if (element.repostOn?.description != null) {
                    readmoree.add(
                        (element.repostOn?.description?.length ?? 0) <=
                            maxLength);
                  } else {
                    readmoree.add(false);
                  }

                  if (element.postDataType == 'VIDEO') {
                    if (element.postData?.isNotEmpty == true) {
                      videoUrls.add(element.postData?.first ?? '');
                    }
                    /* VideoPlayerController _controller =
                        VideoPlayerController.networkUrl(
                            Uri.parse(element.postData?.first ?? ''));
                    inList = ChewieController(
                      videoPlayerController: _controller,
                      autoPlay: true,
                      /*  looping: false,
                      allowFullScreen: true, */
                      materialProgressColors: ChewieProgressColors(
                          backgroundColor: Colors.grey,
                          playedColor: ColorConstant.primary_color),
                    ); */
                  } else if (element.repostOn?.postDataType == 'VIDEO') {
                    videoUrls.add(element.repostOn?.postData?.first ?? '');
                  } else {
                    videoUrls.add('');
                  }

                  /*  chewieController.add(inList ??
                      ChewieController(videoPlayerController: _controller)); */
                });
                print(
                    "readmoreereadmoreereadmoreereadmoree:-- ${readmoree.length}");
                /*  print("chewieController length -${chewieController.length}"); */
              }
              if (state is PostLikeLoadedState) {
                if (state.likePost.object != 'Post Liked Successfully' &&
                    state.likePost.object != 'Post Unliked Successfully') {
                  SnackBar snackBar = SnackBar(
                    content: Text(state.likePost.object.toString()),
                    backgroundColor: ColorConstant.primary_color,
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                }
                BlocProvider.of<GetGuestAllPostCubit>(context)
                    .FetchAllExpertsAPI(context);
                // await BlocProvider.of<GetGuestAllPostCubit>(context)
                //     .GetUserAllPostAPI(context, '1', showAlert: true);

                likePost = state.likePost;
              }
              if (state is UserTagLoadedState) {
                userTagModel = await state.userTagModel;
              }
            }, builder: (context, state) {
              return apiCalingdone == true
                  ? RefreshIndicator(
                      onRefresh: refreshdata,
                      color: Colors.white,
                      backgroundColor: ColorConstant.primary_color,
                      child: SingleChildScrollView(
                        controller: widget.scrollController,
                        child: Column(
                          children: [
                            SizedBox(
                              height: 15,
                            ),
                            /*  Padding(
                              padding: EdgeInsets.only(left: 16, right: 16),
                              child: Row(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      print("this seactin -${User_Module}");
                                    },
                                    child: SizedBox(
                                        height: 40,
                                        child: Image.asset(
                                            ImageConstant.splashImage)),
                                  ),
                                  Spacer(),
                                  UserStatus == 'REJECTED' ||
                                          User_Module == "EMPLOYEE" ||
                                          User_Module == null ||
                                          User_Module == ''
                                      ? GestureDetector(
                                          onTapDown: (TapDownDetails details) {
                                            _showPopupMenu(
                                              details.globalPosition,
                                              context,
                                            );
                                          },
                                          child: Container(
                                            height: 50,
                                            width: 50,
                                            decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: ColorConstant
                                                    .primary_color),
                                            child: Icon(
                                              Icons.person_add_alt,
                                              color: Colors.white,
                                            ),
                                          ),
                                        )
                                      : SizedBox(),
                                  SizedBox(
                                    width: 17,
                                  ),
                                  GestureDetector(
                                      onTap: () async {
                                        if (uuid == null) {
                                          /* Navigator.of(context).push(
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      RegisterCreateAccountScreen())); */
                                          /*     Navigator.removeRoute(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      RegisterCreateAccountScreen())); */
                                          Navigator.pushAndRemoveUntil(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      RegisterCreateAccountScreen()),
                                              (route) => true);
                                        } else {
                                          await BlocProvider.of<
                                                  GetGuestAllPostCubit>(context)
                                              .seetinonExpried(context);
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
                                                  User_ID: "${User_ID}",
                                                  isFollowing: 'FOLLOW',
                                                ));
                                          })).then((value) => Get_UserToken());
                                          /////
                                        }
                                      },
                                      child: uuid == null
                                          ? Text(
                                              'Login',
                                              style: TextStyle(
                                                  fontFamily: "outfit",
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold,
                                                  color: ColorConstant
                                                      .primary_color),
                                            )
                                          : UserProfileImage != null &&
                                                  UserProfileImage != ""
                                              ? CustomImageView(
                                                  url: "${UserProfileImage}",
                                                  // color: Colors.transparent,
                                                  height: 50,
                                                  width: 50,
                                                  fit: BoxFit.fill,
                                                  radius:
                                                      BorderRadius.circular(25),
                                                )
                                              : CustomImageView(
                                                  imagePath:
                                                      ImageConstant.tomcruse,
                                                  // color: Colors.transparent,
                                                  height: 50,
                                                  width: 50,
                                                  fit: BoxFit.fill,
                                                  radius:
                                                      BorderRadius.circular(25),
                                                )),
                                ],
                              ),
                            ), */

                            storyButtons == null
                                ? Container(
                                    height: 40,
                                    width: 200,
                                    color: Colors.amber,
                                  )
                                : Container(
                                    height: 90,
                                    margin:
                                        EdgeInsets.symmetric(horizontal: 16),
                                    child: ListView.separated(
                                      itemBuilder: (context, index) {
                                        if (index == 0) {
                                          if (!storyAdded)
                                            return GestureDetector(
                                              onTap: () async {
                                                ImageDataPostOne? imageDataPost;
                                                if (uuid != null) {
                                                  await BlocProvider.of<
                                                              GetGuestAllPostCubit>(
                                                          context)
                                                      .seetinonExpried(context);
                                                  if (Platform.isAndroid) {
                                                    final info =
                                                        await DeviceInfoPlugin()
                                                            .androidInfo;
                                                    if (num.parse(await info
                                                                .version
                                                                .release)
                                                            .toInt() >=
                                                        13) {
                                                      if (await permissionHandler(
                                                              context,
                                                              Permission
                                                                  .photos) ??
                                                          false) {
                                                        imageDataPost =
                                                            await Navigator.push(
                                                                context,
                                                                MaterialPageRoute(
                                                                    builder:
                                                                        (context) {
                                                          return CreateStoryPage(
                                                            finalFileSize:
                                                                finalFileSize,
                                                            finalvideoSize:
                                                                finalvideoSize,
                                                          );
                                                        }));

                                                        print("this is the 1");
                                                        if (imageDataPost
                                                                ?.object
                                                                ?.split('.')
                                                                .last ==
                                                            'mp4') {
                                                          var parmes = {
                                                            "storyData":
                                                                imageDataPost
                                                                    ?.object,
                                                            "storyType":
                                                                "VIDEO",
                                                            "videoDuration":
                                                                imageDataPost
                                                                    ?.videodurationGet
                                                          };
                                                          print(
                                                              "scdfhgsdfhsd-${parmes}");
                                                          Repository()
                                                              .cretateStoryApi(
                                                                  context,
                                                                  parmes);
                                                          isWatch = true;
                                                          Get_UserToken();
                                                        } else {
                                                          var parmes = {
                                                            "storyData":
                                                                imageDataPost
                                                                    ?.object
                                                                    .toString(),
                                                            "storyType": "TEXT",
                                                            "videoDuration": ''
                                                          };
                                                          print(
                                                              "CHECK:--------${parmes}");
                                                          Repository()
                                                              .cretateStoryApi(
                                                                  context,
                                                                  parmes);
                                                          isWatch = true;
                                                          Get_UserToken();
                                                        }
                                                      }
                                                    } else if (await permissionHandler(
                                                            context,
                                                            Permission
                                                                .storage) ??
                                                        false) {
                                                      print("this is the 3");

                                                      imageDataPost =
                                                          await Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                  builder:
                                                                      (context) {
                                                        return CreateStoryPage(
                                                          finalFileSize:
                                                              finalFileSize,
                                                          finalvideoSize:
                                                              finalvideoSize,
                                                        );
                                                      }));

                                                      if (imageDataPost?.object
                                                              ?.split('.')
                                                              .last ==
                                                          'mp4') {
                                                        var parmes = {
                                                          "storyData":
                                                              imageDataPost
                                                                  ?.object,
                                                          "storyType": "VIDEO",
                                                          "videoDuration":
                                                              imageDataPost
                                                                  ?.videodurationGet
                                                        };
                                                        print(
                                                            "scdfhgsdfhsd-${parmes}");
                                                        Repository()
                                                            .cretateStoryApi(
                                                                context,
                                                                parmes);
                                                        isWatch = true;
                                                        Get_UserToken();
                                                      } else {
                                                        var parmes = {
                                                          "storyData":
                                                              imageDataPost
                                                                  ?.object
                                                                  .toString(),
                                                          "storyType": "TEXT",
                                                          "videoDuration": ''
                                                        };
                                                        print(
                                                            "CHECK:--------${parmes}");
                                                        Repository()
                                                            .cretateStoryApi(
                                                                context,
                                                                parmes);
                                                        isWatch = true;
                                                        Get_UserToken();
                                                      }
                                                    }
                                                  }
                                                  if (Platform.isIOS) {
// final info =
//                                                   await DeviceInfoPlugin()
//                                                       .androidInfo;
                                                    // if (num.parse(await info
                                                    //             .version.release)
                                                    //         .toInt() >=
                                                    //     13) {
                                                    //   if (await permissionHandler(
                                                    //           context,
                                                    //           Permission.photos) ??
                                                    //       false) {
                                                    //     imageDataPost =
                                                    //         await Navigator.push(
                                                    //             context,
                                                    //             MaterialPageRoute(
                                                    //                 builder:
                                                    //                     (context) {
                                                    //       return CreateStoryPage(
                                                    //         finalFileSize:
                                                    //             finalFileSize,
                                                    //         finalvideoSize:
                                                    //             finalvideoSize,
                                                    //       );
                                                    //     }));

                                                    //     print("this is the 1");
                                                    //     if (imageDataPost?.object
                                                    //             ?.split('.')
                                                    //             .last ==
                                                    //         'mp4') {
                                                    //       var parmes = {
                                                    //         "storyData":
                                                    //             imageDataPost?.object,
                                                    //         "storyType": "VIDEO",
                                                    //         "videoDuration":
                                                    //             imageDataPost
                                                    //                 ?.videodurationGet
                                                    //       };
                                                    //       print(
                                                    //           "scdfhgsdfhsd-${parmes}");
                                                    //       Repository()
                                                    //           .cretateStoryApi(
                                                    //               context, parmes);
                                                    //       isWatch = true;
                                                    //       Get_UserToken();
                                                    //     } else {
                                                    //       var parmes = {
                                                    //         "storyData": imageDataPost
                                                    //             ?.object
                                                    //             .toString(),
                                                    //         "storyType": "TEXT",
                                                    //         "videoDuration": ''
                                                    //       };
                                                    //       print(
                                                    //           "CHECK:--------${parmes}");
                                                    //       Repository()
                                                    //           .cretateStoryApi(
                                                    //               context, parmes);
                                                    //       isWatch = true;
                                                    //       Get_UserToken();
                                                    //     }
                                                    //   }
                                                    // } else if (await permissionHandler(
                                                    //         context,
                                                    //         Permission.storage) ??
                                                    //     false) {
                                                    print("this is the 3");

                                                    imageDataPost =
                                                        await Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                                builder:
                                                                    (context) {
                                                      return CreateStoryPage(
                                                        finalFileSize:
                                                            finalFileSize,
                                                        finalvideoSize:
                                                            finalvideoSize,
                                                      );
                                                    }));

                                                    if (imageDataPost?.object
                                                            ?.split('.')
                                                            .last ==
                                                        'mp4') {
                                                      var parmes = {
                                                        "storyData":
                                                            imageDataPost
                                                                ?.object,
                                                        "storyType": "VIDEO",
                                                        "videoDuration":
                                                            imageDataPost
                                                                ?.videodurationGet
                                                      };
                                                      print(
                                                          "scdfhgsdfhsd-${parmes}");
                                                      Repository()
                                                          .cretateStoryApi(
                                                              context, parmes);
                                                      isWatch = true;
                                                      Get_UserToken();
                                                    } else {
                                                      var parmes = {
                                                        "storyData":
                                                            imageDataPost
                                                                ?.object
                                                                .toString(),
                                                        "storyType": "TEXT",
                                                        "videoDuration": ''
                                                      };
                                                      print(
                                                          "CHECK:--------${parmes}");
                                                      Repository()
                                                          .cretateStoryApi(
                                                              context, parmes);
                                                      isWatch = true;
                                                      Get_UserToken();
                                                    }
                                                    // }
                                                  }
                                                } else {
                                                  Navigator.of(context).push(
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              RegisterCreateAccountScreen()));
                                                }

                                                if (imageDataPost?.object !=
                                                    null) {
                                                  StoryButtonData buttonData =
                                                      StoryButtonData(
                                                    timelineBackgroundColor:
                                                        Colors.grey,
                                                    buttonDecoration:
                                                        UserProfileImage !=
                                                                    null &&
                                                                UserProfileImage !=
                                                                    ""
                                                            ? BoxDecoration(
                                                                shape: BoxShape
                                                                    .circle,
                                                                image:
                                                                    DecorationImage(
                                                                  image: NetworkImage(
                                                                      "${UserProfileImage}"),
                                                                  fit: BoxFit
                                                                      .fill,
                                                                ),
                                                              )
                                                            : BoxDecoration(
                                                                shape: BoxShape
                                                                    .circle,
                                                                image:
                                                                    DecorationImage(
                                                                  image:
                                                                      AssetImage(
                                                                    ImageConstant
                                                                        .tomcruse,
                                                                  ),
                                                                  fit: BoxFit
                                                                      .cover,
                                                                ),
                                                              ),
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              5.0),
                                                      child: Column(
                                                        mainAxisSize:
                                                            MainAxisSize.max,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .end,
                                                        children: [
                                                          Text(
                                                            '',
                                                            style:
                                                                const TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    images: [
                                                      StoryModel(
                                                          imageDataPost!.object
                                                              .toString(),
                                                          DateTime.now()
                                                              .toIso8601String(),
                                                          UserProfileImage,
                                                          User_Name,
                                                          "",
                                                          "${User_ID}",
                                                          0,
                                                          imageDataPost
                                                                  .videodurationGet ??
                                                              15)
                                                    ],
                                                    isWatch: false,
                                                    borderDecoration:
                                                        BoxDecoration(
                                                      borderRadius:
                                                          const BorderRadius
                                                              .all(
                                                        Radius.circular(60.0),
                                                      ),
                                                      border:
                                                          Border.fromBorderSide(
                                                        BorderSide(
                                                          color: Colors.red,
                                                          width: 1.5,
                                                        ),
                                                      ),
                                                    ),
                                                    storyPages: [
                                                      FullStoryPage(
                                                        imageName:
                                                            '${imageDataPost.object}',
                                                      )
                                                    ],
                                                    segmentDuration:
                                                        const Duration(
                                                            seconds: 3),
                                                  );

                                                  buttonDatas.insert(
                                                      0, buttonData);
                                                  storyButtons[0] = StoryButton(
                                                      onPressed: (data) {
                                                        Navigator.push(context,
                                                            MaterialPageRoute(
                                                                builder:
                                                                    (context) {
                                                          return NewStoryViewPage(
                                                              data,
                                                              buttonDatas,
                                                              0,
                                                              User_ID!);
                                                        })).then((value) =>
                                                            Get_UserToken());
                                                        /*Navigator.of(
                                                                storycontext!)
                                                            .push(
                                                              StoryRoute(
                                                                onTap:
                                                                    () async {
                                                                  await BlocProvider.of<
                                                                              GetGuestAllPostCubit>(
                                                                          context)
                                                                      .seetinonExpried(
                                                                          context);
                                                                  Navigator.push(
                                                                      context,
                                                                      MaterialPageRoute(
                                                                          builder:
                                                                              (context) {
                                                                    return ProfileScreen(
                                                                        User_ID:
                                                                            "${User_ID}",
                                                                        isFollowing:
                                                                            "");
                                                                  })).then(
                                                                      (value) =>
                                                                          Get_UserToken());
                                                                },
                                                                storyContainerSettings:
                                                                    StoryContainerSettings(
                                                                  buttonData:
                                                                      buttonData,
                                                                  tapPosition:
                                                                      buttonData
                                                                          .buttonCenterPosition!,
                                                                  curve: buttonData
                                                                      .pageAnimationCurve,
                                                                  allButtonDatas:
                                                                      buttonDatas,
                                                                  pageTransform:
                                                                      StoryPage3DTransform(),
                                                                  storyListScrollController:
                                                                      ScrollController(),
                                                                ),
                                                                duration: buttonData
                                                                    .pageAnimationDuration,
                                                              ),
                                                            )
                                                            .then((value) =>
                                                                Get_UserToken());*/
                                                      },
                                                      buttonData: buttonData,
                                                      allButtonDatas:
                                                          buttonDatas,
                                                      storyListViewController:
                                                          ScrollController());
                                                  userName[0] = "Your Story";

                                                  if (mounted)
                                                    setState(() {
                                                      storyAdded = true;
                                                      // BlocProvider.of<
                                                      //     GetGuestAllPostCubit>(
                                                      //     context)
                                                      //     .get_all_story(
                                                      //   context,
                                                      // );
                                                    });
                                                }
                                              },
                                              child: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  DottedBorder(
                                                    borderType:
                                                        BorderType.Circle,
                                                    dashPattern: [5, 5, 5, 5],
                                                    color: ColorConstant
                                                        .primary_color,
                                                    child: Container(
                                                      height: 67,
                                                      width: 67,
                                                      decoration: BoxDecoration(
                                                          shape:
                                                              BoxShape.circle,
                                                          color: ColorConstant
                                                              .primaryLight_color),
                                                      child: Icon(
                                                        Icons
                                                            .add_circle_outline_rounded,
                                                        color: ColorConstant
                                                            .primary_color,
                                                      ),
                                                    ),
                                                  ),
                                                  Text(
                                                    /// jinal code 14022024
                                                    'Your Story',
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 16),
                                                  )
                                                ],
                                              ),
                                            );
                                          else if (storyButtons[index] !=
                                              null) {
                                            return SizedBox(
                                              child: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Expanded(
                                                    child: Stack(
                                                      children: [
                                                        storyButtons[index]!,
                                                        Positioned(
                                                          bottom: 0,
                                                          right: 0,
                                                          child:
                                                              GestureDetector(
                                                            onTap:
                                                                methodCalling,
                                                            child: Container(
                                                              decoration: BoxDecoration(
                                                                  color: Colors
                                                                      .white,
                                                                  shape: BoxShape
                                                                      .circle),
                                                              child: Icon(
                                                                Icons
                                                                    .add_circle_rounded,
                                                                color: ColorConstant
                                                                    .primary_color,
                                                              ),
                                                            ),
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                    flex: 1,
                                                  ),
                                                  Text(
                                                    /// jinal code 14022024
                                                    'Your Story',
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 16),
                                                  ),
                                                ],
                                              ),
                                            );
                                          }
                                        } else {
                                          return SizedBox(
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Expanded(
                                                  child: storyButtons[index]!,
                                                  flex: 1,
                                                ),
                                                if (userName[index].isNotEmpty)
                                                  Text(
                                                    '${userName[index]}',
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 16),
                                                  )
                                              ],
                                            ),
                                          );
                                        }
                                      },
                                      separatorBuilder: (context, index) {
                                        return SizedBox(
                                          width: 8,
                                        );
                                      },
                                      itemCount: storyButtons.length,
                                      scrollDirection: Axis.horizontal,
                                    ),
                                  ),
                            SizedBox(
                              height: 15,
                            ),
                            AllGuestPostRoomData?.object?.content?.length !=
                                        0 ||
                                    AllGuestPostRoomData
                                            ?.object?.content?.isNotEmpty ==
                                        true
                                ? PaginationWidget1(
                                    scrollController: widget.scrollController,
                                    totalSize: AllGuestPostRoomData
                                        ?.object?.totalElements,
                                    offSet: AllGuestPostRoomData
                                        ?.object?.pageable?.pageNumber,
                                    onPagination: ((p0) async {
                                      if (User_ID != null) {
                                        await BlocProvider.of<
                                                GetGuestAllPostCubit>(context)
                                            .GetUserAllPostAPIPagantion(
                                                context, (p0 + 1).toString(),
                                                showAlert: true);
                                      } else {
                                        await BlocProvider.of<
                                                GetGuestAllPostCubit>(context)
                                            .GetGuestAllPostAPIPagantion(
                                                context, (p0 + 1).toString(),
                                                showAlert: true);
                                      }
                                    }),
                                    items: ListView.separated(
                                      padding: EdgeInsets.zero,
                                      physics: NeverScrollableScrollPhysics(),
                                      itemCount: AllGuestPostRoomData
                                              ?.object?.content?.length ??
                                          0,
                                      shrinkWrap: true,
                                      itemBuilder: (context, index) {
                                        if (!added) {
                                          AllGuestPostRoomData?.object?.content
                                              ?.forEach((element) {
                                            _pageControllers
                                                .add(PageController());
                                            _currentPages.add(0);
                                          });
                                          AllGuestPostRoomData?.object?.content
                                              ?.forEach((element) {
                                            _pageControllers1
                                                .add(PageController());
                                            _currentPages1.add(0);
                                          });
                                          AllGuestPostRoomData?.object?.content
                                              ?.forEach((element) {
                                            _pageControllers2
                                                .add(PageController());
                                            _currentPages2.add(0);
                                          });

                                          WidgetsBinding.instance
                                              .addPostFrameCallback(
                                                  (timeStamp) =>
                                                      super.setState(() {
                                                        added = true;
                                                      }));
                                        }
                                        if (AllGuestPostRoomData?.object
                                                ?.content?[index].description !=
                                            null) {
                                          String inputText =
                                              "${AllGuestPostRoomData?.object?.content?[index].description}";
                                        }
                                        DateTime parsedDateTime = DateTime.parse(
                                            '${AllGuestPostRoomData?.object?.content?[index].createdAt ?? ""}');
                                        DateTime? repostTime;
                                        if (AllGuestPostRoomData!.object!
                                                .content![index].repostOn !=
                                            null) {
                                          repostTime = DateTime.parse(
                                              '${AllGuestPostRoomData?.object?.content?[index].repostOn!.createdAt ?? ""}');
                                          print(
                                              "repost time = $parsedDateTime");
                                        }
                                        bool DataGet = false;
                                        if (AllGuestPostRoomData
                                                    ?.object
                                                    ?.content?[index]
                                                    .description !=
                                                null &&
                                            AllGuestPostRoomData
                                                    ?.object
                                                    ?.content?[index]
                                                    .description !=
                                                '') {
                                          DataGet = _isLink(
                                              '${AllGuestPostRoomData?.object?.content?[index].description}');
                                        }
                                        // LangDetect("${AllGuestPostRoomData?.object?.content?[index].description}",index);
                                        // this is the data
                                        if (AllGuestPostRoomData
                                                ?.object
                                                ?.content?[index]
                                                .postDataType ==
                                            "ATTACHMENT") {}
                                        GlobalKey buttonKey = GlobalKey(); //
                                        return AllGuestPostRoomData
                                                    ?.object
                                                    ?.content?[index]
                                                    .isReports ==
                                                true
                                            ? Container(
                                                width: _width,
                                                decoration: BoxDecoration(
                                                  color: Color(0xffF0F0F0),
                                                ),
                                                child: Column(
                                                  children: [
                                                    SizedBox(
                                                      height: 10,
                                                    ),
                                                    SizedBox(
                                                        height: 20,
                                                        child: Image.asset(
                                                            ImageConstant
                                                                .greenseen)),
                                                    SizedBox(
                                                      height: 10,
                                                    ),
                                                    Text(
                                                      'Thanks for reporting',
                                                      style: TextStyle(
                                                          color: Colors.black),
                                                    ),
                                                    SizedBox(
                                                      height: 5,
                                                    ),
                                                    Text(
                                                      'Post Reported and under review',
                                                      style: TextStyle(
                                                          color: Colors.grey),
                                                    ),
                                                    SizedBox(
                                                      height: 20,
                                                    ),
                                                  ],
                                                ),
                                              )
                                            : AllGuestPostRoomData
                                                        ?.object
                                                        ?.content?[index]
                                                        .repostOn !=
                                                    null
                                                ? Padding(
                                                    padding: EdgeInsets.only(
                                                        left: 0, right: 0),
                                                    child: GestureDetector(
                                                      onTap: () {
                                                        if (AllGuestPostRoomData
                                                                ?.object
                                                                ?.content?[
                                                                    index]
                                                                .postDataType !=
                                                            "ATTACHMENT") {
                                                          Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                builder: (context) => OpenSavePostImage(
                                                                    PostID: AllGuestPostRoomData
                                                                        ?.object
                                                                        ?.content?[
                                                                            index]
                                                                        .postUid),
                                                              )).then((value) {
                                                            // Get_UserToken();

                                                            setColorr();
                                                          });
                                                        }
                                                      },
                                                      onDoubleTap: () async {
                                                        await soicalFunation(
                                                            apiName:
                                                                'like_post',
                                                            index: index);
                                                      },
                                                      child: AllGuestPostRoomData
                                                                  ?.object
                                                                  ?.content?[
                                                                      index]
                                                                  .isReports ==
                                                              true
                                                          ? Container(
                                                              width: _width,
                                                              decoration:
                                                                  BoxDecoration(
                                                                color: Color(
                                                                    0xffF0F0F0),
                                                              ),
                                                              child: Column(
                                                                children: [
                                                                  SizedBox(
                                                                    height: 10,
                                                                  ),
                                                                  SizedBox(
                                                                      height:
                                                                          20,
                                                                      child: Image.asset(
                                                                          ImageConstant
                                                                              .greenseen)),
                                                                  SizedBox(
                                                                    height: 10,
                                                                  ),
                                                                  Text(
                                                                    'Thanks for reporting',
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .black),
                                                                  ),
                                                                  SizedBox(
                                                                    height: 5,
                                                                  ),
                                                                  Text(
                                                                    'Post Reported and under review',
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .grey),
                                                                  ),
                                                                  SizedBox(
                                                                    height: 20,
                                                                  ),
                                                                ],
                                                              ),
                                                            )
                                                          : Container(
                                                              decoration:
                                                                  BoxDecoration(
                                                                color: Colors
                                                                    .white,
                                                                border: Border.all(
                                                                    color: Color
                                                                        .fromRGBO(
                                                                            0,
                                                                            0,
                                                                            0,
                                                                            0.25)),
                                                                /*  borderRadius:
                                                            BorderRadius
                                                                .circular(15) */
                                                              ),
                                                              // height: 300,
                                                              width: _width,
                                                              child: Column(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  SizedBox(
                                                                    height: 10,
                                                                  ),
                                                                  Container(
                                                                    height: 60,
                                                                    child:
                                                                        ListTile(
                                                                      leading:
                                                                          GestureDetector(
                                                                        onTap:
                                                                            () async {
                                                                          if (uuid ==
                                                                              null) {
                                                                            Navigator.of(context).push(MaterialPageRoute(builder: (context) => RegisterCreateAccountScreen()));
                                                                          } else {
                                                                            await BlocProvider.of<GetGuestAllPostCubit>(context).seetinonExpried(context);
                                                                            Navigator.push(context, MaterialPageRoute(builder:
                                                                                (context) {
                                                                              return MultiBlocProvider(providers: [
                                                                                BlocProvider<NewProfileSCubit>(
                                                                                  create: (context) => NewProfileSCubit(),
                                                                                ),
                                                                              ], child: ProfileScreen(User_ID: "${AllGuestPostRoomData?.object?.content?[index].userUid}", isFollowing: AllGuestPostRoomData?.object?.content?[index].isFollowing));
                                                                            })).then((value) =>
                                                                                Get_UserToken());

                                                                            ///
                                                                          }
                                                                        },
                                                                        child: AllGuestPostRoomData?.object?.content?[index].userProfilePic != null &&
                                                                                AllGuestPostRoomData?.object?.content?[index].userProfilePic != ""
                                                                            ? CircleAvatar(
                                                                                backgroundImage: NetworkImage("${AllGuestPostRoomData?.object?.content?[index].userProfilePic}"),
                                                                                backgroundColor: Colors.white,
                                                                                radius: 25,
                                                                              )
                                                                            : CustomImageView(
                                                                                imagePath: ImageConstant.tomcruse,
                                                                                height: 50,
                                                                                width: 50,
                                                                                fit: BoxFit.fill,
                                                                                radius: BorderRadius.circular(25),
                                                                              ),
                                                                      ),
                                                                      title:
                                                                          Column(
                                                                        crossAxisAlignment:
                                                                            CrossAxisAlignment.start,
                                                                        children: [
                                                                          SizedBox(
                                                                            height:
                                                                                8,
                                                                          ),
                                                                          GestureDetector(
                                                                            onTap:
                                                                                () async {
                                                                              if (uuid == null) {
                                                                                Navigator.of(context).push(MaterialPageRoute(builder: (context) => RegisterCreateAccountScreen()));
                                                                              } else {
                                                                                await BlocProvider.of<GetGuestAllPostCubit>(context).seetinonExpried(context);
                                                                                Navigator.push(context, MaterialPageRoute(builder: (context) {
                                                                                  return MultiBlocProvider(providers: [
                                                                                    BlocProvider<NewProfileSCubit>(
                                                                                      create: (context) => NewProfileSCubit(),
                                                                                    ),
                                                                                  ], child: ProfileScreen(User_ID: "${AllGuestPostRoomData?.object?.content?[index].userUid}", isFollowing: AllGuestPostRoomData?.object?.content?[index].isFollowing));
                                                                                })).then((value) => Get_UserToken());

                                                                                //
                                                                              }
                                                                            },
                                                                            child:
                                                                                Container(
                                                                              // color: Colors.amber,
                                                                              child: Text(
                                                                                "${AllGuestPostRoomData?.object?.content?[index].postUserName}",
                                                                                style: TextStyle(fontSize: 20, fontFamily: "outfit", fontWeight: FontWeight.bold),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          Text(
                                                                            getTimeDifference(parsedDateTime),
                                                                            style:
                                                                                TextStyle(
                                                                              fontSize: 12,
                                                                              fontFamily: "outfit",
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                      trailing: User_ID ==
                                                                              AllGuestPostRoomData?.object?.content?[index].userUid
                                                                          ? GestureDetector(
                                                                              key: buttonKey,
                                                                              onTap: () {
                                                                                showPopupMenu(context, index, buttonKey);
                                                                              },
                                                                              /*  onTapDown:
                                                                  (TapDownDetails
                                                                      details) {
                                                                delete_dilog_menu(
                                                                  details
                                                                      .globalPosition,
                                                                  context,
                                                                );
                                                              },
                                                              onTap: () {
                                                                Navigator.pop(
                                                                    context);
                                                              }, */
                                                                              child: Icon(
                                                                                Icons.more_vert_rounded,
                                                                              ))
                                                                          : GestureDetector(
                                                                              onTap: () async {
                                                                                await soicalFunation(
                                                                                  apiName: 'Follow',
                                                                                  index: index,
                                                                                );
                                                                              },
                                                                              child: Container(
                                                                                height: 25,
                                                                                alignment: Alignment.center,
                                                                                width: 65,
                                                                                margin: EdgeInsets.only(bottom: 5),
                                                                                decoration: BoxDecoration(color: ColorConstant.primary_color, borderRadius: BorderRadius.circular(4)),
                                                                                child: uuid == null
                                                                                    ? Text(
                                                                                        'Follow',
                                                                                        style: TextStyle(fontFamily: "outfit", fontSize: 12, fontWeight: FontWeight.bold, color: Colors.white),
                                                                                      )
                                                                                    : AllGuestPostRoomData?.object?.content?[index].userAccountType == "PUBLIC"
                                                                                        ? (AllGuestPostRoomData?.object?.content?[index].isFollowing == 'FOLLOW'
                                                                                            ? Text(
                                                                                                'Follow',
                                                                                                style: TextStyle(fontFamily: "outfit", fontSize: 12, fontWeight: FontWeight.bold, color: Colors.white),
                                                                                              )
                                                                                            : Text(
                                                                                                'Following ',
                                                                                                style: TextStyle(fontFamily: "outfit", fontSize: 12, fontWeight: FontWeight.bold, color: Colors.white),
                                                                                              ))
                                                                                        : AllGuestPostRoomData?.object?.content?[index].isFollowing == 'FOLLOW'
                                                                                            ? Text(
                                                                                                'Follow',
                                                                                                style: TextStyle(fontFamily: "outfit", fontSize: 12, fontWeight: FontWeight.bold, color: Colors.white),
                                                                                              )
                                                                                            : AllGuestPostRoomData?.object?.content?[index].isFollowing == 'REQUESTED'
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
                                                                  ),
                                                                  SizedBox(
                                                                    height: 10,
                                                                  ),

                                                                  AllGuestPostRoomData
                                                                              ?.object
                                                                              ?.content?[index]
                                                                              .description !=
                                                                          null
                                                                      ? Padding(
                                                                          padding:
                                                                              const EdgeInsets.only(left: 16),
                                                                          child: GestureDetector(
                                                                              onTap: () async {
                                                                                if (DataGet == true) {
                                                                                  await launch('${AllGuestPostRoomData?.object?.content?[index].description}', forceWebView: true, enableJavaScript: true);
                                                                                } else {
                                                                                  Navigator.push(
                                                                                    context,
                                                                                    MaterialPageRoute(
                                                                                        builder: (context) => OpenSavePostImage(
                                                                                              PostID: AllGuestPostRoomData?.object?.content?[index].postUid,
                                                                                            )),
                                                                                  ).then((value) {
                                                                                    // Get_UserToken();

                                                                                    setColorr();
                                                                                  });
                                                                                }
                                                                              },
                                                                              child: Column(
                                                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                                                children: [
                                                                                  Row(
                                                                                    children: [
                                                                                      Expanded(
                                                                                        child: Container(
                                                                                          // color: Colors.amber,
                                                                                          child: LinkifyText(
                                                                                            // AllGuestPostRoomData?.object?.content?[index].isTrsnalteoption == false || AllGuestPostRoomData?.object?.content?[index].isTrsnalteoption == null ? "${AllGuestPostRoomData?.object?.content?[index].description}" : "${AllGuestPostRoomData?.object?.content?[index].translatedDescription}",
                                                                                            readmoree[index] == true
                                                                                                ? (AllGuestPostRoomData?.object?.content?[index].isTrsnalteoption == false || AllGuestPostRoomData?.object?.content?[index].isTrsnalteoption == null)
                                                                                                    ? "${AllGuestPostRoomData?.object?.content?[index].description}${(AllGuestPostRoomData?.object?.content?[index].description?.length ?? 0) > maxLength ? ' ....ReadLess' : ''}"
                                                                                                    : "${AllGuestPostRoomData?.object?.content?[index].translatedDescription}"
                                                                                                : (AllGuestPostRoomData?.object?.content?[index].isTrsnalteoption == false || AllGuestPostRoomData?.object?.content?[index].isTrsnalteoption == null)
                                                                                                    ? "${AllGuestPostRoomData?.object?.content?[index].description?.substring(0, maxLength)} ....ReadMore"
                                                                                                    : "${AllGuestPostRoomData?.object?.content?[index].translatedDescription?.substring(0, maxLength)} ....ReadMore", // asdsd
                                                                                            linkStyle: TextStyle(
                                                                                              color: Colors.blue,
                                                                                              fontFamily: 'outfit',
                                                                                            ),
                                                                                            textStyle: TextStyle(
                                                                                              color: Colors.black,
                                                                                              fontFamily: 'outfit',
                                                                                            ),
                                                                                            linkTypes: [
                                                                                              LinkType.url,
                                                                                              LinkType.userTag,
                                                                                              LinkType.hashTag,
                                                                                              // LinkType
                                                                                              //     .email
                                                                                            ],
                                                                                            onTap: (link) async {
                                                                                              /// do stuff with `link` like
                                                                                              /// if(link.type == Link.url) launchUrl(link.value);

                                                                                              var SelectedTest = link.value.toString();
                                                                                              var Link = SelectedTest.startsWith('https');
                                                                                              var Link1 = SelectedTest.startsWith('http');
                                                                                              var Link2 = SelectedTest.startsWith('www');
                                                                                              var Link3 = SelectedTest.startsWith('WWW');
                                                                                              var Link4 = SelectedTest.startsWith('HTTPS');
                                                                                              var Link5 = SelectedTest.startsWith('HTTP');
                                                                                              var Link6 = SelectedTest.startsWith('https://pdslink.page.link/');
                                                                                              print(SelectedTest.toString());
                                                                                              if ((AllGuestPostRoomData?.object?.content?[index].description?.length ?? 0) > maxLength) {
                                                                                                // if (User_ID == null) {
                                                                                                //   Navigator.of(context).push(MaterialPageRoute(builder: (context) => RegisterCreateAccountScreen()));
                                                                                                // } else {
                                                                                                if (Link == true || Link1 == true || Link2 == true || Link3 == true || Link4 == true || Link5 == true || Link6 == true) {
                                                                                                  print("ssaddsaddsdssaddsaddsdssaddsaddsdssaddsaddsd:- 1");
                                                                                                  if (Link2 == true || Link3 == true) {
                                                                                                    print("ssaddsaddsdssaddsaddsdssaddsaddsdssaddsaddsd:- 2");
                                                                                                    launchUrl(Uri.parse("https://${link.value.toString()}"));
                                                                                                    print("qqqqqqqqhttps://${link.value}");
                                                                                                  } else {
                                                                                                    print("ssaddsaddsdssaddsaddsdssaddsaddsdssaddsaddsd:- 3");
                                                                                                    if (Link6 == true) {
                                                                                                      print("ssaddsaddsdssaddsaddsdssaddsaddsdssaddsaddsd:- 4");
                                                                                                      print("yes i am inList =   room");
                                                                                                      Navigator.push(context, MaterialPageRoute(
                                                                                                        builder: (context) {
                                                                                                          return NewBottomBar(
                                                                                                            buttomIndex: 1,
                                                                                                          );
                                                                                                        },
                                                                                                      ));
                                                                                                    } else {
                                                                                                      print("ssaddsaddsdssaddsaddsdssaddsaddsdssaddsaddsd:- 5");
                                                                                                      launchUrl(Uri.parse(link.value.toString()));
                                                                                                      print("link.valuelink.value -- ${link.value}");
                                                                                                    }
                                                                                                  }
                                                                                                } else {
                                                                                                  print("ssaddsaddsdssaddsaddsdssaddsaddsdssaddsaddsd:- 6");
                                                                                                  if (link.value!.startsWith('#')) {
                                                                                                    print("ssaddsaddsdssaddsaddsdssaddsaddsdssaddsaddsd:- 7");
                                                                                                    await BlocProvider.of<GetGuestAllPostCubit>(context).seetinonExpried(context);
                                                                                                    Navigator.push(
                                                                                                        context,
                                                                                                        MaterialPageRoute(
                                                                                                          builder: (context) => HashTagViewScreen(title: "${link.value}"),
                                                                                                        ));
                                                                                                  } else if (link.value!.startsWith('@')) {
                                                                                                    print("ssaddsaddsdssaddsaddsdssaddsaddsdssaddsaddsd:- 8");
                                                                                                    await BlocProvider.of<GetGuestAllPostCubit>(context).seetinonExpried(context);
                                                                                                    var name;
                                                                                                    var tagName;
                                                                                                    name = SelectedTest;
                                                                                                    tagName = name.replaceAll("@", "");
                                                                                                    await BlocProvider.of<GetGuestAllPostCubit>(context).UserTagAPI(context, tagName);

                                                                                                    Navigator.push(context, MaterialPageRoute(builder: (context) {
                                                                                                      return ProfileScreen(User_ID: "${userTagModel?.object}", isFollowing: "");
                                                                                                    })).then((value) => Get_UserToken());

                                                                                                    print("tagName -- ${tagName}");
                                                                                                    print("user id -- ${userTagModel?.object}");
                                                                                                  } else {
                                                                                                    print("ssaddsaddsdssaddsaddsdssaddsaddsdssaddsaddsd:- 9");
                                                                                                    // launchUrl(Uri.parse("https://${link.value.toString()}"));
                                                                                                    setState(() {
                                                                                                      if (readmoree[index] == true) {
                                                                                                        readmoree[index] = false;
                                                                                                        print("--------------false ");
                                                                                                      } else {
                                                                                                        readmoree[index] = true;
                                                                                                        print("-------------- true");
                                                                                                      }
                                                                                                    });
                                                                                                  }
                                                                                                }
                                                                                                // }

                                                                                                // setState(() {
                                                                                                //   if (readmoree[index] == true) {
                                                                                                //     readmoree[index] = false;
                                                                                                //     print("--------------false ");
                                                                                                //   } else {
                                                                                                //     readmoree[index] = true;
                                                                                                //     print("-------------- true");
                                                                                                //   }
                                                                                                // });
                                                                                              } else {
                                                                                                if (User_ID == null) {
                                                                                                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => RegisterCreateAccountScreen()));
                                                                                                } else {
                                                                                                  if (Link == true || Link1 == true || Link2 == true || Link3 == true || Link4 == true || Link5 == true || Link6 == true) {
                                                                                                    if (Link2 == true || Link3 == true) {
                                                                                                      launchUrl(Uri.parse("https://${link.value.toString()}"));
                                                                                                      print("qqqqqqqqhttps://${link.value}");
                                                                                                    } else {
                                                                                                      if (Link6 == true) {
                                                                                                        print("yes i am inList =   room");
                                                                                                        Navigator.push(context, MaterialPageRoute(
                                                                                                          builder: (context) {
                                                                                                            return NewBottomBar(
                                                                                                              buttomIndex: 1,
                                                                                                            );
                                                                                                          },
                                                                                                        ));
                                                                                                      } else {
                                                                                                        launchUrl(Uri.parse(link.value.toString()));
                                                                                                        print("link.valuelink.value -- ${link.value}");
                                                                                                      }
                                                                                                    }
                                                                                                  } else {
                                                                                                    if (link.value!.startsWith('#')) {
                                                                                                      await BlocProvider.of<GetGuestAllPostCubit>(context).seetinonExpried(context);
                                                                                                      Navigator.push(
                                                                                                          context,
                                                                                                          MaterialPageRoute(
                                                                                                            builder: (context) => HashTagViewScreen(title: "${link.value}"),
                                                                                                          ));
                                                                                                    } else if (link.value!.startsWith('@')) {
                                                                                                      await BlocProvider.of<GetGuestAllPostCubit>(context).seetinonExpried(context);
                                                                                                      var name;
                                                                                                      var tagName;
                                                                                                      name = SelectedTest;
                                                                                                      tagName = name.replaceAll("@", "");
                                                                                                      await BlocProvider.of<GetGuestAllPostCubit>(context).UserTagAPI(context, tagName);

                                                                                                      Navigator.push(context, MaterialPageRoute(builder: (context) {
                                                                                                        return ProfileScreen(User_ID: "${userTagModel?.object}", isFollowing: "");
                                                                                                      })).then((value) => Get_UserToken());

                                                                                                      print("tagName -- ${tagName}");
                                                                                                      print("user id -- ${userTagModel?.object}");
                                                                                                    } else {
                                                                                                      // launchUrl(Uri.parse("https://${link.value.toString()}"));
                                                                                                    }
                                                                                                  }
                                                                                                }
                                                                                              }
                                                                                            },
                                                                                          ),
                                                                                        ),
                                                                                      ),
                                                                                    ],
                                                                                  ),
                                                                                  AllGuestPostRoomData?.object?.content?[index].translatedDescription != null
                                                                                      ? readmoree[index] == true
                                                                                          ? GestureDetector(
                                                                                              onTap: () async {
                                                                                                super.setState(() {
                                                                                                  if (AllGuestPostRoomData?.object?.content?[index].isTrsnalteoption == false || AllGuestPostRoomData?.object?.content?[index].isTrsnalteoption == null) {
                                                                                                    AllGuestPostRoomData?.object?.content?[index].isTrsnalteoption = true;
                                                                                                  } else {
                                                                                                    AllGuestPostRoomData?.object?.content?[index].isTrsnalteoption = false;
                                                                                                  }
                                                                                                });
                                                                                              },
                                                                                              child: Container(
                                                                                                  width: 80,
                                                                                                  decoration: BoxDecoration(
                                                                                                    color: ColorConstant.primaryLight_color,
                                                                                                    borderRadius: BorderRadius.circular(10),
                                                                                                  ),
                                                                                                  child: Center(
                                                                                                      child: Text(
                                                                                                    "Translate",
                                                                                                    style: TextStyle(
                                                                                                      fontFamily: 'outfit',
                                                                                                      fontWeight: FontWeight.bold,
                                                                                                    ),
                                                                                                  ))),
                                                                                            )
                                                                                          : SizedBox()
                                                                                      : SizedBox(),
                                                                                  /*   Align(
                                                                              alignment: Alignment.centerRight,
                                                                              child: (AllGuestPostRoomData?.object?.content?[index].description?.length ?? 0) > maxLength
                                                                                  ? GestureDetector(
                                                                                      onTap: () {
                                                                                        setState(() {
                                                                                          if (readmoree[index] == true) {
                                                                                            readmoree[index] = false;
                                                                                            print("--------------false ");
                                                                                          } else {
                                                                                            readmoree[index] = true;
                                                                                            print("-------------- true");
                                                                                          }
                                                                                        });
                                                                                      },
                                                                                      child: Container(
                                                                                        // color: Colors.red,
                                                                                        width: 75,
                                                                                        height: 15,
                                                                                        child: Align(
                                                                                          alignment: Alignment.centerLeft,
                                                                                          child: Text(
                                                                                            readmoree[index] ? 'Read Less' : 'Read More',
                                                                                            style: TextStyle(
                                                                                              color: Colors.blue,
                                                                                              fontWeight: FontWeight.bold,
                                                                                            ),
                                                                                          ),
                                                                                        ),
                                                                                      ),
                                                                                    )
                                                                                  : SizedBox(),
                                                                            ) */
                                                                                ],
                                                                              )),
                                                                        )
                                                                      : SizedBox(),

                                                                  (AllGuestPostRoomData
                                                                              ?.object
                                                                              ?.content?[index]
                                                                              .postData
                                                                              ?.isEmpty ??
                                                                          false)
                                                                      ? SizedBox()
                                                                      : Container(
                                                                          // height: 200,
                                                                          width:
                                                                              _width,
                                                                          child: AllGuestPostRoomData?.object?.content?[index].postDataType == null
                                                                              ? SizedBox()
                                                                              : AllGuestPostRoomData?.object?.content?[index].postData?.length == 1
                                                                                  ? (AllGuestPostRoomData?.object?.content?[index].postDataType == "IMAGE"
                                                                                      ? GestureDetector(
                                                                                          onTap: () {
                                                                                            /*  if (uuid == null) {
                                                                                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => RegisterCreateAccountScreen()));
                                                                                  } else { */
                                                                                            Navigator.push(
                                                                                              context,
                                                                                              MaterialPageRoute(
                                                                                                  builder: (context) => OpenSavePostImage(
                                                                                                        PostID: AllGuestPostRoomData?.object?.content?[index].postUid,
                                                                                                        index: index,
                                                                                                      )),
                                                                                            ).then((value) {
                                                                                              // Get_UserToken();

                                                                                              setColorr();
                                                                                            });
                                                                                            // }
                                                                                          },
                                                                                          child: Container(
                                                                                            height: 200,
                                                                                            width: _width,
                                                                                            margin: EdgeInsets.only(left: 16, top: 15, right: 16),
                                                                                            child: Center(
                                                                                                child: CustomImageView(
                                                                                              url: "${AllGuestPostRoomData?.object?.content?[index].postData?[0]}",
                                                                                            )),
                                                                                          ),
                                                                                        )
                                                                                      : AllGuestPostRoomData?.object?.content?[index].postDataType == "VIDEO"
                                                                                          ? /* repostControllers[0].value.isInitialized
                                                                                    ?   */
                                                                                          Padding(
                                                                                              padding: const EdgeInsets.only(right: 20, top: 15),
                                                                                              child: Column(
                                                                                                mainAxisSize: MainAxisSize.min,
                                                                                                children: [
                                                                                                  Container(
                                                                                                    // height: 180,
                                                                                                    width: _width,
                                                                                                    child: VideoListItem1(
                                                                                                      videoUrl: videoUrls[index],
                                                                                                      PostID: AllGuestPostRoomData?.object?.content?[index].postUid,
                                                                                                      // isData: User_ID == null ? false : true,
                                                                                                    ),
                                                                                                  ),
                                                                                                ],
                                                                                              ),
                                                                                            )
                                                                                          // : SizedBox()
                                                                                          //this is the ATTACHMENT
                                                                                          : AllGuestPostRoomData?.object?.content?[index].postDataType == "ATTACHMENT"
                                                                                              ? (AllGuestPostRoomData?.object?.content?[index].postData?.isNotEmpty == true)
                                                                                                  ? /* Container(
                                                                                            height: 200,
                                                                                            width: _width,
                                                                                            child: DocumentViewScreen1(
                                                                                              path: AllGuestPostRoomData?.object?.content?[index].postData?[0].toString(),
                                                                                            )) */
                                                                                                  Stack(
                                                                                                      children: [
                                                                                                        Container(
                                                                                                          height: 400,
                                                                                                          width: _width,
                                                                                                          color: Colors.transparent,
                                                                                                        ),
                                                                                                        GestureDetector(
                                                                                                          onTap: () {
                                                                                                            if (uuid == null) {
                                                                                                              Navigator.of(context).push(MaterialPageRoute(builder: (context) => RegisterCreateAccountScreen()));
                                                                                                            } else {
                                                                                                              print("objectobjectobjectobject");
                                                                                                              Navigator.push(context, MaterialPageRoute(
                                                                                                                builder: (context) {
                                                                                                                  return DocumentViewScreen1(
                                                                                                                    path: AllGuestPostRoomData?.object?.content?[index].postData?[0].toString(),
                                                                                                                  );
                                                                                                                },
                                                                                                              ));
                                                                                                            }
                                                                                                          },
                                                                                                          child: Container(
                                                                                                            child: CustomImageView(
                                                                                                              url: "${AllGuestPostRoomData?.object?.content?[index].thumbnailImageUrl}",
                                                                                                              fit: BoxFit.cover,
                                                                                                            ),
                                                                                                            // CachedNetworkImage(
                                                                                                            //   imageUrl: "${AllGuestPostRoomData?.object?.content?[index].thumbnailImageUrl}",
                                                                                                            //   fit: BoxFit.cover,
                                                                                                            // ),
                                                                                                          ),
                                                                                                        )
                                                                                                      ],
                                                                                                    )
                                                                                                  : SizedBox()
                                                                                              : SizedBox())
                                                                                  : Column(
                                                                                      children: [
                                                                                        Stack(
                                                                                          children: [
                                                                                            if ((AllGuestPostRoomData?.object?.content?[index].postData?.isNotEmpty ?? false)) ...[
                                                                                              SizedBox(
                                                                                                height: 200,
                                                                                                child: PageView.builder(
                                                                                                  onPageChanged: (page) {
                                                                                                    super.setState(() {
                                                                                                      _currentPages[index] = page;
                                                                                                      imageCount = page + 1;
                                                                                                    });
                                                                                                  },
                                                                                                  controller: _pageControllers[index],
                                                                                                  itemCount: AllGuestPostRoomData?.object?.content?[index].postData?.length,
                                                                                                  itemBuilder: (BuildContext context, int index1) {
                                                                                                    if (AllGuestPostRoomData?.object?.content?[index].postDataType == "IMAGE") {
                                                                                                      return Container(
                                                                                                        // color: Colors.amber,
                                                                                                        width: _width,
                                                                                                        margin: EdgeInsets.only(left: 0, top: 15, right: 0),
                                                                                                        child: Center(
                                                                                                            child: GestureDetector(
                                                                                                          onTap: () {
                                                                                                            /*   if (uuid == null) {
                                                                                                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => RegisterCreateAccountScreen()));
                                                                                                  } else { */
                                                                                                            Navigator.push(
                                                                                                              context,
                                                                                                              MaterialPageRoute(
                                                                                                                  builder: (context) => OpenSavePostImage(
                                                                                                                        PostID: AllGuestPostRoomData?.object?.content?[index].postUid,
                                                                                                                        index: index1,
                                                                                                                      )),
                                                                                                            ).then((value) {
                                                                                                              // Get_UserToken();

                                                                                                              setColorr();
                                                                                                            });
                                                                                                            // }
                                                                                                          },
                                                                                                          child: Stack(
                                                                                                            children: [
                                                                                                              Align(
                                                                                                                alignment: Alignment.topCenter,
                                                                                                                child: PinchZoom(
                                                                                                                  child: CachedNetworkImage(
                                                                                                                    imageUrl: "${AllGuestPostRoomData?.object?.content?[index].postData?[index1]}",
                                                                                                                  ),
                                                                                                                  maxScale: 4,
                                                                                                                  onZoomStart: () {
                                                                                                                    print('Start zooming');
                                                                                                                  },
                                                                                                                  onZoomEnd: () {
                                                                                                                    print('Stop zooming');
                                                                                                                  },
                                                                                                                ),
                                                                                                                /* CustomImageView(
                                                                                                                  url: "${AllGuestPostRoomData?.object?.content?[index].postData?[index1]}",
                                                                                                                ), */
                                                                                                              ),
                                                                                                              Align(
                                                                                                                alignment: Alignment.topRight,
                                                                                                                child: Card(
                                                                                                                  color: Colors.transparent,
                                                                                                                  elevation: 0,
                                                                                                                  child: Container(
                                                                                                                      alignment: Alignment.center,
                                                                                                                      height: 30,
                                                                                                                      width: 50,
                                                                                                                      decoration: BoxDecoration(
                                                                                                                        color: Color.fromARGB(255, 2, 1, 1),
                                                                                                                        borderRadius: BorderRadius.all(Radius.circular(50)),
                                                                                                                      ),
                                                                                                                      child: Text(
                                                                                                                        imageCount.toString() + '/' + '${AllGuestPostRoomData?.object?.content?[index].postData?.length}',
                                                                                                                        style: TextStyle(color: Colors.white),
                                                                                                                      )),
                                                                                                                ),
                                                                                                              )
                                                                                                            ],
                                                                                                          ),
                                                                                                        )),
                                                                                                      );
                                                                                                    } else if (AllGuestPostRoomData?.object?.content?[index].postDataType == "ATTACHMENT") {
                                                                                                      return Container(
                                                                                                          height: 200,
                                                                                                          width: _width,
                                                                                                          child: DocumentViewScreen1(
                                                                                                            path: AllGuestPostRoomData?.object?.content?[index].postData?[index1].toString(),
                                                                                                          ));
                                                                                                    }
                                                                                                  },
                                                                                                ),
                                                                                              ),
                                                                                              Positioned(
                                                                                                  bottom: 5,
                                                                                                  left: 0,
                                                                                                  right: 0,
                                                                                                  child: Padding(
                                                                                                    padding: const EdgeInsets.only(top: 0),
                                                                                                    child: Container(
                                                                                                      height: 20,
                                                                                                      child: DotsIndicator(
                                                                                                        dotsCount: AllGuestPostRoomData?.object?.content?[index].postData?.length ?? 0,
                                                                                                        position: _currentPages[index].toDouble(),
                                                                                                        decorator: DotsDecorator(
                                                                                                          size: const Size(10.0, 7.0),
                                                                                                          activeSize: const Size(10.0, 10.0),
                                                                                                          spacing: const EdgeInsets.symmetric(horizontal: 2),
                                                                                                          activeColor: ColorConstant.primary_color,
                                                                                                          color: Color(0xff6A6A6A),
                                                                                                        ),
                                                                                                      ),
                                                                                                    ),
                                                                                                  ))
                                                                                            ]
                                                                                            // : SizedBox()
                                                                                          ],
                                                                                        ),
                                                                                      ],
                                                                                    ),
                                                                        ),
                                                                  // inner post portion & repost

                                                                  Padding(
                                                                    padding: const EdgeInsets
                                                                            .only(
                                                                        left:
                                                                            10,
                                                                        right:
                                                                            10,
                                                                        bottom:
                                                                            10,
                                                                        top:
                                                                            20),
                                                                    child:
                                                                        GestureDetector(
                                                                      onTap:
                                                                          () {
                                                                        /*  if (uuid == null) {
                                                                                      Navigator.of(context).push(MaterialPageRoute(builder: (context) => RegisterCreateAccountScreen()));
                                                                                    } else { */
                                                                        Navigator
                                                                            .push(
                                                                          context,
                                                                          MaterialPageRoute(
                                                                              builder: (context) => OpenSavePostImage(
                                                                                    PostID: AllGuestPostRoomData?.object?.content?[index].repostOn?.postUid,
                                                                                    index: index,
                                                                                  )),
                                                                        ).then(
                                                                            (value) {
                                                                          // Get_UserToken();

                                                                          setColorr();
                                                                        });
                                                                        // }
                                                                      },
                                                                      child:
                                                                          Container(
                                                                        decoration: BoxDecoration(
                                                                            color: Colors.white,
                                                                            border: Border.all(
                                                                              color: Colors.grey.shade200,
                                                                            ),
                                                                            borderRadius: BorderRadius.circular(15)),
                                                                        // height: 300,
                                                                        width:
                                                                            _width,
                                                                        child:
                                                                            Column(
                                                                          crossAxisAlignment:
                                                                              CrossAxisAlignment.start,
                                                                          children: [
                                                                            SizedBox(
                                                                              height: 10,
                                                                            ),
                                                                            Container(
                                                                              height: 60,
                                                                              child: ListTile(
                                                                                leading: GestureDetector(
                                                                                  onTap: () async {
                                                                                    if (uuid == null) {
                                                                                      Navigator.of(context).push(MaterialPageRoute(builder: (context) => RegisterCreateAccountScreen()));
                                                                                    } else {
                                                                                      await BlocProvider.of<GetGuestAllPostCubit>(context).seetinonExpried(context);
                                                                                      Navigator.push(context, MaterialPageRoute(builder: (context) {
                                                                                        return MultiBlocProvider(providers: [
                                                                                          BlocProvider<NewProfileSCubit>(
                                                                                            create: (context) => NewProfileSCubit(),
                                                                                          ),
                                                                                        ], child: ProfileScreen(User_ID: "${AllGuestPostRoomData?.object?.content?[index].repostOn?.userUid}", isFollowing: AllGuestPostRoomData?.object?.content?[index].repostOn?.isFollowing));
                                                                                      })).then((value) => Get_UserToken());
                                                                                      //
                                                                                    }
                                                                                  },
                                                                                  child: AllGuestPostRoomData?.object?.content?[index].repostOn?.userProfilePic != null && AllGuestPostRoomData?.object?.content?[index].repostOn?.userProfilePic != ""
                                                                                      ? CircleAvatar(
                                                                                          backgroundImage: NetworkImage("${AllGuestPostRoomData?.object?.content?[index].repostOn?.userProfilePic}"),
                                                                                          backgroundColor: Colors.white,
                                                                                          radius: 25,
                                                                                        )
                                                                                      : CustomImageView(
                                                                                          imagePath: ImageConstant.tomcruse,
                                                                                          height: 50,
                                                                                          width: 50,
                                                                                          fit: BoxFit.fill,
                                                                                          radius: BorderRadius.circular(25),
                                                                                        ),
                                                                                ),
                                                                                title: Column(
                                                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                                                  children: [
                                                                                    SizedBox(
                                                                                      height: 8,
                                                                                    ),
                                                                                    GestureDetector(
                                                                                      onTap: () async {
                                                                                        if (uuid == null) {
                                                                                          Navigator.of(context).push(MaterialPageRoute(builder: (context) => RegisterCreateAccountScreen()));
                                                                                        } else {
                                                                                          await BlocProvider.of<GetGuestAllPostCubit>(context).seetinonExpried(context);
                                                                                          Navigator.push(context, MaterialPageRoute(builder: (context) {
                                                                                            return MultiBlocProvider(providers: [
                                                                                              BlocProvider<NewProfileSCubit>(
                                                                                                create: (context) => NewProfileSCubit(),
                                                                                              ),
                                                                                            ], child: ProfileScreen(User_ID: "${AllGuestPostRoomData?.object?.content?[index].repostOn?.userUid}", isFollowing: AllGuestPostRoomData?.object?.content?[index].repostOn?.isFollowing));
                                                                                          })).then((value) => Get_UserToken());
                                                                                          //
                                                                                        }
                                                                                      },
                                                                                      child: Container(
                                                                                        // color:
                                                                                        //     Colors.amber,
                                                                                        child: Text(
                                                                                          "${AllGuestPostRoomData?.object?.content?[index].repostOn?.postUserName}",
                                                                                          style: TextStyle(fontSize: 20, fontFamily: "outfit", fontWeight: FontWeight.bold),
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                    Text(
                                                                                      AllGuestPostRoomData?.object?.content?[index].repostOn == null ? "" : getTimeDifference(repostTime!),
                                                                                      style: TextStyle(
                                                                                        fontSize: 12,
                                                                                        fontFamily: "outfit",
                                                                                      ),
                                                                                    ),
                                                                                  ],
                                                                                ),
                                                                              ),
                                                                            ),
                                                                            SizedBox(
                                                                              height: 10,
                                                                            ),
                                                                            AllGuestPostRoomData?.object?.content?[index].repostOn?.description != null
                                                                                ? Padding(
                                                                                    padding: const EdgeInsets.only(left: 16),
                                                                                    child: LinkifyText(
                                                                                      readmoree[index] == true
                                                                                          ? (AllGuestPostRoomData?.object?.content?[index].repostOn?.isTrsnalteoption == false || AllGuestPostRoomData?.object?.content?[index].repostOn?.isTrsnalteoption == null)
                                                                                              ? "${AllGuestPostRoomData?.object?.content?[index].repostOn?.description}${(AllGuestPostRoomData?.object?.content?[index].repostOn?.description?.length ?? 0) > maxLength ? ' ....ReadLess' : ''}"
                                                                                              : "${AllGuestPostRoomData?.object?.content?[index].repostOn?.translatedDescription}"
                                                                                          : (AllGuestPostRoomData?.object?.content?[index].repostOn?.isTrsnalteoption == false || AllGuestPostRoomData?.object?.content?[index].repostOn?.isTrsnalteoption == null)
                                                                                              ? "${AllGuestPostRoomData?.object?.content?[index].repostOn?.description?.substring(0, maxLength)} ....ReadMore"
                                                                                              : "${AllGuestPostRoomData?.object?.content?[index].repostOn?.translatedDescription?.substring(0, maxLength)} ....ReadMore", // as
                                                                                      linkStyle: TextStyle(
                                                                                        color: Colors.blue,
                                                                                        fontFamily: 'outfit',
                                                                                      ),
                                                                                      textStyle: TextStyle(
                                                                                        color: Colors.black,
                                                                                        fontFamily: 'outfit',
                                                                                      ),
                                                                                      linkTypes: [
                                                                                        LinkType.url,
                                                                                        LinkType.userTag,
                                                                                        LinkType.hashTag,
                                                                                        // LinkType
                                                                                        //     .email
                                                                                      ],
                                                                                      onTap: (link) async {
                                                                                        /// do stuff with `link` like
                                                                                        /// if(link.type == Link.url) launchUrl(link.value);

                                                                                        var SelectedTest = link.value.toString();
                                                                                        var Link = SelectedTest.startsWith('https');
                                                                                        var Link1 = SelectedTest.startsWith('http');
                                                                                        var Link2 = SelectedTest.startsWith('www');
                                                                                        var Link3 = SelectedTest.startsWith('WWW');
                                                                                        var Link4 = SelectedTest.startsWith('HTTPS');
                                                                                        var Link5 = SelectedTest.startsWith('HTTP');
                                                                                        var Link6 = SelectedTest.startsWith('https://pdslink.page.link/');
                                                                                        print(SelectedTest.toString());
                                                                                        if ((AllGuestPostRoomData?.object?.content?[index].repostOn?.description?.length ?? 0) > maxLength) {
                                                                                          // if (User_ID == null) {
                                                                                          //   Navigator.of(context).push(MaterialPageRoute(builder: (context) => RegisterCreateAccountScreen()));
                                                                                          // } else {
                                                                                          if (Link == true || Link1 == true || Link2 == true || Link3 == true || Link4 == true || Link5 == true || Link6 == true) {
                                                                                            print("vcvcvcvcvcvcvcvcvcvcvcvvcvcvcvcvcvcvcvcvcvcvcv = 1");
                                                                                            if (Link2 == true || Link3 == true) {
                                                                                              print("vcvcvcvcvcvcvcvcvcvcvcvvcvcvcvcvcvcvcvcvcvcvcv = 2");
                                                                                              launchUrl(Uri.parse("https://${link.value.toString()}"));
                                                                                              print("qqqqqqqqhttps://${link.value}");
                                                                                            } else {
                                                                                              print("vcvcvcvcvcvcvcvcvcvcvcvvcvcvcvcvcvcvcvcvcvcvcv = 3");
                                                                                              if (Link6 == true) {
                                                                                                print("vcvcvcvcvcvcvcvcvcvcvcvvcvcvcvcvcvcvcvcvcvcvcv = 4");
                                                                                                print("yes i am inList =   room");
                                                                                                Navigator.push(context, MaterialPageRoute(
                                                                                                  builder: (context) {
                                                                                                    return NewBottomBar(
                                                                                                      buttomIndex: 1,
                                                                                                    );
                                                                                                  },
                                                                                                ));
                                                                                              } else {
                                                                                                print("vcvcvcvcvcvcvcvcvcvcvcvvcvcvcvcvcvcvcvcvcvcvcv = 5");
                                                                                                launchUrl(Uri.parse(link.value.toString()));
                                                                                                print("link.valuelink.value -- ${link.value}");
                                                                                              }
                                                                                            }
                                                                                          } else {
                                                                                            print("vcvcvcvcvcvcvcvcvcvcvcvvcvcvcvcvcvcvcvcvcvcvcv = 6");
                                                                                            if (link.value!.startsWith('#')) {
                                                                                              print("vcvcvcvcvcvcvcvcvcvcvcvvcvcvcvcvcvcvcvcvcvcvcv = 7");
                                                                                              await BlocProvider.of<GetGuestAllPostCubit>(context).seetinonExpried(context);
                                                                                              print("aaaaaaaaaa == ${link}");
                                                                                              Navigator.push(
                                                                                                  context,
                                                                                                  MaterialPageRoute(
                                                                                                    builder: (context) => HashTagViewScreen(title: "${link.value}"),
                                                                                                  ));
                                                                                            } else if (link.value!.startsWith('@')) {
                                                                                              print("vcvcvcvcvcvcvcvcvcvcvcvvcvcvcvcvcvcvcvcvcvcvcv = 8");
                                                                                              await BlocProvider.of<GetGuestAllPostCubit>(context).seetinonExpried(context);
                                                                                              var name;
                                                                                              var tagName;
                                                                                              name = SelectedTest;
                                                                                              tagName = name.replaceAll("@", "");
                                                                                              await BlocProvider.of<GetGuestAllPostCubit>(context).UserTagAPI(context, tagName);

                                                                                              Navigator.push(context, MaterialPageRoute(builder: (context) {
                                                                                                return ProfileScreen(User_ID: "${userTagModel?.object}", isFollowing: "");
                                                                                              })).then((value) => Get_UserToken());

                                                                                              print("tagName -- ${tagName}");
                                                                                              print("user id -- ${userTagModel?.object}");
                                                                                            } else {
                                                                                              print("vcvcvcvcvcvcvcvcvcvcvcvvcvcvcvcvcvcvcvcvcvcvcv = 9");
                                                                                              setState(() {
                                                                                                if (readmoree[index] == true) {
                                                                                                  readmoree[index] = false;
                                                                                                  print("--------------false ");
                                                                                                } else {
                                                                                                  readmoree[index] = true;
                                                                                                  print("-------------- true");
                                                                                                }
                                                                                              });
                                                                                            }
                                                                                          }
                                                                                          // }
                                                                                          // setState(() {
                                                                                          //   if (readmoree[index] == true) {
                                                                                          //     readmoree[index] = false;
                                                                                          //     print("--------------false ");
                                                                                          //   } else {
                                                                                          //     readmoree[index] = true;
                                                                                          //     print("-------------- true");
                                                                                          //   }
                                                                                          // });
                                                                                        } else {
                                                                                          if (User_ID == null) {
                                                                                            Navigator.of(context).push(MaterialPageRoute(builder: (context) => RegisterCreateAccountScreen()));
                                                                                          } else {
                                                                                            if (Link == true || Link1 == true || Link2 == true || Link3 == true || Link4 == true || Link5 == true || Link6 == true) {
                                                                                              if (Link2 == true || Link3 == true) {
                                                                                                launchUrl(Uri.parse("https://${link.value.toString()}"));
                                                                                                print("qqqqqqqqhttps://${link.value}");
                                                                                              } else {
                                                                                                if (Link6 == true) {
                                                                                                  print("yes i am inList =   room");
                                                                                                  Navigator.push(context, MaterialPageRoute(
                                                                                                    builder: (context) {
                                                                                                      return NewBottomBar(
                                                                                                        buttomIndex: 1,
                                                                                                      );
                                                                                                    },
                                                                                                  ));
                                                                                                } else {
                                                                                                  launchUrl(Uri.parse(link.value.toString()));
                                                                                                  print("link.valuelink.value -- ${link.value}");
                                                                                                }
                                                                                              }
                                                                                            } else {
                                                                                              if (link.value!.startsWith('#')) {
                                                                                                await BlocProvider.of<GetGuestAllPostCubit>(context).seetinonExpried(context);
                                                                                                print("aaaaaaaaaa == ${link}");
                                                                                                Navigator.push(
                                                                                                    context,
                                                                                                    MaterialPageRoute(
                                                                                                      builder: (context) => HashTagViewScreen(title: "${link.value}"),
                                                                                                    ));
                                                                                              } else if (link.value!.startsWith('@')) {
                                                                                                await BlocProvider.of<GetGuestAllPostCubit>(context).seetinonExpried(context);
                                                                                                var name;
                                                                                                var tagName;
                                                                                                name = SelectedTest;
                                                                                                tagName = name.replaceAll("@", "");
                                                                                                await BlocProvider.of<GetGuestAllPostCubit>(context).UserTagAPI(context, tagName);

                                                                                                Navigator.push(context, MaterialPageRoute(builder: (context) {
                                                                                                  return ProfileScreen(User_ID: "${userTagModel?.object}", isFollowing: "");
                                                                                                })).then((value) => Get_UserToken());

                                                                                                print("tagName -- ${tagName}");
                                                                                                print("user id -- ${userTagModel?.object}");
                                                                                              }
                                                                                            }
                                                                                          }
                                                                                        }
                                                                                      },
                                                                                    ))
                                                                                : SizedBox(),
                                                                            if (AllGuestPostRoomData?.object?.content?[index].repostOn?.translatedDescription != null &&
                                                                                readmoree[index] == true)
                                                                              GestureDetector(
                                                                                onTap: () {
                                                                                  if (AllGuestPostRoomData?.object?.content?[index].repostOn?.isTrsnalteoption == false || AllGuestPostRoomData?.object?.content?[index].repostOn?.isTrsnalteoption == null) {
                                                                                    AllGuestPostRoomData?.object?.content?[index].repostOn?.isTrsnalteoption = true;
                                                                                  } else {
                                                                                    AllGuestPostRoomData?.object?.content?[index].repostOn?.isTrsnalteoption = false;
                                                                                  }
                                                                                },
                                                                                child: Container(
                                                                                  margin: EdgeInsets.only(left: 10, top: 10),
                                                                                  width: 80,
                                                                                  decoration: BoxDecoration(
                                                                                    color: ColorConstant.primaryLight_color,
                                                                                    borderRadius: BorderRadius.circular(10),
                                                                                  ),
                                                                                  child: Center(
                                                                                    child: Text(
                                                                                      "Translate",
                                                                                      style: TextStyle(
                                                                                        fontFamily: 'outfit',
                                                                                        fontWeight: FontWeight.bold,
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            /* AllGuestPostRoomData?.object?.content?[index].translatedDescription !=
                                                                              null
                                                                          ? readmoree[index] == true
                                                                              ? GestureDetector(
                                                                                  onTap: () async {
                                                                                    super.setState(() {
                                                                                      if (AllGuestPostRoomData?.object?.content?[index].isTrsnalteoption == false || AllGuestPostRoomData?.object?.content?[index].isTrsnalteoption == null) {
                                                                                        AllGuestPostRoomData?.object?.content?[index].isTrsnalteoption = true;
                                                                                      } else {
                                                                                        AllGuestPostRoomData?.object?.content?[index].isTrsnalteoption = false;
                                                                                      }
                                                                                    });
                                                                                  },
                                                                                  child: Container(
                                                                                      width: 80,
                                                                                      decoration: BoxDecoration(
                                                                                        color: ColorConstant.primaryLight_color,
                                                                                        borderRadius: BorderRadius.circular(10),
                                                                                      ),
                                                                                      child: Center(
                                                                                          child: Text(
                                                                                        "Translate",
                                                                                        style: TextStyle(
                                                                                          fontFamily: 'outfit',
                                                                                          fontWeight: FontWeight.bold,
                                                                                        ),
                                                                                      ))),
                                                                                ), */
                                                                            Container(
                                                                              width: _width,
                                                                              child: AllGuestPostRoomData?.object?.content?[index].repostOn?.postDataType == null
                                                                                  ? SizedBox()
                                                                                  : AllGuestPostRoomData?.object?.content?[index].repostOn?.postData?.length == 1
                                                                                      ? (AllGuestPostRoomData?.object?.content?[index].repostOn?.postDataType == "IMAGE"
                                                                                          ? GestureDetector(
                                                                                              onTap: () {
                                                                                                /*  if (uuid == null) {
                                                                                        Navigator.of(context).push(MaterialPageRoute(builder: (context) => RegisterCreateAccountScreen()));
                                                                                      } else { */
                                                                                                Navigator.push(
                                                                                                  context,
                                                                                                  MaterialPageRoute(
                                                                                                      builder: (context) => OpenSavePostImage(
                                                                                                            PostID: AllGuestPostRoomData?.object?.content?[index].repostOn?.postUid,
                                                                                                            index: index,
                                                                                                          )),
                                                                                                ).then((value) {
                                                                                                  // Get_UserToken();

                                                                                                  setColorr();
                                                                                                });
                                                                                                // }
                                                                                              },
                                                                                              child: Container(
                                                                                                width: _width,
                                                                                                height: 150,
                                                                                                margin: EdgeInsets.only(left: 16, top: 15, right: 16),
                                                                                                child: Center(
                                                                                                    child: CustomImageView(
                                                                                                  url: "${AllGuestPostRoomData?.object?.content?[index].repostOn?.postData?[0]}",
                                                                                                )),
                                                                                              ),
                                                                                            )
                                                                                          : AllGuestPostRoomData?.object?.content?[index].repostOn?.postDataType == "VIDEO"
                                                                                              ? /* repostMainControllers[0].value.isInitialized
                                                                                        ? */
                                                                                              Padding(
                                                                                                  padding: const EdgeInsets.only(
                                                                                                    right: 20,
                                                                                                    top: 15,
                                                                                                  ),
                                                                                                  child: Column(
                                                                                                    mainAxisSize: MainAxisSize.min,
                                                                                                    children: [
                                                                                                      VideoListItem1(
                                                                                                        videoUrl: videoUrls[index],
                                                                                                        discrption: AllGuestPostRoomData?.object?.content?[index].repostOn?.description,
                                                                                                        PostID: AllGuestPostRoomData?.object?.content?[index].postUid,
                                                                                                        // isData: User_ID == null ? false : true,
                                                                                                      )
                                                                                                    ],
                                                                                                  ),
                                                                                                )
                                                                                              // : SizedBox()
                                                                                              : AllGuestPostRoomData?.object?.content?[index].repostOn?.postDataType == "ATTACHMENT"
                                                                                                  ? Stack(
                                                                                                      children: [
                                                                                                        Container(
                                                                                                          height: 400,
                                                                                                          width: _width,
                                                                                                          color: Colors.transparent,
                                                                                                        ),
                                                                                                        GestureDetector(
                                                                                                          onTap: () {
                                                                                                            if (uuid == null) {
                                                                                                              Navigator.of(context).push(MaterialPageRoute(builder: (context) => RegisterCreateAccountScreen()));
                                                                                                            } else {
                                                                                                              print("objectobjectobjectobject");
                                                                                                              Navigator.push(context, MaterialPageRoute(
                                                                                                                builder: (context) {
                                                                                                                  return DocumentViewScreen1(
                                                                                                                    path: AllGuestPostRoomData?.object?.content?[index].repostOn?.postData?[0].toString(),
                                                                                                                  );
                                                                                                                },
                                                                                                              ));
                                                                                                            }
                                                                                                          },
                                                                                                          child: Container(
                                                                                                            child: CustomImageView(
                                                                                                              url: "${AllGuestPostRoomData?.object?.content?[index].repostOn?.thumbnailImageUrl}",
                                                                                                              fit: BoxFit.cover,
                                                                                                            ),
                                                                                                            //  CachedNetworkImage(
                                                                                                            //   imageUrl: "${AllGuestPostRoomData?.object?.content?[index].repostOn?.thumbnailImageUrl}",
                                                                                                            //   fit: BoxFit.cover,
                                                                                                            // ),
                                                                                                          ),
                                                                                                        )
                                                                                                      ],
                                                                                                    )
                                                                                                  : SizedBox())
                                                                                      : Column(
                                                                                          children: [
                                                                                            Stack(
                                                                                              children: [
                                                                                                if ((AllGuestPostRoomData?.object?.content?[index].repostOn?.postData?.isNotEmpty ?? false)) ...[
                                                                                                  SizedBox(
                                                                                                    height: 300,
                                                                                                    child: PageView.builder(
                                                                                                      onPageChanged: (page) {
                                                                                                        super.setState(() {
                                                                                                          _currentPages1[index] = page;
                                                                                                          imageCount1 = page + 1;
                                                                                                        });
                                                                                                      },
                                                                                                      controller: _pageControllers1[index],
                                                                                                      itemCount: AllGuestPostRoomData?.object?.content?[index].repostOn?.postData?.length,
                                                                                                      itemBuilder: (BuildContext context, int index1) {
                                                                                                        if (AllGuestPostRoomData?.object?.content?[index].repostOn?.postDataType == "IMAGE") {
                                                                                                          return GestureDetector(
                                                                                                            onTap: () {
                                                                                                              print("Repost Opne Full screen");
                                                                                                              /*   if (uuid == null) {
                                                                                                      Navigator.of(context).push(MaterialPageRoute(builder: (context) => RegisterCreateAccountScreen()));
                                                                                                    } else { */
                                                                                                              Navigator.push(
                                                                                                                context,
                                                                                                                MaterialPageRoute(
                                                                                                                    builder: (context) => OpenSavePostImage(
                                                                                                                          PostID: AllGuestPostRoomData?.object?.content?[index].repostOn?.postUid,
                                                                                                                          index: index1,
                                                                                                                        )),
                                                                                                              ).then((value) {
                                                                                                                // Get_UserToken();

                                                                                                                setColorr();
                                                                                                              });
                                                                                                              // }
                                                                                                            },
                                                                                                            child: Container(
                                                                                                              width: _width,
                                                                                                              margin: EdgeInsets.only(left: 16, top: 15, right: 16),
                                                                                                              child: Center(
                                                                                                                  child: Stack(
                                                                                                                children: [
                                                                                                                  Align(
                                                                                                                    alignment: Alignment.topCenter,
                                                                                                                    child: CustomImageView(
                                                                                                                      url: "${AllGuestPostRoomData?.object?.content?[index].repostOn?.postData?[index1]}",
                                                                                                                    ),
                                                                                                                  ),
                                                                                                                  Align(
                                                                                                                    alignment: Alignment.topRight,
                                                                                                                    child: Card(
                                                                                                                      color: Colors.transparent,
                                                                                                                      elevation: 0,
                                                                                                                      child: Container(
                                                                                                                          alignment: Alignment.center,
                                                                                                                          height: 30,
                                                                                                                          width: 50,
                                                                                                                          decoration: BoxDecoration(
                                                                                                                            color: Color.fromARGB(255, 2, 1, 1),
                                                                                                                            borderRadius: BorderRadius.all(Radius.circular(50)),
                                                                                                                          ),
                                                                                                                          child: Text(
                                                                                                                            imageCount1.toString() + '/' + '${AllGuestPostRoomData?.object?.content?[index].repostOn?.postData?.length}',
                                                                                                                            style: TextStyle(color: Colors.white),
                                                                                                                          )),
                                                                                                                    ),
                                                                                                                  )
                                                                                                                ],
                                                                                                              )),
                                                                                                            ),
                                                                                                          );
                                                                                                        } else if (AllGuestPostRoomData?.object?.content?[index].repostOn?.postDataType == "ATTACHMENT") {
                                                                                                          return Container(
                                                                                                              height: 400,
                                                                                                              width: _width,
                                                                                                              child: DocumentViewScreen1(
                                                                                                                path: AllGuestPostRoomData?.object?.content?[index].repostOn?.postData?[index1].toString(),
                                                                                                              ));
                                                                                                        }
                                                                                                      },
                                                                                                    ),
                                                                                                  ),
                                                                                                  Positioned(
                                                                                                      bottom: 5,
                                                                                                      left: 0,
                                                                                                      right: 0,
                                                                                                      child: Padding(
                                                                                                        padding: const EdgeInsets.only(top: 0),
                                                                                                        child: Container(
                                                                                                          height: 20,
                                                                                                          child: DotsIndicator(
                                                                                                            dotsCount: AllGuestPostRoomData?.object?.content?[index].repostOn?.postData?.length ?? 1,
                                                                                                            position: _currentPages1[index].toDouble(),
                                                                                                            decorator: DotsDecorator(
                                                                                                              size: const Size(10.0, 7.0),
                                                                                                              activeSize: const Size(10.0, 10.0),
                                                                                                              spacing: const EdgeInsets.symmetric(horizontal: 2),
                                                                                                              activeColor: ColorConstant.primary_color,
                                                                                                              color: Color(0xff6A6A6A),
                                                                                                            ),
                                                                                                          ),
                                                                                                        ),
                                                                                                      ))
                                                                                                ]
                                                                                              ],
                                                                                            ),
                                                                                          ],
                                                                                        ),
                                                                            ),
                                                                            SizedBox(
                                                                              height: 10,
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Padding(
                                                                    padding:
                                                                        const EdgeInsets.all(
                                                                            8.0),
                                                                    child:
                                                                        Divider(
                                                                      thickness:
                                                                          1,
                                                                    ),
                                                                  ),
                                                                  SizedBox(
                                                                    height: 5,
                                                                  ),
                                                                  Padding(
                                                                    padding: const EdgeInsets
                                                                            .only(
                                                                        top: 0,
                                                                        right:
                                                                            16),
                                                                    child: Row(
                                                                      children: [
                                                                        SizedBox(
                                                                          width:
                                                                              14,
                                                                        ),
                                                                        GestureDetector(
                                                                          onTap:
                                                                              () async {
                                                                            await soicalFunation(
                                                                                apiName: 'like_post',
                                                                                index: index);
                                                                          },
                                                                          child:
                                                                              Container(
                                                                            color:
                                                                                Colors.transparent,
                                                                            child:
                                                                                Padding(
                                                                              padding: const EdgeInsets.all(5.0),
                                                                              child: AllGuestPostRoomData?.object?.content?[index].isLiked != true
                                                                                  ? Image.asset(
                                                                                      ImageConstant.likewithout,
                                                                                      height: 20,
                                                                                    )
                                                                                  : Image.asset(
                                                                                      ImageConstant.like,
                                                                                      height: 20,
                                                                                    ),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        SizedBox(
                                                                          width:
                                                                              0,
                                                                        ),
                                                                        AllGuestPostRoomData?.object?.content?[index].likedCount ==
                                                                                0
                                                                            ? SizedBox()
                                                                            : GestureDetector(
                                                                                onTap: () {
                                                                                  /* Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                       
                                                            ShowAllPostLike("${AllGuestPostRoomData?.object?[index].postUid}"))); */

                                                                                  Navigator.push(context, MaterialPageRoute(
                                                                                    builder: (context) {
                                                                                      return ShowAllPostLike("${AllGuestPostRoomData?.object?.content?[index].postUid}");
                                                                                    },
                                                                                  ));
                                                                                },
                                                                                child: Container(
                                                                                  color: Colors.transparent,
                                                                                  child: Padding(
                                                                                    padding: const EdgeInsets.all(5.0),
                                                                                    child: Text(
                                                                                      "${AllGuestPostRoomData?.object?.content?[index].likedCount}",
                                                                                      style: TextStyle(fontFamily: "outfit", fontSize: 14),
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                        SizedBox(
                                                                          width:
                                                                              8,
                                                                        ),
                                                                        GestureDetector(
                                                                          onTap:
                                                                              () async {
                                                                            if (uuid ==
                                                                                null) {
                                                                              Navigator.of(context).push(MaterialPageRoute(builder: (context) => RegisterCreateAccountScreen()));
                                                                            } else {
                                                                              BlocProvider.of<AddcommentCubit>(context).Addcomment(context, '${AllGuestPostRoomData?.object?.content?[index].postUid}');
                                                                              _settingModalBottomSheet1(context, index, _width);
                                                                            }
                                                                          },
                                                                          child:
                                                                              Container(
                                                                            color:
                                                                                Colors.transparent,
                                                                            child:
                                                                                Padding(
                                                                              padding: const EdgeInsets.all(5.0),
                                                                              child: Image.asset(
                                                                                ImageConstant.meesage,
                                                                                height: 15,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        SizedBox(
                                                                          width:
                                                                              5,
                                                                        ),
                                                                        AllGuestPostRoomData?.object?.content?[index].commentCount ==
                                                                                0
                                                                            ? SizedBox()
                                                                            : Text(
                                                                                "${AllGuestPostRoomData?.object?.content?[index].commentCount}",
                                                                                style: TextStyle(fontFamily: "outfit", fontSize: 14),
                                                                              ),
                                                                        SizedBox(
                                                                          width:
                                                                              8,
                                                                        ),
                                                                        GestureDetector(
                                                                          onTap:
                                                                              () {
                                                                            rePostBottomSheet(context,
                                                                                index);
                                                                            // Navigator.push(
                                                                            //     context,
                                                                            //     MaterialPageRoute(
                                                                            //   builder:
                                                                            //       (context) {
                                                                            //     return RePostScreen(
                                                                            //       userProfile: AllGuestPostRoomData
                                                                            //           ?.object
                                                                            //           ?.content?[
                                                                            //               index]
                                                                            //           .userProfilePic,
                                                                            //       username: AllGuestPostRoomData
                                                                            //           ?.object
                                                                            //           ?.content?[
                                                                            //               index]
                                                                            //           .postUserName,
                                                                            //       date: AllGuestPostRoomData
                                                                            //           ?.object
                                                                            //           ?.content?[
                                                                            //               index]
                                                                            //           .createdAt,
                                                                            //       desc: AllGuestPostRoomData
                                                                            //           ?.object
                                                                            //           ?.content?[
                                                                            //               index]
                                                                            //           .description,
                                                                            //       postData: AllGuestPostRoomData
                                                                            //           ?.object
                                                                            //           ?.content?[
                                                                            //               index]
                                                                            //           .postData,
                                                                            //       postDataType: AllGuestPostRoomData
                                                                            //           ?.object
                                                                            //           ?.content?[
                                                                            //               index]
                                                                            //           .postDataType,
                                                                            //       index:
                                                                            //           index,
                                                                            //       AllGuestPostRoomData:
                                                                            //           AllGuestPostRoomData,
                                                                            //       postUid: AllGuestPostRoomData
                                                                            //           ?.object
                                                                            //           ?.content?[
                                                                            //               index]
                                                                            //           .postUid,
                                                                            //     );
                                                                            //   },
                                                                            // ));
                                                                          },
                                                                          child:
                                                                              Container(
                                                                            color:
                                                                                Colors.transparent,
                                                                            child:
                                                                                Padding(
                                                                              padding: const EdgeInsets.all(5.0),
                                                                              child: Image.asset(
                                                                                ImageConstant.vector2,
                                                                                height: 13,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        SizedBox(
                                                                          width:
                                                                              5,
                                                                        ),
                                                                        AllGuestPostRoomData?.object?.content?[index].repostCount == null ||
                                                                                AllGuestPostRoomData?.object?.content?[index].repostCount == 0
                                                                            ? SizedBox()
                                                                            : Text(
                                                                                '${AllGuestPostRoomData?.object?.content?[index].repostCount}',
                                                                                style: TextStyle(fontFamily: "outfit", fontSize: 14),
                                                                              ),
                                                                        GestureDetector(
                                                                          onTap:
                                                                              () {
                                                                            if (uuid ==
                                                                                null) {
                                                                              Navigator.of(context).push(MaterialPageRoute(builder: (context) => RegisterCreateAccountScreen()));
                                                                            } else {
                                                                              _onShareXFileFromAssets(context, androidLink: '${AllGuestPostRoomData?.object?.content?[index].postLink}'
                                                                                  /* iosLink:
                                                      "https://apps.apple.com/inList =  /app/growder-b2b-platform/id6451333863" */
                                                                                  );
                                                                            }
                                                                          },
                                                                          child:
                                                                              Container(
                                                                            height:
                                                                                20,
                                                                            width:
                                                                                30,
                                                                            color:
                                                                                Colors.transparent,
                                                                            child:
                                                                                Icon(Icons.share_rounded, size: 20),
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
                                                                          onTap:
                                                                              () async {
                                                                            await soicalFunation(
                                                                                apiName: 'savedata',
                                                                                index: index);
                                                                          },
                                                                          child:
                                                                              Container(
                                                                            color:
                                                                                Colors.transparent,
                                                                            child:
                                                                                Padding(
                                                                              padding: const EdgeInsets.all(5.0),
                                                                              child: uuid == null
                                                                                  ? Image.asset(
                                                                                      ImageConstant.savePin,
                                                                                      height: 17,
                                                                                    )
                                                                                  : Image.asset(
                                                                                      AllGuestPostRoomData?.object?.content?[index].isSaved == false ? ImageConstant.savePin : ImageConstant.Savefill,
                                                                                      height: 17,
                                                                                    ),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        // GestureDetector(
                                                                        //   onTap: () {
                                                                        //     Share.share(
                                                                        //         'https://play.google.com/store/apps/details?id=com.inpackaging.app');
                                                                        //   },
                                                                        //   child: Container(
                                                                        //     color: Colors
                                                                        //         .transparent,
                                                                        //     child: Padding(
                                                                        //       padding:
                                                                        //           const EdgeInsets
                                                                        //                   .all(
                                                                        //               5.0),
                                                                        //       child: Image
                                                                        //           .asset(
                                                                        //         ImageConstant
                                                                        //             .shareBlack,
                                                                        //         height: 17,
                                                                        //       ),
                                                                        //     ),
                                                                        //   ),
                                                                        // ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                  SizedBox(
                                                                    height: 5,
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                    ),
                                                  )
                                                : Padding(
                                                    padding: EdgeInsets.only(
                                                        left: 0, right: 0),
                                                    child: GestureDetector(
                                                      onTap: () {
                                                        if (AllGuestPostRoomData
                                                                ?.object
                                                                ?.content?[
                                                                    index]
                                                                .postDataType !=
                                                            "ATTACHMENT") {
                                                          Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                builder: (context) => OpenSavePostImage(
                                                                    PostID: AllGuestPostRoomData
                                                                        ?.object
                                                                        ?.content?[
                                                                            index]
                                                                        .postUid),
                                                              )).then((value) {
                                                            // Get_UserToken();

                                                            setColorr();
                                                          });
                                                        }
                                                      },
                                                      onDoubleTap: () async {
                                                        await soicalFunation(
                                                            apiName:
                                                                'like_post',
                                                            index: index);
                                                      },
                                                      child: Container(
                                                        decoration:
                                                            BoxDecoration(
                                                          color: Colors.white,
                                                          border: Border.all(
                                                              color: Color
                                                                  .fromRGBO(
                                                                      0,
                                                                      0,
                                                                      0,
                                                                      0.25)),
                                                          /*  borderRadius:
                                                            BorderRadius
                                                                .circular(15) */
                                                        ),
                                                        // height: 300,
                                                        width: _width,
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            SizedBox(
                                                              height: 10,
                                                            ),
                                                            Container(
                                                              height: 60,
                                                              child: ListTile(
                                                                leading:
                                                                    GestureDetector(
                                                                  onTap:
                                                                      () async {
                                                                    if (uuid ==
                                                                        null) {
                                                                      Navigator.of(
                                                                              context)
                                                                          .push(
                                                                              MaterialPageRoute(builder: (context) => RegisterCreateAccountScreen()));
                                                                    } else {
                                                                      await BlocProvider.of<GetGuestAllPostCubit>(
                                                                              context)
                                                                          .seetinonExpried(
                                                                              context);
                                                                      Navigator.push(
                                                                          context,
                                                                          MaterialPageRoute(builder:
                                                                              (context) {
                                                                        return MultiBlocProvider(
                                                                            providers: [
                                                                              BlocProvider<NewProfileSCubit>(
                                                                                create: (context) => NewProfileSCubit(),
                                                                              ),
                                                                            ],
                                                                            child:
                                                                                ProfileScreen(User_ID: "${AllGuestPostRoomData?.object?.content?[index].userUid}", isFollowing: AllGuestPostRoomData?.object?.content?[index].isFollowing));
                                                                      })).then(
                                                                          (value) =>
                                                                              Get_UserToken());
                                                                      //
                                                                    }
                                                                  },
                                                                  child: AllGuestPostRoomData?.object?.content?[index].userProfilePic !=
                                                                              null &&
                                                                          AllGuestPostRoomData?.object?.content?[index].userProfilePic !=
                                                                              ""
                                                                      ? CircleAvatar(
                                                                          backgroundImage:
                                                                              NetworkImage("${AllGuestPostRoomData?.object?.content?[index].userProfilePic}"),
                                                                          backgroundColor:
                                                                              Colors.white,
                                                                          radius:
                                                                              25,
                                                                        )
                                                                      : CustomImageView(
                                                                          imagePath:
                                                                              ImageConstant.tomcruse,
                                                                          height:
                                                                              50,
                                                                          width:
                                                                              50,
                                                                          fit: BoxFit
                                                                              .fill,
                                                                          radius:
                                                                              BorderRadius.circular(25),
                                                                        ),
                                                                ),
                                                                title: Column(
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    SizedBox(
                                                                      height: 8,
                                                                    ),
                                                                    GestureDetector(
                                                                      onTap:
                                                                          () async {
                                                                        if (uuid ==
                                                                            null) {
                                                                          Navigator.of(context)
                                                                              .push(MaterialPageRoute(builder: (context) => RegisterCreateAccountScreen()));
                                                                        } else {
                                                                          await BlocProvider.of<GetGuestAllPostCubit>(context)
                                                                              .seetinonExpried(context);
                                                                          Navigator.push(
                                                                              context,
                                                                              MaterialPageRoute(builder:
                                                                                  (context) {
                                                                            return MultiBlocProvider(providers: [
                                                                              BlocProvider<NewProfileSCubit>(
                                                                                create: (context) => NewProfileSCubit(),
                                                                              ),
                                                                            ], child: ProfileScreen(User_ID: "${AllGuestPostRoomData?.object?.content?[index].userUid}", isFollowing: AllGuestPostRoomData?.object?.content?[index].isFollowing));
                                                                          })).then((value) =>
                                                                              Get_UserToken());
                                                                          //
                                                                        }
                                                                      },
                                                                      child:
                                                                          Container(
                                                                        // color: Colors.amber,
                                                                        child:
                                                                            Text(
                                                                          "${AllGuestPostRoomData?.object?.content?[index].postUserName}",
                                                                          style: TextStyle(
                                                                              fontSize: 20,
                                                                              fontFamily: "outfit",
                                                                              fontWeight: FontWeight.bold),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    //FIndText
                                                                    Text(
                                                                      getTimeDifference(
                                                                          parsedDateTime),
                                                                      style:
                                                                          TextStyle(
                                                                        fontSize:
                                                                            12,
                                                                        fontFamily:
                                                                            "outfit",
                                                                      ),
                                                                    ),
                                                                    /* Text(
                                                            "${AllGuestPostRoomData?.object?.content?[index].postType}",
                                                            style: TextStyle(
                                                                fontSize: 10,
                                                                fontFamily: "outfit",
                                                                fontWeight:
                                                                    FontWeight.bold),
                                                          ), */
                                                                  ],
                                                                ),
                                                                trailing: User_ID ==
                                                                        AllGuestPostRoomData
                                                                            ?.object
                                                                            ?.content?[
                                                                                index]
                                                                            .userUid
                                                                    ? GestureDetector(
                                                                        key:
                                                                            buttonKey,
                                                                        onTap:
                                                                            () {
                                                                          showPopupMenu(
                                                                              context,
                                                                              index,
                                                                              buttonKey);
                                                                        },
                                                                        /*  onTapDown:
                                                                  (TapDownDetails
                                                                      details) {
                                                                delete_dilog_menu(
                                                                  details
                                                                      .globalPosition,
                                                                  context,
                                                                );
                                                              },
                                                              onTap: () {
                                                                Navigator.pop(
                                                                    context);
                                                              }, */
                                                                        child:
                                                                            Icon(
                                                                          Icons
                                                                              .more_vert_rounded,
                                                                        ))
                                                                    : Row(
                                                                        mainAxisSize:
                                                                            MainAxisSize.min,
                                                                        children: [
                                                                          GestureDetector(
                                                                            onTap:
                                                                                () async {
                                                                              await soicalFunation(
                                                                                apiName: 'Follow',
                                                                                index: index,
                                                                              );
                                                                            },
                                                                            child:
                                                                                Container(
                                                                              height: 25,
                                                                              alignment: Alignment.center,
                                                                              width: 65,
                                                                              margin: EdgeInsets.only(bottom: 5),
                                                                              decoration: BoxDecoration(color: ColorConstant.primary_color, borderRadius: BorderRadius.circular(4)),
                                                                              child: uuid == null
                                                                                  ? Text(
                                                                                      'Follow',
                                                                                      style: TextStyle(fontFamily: "outfit", fontSize: 12, fontWeight: FontWeight.bold, color: Colors.white),
                                                                                    )
                                                                                  : AllGuestPostRoomData?.object?.content?[index].userAccountType == "PUBLIC"
                                                                                      ? (AllGuestPostRoomData?.object?.content?[index].isFollowing == 'FOLLOW'
                                                                                          ? Text(
                                                                                              'Follow',
                                                                                              style: TextStyle(fontFamily: "outfit", fontSize: 12, fontWeight: FontWeight.bold, color: Colors.white),
                                                                                            )
                                                                                          : Text(
                                                                                              'Following ',
                                                                                              style: TextStyle(fontFamily: "outfit", fontSize: 12, fontWeight: FontWeight.bold, color: Colors.white),
                                                                                            ))
                                                                                      : AllGuestPostRoomData?.object?.content?[index].isFollowing == 'FOLLOW'
                                                                                          ? Text(
                                                                                              'Follow',
                                                                                              style: TextStyle(fontFamily: "outfit", fontSize: 12, fontWeight: FontWeight.bold, color: Colors.white),
                                                                                            )
                                                                                          : AllGuestPostRoomData?.object?.content?[index].isFollowing == 'REQUESTED'
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
                                                                          if (User_ID !=
                                                                              null)
                                                                            GestureDetector(
                                                                                key: buttonKey,
                                                                                onTap: () async {
                                                                                  print("dfsdfgsdfgsdfgsdfg");
                                                                                  showPopupMenu1(context, index, buttonKey, AllGuestPostRoomData?.object?.content?[index].postUid, '_HomeScreenNewState');
                                                                                },
                                                                                child: Container(height: 25, width: 40, color: Colors.transparent, child: Icon(Icons.more_vert_rounded))),
                                                                        ],
                                                                      ),
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              height: 10,
                                                            ),
                                                            AllGuestPostRoomData
                                                                        ?.object
                                                                        ?.content?[
                                                                            index]
                                                                        .description !=
                                                                    null
                                                                ? GestureDetector(
                                                                    onTap:
                                                                        () async {
                                                                      if (DataGet ==
                                                                          true) {
                                                                        await launch(
                                                                            '${AllGuestPostRoomData?.object?.content?[index].description}',
                                                                            forceWebView:
                                                                                true,
                                                                            enableJavaScript:
                                                                                true);
                                                                      } else {
                                                                        Navigator
                                                                            .push(
                                                                          context,
                                                                          MaterialPageRoute(
                                                                              builder: (context) => OpenSavePostImage(
                                                                                    PostID: AllGuestPostRoomData?.object?.content?[index].postUid,
                                                                                  )),
                                                                        ).then(
                                                                            (value) {
                                                                          // Get_UserToken();

                                                                          setColorr();
                                                                        });
                                                                      }
                                                                    },
                                                                    child:
                                                                        Padding(
                                                                      padding: const EdgeInsets
                                                                              .only(
                                                                          left:
                                                                              16),
                                                                      child:
                                                                          Column(
                                                                        crossAxisAlignment:
                                                                            CrossAxisAlignment.start,
                                                                        children: [
                                                                          /*  SizedBox(
                                                                        height:
                                                                            10,
                                                                      ), */
                                                                          Row(
                                                                            children: [
                                                                              ///////////////////////////////////////////////////////////////////////////////////////////////////////////
                                                                              /*  Expanded(
                                                                            child: GestureDetector(onTap: () {
                                                                            print("cheakkkkkkkkkkkkkkkk${AllGuestPostRoomData?.object?.content?[index].description ?? ''}");
                                                                            print("index-$index");
                                                                          },
                                                                            child: Text(AllGuestPostRoomData?.object?.content?[index].description ?? '',))) */
                                                                              //////////////////////////////////////////////////////////////////////////////////////////////////////////
                                                                              Expanded(
                                                                                child: Container(
                                                                                  // color: Colors.red,
                                                                                  child: LinkifyText(
                                                                                    /*    utf8.decode(AllGuestPostRoomData?.object?.content?[index].description?.runes.toList() ??
                                                                                    []), */
                                                                                    // THIS IS THE SET
                                                                                    readmoree[index] == true
                                                                                        ? (AllGuestPostRoomData?.object?.content?[index].isTrsnalteoption == false || AllGuestPostRoomData?.object?.content?[index].isTrsnalteoption == null)
                                                                                            ? "${AllGuestPostRoomData?.object?.content?[index].description} ${(AllGuestPostRoomData?.object?.content?[index].description?.length ?? 0) > maxLength ? ' ....ReadLess' : ''}"
                                                                                            : "${AllGuestPostRoomData?.object?.content?[index].translatedDescription}"
                                                                                        : (AllGuestPostRoomData?.object?.content?[index].isTrsnalteoption == false || AllGuestPostRoomData?.object?.content?[index].isTrsnalteoption == null)
                                                                                            ? "${AllGuestPostRoomData?.object?.content?[index].description?.substring(0, maxLength)} ....ReadMore"
                                                                                            : "${AllGuestPostRoomData?.object?.content?[index].translatedDescription?.substring(0, maxLength)}....ReadMore",
                                                                                    linkStyle: TextStyle(
                                                                                      color: Colors.blue,
                                                                                      fontFamily: 'outfit',
                                                                                    ),
                                                                                    textStyle: TextStyle(
                                                                                      color: Colors.black,
                                                                                      fontFamily: 'outfit',
                                                                                    ),
                                                                                    linkTypes: [
                                                                                      LinkType.url,
                                                                                      LinkType.userTag,
                                                                                      LinkType.hashTag,
                                                                                      // LinkType
                                                                                      //     .email
                                                                                    ],
                                                                                    onTap: (link) async {
                                                                                      /// do stuff with `link` like
                                                                                      /// if(link.type == Link.url) launchUrl(link.value);

                                                                                      var SelectedTest = link.value.toString();
                                                                                      var Link = SelectedTest.startsWith('https');
                                                                                      var Link1 = SelectedTest.startsWith('http');
                                                                                      var Link2 = SelectedTest.startsWith('www');
                                                                                      var Link3 = SelectedTest.startsWith('WWW');
                                                                                      var Link4 = SelectedTest.startsWith('HTTPS');
                                                                                      var Link5 = SelectedTest.startsWith('HTTP');
                                                                                      var Link6 = SelectedTest.startsWith('https://pdslink.page.link/');
                                                                                      print("tag -- " + SelectedTest.toString());
                                                                                      if ((AllGuestPostRoomData?.object?.content?[index].description?.length ?? 0) > maxLength) {
                                                                                        /* if (User_ID == null) {
                                                                                      Navigator.of(context).push(MaterialPageRoute(builder: (context) => RegisterCreateAccountScreen()));
                                                                                    } else { */
                                                                                        if (Link == true || Link1 == true || Link2 == true || Link3 == true || Link4 == true || Link5 == true || Link6 == true) {
                                                                                          print("objectobjectobjectobjectobjectobjectobject:- 1");
                                                                                          if (Link2 == true || Link3 == true) {
                                                                                            print("objectobjectobjectobjectobjectobjectobject:- 2");
                                                                                            launchUrl(Uri.parse("https://${link.value.toString()}"));
                                                                                            print("qqqqqqqqhttps://${link.value}");
                                                                                          } else {
                                                                                            print("objectobjectobjectobjectobjectobjectobject:- 3");
                                                                                            if (Link6 == true) {
                                                                                              print("yes i am inList =   room");
                                                                                              Navigator.push(context, MaterialPageRoute(
                                                                                                builder: (context) {
                                                                                                  return NewBottomBar(
                                                                                                    buttomIndex: 1,
                                                                                                  );
                                                                                                },
                                                                                              ));
                                                                                            } else {
                                                                                              launchUrl(Uri.parse(link.value.toString()));
                                                                                              print("link.valuelink.value -- ${link.value}");
                                                                                            }
                                                                                          }
                                                                                        } else if (link.value != null) {
                                                                                          print("objectobjectobjectobjectobjectobjectobject:- 4");
                                                                                          if (link.value!.startsWith('#')) {
                                                                                            print("objectobjectobjectobjectobjectobjectobject:- 5");
                                                                                            await BlocProvider.of<GetGuestAllPostCubit>(context).seetinonExpried(context);
                                                                                            Navigator.push(
                                                                                                context,
                                                                                                MaterialPageRoute(
                                                                                                  builder: (context) => HashTagViewScreen(title: "${link.value}"),
                                                                                                ));
                                                                                          } else if (link.value!.startsWith('@')) {
                                                                                            print("objectobjectobjectobjectobjectobjectobject:- 6");
                                                                                            await BlocProvider.of<GetGuestAllPostCubit>(context).seetinonExpried(context);
                                                                                            var name;
                                                                                            var tagName;
                                                                                            name = SelectedTest;
                                                                                            tagName = name.replaceAll("@", "");
                                                                                            await BlocProvider.of<GetGuestAllPostCubit>(context).UserTagAPI(context, tagName);

                                                                                            Navigator.push(context, MaterialPageRoute(builder: (context) {
                                                                                              return ProfileScreen(User_ID: "${userTagModel?.object}", isFollowing: "");
                                                                                            })).then((value) => Get_UserToken());

                                                                                            print("tagName -- ${tagName}");
                                                                                            print("user id -- ${userTagModel?.object}");
                                                                                          } else {
                                                                                            print("objectobjectobjectobjectobjectobjectobject:- 7");
                                                                                            setState(() {
                                                                                              if (readmoree[index] == true) {
                                                                                                readmoree[index] = false;
                                                                                                print("--------------false ");
                                                                                              } else {
                                                                                                readmoree[index] = true;
                                                                                                print("-------------- true");
                                                                                              }
                                                                                            });
                                                                                          }
                                                                                        } else {
                                                                                          print("objectobjectobjectobjectobjectobjectobject:- 8");
                                                                                          setState(() {
                                                                                            if (readmoree[index] == true) {
                                                                                              readmoree[index] = false;
                                                                                              print("--------------false ");
                                                                                            } else {
                                                                                              readmoree[index] = true;
                                                                                              print("-------------- true");
                                                                                            }
                                                                                          });
                                                                                        }
                                                                                      } else {
                                                                                        if (User_ID == null) {
                                                                                          Navigator.of(context).push(MaterialPageRoute(builder: (context) => RegisterCreateAccountScreen()));
                                                                                        } else {
                                                                                          if (Link == true || Link1 == true || Link2 == true || Link3 == true || Link4 == true || Link5 == true || Link6 == true) {
                                                                                            if (Link2 == true || Link3 == true) {
                                                                                              launchUrl(Uri.parse("https://${link.value.toString()}"));
                                                                                              print("qqqqqqqqhttps://${link.value}");
                                                                                            } else {
                                                                                              if (Link6 == true) {
                                                                                                print("yes i am inList =   room");
                                                                                                Navigator.push(context, MaterialPageRoute(
                                                                                                  builder: (context) {
                                                                                                    return NewBottomBar(
                                                                                                      buttomIndex: 1,
                                                                                                    );
                                                                                                  },
                                                                                                ));
                                                                                              } else {
                                                                                                launchUrl(Uri.parse(link.value.toString()));
                                                                                                print("link.valuelink.value -- ${link.value}");
                                                                                              }
                                                                                            }
                                                                                          } else if (link.value != null) {
                                                                                            if (link.value!.startsWith('#')) {
                                                                                              await BlocProvider.of<GetGuestAllPostCubit>(context).seetinonExpried(context);
                                                                                              Navigator.push(
                                                                                                  context,
                                                                                                  MaterialPageRoute(
                                                                                                    builder: (context) => HashTagViewScreen(title: "${link.value}"),
                                                                                                  ));
                                                                                            } else if (link.value!.startsWith('@')) {
                                                                                              await BlocProvider.of<GetGuestAllPostCubit>(context).seetinonExpried(context);
                                                                                              var name;
                                                                                              var tagName;
                                                                                              name = SelectedTest;
                                                                                              tagName = name.replaceAll("@", "");
                                                                                              await BlocProvider.of<GetGuestAllPostCubit>(context).UserTagAPI(context, tagName);

                                                                                              Navigator.push(context, MaterialPageRoute(builder: (context) {
                                                                                                return ProfileScreen(User_ID: "${userTagModel?.object}", isFollowing: "");
                                                                                              })).then((value) => Get_UserToken());

                                                                                              print("tagName -- ${tagName}");
                                                                                              print("user id -- ${userTagModel?.object}");
                                                                                            }
                                                                                          }
                                                                                        }
                                                                                      }
                                                                                    },
                                                                                  ),
                                                                                ),
                                                                              ),

                                                                              SizedBox(
                                                                                width: 10,
                                                                              ),
                                                                              // InkWell(
                                                                              //     onTap: () async {

                                                                              //       String inputText = "${AllGuestPostRoomData?.object?.content?[index].description}";
                                                                              //       String translatedTextGujarati = await translateText(inputText, 'gu');
                                                                              //       super.setState(() {
                                                                              //         _translatedTextGujarati = translatedTextGujarati;
                                                                              //       });
                                                                              //     },
                                                                              //     child: Column(
                                                                              //       children: [
                                                                              //         Text(
                                                                              //           "Translate",
                                                                              //         ),
                                                                              //         Text(_translatedTextGujarati),
                                                                              //       ],
                                                                              //     )),
                                                                            ],
                                                                          ),
                                                                          AllGuestPostRoomData?.object?.content?[index].translatedDescription != null
                                                                              ? readmoree[index] == true
                                                                                  ? GestureDetector(
                                                                                      onTap: () async {
                                                                                        super.setState(() {
                                                                                          if (AllGuestPostRoomData?.object?.content?[index].isTrsnalteoption == false || AllGuestPostRoomData?.object?.content?[index].isTrsnalteoption == null) {
                                                                                            AllGuestPostRoomData?.object?.content?[index].isTrsnalteoption = true;
                                                                                          } else {
                                                                                            AllGuestPostRoomData?.object?.content?[index].isTrsnalteoption = false;
                                                                                          }
                                                                                        });
                                                                                      },
                                                                                      child: Container(
                                                                                          width: 80,
                                                                                          decoration: BoxDecoration(
                                                                                            color: ColorConstant.primaryLight_color,
                                                                                            borderRadius: BorderRadius.circular(10),
                                                                                          ),
                                                                                          child: Center(
                                                                                              child: Text(
                                                                                            "Translate",
                                                                                            style: TextStyle(
                                                                                              fontFamily: 'outfit',
                                                                                              fontWeight: FontWeight.bold,
                                                                                            ),
                                                                                          ))),
                                                                                    )
                                                                                  : SizedBox()
                                                                              : SizedBox(),
                                                                          /* Align(
                                                                        alignment:
                                                                            Alignment.centerRight,
                                                                        child: (AllGuestPostRoomData?.object?.content?[index].description?.length ?? 0) >
                                                                                maxLength
                                                                            ? GestureDetector(
                                                                                onTap: () {
                                                                                  setState(() {
                                                                                    if (readmoree[index] == true) {
                                                                                      readmoree[index] = false;
                                                                                      print("--------------false ");
                                                                                    } else {
                                                                                      readmoree[index] = true;
                                                                                      print("-------------- true");
                                                                                    }
                                                                                  });
                                                                                },
                                                                                child: Container(
                                                                                  // color: Colors.red,
                                                                                  width: 75,
                                                                                  height: 15,
                                                                                  child: Align(
                                                                                    alignment: Alignment.centerLeft,
                                                                                    child: Text(
                                                                                      readmoree[index] ? 'Read Less' : 'Read More',
                                                                                      style: TextStyle(
                                                                                        color: Colors.blue,
                                                                                        fontWeight: FontWeight.bold,
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                              )
                                                                            : SizedBox(),
                                                                      ) */
                                                                        ],
                                                                      ),
                                                                    ))
                                                                : SizedBox(),
                                                            // index == 0

                                                            Container(
                                                              width: _width,
                                                              child: AllGuestPostRoomData
                                                                          ?.object
                                                                          ?.content?[
                                                                              index]
                                                                          .postDataType ==
                                                                      null
                                                                  ? SizedBox()
                                                                  : AllGuestPostRoomData
                                                                              ?.object
                                                                              ?.content?[
                                                                                  index]
                                                                              .postData
                                                                              ?.length ==
                                                                          1
                                                                      ? (AllGuestPostRoomData?.object?.content?[index].postDataType ==
                                                                              "IMAGE"
                                                                          ? GestureDetector(
                                                                              onTap: () {
                                                                                /* f (uuid ==
                                                                                null) {
                                                                              Navigator.of(context).push(MaterialPageRoute(builder: (context) => RegisterCreateAccountScreen()));
                                                                            } else { */
                                                                                Navigator.push(
                                                                                  context,
                                                                                  MaterialPageRoute(
                                                                                      builder: (context) => OpenSavePostImage(
                                                                                            PostID: AllGuestPostRoomData?.object?.content?[index].postUid,
                                                                                            index: index,
                                                                                          )),
                                                                                ).then((value) {
                                                                                  // Get_UserToken();

                                                                                  setColorr();
                                                                                });
                                                                                // }
                                                                              },
                                                                              child: Container(
                                                                                width: _width,
                                                                                margin: EdgeInsets.only(left: 0, top: 15, right: 0),
                                                                                child: Center(
                                                                                  child: PinchZoom(
                                                                                    child: CachedNetworkImage(
                                                                                      imageUrl: "${AllGuestPostRoomData?.object?.content?[index].postData?[0]}",
                                                                                    ),
                                                                                    maxScale: 4,
                                                                                    onZoomStart: () {
                                                                                      print('Start zooming');
                                                                                    },
                                                                                    onZoomEnd: () {
                                                                                      print('Stop zooming');
                                                                                    },
                                                                                  ),

                                                                                  /* CustomImageView(
                                                                                url: "${AllGuestPostRoomData?.object?.content?[index].postData?[0]}",
                                                                              ), */
                                                                                ),
                                                                              ),
                                                                            )
                                                                          : AllGuestPostRoomData?.object?.content?[index].postDataType == "VIDEO"
                                                                              ? /*  mainPostControllers[0].value.isInitialized
                                                                              ? */

                                                                              Padding(
                                                                                  padding: const EdgeInsets.only(right: 20, top: 15),
                                                                                  child: Column(
                                                                                    mainAxisSize: MainAxisSize.min,
                                                                                    children: [
                                                                                      /* Container(
                                                                                            height: 250,
                                                                                            width: _width,
                                                                                            child: Chewie(
                                                                                              controller: chewieController[index],
                                                                                            )), */

                                                                                      VideoListItem1(
                                                                                        videoUrl: videoUrls[index],
                                                                                        PostID: AllGuestPostRoomData?.object?.content?[index].postUid,
                                                                                        // isData: User_ID == null ? false : true,
                                                                                      ),
                                                                                    ],
                                                                                  ),
                                                                                )
                                                                              // : SizedBox()

                                                                              : AllGuestPostRoomData?.object?.content?[index].postDataType == "ATTACHMENT"
                                                                                  ? (AllGuestPostRoomData?.object?.content?[index].postData?.isNotEmpty == true)
                                                                                      ? Stack(
                                                                                          children: [
                                                                                            Container(
                                                                                              height: 400,
                                                                                              width: _width,
                                                                                              color: Colors.transparent,
                                                                                              /* child: DocumentViewScreen1(
                                                                                            path: AllGuestPostRoomData?.object?.content?[index].postData?[0].toString(),
                                                                                          ) */
                                                                                            ),
                                                                                            GestureDetector(
                                                                                              onTap: () {
                                                                                                if (uuid == null) {
                                                                                                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => RegisterCreateAccountScreen()));
                                                                                                } else {
                                                                                                  print("objectobjectobjectobject");
                                                                                                  Navigator.push(context, MaterialPageRoute(
                                                                                                    builder: (context) {
                                                                                                      return DocumentViewScreen1(
                                                                                                        path: AllGuestPostRoomData?.object?.content?[index].postData?[0].toString(),
                                                                                                      );
                                                                                                    },
                                                                                                  ));
                                                                                                }
                                                                                              },
                                                                                              child: Container(
                                                                                                child: CustomImageView(
                                                                                                  url: "${AllGuestPostRoomData?.object?.content?[index].thumbnailImageUrl}",
                                                                                                  fit: BoxFit.cover,
                                                                                                ),
                                                                                                //  CachedNetworkImage(
                                                                                                //   imageUrl: "${AllGuestPostRoomData?.object?.content?[index].thumbnailImageUrl}",
                                                                                                //   fit: BoxFit.cover,
                                                                                                // ),
                                                                                              ),
                                                                                            )
                                                                                          ],
                                                                                        )
                                                                                      : SizedBox()
                                                                                  : SizedBox())
                                                                      : Column(
                                                                          children: [
                                                                            Stack(
                                                                              children: [
                                                                                if ((AllGuestPostRoomData?.object?.content?[index].postData?.isNotEmpty ?? false)) ...[
                                                                                  Container(
                                                                                    height: _height / 1.4,
                                                                                    child: PageView.builder(
                                                                                      onPageChanged: (page) {
                                                                                        super.setState(() {
                                                                                          _currentPages2[index] = page;
                                                                                          imageCount2 = page + 1;
                                                                                        });
                                                                                      },
                                                                                      controller: _pageControllers2[index],
                                                                                      itemCount: AllGuestPostRoomData?.object?.content?[index].postData?.length,
                                                                                      itemBuilder: (BuildContext context, int index1) {
                                                                                        if (AllGuestPostRoomData?.object?.content?[index].postDataType == "IMAGE") {
                                                                                          return Container(
                                                                                            // color: Colors.amber,
                                                                                            width: _width,
                                                                                            margin: EdgeInsets.only(left: 0, top: 15, right: 0),
                                                                                            child: Center(
                                                                                              child: GestureDetector(
                                                                                                onTap: () {
                                                                                                  /*   if (uuid == null) {
                                                                                              Navigator.of(context).push(MaterialPageRoute(builder: (context) => RegisterCreateAccountScreen()));
                                                                                            } else { */
                                                                                                  Navigator.push(
                                                                                                    context,
                                                                                                    MaterialPageRoute(
                                                                                                        builder: (context) => OpenSavePostImage(
                                                                                                              PostID: AllGuestPostRoomData?.object?.content?[index].postUid,
                                                                                                              index: index1,
                                                                                                            )),
                                                                                                  ).then((value) {
                                                                                                    // Get_UserToken();

                                                                                                    setColorr();
                                                                                                  });
                                                                                                  // }
                                                                                                },
                                                                                                //this is the cusotmImageView
                                                                                                /* child: Container(
                                                                                            color: Colors.white,
                                                                                            width: MediaQuery.of(context).size.width,
                                                                                            height: MediaQuery.of(context).size.height * 0.5, //tththth
                                                                                            child: Stack(
                                                                                              children: [
                                                                                                PhotoViewGallery(
                                                                                                  onPageChanged: (value) {
                                                                                                    super.setState(() {
                                                                                                      imageCount = value + 1;
                                                                                                    });
                                                                                                    print("imageCountcheck--${imageCount}");
                                                                                                  },
                                                                                                  backgroundDecoration: BoxDecoration(color: Colors.white),
                                                                                                  pageOptions: AllGuestPostRoomData?.object?.content?[index].postData
                                                                                                      ?.map((images) => PhotoViewGalleryPageOptions(
                                                                                                            imageProvider: NetworkImage(images),
                                                                                                            minScale: PhotoViewComputedScale.contained,
                                                                                                            maxScale: PhotoViewComputedScale.covered * 2,
                                                                                                          ))
                                                                                                      .toList(),
                                                                                                ),
                                                                                                Align(alignment: Alignment.topRight, child: Text(imageCount.toString() + '/' + '${AllGuestPostRoomData?.object?.content?[index].postData?.length}'))
                                                                                              ],
                                                                                            ),
                                                                                          ), */
                                                                                                child: Stack(
                                                                                                  children: [
                                                                                                    Align(
                                                                                                      alignment: Alignment.center,
                                                                                                      child: PinchZoom(
                                                                                                        child: CachedNetworkImage(
                                                                                                          imageUrl: "${AllGuestPostRoomData?.object?.content?[index].postData?[0]}",
                                                                                                        ),
                                                                                                        maxScale: 4,
                                                                                                        onZoomStart: () {
                                                                                                          print('Start zooming');
                                                                                                        },
                                                                                                        onZoomEnd: () {
                                                                                                          print('Stop zooming');
                                                                                                        },
                                                                                                      ),
                                                                                                      /* CustomImageView(
                                                                                                        url: "${AllGuestPostRoomData?.object?.content?[index].postData?[index1]}",
                                                                                                      ) */
                                                                                                    ),
                                                                                                    Align(
                                                                                                      alignment: Alignment.topRight,
                                                                                                      child: Card(
                                                                                                        color: Colors.transparent,
                                                                                                        elevation: 0,
                                                                                                        child: Container(
                                                                                                            alignment: Alignment.center,
                                                                                                            height: 30,
                                                                                                            width: 50,
                                                                                                            decoration: BoxDecoration(
                                                                                                              color: Color.fromARGB(255, 2, 1, 1),
                                                                                                              borderRadius: BorderRadius.all(Radius.circular(50)),
                                                                                                            ),
                                                                                                            child: Text(
                                                                                                              imageCount2.toString() + '/' + '${AllGuestPostRoomData?.object?.content?[index].postData?.length}',
                                                                                                              style: TextStyle(color: Colors.white),
                                                                                                            )),
                                                                                                      ),
                                                                                                    ),
                                                                                                  ],
                                                                                                ),
                                                                                              ),
                                                                                            ),
                                                                                          );
                                                                                        } else if (AllGuestPostRoomData?.object?.content?[index].postDataType == "ATTACHMENT") {
                                                                                          return Container(
                                                                                              height: 400,
                                                                                              width: _width,
                                                                                              child: DocumentViewScreen1(
                                                                                                path: AllGuestPostRoomData?.object?.content?[index].postData?[index1].toString(),
                                                                                              ));
                                                                                        }
                                                                                      },
                                                                                    ),
                                                                                  ),
                                                                                  Positioned(
                                                                                      bottom: 5,
                                                                                      left: 0,
                                                                                      right: 0,
                                                                                      child: Padding(
                                                                                        padding: const EdgeInsets.only(top: 0),
                                                                                        child: Container(
                                                                                          height: 20,
                                                                                          child: DotsIndicator(
                                                                                            dotsCount: AllGuestPostRoomData?.object?.content?[index].postData?.length ?? 0,
                                                                                            position: _currentPages2[index].toDouble(),
                                                                                            decorator: DotsDecorator(
                                                                                              size: const Size(10.0, 7.0),
                                                                                              activeSize: const Size(10.0, 10.0),
                                                                                              spacing: const EdgeInsets.symmetric(horizontal: 2),
                                                                                              activeColor: ColorConstant.primary_color,
                                                                                              color: Color(0xff6A6A6A),
                                                                                            ),
                                                                                          ),
                                                                                        ),
                                                                                      ))
                                                                                ]
                                                                                // : SizedBox()
                                                                              ],
                                                                            ),
                                                                          ],
                                                                        ),
                                                            ),

                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(8.0),
                                                              child: Divider(
                                                                thickness: 1,
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              height: 5,
                                                            ),
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      top: 0,
                                                                      right:
                                                                          16),
                                                              child: Row(
                                                                children: [
                                                                  SizedBox(
                                                                    width: 14,
                                                                  ),
                                                                  GestureDetector(
                                                                    onTap:
                                                                        () async {
                                                                      await soicalFunation(
                                                                          apiName:
                                                                              'like_post',
                                                                          index:
                                                                              index);
                                                                    },
                                                                    child:
                                                                        Container(
                                                                      color: Colors
                                                                          .transparent,
                                                                      child:
                                                                          Padding(
                                                                        padding:
                                                                            EdgeInsets.all(5.0),
                                                                        child: AllGuestPostRoomData?.object?.content?[index].isLiked !=
                                                                                true
                                                                            ? Image.asset(
                                                                                ImageConstant.likewithout,
                                                                                height: 18,
                                                                              )
                                                                            : Image.asset(
                                                                                ImageConstant.like,
                                                                                height: 18,
                                                                              ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  /* SizedBox(
                                                                width: 0,
                                                              ), */
                                                                  AllGuestPostRoomData
                                                                              ?.object
                                                                              ?.content?[index]
                                                                              .likedCount ==
                                                                          0
                                                                      ? SizedBox()
                                                                      : GestureDetector(
                                                                          onTap:
                                                                              () {
                                                                            /* Navigator.push(  
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
         
                                                            ShowAllPostLike("${AllGuestPostRoomData?.object?[index].postUid}"))); */
                                                                            if (uuid ==
                                                                                null) {
                                                                              Navigator.of(context).push(MaterialPageRoute(builder: (context) => RegisterCreateAccountScreen()));
                                                                            } else {
                                                                              Navigator.push(context, MaterialPageRoute(
                                                                                builder: (context) {
                                                                                  return ShowAllPostLike("${AllGuestPostRoomData?.object?.content?[index].postUid}");
                                                                                },
                                                                              ));
                                                                            }
                                                                          },
                                                                          child:
                                                                              Container(
                                                                            color:
                                                                                Colors.transparent,
                                                                            child:
                                                                                Padding(
                                                                              padding: EdgeInsets.all(5.0),
                                                                              child: Align(
                                                                                alignment: Alignment.centerLeft,
                                                                                child: Text(
                                                                                  "${AllGuestPostRoomData?.object?.content?[index].likedCount}",
                                                                                  style: TextStyle(fontFamily: "outfit", fontSize: 14),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                  SizedBox(
                                                                    width: 8,
                                                                  ),
                                                                  GestureDetector(
                                                                      onTap:
                                                                          () async {
                                                                        if (uuid ==
                                                                            null) {
                                                                          Navigator.of(context)
                                                                              .push(MaterialPageRoute(builder: (context) => RegisterCreateAccountScreen()));
                                                                        } else {
                                                                          BlocProvider.of<AddcommentCubit>(context).Addcomment(
                                                                              context,
                                                                              '${AllGuestPostRoomData?.object?.content?[index].postUid}');
                                                                          _settingModalBottomSheet1(
                                                                              context,
                                                                              index,
                                                                              _width);
                                                                        }
                                                                      },
                                                                      child: Container(
                                                                          color: Colors.transparent,
                                                                          child: Padding(
                                                                              padding: EdgeInsets.all(5.0),
                                                                              child: Image.asset(
                                                                                ImageConstant.meesage,
                                                                                height: 15,
                                                                                // width: 15,
                                                                              )))),
                                                                  SizedBox(
                                                                    width: 5,
                                                                  ),
                                                                  AllGuestPostRoomData
                                                                              ?.object
                                                                              ?.content?[index]
                                                                              .commentCount ==
                                                                          0
                                                                      ? SizedBox()
                                                                      : Text(
                                                                          "${AllGuestPostRoomData?.object?.content?[index].commentCount}",
                                                                          style: TextStyle(
                                                                              fontFamily: "outfit",
                                                                              fontSize: 14),
                                                                        ),
                                                                  SizedBox(
                                                                    width: 5,
                                                                  ),
                                                                  GestureDetector(
                                                                    onTap: () {
                                                                      if (uuid ==
                                                                          null) {
                                                                        Navigator.of(context).push(MaterialPageRoute(
                                                                            builder: (context) =>
                                                                                RegisterCreateAccountScreen()));
                                                                      } else {
                                                                        rePostBottomSheet(
                                                                            context,
                                                                            index);
                                                                        // Navigator.push(
                                                                        //     context,
                                                                        //     MaterialPageRoute(
                                                                        //   builder:
                                                                        //       (context) {
                                                                        //     return RePostScreen(
                                                                        //       userProfile: AllGuestPostRoomData
                                                                        //           ?.object
                                                                        //           ?.content?[index]
                                                                        //           .userProfilePic,
                                                                        //       username: AllGuestPostRoomData
                                                                        //           ?.object
                                                                        //           ?.content?[index]
                                                                        //           .postUserName,
                                                                        //       date: AllGuestPostRoomData
                                                                        //           ?.object
                                                                        //           ?.content?[index]
                                                                        //           .createdAt,
                                                                        //       desc: AllGuestPostRoomData
                                                                        //           ?.object
                                                                        //           ?.content?[index]
                                                                        //           .description,
                                                                        //       postData: AllGuestPostRoomData
                                                                        //           ?.object
                                                                        //           ?.content?[index]
                                                                        //           .postData,
                                                                        //       postDataType: AllGuestPostRoomData
                                                                        //           ?.object
                                                                        //           ?.content?[index]
                                                                        //           .postDataType,
                                                                        //       index:
                                                                        //           index,
                                                                        //       AllGuestPostRoomData:
                                                                        //           AllGuestPostRoomData,
                                                                        //       postUid: AllGuestPostRoomData
                                                                        //           ?.object
                                                                        //           ?.content?[index]
                                                                        //           .postUid,
                                                                        //     );
                                                                        //   },
                                                                        // ));
                                                                      }
                                                                    },
                                                                    child:
                                                                        Container(
                                                                      color: Colors
                                                                          .transparent,
                                                                      child:
                                                                          Padding(
                                                                        padding:
                                                                            const EdgeInsets.all(5.0),
                                                                        child: Image
                                                                            .asset(
                                                                          ImageConstant
                                                                              .vector2,
                                                                          height:
                                                                              13,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  SizedBox(
                                                                    width: 5,
                                                                  ),
                                                                  AllGuestPostRoomData?.object?.content?[index].repostCount ==
                                                                              null ||
                                                                          AllGuestPostRoomData?.object?.content?[index].repostCount ==
                                                                              0
                                                                      ? SizedBox()
                                                                      : Text(
                                                                          uuid == null
                                                                              ? ""
                                                                              : '${AllGuestPostRoomData?.object?.content?[index].repostCount}',
                                                                          style: TextStyle(
                                                                              fontFamily: "outfit",
                                                                              fontSize: 14),
                                                                        ),
                                                                  GestureDetector(
                                                                    onTap: () {
                                                                      if (uuid ==
                                                                          null) {
                                                                        Navigator.of(context).push(MaterialPageRoute(
                                                                            builder: (context) =>
                                                                                RegisterCreateAccountScreen()));
                                                                      } else {
                                                                        print(
                                                                            "check Data Get-${AllGuestPostRoomData?.object?.content?[index].postLink}");
                                                                        _onShareXFileFromAssets(
                                                                          context,
                                                                          androidLink:
                                                                              '${AllGuestPostRoomData?.object?.content?[index].postLink}',
                                                                          /* iosLink:
                                                      "https://apps.apple.com/inList =  /app/growder-b2b-platform/id6451333863" */
                                                                        );
                                                                      }
                                                                    },
                                                                    child:
                                                                        Container(
                                                                      height:
                                                                          20,
                                                                      width: 30,
                                                                      color: Colors
                                                                          .transparent,
                                                                      child: Icon(
                                                                          Icons
                                                                              .share_rounded,
                                                                          size:
                                                                              20),
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
                                                                    onTap:
                                                                        () async {
                                                                      await soicalFunation(
                                                                          apiName:
                                                                              'savedata',
                                                                          index:
                                                                              index);
                                                                    },
                                                                    child:
                                                                        Container(
                                                                      color: Colors
                                                                          .transparent,
                                                                      child:
                                                                          Padding(
                                                                        padding:
                                                                            const EdgeInsets.all(5.0),
                                                                        child: uuid ==
                                                                                null
                                                                            ? Image.asset(
                                                                                /* AllGuestPostRoomData?.object?.content?[index].isSaved == false
                                                                                ? ImageConstant.savePin
                                                                                : */
                                                                                ImageConstant.savePin,
                                                                                height: 17,
                                                                              )
                                                                            : Image.asset(
                                                                                AllGuestPostRoomData?.object?.content?[index].isSaved == false ? ImageConstant.savePin : ImageConstant.Savefill,
                                                                                height: 17,
                                                                              ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  // GestureDetector(
                                                                  //   onTap: () {
                                                                  //     Share.share(
                                                                  //         'https://play.google.com/store/apps/details?id=com.inpackaging.app');
                                                                  //   },
                                                                  //   child: Container(
                                                                  //     color: Colors
                                                                  //         .transparent,
                                                                  //     child: Padding(
                                                                  //       padding:
                                                                  //           const EdgeInsets
                                                                  //                   .all(
                                                                  //               5.0),
                                                                  //       child: Image
                                                                  //           .asset(
                                                                  //         ImageConstant
                                                                  //             .shareBlack,
                                                                  //         height: 17,
                                                                  //       ),
                                                                  //     ),
                                                                  //   ),
                                                                  // ),
                                                                ],
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              height: 5,
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  );
                                      },
                                      separatorBuilder:
                                          (BuildContext context, int index) {
                                        if (index == 1) {
                                          return User_Module == 'EXPERT' ||
                                                  User_Module == null
                                              ? SizedBox(
                                                  height: 10,
                                                )
                                              : User_ID == null
                                                  ? SizedBox(
                                                      height: 30,
                                                    )
                                                  : AllExperData?.object
                                                              ?.isNotEmpty ==
                                                          false
                                                      ? SizedBox(
                                                          height: 20,
                                                        )
                                                      : Column(
                                                          children: [
                                                            SizedBox(
                                                              height: 30,
                                                            ),
                                                            Row(
                                                              children: [
                                                                Container(
                                                                  margin: EdgeInsets
                                                                      .only(
                                                                          left:
                                                                              10),
                                                                  child: Text(
                                                                    'Experts',
                                                                    style: TextStyle(
                                                                        fontFamily:
                                                                            "outfit",
                                                                        fontSize:
                                                                            18,
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .bold,
                                                                        color: Colors
                                                                            .black),
                                                                  ),
                                                                ),
                                                                Spacer(),
                                                                GestureDetector(
                                                                  onTap: () {
                                                                    Navigator
                                                                        .push(
                                                                            context,
                                                                            MaterialPageRoute(
                                                                              builder: (context) => MultiBlocProvider(providers: [
                                                                                BlocProvider<SherInviteCubit>(
                                                                                  create: (_) => SherInviteCubit(),
                                                                                ),
                                                                              ], child: ExpertsScreen(RoomUUID: "")),
                                                                              // ExpertsScreen(RoomUUID:  PriveateRoomData?.object?[index].uid),
                                                                            )).then(
                                                                        (value) =>
                                                                            super.setState(() {
                                                                              // refresh = true;
                                                                            }));
                                                                  },
                                                                  child: SizedBox(
                                                                      height: 20,
                                                                      child: Icon(
                                                                        Icons
                                                                            .arrow_forward_rounded,
                                                                        color: Colors
                                                                            .black,
                                                                      )),
                                                                ),
                                                                SizedBox(
                                                                  width: 10,
                                                                ),
                                                              ],
                                                            ),
                                                            Container(
                                                              // color: Colors.green,
                                                              height: 230,
                                                              width: _width,
                                                              child: ListView
                                                                  .builder(
                                                                itemCount:
                                                                    AllExperData
                                                                        ?.object
                                                                        ?.length,
                                                                scrollDirection:
                                                                    Axis.horizontal,
                                                                itemBuilder:
                                                                    (context,
                                                                        index) {
                                                                  return Center(
                                                                    child:
                                                                        Padding(
                                                                      padding: EdgeInsets.only(
                                                                          left: index == 0
                                                                              ? 16
                                                                              : 4,
                                                                          right:
                                                                              4),
                                                                      child:
                                                                          Container(
                                                                        height:
                                                                            190,
                                                                        width:
                                                                            130,
                                                                        decoration: BoxDecoration(
                                                                            // color: Colors.red,
                                                                            border: Border.all(color: ColorConstant.primary_color, width: 3),
                                                                            borderRadius: BorderRadius.circular(14)),
                                                                        child:
                                                                            Stack(
                                                                          children: [
                                                                            AllExperData?.object?[index].profilePic == null || AllExperData?.object?[index].profilePic == ""
                                                                                ? CustomImageView(
                                                                                    height: 110,
                                                                                    width: 128,
                                                                                    // fit: BoxFit.fill,
                                                                                    imagePath: ImageConstant.brandlogo,
                                                                                  )
                                                                                : CustomImageView(
                                                                                    height: 120,
                                                                                    width: 128,
                                                                                    radius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10)),
                                                                                    url: "${AllExperData?.object?[index].profilePic}",
                                                                                    fit: BoxFit.cover,
                                                                                  ),
                                                                            Align(
                                                                              alignment: Alignment.topCenter,
                                                                              child: GestureDetector(
                                                                                onTap: () async {
                                                                                  print("followStatusfollowStatus == >>${AllExperData?.object?[index].followStatus}");
                                                                                  BlocProvider.of<GetGuestAllPostCubit>(context).followWIngMethod(AllExperData?.object?[index].uuid, context);
                                                                                },
                                                                                child: Container(
                                                                                  height: 24,
                                                                                  alignment: Alignment.center,
                                                                                  width: AllExperData?.object?[index].followStatus == 'FOLLOW' ? 70 : 95,
                                                                                  decoration: BoxDecoration(
                                                                                    borderRadius: BorderRadius.only(
                                                                                      bottomLeft: Radius.circular(8),
                                                                                      bottomRight: Radius.circular(8),
                                                                                    ),
                                                                                    color: ColorConstant.primary_color,
                                                                                  ),
                                                                                  child: Row(
                                                                                    children: [
                                                                                      Padding(
                                                                                        padding: EdgeInsets.only(left: 8, right: 4),
                                                                                        child: Icon(
                                                                                          Icons.person_add_alt,
                                                                                          size: 16,
                                                                                          color: Colors.white,
                                                                                        ),
                                                                                      ),
                                                                                      AllExperData?.object?[index].followStatus == 'FOLLOW'
                                                                                          ? Text(
                                                                                              'Follow',
                                                                                              style: TextStyle(fontFamily: "outfit", fontSize: 12, fontWeight: FontWeight.bold, color: Colors.white),
                                                                                            )
                                                                                          : AllExperData?.object?[index].followStatus == 'REQUESTED'
                                                                                              ? Text(
                                                                                                  'Requested',
                                                                                                  style: TextStyle(fontFamily: "outfit", fontSize: 12, fontWeight: FontWeight.bold, color: Colors.white),
                                                                                                )
                                                                                              : Text(
                                                                                                  'Following ',
                                                                                                  style: TextStyle(fontFamily: "outfit", fontSize: 12, fontWeight: FontWeight.bold, color: Colors.white),
                                                                                                ),
                                                                                    ],
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                            Padding(
                                                                              padding: EdgeInsets.only(bottom: 25),
                                                                              child: Align(
                                                                                alignment: Alignment.bottomCenter,
                                                                                child: Container(
                                                                                  height: 40,
                                                                                  width: 115,
                                                                                  // color: Colors.amber,
                                                                                  child: Column(
                                                                                    children: [
                                                                                      Row(
                                                                                        children: [
                                                                                          Text(
                                                                                            "${AllExperData?.object?[index].userName ?? ''}",
                                                                                            style: TextStyle(fontSize: 11, color: Colors.black, fontFamily: "outfit", fontWeight: FontWeight.bold),
                                                                                          ),
                                                                                          SizedBox(
                                                                                            width: 2,
                                                                                          ),
                                                                                          Image.asset(
                                                                                            ImageConstant.Star,
                                                                                            height: 11,
                                                                                          ),
                                                                                        ],
                                                                                      ),
                                                                                      Row(
                                                                                        children: [
                                                                                          SizedBox(
                                                                                              height: 13,
                                                                                              child: Image.asset(
                                                                                                ImageConstant.beg,
                                                                                                color: Colors.black,
                                                                                              )),
                                                                                          SizedBox(
                                                                                            width: 2,
                                                                                          ),
                                                                                          Expanded(
                                                                                            child: Text(
                                                                                              '${AllExperData?.object?[index].expertise?[0].expertiseName ?? ''}',
                                                                                              maxLines: 1,
                                                                                              style: TextStyle(fontFamily: "outfit", fontSize: 11, overflow: TextOverflow.ellipsis, color: Colors.black, fontWeight: FontWeight.bold),
                                                                                            ),
                                                                                          ),
                                                                                        ],
                                                                                      )
                                                                                    ],
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                            GestureDetector(
                                                                              onTap: () {
                                                                                Navigator
                                                                                    .push(
                                                                                        context,
                                                                                        MaterialPageRoute(
                                                                                          builder: (context) => MultiBlocProvider(providers: [
                                                                                            BlocProvider<SherInviteCubit>(
                                                                                              create: (_) => SherInviteCubit(),
                                                                                            ),
                                                                                          ], child: ExpertsScreen(RoomUUID: "")),
                                                                                          // ExpertsScreen(RoomUUID:  PriveateRoomData?.object?[index].uid),
                                                                                        )).then((value) => super.setState(() {
                                                                                      // refresh = true;
                                                                                    }));
                                                                              },
                                                                              child: Align(
                                                                                alignment: Alignment.bottomCenter,
                                                                                child: Container(
                                                                                  height: 25,
                                                                                  width: 130,
                                                                                  decoration: BoxDecoration(
                                                                                    borderRadius: BorderRadius.only(
                                                                                      bottomLeft: Radius.circular(8),
                                                                                      bottomRight: Radius.circular(8),
                                                                                    ),
                                                                                    color: ColorConstant.primary_color,
                                                                                  ),
                                                                                  child: Center(
                                                                                    child: Text(
                                                                                      'Invite',
                                                                                      style: TextStyle(fontFamily: "outfit", fontSize: 13, color: Colors.white, fontWeight: FontWeight.bold),
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  );
                                                                },
                                                              ),
                                                            )
                                                          ],
                                                        );
                                        }

                                        if (getallBlogModel1
                                                    ?.object?.isNotEmpty ==
                                                true &&
                                            index == 0) {
                                          // print("index check$index");

                                          return User_ID == null
                                              ? SizedBox(
                                                  height: 30,
                                                )
                                              : isDataget != true
                                                  ? SizedBox()
                                                  : Column(
                                                      children: [
                                                        SizedBox(
                                                          height: 30,
                                                        ),
                                                        Row(
                                                          children: [
                                                            Container(
                                                              margin: EdgeInsets
                                                                  .only(
                                                                      left: 10),
                                                              child: Text(
                                                                'Blogs',
                                                                style: TextStyle(
                                                                    fontFamily:
                                                                        "outfit",
                                                                    fontSize:
                                                                        18,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    color: Colors
                                                                        .black),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        Container(
                                                          height:
                                                              _height / 3.23,
                                                          // width: _width,
                                                          margin:
                                                              EdgeInsets.only(
                                                                  bottom: 15),
                                                          child:
                                                              ListView.builder(
                                                            itemCount:
                                                                getallBlogModel1
                                                                    ?.object
                                                                    ?.length,
                                                            scrollDirection:
                                                                Axis.horizontal,
                                                            itemBuilder:
                                                                (context,
                                                                    index1) {
                                                              if (getallBlogModel1
                                                                          ?.object
                                                                          ?.length !=
                                                                      0 ||
                                                                  getallBlogModel1
                                                                          ?.object !=
                                                                      null) {
                                                                parsedDateTimeBlogs =
                                                                    DateTime.parse(
                                                                        '${getallBlogModel1?.object?[index1].createdAt ?? ""}');
                                                                // print(
                                                                //     'index $index1 parsedDateTimeBlogs------$parsedDateTimeBlogs ');
                                                              }
                                                              return GestureDetector(
                                                                onTap: () {
                                                                  Navigator.push(
                                                                      context,
                                                                      MaterialPageRoute(
                                                                        builder:
                                                                            (context) =>
                                                                                RecentBlogScren(
                                                                          index:
                                                                              index1,
                                                                          getallBlogModel1:
                                                                              getallBlogModel1,
                                                                          description1:
                                                                              getallBlogModel1?.object?[index1].description.toString() ?? "",
                                                                          title:
                                                                              getallBlogModel1?.object?[index1].title.toString() ?? "",
                                                                          imageURL:
                                                                              getallBlogModel1?.object?[index1].image.toString() ?? "",
                                                                        ),
                                                                      ));
                                                                },
                                                                child:
                                                                    Container(
                                                                  height: 230,
                                                                  width:
                                                                      _width /
                                                                          1.6,
                                                                  margin:
                                                                      EdgeInsets
                                                                          .only(
                                                                    left: 10,
                                                                  ),
                                                                  decoration: BoxDecoration(
                                                                      borderRadius: BorderRadius.circular(12),
                                                                      color: Colors.white,
                                                                      border: Border.all(
                                                                          // color: Colors.black,
                                                                          color: Color(0xffF1F1F1),
                                                                          width: 5)),
                                                                  child: Column(
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .start,
                                                                    children: [
                                                                      CustomImageView(
                                                                        url: getallBlogModel1?.object?[index1].image.toString() ??
                                                                            "",
                                                                        height:
                                                                            150,
                                                                        width:
                                                                            _width,
                                                                        fit: BoxFit
                                                                            .fill,
                                                                        radius:
                                                                            BorderRadius.circular(10),
                                                                      ),
                                                                      Padding(
                                                                        padding: const EdgeInsets.only(
                                                                            left:
                                                                                9,
                                                                            top:
                                                                                7),
                                                                        child:
                                                                            Text(
                                                                          "${getallBlogModel1?.object?[index1].title}",
                                                                          maxLines:
                                                                              1,
                                                                          style: TextStyle(
                                                                              fontSize: 16,
                                                                              overflow: TextOverflow.ellipsis,
                                                                              fontFamily: "outfit",
                                                                              fontWeight: FontWeight.w400),
                                                                        ),
                                                                      ),
                                                                      Row(
                                                                        children: [
                                                                          Padding(
                                                                            padding:
                                                                                const EdgeInsets.only(left: 10, top: 3),
                                                                            child:
                                                                                Text(
                                                                              /*  getallBlogModel?.object?.length != 0 ||
                                                                                        getallBlogModel?.object != null
                                                                                    ?
                                                                                    : */
                                                                              customFormat(parsedDateTimeBlogs!),
                                                                              style: TextStyle(fontFamily: "outfit", fontSize: 12, fontWeight: FontWeight.w400, color: Color(0xffABABAB)),
                                                                            ),
                                                                          ),
                                                                          // Container(
                                                                          //   height:
                                                                          //       6,
                                                                          //   width:
                                                                          //       7,
                                                                          //   margin: EdgeInsets.only(
                                                                          //       top: 5,
                                                                          //       left: 2),
                                                                          //   decoration: BoxDecoration(
                                                                          //       shape: BoxShape.circle,
                                                                          //       color: Color(0xffABABAB)),
                                                                          // ),
                                                                          // Padding(
                                                                          //   padding: const EdgeInsets.only(
                                                                          //       top: 4,
                                                                          //       left: 1),
                                                                          //   child:
                                                                          //       Text(
                                                                          //     '12.3K Views',
                                                                          //     style:
                                                                          //         TextStyle(fontSize: 11, color: Color(0xffABABAB)),
                                                                          //   ),
                                                                          // ),
                                                                        ],
                                                                      ),
                                                                      Row(
                                                                        children: [
                                                                          GestureDetector(
                                                                            onTap:
                                                                                () {
                                                                              print("Click On Like Button");

                                                                              BlocProvider.of<GetGuestAllPostCubit>(context).LikeBlog(context, "${User_ID}", "${getallBlogModel1?.object?[index1].uid}");

                                                                              if (getallBlogModel1?.object?[index1].isLiked == true) {
                                                                                getallBlogModel1?.object?[index1].isLiked = false;
                                                                                int a = getallBlogModel1?.object?[index1].likeCount ?? 0;
                                                                                int b = 1;
                                                                                getallBlogModel1?.object?[index1].likeCount = a - b;
                                                                              } else {
                                                                                getallBlogModel1?.object?[index1].isLiked = true;
                                                                                getallBlogModel1?.object?[index1].likeCount;
                                                                                int a = getallBlogModel1?.object?[index1].likeCount ?? 0;
                                                                                int b = 1;
                                                                                getallBlogModel1?.object?[index1].likeCount = a + b;
                                                                              }

                                                                              // if (getallBlogModel1?.object?[index1].isLiked ==
                                                                              //     false) {
                                                                              //   getallBlogModel1?.object?[index1].isLiked = true;

                                                                              // } else {
                                                                              //   getallBlogModel1?.object?[index1].isLiked = false;

                                                                              // }
                                                                            },
                                                                            child:
                                                                                Padding(
                                                                              padding: const EdgeInsets.only(left: 7, top: 4),
                                                                              child: getallBlogModel1?.object?[index1].isLiked == false
                                                                                  ? Icon(Icons.favorite_border)
                                                                                  : Icon(
                                                                                      Icons.favorite,
                                                                                      color: ColorConstant.primary_color,
                                                                                    ),
                                                                            ),
                                                                          ),
                                                                          SizedBox(
                                                                            width:
                                                                                5,
                                                                          ),
                                                                          getallBlogModel1?.object?[index1].likeCount == 0
                                                                              ? SizedBox()
                                                                              : GestureDetector(
                                                                                  onTap: () {
                                                                                    print("User_id -- ${User_ID}");
                                                                                    print("blog UUid -- ${getallBlogModel1?.object?[index1].uid}");
                                                                                    Navigator.push(context, MaterialPageRoute(
                                                                                      builder: (context) {
                                                                                        return BlogLikeListScreen(
                                                                                          BlogUid: "${getallBlogModel1?.object?[index1].uid}",
                                                                                          user_id: User_ID,
                                                                                        );
                                                                                      },
                                                                                    ));
                                                                                  },
                                                                                  child: Container(
                                                                                    color: Colors.transparent,
                                                                                    child: Padding(
                                                                                      padding: const EdgeInsets.all(5.0),
                                                                                      child: Text(
                                                                                        "${getallBlogModel1?.object?[index1].likeCount == null ? 0 : getallBlogModel1?.object?[index1].likeCount}",
                                                                                        style: TextStyle(fontFamily: "outfit", fontSize: 14, color: Colors.black),
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                ),

                                                                          SizedBox(
                                                                            width:
                                                                                5,
                                                                          ),
                                                                          GestureDetector(
                                                                            onTap:
                                                                                () async {
                                                                              print("opne comment sheet inList =   blogs");
                                                                              BlocProvider.of<BlogcommentCubit>(context).BlogcommentAPI(context, getallBlogModel1?.object?[index1].uid ?? "");

                                                                              _settingModalBottomSheetBlog(context, index1, _width);
                                                                            },
                                                                            child:
                                                                                Container(
                                                                              color: Colors.transparent,
                                                                              child: Padding(
                                                                                padding: const EdgeInsets.all(5.0),
                                                                                child: Image.asset(
                                                                                  ImageConstant.meesage,
                                                                                  height: 15,
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          ),

                                                                          Text(
                                                                              "${getallBlogModel1?.object?[index1].commentCount == null ? 0 : getallBlogModel1?.object?[index1].commentCount}"),

                                                                          // BlocConsumer<
                                                                          //     BlogcommentCubit,
                                                                          //     BlogCommentState>(listener: (context, state) {
                                                                          //   if (state
                                                                          //       is BlogCommentLoadedState) {
                                                                          //     blogCommentModel =
                                                                          //         state.commentdata;
                                                                          //     print("blog comment length ==  ${blogCommentModel?.object?.length}");
                                                                          //   }
                                                                          // }, builder:
                                                                          //     (context,
                                                                          //         state) {
                                                                          //   return Text(
                                                                          //     "${blogCommentModel?.object?.length}",
                                                                          //     style: TextStyle(
                                                                          //         fontFamily: "outfit",
                                                                          //         fontSize: 14,
                                                                          //         color: Colors.black),
                                                                          //   );
                                                                          // })
                                                                          /* SizedBox(
                                                                            height:
                                                                                15,
                                                                            child:
                                                                                Padding(
                                                                              padding:
                                                                                  const EdgeInsets.only(top: 2),
                                                                              child:
                                                                                  Image.asset(ImageConstant.arrowright),
                                                                            ),
                                                                          ), */

                                                                          Spacer(),
                                                                          GestureDetector(
                                                                            onTap:
                                                                                () {
                                                                              print("Save Blogs");

                                                                              BlocProvider.of<GetGuestAllPostCubit>(context).SaveBlog(context, "${User_ID}", "${getallBlogModel1?.object?[index1].uid}");
                                                                              if (getallBlogModel1?.object?[index1].isSaved == false) {
                                                                                getallBlogModel1?.object?[index1].isSaved = true;
                                                                              } else {
                                                                                getallBlogModel1?.object?[index1].isSaved = false;
                                                                              }
                                                                            },
                                                                            child:
                                                                                SizedBox(
                                                                              height: 35,
                                                                              child: Padding(
                                                                                  padding: const EdgeInsets.only(top: 6),
                                                                                  child: Image.asset(
                                                                                    getallBlogModel1?.object?[index1].isSaved == false ? ImageConstant.savePin : ImageConstant.Savefill,
                                                                                    width: 12.5,
                                                                                  )),
                                                                            ),
                                                                          ),
                                                                          SizedBox(
                                                                            width:
                                                                                10,
                                                                          ),
                                                                        ],
                                                                      )
                                                                    ],
                                                                  ),
                                                                ),
                                                              );
                                                            },
                                                          ),
                                                        )
                                                      ],
                                                    );
                                        } else {
                                          return SizedBox(
                                            height: 10,
                                          );
                                        }
                                      },
                                    ),
                                  )
                                : SizedBox(),
                          ],
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
            })));
  }

  void _showPopupMenuSwitchAccount(
    Offset position,
    BuildContext context,
  ) async {
    List<String> name = ["Inpackaging", "Growder"];

    final RenderBox overlay =
        Overlay.of(context).context.findRenderObject() as RenderBox;
    double _width = MediaQuery.of(context).size.width;
    double _height = MediaQuery.of(context).size.height;
    await showMenu(
        context: context,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        position: RelativeRect.fromRect(
          position & const Size(40, 40),
          Offset.zero & overlay.size,
        ),
        items: List.generate(
            name.length,
            (index) => PopupMenuItem(
                onTap: () {
                  super.setState(() {
                    indexx = index;
                  });
                  // index == 0 ? CreateForum() : becomeAnExport();
                },
                child: Container(
                    decoration: BoxDecoration(
                        color: indexx == index
                            ? ColorConstant.primary_color
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(5)),
                    width: 180,
                    height: 50,
                    child: Padding(
                      padding: EdgeInsets.only(right: 10, left: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              CustomImageView(
                                imagePath: ImageConstant.tomcruse,
                                height: 30,
                                radius: BorderRadius.circular(25),
                                width: 30,
                                fit: BoxFit.fill,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 8, bottom: 8, left: 10),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Flexible(
                                      child: Container(
                                        child: Text(
                                          "${name[index]}",
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Flexible(
                                      child: Container(
                                        child: Text(
                                          "@${name[index]}",
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            fontSize: 12,
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
                          Image.asset(
                            indexx == index
                                ? ImageConstant.selectComapny
                                : ImageConstant.UnselectComapny,
                            height: 20,
                          )
                        ],
                      ),
                    )))));
  }

  void _showPopupMenu(
    Offset position,
    BuildContext context,
  ) async {
    List<String> ankur = ["Create Forum", "Become an Expert"];
    final RenderBox overlay =
        Overlay.of(context).context.findRenderObject() as RenderBox;
    double _width = MediaQuery.of(context).size.width;
    double _height = MediaQuery.of(context).size.height;
    final selectedOption = await showMenu(
        context: context,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        position: RelativeRect.fromRect(
          position & const Size(40, 40),
          Offset.zero & overlay.size,
        ),
        items: List.generate(
            ankur.length,
            (index) => PopupMenuItem(
                onTap: () {
                  super.setState(() {
                    indexx = index;
                  });
                  index == 0 ? CreateForum() : becomeAnExport();
                },
                child: Container(
                  decoration: BoxDecoration(
                      color: indexx == index
                          ? ColorConstant.primary_color
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(5)),
                  width: 130,
                  height: 40,
                  child: Center(
                    child: Text(
                      ankur[index],
                      style: TextStyle(
                          color: indexx == index ? Colors.white : Colors.black),
                    ),
                  ),
                ))));
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

  saveNotificationCount(int NotificationCount, int MessageCount) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt(PreferencesKey.NotificationCount, NotificationCount);
    prefs.setInt(PreferencesKey.MessageCount, MessageCount);
  }

  CreateForum() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var UserLogin_ID = prefs.getString(PreferencesKey.loginUserID);

    if (UserLogin_ID == null) {
      print("user login Mood");
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => RegisterCreateAccountScreen()));
    } else {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text("Create Forum"),
          content: Container(
            height: 87,
            //color: Colors.amber,
            child: Column(
              children: [
                Text("Please fill your Company info before creation forum."),
                SizedBox(
                  height: 10,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(ctx).pop();
                    print('no login');
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return CreateForamScreen();
                    }));
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        // color: Colors.green,
                        child: Text(
                          "Okay",
                          style: TextStyle(color: Colors.blue),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }
  }

  void delete_dilog_menu(
    Offset position,
    BuildContext context,
  ) async {
    List<String> ankur = [
      "Delete Post",
    ];
    final RenderBox overlay =
        Overlay.of(context).context.findRenderObject() as RenderBox;
    double _width = MediaQuery.of(context).size.width;
    double _height = MediaQuery.of(context).size.height;
    final selectedOption = await showMenu(
        context: context,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        position: RelativeRect.fromRect(
          position & const Size(40, 40),
          Offset.zero & overlay.size,
        ),
        items: List.generate(
            ankur.length,
            (index) => PopupMenuItem(
                enabled: true,
                onTap: () {
                  super.setState(() {
                    indexx = index;
                  });
                },
                child: GestureDetector(
                  onTap: () {
                    Deletedilog(
                        AllGuestPostRoomData?.object?.content?[index].postUid ??
                            "",
                        index);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        color: indexx == index
                            ? ColorConstant.primary_color
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(5)),
                    width: 130,
                    height: 40,
                    child: Center(
                      child: Text(
                        ankur[index],
                        style: TextStyle(
                            color:
                                indexx == index ? Colors.white : Colors.black),
                      ),
                    ),
                  ),
                ))));
  }

  Future<void> methodCalling() async {
    print("method caling");
    ImageDataPostOne? imageDataPost;

    if (Platform.isAndroid) {
      print("tHIS iS THE dATA gET");
      final info = await DeviceInfoPlugin().androidInfo;
      if (num.parse(await info.version.release).toInt() >= 13) {
        if (await permissionHandler(context, Permission.photos) ?? false) {
          imageDataPost = await Navigator.push(context,
              MaterialPageRoute(builder: (context) {
            return CreateStoryPage(
              finalFileSize: finalFileSize,
              finalvideoSize: finalvideoSize,
            );
          }));

          if (imageDataPost?.object?.split('.').last == 'mp4') {
            var parmes = {
              "storyData": imageDataPost?.object,
              "storyType": "VIDEO",
              "videoDuration": imageDataPost?.videodurationGet
            };
            print("scdfhgsdfhsd-${parmes}");
            Repository().cretateStoryApi(context, parmes);
            isWatch = true;
            Get_UserToken();
          } else {
            var parmes = {
              "storyData": imageDataPost?.object.toString(),
              "storyType": "TEXT",
              "videoDuration": ''
            };
            print("CHECK:--------${parmes}");
            Repository().cretateStoryApi(context, parmes);
            isWatch = true;
            Get_UserToken();
          }
        }
      } else if (await permissionHandler(context, Permission.storage) ??
          false) {
        print("tHIS iS THE dATA ELSE");

        imageDataPost =
            await Navigator.push(context, MaterialPageRoute(builder: (context) {
          return CreateStoryPage(
            finalFileSize: finalFileSize,
            finalvideoSize: finalvideoSize,
          );
        }));

        if (imageDataPost?.object?.split('.').last == 'mp4') {
          var parmes = {
            "storyData": imageDataPost?.object,
            "storyType": "VIDEO",
            "videoDuration": imageDataPost?.videodurationGet
          };
          print("scdfhgsdfhsd-${parmes}");
          Repository().cretateStoryApi(context, parmes);
          Get_UserToken();
        } else {
          var parmes = {
            "storyData": imageDataPost?.object.toString(),
            "storyType": "TEXT",
            "videoDuration": ''
          };
          print("CHECK:--------${parmes}");
          Repository().cretateStoryApi(context, parmes);
          Get_UserToken();
        }
      }
    } else if (await permissionHandler(context, Permission.photos) ?? false) {
      print("tHIS iS THE dATA ELSE");

      imageDataPost =
          await Navigator.push(context, MaterialPageRoute(builder: (context) {
        return CreateStoryPage(
          finalFileSize: finalFileSize,
          finalvideoSize: finalvideoSize,
        );
      }));

      if (imageDataPost?.object?.split('.').last == 'mp4') {
        var parmes = {
          "storyData": imageDataPost?.object,
          "storyType": "VIDEO",
          "videoDuration": imageDataPost?.videodurationGet
        };
        print("scdfhgsdfhsd-${parmes}");
        Repository().cretateStoryApi(context, parmes);
        Get_UserToken();
      } else {
        var parmes = {
          "storyData": imageDataPost?.object.toString(),
          "storyType": "TEXT",
          "videoDuration": ''
        };
        print("CHECK:--------${parmes}");
        Repository().cretateStoryApi(context, parmes);
        Get_UserToken();
      }
    }
    buttonDatas[0].images.add(StoryModel(
        imageDataPost?.object,
        DateTime.now().toIso8601String(),
        UserProfileImage,
        User_Name,
        "",
        "${User_ID}",
        0,
        imageDataPost?.videodurationGet ?? 15));
    if (imageDataPost?.object != null) {
      buttonDatas[0].storyPages.add(FullStoryPage(
            imageName: '${imageDataPost?.object}',
          ));
      if (mounted)
        super.setState(() {
          storyAdded = true;
        });
    }
  }

  Deletedilog(String PostUID, int index) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        // title: const Text("Create Expert"),
        content: Container(
          height: 90,
          child: Column(
            children: [
              Text("Are You Sure You Want To delete This Post."),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  GestureDetector(
                    onTap: () async {
                      await soicalFunation(apiName: 'Deletepost', index: index);
                      Navigator.pop(context);
                    },
                    child: Container(
                      height: 30,
                      width: 80,
                      decoration: BoxDecoration(
                          color: ColorConstant.primary_color,
                          borderRadius: BorderRadius.circular(5)),
                      // color: Colors.green,
                      child: Center(
                        child: Text(
                          "Yes",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      height: 30,
                      width: 80,
                      decoration: BoxDecoration(
                          border:
                              Border.all(color: ColorConstant.primary_color),
                          borderRadius: BorderRadius.circular(5)),
                      // color: Colors.green,
                      child: Center(
                        child: Text(
                          "No",
                          style: TextStyle(color: ColorConstant.primary_color),
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
  }

  Deletecommentdilog(String commentuuid, int index1) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        // title: const Text("Create Expert"),
        content: Container(
          height: 90,
          child: Column(
            children: [
              Text("Are You Sure You Want To delete This Comment."),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  GestureDetector(
                    onTap: () async {
                      print(
                          "index print${addCommentModeldata?.object?[index1].commentUid}");
                      print(
                          "index print1${addCommentModeldata?.object?[index1].comment}");

                      BlocProvider.of<AddcommentCubit>(context).Deletecomment(
                          "${addCommentModeldata?.object?[index1].commentUid}",
                          context);
                      addCommentModeldata?.object?.removeAt(index1);
                      Navigator.pop(context);
                    },
                    child: Container(
                      height: 30,
                      width: 80,
                      decoration: BoxDecoration(
                          color: ColorConstant.primary_color,
                          borderRadius: BorderRadius.circular(5)),
                      // color: Colors.green,
                      child: Center(
                        child: Text(
                          "Yes",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      height: 30,
                      width: 80,
                      decoration: BoxDecoration(
                          border:
                              Border.all(color: ColorConstant.primary_color),
                          borderRadius: BorderRadius.circular(5)),
                      // color: Colors.green,
                      child: Center(
                        child: Text(
                          "No",
                          style: TextStyle(color: ColorConstant.primary_color),
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
  }

  becomeAnExport() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var UserLogin_ID = prefs.getString(PreferencesKey.loginUserID);

    if (UserLogin_ID == null) {
      print("user login Mood");
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => RegisterCreateAccountScreen()));
    } else {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text("Create Expert"),
          content: Container(
            height: 87,
            child: Column(
              children: [
                Text(
                    "Please fill the necessary data before Registering as an Expert."),
                SizedBox(
                  height: 10,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(ctx).pop();
                    print('no login');
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return BecomeExpertScreen();
                    }));
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        // color: Colors.green,
                        child: Text(
                          "Okay",
                          style: TextStyle(color: Colors.blue),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }
  }

  void _settingModalBottomSheet1(context, index, _width) {
    /* void _goToElement() {
      scroll.animateTo((1000 * 20),
          duration: const Duration(milliseconds: 300), curve: Curves.easeOut);
    } */

    showModalBottomSheet(
        context: context,
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15.0), topRight: Radius.circular(15.0)),
        ),
        builder: (context) {
          return StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
            return CommentBottomSheet(
                isFoollinng:
                    AllGuestPostRoomData?.object?.content?[index].isFollowing,
                useruid:
                    AllGuestPostRoomData?.object?.content?[index].userUid ?? "",
                userProfile: AllGuestPostRoomData
                        ?.object?.content?[index].userProfilePic ??
                    "",
                UserName: AllGuestPostRoomData
                        ?.object?.content?[index].postUserName ??
                    "",
                desc:
                    AllGuestPostRoomData?.object?.content?[index].description ??
                        "",
                postUuID:
                    AllGuestPostRoomData?.object?.content?[index].postUid ??
                        "");
          }); /* Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              ListTile(
                leading: Icon(Icons.email),
                title: Text('Send email'),
                onTap: () {
                  print('Send email');
                },
              ),
              ListTile(
                leading: Icon(Icons.phone),
                title: Text('Call phone'),
                onTap: () {
                  print('Call phone');
                },
              ),
            ],
          ); */
        }
        /*   isScrollControlled: true,
        useSafeArea: true,
        isDismissible: true,
        showDragHandle: true,
        enableDrag: true,
        constraints: BoxConstraints.tight(Size.infinite),
        context: context,
        builder: (BuildContext bc) {
          print(
              "userUiduserUid == >>>>>>> ${AllGuestPostRoomData?.object?.content?[index].userUid}");
          return StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
            return CommentBottomSheet(
                isFoollinng:
                    AllGuestPostRoomData?.object?.content?[index].isFollowing,
                useruid:
                    AllGuestPostRoomData?.object?.content?[index].userUid ?? "",
                userProfile: AllGuestPostRoomData
                        ?.object?.content?[index].userProfilePic ??
                    "",
                UserName: AllGuestPostRoomData
                        ?.object?.content?[index].postUserName ??
                    "",
                desc:
                    AllGuestPostRoomData?.object?.content?[index].description ??
                        "",
                postUuID:
                    AllGuestPostRoomData?.object?.content?[index].postUid ??
                        "");
          });
        } */
        ).then((value) {});
    ;
  }

  void _settingModalBottomSheetBlog(context, index, _width) {
    showModalBottomSheet(
            isScrollControlled: true,
            useSafeArea: true,
            isDismissible: true,
            showDragHandle: true,
            enableDrag: true,
            constraints: BoxConstraints.tight(Size.infinite),
            context: context,
            builder: (BuildContext bc) {
              return BlogCommentBottomSheet(
                blogUid: getallBlogModel1?.object?[index].uid,
                isFoollinng:
                    AllGuestPostRoomData?.object?.content?[index].isFollowing,
              );
            })
        .then((value) => BlocProvider.of<GetGuestAllPostCubit>(context)
            .GetallBlog(context, User_ID ?? ""));
  }

  void onClickedEmoji() async {
    if (isEmojiVisible) {
      focusNode.requestFocus();
    } else if (isKeyboardVisible) {
      await SystemChannels.textInput.invokeMethod('TextInput.hide');
      await Future.delayed(Duration(milliseconds: 100));
    }
    toggleEmojiKeyboard();
  }

  Future toggleEmojiKeyboard() async {
    if (isKeyboardVisible) {
      FocusScope.of(context).unfocus();
    }

    // super.setState(() {
    isEmojiVisible = !isEmojiVisible;

    // });
  }

  void onEmojiSelected(String emoji) => super.setState(() {
        addcomment.text = addcomment.text + emoji;
      });

  Future<bool> onBackPress() {
    if (isEmojiVisible) {
      toggleEmojiKeyboard();
    } else {
      Navigator.pop(context);
    }

    return Future.value(false);
  }

  void rePostBottomSheet(context, index) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return Container(
            height: 200,
            child: new Wrap(
              children: [
                Container(
                  height: 20,
                  width: 50,
                  color: Colors.transparent,
                ),
                Center(
                    child: Container(
                  height: 5,
                  width: 150,
                  decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(25)),
                )),
                SizedBox(
                  height: 35,
                ),
                Center(
                  child: new ListTile(
                      leading: new Image.asset(
                        ImageConstant.vector2,
                        height: 20,
                      ),
                      title: new Text('RePost'),
                      subtitle: Text(
                        "Share this post with your followers",
                        style: TextStyle(fontSize: 10, color: Colors.grey),
                      ),
                      onTap: () async {
                        Map<String, dynamic> param = {"postType": "PUBLIC"};
                        BlocProvider.of<GetGuestAllPostCubit>(context)
                            .RePostAPI(
                                context,
                                param,
                                AllGuestPostRoomData
                                    ?.object?.content?[index].postUid,
                                "Repost");
                        Navigator.pop(context);
                      }),
                ),
                SizedBox(
                  height: 20,
                ),
                Center(
                  child: new ListTile(
                    leading: new Icon(
                      Icons.edit_outlined,
                      color: Colors.black,
                    ),
                    title: new Text('Quote'),
                    subtitle: Text(
                      "Add a comment, photo or GIF before you share this post",
                      style: TextStyle(fontSize: 10, color: Colors.grey),
                    ),
                    onTap: () async {
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) {
                          return RePostScreen(
                            userProfile: AllGuestPostRoomData
                                ?.object?.content?[index].userProfilePic,
                            username: AllGuestPostRoomData
                                ?.object?.content?[index].postUserName,
                            date: AllGuestPostRoomData
                                ?.object?.content?[index].createdAt,
                            desc: AllGuestPostRoomData
                                ?.object?.content?[index].description,
                            postData: AllGuestPostRoomData
                                ?.object?.content?[index].postData,
                            postDataType: AllGuestPostRoomData
                                ?.object?.content?[index].postDataType,
                            index: index,
                            AllGuestPostRoomData: AllGuestPostRoomData,
                            postUid: AllGuestPostRoomData
                                ?.object?.content?[index].postUid,
                            thumbNailURL: AllGuestPostRoomData
                                ?.object?.content?[index].thumbnailImageUrl,
                          );
                        },
                      ));
                      // Navigator.pop(context);
                    },
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
          );
        });
  }

  void post_shere(BuildContext context,
      {String? androidLink, String? iosLink}) async {
    RenderBox? box = context.findAncestorRenderObjectOfType();
    final scaffoldMessenger = ScaffoldMessenger.of(context);
    final data = await rootBundle.load(
      ImageConstant.tomcruse,
    );
    final buffer = data.buffer;
    final shareResult = await Share.shareXFiles(
      [
        XFile.fromData(
          buffer.asUint8List(data.offsetInBytes, data.lengthInBytes),
          name: 'HomeLogo.png',
          mimeType: 'image/png',
        ),
      ],
      subject: "Share",
      text: "Try This Awesome App \n\n Android :- ${androidLink}",
      //  \n \n iOS :- ${iosLink}",
      sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size,
    );
  }

  void _onShareXFileFromAssets(BuildContext context,
      {String? androidLink}) async {
    // RenderBox? box = context.findAncestorRenderObjectOfType();

    var directory = await getApplicationDocumentsDirectory();

    if (Platform.isAndroid) {
      Share.shareXFiles(
        [XFile("/sdcard/download/IPImage.jpg")],
        subject: "Share",
        text: "Try This Awesome App \n\n Android :- ${androidLink}",
        // sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size,
      );
    } else {
      Share.shareXFiles(
        [
          XFile(directory.path +
              Platform.pathSeparator +
              'Growder_Image/IPImage.jpg')
        ],
        subject: "Share",
        text: "Try This Awesome App \n\n Android :- ${androidLink}",
        // sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size,
      );
    }
  }

  shareImageDownload() async {
    print(
        ":- %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%");
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var url = prefs.getString(PreferencesKey.AwsImageInPackagingLogoUrl) ??
        "https://pds-images-live.s3.ap-south-1.amazonaws.com/misc/Inpackaging+Without+Reward.jpg";

    if (url.isNotEmpty) {
      _permissionReady = await _checkPermission();
      await _prepareSaveDir();

      if (_permissionReady) {
        print("Downloading");
        print("${url}");
        try {
          await Dio().download(
            url.toString(),
            _localPath + "/" + "IPImage.jpg",
          );

          print("Download Completed.");
        } catch (e) {
          print("Download Failed.\n\n" + e.toString());
        }
      }
    } else {
      print('No Invoice Available');
    }
  }

  Future<bool> _checkPermission() async {
    if (Platform.isAndroid) {
      DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      print(
          "objectobjectobjectobjectobjectobjectobjectobject ${androidInfo.version.release}");
      version = int.parse(androidInfo.version.release);
      // final SharedPreferences prefs = await SharedPreferences.getInstance();
      // version =
      //     await int.parse(prefs.getString(UserdefaultsData.version).toString());
      print('dddwssadasdasdasdasdasd ${version}');
    }
    if (Platform.isAndroid) {
      final status = (version ?? 0) < 13
          ? await Permission.storage.status
          : PermissionStatus.granted;
      if (status != PermissionStatus.granted) {
        print('gegegegegegegegegegegegegege');
        print('gegegegegegegegegegegegegege $status');
        final result = (version ?? 0) < 13
            ? await Permission.storage.request()
            : PermissionStatus.granted;
        if (result == PermissionStatus.granted) {
          return true;
        }
      } else {
        return true;
      }
    } else {
      return true;
    }
    return false;
  }

  Future<void> _prepareSaveDir() async {
    _localPath = (await _findLocalPath())!;

    print(_localPath);
    final savedDir = Directory(_localPath);
    bool hasExisted = await savedDir.exists();
    if (!hasExisted) {
      savedDir.create();
      print('first vvvvvvvvvvvvvvvvvvv');
    }
  }

  Future<String?> _findLocalPath() async {
    if (Platform.isAndroid) {
      return "/sdcard/download/";
    } else {
      var directory = await getApplicationDocumentsDirectory();
      return directory.path + Platform.pathSeparator + 'IP_Image';
    }
  }
}

class VideoListItem extends StatefulWidget {
  final String videoUrl;
  String? discrption;
  VideoListItem({required this.videoUrl, this.discrption});

  @override
  State<VideoListItem> createState() => _VideoListItemState();
}

class _VideoListItemState extends State<VideoListItem> {
  FlickManager? flickManager;

  @override
  void initState() {
    super.initState();

    flickManager = FlickManager(
      autoPlay: true,
      videoPlayerController: VideoPlayerController.networkUrl(
        Uri.parse(widget.videoUrl),
      ),
    );
  }

  @override
  void dispose() {
    flickManager!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: ObjectKey(flickManager),
      onVisibilityChanged: (visiblityInfo) {
        if (visiblityInfo.visibleFraction > 0.50) {
          flickManager?.flickControlManager?.play();
        } else {
          flickManager?.flickControlManager?.pause();
        }
      },
      child: Card(
        margin: EdgeInsets.only(
          left: 20,
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              if (widget.videoUrl.isNotEmpty)
                FlickVideoPlayer(
                  preferredDeviceOrientationFullscreen: [
                    DeviceOrientation.portraitUp,
                    DeviceOrientation.landscapeLeft,
                    DeviceOrientation.landscapeRight,
                  ],
                  flickManager: flickManager!,
                  flickVideoWithControls: FlickVideoWithControls(
                    controls: FlickPortraitControls(),
                  ),
                ),
              // Add other information or controls as needed
            ],
          ),
        ),
      ),
    );
  }
}
