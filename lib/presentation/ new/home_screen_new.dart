import 'dart:io';
import 'package:dotted_border/dotted_border.dart';
import 'package:linkfy_text/linkfy_text.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pds/API/Bloc/System_Config_Bloc/system_config_cubit.dart';
import 'package:pds/API/Model/System_Config_model/system_config_model.dart';
import 'package:pds/presentation/%20new/RePost_Screen.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hashtagable/hashtagable.dart';
import 'package:intl/intl.dart';
import 'package:pds/API/Bloc/GuestAllPost_Bloc/GuestAllPost_cubit.dart';
import 'package:pds/API/Bloc/GuestAllPost_Bloc/GuestAllPost_state.dart';
import 'package:pds/API/Bloc/add_comment_bloc/add_comment_cubit.dart';
import 'package:pds/API/Bloc/sherinvite_Block/sherinvite_cubit.dart';
import 'package:pds/API/Model/Add_comment_model/add_comment_model.dart';
import 'package:pds/API/Model/CreateStory_Model/all_stories.dart';
import 'package:pds/API/Model/FetchAllExpertsModel/FetchAllExperts_Model.dart';
import 'package:pds/API/Model/GetGuestAllPostModel/GetGuestAllPost_Model.dart';
import 'package:pds/API/Model/deletecomment/delete_comment_model.dart';
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
import 'package:pds/presentation/%20new/HashTagView_screen.dart';
import 'package:pds/presentation/%20new/OpenSavePostImage.dart';
import 'package:pds/presentation/%20new/ShowAllPostLike.dart';
import 'package:pds/presentation/%20new/comment_bottom_sheet.dart';
import 'package:pds/presentation/%20new/profileNew.dart';
import 'package:pds/presentation/Create_Post_Screen/Ceratepost_Screen.dart';
import 'package:pds/presentation/create_foram/create_foram_screen.dart';
import 'package:pds/presentation/create_story/create_story.dart';
import 'package:pds/presentation/create_story/full_story_page.dart';
import 'package:pds/presentation/experts/experts_screen.dart';
import 'package:pds/presentation/register_create_account_screen/register_create_account_screen.dart';
import 'package:pds/presentation/splash_screen/splash_screen.dart';
import 'package:pds/widgets/commentPdf.dart';
import 'package:pds/widgets/pagenation.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:pds/presentation/recent_blog/recent_blog_screen.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../API/Model/Get_all_blog_Model/get_all_blog_model.dart';
import '../become_an_expert_screen/become_an_expert_screen.dart';
import 'package:share_plus/share_plus.dart';

class HomeScreenNew extends StatefulWidget {
  const HomeScreenNew({Key? key}) : super(key: key);

  @override
  State<HomeScreenNew> createState() => _HomeScreenNewState();
}

class _HomeScreenNewState extends State<HomeScreenNew> {
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
  Uint8List? firstPageImage;
  double documentuploadsize = 0;
  double finalFileSize = 0;
  LikePost? likePost;
  GetGuestAllPostModel? AllGuestPostRoomData;
  DeleteCommentModel? DeletecommentDataa;
  saveBlogModel? saveBlogModeData;
  saveBlogModel? LikeBlogModeData;
  ScrollController scrollController = ScrollController();
  String formattedDate = DateFormat('dd-MM-yyyy').format(DateTime.now());
  bool showDraggableSheet = false;
  bool storyAdded = false;
  BuildContext? storycontext;
  List<Widget> storyPagedata = [];
  GetAllStoryModel? getAllStoryModel;
  FetchAllExpertsModel? AllExperData;
  SystemConfigModel? systemConfigModel;
  bool apiCalingdone = false;
  int sliderCurrentPosition = 0;
  List<PageController> _pageControllers = [];
  List<int> _currentPages = [];
  String? myUserId;
  String? UserProfileImage;
  GetallBlogModel? getallBlogModel1;
  bool isDataget = false;
  DateTime? parsedDateTimeBlogs;
  FocusNode _focusNode = FocusNode();
  String? appApkMinVersion;
  String? appApkLatestVersion;
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
  getDocumentSize() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    documentuploadsize = await double.parse(
        prefs.getString(PreferencesKey.MaxPostUploadSizeInMB) ?? "0");

    finalFileSize = documentuploadsize;
    setState(() {});
  }

  bool _isLink(String input) {
    RegExp linkRegex = RegExp(
        r'^https?:\/\/(?:www\.)?[a-zA-Z0-9-]+(?:\.[a-zA-Z]+)+(?:[^\s]*)$');
    return linkRegex.hasMatch(input);
  }

  thubMethod() async {
    Directory tempDir = await getTemporaryDirectory();
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
    Get_UserToken();

    storycontext = context;
    VersionControll();
    getDocumentSize();
    super.initState();
  }

  AddCommentModel? addCommentModeldata;
  final TextEditingController addcomment = TextEditingController();
  final ScrollController scroll = ScrollController();
  List<StoryButtonData> buttonDatas = [];
  List<StoryButton?> storyButtons = List.filled(1, null, growable: true);
  List<String> userName = [];
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
      items: <PopupMenuItem<String>>[
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
                color: Color(0xffED1C25),
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
                        final Uri url = Uri.parse(
                            "https://play.google.com/store/apps/details?id=com.pds.app");

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
                            final Uri url = Uri.parse(
                                "https://play.google.com/store/apps/details?id=com.pds.app");

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
            height: 75,
            child: Column(
              children: [
                Text('Are you sure you want to delete this Post?'),
                SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
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
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var Token = prefs.getString(PreferencesKey.loginJwt);
    var FCMToken = prefs.getString(PreferencesKey.fcmToken);
    User_ID = prefs.getString(PreferencesKey.loginUserID);
    User_Name = prefs.getString(PreferencesKey.ProfileName);
    User_Module = prefs.getString(PreferencesKey.module);
    uuid = prefs.getString(PreferencesKey.loginUserID);
    UserProfileImage = prefs.getString(PreferencesKey.UserProfile);
    print("---------------------->> : ${FCMToken}");
    print("User Token :--- " + "${Token}");
    User_ID == null ? api() : NewApi();
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
    await BlocProvider.of<GetGuestAllPostCubit>(context)
        .seetinonExpried(context);
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
  }

  soicalFunation({String? apiName, int? index}) async {
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
          AllGuestPostRoomData?.object?.content?[index ?? 0].userUid, context);
      if (AllGuestPostRoomData?.object?.content?[index ?? 0].isFollowing ==
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
      await BlocProvider.of<GetGuestAllPostCubit>(context).like_post(
          AllGuestPostRoomData?.object?.content?[index ?? 0].postUid, context);
      print(
          "isLiked-->${AllGuestPostRoomData?.object?.content?[index ?? 0].isLiked}");
      if (AllGuestPostRoomData?.object?.content?[index ?? 0].isLiked == true) {
        AllGuestPostRoomData?.object?.content?[index ?? 0].isLiked = false;
        int a =
            AllGuestPostRoomData?.object?.content?[index ?? 0].likedCount ?? 0;
        int b = 1;
        AllGuestPostRoomData?.object?.content?[index ?? 0].likedCount = a - b;
      } else {
        AllGuestPostRoomData?.object?.content?[index ?? 0].isLiked = true;
        AllGuestPostRoomData?.object?.content?[index ?? 0].likedCount;
        int a =
            AllGuestPostRoomData?.object?.content?[index ?? 0].likedCount ?? 0;
        int b = 1;
        AllGuestPostRoomData?.object?.content?[index ?? 0].likedCount = a + b;
      }
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

  @override
  Widget build(BuildContext context) {
    var _height = MediaQuery.of(context).size.height;
    var _width = MediaQuery.of(context).size.width;

    return WillPopScope(
      onWillPop: () async {
        return true;
      },
      child: Scaffold(
          floatingActionButton: FloatingActionButton(
            backgroundColor: Color(0xffED1C25),
            onPressed: () {
              if (uuid != null) {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return CreateNewPost();
                })).then((value) => Get_UserToken());
              } else {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => RegisterCreateAccountScreen()));
              }
            },
            child: Image.asset(
              ImageConstant.huge,
              height: 30,
            ),
            elevation: 0,
          ),
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
              SnackBar snackBar = SnackBar(
                content: Text(state.LikeBlogModeData.object.toString()),
                backgroundColor: ColorConstant.primary_color,
              );
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
              LikeBlogModeData = state.LikeBlogModeData;
            }
            if (state is RePostLoadedState) {
              SnackBar snackBar = SnackBar(
                content: Text(state.RePost.object.toString()),
                backgroundColor: ColorConstant.primary_color,
              );
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
              Navigator.pop(context);
            }

            if (state is GetAllStoryLoadedState) {
              getAllStoryModel = state.getAllStoryModel;
              buttonDatas.clear();
              storyButtons.clear();
              userName.clear();
              storyButtons = List.filled(1, null, growable: true);
              if (state.getAllStoryModel.object != null ||
                  ((state.getAllStoryModel.object?.isNotEmpty == true) ??
                      false)) {
                state.getAllStoryModel.object?.forEach((element) {
                  if (element.userUid == User_ID) {
                    userName.insert(0, element.userName.toString());
                    buttonDatas.insert(
                        0,
                        StoryButtonData(
                          timelineBackgroundColor: Colors.grey,
                          buttonDecoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: element.profilePic != null
                                ? DecorationImage(
                                    image: NetworkImage(element.profilePic))
                                : DecorationImage(
                                    image: AssetImage(
                                      ImageConstant.placeholder2,
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
                                  element.storyData![index].userUid)),
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
                          Navigator.of(storycontext!).push(
                            StoryRoute(
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
                          );
                        },
                        buttonData: buttonDatas[0],
                        allButtonDatas: buttonDatas,
                        storyListViewController: ScrollController()));

                    storyAdded = true;
                  } else {
                    if (!storyAdded) userName.add("Share Story");
                    userName.add(element.userName.toString());
                    StoryButtonData buttonData1 = StoryButtonData(
                      timelineBackgroundColor: Colors.grey,
                      buttonDecoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: element.profilePic != null ||
                                element.profilePic != ''
                            ? DecorationImage(
                                image:
                                    NetworkImage(element.profilePic.toString()))
                            : DecorationImage(
                                image: AssetImage(
                                  ImageConstant.pdslogo,
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
                              element.storyData![index].userUid)),
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
                      storyPages: List.generate(element.storyData?.length ?? 0,
                          (index) {
                        return FullStoryPage(
                          imageName: '${element.storyData?[index].storyData}',
                        );
                      }),
                      segmentDuration: const Duration(seconds: 3),
                    );
                    buttonDatas.add(buttonData1);
                    storyButtons.add(StoryButton(
                        onPressed: (data) {
                          Navigator.of(storycontext!).push(
                            StoryRoute(
                              storyContainerSettings: StoryContainerSettings(
                                buttonData: buttonData1,
                                tapPosition: buttonData1.buttonCenterPosition!,
                                curve: buttonData1.pageAnimationCurve,
                                allButtonDatas: buttonDatas,
                                pageTransform: StoryPage3DTransform(),
                                storyListScrollController: ScrollController(),
                              ),
                              duration: buttonData1.pageAnimationDuration,
                            ),
                          );
                        },
                        buttonData: buttonData1,
                        allButtonDatas: buttonDatas,
                        storyListViewController: ScrollController()));
                  }
                });
              }
            }
            if (state is GetGuestAllPostLoadedState) {
              apiCalingdone = true;
              AllGuestPostRoomData = state.GetGuestAllPostRoomData;
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

              likePost = state.likePost;
            }
          }, builder: (context, state) {
            return apiCalingdone == true
                ? RefreshIndicator(
                    onRefresh: refreshdata,
                    color: Colors.white,
                    backgroundColor: ColorConstant.primary_color,
                    child: SingleChildScrollView(
                      controller: scrollController,
                      child: Column(
                        children: [
                          SizedBox(
                            height: 55,
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 16, right: 16),
                            child: Row(
                              children: [
                                SizedBox(
                                    height: 40,
                                    child:
                                        Image.asset(ImageConstant.splashImage)),
                                Spacer(),
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
                                              color: Color(0xffED1C25)),
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
                                    onTap: () {
                                      if (uuid == null) {
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    RegisterCreateAccountScreen()));
                                      } else {
                                        Navigator.push(context,
                                            MaterialPageRoute(
                                                builder: (context) {
                                          return ProfileScreen(
                                            User_ID: "${User_ID}",
                                            isFollowing: 'FOLLOW',
                                          );
                                        }));
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
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Container(
                            height: 90,
                            margin: EdgeInsets.symmetric(horizontal: 16),
                            child: ListView.separated(
                              itemBuilder: (context, index) {
                                if (index == 0) {
                                  if (!storyAdded)
                                    return GestureDetector(
                                      onTap: () async {
                                        ImageDataPostOne? imageDataPost;
                                        if (uuid != null) {
                                          if (Platform.isAndroid) {
                                            final info =
                                                await DeviceInfoPlugin()
                                                    .androidInfo;
                                            if (num.parse(await info
                                                        .version.release)
                                                    .toInt() >=
                                                13) {
                                              if (await permissionHandler(
                                                      context,
                                                      Permission.photos) ??
                                                  false) {
                                                imageDataPost =
                                                    await Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) {
                                                  return CreateStoryPage(
                                                    finalFileSize:
                                                        finalFileSize,
                                                  );
                                                }));
                                                print(
                                                    "dfhsdfhsdfsdhf--${imageDataPost?.object}");
                                                var parmes = {
                                                  "storyData": imageDataPost
                                                      ?.object
                                                      .toString()
                                                };
                                                await Repository()
                                                    .cretateStoryApi(
                                                        context, parmes);
                                              }
                                            } else if (await permissionHandler(
                                                    context,
                                                    Permission.storage) ??
                                                false) {
                                              imageDataPost =
                                                  await Navigator.push(context,
                                                      MaterialPageRoute(
                                                          builder: (context) {
                                                return CreateStoryPage(
                                                  finalFileSize: finalFileSize,
                                                );
                                              }));
                                              var parmes = {
                                                "storyData": imageDataPost
                                                    ?.object
                                                    .toString()
                                              };
                                              await Repository()
                                                  .cretateStoryApi(
                                                      context, parmes);
                                            }
                                          }
                                        } else {
                                          Navigator.of(context).push(
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      RegisterCreateAccountScreen()));
                                        }

                                        if (imageDataPost?.object != null) {
                                          StoryButtonData buttonData =
                                              StoryButtonData(
                                            timelineBackgroundColor:
                                                Colors.grey,
                                            buttonDecoration:
                                                UserProfileImage != null &&
                                                        UserProfileImage != ""
                                                    ? BoxDecoration(
                                                        shape: BoxShape.circle,
                                                        image: DecorationImage(
                                                          image: NetworkImage(
                                                              "${UserProfileImage}"),
                                                          fit: BoxFit.cover,
                                                        ),
                                                      )
                                                    : BoxDecoration(
                                                        shape: BoxShape.circle,
                                                        image: DecorationImage(
                                                          image: AssetImage(
                                                            ImageConstant
                                                                .tomcruse,
                                                          ),
                                                          fit: BoxFit.cover,
                                                        ),
                                                      ),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(5.0),
                                              child: Column(
                                                mainAxisSize: MainAxisSize.max,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                children: [
                                                  Text(
                                                    '',
                                                    style: const TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold,
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
                                                  "${User_ID}")
                                            ],
                                            borderDecoration: BoxDecoration(
                                              borderRadius:
                                                  const BorderRadius.all(
                                                Radius.circular(60.0),
                                              ),
                                              border: Border.fromBorderSide(
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
                                                const Duration(seconds: 3),
                                          );

                                          buttonDatas.insert(0, buttonData);
                                          storyButtons[0] = StoryButton(
                                              onPressed: (data) {
                                                Navigator.of(storycontext!)
                                                    .push(
                                                  StoryRoute(
                                                    storyContainerSettings:
                                                        StoryContainerSettings(
                                                      buttonData: buttonData,
                                                      tapPosition: buttonData
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
                                                );
                                              },
                                              buttonData: buttonData,
                                              allButtonDatas: buttonDatas,
                                              storyListViewController:
                                                  ScrollController());

                                          userName.add(User_Name!);
                                          if (mounted)
                                            setState(() {
                                              storyAdded = true;
                                            });
                                        }
                                      },
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          DottedBorder(
                                            borderType: BorderType.Circle,
                                            dashPattern: [5, 5, 5, 5],
                                            color: ColorConstant.primary_color,
                                            child: Container(
                                              height: 67,
                                              width: 67,
                                              decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: Color(0x4CED1C25)),
                                              child: Icon(
                                                Icons
                                                    .add_circle_outline_rounded,
                                                color:
                                                    ColorConstant.primary_color,
                                              ),
                                            ),
                                          ),
                                          Text(
                                            'Share Story',
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 16),
                                          )
                                        ],
                                      ),
                                    );
                                  else if (storyButtons[index] != null) {
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
                                                  child: GestureDetector(
                                                    onTap: methodCalling,
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                          color: Colors.white,
                                                          shape:
                                                              BoxShape.circle),
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
                                            '${userName[index]}',
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
                          AllGuestPostRoomData?.object?.content?.length != 0 ||
                                  AllGuestPostRoomData
                                          ?.object?.content?.isNotEmpty ==
                                      true
                              ? PaginationWidget(
                                  scrollController: scrollController,
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
                                        WidgetsBinding.instance
                                            .addPostFrameCallback(
                                                (timeStamp) => setState(() {
                                                      added = true;
                                                    }));
                                      }
                                      DateTime parsedDateTime = DateTime.parse(
                                          '${AllGuestPostRoomData?.object?.content?[index].createdAt ?? ""}');
                                      DateTime? repostTime;
                                      if (AllGuestPostRoomData!.object!
                                              .content![index].repostOn !=
                                          null) {
                                        repostTime = DateTime.parse(
                                            '${AllGuestPostRoomData?.object?.content?[index].repostOn!.createdAt ?? ""}');
                                        print("repost time = $parsedDateTime");
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
                                      // this is the data
                                      if (AllGuestPostRoomData?.object
                                              ?.content?[index].postDataType ==
                                          "ATTACHMENT") {}
                                      GlobalKey buttonKey = GlobalKey(); //
                                      return AllGuestPostRoomData?.object
                                                  ?.content?[index].repostOn !=
                                              null
                                          ? Padding(
                                              padding: EdgeInsets.only(
                                                  left: 16, right: 16),
                                              child: GestureDetector(
                                                onDoubleTap: () async {
                                                  await soicalFunation(
                                                      apiName: 'like_post',
                                                      index: index);
                                                },
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      border: Border.all(
                                                          color: Color.fromRGBO(
                                                              0, 0, 0, 0.25)),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              15)),
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
                                                            onTap: () {
                                                              if (uuid ==
                                                                  null) {
                                                                Navigator.of(
                                                                        context)
                                                                    .push(MaterialPageRoute(
                                                                        builder:
                                                                            (context) =>
                                                                                RegisterCreateAccountScreen()));
                                                              } else {
                                                                Navigator.push(
                                                                    context,
                                                                    MaterialPageRoute(
                                                                        builder:
                                                                            (context) {
                                                                  return ProfileScreen(
                                                                      User_ID:
                                                                          "${AllGuestPostRoomData?.object?.content?[index].userUid}",
                                                                      isFollowing: AllGuestPostRoomData
                                                                          ?.object
                                                                          ?.content?[
                                                                              index]
                                                                          .isFollowing);
                                                                }));
                                                              }
                                                            },
                                                            child: AllGuestPostRoomData
                                                                            ?.object
                                                                            ?.content?[
                                                                                index]
                                                                            .userProfilePic !=
                                                                        null &&
                                                                    AllGuestPostRoomData
                                                                            ?.object
                                                                            ?.content?[index]
                                                                            .userProfilePic !=
                                                                        ""
                                                                ? CircleAvatar(
                                                                    backgroundImage:
                                                                        NetworkImage(
                                                                            "${AllGuestPostRoomData?.object?.content?[index].userProfilePic}"),
                                                                    backgroundColor:
                                                                        Colors
                                                                            .white,
                                                                    radius: 25,
                                                                  )
                                                                : CustomImageView(
                                                                    imagePath:
                                                                        ImageConstant
                                                                            .tomcruse,
                                                                    height: 50,
                                                                    width: 50,
                                                                    fit: BoxFit
                                                                        .fill,
                                                                    radius: BorderRadius
                                                                        .circular(
                                                                            25),
                                                                  ),
                                                          ),
                                                          title: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Container(
                                                                child: Text(
                                                                  "${AllGuestPostRoomData?.object?.content?[index].postUserName}",
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
                                                              Text(
                                                                getTimeDifference(
                                                                    parsedDateTime),
                                                                style:
                                                                    TextStyle(
                                                                  fontSize: 12,
                                                                  fontFamily:
                                                                      "outfit",
                                                                ),
                                                              ),
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
                                                                  onTap: () {
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
                                                                  child: Icon(
                                                                    Icons
                                                                        .more_vert_rounded,
                                                                  ))
                                                              : GestureDetector(
                                                                  onTap:
                                                                      () async {
                                                                    await soicalFunation(
                                                                      apiName:
                                                                          'Follow',
                                                                      index:
                                                                          index,
                                                                    );
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
                                                                        color: Color(
                                                                            0xffED1C25),
                                                                        borderRadius:
                                                                            BorderRadius.circular(4)),
                                                                    child: AllGuestPostRoomData?.object?.content?[index].isFollowing ==
                                                                            'FOLLOW'
                                                                        ? Text(
                                                                            'Follow',
                                                                            style: TextStyle(
                                                                                fontFamily: "outfit",
                                                                                fontSize: 12,
                                                                                fontWeight: FontWeight.bold,
                                                                                color: Colors.white),
                                                                          )
                                                                        : AllGuestPostRoomData?.object?.content?[index].isFollowing ==
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
                                                          ? Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      left: 16),
                                                              child:
                                                                  GestureDetector(
                                                                      onTap:
                                                                          () async {
                                                                        if (DataGet ==
                                                                            true) {
                                                                          await launch(
                                                                              '${AllGuestPostRoomData?.object?.content?[index].description}',
                                                                              forceWebView: true,
                                                                              enableJavaScript: true);
                                                                        }
                                                                      },
                                                                      child:
                                                                          LinkifyText(
                                                                        "${AllGuestPostRoomData?.object?.content?[index].description}",
                                                                        linkStyle:
                                                                            TextStyle(color: Colors.blue),
                                                                        textStyle:
                                                                            TextStyle(color: Colors.black),
                                                                        linkTypes: [
                                                                          LinkType
                                                                              .url,
                                                                          // LinkType
                                                                          //     .userTag,
                                                                          LinkType
                                                                              .hashTag,
                                                                          // LinkType
                                                                          //     .email
                                                                        ],
                                                                        onTap:
                                                                            (link) {
                                                                          /// do stuff with `link` like
                                                                          /// if(link.type == Link.url) launchUrl(link.value);
                                                                          var SelectedTest = link
                                                                              .value
                                                                              .toString();
                                                                          var Link =
                                                                              SelectedTest.startsWith('https');
                                                                          var Link1 =
                                                                              SelectedTest.startsWith('http');
                                                                          var Link2 =
                                                                              SelectedTest.startsWith('www');

                                                                          print(
                                                                              SelectedTest.toString());
                                                                          print(
                                                                              Link);
                                                                          if (User_ID ==
                                                                              null) {
                                                                            Navigator.of(context).push(MaterialPageRoute(builder: (context) => RegisterCreateAccountScreen()));
                                                                          } else {
                                                                            if (Link == true &&
                                                                                Link1 == true &&
                                                                                Link2 == true) {
                                                                              launch(link.value.toString(), forceWebView: true, enableJavaScript: true);
                                                                            } else {
                                                                              print("${link}");
                                                                              Navigator.push(
                                                                                  context,
                                                                                  MaterialPageRoute(
                                                                                    builder: (context) => HashTagViewScreen(title: "${link.value}"),
                                                                                  ));
                                                                            }
                                                                          }
                                                                        },
                                                                      )),
                                                            )
                                                          : SizedBox(),

                                                      (AllGuestPostRoomData
                                                                  ?.object
                                                                  ?.content?[
                                                                      index]
                                                                  .postData
                                                                  ?.isEmpty ??
                                                              false)
                                                          ? SizedBox()
                                                          : Container(
                                                              height: 200,
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
                                                                                if (uuid == null) {
                                                                                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => RegisterCreateAccountScreen()));
                                                                                } else {
                                                                                  Navigator.push(
                                                                                    context,
                                                                                    MaterialPageRoute(
                                                                                        builder: (context) => OpenSavePostImage(
                                                                                              PostID: AllGuestPostRoomData?.object?.content?[index].postUid,
                                                                                              index: index,
                                                                                            )),
                                                                                  );
                                                                                }
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

                                                                          //this is the ATTACHMENT
                                                                          : AllGuestPostRoomData?.object?.content?[index].postDataType == "ATTACHMENT"
                                                                              ? (AllGuestPostRoomData?.object?.content?[index].postData?.isNotEmpty == true)
                                                                                  ? Container(
                                                                                      height: 200,
                                                                                      width: _width,
                                                                                      child: DocumentViewScreen1(
                                                                                        path: AllGuestPostRoomData?.object?.content?[index].postData?[0].toString(),
                                                                                      ))
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
                                                                                        setState(() {
                                                                                          _currentPages[index] = page;
                                                                                          imageCount1 = page + 1;
                                                                                        });
                                                                                      },
                                                                                      controller: _pageControllers[index],
                                                                                      itemCount: AllGuestPostRoomData?.object?.content?[index].postData?.length,
                                                                                      itemBuilder: (BuildContext context, int index1) {
                                                                                        if (AllGuestPostRoomData?.object?.content?[index].postDataType == "IMAGE") {
                                                                                          return Container(
                                                                                            width: _width,
                                                                                            margin: EdgeInsets.only(left: 16, top: 15, right: 16),
                                                                                            child: Center(
                                                                                                child: GestureDetector(
                                                                                              onTap: () {
                                                                                                if (uuid == null) {
                                                                                                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => RegisterCreateAccountScreen()));
                                                                                                } else {
                                                                                                  Navigator.push(
                                                                                                    context,
                                                                                                    MaterialPageRoute(
                                                                                                        builder: (context) => OpenSavePostImage(
                                                                                                              PostID: AllGuestPostRoomData?.object?.content?[index].postUid,
                                                                                                              index: index1,
                                                                                                            )),
                                                                                                  );
                                                                                                }
                                                                                              },
                                                                                              child: Stack(
                                                                                                children: [
                                                                                                  Align(
                                                                                                    alignment: Alignment.topCenter,
                                                                                                    child: CustomImageView(
                                                                                                      url: "${AllGuestPostRoomData?.object?.content?[index].postData?[index1]}",
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
                                                                                                            imageCount1.toString() + '/' + '${AllGuestPostRoomData?.object?.content?[index].postData?.length}',
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
                                                                                              activeColor: Color(0xffED1C25),
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
                                                      // inner post portion

                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                left: 10,
                                                                right: 10,
                                                                bottom: 10,
                                                                top: 20),
                                                        child: Container(
                                                          decoration: BoxDecoration(
                                                              color:
                                                                  Colors.white,
                                                              border: Border.all(
                                                                  color: Color
                                                                      .fromRGBO(
                                                                          0,
                                                                          0,
                                                                          0,
                                                                          0.25)),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          15)),
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
                                                                    onTap: () {
                                                                      if (uuid ==
                                                                          null) {
                                                                        Navigator.of(context).push(MaterialPageRoute(
                                                                            builder: (context) =>
                                                                                RegisterCreateAccountScreen()));
                                                                      } else {
                                                                        Navigator.push(
                                                                            context,
                                                                            MaterialPageRoute(builder:
                                                                                (context) {
                                                                          return ProfileScreen(
                                                                              User_ID: "${AllGuestPostRoomData?.object?.content?[index].repostOn?.userUid}",
                                                                              isFollowing: AllGuestPostRoomData?.object?.content?[index].repostOn?.isFollowing);
                                                                        }));
                                                                      }
                                                                    },
                                                                    child: AllGuestPostRoomData?.object?.content?[index].repostOn?.userProfilePic !=
                                                                                null &&
                                                                            AllGuestPostRoomData?.object?.content?[index].repostOn?.userProfilePic !=
                                                                                ""
                                                                        ? CircleAvatar(
                                                                            backgroundImage:
                                                                                NetworkImage("${AllGuestPostRoomData?.object?.content?[index].repostOn?.userProfilePic}"),
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
                                                                            fit:
                                                                                BoxFit.fill,
                                                                            radius:
                                                                                BorderRadius.circular(25),
                                                                          ),
                                                                  ),
                                                                  title: Column(
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .start,
                                                                    children: [
                                                                      Container(
                                                                        child:
                                                                            Text(
                                                                          "${AllGuestPostRoomData?.object?.content?[index].repostOn?.postUserName}",
                                                                          style: TextStyle(
                                                                              fontSize: 20,
                                                                              fontFamily: "outfit",
                                                                              fontWeight: FontWeight.bold),
                                                                        ),
                                                                      ),
                                                                      Text(
                                                                        AllGuestPostRoomData?.object?.content?[index].repostOn ==
                                                                                null
                                                                            ? ""
                                                                            : getTimeDifference(repostTime!),
                                                                        style:
                                                                            TextStyle(
                                                                          fontSize:
                                                                              12,
                                                                          fontFamily:
                                                                              "outfit",
                                                                        ),
                                                                      ),
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
                                                                          .repostOn
                                                                          ?.description !=
                                                                      null
                                                                  ? Padding(
                                                                      padding: const EdgeInsets
                                                                              .only(
                                                                          left:
                                                                              16),
                                                                      child:
                                                                          LinkifyText(
                                                                        "${AllGuestPostRoomData?.object?.content?[index].repostOn?.description}",
                                                                        linkStyle:
                                                                            TextStyle(color: Colors.blue),
                                                                        textStyle:
                                                                            TextStyle(color: Colors.black),
                                                                        linkTypes: [
                                                                          LinkType
                                                                              .url,
                                                                          // LinkType
                                                                          //     .userTag,
                                                                          LinkType
                                                                              .hashTag,
                                                                          // LinkType
                                                                          //     .email
                                                                        ],
                                                                        onTap:
                                                                            (link) {
                                                                          var SelectedTest = link
                                                                              .value
                                                                              .toString();
                                                                          var Link =
                                                                              SelectedTest.startsWith('https');
                                                                          var Link1 =
                                                                              SelectedTest.startsWith('http');
                                                                          var Link2 =
                                                                              SelectedTest.startsWith('www');

                                                                          print(
                                                                              SelectedTest.toString());
                                                                          print(
                                                                              Link);
                                                                          if (User_ID ==
                                                                              null) {
                                                                            Navigator.of(context).push(MaterialPageRoute(builder: (context) => RegisterCreateAccountScreen()));
                                                                          } else {
                                                                            if (Link == true &&
                                                                                Link1 == true &&
                                                                                Link2 == true) {
                                                                              launch(link.value.toString(), forceWebView: true, enableJavaScript: true);
                                                                            } else {
                                                                              print("${link}");
                                                                              Navigator.push(
                                                                                  context,
                                                                                  MaterialPageRoute(
                                                                                    builder: (context) => HashTagViewScreen(title: "${link.value}"),
                                                                                  ));
                                                                            }
                                                                          }
                                                                        },
                                                                      ))
                                                                  : SizedBox(),
                                                              Container(
                                                                width: _width,
                                                                child: AllGuestPostRoomData
                                                                            ?.object
                                                                            ?.content?[
                                                                                index]
                                                                            .repostOn
                                                                            ?.postDataType ==
                                                                        null
                                                                    ? SizedBox()
                                                                    : AllGuestPostRoomData?.object?.content?[index].repostOn?.postData?.length ==
                                                                            1
                                                                        ? (AllGuestPostRoomData?.object?.content?[index].repostOn?.postDataType ==
                                                                                "IMAGE"
                                                                            ? GestureDetector(
                                                                                onTap: () {
                                                                                  if (uuid == null) {
                                                                                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => RegisterCreateAccountScreen()));
                                                                                  } else {
                                                                                    Navigator.push(
                                                                                      context,
                                                                                      MaterialPageRoute(
                                                                                          builder: (context) => OpenSavePostImage(
                                                                                                PostID: AllGuestPostRoomData?.object?.content?[index].repostOn?.postUid,
                                                                                                index: index,
                                                                                              )),
                                                                                    );
                                                                                  }
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
                                                                            : AllGuestPostRoomData?.object?.content?[index].repostOn?.postDataType == "ATTACHMENT"
                                                                                ? Container(
                                                                                    height: 400,
                                                                                    width: _width,
                                                                                    child: DocumentViewScreen1(
                                                                                      path: "",
                                                                                    ))
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
                                                                                          setState(() {
                                                                                            _currentPages[index] = page;
                                                                                          });
                                                                                        },
                                                                                        controller: _pageControllers[index],
                                                                                        itemCount: AllGuestPostRoomData?.object?.content?[index].repostOn?.postData?.length,
                                                                                        itemBuilder: (BuildContext context, int index1) {
                                                                                          if (AllGuestPostRoomData?.object?.content?[index].repostOn?.postDataType == "IMAGE") {
                                                                                            return GestureDetector(
                                                                                              onTap: () {
                                                                                                print("Repost Opne Full screen");
                                                                                                // if (uuid == null) {
                                                                                                //   Navigator.of(context).push(MaterialPageRoute(builder: (context) => RegisterCreateAccountScreen()));
                                                                                                // } else {
                                                                                                // Navigator.push(
                                                                                                //   context,
                                                                                                //   MaterialPageRoute(
                                                                                                //       builder: (context) => OpenSavePostImage(
                                                                                                //             PostID: AllGuestPostRoomData?.object?.content?[index].repostOn?.postUid,
                                                                                                //             index: index,
                                                                                                //           )),
                                                                                                // );
                                                                                                // }
                                                                                              },
                                                                                              child: Container(
                                                                                                width: _width,
                                                                                                margin: EdgeInsets.only(left: 16, top: 15, right: 16),
                                                                                                child: Center(
                                                                                                    child: CustomImageView(
                                                                                                  url: "${AllGuestPostRoomData?.object?.content?[index].repostOn?.postData?[index1]}",
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
                                                                                              position: _currentPages[index].toDouble(),
                                                                                              decorator: DotsDecorator(
                                                                                                size: const Size(10.0, 7.0),
                                                                                                activeSize: const Size(10.0, 10.0),
                                                                                                spacing: const EdgeInsets.symmetric(horizontal: 2),
                                                                                                activeColor: Color(0xffED1C25),
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
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(left: 13),
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
                                                                right: 16),
                                                        child: Row(
                                                          children: [
                                                            SizedBox(
                                                              width: 14,
                                                            ),
                                                            GestureDetector(
                                                              onTap: () async {
                                                                await soicalFunation(
                                                                    apiName:
                                                                        'like_post',
                                                                    index:
                                                                        index);
                                                              },
                                                              child: Container(
                                                                color: Colors
                                                                    .transparent,
                                                                child: Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                              .all(
                                                                          5.0),
                                                                  child: AllGuestPostRoomData
                                                                              ?.object
                                                                              ?.content?[
                                                                                  index]
                                                                              .isLiked !=
                                                                          true
                                                                      ? Image
                                                                          .asset(
                                                                          ImageConstant
                                                                              .likewithout,
                                                                          height:
                                                                              20,
                                                                        )
                                                                      : Image
                                                                          .asset(
                                                                          ImageConstant
                                                                              .like,
                                                                          height:
                                                                              20,
                                                                        ),
                                                                ),
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              width: 0,
                                                            ),
                                                            AllGuestPostRoomData
                                                                        ?.object
                                                                        ?.content?[
                                                                            index]
                                                                        .likedCount ==
                                                                    0
                                                                ? SizedBox()
                                                                : GestureDetector(
                                                                    onTap: () {
                                                                      /* Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                      
                                                          ShowAllPostLike("${AllGuestPostRoomData?.object?[index].postUid}"))); */

                                                                      Navigator.push(
                                                                          context,
                                                                          MaterialPageRoute(
                                                                        builder:
                                                                            (context) {
                                                                          return ShowAllPostLike(
                                                                              "${AllGuestPostRoomData?.object?.content?[index].postUid}");
                                                                        },
                                                                      ));
                                                                    },
                                                                    child:
                                                                        Container(
                                                                      color: Colors
                                                                          .transparent,
                                                                      child:
                                                                          Padding(
                                                                        padding:
                                                                            const EdgeInsets.all(5.0),
                                                                        child:
                                                                            Text(
                                                                          "${AllGuestPostRoomData?.object?.content?[index].likedCount}",
                                                                          style: TextStyle(
                                                                              fontFamily: "outfit",
                                                                              fontSize: 14),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                            SizedBox(
                                                              width: 8,
                                                            ),
                                                            GestureDetector(
                                                              onTap: () async {
                                                                BlocProvider.of<
                                                                            AddcommentCubit>(
                                                                        context)
                                                                    .Addcomment(
                                                                        context,
                                                                        '${AllGuestPostRoomData?.object?.content?[index].postUid}');
                                                                if (uuid ==
                                                                    null) {
                                                                  Navigator.of(
                                                                          context)
                                                                      .push(MaterialPageRoute(
                                                                          builder: (context) =>
                                                                              RegisterCreateAccountScreen()));
                                                                } else {
                                                                  _settingModalBottomSheet1(
                                                                      context,
                                                                      index,
                                                                      _width);
                                                                }
                                                              },
                                                              child: Container(
                                                                color: Colors
                                                                    .transparent,
                                                                child: Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                              .all(
                                                                          5.0),
                                                                  child: Image
                                                                      .asset(
                                                                    ImageConstant
                                                                        .meesage,
                                                                    height: 15,
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              width: 5,
                                                            ),
                                                            AllGuestPostRoomData
                                                                        ?.object
                                                                        ?.content?[
                                                                            index]
                                                                        .commentCount ==
                                                                    0
                                                                ? SizedBox()
                                                                : Text(
                                                                    "${AllGuestPostRoomData?.object?.content?[index].commentCount}",
                                                                    style: TextStyle(
                                                                        fontFamily:
                                                                            "outfit",
                                                                        fontSize:
                                                                            14),
                                                                  ),
                                                            SizedBox(
                                                              width: 8,
                                                            ),
                                                            GestureDetector(
                                                              onTap: () {
                                                                // rePostBottomSheet(
                                                                //     context,
                                                                //     index);
                                                                Navigator.push(
                                                                    context,
                                                                    MaterialPageRoute(
                                                                  builder:
                                                                      (context) {
                                                                    return RePostScreen(
                                                                      userProfile: AllGuestPostRoomData
                                                                          ?.object
                                                                          ?.content?[
                                                                              index]
                                                                          .userProfilePic,
                                                                      username: AllGuestPostRoomData
                                                                          ?.object
                                                                          ?.content?[
                                                                              index]
                                                                          .postUserName,
                                                                      date: AllGuestPostRoomData
                                                                          ?.object
                                                                          ?.content?[
                                                                              index]
                                                                          .createdAt,
                                                                      desc: AllGuestPostRoomData
                                                                          ?.object
                                                                          ?.content?[
                                                                              index]
                                                                          .description,
                                                                      postData: AllGuestPostRoomData
                                                                          ?.object
                                                                          ?.content?[
                                                                              index]
                                                                          .postData,
                                                                      postDataType: AllGuestPostRoomData
                                                                          ?.object
                                                                          ?.content?[
                                                                              index]
                                                                          .postDataType,
                                                                      index:
                                                                          index,
                                                                      AllGuestPostRoomData:
                                                                          AllGuestPostRoomData,
                                                                      postUid: AllGuestPostRoomData
                                                                          ?.object
                                                                          ?.content?[
                                                                              index]
                                                                          .postUid,
                                                                    );
                                                                  },
                                                                ));
                                                              },
                                                              child: Container(
                                                                color: Colors
                                                                    .transparent,
                                                                child: Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                              .all(
                                                                          5.0),
                                                                  child: Image
                                                                      .asset(
                                                                    ImageConstant
                                                                        .vector2,
                                                                    height: 13,
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              width: 5,
                                                            ),
                                                            AllGuestPostRoomData
                                                                            ?.object
                                                                            ?.content?[
                                                                                index]
                                                                            .repostCount ==
                                                                        null ||
                                                                    AllGuestPostRoomData
                                                                            ?.object
                                                                            ?.content?[index]
                                                                            .repostCount ==
                                                                        0
                                                                ? SizedBox()
                                                                : Text(
                                                                    '${AllGuestPostRoomData?.object?.content?[index].repostCount}',
                                                                    style: TextStyle(
                                                                        fontFamily:
                                                                            "outfit",
                                                                        fontSize:
                                                                            14),
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
                                                                    apiName:
                                                                        'savedata',
                                                                    index:
                                                                        index);
                                                              },
                                                              child: Container(
                                                                color: Colors
                                                                    .transparent,
                                                                child: Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                              .all(
                                                                          5.0),
                                                                  child: Image
                                                                      .asset(
                                                                    AllGuestPostRoomData?.object?.content?[index].isSaved ==
                                                                            false
                                                                        ? ImageConstant
                                                                            .savePin
                                                                        : ImageConstant
                                                                            .Savefill,
                                                                    height: 17,
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                            // GestureDetector(
                                                            //   onTap: () {
                                                            //     Share.share(
                                                            //         'https://play.google.com/store/apps/details?id=com.pds.app');
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
                                                  left: 16, right: 16),
                                              child: GestureDetector(
                                                onDoubleTap: () async {
                                                  await soicalFunation(
                                                      apiName: 'like_post',
                                                      index: index);
                                                },
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      border: Border.all(
                                                          color: Color.fromRGBO(
                                                              0, 0, 0, 0.25)),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              15)),
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
                                                            onTap: () {
                                                              if (uuid ==
                                                                  null) {
                                                                Navigator.of(
                                                                        context)
                                                                    .push(MaterialPageRoute(
                                                                        builder:
                                                                            (context) =>
                                                                                RegisterCreateAccountScreen()));
                                                              } else {
                                                                Navigator.push(
                                                                    context,
                                                                    MaterialPageRoute(
                                                                        builder:
                                                                            (context) {
                                                                  return ProfileScreen(
                                                                      User_ID:
                                                                          "${AllGuestPostRoomData?.object?.content?[index].userUid}",
                                                                      isFollowing: AllGuestPostRoomData
                                                                          ?.object
                                                                          ?.content?[
                                                                              index]
                                                                          .isFollowing);
                                                                }));
                                                              }
                                                            },
                                                            child: AllGuestPostRoomData
                                                                            ?.object
                                                                            ?.content?[
                                                                                index]
                                                                            .userProfilePic !=
                                                                        null &&
                                                                    AllGuestPostRoomData
                                                                            ?.object
                                                                            ?.content?[index]
                                                                            .userProfilePic !=
                                                                        ""
                                                                ? CircleAvatar(
                                                                    backgroundImage:
                                                                        NetworkImage(
                                                                            "${AllGuestPostRoomData?.object?.content?[index].userProfilePic}"),
                                                                    backgroundColor:
                                                                        Colors
                                                                            .white,
                                                                    radius: 25,
                                                                  )
                                                                : CustomImageView(
                                                                    imagePath:
                                                                        ImageConstant
                                                                            .tomcruse,
                                                                    height: 50,
                                                                    width: 50,
                                                                    fit: BoxFit
                                                                        .fill,
                                                                    radius: BorderRadius
                                                                        .circular(
                                                                            25),
                                                                  ),
                                                          ),
                                                          title: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              // SizedBox(
                                                              //   height: 6,
                                                              // ),
                                                              Container(
                                                                // color: Colors.amber,
                                                                child: Text(
                                                                  "${AllGuestPostRoomData?.object?.content?[index].postUserName}",
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
                                                              //FIndText
                                                              Text(
                                                                getTimeDifference(
                                                                    parsedDateTime),
                                                                style:
                                                                    TextStyle(
                                                                  fontSize: 12,
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
                                                                  onTap: () {
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
                                                                  child: Icon(
                                                                    Icons
                                                                        .more_vert_rounded,
                                                                  ))
                                                              : GestureDetector(
                                                                  onTap:
                                                                      () async {
                                                                    await soicalFunation(
                                                                      apiName:
                                                                          'Follow',
                                                                      index:
                                                                          index,
                                                                    );
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
                                                                        color: Color(
                                                                            0xffED1C25),
                                                                        borderRadius:
                                                                            BorderRadius.circular(4)),
                                                                    child: AllGuestPostRoomData?.object?.content?[index].isFollowing ==
                                                                            'FOLLOW'
                                                                        ? Text(
                                                                            'Follow',
                                                                            style: TextStyle(
                                                                                fontFamily: "outfit",
                                                                                fontSize: 12,
                                                                                fontWeight: FontWeight.bold,
                                                                                color: Colors.white),
                                                                          )
                                                                        : AllGuestPostRoomData?.object?.content?[index].isFollowing ==
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
                                                          ? Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      left: 16),
                                                              child:
                                                                  //this is the despcation
                                                                  GestureDetector(
                                                                      onTap:
                                                                          () async {
                                                                        if (DataGet ==
                                                                            true) {
                                                                          await launch(
                                                                              '${AllGuestPostRoomData?.object?.content?[index].description}',
                                                                              forceWebView: true,
                                                                              enableJavaScript: true);
                                                                        }
                                                                      },
                                                                      child:
                                                                          LinkifyText(
                                                                        "${AllGuestPostRoomData?.object?.content?[index].description}",
                                                                        linkStyle:
                                                                            TextStyle(color: Colors.blue),
                                                                        textStyle:
                                                                            TextStyle(color: Colors.black),
                                                                        linkTypes: [
                                                                          LinkType
                                                                              .url,
                                                                          // LinkType
                                                                          //     .userTag,
                                                                          LinkType
                                                                              .hashTag,
                                                                          // LinkType
                                                                          //     .email
                                                                        ],
                                                                        onTap:
                                                                            (link) {
                                                                          /// do stuff with `link` like
                                                                          /// if(link.type == Link.url) launchUrl(link.value);

                                                                          var SelectedTest = link
                                                                              .value
                                                                              .toString();
                                                                          var Link =
                                                                              SelectedTest.startsWith('https');
                                                                          var Link1 =
                                                                              SelectedTest.startsWith('http');
                                                                          var Link2 =
                                                                              SelectedTest.startsWith('www');
                                                                          print(
                                                                              SelectedTest.toString());
                                                                          print(
                                                                              Link);
                                                                          if (User_ID ==
                                                                              null) {
                                                                            Navigator.of(context).push(MaterialPageRoute(builder: (context) => RegisterCreateAccountScreen()));
                                                                          } else {
                                                                            if (Link == true &&
                                                                                Link1 == true &&
                                                                                Link2 == true) {
                                                                              launch(link.value.toString(), forceWebView: true, enableJavaScript: true);
                                                                            } else {
                                                                              print("${link}");
                                                                              Navigator.push(
                                                                                  context,
                                                                                  MaterialPageRoute(
                                                                                    builder: (context) => HashTagViewScreen(title: "${link.value}"),
                                                                                  ));
                                                                            }
                                                                          }
                                                                        },
                                                                      )),
                                                            )
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
                                                                ? (AllGuestPostRoomData
                                                                            ?.object
                                                                            ?.content?[
                                                                                index]
                                                                            .postDataType ==
                                                                        "IMAGE"
                                                                    ? GestureDetector(
                                                                        onTap:
                                                                            () {
                                                                          if (uuid ==
                                                                              null) {
                                                                            Navigator.of(context).push(MaterialPageRoute(builder: (context) => RegisterCreateAccountScreen()));
                                                                          } else {
                                                                            Navigator.push(
                                                                              context,
                                                                              MaterialPageRoute(
                                                                                  builder: (context) => OpenSavePostImage(
                                                                                        PostID: AllGuestPostRoomData?.object?.content?[index].postUid,
                                                                                        index: index,
                                                                                      )),
                                                                            );
                                                                          }
                                                                        },
                                                                        child:
                                                                            Container(
                                                                          width:
                                                                              _width,
                                                                          margin: EdgeInsets.only(
                                                                              left: 16,
                                                                              top: 15,
                                                                              right: 16),
                                                                          child: Center(
                                                                              child: CustomImageView(
                                                                            url:
                                                                                "${AllGuestPostRoomData?.object?.content?[index].postData?[0]}",
                                                                          )),
                                                                        ),
                                                                      )
                                                                    : AllGuestPostRoomData?.object?.content?[index].postDataType ==
                                                                            "ATTACHMENT"
                                                                        ? (AllGuestPostRoomData?.object?.content?[index].postData?.isNotEmpty ==
                                                                                true)
                                                                            ? Container(
                                                                                height: 400,
                                                                                width: _width,
                                                                                child: DocumentViewScreen1(
                                                                                  path: AllGuestPostRoomData?.object?.content?[index].postData?[0].toString(),
                                                                                ))
                                                                            : SizedBox()
                                                                        : SizedBox())
                                                                : Column(
                                                                    children: [
                                                                      Stack(
                                                                        children: [
                                                                          if ((AllGuestPostRoomData?.object?.content?[index].postData?.isNotEmpty ??
                                                                              false)) ...[
                                                                            SizedBox(
                                                                              height: 300,
                                                                              child: PageView.builder(
                                                                                onPageChanged: (page) {
                                                                                  setState(() {
                                                                                    _currentPages[index] = page;
                                                                                    imageCount = page + 1;
                                                                                  });
                                                                                },
                                                                                controller: _pageControllers[index],
                                                                                itemCount: AllGuestPostRoomData?.object?.content?[index].postData?.length,
                                                                                itemBuilder: (BuildContext context, int index1) {
                                                                                  if (AllGuestPostRoomData?.object?.content?[index].postDataType == "IMAGE") {
                                                                                    return Container(
                                                                                      width: _width,
                                                                                      margin: EdgeInsets.only(left: 16, top: 15, right: 16),
                                                                                      child: Center(
                                                                                          child: GestureDetector(
                                                                                        onTap: () {
                                                                                          if (uuid == null) {
                                                                                            Navigator.of(context).push(MaterialPageRoute(builder: (context) => RegisterCreateAccountScreen()));
                                                                                          } else {
                                                                                            Navigator.push(
                                                                                              context,
                                                                                              MaterialPageRoute(
                                                                                                  builder: (context) => OpenSavePostImage(
                                                                                                        PostID: AllGuestPostRoomData?.object?.content?[index].postUid,
                                                                                                        index: index1,
                                                                                                      )),
                                                                                            );
                                                                                          }
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
                                                                                                  setState(() {
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
                                                                                              alignment: Alignment.topCenter,
                                                                                              child: CustomImageView(
                                                                                                url: "${AllGuestPostRoomData?.object?.content?[index].postData?[index1]}",
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
                                                                                      position: _currentPages[index].toDouble(),
                                                                                      decorator: DotsDecorator(
                                                                                        size: const Size(10.0, 7.0),
                                                                                        activeSize: const Size(10.0, 10.0),
                                                                                        spacing: const EdgeInsets.symmetric(horizontal: 2),
                                                                                        activeColor: Color(0xffED1C25),
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
                                                                .only(left: 13),
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
                                                                right: 16),
                                                        child: Row(
                                                          children: [
                                                            SizedBox(
                                                              width: 14,
                                                            ),
                                                            GestureDetector(
                                                              onTap: () async {
                                                                await soicalFunation(
                                                                    apiName:
                                                                        'like_post',
                                                                    index:
                                                                        index);
                                                              },
                                                              child: Container(
                                                                color: Colors
                                                                    .transparent,
                                                                child: Padding(
                                                                  padding:
                                                                      EdgeInsets
                                                                          .all(
                                                                              5.0),
                                                                  child: AllGuestPostRoomData
                                                                              ?.object
                                                                              ?.content?[
                                                                                  index]
                                                                              .isLiked !=
                                                                          true
                                                                      ? Image
                                                                          .asset(
                                                                          ImageConstant
                                                                              .likewithout,
                                                                          height:
                                                                              18,
                                                                        )
                                                                      : Image
                                                                          .asset(
                                                                          ImageConstant
                                                                              .like,
                                                                          height:
                                                                              18,
                                                                        ),
                                                                ),
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              width: 0,
                                                            ),
                                                            AllGuestPostRoomData
                                                                        ?.object
                                                                        ?.content?[
                                                                            index]
                                                                        .likedCount ==
                                                                    0
                                                                ? SizedBox()
                                                                : GestureDetector(
                                                                    onTap: () {
                                                                      /* Navigator.push(  
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
    
                                                          ShowAllPostLike("${AllGuestPostRoomData?.object?[index].postUid}"))); */

                                                                      Navigator.push(
                                                                          context,
                                                                          MaterialPageRoute(
                                                                        builder:
                                                                            (context) {
                                                                          return ShowAllPostLike(
                                                                              "${AllGuestPostRoomData?.object?.content?[index].postUid}");
                                                                        },
                                                                      ));
                                                                    },
                                                                    child:
                                                                        Container(
                                                                      color: Colors
                                                                          .transparent,
                                                                      child:
                                                                          Padding(
                                                                        padding:
                                                                            EdgeInsets.all(5.0),
                                                                        child:
                                                                            Align(
                                                                          alignment:
                                                                              Alignment.centerLeft,
                                                                          child:
                                                                              Text(
                                                                            "${AllGuestPostRoomData?.object?.content?[index].likedCount}",
                                                                            style:
                                                                                TextStyle(fontFamily: "outfit", fontSize: 14),
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
                                                                  BlocProvider.of<
                                                                              AddcommentCubit>(
                                                                          context)
                                                                      .Addcomment(
                                                                          context,
                                                                          '${AllGuestPostRoomData?.object?.content?[index].postUid}');
                                                                  if (uuid ==
                                                                      null) {
                                                                    Navigator.of(
                                                                            context)
                                                                        .push(MaterialPageRoute(
                                                                            builder: (context) =>
                                                                                RegisterCreateAccountScreen()));
                                                                  } else {
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
                                                                          ImageConstant
                                                                              .meesage,
                                                                          height:
                                                                              15,
                                                                          // width: 15,
                                                                        )))),
                                                            SizedBox(
                                                              width: 5,
                                                            ),
                                                            AllGuestPostRoomData
                                                                        ?.object
                                                                        ?.content?[
                                                                            index]
                                                                        .commentCount ==
                                                                    0
                                                                ? SizedBox()
                                                                : Text(
                                                                    "${AllGuestPostRoomData?.object?.content?[index].commentCount}",
                                                                    style: TextStyle(
                                                                        fontFamily:
                                                                            "outfit",
                                                                        fontSize:
                                                                            14),
                                                                  ),
                                                            SizedBox(
                                                              width: 5,
                                                            ),
                                                            GestureDetector(
                                                              onTap: () {
                                                                if (uuid ==
                                                                    null) {
                                                                  Navigator.of(
                                                                          context)
                                                                      .push(MaterialPageRoute(
                                                                          builder: (context) =>
                                                                              RegisterCreateAccountScreen()));
                                                                } else {
                                                                  // rePostBottomSheet(
                                                                  //     context,
                                                                  //     index);
                                                                  Navigator.push(
                                                                      context,
                                                                      MaterialPageRoute(
                                                                    builder:
                                                                        (context) {
                                                                      return RePostScreen(
                                                                        userProfile: AllGuestPostRoomData
                                                                            ?.object
                                                                            ?.content?[index]
                                                                            .userProfilePic,
                                                                        username: AllGuestPostRoomData
                                                                            ?.object
                                                                            ?.content?[index]
                                                                            .postUserName,
                                                                        date: AllGuestPostRoomData
                                                                            ?.object
                                                                            ?.content?[index]
                                                                            .createdAt,
                                                                        desc: AllGuestPostRoomData
                                                                            ?.object
                                                                            ?.content?[index]
                                                                            .description,
                                                                        postData: AllGuestPostRoomData
                                                                            ?.object
                                                                            ?.content?[index]
                                                                            .postData,
                                                                        postDataType: AllGuestPostRoomData
                                                                            ?.object
                                                                            ?.content?[index]
                                                                            .postDataType,
                                                                        index:
                                                                            index,
                                                                        AllGuestPostRoomData:
                                                                            AllGuestPostRoomData,
                                                                        postUid: AllGuestPostRoomData
                                                                            ?.object
                                                                            ?.content?[index]
                                                                            .postUid,
                                                                      );
                                                                    },
                                                                  ));
                                                                }
                                                              },
                                                              child: Container(
                                                                color: Colors
                                                                    .transparent,
                                                                child: Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                              .all(
                                                                          5.0),
                                                                  child: Image
                                                                      .asset(
                                                                    ImageConstant
                                                                        .vector2,
                                                                    height: 13,
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              width: 5,
                                                            ),
                                                            AllGuestPostRoomData
                                                                            ?.object
                                                                            ?.content?[
                                                                                index]
                                                                            .repostCount ==
                                                                        null ||
                                                                    AllGuestPostRoomData
                                                                            ?.object
                                                                            ?.content?[index]
                                                                            .repostCount ==
                                                                        0
                                                                ? SizedBox()
                                                                : Text(
                                                                    uuid == null
                                                                        ? ""
                                                                        : '${AllGuestPostRoomData?.object?.content?[index].repostCount}',
                                                                    style: TextStyle(
                                                                        fontFamily:
                                                                            "outfit",
                                                                        fontSize:
                                                                            14),
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
                                                                    apiName:
                                                                        'savedata',
                                                                    index:
                                                                        index);
                                                              },
                                                              child: Container(
                                                                color: Colors
                                                                    .transparent,
                                                                child: Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                              .all(
                                                                          5.0),
                                                                  child: Image
                                                                      .asset(
                                                                    AllGuestPostRoomData?.object?.content?[index].isSaved ==
                                                                            false
                                                                        ? ImageConstant
                                                                            .savePin
                                                                        : ImageConstant
                                                                            .Savefill,
                                                                    height: 17,
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                            // GestureDetector(
                                                            //   onTap: () {
                                                            //     Share.share(
                                                            //         'https://play.google.com/store/apps/details?id=com.pds.app');
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
                                            ? SizedBox()
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
                                                                            builder: (context) =>
                                                                                MultiBlocProvider(providers: [
                                                                              BlocProvider<SherInviteCubit>(
                                                                                create: (_) => SherInviteCubit(),
                                                                              ),
                                                                            ], child: ExpertsScreen(RoomUUID: "")),
                                                                            // ExpertsScreen(RoomUUID:  PriveateRoomData?.object?[index].uid),
                                                                          )).then(
                                                                      (value) =>
                                                                          setState(
                                                                              () {
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
                                                                        left: index ==
                                                                                0
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
                                                                          border: Border.all(color: Colors.red, width: 3),
                                                                          borderRadius: BorderRadius.circular(14)),
                                                                      child:
                                                                          Stack(
                                                                        children: [
                                                                          CustomImageView(
                                                                            height:
                                                                                180,
                                                                            width:
                                                                                128,
                                                                            radius:
                                                                                BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10)),
                                                                            url:
                                                                                "${AllExperData?.object?[index].profilePic}",
                                                                            fit:
                                                                                BoxFit.cover,
                                                                          ),
                                                                          Align(
                                                                            alignment:
                                                                                Alignment.topCenter,
                                                                            child:
                                                                                Container(
                                                                              height: 24,
                                                                              alignment: Alignment.center,
                                                                              width: 70,
                                                                              decoration: BoxDecoration(
                                                                                borderRadius: BorderRadius.only(
                                                                                  bottomLeft: Radius.circular(8),
                                                                                  bottomRight: Radius.circular(8),
                                                                                ),
                                                                                color: Color.fromRGBO(237, 28, 37, 0.5),
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
                                                                                  Text(
                                                                                    'Follow',
                                                                                    style: TextStyle(fontFamily: "outfit", fontSize: 12, color: Colors.white, fontWeight: FontWeight.bold),
                                                                                  )
                                                                                ],
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          Padding(
                                                                            padding:
                                                                                EdgeInsets.only(bottom: 25),
                                                                            child:
                                                                                Align(
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
                                                                                          "${AllExperData?.object?[index].userName}",
                                                                                          style: TextStyle(fontSize: 11, color: Colors.white, fontFamily: "outfit", fontWeight: FontWeight.bold),
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
                                                                                        SizedBox(height: 13, child: Image.asset(ImageConstant.beg)),
                                                                                        SizedBox(
                                                                                          width: 2,
                                                                                        ),
                                                                                        Text(
                                                                                          'Expertise in ${AllExperData?.object?[index].expertise?[0].expertiseName}',
                                                                                          maxLines: 1,
                                                                                          style: TextStyle(fontFamily: "outfit", fontSize: 11, overflow: TextOverflow.ellipsis, color: Colors.white, fontWeight: FontWeight.bold),
                                                                                        ),
                                                                                      ],
                                                                                    )
                                                                                  ],
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          GestureDetector(
                                                                            onTap:
                                                                                () {
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
                                                                                      )).then((value) => setState(() {
                                                                                    // refresh = true;
                                                                                  }));
                                                                            },
                                                                            child:
                                                                                Align(
                                                                              alignment: Alignment.bottomCenter,
                                                                              child: Container(
                                                                                height: 25,
                                                                                width: 130,
                                                                                decoration: BoxDecoration(
                                                                                  borderRadius: BorderRadius.only(
                                                                                    bottomLeft: Radius.circular(8),
                                                                                    bottomRight: Radius.circular(8),
                                                                                  ),
                                                                                  color: Color(0xffED1C25),
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
                                                            margin:
                                                                EdgeInsets.only(
                                                                    left: 10),
                                                            child: Text(
                                                              'Blogs',
                                                              style: TextStyle(
                                                                  fontFamily:
                                                                      "outfit",
                                                                  fontSize: 18,
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
                                                        height: _height / 3.23,
                                                        // width: _width,
                                                        margin: EdgeInsets.only(
                                                            bottom: 15),
                                                        child: ListView.builder(
                                                          itemCount:
                                                              getallBlogModel1
                                                                  ?.object
                                                                  ?.length,
                                                          scrollDirection:
                                                              Axis.horizontal,
                                                          itemBuilder: (context,
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
                                                                      builder: (context) => RecentBlogScren(
                                                                          description1: getallBlogModel1?.object?[index1].description.toString() ??
                                                                              "",
                                                                          title: getallBlogModel1?.object?[index1].title.toString() ??
                                                                              "",
                                                                          imageURL:
                                                                              getallBlogModel1?.object?[index1].image.toString() ?? ""),
                                                                    ));
                                                              },
                                                              child: Container(
                                                                height: 230,
                                                                width: _width /
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
                                                                      url: getallBlogModel1
                                                                              ?.object?[index1]
                                                                              .image
                                                                              .toString() ??
                                                                          "",
                                                                      height:
                                                                          155,
                                                                      width:
                                                                          _width,
                                                                      fit: BoxFit
                                                                          .fill,
                                                                      radius: BorderRadius
                                                                          .circular(
                                                                              10),
                                                                    ),
                                                                    Padding(
                                                                      padding: const EdgeInsets
                                                                              .only(
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
                                                                            fontSize:
                                                                                16,
                                                                            overflow: TextOverflow
                                                                                .ellipsis,
                                                                            fontFamily:
                                                                                "outfit",
                                                                            fontWeight:
                                                                                FontWeight.w400),
                                                                      ),
                                                                    ),
                                                                    Row(
                                                                      children: [
                                                                        Padding(
                                                                          padding: const EdgeInsets.only(
                                                                              left: 10,
                                                                              top: 3),
                                                                          child:
                                                                              Text(
                                                                            /*  getallBlogModel?.object?.length != 0 ||
                                                                                      getallBlogModel?.object != null
                                                                                  ?
                                                                                  : */
                                                                            customFormat(parsedDateTimeBlogs!),
                                                                            style: TextStyle(
                                                                                fontFamily: "outfit",
                                                                                fontSize: 12,
                                                                                fontWeight: FontWeight.w400,
                                                                                color: Color(0xffABABAB)),
                                                                          ),
                                                                        ),
                                                                        Container(
                                                                          height:
                                                                              6,
                                                                          width:
                                                                              7,
                                                                          margin: EdgeInsets.only(
                                                                              top: 5,
                                                                              left: 2),
                                                                          decoration: BoxDecoration(
                                                                              shape: BoxShape.circle,
                                                                              color: Color(0xffABABAB)),
                                                                        ),
                                                                        Padding(
                                                                          padding: const EdgeInsets.only(
                                                                              top: 4,
                                                                              left: 1),
                                                                          child:
                                                                              Text(
                                                                            '12.3K Views',
                                                                            style:
                                                                                TextStyle(fontSize: 11, color: Color(0xffABABAB)),
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                    Row(
                                                                      children: [
                                                                        GestureDetector(
                                                                          onTap:
                                                                              () {
                                                                            print("Click On Like Button");

                                                                            BlocProvider.of<GetGuestAllPostCubit>(context).LikeBlog(
                                                                                context,
                                                                                "${User_ID}",
                                                                                "${getallBlogModel1?.object?[index1].uid}");

                                                                            if (getallBlogModel1?.object?[index1].isLiked ==
                                                                                false) {
                                                                              getallBlogModel1?.object?[index1].isLiked = true;
                                                                            } else {
                                                                              getallBlogModel1?.object?[index1].isLiked = false;
                                                                            }
                                                                          },
                                                                          child:
                                                                              Padding(
                                                                            padding:
                                                                                const EdgeInsets.only(left: 7, top: 4),
                                                                            child: getallBlogModel1?.object?[index1].isLiked == false
                                                                                ? Icon(Icons.favorite_border)
                                                                                : Icon(
                                                                                    Icons.favorite,
                                                                                    color: Colors.red,
                                                                                  ),
                                                                          ),
                                                                        ),
                                                                        SizedBox(
                                                                          width:
                                                                              15,
                                                                        ),
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

                                                                            BlocProvider.of<GetGuestAllPostCubit>(context).SaveBlog(
                                                                                context,
                                                                                "${User_ID}",
                                                                                "${getallBlogModel1?.object?[index1].uid}");
                                                                            if (getallBlogModel1?.object?[index1].isSaved ==
                                                                                false) {
                                                                              getallBlogModel1?.object?[index1].isSaved = true;
                                                                            } else {
                                                                              getallBlogModel1?.object?[index1].isSaved = false;
                                                                            }
                                                                          },
                                                                          child:
                                                                              SizedBox(
                                                                            height:
                                                                                35,
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
          })),
    );
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
                  setState(() {
                    indexx = index;
                  });
                  index == 0 ? CreateForum() : becomeAnExport();
                },
                child: Container(
                  decoration: BoxDecoration(
                      color: indexx == index
                          ? Color(0xffED1C25)
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
                  setState(() {
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
                            ? Color(0xffED1C25)
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
    ImageDataPostOne? imageDataPost;
    if (Platform.isAndroid) {
      final info = await DeviceInfoPlugin().androidInfo;
      if (num.parse(await info.version.release).toInt() >= 13) {
        if (await permissionHandler(context, Permission.photos) ?? false) {
          imageDataPost = await Navigator.push(context,
              MaterialPageRoute(builder: (context) {
            return CreateStoryPage(
              finalFileSize: finalFileSize,
            );
          }));
          print("imageData--${imageDataPost?.object.toString()}");
          var parmes = {"storyData": imageDataPost?.object.toString()};

          Repository().cretateStoryApi(context, parmes);
        }
      } else if (await permissionHandler(context, Permission.storage) ??
          false) {
        imageDataPost =
            await Navigator.push(context, MaterialPageRoute(builder: (context) {
          return CreateStoryPage(
            finalFileSize: finalFileSize,
          );
        }));
        var parmes = {"storyData": imageDataPost?.object.toString()};
        Repository().cretateStoryApi(context, parmes);
      }
    }
    buttonDatas[0].images.add(StoryModel(
        imageDataPost!.object!,
        DateTime.now().toIso8601String(),
        UserProfileImage,
        User_Name,
        "",
        "${User_ID}"));
    if (imageDataPost.object != null) {
      buttonDatas[0].storyPages.add(FullStoryPage(
            imageName: '${imageDataPost.object}',
          ));
      if (mounted)
        setState(() {
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
              useruid:
                  AllGuestPostRoomData?.object?.content?[index].userUid ?? "",
              userProfile: AllGuestPostRoomData
                      ?.object?.content?[index].userProfilePic ??
                  "",
              UserName:
                  AllGuestPostRoomData?.object?.content?[index].postUserName ??
                      "",
              desc: AllGuestPostRoomData?.object?.content?[index].description ??
                  "",
              postUuID:
                  AllGuestPostRoomData?.object?.content?[index].postUid ?? "");
        });
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

    // setState(() {
    isEmojiVisible = !isEmojiVisible;

    // });
  }

  void onEmojiSelected(String emoji) => setState(() {
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

  // void rePostBottomSheet(context, index) {
  //   showModalBottomSheet(
  //       context: context,
  //       builder: (BuildContext bc) {
  //         return Container(
  //           height: 200,
  //           child: new Wrap(
  //             children: [
  //               Container(
  //                 height: 20,
  //                 width: 50,
  //                 color: Colors.transparent,
  //               ),
  //               Center(
  //                   child: Container(
  //                 height: 5,
  //                 width: 150,
  //                 decoration: BoxDecoration(
  //                     color: Colors.grey,
  //                     borderRadius: BorderRadius.circular(25)),
  //               )),
  //               SizedBox(
  //                 height: 35,
  //               ),
  //               Center(
  //                 child: new ListTile(
  //                     leading: new Image.asset(
  //                       ImageConstant.vector2,
  //                       height: 20,
  //                     ),
  //                     title: new Text('RePost'),
  //                     subtitle: Text(
  //                       "Share this post with your followers",
  //                       style: TextStyle(fontSize: 10, color: Colors.grey),
  //                     ),
  //                     onTap: () async {
  //                       Map<String, dynamic> param = {
  //                         "description": "",
  //                         "postData": "",
  //                         "postDataType": "",
  //                         "postType": ""
  //                       };
  //                       BlocProvider.of<GetGuestAllPostCubit>(context)
  //                           .RePostAPI(
  //                               context,
  //                               param,
  //                               AllGuestPostRoomData
  //                                   ?.object?.content?[index].postUid);
  //                       Navigator.pop(context);
  //                     }),
  //               ),
  //               SizedBox(
  //                 height: 20,
  //               ),
  //               Center(
  //                 child: new ListTile(
  //                   leading: new Icon(
  //                     Icons.edit_outlined,
  //                     color: Colors.black,
  //                   ),
  //                   title: new Text('Quote'),
  //                   subtitle: Text(
  //                     "Add a comment, photo or GIF before you share this post",
  //                     style: TextStyle(fontSize: 10, color: Colors.grey),
  //                   ),
  //                   onTap: () async {
  //                     Navigator.push(context, MaterialPageRoute(
  //                       builder: (context) {
  //                         return RePostScreen(
  //                           userProfile: AllGuestPostRoomData
  //                               ?.object?.content?[index].userProfilePic,
  //                           username: AllGuestPostRoomData
  //                               ?.object?.content?[index].postUserName,
  //                           date: AllGuestPostRoomData
  //                               ?.object?.content?[index].createdAt,
  //                           desc: AllGuestPostRoomData
  //                               ?.object?.content?[index].description,
  //                           postData: AllGuestPostRoomData
  //                               ?.object?.content?[index].postData,
  //                           postDataType: AllGuestPostRoomData
  //                               ?.object?.content?[index].postDataType,
  //                           index: index,
  //                           AllGuestPostRoomData: AllGuestPostRoomData,
  //                           postUid: AllGuestPostRoomData
  //                               ?.object?.content?[index].postUid,
  //                         );
  //                       },
  //                     ));
  //                     // Navigator.pop(context);
  //                   },
  //                 ),
  //               ),
  //               SizedBox(
  //                 height: 20,
  //               ),
  //             ],
  //           ),
  //         );
  //       });
  // }
}
