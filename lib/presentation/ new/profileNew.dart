// // ignore_for_file: must_be_immutable, override_on_non_overriding_member

import 'dart:io';
import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_mentions/flutter_mentions.dart';
import 'package:flutter_observer/Observable.dart';
import 'package:flutter_observer/Observer.dart';
import 'package:intl/intl.dart';
import 'package:linkfy_text/linkfy_text.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pds/API/Bloc/NewProfileScreen_Bloc/NewProfileScreen_cubit.dart';
import 'package:pds/API/Bloc/NewProfileScreen_Bloc/NewProfileScreen_state.dart';
import 'package:pds/API/Bloc/add_comment_bloc/add_comment_cubit.dart';
import 'package:pds/API/Model/FollwersModel/FllowersModel.dart';
import 'package:pds/API/Model/NewProfileScreenModel/GetAppUserPost_Model.dart';
import 'package:pds/API/Model/NewProfileScreenModel/GetSavePost_Model.dart';
import 'package:pds/API/Model/NewProfileScreenModel/GetUserPostCommet_Model.dart';
import 'package:pds/API/Model/NewProfileScreenModel/NewProfileScreen_Model.dart';
import 'package:pds/API/Model/getall_compeny_page_model/getall_compeny_page.dart';
import 'package:pds/API/Model/saveAllBlogModel/saveAllBlog_Model.dart';
import 'package:pds/core/app_export.dart';
import 'package:pds/core/utils/color_constant.dart';
import 'package:pds/core/utils/sharedPreferences.dart';
import 'package:pds/presentation/%20new/AddWorkExperience_Screen.dart';
import 'package:pds/presentation/%20new/ExperienceEdit_screen.dart';
import 'package:pds/presentation/%20new/HashTagView_screen.dart';
import 'package:pds/presentation/%20new/OpenSavePostImage.dart';
import 'package:pds/presentation/%20new/RePost_Screen.dart';
import 'package:pds/presentation/%20new/ShowAllPostLike.dart';
import 'package:pds/presentation/%20new/commenwigetReposrt.dart';
import 'package:pds/presentation/%20new/editproilescreen.dart';
import 'package:pds/presentation/%20new/newbottembar.dart';
import 'package:pds/presentation/%20new/videoScreen.dart';
import 'package:pds/presentation/%20new/view_profile_background.dart';
import 'package:pds/presentation/DMAll_Screen/Dm_Screen.dart';
import 'package:pds/presentation/recent_blog/recent_blog_screen.dart';
import 'package:pds/presentation/register_create_account_screen/register_create_account_screen.dart';
import 'package:pds/widgets/commentPdf.dart';
import 'package:pds/widgets/custom_text_form_field.dart';
import 'package:pinch_zoom/pinch_zoom.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:translator/translator.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../API/Bloc/followerBlock/followBlock.dart';
import '../../API/Bloc/my_account_Bloc/my_account_cubit.dart';
import '../../API/Model/HasTagModel/hasTagModel.dart';
import '../../API/Model/UserTagModel/UserTag_model.dart';
import '../../API/Model/WorkExperience_Model/WorkExperience_model.dart';
import '../../API/Model/serchForInboxModel/serchForinboxModel.dart';
import '../../widgets/Block_dailog.dart';
import '../Create_Post_Screen/Ceratepost_Screen.dart';
import '../settings/setting_screen.dart';
import 'comment_bottom_sheet.dart';
import 'followers.dart';
import 'switchProfilebootmSheet.dart';

class ProfileScreen extends StatefulWidget {
  String User_ID;
  String? isFollowing;
  bool? ProfileNotification;
  String? Screen;
  ProfileScreen(
      {required this.User_ID,
      required this.isFollowing,
      this.ProfileNotification,
      this.Screen});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class NotificationModel {
  int id;
  String title;
  bool isSelected;
  NotificationModel(this.id, this.title, {this.isSelected = false});
}

class _ProfileScreenState extends State<ProfileScreen>
    with SingleTickerProviderStateMixin, Observer {
  List<String> tabData = ["Details", "Post", "Comments", "Saved"];
  List<String> soicalScreen = [
    "Details",
    "Post",
    "Comments",
  ];
  String formattedDate = DateFormat('dd-MM-yyyy').format(DateTime.now());
  DateTime? parsedDateTimeBlogs;
  String? User_ID;
  List<String> SaveList = ["Post", "Blog"];
  // List<String>
  String industryTypesArray = "";
  String ExpertiseData = "";
  bool isUpDate = false;
  TimeOfDay? _startTime;
  TimeOfDay? _endTime;
  String? dopcument;
  String? filepath;
  double value2 = 0.0;
  bool isDataSet = true;
  String? userCompanyPageUid;
  String? workignStart;
  String? workignend;
  String? start;
  GetAllCompenyPageModel? getallcompenypagemodel;
  String? startAm;
  String? end;
  String? endAm;
  String selctedValue = 'Newest to oldest';
  String selctedValue1 = 'All Date';
  String selctedValue2 = 'All Users';
  TextEditingController jobprofileController = TextEditingController();
  TextEditingController IndustryType = TextEditingController();
  TextEditingController priceContrller = TextEditingController();
  TextEditingController uplopdfile = TextEditingController();
  TextEditingController CompanyName = TextEditingController();
  TextEditingController Expertise = TextEditingController();
  bool isNotEmployee = false;
  TextEditingController aboutMe = TextEditingController();
  NewProfileScreen_Model? NewProfileData;
  GetAppUserPostModel? GetAllPostData;
  GetUserPostCommetModel? GetUserPostCommetData;
  GetSavePostModel? GetSavePostData;
  saveAllBlogModel? saveAllBlogModelData;
  int UserProfilePostCount = 0;
  int FinalPostCount = 0;
  int CommentsPostCount = 0;
  int FinalSavePostCount = 0;
  int SavePostCount = 0;
  int SaveBlogCount = 0;
  // String? User_ID;
  int? value1;
  bool isDataGet = false;
  bool isAbourtMe = true;
  bool AbboutMeShow = true;
  var uploadimage = "";
  dynamic dataSetup;
  GetWorkExperienceModel? addWorkExperienceModel;
  String? formattedDateStart;
  String? formattedDateEnd;
  String? User_Module;
  String? User_CompnyPageModule;

  FollowersClassModel? followersClassModel1;
  FollowersClassModel? followersClassModel2;
  List<String> videoUrls = [];
  SearchUserForInbox? searchUserForInbox1;
  bool istageData = false;
  bool isHeshTegData = false;
  HasDataModel? getAllHashtag;
  List<Map<String, dynamic>> tageData = [];
  List<Map<String, dynamic>> heshTageData = [];
  Map<String, Uint8List> thumbnailDataMap = {};
  Uint8List? thumbnailData;
  List<Uint8List?> thumbnailData1 = [];
  List<PageController> _pageControllers = [];
  List<int> _currentPages = [];
  bool added = false;
  int imageCount1 = 1;
  int imageCount2 = 1;
  int imageCount = 1;
  UserTagModel? userTagModel;
  TabController? _tabController;
  ScrollController scrollController = ScrollController();
  int selectedIndex = 0;
  bool swipLeft = false;
  bool swipeRigth = false;
  bool Blockuser = false;
  GlobalKey key = GlobalKey();
  GlobalKey blockKey = GlobalKey();
  bool isScrollingDown = false;
  bool? soicalData;

  bool _show = true;
  int indexx = 0;
  ScrollController _scrollController = ScrollController();
  bool _isScrolledUp = false;
  bool scrolldown = false;
  bool isOpen = false;
  bool isDataGetValue = false;
  void launchEmail(String emailAddress) async {
    final Uri emailLaunchUri = Uri(
      // scheme: 'Test',
      path: emailAddress,
    );
    Uri mailto = Uri.parse("mailto:$emailLaunchUri");
    // if (Platform.isAndroid && Platform.isIOS) {
    await launchUrl(mailto);
    // } else {
    //   print("Somthing went wrong!");
    // }
    /* if (await canLaunch(emailLaunchUri.toString())) {
    await launch(emailLaunchUri.toString());
  } else {
    throw 'Could not launch email';
  } */
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

  void myScroll() async {
    _scrollController.addListener(() {
      if (_scrollController.position.userScrollDirection ==
          ScrollDirection.reverse) {
        if (!isScrollingDown || !scrolldown) {
          isScrollingDown = true;
          scrolldown = true;
          //  _isScrolleddown=false;
          hideFloting();
        }
      }
      if (_scrollController.position.userScrollDirection ==
          ScrollDirection.forward) {
        if (isScrollingDown || !scrolldown) {
          isScrollingDown = false;
          scrolldown = false;
          // _isScrolleddown=true;

          showFloting();
        }
      }
    });
  }

  // void myScrolll() async {
  //   _scrollController.addListener(() {
  //     if (_scrollController.position.userScrollDirection ==
  //         ScrollDirection.reverse) {
  //       if (!isScrollingDown) {
  //         // isScrollingDown = true;
  //         //  _isScrolleddown=false;
  //         hideFloting();
  //       }
  //     }
  //     if (_scrollController.position.userScrollDirection ==
  //         ScrollDirection.forward) {
  //       if (isScrollingDown) {
  //         // isScrollingDown = false;
  //         // _isScrolleddown=true;

  //         showFloting();
  //       }
  //     }
  //   });
  // }

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

  var arrNotiyTypeList = [
    NotificationModel(
      1,
      " ",
      isSelected: true,
    ),
    NotificationModel(
      2,
      " ",
    ),
    NotificationModel(
      3,
      " ",
    ),
    NotificationModel(
      4,
      " ",
    ),
  ];
  savedataFuntion(String userId) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    User_Module = prefs.getString(PreferencesKey.module);
    soicalData =
        prefs.getBool(PreferencesKey.videoCallaudiocallcompnypagecreation);
    super.setState(() {});

    BlocProvider.of<NewProfileSCubit>(context).get_about_me(context, userId);

    BlocProvider.of<NewProfileSCubit>(context).GetAllSaveBlog(context, userId);
  }

  @override
  void initState() {
    BlocProvider.of<NewProfileSCubit>(context).getallcompenypagee(context);
    Observable.instance.addObserver(this);
    _tabController = TabController(length: tabData.length, vsync: this);
    _scrollController.addListener(_scrollListener);
    getAllAPI_Data();
    getUserSavedData();
    dataSetup = null;
    value1 = 0;

    super.initState();
  }

  getAllAPI_Data() async {
    widget.ProfileNotification == true
        ? BlocProvider.of<NewProfileSCubit>(context)
            .NewProfileSAPI(context, widget.User_ID, true)
        : BlocProvider.of<NewProfileSCubit>(context)
            .NewProfileSAPI(context, widget.User_ID, false);
    BlocProvider.of<NewProfileSCubit>(context)
        .getFollwerApi(context, widget.User_ID);
    BlocProvider.of<NewProfileSCubit>(context)
        .getAllFollwing(context, widget.User_ID);
    BlocProvider.of<NewProfileSCubit>(context)
        .GetWorkExperienceAPI(context, widget.User_ID);
  }

  getUserSavedData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    User_ID = prefs.getString(PreferencesKey.loginUserID);
    User_Module = prefs.getString(PreferencesKey.module);
    User_CompnyPageModule = prefs.getString(PreferencesKey.module1);
    print("this is the seaction check -${User_CompnyPageModule}");
  }

  @override
  update(Observable observable, String? notifyName, Map? map) async {
    GetAllPostData?.object?[map?['index']].isReports = true;
    setState(() {});
  }

  @override
  void dispose() {
    _tabController!.dispose();
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollListener() {
    if (_scrollController.position.userScrollDirection ==
        ScrollDirection.reverse) {
      setState(() {
        _isScrolledUp = true;
      });
    } else {
      setState(() {
        _isScrolledUp = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var _height = MediaQuery.of(context).size.height;
    var _width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: NotificationListener<ScrollNotification>(
        onNotification: (scrollNotification) {
          if (scrollNotification is ScrollEndNotification) {
            /* setState(() {
              _isScrolledUp = false;
            }); */
          }
          return false;
        },
        child: BlocConsumer<NewProfileSCubit, NewProfileSState>(
            listener: (context, state) async {
          if (state is NewProfileSErrorState) {
            SnackBar snackBar = SnackBar(
              content: Text(state.error),
              backgroundColor: ColorConstant.primary_color,
            );
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          }

          if (state is AboutMeLoadedState1) {
            print("this data i will get-->${state.aboutMe.object}");
            if (state.aboutMe.object?.isNotEmpty == true) {
              AbboutMeShow = false;
            }
            aboutMe.text = state.aboutMe.object.toString();
          }
          if (state is saveAllBlogModelLoadedState1) {
            saveAllBlogModelData = state.saveAllBlogModelData;
            SaveBlogCount = saveAllBlogModelData?.object?.length ?? 0;
          }
          if (state is NewProfileSLoadingState) {
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
          if (state is FollowersClass) {
            /*  SnackBar snackBar = SnackBar(
              content: Text(state.followersClassModel.object![0].followerUid.toString()),
              backgroundColor: ColorConstant.primary_color,
            );
            ScaffoldMessenger.of(context).showSnackBar(snackBar); */
            followersClassModel1 = state.followersClassModel;
          }
          if (state is FollowersClass1) {
            followersClassModel2 = state.followersClassModel1;
          }
          if (state is DMChatListLoadedState) {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return DmScreen(
                isBlock: NewProfileData?.object?.isBlock,
                UserUID: "${NewProfileData?.object?.userUid}",
                UserName: "${NewProfileData?.object?.userName}",
                ChatInboxUid: state.DMChatList.object ?? "",
                UserImage: "${NewProfileData?.object?.userProfilePic}",
              );
            }));
          }
          if (state is NewProfileSLoadedState) {
            industryTypesArray = "";
            ExpertiseData = "";
            NewProfileData = state.PublicRoomData;
            print("i check accountTyp--${NewProfileData?.object?.accountType}");
            isDataGet = true;
            print(NewProfileData?.object?.module);
            BlocProvider.of<NewProfileSCubit>(context)
                .GetAppPostAPI(context, "${NewProfileData?.object?.userUid}");

            BlocProvider.of<NewProfileSCubit>(context)
                .GetSavePostAPI(context, "${NewProfileData?.object?.userUid}");

            BlocProvider.of<NewProfileSCubit>(context).GetPostCommetAPI(
                context, "${NewProfileData?.object?.userUid}", "desc");
            savedataFuntion(NewProfileData?.object?.userUid ?? '');

            NewProfileData?.object?.industryTypes?.forEach((element) {
              // industryTypesArray.add("${element.industryTypeName}");

              if (industryTypesArray == "") {
                industryTypesArray =
                    "${industryTypesArray}${element.industryTypeName}";
              } else {
                industryTypesArray =
                    "${industryTypesArray}, ${element.industryTypeName}";
              }
            });

            NewProfileData?.object?.expertise?.forEach((element) {
              if (ExpertiseData == "") {
                ExpertiseData = "${element.expertiseName}";
              } else {
                ExpertiseData = "${element.expertiseName}";
              }
            });

            // ExpertiseData

            CompanyName.text = "${NewProfileData?.object?.companyName}";
            jobprofileController.text = "${NewProfileData?.object?.jobProfile}";
            IndustryType.text = industryTypesArray;

            if (NewProfileData?.object?.userDocument != null) {
              dopcument = NewProfileData?.object?.documentName;
            } else {
              dopcument = 'Upload Image';
            }

            priceContrller.text = "${NewProfileData?.object?.fees}";
            Expertise.text = ExpertiseData;
            if (state.PublicRoomData.object?.workingHours != null) {
              workignStart = state.PublicRoomData.object?.workingHours
                  .toString()
                  .split(" to ")
                  .first;

              start = workignStart?.split(' ')[0];
              startAm = workignStart?.split(' ')[1];
              workignend = state.PublicRoomData.object?.workingHours
                  .toString()
                  .split(" to ")
                  .last;
              end = workignend?.split(' ')[0];
              endAm = workignend?.split(' ')[1];
            }
            if (NewProfileData?.object?.isBlock == true) {
              Blockuser = false;
            } else {
              Blockuser = true;
            }
          }
          if (state is GetAppPostByUserLoadedState) {
            videoUrls.clear();
            print(state.GetAllPost);
            GetAllPostData = state.GetAllPost;
            UserProfilePostCount = GetAllPostData?.object?.length ?? 0;

            if (UserProfilePostCount.isOdd) {
              UserProfilePostCount = UserProfilePostCount + 1;
              var PostCount = UserProfilePostCount / 2;
              var aa = "${PostCount}";
              print(
                  "PostCountPostCountPostCountPostCountPostCountPostCountPostCountPostCountPostCount : 1 :- ${PostCount}  :::::- ${UserProfilePostCount}");
              print("sadasdsadasdsadasdsadasdsadasdsadasd : ------> ${aa}");

              int? y = int.parse(aa.split('.')[0]);
              print("sadasdsadasdsadasdsadasdsadasdsadasd : ------> ${y}");
              FinalPostCount = y;
              UserProfilePostCount = UserProfilePostCount - 1;
              print(
                  "sadasdsadasdsadasdsadasdsadasdsadasd : ------> ${FinalPostCount}");
            } else {
              print(UserProfilePostCount);
              var PostCount = UserProfilePostCount / 2;
              print(
                  "PostCountPostCountPostCountPostCountPostCountPostCountPostCountPostCountPostCount : 2 :- ${PostCount}  :::::- ${UserProfilePostCount}");
              var aa = "${PostCount}";
              print("sadasdsadasdsadasdsadasdsadasdsadasd : ------> ${aa}");

              int? y = int.parse(aa.split('.')[0]);
              print("sadasdsadasdsadasdsadasdsadasdsadasd : ------> ${y}");

              FinalPostCount = y;
              print(
                  "sadasdsadasdsadasdsadasdsadasdsadasd : ------> ${FinalPostCount}");
            }

            GetAllPostData?.object?.forEach((element) {
              if (element.postDataType == 'VIDEO') {
                if (element.postData?.isNotEmpty == true) {
                  videoUrls.add(element.postData?.first ?? '');
                }
              } else if (element.repostOn?.postDataType == 'VIDEO') {
                videoUrls.add(element.repostOn?.postData?.first ?? '');
              } else {
                videoUrls.add('');
              }
            });
          }
          if (state is GetUserPostCommetLoadedState) {
            print(
                "Get Comment Get Comment Get Comment Get Comment Get Comment Get Comment Get Comment ");
            print(state.GetUserPostCommet);
            GetUserPostCommetData = state.GetUserPostCommet;
            CommentsPostCount = GetUserPostCommetData?.object?.length ?? 0;
            isDataGetValue = true;
          }
          if (state is GetSavePostLoadedState) {
            GetSavePostData = state.GetSavePost;
            SavePostCount = GetSavePostData?.object?.length ?? 0;
            if (SavePostCount.isOdd) {
              SavePostCount = SavePostCount + 1;
              var PostCount = SavePostCount / 2;
              var aa = "${PostCount}";
              int? y = int.parse(aa.split('.')[0]);
              FinalSavePostCount = y;
              SavePostCount = SavePostCount - 1;
            } else {
              var PostCount = SavePostCount / 2;
              var aa = "${PostCount}";
              int? y = int.parse(aa.split('.')[0]);
              FinalSavePostCount = y;
            }
          }
          if (state is AboutMeLoadedState) {
            isAbourtMe = true;
            isUpDate = false;
            print("dfgsfgdsfg-${isAbourtMe}");
            SnackBar snackBar = SnackBar(
              content: Text('Saved Successfully'),
              backgroundColor: ColorConstant.primary_color,
            );
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          }
          if (state is PostLikeLoadedState) {
            widget.ProfileNotification == true
                ? BlocProvider.of<NewProfileSCubit>(context)
                    .NewProfileSAPI(context, widget.User_ID, true)
                : BlocProvider.of<NewProfileSCubit>(context)
                    .NewProfileSAPI(context, widget.User_ID, false);
            if (state.likePost.object != 'Post Liked Successfully' &&
                state.likePost.object != 'Post Unliked Successfully') {
              SnackBar snackBar = SnackBar(
                content: Text(state.likePost.object.toString()),
                backgroundColor: ColorConstant.primary_color,
              );
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            }
          }
          if (state is GetWorkExpereinceLoadedState) {
            addWorkExperienceModel = state.addWorkExperienceModel;
          }
          if (state is UserTagLoadedState) {
            userTagModel = state.userTagModel;
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return ProfileScreen(
                  User_ID: "${state.userTagModel.object}", isFollowing: "");
            }));

            // print("tagName -- ${tagName}");
            print("user id -- ${state.userTagModel..object}");
          }
          if (state is SearchHistoryDataAddxtends) {
            searchUserForInbox1 = state.searchUserForInbox;

            /*  isTagData = true;
              isHeshTegData = false; */
            searchUserForInbox1?.object?.content?.forEach((element) {
              Map<String, dynamic> dataSetup = {
                'id': element.userUid,
                'display': element.userName,
                'photo': element.userProfilePic,
              };

              tageData.add(dataSetup);
              List<Map<String, dynamic>> uniqueTageData = [];
              Set<String> encounteredIds = Set<String>();
              for (Map<String, dynamic> data in tageData) {
                if (!encounteredIds.contains(data['id'])) {
                  // If the ID hasn't been encountered, add to the result list
                  uniqueTageData.add(data);

                  // Mark the ID as encountered
                  encounteredIds.add(data['id']);
                }
                tageData = uniqueTageData;
              }
              if (tageData.isNotEmpty == true) {
                istageData = true;
              }
            });
          }

          if (state is GetAllHashtagState) {
            getAllHashtag = state.getAllHashtag;

            for (int i = 0;
                i < (getAllHashtag?.object?.content?.length ?? 0);
                i++) {
              // getAllHashtag?.object?.content?[i].split('#').last;
              Map<String, dynamic> dataSetup = {
                'id': '${i}',
                'display':
                    '${getAllHashtag?.object?.content?[i].split('#').last}',
                'style': TextStyle(color: Colors.blue)
              };
              heshTageData.add(dataSetup);
              if (heshTageData.isNotEmpty == true) {
                isHeshTegData = true;
              }
              print("check heshTageData -$heshTageData");
            }
          }
          if (state is DeletePostLoadedState) {
            SnackBar snackBar = SnackBar(
              content: Text(state.DeletePost.object.toString()),
              backgroundColor: ColorConstant.primary_color,
            );
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
            BlocProvider.of<NewProfileSCubit>(context)
                .GetAppPostAPI(context, "${NewProfileData?.object?.userUid}");
          }
          if (state is Getallcompenypagelodedstate) {
            getallcompenypagemodel = state.getallcompenypagemodel;
            userCompanyPageUid = getallcompenypagemodel?.object?.content
                ?.firstWhere((element) => element.isSwitched == true)
                .userCompanyPageUid;
            print("userCompanyPageUiduserCompanyPageUid-${userCompanyPageUid}");
          }
        }, builder: (context, state) {
          return DefaultTabController(
              length: 4,
              child: isDataGet == false
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
                  : CustomScrollView(
                      controller: _scrollController,
                      slivers: <Widget>[
                        SliverAppBar(
                          toolbarHeight: _height / 10,
                          backgroundColor: Colors.transparent,
                          leading: SizedBox(),
                          expandedHeight: _height / 3,
                          floating: false,
                          pinned: false,
                          snap: false,
                          stretch: true,
                          elevation: 0,
                          flexibleSpace: LayoutBuilder(
                            builder: (BuildContext context,
                                BoxConstraints constraints) {
                              return FlexibleSpaceBar(
                                centerTitle: true,
                                expandedTitleScale: 1,
                                title: Container(
                                  height: _height / 2.5,
                                  // width: _width,
                                  child: Stack(
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          if (NewProfileData
                                                      ?.object
                                                      ?.userBackgroundPic
                                                      ?.isNotEmpty ==
                                                  true &&
                                              NewProfileData?.object
                                                      ?.userBackgroundPic !=
                                                  '') {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      ProfileandDocumentScreen(
                                                    path: NewProfileData?.object
                                                        ?.userBackgroundPic,
                                                    title: "",
                                                  ),
                                                ));
                                          } else {
                                            Navigator.of(context).push(
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        ProfileandDocumentScreen(
                                                          path:
                                                              'https://inpackaging-images.s3.ap-south-1.amazonaws.com/misc/InPackaging_Logo.png',
                                                          title: '',
                                                        )));
                                          }
                                        },
                                        child: Container(
                                          color: Colors.white,
                                          height: _height / 3.4,
                                          width: _width,
                                          child: NewProfileData?.object
                                                          ?.userBackgroundPic ==
                                                      null ||
                                                  NewProfileData?.object
                                                          ?.userBackgroundPic ==
                                                      ''
                                              ? Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: CustomImageView(
                                                    svgPath: ImageConstant
                                                        .splashImage,
                                                    /* fit: BoxFit.fill, */
                                                    radius: BorderRadius.only(
                                                        bottomRight:
                                                            Radius.circular(20),
                                                        bottomLeft:
                                                            Radius.circular(
                                                                20)),
                                                  ),
                                                )
                                              : CustomImageView(
                                                  url:
                                                      "${NewProfileData?.object?.userBackgroundPic}",
                                                  fit: BoxFit.cover,
                                                  radius: BorderRadius.only(
                                                      bottomRight:
                                                          Radius.circular(20),
                                                      bottomLeft:
                                                          Radius.circular(20))
                                                  // BorderRadius.circular(25),
                                                  ),
                                        ),
                                      ),
                                      _isScrolledUp == false
                                          ? Padding(
                                              padding: EdgeInsets.only(
                                                  top: 55, left: 16),
                                              child: GestureDetector(
                                                onTap: () {
                                                  if (widget
                                                          .Screen?.isNotEmpty ==
                                                      true) {
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                          builder: (context) =>
                                                              NewBottomBar(
                                                                  buttomIndex:
                                                                      0),
                                                        ));
                                                  } else {
                                                    Navigator.pop(context);
                                                  }
                                                },
                                                child: Container(
                                                  height: 30,
                                                  width: 30,
                                                  color: Color.fromRGBO(
                                                      255, 255, 255, 0.3),
                                                  child: Center(
                                                    child: Image.asset(
                                                      ImageConstant.backArrow,
                                                      fit: BoxFit.fill,
                                                      height: 25,
                                                      width: 25,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            )
                                          : SizedBox(),
                                      Align(
                                        alignment: Alignment.bottomCenter,
                                        child: Stack(
                                          children: [
                                            GestureDetector(
                                              onTap: () {
                                                print("frgfgdfggdfgdfhghfdgh");
                                                if (NewProfileData
                                                            ?.object
                                                            ?.userProfilePic
                                                            ?.isNotEmpty ==
                                                        true &&
                                                    NewProfileData?.object
                                                            ?.userProfilePic !=
                                                        '') {
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: (context) =>
                                                            ProfileandDocumentScreen(
                                                          path: NewProfileData
                                                              ?.object
                                                              ?.userProfilePic,
                                                          title: "",
                                                        ),
                                                      ));
                                                } else {
                                                  Navigator.of(context)
                                                      .push(MaterialPageRoute(
                                                    builder: (context) =>
                                                        /* ProfileandDocumentScreen(
                                                                    path:
                                                                        'https://inpackaging-images.s3.ap-south-1.amazonaws.com/misc/InPackaging_Logo.png',
                                                                    title: '',
                                                                  ) */

                                                        ProfilePage(
                                                      image: ImageConstant
                                                          .tomcruse,
                                                    ),
                                                  ));
                                                }
                                              },
                                              child: Container(
                                                height: 150,
                                                width: 150,
                                                decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    color: Colors.white),
                                                child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            4.0),
                                                    child: NewProfileData
                                                                    ?.object
                                                                    ?.userProfilePic ==
                                                                null ||
                                                            NewProfileData
                                                                    ?.object
                                                                    ?.userProfilePic ==
                                                                ''
                                                        ? CircleAvatar(
                                                            backgroundColor:
                                                                Colors.white,
                                                            backgroundImage:
                                                                AssetImage(
                                                              ImageConstant
                                                                  .tomcruse,
                                                            ),
                                                            radius: 25,
                                                          )
                                                        /* CustomImageView(
                                                          imagePath: ImageConstant
                                                              .tomcruse,
                                                               
                                                          radius:
                                                              BorderRadius.all(
                                                            Radius.circular(20),
                                                          ),
                                                        ) */
                                                        : CircleAvatar(
                                                            backgroundColor:
                                                                Colors.white,
                                                            backgroundImage:
                                                                NetworkImage(
                                                                    "${NewProfileData?.object?.userProfilePic}"),
                                                            radius: 25,
                                                          )),
                                              ),
                                            ),
                                            if (getallcompenypagemodel?.object
                                                        ?.content?.isNotEmpty ==
                                                    true &&
                                                getallcompenypagemodel?.object
                                                        ?.content?.length !=
                                                    1 &&
                                                soicalData == true)
                                              Positioned(
                                                bottom: 5,
                                                right: -0,
                                                child: GestureDetector(
                                                  onTap: () {
                                                    showProfileSwitchBottomSheet(
                                                        context,
                                                        getallcompenypagemodel!,
                                                        '${User_ID}');
                                                    /* _showPopupMenuSwitchAccount(
                                                          details.globalPosition,
                                                          context,
                                                        ); */
                                                  },
                                                  child: Container(
                                                      height: 40,
                                                      width: 40,
                                                      decoration: BoxDecoration(
                                                          shape:
                                                              BoxShape.circle,
                                                          color: ColorConstant
                                                              .primaryLight_color),
                                                      child: Center(
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: Image.asset(
                                                            ImageConstant
                                                                .switchAccount,
                                                            color: ColorConstant
                                                                .primary_color,
                                                          ),
                                                        ),
                                                      )),
                                                ),
                                              )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        SliverToBoxAdapter(
                          child: Column(
                            children: [
                              User_Module == "EMPLOYEE" &&
                                      NewProfileData?.object?.approvalStatus ==
                                          "PARTIALLY_REGISTERED"
                                  ? Padding(
                                      padding: const EdgeInsets.only(top: 15),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Flexible(
                                            child: Container(
                                              height: 30,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                                color: Color(0xffD5EED5),
                                              ),
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 15, right: 15),
                                                child: Row(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    Container(
                                                        height: 10,
                                                        width: 10,
                                                        decoration:
                                                            BoxDecoration(
                                                          shape:
                                                              BoxShape.circle,
                                                          color:
                                                              Color(0xff019801),
                                                        )),
                                                    SizedBox(
                                                      width: 10,
                                                    ),
                                                    Text(
                                                      "Profile APPROVED",
                                                      style: TextStyle(
                                                          fontSize: 15,
                                                          fontWeight:
                                                              FontWeight.w600),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  : User_ID == NewProfileData?.object?.userUid
                                      ? Padding(
                                          padding: EdgeInsets.only(
                                              top: User_CompnyPageModule == null
                                                  ? 15
                                                  : 0),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              if (User_CompnyPageModule == null)
                                                Flexible(
                                                  child: Container(
                                                    height: 30,
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20),
                                                      color: NewProfileData
                                                                  ?.object
                                                                  ?.approvalStatus ==
                                                              "PARTIALLY_REGISTERED"
                                                          ? Color(0xffB6D9EC)
                                                          : NewProfileData
                                                                      ?.object
                                                                      ?.approvalStatus ==
                                                                  "PENDING"
                                                              ? Color(
                                                                  0xffFFDBA8)
                                                              : NewProfileData
                                                                          ?.object
                                                                          ?.approvalStatus ==
                                                                      "APPROVED"
                                                                  ? Color(
                                                                      0xffD5EED5)
                                                                  : Color(
                                                                      0xffFFE0E1),
                                                    ),
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 15,
                                                              right: 15),
                                                      child: Row(
                                                        mainAxisSize:
                                                            MainAxisSize.min,
                                                        children: [
                                                          Container(
                                                            height: 10,
                                                            width: 10,
                                                            decoration: BoxDecoration(
                                                                shape: BoxShape.circle,
                                                                color: NewProfileData?.object?.approvalStatus == "PARTIALLY_REGISTERED"
                                                                    ? Color(0xff1A94D7)
                                                                    : NewProfileData?.object?.approvalStatus == "PENDING"
                                                                        ? Color(0xffC28432)
                                                                        : NewProfileData?.object?.approvalStatus == "APPROVED"
                                                                            ? Color(0xff019801)
                                                                            : Color(0xffFF000B)),
                                                          ),
                                                          SizedBox(
                                                            width: 10,
                                                          ),
                                                          Text(
                                                            "Profile ${NewProfileData?.object?.approvalStatus}",
                                                            style: TextStyle(
                                                                color: NewProfileData
                                                                            ?.object
                                                                            ?.approvalStatus ==
                                                                        "PARTIALLY_REGISTERED"
                                                                    ? Color(
                                                                        0xff1A94D7)
                                                                    : NewProfileData?.object?.approvalStatus ==
                                                                            "PENDING"
                                                                        ? Color(
                                                                            0xffC28432)
                                                                        : NewProfileData?.object?.approvalStatus ==
                                                                                "APPROVED"
                                                                            ? Color(
                                                                                0xff019801)
                                                                            : Color(
                                                                                0xffFF000B),
                                                                fontSize: 15,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600),
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                            ],
                                          ),
                                        )
                                      : SizedBox(),
                              Padding(
                                padding: EdgeInsets.only(
                                    top:
                                        User_CompnyPageModule == null ? 20 : 0),
                                child: Center(
                                  child: Text(
                                    '${User_CompnyPageModule == null ? NewProfileData?.object?.name : NewProfileData?.object?.companyName}',
                                    style: TextStyle(
                                        fontSize: 26,
                                        fontFamily: "outfit",
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      left: 0,
                                    ),
                                    child: Text(
                                      User_CompnyPageModule == null
                                          ? '@${NewProfileData?.object?.userName}'
                                          : '${NewProfileData?.object?.companyPageType}',
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontFamily: "outfit",
                                          fontWeight: FontWeight.bold,
                                          color: Color(0xff444444)),
                                    ),
                                  ),
                                  NewProfileData?.object?.approvalStatus ==
                                              'PENDING' ||
                                          NewProfileData
                                                  ?.object?.approvalStatus ==
                                              'REJECTED'
                                      ? SizedBox()
                                      : NewProfileData?.object?.module ==
                                              "EXPERT"
                                          ? Padding(
                                              padding: const EdgeInsets.only(
                                                  bottom: 4, left: 3),
                                              child: Image.asset(
                                                ImageConstant.Star,
                                                height: 18,
                                              ),
                                            )
                                          : SizedBox()
                                ],
                              ),

                              SizedBox(
                                height: 10,
                              ),
                              User_ID == widget.User_ID
                                  ? Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            /* Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          ShowProfileScreen(),
                                                    )); */
                                            Navigator.push(context,
                                                MaterialPageRoute(
                                                    builder: (context) {
                                              return MultiBlocProvider(
                                                  providers: [
                                                    BlocProvider<
                                                        MyAccountCubit>(
                                                      create: (context) =>
                                                          MyAccountCubit(),
                                                    ),
                                                  ],
                                                  child: EditProfileScreen(
                                                    newProfileData:
                                                        NewProfileData,
                                                  ));
                                            })).then((value) => widget
                                                        .ProfileNotification ==
                                                    true
                                                ? BlocProvider.of<NewProfileSCubit>(context)
                                                    .NewProfileSAPI(context,
                                                        widget.User_ID, true)
                                                : BlocProvider.of<NewProfileSCubit>(context)
                                                    .NewProfileSAPI(context,
                                                        widget.User_ID, false));
                                          },
                                          child: Container(
                                            alignment: Alignment.center,
                                            height: 45,
                                            width: _width / 2.6,
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                border: Border.all(
                                                  color: ColorConstant
                                                      .primary_color,
                                                )),
                                            child: Text(
                                              'View Profile',
                                              maxLines: 1,
                                              style: TextStyle(
                                                  fontFamily: "outfit",
                                                  fontSize: 18,
                                                  color: ColorConstant
                                                      .primary_color,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        SettingScreen(
                                                          accountType:
                                                              NewProfileData
                                                                      ?.object
                                                                      ?.accountType ??
                                                                  '',
                                                          module: NewProfileData?.object?.module == 'COMPANY' &&
                                                                  NewProfileData
                                                                          ?.object
                                                                          ?.approvalStatus !=
                                                                      "PENDING" &&
                                                                  NewProfileData
                                                                          ?.object
                                                                          ?.approvalStatus !=
                                                                      "REJECTED"
                                                              ? true
                                                              : false,
                                                          userCompanyPageUid:
                                                              userCompanyPageUid,
                                                        ))).then((value) {
                                              widget.ProfileNotification == true
                                                  ? BlocProvider.of<
                                                              NewProfileSCubit>(
                                                          context)
                                                      .NewProfileSAPI(context,
                                                          widget.User_ID, true)
                                                  : BlocProvider.of<
                                                              NewProfileSCubit>(
                                                          context)
                                                      .NewProfileSAPI(
                                                          context,
                                                          widget.User_ID,
                                                          false);
                                              BlocProvider.of<NewProfileSCubit>(
                                                      context)
                                                  .getallcompenypagee(context);
                                            });
                                          },
                                          child: Container(
                                            margin: EdgeInsets.only(left: 10),
                                            height: 45,
                                            width: 50,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              color:
                                                  ColorConstant.primary_color,
                                            ),
                                            child: Icon(
                                              Icons.settings,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ],
                                    )
                                  : Row(
                                      children: [
                                        Spacer(),
                                        widget.isFollowing == true
                                            ? Container(
                                                alignment: Alignment.center,
                                                height: 45,
                                                width: _width / 3,
                                                decoration: BoxDecoration(
                                                  color: ColorConstant
                                                      .primary_color,
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                                child: Text(
                                                  'Following',
                                                  style: TextStyle(
                                                      fontFamily: "outfit",
                                                      fontSize: 18,
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ),
                                              )
                                            : NewProfileData?.object?.isBlock ==
                                                    true
                                                ? GestureDetector(
                                                    /* key: blockKey,
                                                onTap: () {
                                                  showPopupMenuBlock(
                                                      context,
                                                      NewProfileData
                                                          ?.object?.userUid,
                                                      NewProfileData
                                                          ?.object?.name,
                                                      blockKey);
                                                }, */

                                                    child: Container(
                                                      alignment:
                                                          Alignment.center,
                                                      height: 45,
                                                      width: _width / 3,
                                                      decoration: BoxDecoration(
                                                        color: ColorConstant
                                                            .primary_color,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                      ),
                                                      child: Text(
                                                        'Unblock',
                                                        style: TextStyle(
                                                            fontFamily:
                                                                "outfit",
                                                            fontSize: 18,
                                                            color: Colors.white,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500),
                                                      ),
                                                    ),
                                                  )
                                                : GestureDetector(
                                                    onTap: () {
                                                      BlocProvider.of<
                                                                  NewProfileSCubit>(
                                                              context)
                                                          .followWIngMethod(
                                                              NewProfileData
                                                                  ?.object
                                                                  ?.userUid
                                                                  .toString(),
                                                              context);
                                                      // print(${name[0].toUpperCase()}${name.substring(1).toLowerCase()});
                                                    },
                                                    child: Container(
                                                      alignment:
                                                          Alignment.center,
                                                      height: 45,
                                                      width: _width / 3,
                                                      decoration: BoxDecoration(
                                                        color: ColorConstant
                                                            .primary_color,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                      ),
                                                      child: Text(
                                                        '${NewProfileData?.object?.isFollowing?.toString()[0].toUpperCase()}${NewProfileData?.object?.isFollowing?.toString().substring(1).toLowerCase()}',
                                                        style: TextStyle(
                                                            fontFamily:
                                                                "outfit",
                                                            fontSize: 18,
                                                            color: Colors.white,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500),
                                                      ),
                                                    ),
                                                  ),
                                        NewProfileData?.object?.isFollowing ==
                                                    "FOLLOWING" ||
                                                NewProfileData
                                                        ?.object?.accountType ==
                                                    "PUBLIC"
                                            ? Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 10),
                                                child: GestureDetector(
                                                  onTap: () {
                                                    BlocProvider.of<
                                                                NewProfileSCubit>(
                                                            context)
                                                        .DMChatListm(
                                                            "${NewProfileData?.object?.userUid}",
                                                            context);
                                                  },
                                                  child: Container(
                                                    height: 40,
                                                    width: 40,
                                                    decoration: BoxDecoration(
                                                      color: ColorConstant
                                                          .primary_color,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                    ),
                                                    child: Center(
                                                      child: CustomImageView(
                                                          height: 20,
                                                          width: 20,
                                                          imagePath:
                                                              ImageConstant
                                                                  .chat),
                                                    ),
                                                  ),
                                                ),
                                              )
                                            : SizedBox(),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 10),
                                          child: GestureDetector(
                                            key: blockKey,
                                            onTap: () {
                                              showPopupMenuBlock(
                                                  context,
                                                  NewProfileData
                                                      ?.object?.userUid,
                                                  NewProfileData?.object?.name,
                                                  blockKey);
                                            },
                                            child: Container(
                                              /*  */ height: 40,
                                              width: 40,
                                              decoration: BoxDecoration(
                                                color:
                                                    ColorConstant.primary_color,
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                              child: Center(
                                                child: Icon(
                                                  Icons.more_vert_rounded,
                                                  color: Colors.white,
                                                ), /* CustomImageView(
                                                            height: 20,
                                                            width: 20,
                                                            imagePath:
                                                                ImageConstant.chat) */
                                              ),
                                            ),
                                          ),
                                        ),
                                        Spacer(),
                                      ],
                                    ),

                              SizedBox(
                                height: 12,
                              ),

                              Center(
                                child: Container(
                                  key: key,
                                  margin: EdgeInsets.only(left: 15, right: 15),
                                  height: 80,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(
                                        color: Color(0xffD2D2D2),
                                      )),
                                  child: Row(
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          super.setState(() {
                                            updateType();
                                            arrNotiyTypeList[1].isSelected =
                                                true;
                                          });
                                        },
                                        child: Container(
                                          width: _width / 3.3,
                                          color: Colors.transparent,
                                          child: Column(
                                            children: [
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Text(
                                                NewProfileData
                                                            ?.object?.isBlock ==
                                                        true
                                                    ? "0"
                                                    : '${NewProfileData?.object?.postCount}',
                                                style: TextStyle(
                                                    fontFamily: "outfit",
                                                    fontSize: 25,
                                                    color: Color(0xff000000),
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              Text(
                                                'Post',
                                                style: TextStyle(
                                                    fontFamily: "outfit",
                                                    fontSize: 16,
                                                    color: Color(0xff444444),
                                                    fontWeight:
                                                        FontWeight.w500),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            top: 20, bottom: 20),
                                        child: VerticalDivider(
                                          thickness: 1.5,
                                          color: Color(0xffC2C2C2),
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          if (NewProfileData
                                                      ?.object?.isFollowing ==
                                                  'FOLLOWING' ||
                                              User_ID ==
                                                  NewProfileData
                                                      ?.object?.userUid) {
                                            if (followersClassModel1
                                                    ?.object?.isNotEmpty ==
                                                true) {
                                              //this is i want this
                                              Navigator.push(context,
                                                  MaterialPageRoute(
                                                      builder: (context) {
                                                return MultiBlocProvider(
                                                  providers: [
                                                    BlocProvider<FollowerBlock>(
                                                      create: (context) =>
                                                          FollowerBlock(),
                                                    ),
                                                  ],
                                                  child: Followers(
                                                    User_ID: widget.User_ID,
                                                    appBarName: 'Followers',
                                                    userId: widget.User_ID,
                                                    userCompanyPageUid:
                                                        userCompanyPageUid,
                                                  ),
                                                );
                                              })).then((value) {
                                                widget.ProfileNotification ==
                                                        true
                                                    ? BlocProvider.of<
                                                                NewProfileSCubit>(
                                                            context)
                                                        .NewProfileSAPI(
                                                            context,
                                                            widget.User_ID,
                                                            true)
                                                    : BlocProvider.of<
                                                                NewProfileSCubit>(
                                                            context)
                                                        .NewProfileSAPI(
                                                            context,
                                                            widget.User_ID,
                                                            false);
                                                BlocProvider.of<
                                                            NewProfileSCubit>(
                                                        context)
                                                    .getFollwerApi(context,
                                                        widget.User_ID);
                                              });
                                              /*    Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        Followers(
                                                          // OLLOWERS
                                                          appBarName: 'Followers',
                                                          followersClassModel:
                                                              followersClassModel1!,
                                                          userId: widget.User_ID,
                                                        ))).then((value) =>
                                                BlocProvider.of<NewProfileSCubit>(
                                                        context)
                                                    .NewProfileSAPI(
                                                        context, widget.User_ID)); */
                                            }
                                          } else {
                                            if (NewProfileData
                                                        ?.object?.accountType ==
                                                    'PUBLIC' &&
                                                NewProfileData
                                                        ?.object?.isFollowing ==
                                                    'FOLLOW') {
                                              Navigator.push(context,
                                                  MaterialPageRoute(
                                                      builder: (context) {
                                                return MultiBlocProvider(
                                                  providers: [
                                                    BlocProvider<FollowerBlock>(
                                                      create: (context) =>
                                                          FollowerBlock(),
                                                    ),
                                                  ],
                                                  child: Followers(
                                                    User_ID: widget.User_ID,
                                                    appBarName: 'Followers',
                                                    userId: widget.User_ID,
                                                  ),
                                                );
                                              })).then((value) {
                                                widget.ProfileNotification ==
                                                        true
                                                    ? BlocProvider.of<
                                                                NewProfileSCubit>(
                                                            context)
                                                        .NewProfileSAPI(
                                                            context,
                                                            widget.User_ID,
                                                            true)
                                                    : BlocProvider.of<
                                                                NewProfileSCubit>(
                                                            context)
                                                        .NewProfileSAPI(
                                                            context,
                                                            widget.User_ID,
                                                            false);
                                                BlocProvider.of<
                                                            NewProfileSCubit>(
                                                        context)
                                                    .getFollwerApi(context,
                                                        widget.User_ID);
                                              });
                                            }
                                          }
                                        },
                                        child: Container(
                                          color: Colors.transparent,
                                          width: _width / 3.6,
                                          child: Column(
                                            children: [
                                              SizedBox(
                                                height: 11,
                                              ),
                                              Text(
                                                NewProfileData
                                                            ?.object?.isBlock ==
                                                        true
                                                    ? "0"
                                                    : '${NewProfileData?.object?.followersCount}',
                                                style: TextStyle(
                                                    fontFamily: "outfit",
                                                    fontSize: 25,
                                                    color: Color(0xff000000),
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              Text(
                                                'Followers',
                                                style: TextStyle(
                                                    fontFamily: "outfit",
                                                    fontSize: 16,
                                                    color: Color(0xff444444),
                                                    fontWeight:
                                                        FontWeight.w500),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            top: 20, bottom: 20),
                                        child: VerticalDivider(
                                          thickness: 1.5,
                                          color: Color(0xffC2C2C2),
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          if (NewProfileData
                                                      ?.object?.isFollowing ==
                                                  'FOLLOWING' ||
                                              User_ID ==
                                                  NewProfileData
                                                      ?.object?.userUid) {
                                            if (followersClassModel2
                                                    ?.object?.isNotEmpty ==
                                                true) {
                                              Navigator.push(context,
                                                  MaterialPageRoute(
                                                      builder: (context) {
                                                return MultiBlocProvider(
                                                  providers: [
                                                    BlocProvider<FollowerBlock>(
                                                      create: (context) =>
                                                          FollowerBlock(),
                                                    ),
                                                  ],
                                                  child: Followers(
                                                    User_ID: widget.User_ID,
                                                    appBarName: 'Following',
                                                    userId: widget.User_ID,
                                                  ),
                                                );
                                              })).then((value) => widget
                                                          .ProfileNotification ==
                                                      true
                                                  ? BlocProvider.of<NewProfileSCubit>(context)
                                                      .NewProfileSAPI(context,
                                                          widget.User_ID, true)
                                                  : BlocProvider.of<NewProfileSCubit>(context)
                                                      .NewProfileSAPI(
                                                          context,
                                                          widget.User_ID,
                                                          false));
                                            }
                                          } else {
                                            if (NewProfileData
                                                        ?.object?.accountType ==
                                                    'PUBLIC' &&
                                                NewProfileData
                                                        ?.object?.isFollowing ==
                                                    'FOLLOW') {
                                              Navigator.push(context,
                                                  MaterialPageRoute(
                                                      builder: (context) {
                                                return MultiBlocProvider(
                                                  providers: [
                                                    BlocProvider<FollowerBlock>(
                                                      create: (context) =>
                                                          FollowerBlock(),
                                                    ),
                                                  ],
                                                  child: Followers(
                                                    User_ID: widget.User_ID,
                                                    appBarName: 'Following',
                                                    userId: widget.User_ID,
                                                  ),
                                                );
                                              })).then((value) => widget
                                                          .ProfileNotification ==
                                                      true
                                                  ? BlocProvider.of<NewProfileSCubit>(context)
                                                      .NewProfileSAPI(context,
                                                          widget.User_ID, true)
                                                  : BlocProvider.of<NewProfileSCubit>(context)
                                                      .NewProfileSAPI(
                                                          context,
                                                          widget.User_ID,
                                                          false));
                                            }
                                          }
                                        },
                                        child: Container(
                                          // color: Colors.amber,
                                          width: _width / 4.4,
                                          child: Column(
                                            children: [
                                              SizedBox(
                                                height: 11,
                                              ),
                                              Text(
                                                NewProfileData
                                                            ?.object?.isBlock ==
                                                        true
                                                    ? "0"
                                                    : '${NewProfileData?.object?.followingCount}',
                                                style: TextStyle(
                                                    fontFamily: "outfit",
                                                    fontSize: 25,
                                                    color: Color(0xff000000),
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              Text(
                                                'Following',
                                                style: TextStyle(
                                                    fontFamily: "outfit",
                                                    fontSize: 16,
                                                    color: Color(0xff444444),
                                                    fontWeight:
                                                        FontWeight.w500),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              // SizedBox(
                              //   height: 50,
                              // child: TabBar(
                              //     indicatorColor: Colors.black,
                              //     unselectedLabelColor: Color(0xff444444),
                              //     labelColor: Color(0xff000000),
                              //     controller: _tabController,
                              //     tabs: List.generate(
                              //         tabData.length,
                              //         (index) => Tab(
                              //                 child: Text(
                              //               tabData[index].toString(),
                              //               style: TextStyle(
                              //                 fontWeight: FontWeight.bold,
                              //                 fontFamily: "outfit",
                              //                 fontSize: 14,
                              //               ),
                              //             )))),
                              // ),
                              SizedBox(
                                height: 30,
                              ),
                              /* NewProfileData?.object?.isFollowing == 'FOLLOWING' ||
                            User_ID == NewProfileData?.object?.userUid || NewProfileData?.object?.accountType == 'PUBLIC' */

                              /*  if (User_ID == NewProfileData?.object?.userUid ||
                                (NewProfileData?.object?.isFollowing ==
                                        'FOLLOWING' &&
                                    (NewProfileData?.object?.accountType ==
                                            'PRIVATE' ||
                                        NewProfileData?.object?.accountType ==
                                            'PUBLIC'))) */

                              /* if (User_ID == NewProfileData?.object?.userUid ||
                                (NewProfileData?.object?.accountType == 'PUBLIC') ||
                                (NewProfileData?.object?.isFollowing ==
                                        'FOLLOWING' &&
                                    NewProfileData?.object?.accountType ==
                                        'PRIVATE')) */
                              NewProfileData?.object?.isBlock == true
                                  ? SizedBox()
                                  : Container(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Expanded(
                                            child: GestureDetector(
                                              child: Column(
                                                children: [
                                                  Container(
                                                    height: 40,
                                                    // color: arrNotiyTypeList[0].isSelected
                                                    //     ? ColorConstant.primary_color
                                                    //     : Theme.of(context).brightness == Brightness.light
                                                    //         ? Colors.white
                                                    //         : Colors.black,
                                                    child: Center(
                                                      child: Column(
                                                        children: [
                                                          Row(
                                                            children: [
                                                              const Spacer(),
                                                              Text("Details",
                                                                  textScaleFactor:
                                                                      1.0,
                                                                  style: TextStyle(
                                                                      // color: arrNotiyTypeList[3].isSelected
                                                                      //     ? Colors.white
                                                                      //     : Colors.black,
                                                                      fontSize: 18,
                                                                      fontFamily: 'Outfit',
                                                                      fontWeight: FontWeight.bold)),
                                                              Spacer(),
                                                            ],
                                                          ),
                                                          arrNotiyTypeList[0]
                                                                  .isSelected
                                                              ? Divider(
                                                                  endIndent: 20,
                                                                  indent: 20,
                                                                  color: Colors
                                                                      .black,
                                                                )
                                                              : SizedBox(),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              onTap: () {
                                                super.setState(() {
                                                  updateType();
                                                  arrNotiyTypeList[0]
                                                      .isSelected = true;
                                                  selectedIndex = 0;
                                                  print("abcd");
                                                });
                                              },
                                            ),
                                          ),
                                          Expanded(
                                            child: GestureDetector(
                                              child: Column(
                                                children: [
                                                  Container(
                                                    height: 40,
                                                    // color: arrNotiyTypeList[1].isSelected
                                                    //     ? ColorConstant.primary_color
                                                    //     : Theme.of(context).brightness == Brightness.light
                                                    //         ? Colors.white
                                                    //         : Colors.black,
                                                    child: Column(
                                                      children: [
                                                        Row(
                                                          children: [
                                                            const Spacer(),
                                                            Text("Post",
                                                                textScaleFactor:
                                                                    1.0,
                                                                style: TextStyle(
                                                                    // color: arrNotiyTypeList[3].isSelected
                                                                    //     ? Colors.white
                                                                    //     : Colors.black,
                                                                    fontSize: 18,
                                                                    fontFamily: 'Outfit',
                                                                    fontWeight: FontWeight.bold)),
                                                            Spacer(),
                                                          ],
                                                        ),
                                                        arrNotiyTypeList[1]
                                                                .isSelected
                                                            ? Divider(
                                                                endIndent: 30,
                                                                indent: 30,
                                                                color: Colors
                                                                    .black,
                                                              )
                                                            : SizedBox(),
                                                      ],
                                                    ),
                                                  )
                                                ],
                                              ),
                                              onTap: () {
                                                super.setState(() {
                                                  updateType();
                                                  arrNotiyTypeList[1]
                                                      .isSelected = true;
                                                  selectedIndex = 1;
                                                  print("abcd");
                                                });
                                              },
                                            ),
                                          ),
                                          Container(
                                            height: 1,
                                            color: Colors.black12,
                                          ),
                                          Expanded(
                                            child: GestureDetector(
                                              child: Column(
                                                children: [
                                                  Container(
                                                      height: 40,
                                                      alignment:
                                                          Alignment.center,
                                                      // color: arrNotiyTypeList[2].isSelected
                                                      //     ? ColorConstant.primary_color
                                                      //     : Theme.of(context).brightness == Brightness.light
                                                      //         ? Colors.white
                                                      //         : Colors.black,
                                                      child: Center(
                                                        child: Column(
                                                          children: [
                                                            Row(
                                                              children: [
                                                                const Spacer(),
                                                                Text("Comments",
                                                                    textScaleFactor:
                                                                        1.0,
                                                                    style: TextStyle(
                                                                        // color: arrNotiyTypeList[3].isSelected
                                                                        //     ? Colors.white
                                                                        //     : Colors.black,
                                                                        fontSize: 16,
                                                                        fontFamily: 'Outfit',
                                                                        fontWeight: FontWeight.bold)),
                                                                Spacer(),
                                                              ],
                                                            ),
                                                            arrNotiyTypeList[2]
                                                                    .isSelected
                                                                ? Divider(
                                                                    endIndent:
                                                                        5,
                                                                    indent: 5,
                                                                    color: Colors
                                                                        .black,
                                                                  )
                                                                : SizedBox(),
                                                          ],
                                                        ),
                                                      )),
                                                ],
                                              ),
                                              onTap: () {
                                                super.setState(() {
                                                  updateType();
                                                  arrNotiyTypeList[2]
                                                      .isSelected = true;
                                                  selectedIndex = 2;
                                                });
                                                print("abcd");
                                              },
                                            ),
                                          ),
                                          User_ID ==
                                                  NewProfileData
                                                      ?.object?.userUid
                                              ? Expanded(
                                                  child: GestureDetector(
                                                    child: Container(
                                                        height: 40,
                                                        alignment:
                                                            Alignment.center,
                                                        // color: arrNotiyTypeList[3].isSelected
                                                        //     ? ColorConstant.primary_color
                                                        //     : Theme.of(context).brightness == Brightness.light
                                                        //         ? Colors.white
                                                        //         : Colors.black,
                                                        child: Center(
                                                          child: Column(
                                                            children: [
                                                              Row(
                                                                children: [
                                                                  const Spacer(),
                                                                  Text("Saved",
                                                                      textScaleFactor:
                                                                          1.0,
                                                                      style: TextStyle(
                                                                          // color: arrNotiyTypeList[3].isSelected
                                                                          //     ? Colors.white
                                                                          //     : Colors.black,
                                                                          fontSize: 18,
                                                                          fontFamily: 'Outfit',
                                                                          fontWeight: FontWeight.bold)),
                                                                  Spacer(),
                                                                ],
                                                              ),
                                                              arrNotiyTypeList[
                                                                          3]
                                                                      .isSelected
                                                                  ? Divider(
                                                                      endIndent:
                                                                          25,
                                                                      indent:
                                                                          25,
                                                                      color: Colors
                                                                          .black,
                                                                    )
                                                                  : SizedBox(),
                                                            ],
                                                          ),
                                                        )),
                                                    onTap: () {
                                                      super.setState(() {
                                                        updateType();
                                                        arrNotiyTypeList[3]
                                                            .isSelected = true;
                                                        selectedIndex = 3;
                                                      });
                                                      print("abcd");
                                                    },
                                                  ),
                                                )
                                              : SizedBox.shrink(),
                                        ],
                                      ),
                                    ),
                              /* if (User_ID == NewProfileData?.object?.userUid ||
                                (NewProfileData?.object?.accountType == 'PUBLIC') ||
                                (NewProfileData?.object?.isFollowing ==
                                        'FOLLOWING' &&
                                    NewProfileData?.object?.accountType ==
                                        'PRIVATE')) */

                              /* Container(
                            // color: Colors.red,
                            /*  height: _height, */
                            height: arrNotiyTypeList[0].isSelected == true
                                ? NewProfileData?.object?.module == "EMPLOYEE"
                                    ? _height / 3
                                    : NewProfileData?.object?.module == "EXPERT"
                                        ? _height / 0.65 // 630 old height
                                        : NewProfileData?.object?.module ==
                                                "COMPANY"
                                            ? _height /
                                                0.7 // 650 old height + 400
                                            : 0
                                : arrNotiyTypeList[1].isSelected == true
                                    ? FinalPostCount * 190
                                    : arrNotiyTypeList[2].isSelected == true
                                        ? CommentsPostCount * 310 + 100
                                        : arrNotiyTypeList[3].isSelected == true
                                            ? value1 == 0
                                                ? FinalSavePostCount == 0
                                                    ? 40
                                                    : FinalSavePostCount * 230
                                                : SaveBlogCount * 155 + 100
                                            : 10,
                            child: */
                              SingleChildScrollView(
                                controller: scrollController,
                                physics: NeverScrollableScrollPhysics(),
                                child: GestureDetector(
                                  onHorizontalDragUpdate: (details) {
                                    if (details.delta.dx > 0) {
                                      super.setState(() {
                                        swipLeft = false;
                                        swipeRigth = true;
                                      });
                                      print("Swiped right");
                                    } else if (details.delta.dx < 0) {
                                      super.setState(() {
                                        swipLeft = true;
                                        swipeRigth = false;
                                      });
                                      print("Swiped left");
                                    }
                                  },
                                  onHorizontalDragEnd: (details) {
                                    Scrollable.ensureVisible(
                                        key.currentContext!,
                                        duration: Duration(microseconds: 400));

                                    if (User_ID !=
                                        NewProfileData?.object?.userUid) {
                                      if (swipLeft == false &&
                                          swipeRigth == true) {
                                        if (selectedIndex != 0) {
                                          selectedIndex--;
                                          super.setState(() {
                                            updateType();
                                            arrNotiyTypeList[selectedIndex]
                                                .isSelected = true;
                                          });
                                        }
                                        print("Swiped right");
                                      } else if (swipLeft == true &&
                                          swipeRigth == false) {
                                        if (selectedIndex != 2) {
                                          selectedIndex++;
                                          super.setState(() {
                                            updateType();
                                            arrNotiyTypeList[selectedIndex]
                                                .isSelected = true;
                                          });
                                        }
                                        print("Swiped left");
                                      }
                                    } else {
                                      if (swipLeft == false &&
                                          swipeRigth == true) {
                                        if (selectedIndex != 0) {
                                          selectedIndex--;
                                          super.setState(() {
                                            updateType();
                                            arrNotiyTypeList[selectedIndex]
                                                .isSelected = true;
                                          });
                                        }
                                        print("Swiped right");
                                      } else if (swipLeft == true &&
                                          swipeRigth == false) {
                                        if (selectedIndex != 3) {
                                          selectedIndex++;
                                          super.setState(() {
                                            updateType();
                                            arrNotiyTypeList[selectedIndex]
                                                .isSelected = true;
                                          });
                                        }
                                        print("Swiped left");
                                      }
                                    }

                                    scrollController.animateTo(0.0,
                                        duration: Duration(milliseconds: 300),
                                        curve: Curves.easeOut);
                                  },
                                  child: Container(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: <Widget>[
                                        /// Content of Tab 1
                                        arrNotiyTypeList[0].isSelected
                                            ? NewProfileData?.object?.isBlock ==
                                                    true
                                                ? Column(
                                                    children: [
                                                      SizedBox(
                                                        height: 60,
                                                      ),
                                                      Center(
                                                        child: Image.asset(
                                                          ImageConstant
                                                              .nopostimage,
                                                          height: _height / 5,
                                                        ),
                                                      ),
                                                    ],
                                                  )
                                                : Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 16,
                                                            right: 16,
                                                            top: 14),
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        /* if (User_ID ==
                                                        NewProfileData
                                                            ?.object?.userUid) */
                                                        Card(
                                                            color: Colors.white,
                                                            borderOnForeground:
                                                                true,
                                                            elevation: 10,
                                                            shape:
                                                                RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          15.0),
                                                            ),
                                                            child: Column(
                                                              children: [
                                                                Padding(
                                                                  padding: const EdgeInsets
                                                                          .only(
                                                                      top: 10,
                                                                      right: 20,
                                                                      left: 20),
                                                                  child: Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .spaceBetween,
                                                                    children: [
                                                                      Text(
                                                                        'About Me',
                                                                        style:
                                                                            TextStyle(
                                                                          color:
                                                                              Colors.black,
                                                                          fontSize:
                                                                              18,
                                                                          fontWeight:
                                                                              FontWeight.w600,
                                                                        ),
                                                                      ),
                                                                      User_ID !=
                                                                              NewProfileData?.object?.userUid
                                                                          ? SizedBox.shrink()
                                                                          : GestureDetector(
                                                                              onTap: () {
                                                                                super.setState(() {
                                                                                  isUpDate = true;
                                                                                  isAbourtMe = false;
                                                                                  AbboutMeShow = false;
                                                                                });
                                                                              },
                                                                              child: isUpDate == true
                                                                                  ? GestureDetector(
                                                                                      onTap: () {
                                                                                        if (aboutMe.text.isNotEmpty) {
                                                                                          BlocProvider.of<NewProfileSCubit>(context).abboutMeApi(context, aboutMe.text);
                                                                                        } else {
                                                                                          SnackBar snackBar = SnackBar(
                                                                                            content: Text('Please Enter About Me'),
                                                                                            backgroundColor: ColorConstant.primary_color,
                                                                                          );
                                                                                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                                                                        }
                                                                                      },
                                                                                      child: Container(
                                                                                        alignment: Alignment.center,
                                                                                        height: 24,
                                                                                        width: 50,
                                                                                        decoration: BoxDecoration(
                                                                                          borderRadius: BorderRadius.circular(5),
                                                                                          color: ColorConstant.primary_color,
                                                                                        ),
                                                                                        child: Text(
                                                                                          'SAVE',
                                                                                          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                                                                                        ),
                                                                                      ),
                                                                                    )
                                                                                  : Icon(
                                                                                      Icons.edit,
                                                                                      color: Colors.black,
                                                                                    ),
                                                                            )
                                                                    ],
                                                                  ),
                                                                ),
                                                                isUpDate ==
                                                                        false
                                                                    ? Padding(
                                                                        padding: const EdgeInsets.only(
                                                                            top:
                                                                                12,
                                                                            left:
                                                                                10,
                                                                            right:
                                                                                10,
                                                                            bottom:
                                                                                15),
                                                                        child:
                                                                            Container(
                                                                          margin:
                                                                              EdgeInsets.only(left: 10),
                                                                          alignment:
                                                                              Alignment.topLeft,
                                                                          child:
                                                                              LinkifyText(
                                                                            "${aboutMe.text}",
                                                                            linkStyle:
                                                                                TextStyle(
                                                                              color: Colors.blue,
                                                                              fontFamily: 'outfit',
                                                                            ),
                                                                            textStyle:
                                                                                TextStyle(
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
                                                                            onTap:
                                                                                (link) async {
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
                                                                                    Navigator.push(
                                                                                        context,
                                                                                        MaterialPageRoute(
                                                                                          builder: (context) => HashTagViewScreen(title: "${link.value}"),
                                                                                        ));
                                                                                  } else if (link.value!.startsWith('@')) {
                                                                                    var name;
                                                                                    var tagName;
                                                                                    name = SelectedTest;
                                                                                    tagName = name.replaceAll("@", "");
                                                                                    await BlocProvider.of<NewProfileSCubit>(context).UserTagAPI(context, tagName);
                                                                                  } else {
                                                                                    launchUrl(Uri.parse("https://${link.value.toString()}"));
                                                                                  }
                                                                                }
                                                                              }
                                                                            },
                                                                          ),
                                                                        ),
                                                                      )
                                                                    : Padding(
                                                                        padding:
                                                                            const EdgeInsets.only(left: 0),
                                                                        child:
                                                                            Column(
                                                                          crossAxisAlignment:
                                                                              CrossAxisAlignment.start,
                                                                          children: [
                                                                            SizedBox(
                                                                              height: 15,
                                                                            ),

                                                                            SizedBox(
                                                                              height: 5,
                                                                            ),
                                                                            AbboutMeShow == true
                                                                                ? Padding(
                                                                                    padding: const EdgeInsets.only(left: 20, right: 20),
                                                                                    child: Container(
                                                                                      alignment: Alignment.center,
                                                                                      height: 50,
                                                                                      // width:
                                                                                      //     _width /
                                                                                      //         1.5,
                                                                                      decoration: BoxDecoration(
                                                                                          // color: Colors.amber
                                                                                          borderRadius: BorderRadius.circular(10),
                                                                                          border: Border.all(color: Color(0xffEFEFEF))),
                                                                                      child: Text(
                                                                                        'Enter About Me',
                                                                                        style: TextStyle(fontSize: 14, fontWeight: FontWeight.w300, color: Colors.black),
                                                                                      ),
                                                                                    ),
                                                                                  )
                                                                                : Padding(
                                                                                    padding: EdgeInsets.only(
                                                                                      left: 16,
                                                                                      right: 16,
                                                                                      top: 0,
                                                                                    ),
                                                                                    child: Stack(
                                                                                      children: [
                                                                                        Column(
                                                                                          children: [
                                                                                            SizedBox(
                                                                                              height: 100,
                                                                                              child: FlutterMentions(
                                                                                                readOnly: isAbourtMe,
                                                                                                defaultText: aboutMe.text,
                                                                                                onChanged: (value) {
                                                                                                  onChangeMethod(value);
                                                                                                },
                                                                                                suggestionPosition: SuggestionPosition.values.first,
                                                                                                maxLines: 5,
                                                                                                decoration: InputDecoration(
                                                                                                  hintText: 'Enter About Me',
                                                                                                  border: InputBorder.none,
                                                                                                  focusedBorder: InputBorder.none,
                                                                                                ),
                                                                                                mentions: [
                                                                                                  Mention(
                                                                                                      trigger: "@",
                                                                                                      data: tageData,
                                                                                                      matchAll: true,
                                                                                                      style: TextStyle(color: Colors.blue),
                                                                                                      suggestionBuilder: (tageData) {
                                                                                                        if (istageData) {
                                                                                                          return Container(
                                                                                                            padding: EdgeInsets.all(10.0),
                                                                                                            child: Row(
                                                                                                              children: <Widget>[
                                                                                                                tageData['photo'] != null
                                                                                                                    ? CircleAvatar(
                                                                                                                        backgroundImage: NetworkImage(
                                                                                                                          tageData['photo'],
                                                                                                                        ),
                                                                                                                      )
                                                                                                                    : CircleAvatar(
                                                                                                                        backgroundImage: AssetImage(ImageConstant.tomcruse),
                                                                                                                      ),
                                                                                                                SizedBox(
                                                                                                                  width: 20.0,
                                                                                                                ),
                                                                                                                Column(
                                                                                                                  children: <Widget>[
                                                                                                                    Text('@${tageData['display']}'),
                                                                                                                  ],
                                                                                                                )
                                                                                                              ],
                                                                                                            ),
                                                                                                          );
                                                                                                        }

                                                                                                        return Container(
                                                                                                          color: Colors.amber,
                                                                                                        );
                                                                                                      }),
                                                                                                  Mention(
                                                                                                      trigger: "#",
                                                                                                      style: TextStyle(color: Colors.blue),
                                                                                                      disableMarkup: true,
                                                                                                      data: heshTageData,
                                                                                                      // matchAll: true,
                                                                                                      suggestionBuilder: (tageData) {
                                                                                                        if (isHeshTegData) {
                                                                                                          return Container(
                                                                                                              padding: EdgeInsets.all(10.0),
                                                                                                              child: ListTile(
                                                                                                                leading: CircleAvatar(
                                                                                                                  child: Text('#'),
                                                                                                                ),
                                                                                                                title: Text('${tageData['display']}'),
                                                                                                              )
                                                                                                              /* Column(
                                                                                                                                    crossAxisAlignment:
                                                                                                                                        CrossAxisAlignment
                                                                                                                                                    .start,
                                                                                                                                    children: <Widget>[
                                                                                                                                      Text(
                                                                                                                                          '${tageData['display']}'),
                                                                                                                                    ],
                                                                                                                                  ), */
                                                                                                              );
                                                                                                        }

                                                                                                        return Container(
                                                                                                          color: Colors.amber,
                                                                                                        );
                                                                                                      }),
                                                                                                ],
                                                                                              ),
                                                                                            ),
                                                                                          ],
                                                                                        ),
                                                                                      ],
                                                                                    ),
                                                                                  ),

                                                                            // Padding(
                                                                            //         padding: const EdgeInsets
                                                                            //                 .only(
                                                                            //             left:
                                                                            //                 20,
                                                                            //             right:
                                                                            //                 20),
                                                                            //         child:
                                                                            //             TextFormField(
                                                                            //           inputFormatters: [
                                                                            //             LengthLimitingTextInputFormatter(
                                                                            //                 500),
                                                                            //           ],
                                                                            //           readOnly:
                                                                            //               isAbourtMe,
                                                                            //           controller:
                                                                            //               aboutMe,
                                                                            //           maxLines:
                                                                            //               5,
                                                                            //           decoration:
                                                                            //               InputDecoration(
                                                                            //             border:
                                                                            //                 OutlineInputBorder(),
                                                                            //           ),
                                                                            //         ),
                                                                            //       ),
                                                                            //wiil DataGet
                                                                            /*   : */
                                                                            SizedBox(
                                                                              height: 12,
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      ),
                                                              ],
                                                            )),
                                                        /* if ((NewProfileData?.object
                                                                      ?.aboutMe !=
                                                                  null &&
                                                              User_ID !=
                                                                  NewProfileData
                                                                      ?.object
                                                                      ?.userUid) &&
                                                          (NewProfileData?.object
                                                                      ?.accountType ==
                                                                  'PUBLIC' &&
                                                              NewProfileData?.object
                                                                      ?.aboutMe !=
                                                                  null) ||
                                                      (NewProfileData?.object
                                                                  ?.isFollowing ==
                                                              'FOLLOWING' &&
                                                          NewProfileData?.object
                                                                  ?.accountType ==
                                                              'PRIVATE' &&
                                                          NewProfileData?.object
                                                                  ?.aboutMe !=
                                                              null))
                                                    GestureDetector(
                                                      onTap: () {
                                                        print(
                                                            "thid is -${NewProfileData?.object?.aboutMe}");
                                                      },
                                                      child: Card(
                                                          color: Colors.white,
                                                          borderOnForeground: true,
                                                          elevation: 10,
                                                          shape:
                                                              RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(15.0),
                                                          ),
                                                          /*  child: expertUser(_height, _width) */
                                                          child: Column(
                                                            children: [
                                                              ListTile(
                                                                  /*     leading:
                                                                            Container(
                                                                          width: 35,
                                                                          height: 35,
                                                                          decoration:
                                                                              ShapeDecoration(
                                                                            color:ColorConstant.primary_color,
                                                                            shape:
                                                                                OvalBorder(),
                                                                          ),
                                                                        ), */
                                                                  title: Text(
                                                                    'About Me',
                                                                    style:
                                                                        TextStyle(
                                                                      color: Colors
                                                                          .black,
                                                                      fontSize: 18,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600,
                                                                    ),
                                                                  ),
                                                                  subtitle: /* Text(
                                                                        '${NewProfileData?.object?.aboutMe}',
                                                                        style: TextStyle(
                                                                            color: Colors
                                                                                .black,
                                                                            fontSize: 14,
                                                                            fontFamily:
                                                                                "outfit"),
                                                                      ), */
      
                                                                      LinkifyText(
                                                                    "${NewProfileData?.object?.aboutMe}",
                                                                    linkStyle:
                                                                        TextStyle(
                                                                      color: Colors
                                                                          .blue,
                                                                      fontFamily:
                                                                          'outfit',
                                                                    ),
                                                                    textStyle:
                                                                        TextStyle(
                                                                      color: Colors
                                                                          .black,
                                                                      fontFamily:
                                                                          'outfit',
                                                                    ),
                                                                    linkTypes: [
                                                                      LinkType.url,
                                                                      LinkType
                                                                          .userTag,
                                                                      LinkType
                                                                          .hashTag,
                                                                      // LinkType
                                                                      //     .email
                                                                    ],
                                                                    onTap:
                                                                        (link) async {
                                                                      /// do stuff with `link` like
                                                                      /// if(link.type == Link.url) launchUrl(link.value);
      
                                                                      var SelectedTest =
                                                                          link.value
                                                                              .toString();
                                                                      var Link = SelectedTest
                                                                          .startsWith(
                                                                              'https');
                                                                      var Link1 = SelectedTest
                                                                          .startsWith(
                                                                              'http');
                                                                      var Link2 = SelectedTest
                                                                          .startsWith(
                                                                              'www');
                                                                      var Link3 = SelectedTest
                                                                          .startsWith(
                                                                              'WWW');
                                                                      var Link4 = SelectedTest
                                                                          .startsWith(
                                                                              'HTTPS');
                                                                      var Link5 = SelectedTest
                                                                          .startsWith(
                                                                              'HTTP');
                                                                      var Link6 = SelectedTest
                                                                          .startsWith(
                                                                              'https://pdslink.page.link/');
                                                                      print(SelectedTest
                                                                          .toString());
      
                                                                      if (User_ID ==
                                                                          null) {
                                                                        Navigator.of(
                                                                                context)
                                                                            .push(MaterialPageRoute(
                                                                                builder: (context) =>
                                                                                    RegisterCreateAccountScreen()));
                                                                      } else {
                                                                        if (Link ==
                                                                                true ||
                                                                            Link1 ==
                                                                                true ||
                                                                            Link2 ==
                                                                                true ||
                                                                            Link3 ==
                                                                                true ||
                                                                            Link4 ==
                                                                                true ||
                                                                            Link5 ==
                                                                                true ||
                                                                            Link6 ==
                                                                                true) {
                                                                          if (Link2 ==
                                                                                  true ||
                                                                              Link3 ==
                                                                                  true) {
                                                                            launchUrl(
                                                                                Uri.parse("https://${link.value.toString()}"));
                                                                            print(
                                                                                "qqqqqqqqhttps://${link.value}");
                                                                          } else {
                                                                            if (Link6 ==
                                                                                true) {
                                                                              print(
                                                                                  "yes i am inList =   room");
                                                                              Navigator.push(
                                                                                  context,
                                                                                  MaterialPageRoute(
                                                                                builder:
                                                                                    (context) {
                                                                                  return NewBottomBar(
                                                                                    buttomIndex: 1,
                                                                                  );
                                                                                },
                                                                              ));
                                                                            } else {
                                                                              launchUrl(Uri.parse(link
                                                                                  .value
                                                                                  .toString()));
                                                                              print(
                                                                                  "link.valuelink.value -- ${link.value}");
                                                                            }
                                                                          }
                                                                        } else {
                                                                          if (link
                                                                              .value!
                                                                              .startsWith(
                                                                                  '#')) {
                                                                            Navigator.push(
                                                                                context,
                                                                                MaterialPageRoute(
                                                                                  builder: (context) => HashTagViewScreen(title: "${link.value}"),
                                                                                ));
                                                                          } else if (link
                                                                              .value!
                                                                              .startsWith(
                                                                                  '@')) {
                                                                            var name;
                                                                            var tagName;
                                                                            name =
                                                                                SelectedTest;
                                                                            tagName = name.replaceAll(
                                                                                "@",
                                                                                "");
                                                                            await BlocProvider.of<NewProfileSCubit>(context).UserTagAPI(
                                                                                context,
                                                                                tagName);
                                                                          } else {
                                                                            launchUrl(
                                                                                Uri.parse("https://${link.value.toString()}"));
                                                                          }
                                                                        }
                                                                      }
                                                                    },
                                                                  )),
                                                            ],
                                                          )),
                                                    ), */

                                                        /* Card(
                                                          color: Colors.white,
                                                          borderOnForeground: true,
                                                          elevation: 10,
                                                          shape:
                                                              RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(15.0),
                                                          ),
                                                          /*  child: expertUser(_height, _width) */
                                                          child: Column(
                                                            children: [
                                                              ListTile(
                                                                  /*     leading:
                                                                          Container(
                                                                        width: 35,
                                                                        height: 35,
                                                                        decoration:
                                                                            ShapeDecoration(
                                                                          color:ColorConstant.primary_color,
                                                                          shape:
                                                                              OvalBorder(),
                                                                        ),
                                                                      ), */
                                                                  title: Text(
                                                                    'About Me',
                                                                    style:
                                                                        TextStyle(
                                                                      color: Colors
                                                                          .black,
                                                                      fontSize: 18,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600,
                                                                    ),
                                                                  ),
                                                                  subtitle: /* Text(
                                                                      '${NewProfileData?.object?.aboutMe}',
                                                                      style: TextStyle(
                                                                          color: Colors
                                                                              .black,
                                                                          fontSize: 14,
                                                                          fontFamily:
                                                                              "outfit"),
                                                                    ), */
      
                                                                      LinkifyText(
                                                                    "${NewProfileData?.object?.aboutMe}",
                                                                    linkStyle:
                                                                        TextStyle(
                                                                      color: Colors
                                                                          .blue,
                                                                      fontFamily:
                                                                          'outfit',
                                                                    ),
                                                                    textStyle:
                                                                        TextStyle(
                                                                      color: Colors
                                                                          .black,
                                                                      fontFamily:
                                                                          'outfit',
                                                                    ),
                                                                    linkTypes: [
                                                                      LinkType.url,
                                                                      LinkType
                                                                          .userTag,
                                                                      LinkType
                                                                          .hashTag,
                                                                      // LinkType
                                                                      //     .email
                                                                    ],
                                                                    onTap:
                                                                        (link) async {
                                                                      /// do stuff with `link` like
                                                                      /// if(link.type == Link.url) launchUrl(link.value);
      
                                                                      var SelectedTest =
                                                                          link.value
                                                                              .toString();
                                                                      var Link = SelectedTest
                                                                          .startsWith(
                                                                              'https');
                                                                      var Link1 = SelectedTest
                                                                          .startsWith(
                                                                              'http');
                                                                      var Link2 = SelectedTest
                                                                          .startsWith(
                                                                              'www');
                                                                      var Link3 = SelectedTest
                                                                          .startsWith(
                                                                              'WWW');
                                                                      var Link4 = SelectedTest
                                                                          .startsWith(
                                                                              'HTTPS');
                                                                      var Link5 = SelectedTest
                                                                          .startsWith(
                                                                              'HTTP');
                                                                      var Link6 = SelectedTest
                                                                          .startsWith(
                                                                              'https://pdslink.page.link/');
                                                                      print(SelectedTest
                                                                          .toString());
      
                                                                      if (User_ID ==
                                                                          null) {
                                                                        Navigator.of(
                                                                                context)
                                                                            .push(MaterialPageRoute(
                                                                                builder: (context) =>
                                                                                    RegisterCreateAccountScreen()));
                                                                      } else {
                                                                        if (Link ==
                                                                                true ||
                                                                            Link1 ==
                                                                                true ||
                                                                            Link2 ==
                                                                                true ||
                                                                            Link3 ==
                                                                                true ||
                                                                            Link4 ==
                                                                                true ||
                                                                            Link5 ==
                                                                                true ||
                                                                            Link6 ==
                                                                                true) {
                                                                          if (Link2 ==
                                                                                  true ||
                                                                              Link3 ==
                                                                                  true) {
                                                                            launchUrl(
                                                                                Uri.parse("https://${link.value.toString()}"));
                                                                            print(
                                                                                "qqqqqqqqhttps://${link.value}");
                                                                          } else {
                                                                            if (Link6 ==
                                                                                true) {
                                                                              print(
                                                                                  "yes i am inList =   room");
                                                                              Navigator.push(
                                                                                  context,
                                                                                  MaterialPageRoute(
                                                                                builder:
                                                                                    (context) {
                                                                                  return NewBottomBar(
                                                                                    buttomIndex: 1,
                                                                                  );
                                                                                },
                                                                              ));
                                                                            } else {
                                                                              launchUrl(Uri.parse(link
                                                                                  .value
                                                                                  .toString()));
                                                                              print(
                                                                                  "link.valuelink.value -- ${link.value}");
                                                                            }
                                                                          }
                                                                        } else {
                                                                          if (link
                                                                              .value!
                                                                              .startsWith(
                                                                                  '#')) {
                                                                            Navigator.push(
                                                                                context,
                                                                                MaterialPageRoute(
                                                                                  builder: (context) => HashTagViewScreen(title: "${link.value}"),
                                                                                ));
                                                                          } else if (link
                                                                              .value!
                                                                              .startsWith(
                                                                                  '@')) {
                                                                            var name;
                                                                            var tagName;
                                                                            name =
                                                                                SelectedTest;
                                                                            tagName = name.replaceAll(
                                                                                "@",
                                                                                "");
                                                                            await BlocProvider.of<NewProfileSCubit>(context).UserTagAPI(
                                                                                context,
                                                                                tagName);
                                                                          } else {
                                                                            launchUrl(
                                                                                Uri.parse("https://${link.value.toString()}"));
                                                                          }
                                                                        }
                                                                      }
                                                                    },
                                                                  )),
                                                            ],
                                                          )),
       */
                                                        /* User_ID !=
                                                            NewProfileData
                                                                ?.object?.userUid
                                                        ? NewProfileData?.object
                                                                    ?.aboutMe ==
                                                                null
                                                            ? SizedBox()
                                                            : Card(
                                                                color: Colors.white,
                                                                borderOnForeground:
                                                                    true,
                                                                elevation: 10,
                                                                shape:
                                                                    RoundedRectangleBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              15.0),
                                                                ),
                                                                /*  child: expertUser(_height, _width) */
                                                                child: Column(
                                                                  children: [
                                                                    ListTile(
                                                                        /*     leading:
                                                                          Container(
                                                                        width: 35,
                                                                        height: 35,
                                                                        decoration:
                                                                            ShapeDecoration(
                                                                          color:ColorConstant.primary_color,
                                                                          shape:
                                                                              OvalBorder(),
                                                                        ),
                                                                      ), */
                                                                        title: Text(
                                                                          'About Me',
                                                                          style:
                                                                              TextStyle(
                                                                            color: Colors
                                                                                .black,
                                                                            fontSize:
                                                                                18,
                                                                            fontWeight:
                                                                                FontWeight.w600,
                                                                          ),
                                                                        ),
                                                                        subtitle: /* Text(
                                                                      '${NewProfileData?.object?.aboutMe}',
                                                                      style: TextStyle(
                                                                          color: Colors
                                                                              .black,
                                                                          fontSize: 14,
                                                                          fontFamily:
                                                                              "outfit"),
                                                                    ), */
      
                                                                            LinkifyText(
                                                                          "${NewProfileData?.object?.aboutMe}",
                                                                          linkStyle:
                                                                              TextStyle(
                                                                            color: Colors
                                                                                .blue,
                                                                            fontFamily:
                                                                                'outfit',
                                                                          ),
                                                                          textStyle:
                                                                              TextStyle(
                                                                            color: Colors
                                                                                .black,
                                                                            fontFamily:
                                                                                'outfit',
                                                                          ),
                                                                          linkTypes: [
                                                                            LinkType
                                                                                .url,
                                                                            LinkType
                                                                                .userTag,
                                                                            LinkType
                                                                                .hashTag,
                                                                            // LinkType
                                                                            //     .email
                                                                          ],
                                                                          onTap:
                                                                              (link) async {
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
                                                                            var Link3 =
                                                                                SelectedTest.startsWith('WWW');
                                                                            var Link4 =
                                                                                SelectedTest.startsWith('HTTPS');
                                                                            var Link5 =
                                                                                SelectedTest.startsWith('HTTP');
                                                                            var Link6 =
                                                                                SelectedTest.startsWith('https://pdslink.page.link/');
                                                                            print(SelectedTest
                                                                                .toString());
      
                                                                            if (User_ID ==
                                                                                null) {
                                                                              Navigator.of(context)
                                                                                  .push(MaterialPageRoute(builder: (context) => RegisterCreateAccountScreen()));
                                                                            } else {
                                                                              if (Link == true ||
                                                                                  Link1 == true ||
                                                                                  Link2 == true ||
                                                                                  Link3 == true ||
                                                                                  Link4 == true ||
                                                                                  Link5 == true ||
                                                                                  Link6 == true) {
                                                                                if (Link2 == true ||
                                                                                    Link3 == true) {
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
                                                                                  Navigator.push(
                                                                                      context,
                                                                                      MaterialPageRoute(
                                                                                        builder: (context) => HashTagViewScreen(title: "${link.value}"),
                                                                                      ));
                                                                                } else if (link.value!.startsWith('@')) {
                                                                                  var name;
                                                                                  var tagName;
                                                                                  name = SelectedTest;
                                                                                  tagName = name.replaceAll("@", "");
                                                                                  await BlocProvider.of<NewProfileSCubit>(context).UserTagAPI(context, tagName);
                                                                                } else {
                                                                                  launchUrl(Uri.parse("https://${link.value.toString()}"));
                                                                                }
                                                                              }
                                                                            }
                                                                          },
                                                                        )),
                                                                  ],
                                                                ))
                                                        : Card(
                                                            color: Colors.white,
                                                            borderOnForeground:
                                                                true,
                                                            elevation: 10,
                                                            shape:
                                                                RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          15.0),
                                                            ),
                                                            child: Column(
                                                              children: [
                                                                Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                              .only(
                                                                          top: 10,
                                                                          right: 20,
                                                                          left: 20),
                                                                  child: Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .spaceBetween,
                                                                    children: [
                                                                      Text(
                                                                        'About Me',
                                                                        style:
                                                                            TextStyle(
                                                                          color: Colors
                                                                              .black,
                                                                          fontSize:
                                                                              18,
                                                                          fontWeight:
                                                                              FontWeight
                                                                                  .w600,
                                                                        ),
                                                                      ),
                                                                      User_ID !=
                                                                              NewProfileData
                                                                                  ?.object
                                                                                  ?.userUid
                                                                          ? SizedBox
                                                                              .shrink()
                                                                          : GestureDetector(
                                                                              onTap:
                                                                                  () {
                                                                                super.setState(() {
                                                                                  isUpDate = true;
                                                                                  isAbourtMe = false;
                                                                                  AbboutMeShow = false;
                                                                                });
                                                                              },
                                                                              child: isUpDate == true
                                                                                  ? GestureDetector(
                                                                                      onTap: () {
                                                                                        if (aboutMe.text.isNotEmpty) {
                                                                                          BlocProvider.of<NewProfileSCubit>(context).abboutMeApi(context, aboutMe.text);
                                                                                        } else {
                                                                                          SnackBar snackBar = SnackBar(
                                                                                            content: Text('Please Enter About Me'),
                                                                                            backgroundColor: ColorConstant.primary_color,
                                                                                          );
                                                                                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                                                                        }
                                                                                      },
                                                                                      child: Container(
                                                                                        alignment: Alignment.center,
                                                                                        height: 24,
                                                                                        width: 50,
                                                                                        decoration: BoxDecoration(
                                                                                          borderRadius: BorderRadius.circular(5),
                                                                                          color: ColorConstant.primary_color,
                                                                                        ),
                                                                                        child: Text(
                                                                                          'SAVE',
                                                                                          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                                                                                        ),
                                                                                      ),
                                                                                    )
                                                                                  : Icon(
                                                                                      Icons.edit,
                                                                                      color: Colors.black,
                                                                                    ),
                                                                            )
                                                                    ],
                                                                  ),
                                                                ),
                                                                isUpDate == false
                                                                    ? Padding(
                                                                        padding: const EdgeInsets
                                                                                .only(
                                                                            top: 12,
                                                                            left:
                                                                                10,
                                                                            right:
                                                                                10,
                                                                            bottom:
                                                                                15),
                                                                        child:
                                                                            Container(
                                                                          child:
                                                                              LinkifyText(
                                                                            "${aboutMe.text}",
                                                                            linkStyle:
                                                                                TextStyle(
                                                                              color:
                                                                                  Colors.blue,
                                                                              fontFamily:
                                                                                  'outfit',
                                                                            ),
                                                                            textStyle:
                                                                                TextStyle(
                                                                              color:
                                                                                  Colors.black,
                                                                              fontFamily:
                                                                                  'outfit',
                                                                            ),
                                                                            linkTypes: [
                                                                              LinkType
                                                                                  .url,
                                                                              LinkType
                                                                                  .userTag,
                                                                              LinkType
                                                                                  .hashTag,
                                                                              // LinkType
                                                                              //     .email
                                                                            ],
                                                                            onTap:
                                                                                (link) async {
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
                                                                              var Link3 =
                                                                                  SelectedTest.startsWith('WWW');
                                                                              var Link4 =
                                                                                  SelectedTest.startsWith('HTTPS');
                                                                              var Link5 =
                                                                                  SelectedTest.startsWith('HTTP');
                                                                              var Link6 =
                                                                                  SelectedTest.startsWith('https://pdslink.page.link/');
                                                                              print(
                                                                                  SelectedTest.toString());
      
                                                                              if (User_ID ==
                                                                                  null) {
                                                                                Navigator.of(context).push(MaterialPageRoute(builder: (context) => RegisterCreateAccountScreen()));
                                                                              } else {
                                                                                if (Link == true ||
                                                                                    Link1 == true ||
                                                                                    Link2 == true ||
                                                                                    Link3 == true ||
                                                                                    Link4 == true ||
                                                                                    Link5 == true ||
                                                                                    Link6 == true) {
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
                                                                                    Navigator.push(
                                                                                        context,
                                                                                        MaterialPageRoute(
                                                                                          builder: (context) => HashTagViewScreen(title: "${link.value}"),
                                                                                        ));
                                                                                  } else if (link.value!.startsWith('@')) {
                                                                                    var name;
                                                                                    var tagName;
                                                                                    name = SelectedTest;
                                                                                    tagName = name.replaceAll("@", "");
                                                                                    await BlocProvider.of<NewProfileSCubit>(context).UserTagAPI(context, tagName);
                                                                                  } else {
                                                                                    launchUrl(Uri.parse("https://${link.value.toString()}"));
                                                                                  }
                                                                                }
                                                                              }
                                                                            },
                                                                          ),
                                                                        ),
                                                                      )
                                                                    : Padding(
                                                                        padding: const EdgeInsets
                                                                                .only(
                                                                            left:
                                                                                0),
                                                                        child:
                                                                            Column(
                                                                          crossAxisAlignment:
                                                                              CrossAxisAlignment
                                                                                  .start,
                                                                          children: [
                                                                            SizedBox(
                                                                              height:
                                                                                  15,
                                                                            ),
      
                                                                            SizedBox(
                                                                              height:
                                                                                  5,
                                                                            ),
                                                                            AbboutMeShow ==
                                                                                    true
                                                                                ? Padding(
                                                                                    padding: const EdgeInsets.only(left: 20, right: 20),
                                                                                    child: Container(
                                                                                      alignment: Alignment.center,
                                                                                      height: 50,
                                                                                      // width:
                                                                                      //     _width /
                                                                                      //         1.5,
                                                                                      decoration: BoxDecoration(
                                                                                          // color: Colors.amber
                                                                                          borderRadius: BorderRadius.circular(10),
                                                                                          border: Border.all(color: Color(0xffEFEFEF))),
                                                                                      child: Text(
                                                                                        'Enter About Me',
                                                                                        style: TextStyle(fontSize: 14, fontWeight: FontWeight.w300, color: Colors.black),
                                                                                      ),
                                                                                    ),
                                                                                  )
                                                                                : Padding(
                                                                                    padding: EdgeInsets.only(
                                                                                      left: 16,
                                                                                      right: 16,
                                                                                      top: 0,
                                                                                    ),
                                                                                    child: Stack(
                                                                                      children: [
                                                                                        Column(
                                                                                          children: [
                                                                                            SizedBox(
                                                                                              height: 100,
                                                                                              child: FlutterMentions(
                                                                                                readOnly: isAbourtMe,
                                                                                                defaultText: aboutMe.text,
                                                                                                onChanged: (value) {
                                                                                                  onChangeMethod(value);
                                                                                                },
                                                                                                suggestionPosition: SuggestionPosition.values.first,
                                                                                                maxLines: 5,
                                                                                                decoration: InputDecoration(
                                                                                                  hintText: 'Enter About Me',
                                                                                                  border: InputBorder.none,
                                                                                                  focusedBorder: InputBorder.none,
                                                                                                ),
                                                                                                mentions: [
                                                                                                  Mention(
                                                                                                      trigger: "@",
                                                                                                      data: tageData,
                                                                                                      matchAll: true,
                                                                                                      style: TextStyle(color: Colors.blue),
                                                                                                      suggestionBuilder: (tageData) {
                                                                                                        if (istageData) {
                                                                                                          return Container(
                                                                                                            padding: EdgeInsets.all(10.0),
                                                                                                            child: Row(
                                                                                                              children: <Widget>[
                                                                                                                tageData['photo'] != null
                                                                                                                    ? CircleAvatar(
                                                                                                                        backgroundImage: NetworkImage(
                                                                                                                          tageData['photo'],
                                                                                                                        ),
                                                                                                                      )
                                                                                                                    : CircleAvatar(
                                                                                                                        backgroundImage: AssetImage(ImageConstant.tomcruse),
                                                                                                                      ),
                                                                                                                SizedBox(
                                                                                                                  width: 20.0,
                                                                                                                ),
                                                                                                                Column(
                                                                                                                  children: <Widget>[
                                                                                                                    Text('@${tageData['display']}'),
                                                                                                                  ],
                                                                                                                )
                                                                                                              ],
                                                                                                            ),
                                                                                                          );
                                                                                                        }
      
                                                                                                        return Container(
                                                                                                          color: Colors.amber,
                                                                                                        );
                                                                                                      }),
                                                                                                  Mention(
                                                                                                      trigger: "#",
                                                                                                      style: TextStyle(color: Colors.blue),
                                                                                                      disableMarkup: true,
                                                                                                      data: heshTageData,
                                                                                                      // matchAll: true,
                                                                                                      suggestionBuilder: (tageData) {
                                                                                                        if (isHeshTegData) {
                                                                                                          return Container(
                                                                                                              padding: EdgeInsets.all(10.0),
                                                                                                              child: ListTile(
                                                                                                                leading: CircleAvatar(
                                                                                                                  child: Text('#'),
                                                                                                                ),
                                                                                                                title: Text('${tageData['display']}'),
                                                                                                              )
                                                                                                              /* Column(
                                                                                                                                    crossAxisAlignment:
                                                                                                                                        CrossAxisAlignment
                                                                                                                                                    .start,
                                                                                                                                    children: <Widget>[
                                                                                                                                      Text(
                                                                                                                                          '${tageData['display']}'),
                                                                                                                                    ],
                                                                                                                                  ), */
                                                                                                              );
                                                                                                        }
      
                                                                                                        return Container(
                                                                                                          color: Colors.amber,
                                                                                                        );
                                                                                                      }),
                                                                                                ],
                                                                                              ),
                                                                                            ),
                                                                                          ],
                                                                                        ),
                                                                                      ],
                                                                                    ),
                                                                                  ),
      
                                                                            // Padding(
                                                                            //         padding: const EdgeInsets
                                                                            //                 .only(
                                                                            //             left:
                                                                            //                 20,
                                                                            //             right:
                                                                            //                 20),
                                                                            //         child:
                                                                            //             TextFormField(
                                                                            //           inputFormatters: [
                                                                            //             LengthLimitingTextInputFormatter(
                                                                            //                 500),
                                                                            //           ],
                                                                            //           readOnly:
                                                                            //               isAbourtMe,
                                                                            //           controller:
                                                                            //               aboutMe,
                                                                            //           maxLines:
                                                                            //               5,
                                                                            //           decoration:
                                                                            //               InputDecoration(
                                                                            //             border:
                                                                            //                 OutlineInputBorder(),
                                                                            //           ),
                                                                            //         ),
                                                                            //       ),
                                                                            //wiil DataGet
                                                                            /*   : */
                                                                            SizedBox(
                                                                              height:
                                                                                  12,
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      ),
                                                              ],
                                                            )), */
                                                        NewProfileData?.object
                                                                    ?.module ==
                                                                "EXPERT"
                                                            ? Card(
                                                                color: Colors
                                                                    .white,
                                                                borderOnForeground:
                                                                    true,
                                                                elevation: 10,
                                                                shape:
                                                                    RoundedRectangleBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              15.0),
                                                                ),
                                                                /*  child: expertUser(_height, _width) */
                                                                child:
                                                                    expertUser(
                                                                        _height,
                                                                        _width),
                                                              )
                                                            : SizedBox(),
                                                        NewProfileData?.object
                                                                    ?.module ==
                                                                "COMPANY"
                                                            ? Card(
                                                                color: Colors
                                                                    .white,
                                                                borderOnForeground:
                                                                    true,
                                                                elevation: 10,
                                                                shape:
                                                                    RoundedRectangleBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              15.0),
                                                                ),
                                                                /*  child: expertUser(_height, _width) */
                                                                child:
                                                                    compnayUser(
                                                                        _height,
                                                                        _width),
                                                              )
                                                            : SizedBox(),
                                                        NewProfileData?.object
                                                                        ?.module ==
                                                                    "COMPANY" &&
                                                                NewProfileData
                                                                        ?.object
                                                                        ?.approvalStatus !=
                                                                    'PENDING'
                                                            ? Card(
                                                                color: Colors
                                                                    .white,
                                                                borderOnForeground:
                                                                    true,
                                                                elevation: 10,
                                                                shape:
                                                                    RoundedRectangleBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              15.0),
                                                                ),
                                                                /*  child: expertUser(_height, _width) */
                                                                child:
                                                                    experience(
                                                                        _height,
                                                                        _width),
                                                              ) /*  Padding(
                                                          padding:
                                                              const EdgeInsets.only(
                                                                  top: 50),
                                                          child: Container(
                                                            height: _height / 2.2,
                                                            decoration: BoxDecoration(
                                                                boxShadow: [
                                                                  BoxShadow(
                                                                      color:
                                                                          Colors.grey,
                                                                      blurRadius: 20),
                                                                ],
                                                                color: Colors.white,
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(10)),
                                                            child: experience(),
                                                          ),
                                                        ) */
                                                            : SizedBox(),
                                                        NewProfileData?.object
                                                                        ?.module ==
                                                                    "EXPERT" &&
                                                                NewProfileData
                                                                        ?.object
                                                                        ?.approvalStatus !=
                                                                    'PENDING'
                                                            ? Card(
                                                                color: Colors
                                                                    .white,
                                                                borderOnForeground:
                                                                    true,
                                                                elevation: 10,
                                                                shape:
                                                                    RoundedRectangleBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              15.0),
                                                                ),
                                                                /*  child: expertUser(_height, _width) */
                                                                child:
                                                                    experience(
                                                                        _height,
                                                                        _width),
                                                              )
                                                            : SizedBox()
                                                      ],
                                                    ),
                                                  )
                                            : SizedBox(),

                                        /// Content of Tab 2
                                        arrNotiyTypeList[1].isSelected
                                            ? creratePostUser(
                                                GetAllPostData, _width, _height)
                                            /* Container(
                                              height: FinalPostCount * 185,
                                              // color: Colors.yellow,
                                              child: Padding(
                                                padding: EdgeInsets.only(
                                                    left: 16, right: 16, top: 14),
                                                child: GridView.builder(
                                                  physics:
                                                      NeverScrollableScrollPhysics(),
                                                  padding: EdgeInsets.zero,
                                                  gridDelegate:
                                                      SliverGridDelegateWithFixedCrossAxisCount(
                                                    crossAxisCount:
                                                        2, // Number of columns
                                                    mainAxisSpacing:
                                                        0.0, // Vertical spacing between items
                                                    crossAxisSpacing:
                                                        20, // Horizontal spacing between items
                                                  ),
                                                  itemCount: GetAllPostData
                                                      ?.object?.length,
                                                  itemBuilder: (context, index) {
                                                    return Padding(
                                                      padding: EdgeInsets.only(
                                                          bottom: 10, top: 10),
                                                      child: ClipRRect(
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                                20.0),
                                                        child: GestureDetector(
                                                          onTap: () {
                                                            // OpenSaveImagepostModel
                                                            print(
                                                                "Open SavePost Click in one post");
      
                                                            Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                  builder: (context) =>
                                                                      OpenSavePostImage(
                                                                        PostID: GetAllPostData
                                                                            ?.object?[
                                                                                index]
                                                                            .postUid,
                                                                      )),
                                                            );
                                                          },
                                                          //Ankur will code
                                                          child:
      
                                                              ///   TEST IMAGE
      
                                                              GetAllPostData
                                                                          ?.object?[
                                                                              index]
                                                                          .postDataType ==
                                                                      "IMAGE"
                                                                  ? Container(
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        border:
                                                                            Border
                                                                                .all(
                                                                          color: Color
                                                                              .fromARGB(
                                                                                  255,
                                                                                  0,
                                                                                  0,
                                                                                  0),
                                                                        ),
                                                                        // borderRadius:
                                                                        //     BorderRadius
                                                                        //         .circular(
                                                                        //             15),
                                                                      ), // Remove margin
                                                                      child:
                                                                          CustomImageView(
                                                                        fit: BoxFit
                                                                            .cover,
                                                                        url:
                                                                            "${GetAllPostData?.object?[index].postData?.first}",
                                                                      ))
                                                                  : GetAllPostData
                                                                              ?.object?[
                                                                                  index]
                                                                              .postDataType ==
                                                                          "VIDEO"
                                                                      ? Stack(
                                                                          children: [
                                                                            Container(
                                                                              decoration: BoxDecoration(
                                                                                  color: Colors.transparent,
                                                                                  border: Border.all(
                                                                                    color: const Color.fromARGB(255, 0, 0, 0),
                                                                                  ),
                                                                                  borderRadius: BorderRadius.circular(20)),
                                                                            ),
                                                                            ThumbnailClass(
                                                                              videourl:
                                                                                  GetAllPostData?.object?[index].postData?.first ?? '',
                                                                            )
                                                                          ],
                                                                        )
                                                                      : GetAllPostData
                                                                                  ?.object?[
                                                                                      index]
                                                                                  .postDataType ==
                                                                              "ATTACHMENT"
                                                                          ? /*  Container(
                                                                              margin: EdgeInsets
                                                                                  .all(
                                                                                      0.0),
                                                                              decoration: BoxDecoration(
                                                                                  borderRadius: BorderRadius.circular(
                                                                                      20)), // Remove margin
                                
                                                                              child:
                                                                                  DocumentViewScreen1(
                                                                                path: GetAllPostData
                                                                                    ?.object?[index]
                                                                                    .postData
                                                                                    ?.first,
                                                                              )) */
                                                                          Stack(
                                                                              children: [
                                                                                Container(
                                                                                  height: 400,
                                                                                  width: _width,
                                                                                  decoration: BoxDecoration(
                                                                                    color: Colors.transparent,
                                                                                    border: Border.all(color: Colors.grey),
                                                                                    borderRadius: BorderRadius.circular(20),
                                                                                  ),
                                                                                ),
                                                                                Padding(
                                                                                  padding: const EdgeInsets.all(8.0),
                                                                                  child: GestureDetector(
                                                                                    onTap: () {
                                                                                      print("objectobjectobjectobject");
                                                                                      Navigator.push(context, MaterialPageRoute(
                                                                                        builder: (context) {
                                                                                          return DocumentViewScreen1(
                                                                                            path: GetAllPostData?.object?[index].postData?.first,
                                                                                          );
                                                                                        },
                                                                                      ));
                                                                                    },
                                                                                    child: Container(
                                                                                      decoration: BoxDecoration(
                                                                                        borderRadius: BorderRadius.circular(20),
                                                                                      ),
                                                                                      child: CachedNetworkImage(
                                                                                        imageUrl: GetAllPostData?.object?[index].thumbnailImageUrl ?? "",
                                                                                        fit: BoxFit.cover,
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                )
                                                                              ],
                                                                            )
                                                                          : GetAllPostData?.object?[index].postDataType ==
                                                                                  null
                                                                              ? Container(
                                                                                  margin: EdgeInsets.all(0.0),
                                                                                  decoration: BoxDecoration(border: Border.all(color: Color.fromARGB(255, 0, 0, 0)), borderRadius: BorderRadius.circular(20)),
                                                                                  child: Padding(
                                                                                    padding: const EdgeInsets.only(top: 15, left: 8, right: 10),
                                                                                    child: Text(
                                                                                      '${GetAllPostData?.object?[index].description}',
                                                                                      style: TextStyle(color: Colors.black, fontSize: 16),
                                                                                    ),
                                                                                  ))
                                                                              : SizedBox(),
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                ),
                                              ),
                                            ) */
                                            : SizedBox(),

                                        /// Content of Tab 3
                                        arrNotiyTypeList[2].isSelected
                                            ? User_ID ==
                                                        NewProfileData
                                                            ?.object?.userUid ||
                                                    (NewProfileData?.object
                                                            ?.accountType ==
                                                        'PUBLIC') ||
                                                    (NewProfileData?.object
                                                                ?.isFollowing ==
                                                            'FOLLOWING' &&
                                                        NewProfileData?.object
                                                                ?.accountType ==
                                                            'PRIVATE')
                                                ? GetUserPostCommetData?.object
                                                            ?.isNotEmpty ??
                                                        true
                                                    ? Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                left: 16,
                                                                right: 16,
                                                                top: 0),
                                                        child: Column(
                                                          children: [
                                                            Row(
                                                              children: [
                                                                Container(
                                                                  width: 150,
                                                                  height: 25,
                                                                  decoration:
                                                                      ShapeDecoration(
                                                                    color: Color(
                                                                        0xFFFBD8D9),
                                                                    shape:
                                                                        RoundedRectangleBorder(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              100),
                                                                    ),
                                                                  ),
                                                                  child:
                                                                      DropdownButtonHideUnderline(
                                                                    child: DropdownButton<
                                                                        String>(
                                                                      // Step 3.
                                                                      value:
                                                                          selctedValue,
                                                                      // Step 4.
                                                                      items: <String>[
                                                                        'Newest to oldest',
                                                                        'oldest to Newest'
                                                                      ].map<
                                                                          DropdownMenuItem<
                                                                              String>>((String
                                                                          value) {
                                                                        return DropdownMenuItem<
                                                                            String>(
                                                                          value:
                                                                              value,
                                                                          child:
                                                                              Padding(
                                                                            padding:
                                                                                EdgeInsets.only(left: 10),
                                                                            child:
                                                                                Text(
                                                                              value,
                                                                              style: TextStyle(
                                                                                color: Color(0xFFF58E92),
                                                                                fontSize: 14,
                                                                                fontFamily: 'outfit',
                                                                                fontWeight: FontWeight.w400,
                                                                                height: 0,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        );
                                                                      }).toList(),
                                                                      // Step 5.
                                                                      onChanged:
                                                                          (String?
                                                                              newValue) {
                                                                        super.setState(
                                                                            () {
                                                                          if (newValue ==
                                                                              "Newest to oldest") {
                                                                            BlocProvider.of<NewProfileSCubit>(context).GetPostCommetAPI(
                                                                                context,
                                                                                "${NewProfileData?.object?.userUid}",
                                                                                "asc"); //asc
                                                                          } else if (newValue ==
                                                                              "oldest to Newest") {
                                                                            BlocProvider.of<NewProfileSCubit>(context).GetPostCommetAPI(
                                                                                context,
                                                                                "${NewProfileData?.object?.userUid}",
                                                                                "desc");
                                                                          }
                                                                          selctedValue =
                                                                              newValue!;
                                                                        });
                                                                      },
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                            isDataGetValue ==
                                                                    false
                                                                ? SizedBox()
                                                                : ListView
                                                                    .builder(
                                                                    shrinkWrap:
                                                                        true,
                                                                    physics:
                                                                        NeverScrollableScrollPhysics(),
                                                                    itemCount: GetUserPostCommetData
                                                                        ?.object
                                                                        ?.length,
                                                                    itemBuilder:
                                                                        (context,
                                                                            index) {
                                                                      DateTime
                                                                          parsedDateTime =
                                                                          DateTime.parse(
                                                                              '${GetUserPostCommetData?.object?[index].createdAt ?? ""}');
                                                                      return Padding(
                                                                        padding:
                                                                            const EdgeInsets.only(bottom: 10),
                                                                        child: GestureDetector(
                                                                            onTap: () {
                                                                              Navigator.push(
                                                                                context,
                                                                                MaterialPageRoute(
                                                                                    builder: (context) => OpenSavePostImage(
                                                                                          PostID: GetUserPostCommetData?.object?[index].postUid,
                                                                                          profileTure: true,
                                                                                        )),
                                                                              );
                                                                            },
                                                                            child: Container(
                                                                              decoration: ShapeDecoration(
                                                                                // color: Colors.green,
                                                                                shape: RoundedRectangleBorder(
                                                                                  side: BorderSide(width: 1, color: Color(0xFFD3D3D3)),
                                                                                  borderRadius: BorderRadius.circular(10),
                                                                                ),
                                                                              ),
                                                                              child: Row(
                                                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                                                children: [
                                                                                  Container(
                                                                                    width: 50,
                                                                                    // height: 50,
                                                                                    margin: EdgeInsets.only(left: 5, top: 10),
                                                                                    child: GetUserPostCommetData?.object?[index].userProfilePic != null && GetUserPostCommetData?.object?[index].userProfilePic != ""
                                                                                        ? CircleAvatar(
                                                                                            backgroundColor: Colors.white,
                                                                                            backgroundImage: NetworkImage("${GetUserPostCommetData?.object?[index].userProfilePic}"),
                                                                                            radius: 25,
                                                                                          )
                                                                                        : CustomImageView(
                                                                                            imagePath: ImageConstant.tomcruse,
                                                                                            height: 50,
                                                                                            width: 50,
                                                                                            fit: BoxFit.fill,
                                                                                            radius: BorderRadius.circular(25),
                                                                                          ),
                                                                                    // decoration:
                                                                                    //     ShapeDecoration(
                                                                                    //   image:
                                                                                    //       DecorationImage(
                                                                                    //     image: AssetImage(
                                                                                    //         ImageConstant
                                                                                    //             .placeholder2),1
                                                                                    //     fit: BoxFit.fill,
                                                                                    //   ),
                                                                                    //   shape: OvalBorder(),
                                                                                    // ),
                                                                                  ),
                                                                                  Padding(
                                                                                    padding: const EdgeInsets.only(left: 10),
                                                                                    child: Column(
                                                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                                                      children: [
                                                                                        SizedBox(
                                                                                          height: 10,
                                                                                        ),
                                                                                        Text(
                                                                                          '${GetUserPostCommetData?.object?[index].postUserName}',
                                                                                          style: TextStyle(
                                                                                            color: Colors.black,
                                                                                            fontSize: 16,
                                                                                            fontFamily: 'outfit',
                                                                                            fontWeight: FontWeight.w600,
                                                                                          ),
                                                                                        ),
                                                                                        GetUserPostCommetData?.object?[index].description != null
                                                                                            ? Container(
                                                                                                // color: Colors.amber,
                                                                                                width: _width / 1.45,
                                                                                                child: Text(
                                                                                                  '${GetUserPostCommetData?.object?[index].description}',
                                                                                                  style: TextStyle(
                                                                                                    overflow: TextOverflow.visible,
                                                                                                    color: Colors.black,
                                                                                                    fontSize: 14,
                                                                                                    fontFamily: 'outfit',
                                                                                                    fontWeight: FontWeight.w400,
                                                                                                  ),
                                                                                                ),
                                                                                              )
                                                                                            : SizedBox(),
                                                                                        Text(
                                                                                          getTimeDifference(parsedDateTime),
                                                                                          style: TextStyle(
                                                                                            fontSize: 12,
                                                                                            fontFamily: "outfit",
                                                                                          ),
                                                                                        ),
                                                                                        Padding(
                                                                                          padding: const EdgeInsets.only(bottom: 10),
                                                                                          child: Column(
                                                                                              children: List.generate(GetUserPostCommetData?.object?[index].comments?.length == null ? 0 : ((GetUserPostCommetData?.object?[index].comments?.length ?? 0) > 2 ? 2 : GetUserPostCommetData?.object?[index].comments?.length) ?? 0, (index2) {
                                                                                            DateTime parsedDateTime2 = DateTime.parse('${GetUserPostCommetData?.object?[index].comments?[index2].createdAt}');
                                                                                            return Row(
                                                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                                                              children: [
                                                                                                Container(
                                                                                                  width: 45,
                                                                                                  height: 45,
                                                                                                  margin: EdgeInsets.only(top: 15),
                                                                                                  child: GetUserPostCommetData?.object?[index].comments?[index2].profilePic != null && GetUserPostCommetData?.object?[index].comments?[index2].profilePic != ""
                                                                                                      ? CircleAvatar(
                                                                                                          backgroundColor: Colors.white,
                                                                                                          backgroundImage: NetworkImage("${GetUserPostCommetData?.object?[index].comments?[index2].profilePic}"),
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
                                                                                                Padding(
                                                                                                  padding: const EdgeInsets.only(left: 8, top: 5, right: 3),
                                                                                                  child: Column(
                                                                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                                                                    children: [
                                                                                                      SizedBox(
                                                                                                        height: 10,
                                                                                                      ),
                                                                                                      Text(
                                                                                                        '${GetUserPostCommetData?.object?[index].comments?[index2].userName}',
                                                                                                        style: TextStyle(
                                                                                                          color: Colors.black,
                                                                                                          fontSize: 16,
                                                                                                          fontFamily: "outfit",
                                                                                                          fontWeight: FontWeight.w600,
                                                                                                        ),
                                                                                                      ),
                                                                                                      Container(
                                                                                                        // color: Colors.red,
                                                                                                        width: _width / 2,
                                                                                                        child: Text(
                                                                                                          '${GetUserPostCommetData?.object?[index].comments?[index2].comment}',
                                                                                                          // maxLines: 1,
                                                                                                          style: TextStyle(
                                                                                                            // overflow: TextOverflow.ellipsis,
                                                                                                            color: Colors.black,
                                                                                                            fontSize: 16,
                                                                                                            fontFamily: "outfit",
                                                                                                            fontWeight: FontWeight.w600,
                                                                                                          ),
                                                                                                        ),
                                                                                                      ),
                                                                                                      Text(
                                                                                                        getTimeDifference(parsedDateTime2),
                                                                                                        style: TextStyle(
                                                                                                          fontSize: 12,
                                                                                                          fontFamily: "outfit",
                                                                                                        ),
                                                                                                      ),
                                                                                                    ],
                                                                                                  ),
                                                                                                )
                                                                                              ],
                                                                                            );
                                                                                          })),
                                                                                        ),
                                                                                      ],
                                                                                    ),
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                            )),
                                                                      );
                                                                    },
                                                                  )
                                                          ],
                                                        ),
                                                      )
                                                    : Center(
                                                        child: Text(
                                                        "No Comments available",
                                                        style: TextStyle(
                                                            color: Colors.black,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontFamily:
                                                                'outfit',
                                                            fontSize: 20),
                                                      ))
                                                : Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      SizedBox(height: 50),
                                                      Center(
                                                          child: Image.asset(
                                                        ImageConstant
                                                            .nopostimage,
                                                        height: 150,
                                                      )),
                                                      SizedBox(height: 50),
                                                    ],
                                                  )
                                            : SizedBox(),

                                        /// Content of Tab 4

                                        arrNotiyTypeList[3].isSelected
                                            ? Container(
                                                // height: value1 == 0
                                                //     ? FinalSavePostCount == 0
                                                //         ? 40
                                                //         : FinalSavePostCount * 230
                                                //     : SaveBlogCount * 155 + 100,
                                                // color: Colors.green,
                                                child: Padding(
                                                  padding:
                                                      EdgeInsets.only(top: 0),
                                                  child: Column(
                                                    children: [
                                                      Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .center,
                                                          children: List.generate(
                                                              SaveList.length,
                                                              (index) => GestureDetector(
                                                                  onTap: () {
                                                                    dataSetup =
                                                                        null;
                                                                    value1 =
                                                                        index;

                                                                    SharedPreferencesFunction(
                                                                        value1 ??
                                                                            0);
                                                                    super.setState(
                                                                        () {});
                                                                  },
                                                                  child: Container(
                                                                    alignment:
                                                                        Alignment
                                                                            .center,
                                                                    margin: EdgeInsets
                                                                        .only(
                                                                            left:
                                                                                15),
                                                                    width: 100,
                                                                    height: 25,
                                                                    decoration:
                                                                        ShapeDecoration(
                                                                      color: value1 ==
                                                                              index
                                                                          ? ColorConstant
                                                                              .primary_color
                                                                          : dataSetup == index
                                                                              ? ColorConstant.primary_color
                                                                              : Color(0xFFFBD8D9),
                                                                      shape:
                                                                          RoundedRectangleBorder(
                                                                        borderRadius:
                                                                            BorderRadius.circular(100),
                                                                      ),
                                                                    ),
                                                                    child: Text(
                                                                      SaveList[
                                                                          index],
                                                                      style:
                                                                          TextStyle(
                                                                        color: value1 ==
                                                                                index
                                                                            ? Colors.white
                                                                            : dataSetup == index
                                                                                ? Colors.white
                                                                                : Color(0xFFF58E92),
                                                                        fontSize:
                                                                            14,
                                                                        fontFamily:
                                                                            "outfit",
                                                                        fontWeight:
                                                                            FontWeight.w400,
                                                                      ),
                                                                    ),
                                                                  )))),
                                                      NavagtionPassing(
                                                          _width, _height)
                                                    ],
                                                  ),
                                                ),
                                              )
                                            : SizedBox()
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              // ),
                              SizedBox(
                                height: 20,
                              )
                            ],
                          ),
                        )
                      ],
                    ));
        }),
      ),
    );
  }

  updateType() {
    arrNotiyTypeList.forEach((element) {
      element.isSelected = false;
    });
  }

  SharedPreferencesFunction(int value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt(PreferencesKey.tabSelction, value);
  }

  bool _isLink(String input) {
    RegExp linkRegex = RegExp(
        r'^https?:\/\/(?:www\.)?[a-zA-Z0-9-]+(?:\.[a-zA-Z]+)+(?:[^\s]*)$');
    return linkRegex.hasMatch(input);
  }

  Future<String> translateText(String text, String toLanguage) async {
    final translator = GoogleTranslator();

    Translation translation = await translator.translate(text, to: toLanguage);

    return translation.text;
  }

  soicalFunation({String? apiName, int? index}) async {
    print("fghdfghdfgh");
    if (apiName == 'like_post') {
      await BlocProvider.of<NewProfileSCubit>(context)
          .like_post(GetAllPostData?.object?[index ?? 0].postUid, context);
      print("isLiked-->${GetAllPostData?.object?[index ?? 0].isLiked}");
      if (GetAllPostData?.object?[index ?? 0].isLiked == true) {
        GetAllPostData?.object?[index ?? 0].isLiked = false;
        int a = GetAllPostData?.object?[index ?? 0].likedCount ?? 0;
        int b = 1;
        GetAllPostData?.object?[index ?? 0].likedCount = a - b;
      } else {
        GetAllPostData?.object?[index ?? 0].isLiked = true;
        GetAllPostData?.object?[index ?? 0].likedCount;
        int a = GetAllPostData?.object?[index ?? 0].likedCount ?? 0;
        int b = 1;
        GetAllPostData?.object?[index ?? 0].likedCount = a + b;
      }
    } else if (apiName == 'savedata') {
      await BlocProvider.of<NewProfileSCubit>(context)
          .savedData(GetAllPostData?.object?[index ?? 0].postUid, context);

      if (GetAllPostData?.object?[index ?? 0].isSaved == true) {
        GetAllPostData?.object?[index ?? 0].isSaved = false;
      } else {
        GetAllPostData?.object?[index ?? 0].isSaved = true;
      }
    }
  }

  Widget creratePostUser(
    GetAppUserPostModel? getAllPostData,
    double _width,
    double _height,
  ) {
    return User_ID == NewProfileData?.object?.userUid ||
            (NewProfileData?.object?.accountType == 'PUBLIC') ||
            (NewProfileData?.object?.isFollowing == 'FOLLOWING' &&
                NewProfileData?.object?.accountType == 'PRIVATE')
        ? getAllPostData?.object?.isNotEmpty ?? true
            ? ListView.builder(
                padding: EdgeInsets.zero,
                physics: NeverScrollableScrollPhysics(),
                itemCount: getAllPostData?.object?.length ?? 0,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  GlobalKey buttonKey = GlobalKey();

                  if (!added) {
                    getAllPostData?.object?.forEach((element) {
                      _pageControllers.add(PageController());
                      _currentPages.add(0);
                    });
                    WidgetsBinding.instance
                        .addPostFrameCallback((timeStamp) => super.setState(() {
                              added = true;
                            }));
                  }

                  DateTime parsedDateTime = DateTime.parse(
                      '${getAllPostData?.object?[index].createdAt ?? ""}');
                  DateTime? repostTime;
                  if (getAllPostData!.object![index].repostOn != null) {
                    repostTime = DateTime.parse(
                        '${getAllPostData.object?[index].repostOn!.createdAt ?? ""}');
                    print("repost time = $parsedDateTime");
                  }
                  bool DataGet = false;
                  if (getAllPostData.object?[index].description != null &&
                      getAllPostData.object?[index].description != '') {
                    DataGet =
                        _isLink('${getAllPostData.object?[index].description}');
                  }
                  return getAllPostData.object?[index].isReports == true
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
                                  child: Image.asset(ImageConstant.greenseen)),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                'Thanks for reporting',
                                style: TextStyle(color: Colors.black),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                'Post Reported and under review',
                                style: TextStyle(color: Colors.grey),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                            ],
                          ),
                        )
                      : getAllPostData.object?[index].repostOn != null
                          ? Padding(
                              padding: EdgeInsets.only(
                                  left: 0, right: 0, top: 10, bottom: 10),
                              child: GestureDetector(
                                onDoubleTap: () async {
                                  await soicalFunation(
                                      apiName: 'like_post', index: index);
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(
                                        color: Color.fromRGBO(0, 0, 0,
                                            0.25)), /* borderRadius: BorderRadius.circular(15) */
                                  ),
                                  // height: 300,
                                  width: _width,
                                  child: Column(
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
                                              /*  await BlocProvider.of<GetGuestAllPostCubit>(
                                        context)
                                    .seetinonExpried(context); */
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
                                                            "${getAllPostData.object?[index].userUid}",
                                                        isFollowing:
                                                            getAllPostData
                                                                .object?[index]
                                                                .isFollowing));
                                              })).then(
                                                  (value) => Get_UserToken());

                                              ///
                                            },
                                            child: getAllPostData.object?[index]
                                                            .userProfilePic !=
                                                        null &&
                                                    getAllPostData
                                                            .object?[index]
                                                            .userProfilePic !=
                                                        ""
                                                ? CircleAvatar(
                                                    backgroundImage: NetworkImage(
                                                        "${getAllPostData.object?[index].userProfilePic}"),
                                                    backgroundColor:
                                                        Colors.white,
                                                    radius: 25,
                                                  )
                                                : CircleAvatar(
                                                    child: CustomImageView(
                                                      imagePath: ImageConstant
                                                          .tomcruse,
                                                      height: 50,
                                                      width: 50,
                                                      fit: BoxFit.fill,
                                                      radius:
                                                          BorderRadius.circular(
                                                              25),
                                                    ),
                                                  ),
                                          ),
                                          title: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              GestureDetector(
                                                onTap: () async {
                                                  /*   await BlocProvider.of<GetGuestAllPostCubit>(
                                            context)
                                        .seetinonExpried(context); */
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
                                                                "${getAllPostData.object?[index].userUid}",
                                                            isFollowing:
                                                                getAllPostData
                                                                    .object?[
                                                                        index]
                                                                    .isFollowing));
                                                  })).then((value) =>
                                                      Get_UserToken());

                                                  //
                                                },
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Container(
                                                      // color: Colors.amber,
                                                      child: Text(
                                                        "${getAllPostData.object?[index].postUserName}",
                                                        style: TextStyle(
                                                            fontSize: 20,
                                                            fontFamily:
                                                                "outfit",
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                    ),
                                                    getAllPostData
                                                                .object?[index]
                                                                .userUid ==
                                                            User_ID
                                                        ? GestureDetector(
                                                            key: buttonKey,
                                                            onTap: () {
                                                              showPopupMenu(
                                                                  context,
                                                                  index,
                                                                  buttonKey,
                                                                  getAllPostData);
                                                            },
                                                            child: Icon(
                                                              Icons
                                                                  .more_vert_rounded,
                                                              size: 25,
                                                            ),
                                                          )
                                                        : getAllPostData
                                                                    .object?[
                                                                        index]
                                                                    .userUid ==
                                                                User_ID
                                                            ? SizedBox()
                                                            : GestureDetector(
                                                                key: buttonKey,
                                                                onTap:
                                                                    () async {
                                                                  showPopupMenu1(
                                                                      context,
                                                                      index,
                                                                      buttonKey,
                                                                      getAllPostData
                                                                          .object?[
                                                                              index]
                                                                          .postUid,
                                                                      '_ProfileScreenState');
                                                                },
                                                                child: Container(
                                                                    height: 25,
                                                                    width: 40,
                                                                    color: Colors
                                                                        .transparent,
                                                                    child: Icon(
                                                                        Icons
                                                                            .more_vert_rounded)))
                                                  ],
                                                ),
                                              ),
                                              Text(
                                                getTimeDifference(
                                                    parsedDateTime),
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

                                      getAllPostData
                                                  .object?[index].description !=
                                              null
                                          ? Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 16),
                                              child: GestureDetector(
                                                  onTap: () async {
                                                    if (DataGet == true) {
                                                      await launch(
                                                          '${getAllPostData.object?[index].description}',
                                                          forceWebView: true,
                                                          enableJavaScript:
                                                              true);
                                                    } else {
                                                      Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                OpenSavePostImage(
                                                                  PostID: getAllPostData
                                                                      .object?[
                                                                          index]
                                                                      .postUid,
                                                                )),
                                                      );
                                                    }
                                                  },
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      /*                  GestureDetector(
                                                onTap: () async {

                                                                                String inputText = "${getAllPostData.object?[index].description}";
                                                                                String translatedTextGujarati = await translateText(inputText, 'gu');
                                                                                String translatedTextHindi = await translateText(inputText, 'hi');
                                                                                String translatedTextenglish = await translateText(inputText, 'en');

                                                                                if (getAllPostData.object?[index].isfalsehin == null && getAllPostData?.object?[index].isfalsegu == null) {
                                                  super.setState(() {
                                                    // _translatedTextGujarati = translatedTextGujarati;

                                                                                    _translatedTextHindi = translatedTextHindi;

                                                                                    // getAllPostData?.object?[index].description = _translatedTextGujarati;
                                                                                    getAllPostData?.object?[index].description = _translatedTextHindi;
                                                                                    getAllPostData?.object?[index].isfalsehin = true;
                                                                                  });
                                                                                } else if (getAllPostData?.object?[index].isfalsehin == true && getAllPostData?.object?[index].isfalsegu == null) {
                                                                                  super.setState(() {
                                                                                    _translatedTextGujarati = translatedTextGujarati;
                                                                                    // _translatedTextHindi = translatedTextHindi;

                                                                                    // getAllPostData?.object?[index].description = _translatedTextGujarati;
                                                                                    getAllPostData?.object?[index].description = _translatedTextGujarati;
                                                                                    getAllPostData?.object?[index].isfalsegu = true;
                                                                                  });
                                                                                } else if (getAllPostData?.object?[index].isfalsehin == true && getAllPostData?.object?[index].isfalsehin == true) {
                                                                                  print("this condison is working");

                                                                                  super.setState(() {
                                                                                    print("i'm cheaking dataa--------------------------------$initalData");
                                                                                    _translatedTextenglish = translatedTextenglish;
                                                                                    getAllPostData?.object?[index].description = _translatedTextenglish;
                                                                                    getAllPostData?.object?[index].isfalsegu = null;
                                                                                    getAllPostData?.object?[index].isfalsehin = null;
                                                                                  });
                                                                                }
                                                                              },
                                                                              child: Container(
                                                                                  width: 80,
                                                                                  decoration: BoxDecoration(color: ColorConstant.primaryLight_color, borderRadius: BorderRadius.circular(10)),
                                                                                  child: Center(
                                                                                      child: Text(
                                                                                    "Translate",
                                                                                    style: TextStyle(
                                                                                      fontFamily: 'outfit',
                                                                                      fontWeight: FontWeight.bold,
                                                                                    ),
                                                                                  ))),
                                                                            ), */
                                                      getAllPostData
                                                                  .object?[
                                                                      index]
                                                                  .translatedDescription !=
                                                              null
                                                          ? GestureDetector(
                                                              onTap: () async {
                                                                super.setState(
                                                                    () {
                                                                  if (getAllPostData
                                                                              .object?[
                                                                                  index]
                                                                              .isTrsnalteoption ==
                                                                          false ||
                                                                      getAllPostData
                                                                              .object?[index]
                                                                              .isTrsnalteoption ==
                                                                          null) {
                                                                    getAllPostData
                                                                        .object?[
                                                                            index]
                                                                        .isTrsnalteoption = true;
                                                                  } else {
                                                                    getAllPostData
                                                                        .object?[
                                                                            index]
                                                                        .isTrsnalteoption = false;
                                                                  }
                                                                });
                                                              },
                                                              child: Container(
                                                                  width: 80,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    color: ColorConstant
                                                                        .primaryLight_color,
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            10),
                                                                  ),
                                                                  child: Center(
                                                                      child:
                                                                          Text(
                                                                    "Translate",
                                                                    style:
                                                                        TextStyle(
                                                                      fontFamily:
                                                                          'outfit',
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                    ),
                                                                  ))),
                                                            )
                                                          : SizedBox(),
                                                      SizedBox(
                                                        height: 10,
                                                      ),
                                                      Row(
                                                        children: [
                                                          Expanded(
                                                            child: Container(
                                                              // color: Colors.amber,
                                                              child:
                                                                  LinkifyText(
                                                                getAllPostData.object?[index].isTrsnalteoption ==
                                                                            false ||
                                                                        getAllPostData.object?[index].isTrsnalteoption ==
                                                                            null
                                                                    ? "${getAllPostData.object?[index].description}"
                                                                    : "${getAllPostData.object?[index].translatedDescription}",
                                                                linkStyle:
                                                                    TextStyle(
                                                                  color: Colors
                                                                      .blue,
                                                                  fontFamily:
                                                                      'outfit',
                                                                ),
                                                                textStyle:
                                                                    TextStyle(
                                                                  color: Colors
                                                                      .black,
                                                                  fontFamily:
                                                                      'outfit',
                                                                ),
                                                                linkTypes: [
                                                                  LinkType.url,
                                                                  LinkType
                                                                      .userTag,
                                                                  LinkType
                                                                      .hashTag,
                                                                  // LinkType
                                                                  //     .email
                                                                ],
                                                                onTap:
                                                                    (link) async {
                                                                  /// do stuff with `link` like
                                                                  /// if(link.type == Link.url) launchUrl(link.value);

                                                                  var SelectedTest =
                                                                      link.value
                                                                          .toString();
                                                                  var Link = SelectedTest
                                                                      .startsWith(
                                                                          'https');
                                                                  var Link1 = SelectedTest
                                                                      .startsWith(
                                                                          'http');
                                                                  var Link2 = SelectedTest
                                                                      .startsWith(
                                                                          'www');
                                                                  var Link3 = SelectedTest
                                                                      .startsWith(
                                                                          'WWW');
                                                                  var Link4 = SelectedTest
                                                                      .startsWith(
                                                                          'HTTPS');
                                                                  var Link5 = SelectedTest
                                                                      .startsWith(
                                                                          'HTTP');
                                                                  var Link6 = SelectedTest
                                                                      .startsWith(
                                                                          'https://pdslink.page.link/');
                                                                  print(SelectedTest
                                                                      .toString());

                                                                  if (User_ID ==
                                                                      null) {
                                                                    Navigator.of(
                                                                            context)
                                                                        .push(MaterialPageRoute(
                                                                            builder: (context) =>
                                                                                RegisterCreateAccountScreen()));
                                                                  } else {
                                                                    if (Link ==
                                                                            true ||
                                                                        Link1 ==
                                                                            true ||
                                                                        Link2 ==
                                                                            true ||
                                                                        Link3 ==
                                                                            true ||
                                                                        Link4 ==
                                                                            true ||
                                                                        Link5 ==
                                                                            true ||
                                                                        Link6 ==
                                                                            true) {
                                                                      if (Link2 ==
                                                                              true ||
                                                                          Link3 ==
                                                                              true) {
                                                                        launchUrl(
                                                                            Uri.parse("https://${link.value.toString()}"));
                                                                        print(
                                                                            "qqqqqqqqhttps://${link.value}");
                                                                      } else {
                                                                        if (Link6 ==
                                                                            true) {
                                                                          print(
                                                                              "yes i am inList =   room");
                                                                          Navigator.push(
                                                                              context,
                                                                              MaterialPageRoute(
                                                                            builder:
                                                                                (context) {
                                                                              return NewBottomBar(
                                                                                buttomIndex: 1,
                                                                              );
                                                                            },
                                                                          ));
                                                                        } else {
                                                                          launchUrl(Uri.parse(link
                                                                              .value
                                                                              .toString()));
                                                                          print(
                                                                              "link.valuelink.value -- ${link.value}");
                                                                        }
                                                                      }
                                                                    } else {
                                                                      if (link
                                                                          .value!
                                                                          .startsWith(
                                                                              '#')) {
                                                                        /*  await BlocProvider.of<
                                                                      GetGuestAllPostCubit>(
                                                                  context)
                                                              .seetinonExpried(
                                                                  context); */
                                                                        Navigator.push(
                                                                            context,
                                                                            MaterialPageRoute(
                                                                              builder: (context) => HashTagViewScreen(title: "${link.value}"),
                                                                            ));
                                                                      } else if (link
                                                                          .value!
                                                                          .startsWith(
                                                                              '@')) {
                                                                        /*  await BlocProvider.of<
                                                                      GetGuestAllPostCubit>(
                                                                  context)
                                                              .seetinonExpried(
                                                                  context); */
                                                                        var name;
                                                                        var tagName;
                                                                        name =
                                                                            SelectedTest;
                                                                        tagName = name.replaceAll(
                                                                            "@",
                                                                            "");
                                                                        await BlocProvider.of<NewProfileSCubit>(context).UserTagAPI(
                                                                            context,
                                                                            tagName);

                                                                        Navigator.push(
                                                                            context,
                                                                            MaterialPageRoute(builder:
                                                                                (context) {
                                                                          return ProfileScreen(
                                                                              User_ID: "${userTagModel?.object}",
                                                                              isFollowing: "");
                                                                        })).then((value) =>
                                                                            Get_UserToken());

                                                                        print(
                                                                            "tagName -- ${tagName}");
                                                                        print(
                                                                            "user id -- ${userTagModel?.object}");
                                                                      } else {
                                                                        launchUrl(
                                                                            Uri.parse("https://${link.value.toString()}"));
                                                                      }
                                                                    }
                                                                  }
                                                                },
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  )),
                                            )
                                          : SizedBox(),

                                      (getAllPostData.object?[index].postData
                                                  ?.isEmpty ??
                                              false)
                                          ? SizedBox()
                                          : Container(
                                              // height: 200,
                                              width: _width,
                                              child: getAllPostData
                                                          .object?[index]
                                                          .postDataType ==
                                                      null
                                                  ? SizedBox()
                                                  : getAllPostData
                                                              .object?[index]
                                                              .postData
                                                              ?.length ==
                                                          1
                                                      ? (getAllPostData
                                                                  .object?[
                                                                      index]
                                                                  .postDataType ==
                                                              "IMAGE"
                                                          ? GestureDetector(
                                                              onTap: () {
                                                                Navigator.push(
                                                                  context,
                                                                  MaterialPageRoute(
                                                                      builder:
                                                                          (context) =>
                                                                              OpenSavePostImage(
                                                                                PostID: getAllPostData.object?[index].postUid,
                                                                                index: index,
                                                                              )),
                                                                );
                                                              },
                                                              child: Container(
                                                                height: 200,
                                                                width: _width,
                                                                margin: EdgeInsets
                                                                    .only(
                                                                        left:
                                                                            16,
                                                                        top: 15,
                                                                        right:
                                                                            16),
                                                                child: Center(
                                                                    child:
                                                                        CustomImageView(
                                                                  url:
                                                                      "${getAllPostData.object?[index].postData?[0]}",
                                                                )),
                                                              ),
                                                            )
                                                          : getAllPostData
                                                                      .object?[
                                                                          index]
                                                                      .postDataType ==
                                                                  "VIDEO"
                                                              ? /* repostControllers[0].value.isInitialized
                                                                                    ?   */
                                                              Padding(
                                                                  padding: const EdgeInsets
                                                                          .only(
                                                                      right: 20,
                                                                      top: 15),
                                                                  child: Column(
                                                                    mainAxisSize:
                                                                        MainAxisSize
                                                                            .min,
                                                                    children: [
                                                                      Container(
                                                                        // height: 180,
                                                                        width:
                                                                            _width,
                                                                        child:
                                                                            VideoListItem1(
                                                                          videoUrl:
                                                                              videoUrls[index],
                                                                          PostID: getAllPostData
                                                                              .object?[index]
                                                                              .postUid,
                                                                          /*  isData:
                                                                User_ID == null
                                                                    ? false
                                                                    : true, */
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                )
                                                              // : SizedBox()
                                                              //this is the ATTACHMENT
                                                              : getAllPostData
                                                                          .object?[
                                                                              index]
                                                                          .postDataType ==
                                                                      "ATTACHMENT"
                                                                  ? (getAllPostData
                                                                              .object?[index]
                                                                              .postData
                                                                              ?.isNotEmpty ==
                                                                          true)
                                                                      ? /* Container(
                                                                                            height: 200,
                                                                                            width: _width,
                                                                                            child: DocumentViewScreen1(
                                                                                              path: getAllPostData?.object?[index].postData?[0].toString(),
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
                                                                                print("objectobjectobjectobject");
                                                                                Navigator.push(context, MaterialPageRoute(
                                                                                  builder: (context) {
                                                                                    return DocumentViewScreen1(
                                                                                      path: getAllPostData.object?[index].postData?[0].toString(),
                                                                                    );
                                                                                  },
                                                                                ));
                                                                              },
                                                                              child: Container(
                                                                                child: CachedNetworkImage(
                                                                                  imageUrl: getAllPostData.object?[index].thumbnailImageUrl ?? "",
                                                                                  fit: BoxFit.cover,
                                                                                ),
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
                                                                if ((getAllPostData
                                                                        .object?[
                                                                            index]
                                                                        .postData
                                                                        ?.isNotEmpty ??
                                                                    false)) ...[
                                                                  SizedBox(
                                                                    height: 200,
                                                                    child: PageView
                                                                        .builder(
                                                                      onPageChanged:
                                                                          (page) {
                                                                        super.setState(
                                                                            () {
                                                                          _currentPages[index] =
                                                                              page;
                                                                          imageCount1 =
                                                                              page + 1;
                                                                        });
                                                                      },
                                                                      controller:
                                                                          _pageControllers[
                                                                              index],
                                                                      itemCount: getAllPostData
                                                                          .object?[
                                                                              index]
                                                                          .postData
                                                                          ?.length,
                                                                      itemBuilder:
                                                                          (BuildContext context,
                                                                              int index1) {
                                                                        if (getAllPostData.object?[index].postDataType ==
                                                                            "IMAGE") {
                                                                          return Container(
                                                                            width:
                                                                                _width,
                                                                            margin: EdgeInsets.only(
                                                                                left: 16,
                                                                                top: 15,
                                                                                right: 16),
                                                                            child: Center(
                                                                                child: GestureDetector(
                                                                              onTap: () {
                                                                                Navigator.push(
                                                                                  context,
                                                                                  MaterialPageRoute(
                                                                                      builder: (context) => OpenSavePostImage(
                                                                                            PostID: getAllPostData.object?[index].postUid,
                                                                                            index: index1,
                                                                                          )),
                                                                                );
                                                                              },
                                                                              child: Stack(
                                                                                children: [
                                                                                  Align(
                                                                                    alignment: Alignment.topCenter,
                                                                                    child: CustomImageView(
                                                                                      url: "${getAllPostData.object?[index].postData?[index1]}",
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
                                                                                            imageCount1.toString() + '/' + '${getAllPostData.object?[index].postData?.length}',
                                                                                            style: TextStyle(color: Colors.white),
                                                                                          )),
                                                                                    ),
                                                                                  )
                                                                                ],
                                                                              ),
                                                                            )),
                                                                          );
                                                                        } else if (getAllPostData.object?[index].postDataType ==
                                                                            "ATTACHMENT") {
                                                                          return Container(
                                                                              height: 200,
                                                                              width: _width,
                                                                              child: DocumentViewScreen1(
                                                                                path: getAllPostData.object?[index].postData?[index1].toString(),
                                                                              ));
                                                                        }
                                                                      },
                                                                    ),
                                                                  ),
                                                                  Positioned(
                                                                      bottom: 5,
                                                                      left: 0,
                                                                      right: 0,
                                                                      child:
                                                                          Padding(
                                                                        padding:
                                                                            const EdgeInsets.only(top: 0),
                                                                        child:
                                                                            Container(
                                                                          height:
                                                                              20,
                                                                          child:
                                                                              DotsIndicator(
                                                                            dotsCount:
                                                                                getAllPostData.object?[index].postData?.length ?? 0,
                                                                            position:
                                                                                _currentPages[index].toDouble(),
                                                                            decorator:
                                                                                DotsDecorator(
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
                                      // inner post portion

                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 10,
                                            right: 10,
                                            bottom: 10,
                                            top: 20),
                                        child: Container(
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              border: Border.all(
                                                  color: Colors.grey.shade200),
                                              borderRadius:
                                                  BorderRadius.circular(15)),
                                          // height: 300,
                                          width: _width,
                                          child: Column(
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
                                                      /*    await BlocProvider.of<
                                                GetGuestAllPostCubit>(context)
                                            .seetinonExpried(context); */
                                                      Navigator.push(context,
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
                                                            child: ProfileScreen(
                                                                User_ID:
                                                                    "${getAllPostData.object?[index].repostOn?.userUid}",
                                                                isFollowing:
                                                                    getAllPostData
                                                                        .object?[
                                                                            index]
                                                                        .repostOn
                                                                        ?.isFollowing));
                                                      })).then((value) =>
                                                          Get_UserToken());
                                                      //
                                                    },
                                                    child: getAllPostData
                                                                    .object?[
                                                                        index]
                                                                    .repostOn
                                                                    ?.userProfilePic !=
                                                                null &&
                                                            getAllPostData
                                                                    .object?[
                                                                        index]
                                                                    .repostOn
                                                                    ?.userProfilePic !=
                                                                ""
                                                        ? CircleAvatar(
                                                            backgroundImage:
                                                                NetworkImage(
                                                                    "${getAllPostData.object?[index].repostOn?.userProfilePic}"),
                                                            backgroundColor:
                                                                Colors.white,
                                                            radius: 25,
                                                          )
                                                        : CustomImageView(
                                                            imagePath:
                                                                ImageConstant
                                                                    .tomcruse,
                                                            height: 50,
                                                            width: 50,
                                                            fit: BoxFit.fill,
                                                            radius: BorderRadius
                                                                .circular(25),
                                                          ),
                                                  ),
                                                  title: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      GestureDetector(
                                                        onTap: () async {
                                                          /*    await BlocProvider.of<
                                                          GetGuestAllPostCubit>(
                                                      context)
                                                  .seetinonExpried(context); */
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
                                                                child: ProfileScreen(
                                                                    User_ID:
                                                                        "${getAllPostData.object?[index].repostOn?.userUid}",
                                                                    isFollowing: getAllPostData
                                                                        .object?[
                                                                            index]
                                                                        .repostOn
                                                                        ?.isFollowing));
                                                          })).then((value) =>
                                                              Get_UserToken());
                                                          //
                                                        },
                                                        child: Container(
                                                          // color:
                                                          // Colors.amber,
                                                          child: Text(
                                                            "${getAllPostData.object?[index].repostOn?.postUserName}",
                                                            style: TextStyle(
                                                                fontSize: 20,
                                                                fontFamily:
                                                                    "outfit",
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ),
                                                        ),
                                                      ),
                                                      Text(
                                                        getAllPostData
                                                                    .object?[
                                                                        index]
                                                                    .repostOn ==
                                                                null
                                                            ? ""
                                                            : getTimeDifference(
                                                                repostTime!),
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
                                              getAllPostData
                                                          .object?[index]
                                                          .repostOn
                                                          ?.description !=
                                                      null
                                                  ? Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 16),
                                                      child: LinkifyText(
                                                        "${getAllPostData.object?[index].repostOn?.description}",
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

                                                          var SelectedTest =
                                                              link.value
                                                                  .toString();
                                                          var Link =
                                                              SelectedTest
                                                                  .startsWith(
                                                                      'https');
                                                          var Link1 =
                                                              SelectedTest
                                                                  .startsWith(
                                                                      'http');
                                                          var Link2 =
                                                              SelectedTest
                                                                  .startsWith(
                                                                      'www');
                                                          var Link3 =
                                                              SelectedTest
                                                                  .startsWith(
                                                                      'WWW');
                                                          var Link4 =
                                                              SelectedTest
                                                                  .startsWith(
                                                                      'HTTPS');
                                                          var Link5 =
                                                              SelectedTest
                                                                  .startsWith(
                                                                      'HTTP');
                                                          var Link6 = SelectedTest
                                                              .startsWith(
                                                                  'https://pdslink.page.link/');
                                                          print(SelectedTest
                                                              .toString());

                                                          if (User_ID == null) {
                                                            Navigator.of(
                                                                    context)
                                                                .push(MaterialPageRoute(
                                                                    builder:
                                                                        (context) =>
                                                                            RegisterCreateAccountScreen()));
                                                          } else {
                                                            if (Link == true ||
                                                                Link1 == true ||
                                                                Link2 == true ||
                                                                Link3 == true ||
                                                                Link4 == true ||
                                                                Link5 == true ||
                                                                Link6 == true) {
                                                              if (Link2 ==
                                                                      true ||
                                                                  Link3 ==
                                                                      true) {
                                                                launchUrl(Uri.parse(
                                                                    "https://${link.value.toString()}"));
                                                                print(
                                                                    "qqqqqqqqhttps://${link.value}");
                                                              } else {
                                                                if (Link6 ==
                                                                    true) {
                                                                  print(
                                                                      "yes i am inList =   room");
                                                                  Navigator.push(
                                                                      context,
                                                                      MaterialPageRoute(
                                                                    builder:
                                                                        (context) {
                                                                      return NewBottomBar(
                                                                        buttomIndex:
                                                                            1,
                                                                      );
                                                                    },
                                                                  ));
                                                                } else {
                                                                  launchUrl(Uri
                                                                      .parse(link
                                                                          .value
                                                                          .toString()));
                                                                  print(
                                                                      "link.valuelink.value -- ${link.value}");
                                                                }
                                                              }
                                                            } else {
                                                              if (link.value!
                                                                  .startsWith(
                                                                      '#')) {
                                                                /*   await BlocProvider.of<
                                                              GetGuestAllPostCubit>(
                                                          context)
                                                      .seetinonExpried(context); */
                                                                print(
                                                                    "aaaaaaaaaa == ${link}");
                                                                Navigator.push(
                                                                    context,
                                                                    MaterialPageRoute(
                                                                      builder: (context) =>
                                                                          HashTagViewScreen(
                                                                              title: "${link.value}"),
                                                                    ));
                                                              } else if (link
                                                                  .value!
                                                                  .startsWith(
                                                                      '@')) {
                                                                /*  await BlocProvider.of<
                                                              GetGuestAllPostCubit>(
                                                          context)
                                                      .seetinonExpried(context); */
                                                                var name;
                                                                var tagName;
                                                                name =
                                                                    SelectedTest;
                                                                tagName = name
                                                                    .replaceAll(
                                                                        "@",
                                                                        "");
                                                                await BlocProvider.of<
                                                                            NewProfileSCubit>(
                                                                        context)
                                                                    .UserTagAPI(
                                                                        context,
                                                                        tagName);

                                                                Navigator.push(
                                                                    context,
                                                                    MaterialPageRoute(
                                                                        builder:
                                                                            (context) {
                                                                  return ProfileScreen(
                                                                      User_ID:
                                                                          "${userTagModel?.object}",
                                                                      isFollowing:
                                                                          "");
                                                                })).then((value) =>
                                                                    Get_UserToken());

                                                                print(
                                                                    "tagName -- ${tagName}");
                                                                print(
                                                                    "user id -- ${userTagModel?.object}");
                                                              }
                                                            }
                                                          }
                                                        },
                                                      ))
                                                  : SizedBox(),
                                              Container(
                                                width: _width,
                                                child: getAllPostData
                                                            .object?[index]
                                                            .repostOn
                                                            ?.postDataType ==
                                                        null
                                                    ? SizedBox()
                                                    : getAllPostData
                                                                .object?[index]
                                                                .repostOn
                                                                ?.postData
                                                                ?.length ==
                                                            1
                                                        ? (getAllPostData
                                                                    .object?[
                                                                        index]
                                                                    .repostOn
                                                                    ?.postDataType ==
                                                                "IMAGE"
                                                            ? GestureDetector(
                                                                onTap: () {
                                                                  Navigator
                                                                      .push(
                                                                    context,
                                                                    MaterialPageRoute(
                                                                        builder: (context) =>
                                                                            OpenSavePostImage(
                                                                              PostID: getAllPostData.object?[index].repostOn?.postUid,
                                                                              index: index,
                                                                            )),
                                                                  );
                                                                },
                                                                child:
                                                                    Container(
                                                                  width: _width,
                                                                  height: 150,
                                                                  margin: EdgeInsets
                                                                      .only(
                                                                          left:
                                                                              16,
                                                                          top:
                                                                              15,
                                                                          right:
                                                                              16),
                                                                  child: Center(
                                                                      child:
                                                                          CustomImageView(
                                                                    url:
                                                                        "${getAllPostData.object?[index].repostOn?.postData?[0]}",
                                                                  )),
                                                                ),
                                                              )
                                                            : getAllPostData
                                                                        .object?[
                                                                            index]
                                                                        .repostOn
                                                                        ?.postDataType ==
                                                                    "VIDEO"
                                                                ? /* repostMainControllers[0].value.isInitialized
                                                                                      ? */
                                                                Padding(
                                                                    padding: const EdgeInsets
                                                                            .only(
                                                                        right:
                                                                            20,
                                                                        top:
                                                                            15),
                                                                    child:
                                                                        Column(
                                                                      mainAxisSize:
                                                                          MainAxisSize
                                                                              .min,
                                                                      children: [
                                                                        VideoListItem1(
                                                                          videoUrl:
                                                                              videoUrls[index],
                                                                          discrption: getAllPostData
                                                                              .object?[index]
                                                                              .repostOn
                                                                              ?.description,
                                                                          PostID: getAllPostData
                                                                              .object?[index]
                                                                              .postUid,
                                                                          /*  isData:
                                                                User_ID == null
                                                                    ? false
                                                                    : true, */
                                                                        )
                                                                      ],
                                                                    ),
                                                                  )
                                                                // : SizedBox()
                                                                : getAllPostData
                                                                            .object?[index]
                                                                            .repostOn
                                                                            ?.postDataType ==
                                                                        "ATTACHMENT"
                                                                    ? Stack(
                                                                        children: [
                                                                          Container(
                                                                            height:
                                                                                400,
                                                                            width:
                                                                                _width,
                                                                            color:
                                                                                Colors.transparent,
                                                                          ),
                                                                          GestureDetector(
                                                                            onTap:
                                                                                () {
                                                                              print("objectobjectobjectobject");
                                                                              Navigator.push(context, MaterialPageRoute(
                                                                                builder: (context) {
                                                                                  return DocumentViewScreen1(
                                                                                    path: getAllPostData.object?[index].repostOn?.postData?[0].toString(),
                                                                                  );
                                                                                },
                                                                              ));
                                                                            },
                                                                            child:
                                                                                Container(
                                                                              child: CachedNetworkImage(
                                                                                imageUrl: getAllPostData.object?[index].repostOn?.thumbnailImageUrl ?? "",
                                                                                fit: BoxFit.cover,
                                                                              ),
                                                                            ),
                                                                          )
                                                                        ],
                                                                      )
                                                                    : SizedBox())
                                                        : Column(
                                                            children: [
                                                              Stack(
                                                                children: [
                                                                  if ((getAllPostData
                                                                          .object?[
                                                                              index]
                                                                          .repostOn
                                                                          ?.postData
                                                                          ?.isNotEmpty ??
                                                                      false)) ...[
                                                                    SizedBox(
                                                                      height:
                                                                          300,
                                                                      child: PageView
                                                                          .builder(
                                                                        onPageChanged:
                                                                            (page) {
                                                                          super.setState(
                                                                              () {
                                                                            _currentPages[index] =
                                                                                page;
                                                                            imageCount2 =
                                                                                page + 1;
                                                                          });
                                                                        },
                                                                        controller:
                                                                            _pageControllers[index],
                                                                        itemCount: getAllPostData
                                                                            .object?[index]
                                                                            .repostOn
                                                                            ?.postData
                                                                            ?.length,
                                                                        itemBuilder:
                                                                            (BuildContext context,
                                                                                int index1) {
                                                                          if (getAllPostData.object?[index].repostOn?.postDataType ==
                                                                              "IMAGE") {
                                                                            return GestureDetector(
                                                                              onTap: () {
                                                                                print("Repost Opne Full screen");

                                                                                Navigator.push(
                                                                                  context,
                                                                                  MaterialPageRoute(
                                                                                      builder: (context) => OpenSavePostImage(
                                                                                            PostID: getAllPostData.object?[index].repostOn?.postUid,
                                                                                            index: index1,
                                                                                          )),
                                                                                );
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
                                                                                        url: "${getAllPostData.object?[index].repostOn?.postData?[index1]}",
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
                                                                                              imageCount2.toString() + '/' + '${getAllPostData.object?[index].repostOn?.postData?.length}',
                                                                                              style: TextStyle(color: Colors.white),
                                                                                            )),
                                                                                      ),
                                                                                    )
                                                                                  ],
                                                                                )),
                                                                              ),
                                                                            );
                                                                          } else if (getAllPostData.object?[index].repostOn?.postDataType ==
                                                                              "ATTACHMENT") {
                                                                            return Container(
                                                                                height: 400,
                                                                                width: _width,
                                                                                child: DocumentViewScreen1(
                                                                                  path: getAllPostData.object?[index].repostOn?.postData?[index1].toString(),
                                                                                ));
                                                                          }
                                                                        },
                                                                      ),
                                                                    ),
                                                                    Positioned(
                                                                        bottom:
                                                                            5,
                                                                        left: 0,
                                                                        right:
                                                                            0,
                                                                        child:
                                                                            Padding(
                                                                          padding:
                                                                              const EdgeInsets.only(top: 0),
                                                                          child:
                                                                              Container(
                                                                            height:
                                                                                20,
                                                                            child:
                                                                                DotsIndicator(
                                                                              dotsCount: getAllPostData.object?[index].repostOn?.postData?.length ?? 1,
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
                                            const EdgeInsets.only(left: 13),
                                        child: Divider(
                                          thickness: 1,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            top: 0, right: 16),
                                        child: Row(
                                          children: [
                                            SizedBox(
                                              width: 14,
                                            ),
                                            GestureDetector(
                                              onTap: () async {
                                                await soicalFunation(
                                                    apiName: 'like_post',
                                                    index: index);
                                              },
                                              child: Container(
                                                color: Colors.transparent,
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(5.0),
                                                  child: getAllPostData
                                                              .object?[index]
                                                              .isLiked !=
                                                          true
                                                      ? Image.asset(
                                                          ImageConstant
                                                              .likewithout,
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
                                              width: 0,
                                            ),
                                            getAllPostData.object?[index]
                                                        .likedCount ==
                                                    0
                                                ? SizedBox()
                                                : GestureDetector(
                                                    onTap: () {
                                                      /* Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                       
                                                            ShowAllPostLike("${getAllPostData?.object?[index].postUid}"))); */

                                                      Navigator.push(context,
                                                          MaterialPageRoute(
                                                        builder: (context) {
                                                          return ShowAllPostLike(
                                                              "${getAllPostData.object?[index].postUid}");
                                                        },
                                                      ));
                                                    },
                                                    child: Container(
                                                      color: Colors.transparent,
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(5.0),
                                                        child: Text(
                                                          "${getAllPostData.object?[index].likedCount}",
                                                          style: TextStyle(
                                                              fontFamily:
                                                                  "outfit",
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
                                                    .Addcomment(context,
                                                        '${getAllPostData.object?[index].postUid}');

                                                _settingModalBottomSheet1(
                                                    context, index, _height);
                                              },
                                              child: Container(
                                                color: Colors.transparent,
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(5.0),
                                                  child: Image.asset(
                                                    ImageConstant.meesage,
                                                    height: 15,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            getAllPostData.object?[index]
                                                        .commentCount ==
                                                    0
                                                ? SizedBox()
                                                : Text(
                                                    "${getAllPostData.object?[index].commentCount}",
                                                    style: TextStyle(
                                                        fontFamily: "outfit",
                                                        fontSize: 14),
                                                  ),
                                            SizedBox(
                                              width: 8,
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                rePostBottomSheet(
                                                    context, index);
                                              },
                                              child: Container(
                                                color: Colors.transparent,
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(5.0),
                                                  child: Image.asset(
                                                    ImageConstant.vector2,
                                                    height: 13,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            getAllPostData.object?[index]
                                                            .repostCount ==
                                                        null ||
                                                    getAllPostData
                                                            .object?[index]
                                                            .repostCount ==
                                                        0
                                                ? SizedBox()
                                                : Text(
                                                    '${getAllPostData.object?[index].repostCount}',
                                                    style: TextStyle(
                                                        fontFamily: "outfit",
                                                        fontSize: 14),
                                                  ),
                                            GestureDetector(
                                              onTap: () {
                                                _onShareXFileFromAssets(context,
                                                    androidLink:
                                                        '${getAllPostData.object?[index].postLink}'
                                                    /* iosLink:
                                                      "https://apps.apple.com/inList =  /app/growder-b2b-platform/id6451333863" */
                                                    );
                                              },
                                              child: Container(
                                                height: 20,
                                                width: 30,
                                                color: Colors.transparent,
                                                child: Icon(Icons.share_rounded,
                                                    size: 20),
                                              ),
                                            ),
                                            Spacer(),
                                            GestureDetector(
                                              onTap: () async {
                                                await soicalFunation(
                                                    apiName: 'savedata',
                                                    index: index);
                                              },
                                              child: Container(
                                                color: Colors.transparent,
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(5.0),
                                                  child: Image.asset(
                                                    getAllPostData
                                                                .object?[index]
                                                                .isSaved ==
                                                            false
                                                        ? ImageConstant.savePin
                                                        : ImageConstant
                                                            .Savefill,
                                                    height: 17,
                                                  ),
                                                ),
                                              ),
                                            ),
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
                          : getAllPostData.object?[index].isReports == true
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
                                              ImageConstant.greenseen)),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        'Thanks for reporting',
                                        style: TextStyle(color: Colors.black),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        'Post Reported and under review',
                                        style: TextStyle(color: Colors.grey),
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                    ],
                                  ),
                                )
                              : Padding(
                                  padding: EdgeInsets.only(
                                      left: 0, right: 0, top: 10, bottom: 10),
                                  child: GestureDetector(
                                    onDoubleTap: () async {
                                      await soicalFunation(
                                          apiName: 'like_post', index: index);
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        border: Border.all(
                                            color:
                                                Color.fromRGBO(0, 0, 0, 0.25)),
                                        /* borderRadius:
                                              BorderRadius.circular(15) */
                                      ),
                                      // height: 300,
                                      width: _width,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Container(
                                            height: 60,
                                            // color: Colors.amber,
                                            child: ListTile(
                                                leading: GestureDetector(
                                                  onTap: () async {
                                                    /*   await BlocProvider.of<GetGuestAllPostCubit>(
                                        context)
                                    .seetinonExpried(context); */
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
                                                                  "${getAllPostData.object?[index].userUid}",
                                                              isFollowing:
                                                                  getAllPostData
                                                                      .object?[
                                                                          index]
                                                                      .isFollowing));
                                                    })).then((value) =>
                                                        Get_UserToken());
                                                    //
                                                  },
                                                  child: getAllPostData
                                                                  .object?[
                                                                      index]
                                                                  .userProfilePic !=
                                                              null &&
                                                          getAllPostData
                                                                  .object?[
                                                                      index]
                                                                  .userProfilePic !=
                                                              ""
                                                      ? CircleAvatar(
                                                          backgroundImage:
                                                              NetworkImage(
                                                                  "${getAllPostData.object?[index].userProfilePic}"),
                                                          backgroundColor:
                                                              Colors.white,
                                                          radius: 25,
                                                        )
                                                      : CustomImageView(
                                                          imagePath:
                                                              ImageConstant
                                                                  .tomcruse,
                                                          height: 50,
                                                          width: 50,
                                                          fit: BoxFit.fill,
                                                          radius: BorderRadius
                                                              .circular(25),
                                                        ),
                                                ),
                                                title: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    // SizedBox(
                                                    //   height: 6,
                                                    // ),
                                                    GestureDetector(
                                                      onTap: () async {
                                                        /*    await BlocProvider.of<GetGuestAllPostCubit>(
                                            context)
                                        .seetinonExpried(context); */
                                                        Navigator.push(context,
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
                                                              child: ProfileScreen(
                                                                  User_ID:
                                                                      "${getAllPostData.object?[index].userUid}",
                                                                  isFollowing: getAllPostData
                                                                      .object?[
                                                                          index]
                                                                      .isFollowing));
                                                        })).then((value) =>
                                                            Get_UserToken());
                                                        //
                                                      },
                                                      child: Row(
                                                        children: [
                                                          Container(
                                                            // color: Colors.red,
                                                            child: Text(
                                                              "${getAllPostData.object?[index].postUserName}",
                                                              style: TextStyle(
                                                                  fontSize: 20,
                                                                  fontFamily:
                                                                      "outfit",
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            ),
                                                          ),
                                                          /*  Spacer(),
                                                getAllPostData.object?[index]
                                                            .userUid ==
                                                        User_ID
                                                    ? GestureDetector(
                                                        key: buttonKey,
                                                        onTap: () {
                                                          showPopupMenu(
                                                              context,
                                                              index,
                                                              buttonKey,
                                                              getAllPostData);
                                                        },
                                                        child: Icon(
                                                          Icons.abc,
                                                        ),
                                                      )
                                                    : SizedBox() */
                                                        ],
                                                      ),
                                                    ),
                                                    //FIndText
                                                    Text(
                                                      getTimeDifference(
                                                          parsedDateTime),
                                                      style: TextStyle(
                                                        fontSize: 12,
                                                        fontFamily: "outfit",
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                trailing: getAllPostData
                                                            .object?[index]
                                                            .userUid !=
                                                        User_ID
                                                    ? GestureDetector(
                                                        key: buttonKey,
                                                        onTap: () async {
                                                          showPopupMenu1(
                                                              context,
                                                              index,
                                                              buttonKey,
                                                              getAllPostData
                                                                  .object?[
                                                                      index]
                                                                  .postUid,
                                                              '_ProfileScreenState');
                                                        },
                                                        child: Container(
                                                            height: 25,
                                                            width: 40,
                                                            /*   color: Color.fromARGB(
                                                    219, 189, 3, 3), */
                                                            child: Icon(Icons
                                                                .more_vert_rounded)))
                                                    : Container(
                                                        height: 25,
                                                        width: 40,
                                                        child: GestureDetector(
                                                          key: buttonKey,
                                                          onTap: () {
                                                            showPopupMenu(
                                                                context,
                                                                index,
                                                                buttonKey,
                                                                getAllPostData);
                                                          },
                                                          child: Icon(
                                                            Icons
                                                                .more_vert_outlined,
                                                          ),
                                                        ),
                                                      )),
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          getAllPostData.object?[index]
                                                      .description !=
                                                  null
                                              ? Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 16),
                                                  child:
                                                      //this is the despcation
                                                      GestureDetector(
                                                          onTap: () async {
                                                            if (DataGet ==
                                                                true) {
                                                              await launch(
                                                                  '${getAllPostData.object?[index].description}',
                                                                  forceWebView:
                                                                      true,
                                                                  enableJavaScript:
                                                                      true);
                                                            } else {
                                                              Navigator.push(
                                                                context,
                                                                MaterialPageRoute(
                                                                    builder:
                                                                        (context) =>
                                                                            OpenSavePostImage(
                                                                              PostID: getAllPostData.object?[index].postUid,
                                                                            )),
                                                              );
                                                            }
                                                          },
                                                          child: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              /*  GestureDetector(
                                                                              onTap: () async {
                                                                                print("value cheak${getAllPostData?.object?[index].isfalsegu}");
                                                                                print("value cheak${getAllPostData?.object?[index].isfalsehin}");
                                                                                String inputText = "${getAllPostData?.object?[index].description}";
                                                                                String translatedTextGujarati = await translateText(inputText, 'gu');
                                                                                String translatedTextHindi = await translateText(inputText, 'hi');
                                                                                String translatedTextenglish = await translateText(inputText, 'en');

                                                                                if (getAllPostData?.object?[index].isfalsehin == null && getAllPostData?.object?[index].isfalsegu == null) {
                                                                                  super.setState(() {
                                                                                    _translatedTextHindi = translatedTextHindi;

                                                                                    // getAllPostData?.object?[index].description = _translatedTextGujarati;
                                                                                    getAllPostData?.object?[index].description = _translatedTextHindi;
                                                                                    getAllPostData?.object?[index].isfalsehin = true;
                                                                                  });
                                                                                } else if (getAllPostData?.object?[index].isfalsehin == true && getAllPostData?.object?[index].isfalsegu == null) {
                                                                                  super.setState(() {
                                                                                    // isDataSet = false;
                                                                                    _translatedTextGujarati = translatedTextGujarati;
                                                                                    // _translatedTextHindi = translatedTextHindi;

                                                                                    // getAllPostData?.object?[index].description = _translatedTextGujarati;
                                                                                    getAllPostData?.object?[index].description = _translatedTextGujarati;
                                                                                    getAllPostData?.object?[index].isfalsegu = true;
                                                                                    //  isDataSet = true;
                                                                                  });
                                                                                } else if (getAllPostData?.object?[index].isfalsehin == true && getAllPostData?.object?[index].isfalsehin == true) {
                                                                                  print("this condison is working");

                                                                                  super.setState(() {
                                                                                    print("i'm cheaking dataa--------------------------------$initalData");
                                                                                    // isDataSet = false;
                                                                                    _translatedTextenglish = translatedTextenglish;
                                                                                    getAllPostData?.object?[index].description = _translatedTextenglish;
                                                                                    getAllPostData?.object?[index].isfalsegu = null;
                                                                                    getAllPostData?.object?[index].isfalsehin = null;
                                                                                    // isDataSet = true;
                                                                                  });
                                                                                }
                                                                              },
                                                                              child: Container(
                                                                                  width: 80,
                                                                                  decoration: BoxDecoration(color: ColorConstant.primaryLight_color, borderRadius: BorderRadius.circular(10)),
                                                                                  child: Center(
                                                                                      child: Text(
                                                                                    "Translate",
                                                                                    style: TextStyle(
                                                                                      fontFamily: 'outfit',
                                                                                      fontWeight: FontWeight.bold,
                                                                                    ),
                                                                                  ))),
                                                                            ), */
                                                              getAllPostData
                                                                          .object?[
                                                                              index]
                                                                          .translatedDescription !=
                                                                      null
                                                                  ? GestureDetector(
                                                                      onTap:
                                                                          () async {
                                                                        super.setState(
                                                                            () {
                                                                          if (getAllPostData.object?[index].isTrsnalteoption == false ||
                                                                              getAllPostData.object?[index].isTrsnalteoption == null) {
                                                                            getAllPostData.object?[index].isTrsnalteoption =
                                                                                true;
                                                                          } else {
                                                                            getAllPostData.object?[index].isTrsnalteoption =
                                                                                false;
                                                                          }
                                                                        });
                                                                      },
                                                                      child: Container(
                                                                          width: 80,
                                                                          decoration: BoxDecoration(
                                                                            color:
                                                                                ColorConstant.primaryLight_color,
                                                                            borderRadius:
                                                                                BorderRadius.circular(10),
                                                                          ),
                                                                          child: Center(
                                                                              child: Text(
                                                                            "Translate",
                                                                            style:
                                                                                TextStyle(
                                                                              fontFamily: 'outfit',
                                                                              fontWeight: FontWeight.bold,
                                                                            ),
                                                                          ))),
                                                                    )
                                                                  : SizedBox(),
                                                              SizedBox(
                                                                // color: Colors.red,
                                                                height: 10,
                                                              ),
                                                              Row(
                                                                children: [
                                                                  Expanded(
                                                                    child:
                                                                        Container(
                                                                      child:
                                                                          LinkifyText(
                                                                        getAllPostData.object?[index].isTrsnalteoption == false ||
                                                                                getAllPostData.object?[index].isTrsnalteoption == null
                                                                            ? "${getAllPostData.object?[index].description}"
                                                                            : "${getAllPostData.object?[index].translatedDescription}",
                                                                        linkStyle:
                                                                            TextStyle(
                                                                          color:
                                                                              Colors.blue,
                                                                          fontFamily:
                                                                              'outfit',
                                                                        ),
                                                                        textStyle:
                                                                            TextStyle(
                                                                          color:
                                                                              Colors.black,
                                                                          fontFamily:
                                                                              'outfit',
                                                                        ),
                                                                        linkTypes: [
                                                                          LinkType
                                                                              .url,
                                                                          LinkType
                                                                              .userTag,
                                                                          LinkType
                                                                              .hashTag,
                                                                          // LinkType
                                                                          //     .email
                                                                        ],
                                                                        onTap:
                                                                            (link) async {
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
                                                                          var Link3 =
                                                                              SelectedTest.startsWith('WWW');
                                                                          var Link4 =
                                                                              SelectedTest.startsWith('HTTPS');
                                                                          var Link5 =
                                                                              SelectedTest.startsWith('HTTP');
                                                                          var Link6 =
                                                                              SelectedTest.startsWith('https://pdslink.page.link/');
                                                                          print("tag -- " +
                                                                              SelectedTest.toString());

                                                                          if (User_ID ==
                                                                              null) {
                                                                            Navigator.of(context).push(MaterialPageRoute(builder: (context) => RegisterCreateAccountScreen()));
                                                                          } else {
                                                                            if (Link == true ||
                                                                                Link1 == true ||
                                                                                Link2 == true ||
                                                                                Link3 == true ||
                                                                                Link4 == true ||
                                                                                Link5 == true ||
                                                                                Link6 == true) {
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
                                                                                /*   await BlocProvider
                                                                      .of<GetGuestAllPostCubit>(
                                                                          context)
                                                                  .seetinonExpried(
                                                                      context); */
                                                                                Navigator.push(
                                                                                    context,
                                                                                    MaterialPageRoute(
                                                                                      builder: (context) => HashTagViewScreen(title: "${link.value}"),
                                                                                    ));
                                                                              } else if (link.value!.startsWith('@')) {
                                                                                /*  await BlocProvider
                                                                      .of<GetGuestAllPostCubit>(
                                                                          context)
                                                                  .seetinonExpried(
                                                                      context); */
                                                                                var name;
                                                                                var tagName;
                                                                                name = SelectedTest;
                                                                                tagName = name.replaceAll("@", "");
                                                                                await BlocProvider.of<NewProfileSCubit>(context).UserTagAPI(context, tagName);

                                                                                Navigator.push(context, MaterialPageRoute(builder: (context) {
                                                                                  return ProfileScreen(User_ID: "${userTagModel?.object}", isFollowing: "");
                                                                                })).then((value) => Get_UserToken());

                                                                                print("tagName -- ${tagName}");
                                                                                print("user id -- ${userTagModel?.object}");
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
                                                                ],
                                                              ),
                                                            ],
                                                          )),
                                                )
                                              : SizedBox(),
                                          // index == 0

                                          Container(
                                            width: _width,
                                            child: getAllPostData.object?[index]
                                                        .postDataType ==
                                                    null
                                                ? SizedBox()
                                                : getAllPostData.object?[index]
                                                            .postData?.length ==
                                                        1
                                                    ? (getAllPostData
                                                                .object?[index]
                                                                .postDataType ==
                                                            "IMAGE"
                                                        ? GestureDetector(
                                                            onTap: () {
                                                              Navigator.push(
                                                                context,
                                                                MaterialPageRoute(
                                                                    builder:
                                                                        (context) =>
                                                                            OpenSavePostImage(
                                                                              PostID: getAllPostData.object?[index].postUid,
                                                                              index: index,
                                                                            )),
                                                              );
                                                            },
                                                            child: Container(
                                                              width: _width,
                                                              margin: EdgeInsets
                                                                  .only(
                                                                      left: 0,
                                                                      top: 15,
                                                                      right: 0),
                                                              child: Center(
                                                                child:
                                                                    PinchZoom(
                                                                  child:
                                                                      CachedNetworkImage(
                                                                    imageUrl:
                                                                        "${getAllPostData.object?[index].postData?[0]}",
                                                                  ),
                                                                  maxScale: 4,
                                                                  onZoomStart:
                                                                      () {
                                                                    print(
                                                                        'Start zooming');
                                                                  },
                                                                  onZoomEnd:
                                                                      () {
                                                                    print(
                                                                        'Stop zooming');
                                                                  },
                                                                ),
                                                                /*      CustomImageView(
                                                                url:
                                                                    "${getAllPostData.object?[index].postData?[0]}",
                                                              ) */
                                                              ),
                                                            ),
                                                          )
                                                        : getAllPostData
                                                                    .object?[
                                                                        index]
                                                                    .postDataType ==
                                                                "VIDEO"
                                                            ? /*  mainPostControllers[0].value.isInitialized
                                                                              ? */

                                                            Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .only(
                                                                        right:
                                                                            20,
                                                                        top:
                                                                            15),
                                                                child: Column(
                                                                  mainAxisSize:
                                                                      MainAxisSize
                                                                          .min,
                                                                  children: [
                                                                    /* Container(
                                                                                            height: 250,
                                                                                            width: _width,
                                                                                            child: Chewie(
                                                                                              controller: chewieController[index],
                                                                                            )), */

                                                                    VideoListItem1(
                                                                      videoUrl:
                                                                          videoUrls[
                                                                              index],
                                                                      PostID: getAllPostData
                                                                          .object?[
                                                                              index]
                                                                          .postUid,
                                                                      /* isData: User_ID == null
                                                        ? false
                                                        : true, */
                                                                    ),
                                                                  ],
                                                                ),
                                                              )
                                                            // : SizedBox()

                                                            : getAllPostData
                                                                        .object?[
                                                                            index]
                                                                        .postDataType ==
                                                                    "ATTACHMENT"
                                                                ? (getAllPostData
                                                                            .object?[index]
                                                                            .postData
                                                                            ?.isNotEmpty ==
                                                                        true)
                                                                    ? Stack(
                                                                        children: [
                                                                          Container(
                                                                            height:
                                                                                400,
                                                                            width:
                                                                                _width,
                                                                            color:
                                                                                Colors.transparent,
                                                                            /* child: DocumentViewScreen1(
                                                                                            path: getAllPostData?.object?[index].postData?[0].toString(),
                                                                                          ) */
                                                                          ),
                                                                          GestureDetector(
                                                                            onTap:
                                                                                () {
                                                                              print("objectobjectobjectobject");
                                                                              Navigator.push(context, MaterialPageRoute(
                                                                                builder: (context) {
                                                                                  return DocumentViewScreen1(
                                                                                    path: getAllPostData.object?[index].postData?[0].toString(),
                                                                                  );
                                                                                },
                                                                              ));
                                                                            },
                                                                            child:
                                                                                Container(
                                                                              child: CachedNetworkImage(
                                                                                imageUrl: getAllPostData.object?[index].thumbnailImageUrl ?? "",
                                                                                fit: BoxFit.cover,
                                                                              ),
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
                                                              if ((getAllPostData
                                                                      .object?[
                                                                          index]
                                                                      .postData
                                                                      ?.isNotEmpty ??
                                                                  false)) ...[
                                                                Container(
                                                                  height:
                                                                      _height /
                                                                          1.4,
                                                                  child: PageView
                                                                      .builder(
                                                                    onPageChanged:
                                                                        (page) {
                                                                      super.setState(
                                                                          () {
                                                                        _currentPages[index] =
                                                                            page;
                                                                        imageCount =
                                                                            page +
                                                                                1;
                                                                      });
                                                                    },
                                                                    controller:
                                                                        _pageControllers[
                                                                            index],
                                                                    itemCount: getAllPostData
                                                                        .object?[
                                                                            index]
                                                                        .postData
                                                                        ?.length,
                                                                    itemBuilder:
                                                                        (BuildContext
                                                                                context,
                                                                            int index1) {
                                                                      if (getAllPostData
                                                                              .object?[
                                                                                  index]
                                                                              .postDataType ==
                                                                          "IMAGE") {
                                                                        return Container(
                                                                          width:
                                                                              _width,
                                                                          margin: EdgeInsets.only(
                                                                              left: 0,
                                                                              top: 15,
                                                                              right: 0),
                                                                          child: Center(
                                                                              child: GestureDetector(
                                                                            onTap:
                                                                                () {
                                                                              Navigator.push(
                                                                                context,
                                                                                MaterialPageRoute(
                                                                                    builder: (context) => OpenSavePostImage(
                                                                                          PostID: getAllPostData.object?[index].postUid,
                                                                                          index: index1,
                                                                                        )),
                                                                              );
                                                                            },
                                                                            child:
                                                                                Stack(
                                                                              children: [
                                                                                Align(
                                                                                  alignment: Alignment.center,
                                                                                  child: PinchZoom(
                                                                                    child: CachedNetworkImage(
                                                                                      imageUrl: "${getAllPostData.object?[index].postData?[index1]}",
                                                                                    ),
                                                                                    maxScale: 4,
                                                                                    onZoomStart: () {
                                                                                      print('Start zooming');
                                                                                    },
                                                                                    onZoomEnd: () {
                                                                                      print('Stop zooming');
                                                                                    },
                                                                                  ) /* CustomImageView(
                                                                                    url: "${getAllPostData.object?[index].postData?[index1]}",
                                                                                  ) */
                                                                                  ,
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
                                                                                          imageCount.toString() + '/' + '${getAllPostData.object?[index].postData?.length}',
                                                                                          style: TextStyle(color: Colors.white),
                                                                                        )),
                                                                                  ),
                                                                                )
                                                                              ],
                                                                            ),
                                                                          )),
                                                                        );
                                                                      } else if (getAllPostData
                                                                              .object?[index]
                                                                              .postDataType ==
                                                                          "ATTACHMENT") {
                                                                        return Container(
                                                                            height:
                                                                                400,
                                                                            width:
                                                                                _width,
                                                                            child:
                                                                                DocumentViewScreen1(
                                                                              path: getAllPostData.object?[index].postData?[index1].toString(),
                                                                            ));
                                                                      }
                                                                    },
                                                                  ),
                                                                ),
                                                                Positioned(
                                                                    bottom: 5,
                                                                    left: 0,
                                                                    right: 0,
                                                                    child:
                                                                        Padding(
                                                                      padding: const EdgeInsets
                                                                              .only(
                                                                          top:
                                                                              0),
                                                                      child:
                                                                          Container(
                                                                        height:
                                                                            20,
                                                                        child:
                                                                            DotsIndicator(
                                                                          dotsCount:
                                                                              getAllPostData.object?[index].postData?.length ?? 0,
                                                                          position:
                                                                              _currentPages[index].toDouble(),
                                                                          decorator:
                                                                              DotsDecorator(
                                                                            size:
                                                                                const Size(10.0, 7.0),
                                                                            activeSize:
                                                                                const Size(10.0, 10.0),
                                                                            spacing:
                                                                                const EdgeInsets.symmetric(horizontal: 2),
                                                                            activeColor:
                                                                                ColorConstant.primary_color,
                                                                            color:
                                                                                Color(0xff6A6A6A),
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
                                                const EdgeInsets.only(left: 13),
                                            child: Divider(
                                              thickness: 1,
                                            ),
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 0, right: 16),
                                            child: Row(
                                              children: [
                                                SizedBox(
                                                  width: 14,
                                                ),
                                                GestureDetector(
                                                  onTap: () async {
                                                    await soicalFunation(
                                                        apiName: 'like_post',
                                                        index: index);
                                                  },
                                                  child: Container(
                                                    color: Colors.transparent,
                                                    child: Padding(
                                                      padding:
                                                          EdgeInsets.all(5.0),
                                                      child: getAllPostData
                                                                  .object?[
                                                                      index]
                                                                  .isLiked !=
                                                              true
                                                          ? Image.asset(
                                                              ImageConstant
                                                                  .likewithout,
                                                              height: 18,
                                                            )
                                                          : Image.asset(
                                                              ImageConstant
                                                                  .like,
                                                              height: 18,
                                                            ),
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 0,
                                                ),
                                                getAllPostData.object?[index]
                                                            .likedCount ==
                                                        0
                                                    ? SizedBox()
                                                    : GestureDetector(
                                                        onTap: () {
                                                          Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                            builder: (context) {
                                                              return ShowAllPostLike(
                                                                  "${getAllPostData.object?[index].postUid}");
                                                            },
                                                          ));
                                                        },
                                                        child: Container(
                                                          color: Colors
                                                              .transparent,
                                                          child: Padding(
                                                            padding:
                                                                EdgeInsets.all(
                                                                    5.0),
                                                            child: Align(
                                                              alignment: Alignment
                                                                  .centerLeft,
                                                              child: Text(
                                                                "${getAllPostData.object?[index].likedCount}",
                                                                style: TextStyle(
                                                                    fontFamily:
                                                                        "outfit",
                                                                    fontSize:
                                                                        14),
                                                              ),
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
                                                          .Addcomment(context,
                                                              '${getAllPostData.object?[index].postUid}');

                                                      _settingModalBottomSheet1(
                                                          context,
                                                          index,
                                                          _height);
                                                    },
                                                    child: Container(
                                                        color:
                                                            Colors.transparent,
                                                        child: Padding(
                                                            padding:
                                                                EdgeInsets.all(
                                                                    5.0),
                                                            child: Image.asset(
                                                              ImageConstant
                                                                  .meesage,
                                                              height: 15,
                                                              // width: 15,
                                                            )))),
                                                SizedBox(
                                                  width: 5,
                                                ),
                                                getAllPostData.object?[index]
                                                            .commentCount ==
                                                        0
                                                    ? SizedBox()
                                                    : Text(
                                                        "${getAllPostData.object?[index].commentCount}",
                                                        style: TextStyle(
                                                            fontFamily:
                                                                "outfit",
                                                            fontSize: 14),
                                                      ),
                                                SizedBox(
                                                  width: 5,
                                                ),
                                                GestureDetector(
                                                  onTap: () {
                                                    rePostBottomSheet(
                                                        context, index);
                                                  },
                                                  child: Container(
                                                    color: Colors.transparent,
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              5.0),
                                                      child: Image.asset(
                                                        ImageConstant.vector2,
                                                        height: 13,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 5,
                                                ),
                                                getAllPostData.object?[index]
                                                                .repostCount ==
                                                            null ||
                                                        getAllPostData
                                                                .object?[index]
                                                                .repostCount ==
                                                            0
                                                    ? SizedBox()
                                                    : Text(
                                                        '${getAllPostData.object?[index].repostCount}',
                                                        style: TextStyle(
                                                            fontFamily:
                                                                "outfit",
                                                            fontSize: 14),
                                                      ),
                                                GestureDetector(
                                                  onTap: () {
                                                    _onShareXFileFromAssets(
                                                      context,
                                                      androidLink:
                                                          '${getAllPostData.object?[index].postLink}',
                                                      /* iosLink:
                                                      "https://apps.apple.com/inList =  /app/growder-b2b-platform/id6451333863" */
                                                    );
                                                  },
                                                  child: Container(
                                                    height: 20,
                                                    width: 30,
                                                    color: Colors.transparent,
                                                    child: Icon(
                                                        Icons.share_rounded,
                                                        size: 20),
                                                  ),
                                                ),
                                                Spacer(),
                                                GestureDetector(
                                                  onTap: () async {
                                                    await soicalFunation(
                                                        apiName: 'savedata',
                                                        index: index);
                                                  },
                                                  child: Container(
                                                    color: Colors.transparent,
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              5.0),
                                                      child: Image.asset(
                                                        getAllPostData
                                                                    .object?[
                                                                        index]
                                                                    .isSaved ==
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
              )
            : Center(
                child: Text(
                "No post Uploaded",
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'outfit',
                    fontSize: 20),
              ))
        : Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 50),
              Center(
                  child: Image.asset(
                ImageConstant.nopostimage,
                height: 150,
              )),
              SizedBox(height: 50),
            ],
          );
  }

  void _settingModalBottomSheet1(context, index, _heigth) {
    /* void _goToElement() {
      scroll.animateTo((1000 * 20),
          duration: const Duration(milliseconds: 300), curve: Curves.easeOut);
    } */

    showBottomSheet(
        /*  isScrollControlled: true,
        useSafeArea: true,
        isDismissible: true,
        showDragHandle: true, */

        enableDrag: true,
        constraints: BoxConstraints(maxHeight: _heigth / 2),
        context: context,
        builder: (BuildContext bc) {
          print(
              "userUiduserUid == >>>>>>> ${GetAllPostData?.object?[index].userUid}");
          return StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
            return CommentBottomSheet(
                isFoollinng: GetAllPostData?.object?[index].isFollowing,
                useruid: GetAllPostData?.object?[index].userUid ?? "",
                userProfile:
                    GetAllPostData?.object?[index].userProfilePic ?? "",
                UserName: GetAllPostData?.object?[index].postUserName ?? "",
                desc: GetAllPostData?.object?[index].description ?? "",
                postUuID: GetAllPostData?.object?[index].postUid ?? "");
          });
        });
    ;
  }

  onChangeMethod(String value) {
    super.setState(() {
      aboutMe.text = value;
    });

    if (value.contains('@')) {
      print("if this condison is working-${value}");
      if (value.length >= 1 && value.contains('@')) {
        print("value check --${value.endsWith(' #')}");
        if (value.endsWith(' #')) {
          String data1 = value.split(' #').last.replaceAll('#', '');
          BlocProvider.of<NewProfileSCubit>(context)
              .GetAllHashtag(context, '10', '#${data1.trim()}');
        } else {
          String data = value.split(' @').last.replaceAll('@', '');
          BlocProvider.of<NewProfileSCubit>(context)
              .search_user_for_inbox(context, '${data.trim()}', '1');
        }
      } else if (value.endsWith(' #')) {
        print("ends with value-${value}");
      } else {
        print("check lenth else-${value.length}");
      }
    } else if (value.contains('#')) {
      print("check length-${value}");
      String data1 = value.split(' #').last.replaceAll('#', '');
      BlocProvider.of<NewProfileSCubit>(context)
          .GetAllHashtag(context, '10', '#${data1.trim()}');
    } else {
      super.setState(() {
        // postText.text = postText.text + ' ' + postTexContrlloer.join(' ,');
        istageData = false;
        isHeshTegData = false;
      });
    }
  }

  void rePostBottomSheet(context, index) {
    showBottomSheet(
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
                        BlocProvider.of<NewProfileSCubit>(context).RePostAPI(
                            context,
                            param,
                            GetAllPostData?.object?[index].postUid,
                            "Repost");
                        if (widget.Screen?.isNotEmpty == true) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    NewBottomBar(buttomIndex: 0),
                              ));
                        } else {
                          Navigator.pop(context);
                        }
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
                            userProfile:
                                GetAllPostData?.object?[index].userProfilePic,
                            username:
                                GetAllPostData?.object?[index].postUserName,
                            date: GetAllPostData?.object?[index].createdAt,
                            desc: GetAllPostData?.object?[index].description,
                            postData: GetAllPostData?.object?[index].postData,
                            postDataType:
                                GetAllPostData?.object?[index].postDataType,
                            index: index,
                            GetAllPostData: GetAllPostData,
                            postUid: GetAllPostData?.object?[index].postUid,
                            thumbNailURL: GetAllPostData
                                ?.object?[index].thumbnailImageUrl,
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

  void _onShareXFileFromAssets(BuildContext context,
      {String? androidLink}) async {
    RenderBox? box = context.findAncestorRenderObjectOfType();

    var directory = await getApplicationDocumentsDirectory();

    if (Platform.isAndroid) {
      await Share.shareXFiles(
        [XFile("/sdcard/download/IP__image.jpg")],
        subject: "Share",
        text: "Try This Awesome App \n\n Android :- ${androidLink}",
        sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size,
      );
    } else {
      await Share.shareXFiles(
        [
          XFile(directory.path +
              Platform.pathSeparator +
              'Growder_Image/IP__image.jpg')
        ],
        subject: "Share",
        text: "Try This Awesome App \n\n Android :- ${androidLink}",
        sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size,
      );
    }
  }

  soicalFunationSave({String? apiName, int? index}) async {
    print("fghdfghdfgh");
    if (apiName == 'like_post') {
      await BlocProvider.of<NewProfileSCubit>(context)
          .like_post(GetSavePostData?.object?[index ?? 0].postUid, context);
      print("isLiked-->${GetSavePostData?.object?[index ?? 0].isLiked}");
      if (GetSavePostData?.object?[index ?? 0].isLiked == true) {
        GetSavePostData?.object?[index ?? 0].isLiked = false;
        int a = GetSavePostData?.object?[index ?? 0].likedCount ?? 0;
        int b = 1;
        GetSavePostData?.object?[index ?? 0].likedCount = a - b;
      } else {
        GetSavePostData?.object?[index ?? 0].isLiked = true;
        GetSavePostData?.object?[index ?? 0].likedCount;
        int a = GetSavePostData?.object?[index ?? 0].likedCount ?? 0;
        int b = 1;
        GetSavePostData?.object?[index ?? 0].likedCount = a + b;
      }
    } else if (apiName == 'savedata') {
      await BlocProvider.of<NewProfileSCubit>(context)
          .savedData(GetSavePostData?.object?[index ?? 0].postUid, context);

      if (GetSavePostData?.object?[index ?? 0].isSaved == true) {
        GetSavePostData?.object?[index ?? 0].isSaved = false;
      } else {
        GetSavePostData?.object?[index ?? 0].isSaved = true;
      }
    }
  }

  void _settingModalBottomSheetSave(context, index, _heigth) {
    /* void _goToElement() {
      scroll.animateTo((1000 * 20),
          duration: const Duration(milliseconds: 300), curve: Curves.easeOut);
    } */

    showBottomSheet(
        /*    isScrollControlled: true,
        useSafeArea: true,
        isDismissible: true,
        showDragHandle: true, */
        constraints: BoxConstraints(maxHeight: _heigth / 2),
        enableDrag: true,
        context: context,
        builder: (BuildContext bc) {
          print(
              "userUiduserUid == >>>>>>> ${GetSavePostData?.object?[index].userUid}");
          return StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
            return CommentBottomSheet(
                isFoollinng: GetSavePostData?.object?[index].isFollowing,
                useruid: GetSavePostData?.object?[index].userUid ?? "",
                userProfile:
                    GetSavePostData?.object?[index].userProfilePic ?? "",
                UserName: GetSavePostData?.object?[index].postUserName ?? "",
                desc: GetSavePostData?.object?[index].description ?? "",
                postUuID: GetSavePostData?.object?[index].postUid ?? "");
          });
        });
    ;
  }

  void rePostBottomSheetSave(context, index) {
    showBottomSheet(
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
                        BlocProvider.of<NewProfileSCubit>(context).RePostAPI(
                            context,
                            param,
                            GetSavePostData?.object?[index].postUid,
                            "Repost");

                        if (widget.Screen?.isNotEmpty == true) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    NewBottomBar(buttomIndex: 0),
                              ));
                        } else {
                          Navigator.pop(context);
                        }
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
                            userProfile:
                                GetSavePostData?.object?[index].userProfilePic,
                            username:
                                GetSavePostData?.object?[index].postUserName,
                            date: GetSavePostData?.object?[index].createdAt,
                            desc: GetSavePostData?.object?[index].description,
                            postData: GetSavePostData?.object?[index].postData,
                            postDataType:
                                GetSavePostData?.object?[index].postDataType,
                            index: index,
                            GetSavePostData: GetSavePostData,
                            postUid: GetSavePostData?.object?[index].postUid,
                            thumbNailURL: GetSavePostData
                                ?.object?[index].thumbnailImageUrl,
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

  Widget NavagtionPassing(double _width, _height) {
    if (value1 == 0) {
      return GetSavePostData?.object?.isNotEmpty ?? true
          ? ListView.builder(
              padding: EdgeInsets.zero,
              physics: NeverScrollableScrollPhysics(),
              itemCount: GetSavePostData?.object?.length ?? 0,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                if (!added) {
                  GetSavePostData?.object?.forEach((element) {
                    _pageControllers.add(PageController());
                    _currentPages.add(0);
                  });
                  WidgetsBinding.instance
                      .addPostFrameCallback((timeStamp) => super.setState(() {
                            added = true;
                          }));
                }

                DateTime parsedDateTime = DateTime.parse(
                    '${GetSavePostData?.object?[index].createdAt ?? ""}');
                DateTime? repostTime;
                if (GetSavePostData!.object![index].repostOn != null) {
                  repostTime = DateTime.parse(
                      '${GetSavePostData?.object?[index].repostOn!.createdAt ?? ""}');
                  print("repost time = $parsedDateTime");
                }
                bool DataGet = false;
                if (GetSavePostData?.object?[index].description != null &&
                    GetSavePostData?.object?[index].description != '') {
                  DataGet =
                      _isLink('${GetSavePostData?.object?[index].description}');
                }
                return GetSavePostData?.object?[index].repostOn != null
                    ? Padding(
                        padding: EdgeInsets.only(
                            left: 0, right: 0, top: 10, bottom: 10),
                        child: GestureDetector(
                          onDoubleTap: () async {
                            await soicalFunationSave(
                                apiName: 'like_post', index: index);
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(
                                  color: Color.fromRGBO(0, 0, 0,
                                      0.25)), /* borderRadius: BorderRadius.circular(15) */
                            ),
                            // height: 300,
                            width: _width,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  height: 60,
                                  child: ListTile(
                                    leading: GestureDetector(
                                      onTap: () async {
                                        /*  await BlocProvider.of<GetGuestAllPostCubit>(
                                context)
                            .seetinonExpried(context); */
                                        Navigator.push(context,
                                            MaterialPageRoute(
                                                builder: (context) {
                                          return MultiBlocProvider(
                                              providers: [
                                                BlocProvider<NewProfileSCubit>(
                                                  create: (context) =>
                                                      NewProfileSCubit(),
                                                ),
                                              ],
                                              child: ProfileScreen(
                                                  User_ID:
                                                      "${GetSavePostData?.object?[index].userUid}",
                                                  isFollowing: GetSavePostData
                                                      ?.object?[index]
                                                      .isFollowing));
                                        })).then((value) => Get_UserToken());

                                        ///
                                      },
                                      child: GetSavePostData?.object?[index]
                                                      .userProfilePic !=
                                                  null &&
                                              GetSavePostData?.object?[index]
                                                      .userProfilePic !=
                                                  ""
                                          ? CircleAvatar(
                                              backgroundImage: NetworkImage(
                                                  "${GetSavePostData?.object?[index].userProfilePic}"),
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        GestureDetector(
                                          onTap: () async {
                                            /*   await BlocProvider.of<GetGuestAllPostCubit>(
                                    context)
                                .seetinonExpried(context); */
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
                                                          "${GetSavePostData?.object?[index].userUid}",
                                                      isFollowing:
                                                          GetSavePostData
                                                              ?.object?[index]
                                                              .isFollowing));
                                            })).then(
                                                (value) => Get_UserToken());

                                            //
                                          },
                                          child: Container(
                                            // color: Colors.amber,
                                            child: Text(
                                              "${GetSavePostData?.object?[index].postUserName}",
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  fontFamily: "outfit",
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ),
                                        Text(
                                          getTimeDifference(parsedDateTime),
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

                                GetSavePostData?.object?[index].description !=
                                        null
                                    ? Padding(
                                        padding:
                                            const EdgeInsets.only(left: 16),
                                        child: GestureDetector(
                                            onTap: () async {
                                              if (DataGet == true) {
                                                await launch(
                                                    '${GetSavePostData?.object?[index].description}',
                                                    forceWebView: true,
                                                    enableJavaScript: true);
                                              } else {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          OpenSavePostImage(
                                                            PostID:
                                                                GetSavePostData
                                                                    ?.object?[
                                                                        index]
                                                                    .postUid,
                                                          )),
                                                );
                                              }
                                            },
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                /*                  GestureDetector(
                                                                      onTap: () async {
                                                                       
                                                                        String inputText = "${GetSavePostData?.object?[index].description}";
                                                                        String translatedTextGujarati = await translateText(inputText, 'gu');
                                                                        String translatedTextHindi = await translateText(inputText, 'hi');
                                                                        String translatedTextenglish = await translateText(inputText, 'en');

                                                                        if (GetSavePostData?.object?[index].isfalsehin == null && GetSavePostData??.object?[index].isfalsegu == null) {
                                                                          super.setState(() {
                                                                            // _translatedTextGujarati = translatedTextGujarati;

                                                                            _translatedTextHindi = translatedTextHindi;

                                                                            // GetSavePostData??.object?[index].description = _translatedTextGujarati;
                                                                            GetSavePostData??.object?[index].description = _translatedTextHindi;
                                                                            GetSavePostData??.object?[index].isfalsehin = true;
                                                                          });
                                                                        } else if (GetSavePostData??.object?[index].isfalsehin == true && GetSavePostData??.object?[index].isfalsegu == null) {
                                                                          super.setState(() {
                                                                            _translatedTextGujarati = translatedTextGujarati;
                                                                            // _translatedTextHindi = translatedTextHindi;

                                                                            // GetSavePostData??.object?[index].description = _translatedTextGujarati;
                                                                            GetSavePostData??.object?[index].description = _translatedTextGujarati;
                                                                            GetSavePostData??.object?[index].isfalsegu = true;
                                                                          });
                                                                        } else if (GetSavePostData??.object?[index].isfalsehin == true && GetSavePostData??.object?[index].isfalsehin == true) {
                                                                          print("this condison is working");

                                                                          super.setState(() {
                                                                            print("i'm cheaking dataa--------------------------------$initalData");
                                                                            _translatedTextenglish = translatedTextenglish;
                                                                            GetSavePostData??.object?[index].description = _translatedTextenglish;
                                                                            GetSavePostData??.object?[index].isfalsegu = null;
                                                                            GetSavePostData??.object?[index].isfalsehin = null;
                                                                          });
                                                                        }
                                                                      },
                                                                      child: Container(
                                                                          width: 80,
                                                                          decoration: BoxDecoration(color: ColorConstant.primaryLight_color, borderRadius: BorderRadius.circular(10)),
                                                                          child: Center(
                                                                              child: Text(
                                                                            "Translate",
                                                                            style: TextStyle(
                                                                              fontFamily: 'outfit',
                                                                              fontWeight: FontWeight.bold,
                                                                            ),
                                                                          ))),
                                                                    ), */
                                                GetSavePostData?.object?[index]
                                                            .translatedDescription !=
                                                        null
                                                    ? GestureDetector(
                                                        onTap: () async {
                                                          super.setState(() {
                                                            if (GetSavePostData
                                                                        ?.object?[
                                                                            index]
                                                                        .isTrsnalteoption ==
                                                                    false ||
                                                                GetSavePostData
                                                                        ?.object?[
                                                                            index]
                                                                        .isTrsnalteoption ==
                                                                    null) {
                                                              GetSavePostData
                                                                      ?.object?[
                                                                          index]
                                                                      .isTrsnalteoption =
                                                                  true;
                                                            } else {
                                                              GetSavePostData
                                                                      ?.object?[
                                                                          index]
                                                                      .isTrsnalteoption =
                                                                  false;
                                                            }
                                                          });
                                                        },
                                                        child: Container(
                                                            width: 80,
                                                            decoration:
                                                                BoxDecoration(
                                                              color: ColorConstant
                                                                  .primaryLight_color,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10),
                                                            ),
                                                            child: Center(
                                                                child: Text(
                                                              "Translate",
                                                              style: TextStyle(
                                                                fontFamily:
                                                                    'outfit',
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                              ),
                                                            ))),
                                                      )
                                                    : SizedBox(),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                Row(
                                                  children: [
                                                    Expanded(
                                                      child: Container(
                                                        // color: Colors.amber,
                                                        child: LinkifyText(
                                                          GetSavePostData
                                                                          ?.object?[
                                                                              index]
                                                                          .isTrsnalteoption ==
                                                                      false ||
                                                                  GetSavePostData
                                                                          ?.object?[
                                                                              index]
                                                                          .isTrsnalteoption ==
                                                                      null
                                                              ? "${GetSavePostData?.object?[index].description}"
                                                              : "${GetSavePostData?.object?[index].translatedDescription}",
                                                          linkStyle: TextStyle(
                                                            color: Colors.blue,
                                                            fontFamily:
                                                                'outfit',
                                                          ),
                                                          textStyle: TextStyle(
                                                            color: Colors.black,
                                                            fontFamily:
                                                                'outfit',
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

                                                            var SelectedTest =
                                                                link.value
                                                                    .toString();
                                                            var Link =
                                                                SelectedTest
                                                                    .startsWith(
                                                                        'https');
                                                            var Link1 =
                                                                SelectedTest
                                                                    .startsWith(
                                                                        'http');
                                                            var Link2 =
                                                                SelectedTest
                                                                    .startsWith(
                                                                        'www');
                                                            var Link3 =
                                                                SelectedTest
                                                                    .startsWith(
                                                                        'WWW');
                                                            var Link4 =
                                                                SelectedTest
                                                                    .startsWith(
                                                                        'HTTPS');
                                                            var Link5 =
                                                                SelectedTest
                                                                    .startsWith(
                                                                        'HTTP');
                                                            var Link6 = SelectedTest
                                                                .startsWith(
                                                                    'https://pdslink.page.link/');
                                                            print(SelectedTest
                                                                .toString());

                                                            if (User_ID ==
                                                                null) {
                                                              Navigator.of(
                                                                      context)
                                                                  .push(MaterialPageRoute(
                                                                      builder:
                                                                          (context) =>
                                                                              RegisterCreateAccountScreen()));
                                                            } else {
                                                              if (Link ==
                                                                      true ||
                                                                  Link1 ==
                                                                      true ||
                                                                  Link2 ==
                                                                      true ||
                                                                  Link3 ==
                                                                      true ||
                                                                  Link4 ==
                                                                      true ||
                                                                  Link5 ==
                                                                      true ||
                                                                  Link6 ==
                                                                      true) {
                                                                if (Link2 ==
                                                                        true ||
                                                                    Link3 ==
                                                                        true) {
                                                                  launchUrl(
                                                                      Uri.parse(
                                                                          "https://${link.value.toString()}"));
                                                                  print(
                                                                      "qqqqqqqqhttps://${link.value}");
                                                                } else {
                                                                  if (Link6 ==
                                                                      true) {
                                                                    print(
                                                                        "yes i am inList =   room");
                                                                    Navigator.push(
                                                                        context,
                                                                        MaterialPageRoute(
                                                                      builder:
                                                                          (context) {
                                                                        return NewBottomBar(
                                                                          buttomIndex:
                                                                              1,
                                                                        );
                                                                      },
                                                                    ));
                                                                  } else {
                                                                    launchUrl(Uri
                                                                        .parse(link
                                                                            .value
                                                                            .toString()));
                                                                    print(
                                                                        "link.valuelink.value -- ${link.value}");
                                                                  }
                                                                }
                                                              } else {
                                                                if (link.value!
                                                                    .startsWith(
                                                                        '#')) {
                                                                  /*  await BlocProvider.of<
                                                              GetGuestAllPostCubit>(
                                                          context)
                                                      .seetinonExpried(
                                                          context); */
                                                                  Navigator.push(
                                                                      context,
                                                                      MaterialPageRoute(
                                                                        builder:
                                                                            (context) =>
                                                                                HashTagViewScreen(title: "${link.value}"),
                                                                      ));
                                                                } else if (link
                                                                    .value!
                                                                    .startsWith(
                                                                        '@')) {
                                                                  /*  await BlocProvider.of<
                                                              GetGuestAllPostCubit>(
                                                          context)
                                                      .seetinonExpried(
                                                          context); */
                                                                  var name;
                                                                  var tagName;
                                                                  name =
                                                                      SelectedTest;
                                                                  tagName = name
                                                                      .replaceAll(
                                                                          "@",
                                                                          "");
                                                                  await BlocProvider.of<
                                                                              NewProfileSCubit>(
                                                                          context)
                                                                      .UserTagAPI(
                                                                          context,
                                                                          tagName);

                                                                  Navigator.push(
                                                                      context,
                                                                      MaterialPageRoute(
                                                                          builder:
                                                                              (context) {
                                                                    return ProfileScreen(
                                                                        User_ID:
                                                                            "${userTagModel?.object}",
                                                                        isFollowing:
                                                                            "");
                                                                  })).then(
                                                                      (value) =>
                                                                          Get_UserToken());

                                                                  print(
                                                                      "tagName -- ${tagName}");
                                                                  print(
                                                                      "user id -- ${userTagModel?.object}");
                                                                } else {
                                                                  launchUrl(
                                                                      Uri.parse(
                                                                          "https://${link.value.toString()}"));
                                                                }
                                                              }
                                                            }
                                                          },
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            )),
                                      )
                                    : SizedBox(),

                                (GetSavePostData?.object?[index].postData
                                            ?.isEmpty ??
                                        false)
                                    ? SizedBox()
                                    : Container(
                                        // height: 200,
                                        width: _width,
                                        child: GetSavePostData?.object?[index]
                                                    .postDataType ==
                                                null
                                            ? SizedBox()
                                            : GetSavePostData?.object?[index]
                                                        .postData?.length ==
                                                    1
                                                ? (GetSavePostData
                                                            ?.object?[index]
                                                            .postDataType ==
                                                        "IMAGE"
                                                    ? GestureDetector(
                                                        onTap: () {
                                                          Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                                builder:
                                                                    (context) =>
                                                                        OpenSavePostImage(
                                                                          PostID: GetSavePostData
                                                                              ?.object?[index]
                                                                              .postUid,
                                                                          index:
                                                                              index,
                                                                        )),
                                                          );
                                                        },
                                                        child: Container(
                                                          height: 200,
                                                          width: _width,
                                                          margin:
                                                              EdgeInsets.only(
                                                                  left: 16,
                                                                  top: 15,
                                                                  right: 16),
                                                          child: Center(
                                                              child:
                                                                  CustomImageView(
                                                            url:
                                                                "${GetSavePostData?.object?[index].postData?[0]}",
                                                          )),
                                                        ),
                                                      )
                                                    : GetSavePostData
                                                                ?.object?[index]
                                                                .postDataType ==
                                                            "VIDEO"
                                                        ? /* repostControllers[0].value.isInitialized
                                                                            ?   */
                                                        Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    right: 20,
                                                                    top: 15),
                                                            child: Column(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .min,
                                                              children: [
                                                                Container(
                                                                  // height: 180,
                                                                  width: _width,
                                                                  child:
                                                                      VideoListItem1(
                                                                    videoUrl:
                                                                        videoUrls[
                                                                            index],
                                                                    PostID: GetSavePostData
                                                                        ?.object?[
                                                                            index]
                                                                        .postUid,
                                                                    /* isData: User_ID ==
                                                                      null
                                                                  ? false
                                                                  : true, */
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          )
                                                        // : SizedBox()
                                                        //this is the ATTACHMENT
                                                        : GetSavePostData
                                                                    ?.object?[
                                                                        index]
                                                                    .postDataType ==
                                                                "ATTACHMENT"
                                                            ? (GetSavePostData
                                                                        ?.object?[
                                                                            index]
                                                                        .postData
                                                                        ?.isNotEmpty ==
                                                                    true)
                                                                ? /* Container(
                                                                                    height: 200,
                                                                                    width: _width,
                                                                                    child: DocumentViewScreen1(
                                                                                      path: GetSavePostData??.object?[index].postData?[0].toString(),
                                                                                    )) */
                                                                Stack(
                                                                    children: [
                                                                      Container(
                                                                        height:
                                                                            400,
                                                                        width:
                                                                            _width,
                                                                        color: Colors
                                                                            .transparent,
                                                                      ),
                                                                      GestureDetector(
                                                                        onTap:
                                                                            () {
                                                                          print(
                                                                              "objectobjectobjectobject");
                                                                          Navigator.push(
                                                                              context,
                                                                              MaterialPageRoute(
                                                                            builder:
                                                                                (context) {
                                                                              return DocumentViewScreen1(
                                                                                path: GetSavePostData?.object?[index].postData?[0].toString(),
                                                                              );
                                                                            },
                                                                          ));
                                                                        },
                                                                        child:
                                                                            Container(
                                                                          child:
                                                                              CachedNetworkImage(
                                                                            imageUrl:
                                                                                GetSavePostData?.object?[index].thumbnailImageUrl ?? "",
                                                                            fit:
                                                                                BoxFit.cover,
                                                                          ),
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
                                                          if ((GetSavePostData
                                                                  ?.object?[
                                                                      index]
                                                                  .postData
                                                                  ?.isNotEmpty ??
                                                              false)) ...[
                                                            SizedBox(
                                                              height: 200,
                                                              child: PageView
                                                                  .builder(
                                                                onPageChanged:
                                                                    (page) {
                                                                  super
                                                                      .setState(
                                                                          () {
                                                                    _currentPages[
                                                                            index] =
                                                                        page;
                                                                    imageCount1 =
                                                                        page +
                                                                            1;
                                                                  });
                                                                },
                                                                controller:
                                                                    _pageControllers[
                                                                        index],
                                                                itemCount:
                                                                    GetSavePostData
                                                                        ?.object?[
                                                                            index]
                                                                        .postData
                                                                        ?.length,
                                                                itemBuilder:
                                                                    (BuildContext
                                                                            context,
                                                                        int index1) {
                                                                  if (GetSavePostData
                                                                          ?.object?[
                                                                              index]
                                                                          .postDataType ==
                                                                      "IMAGE") {
                                                                    return Container(
                                                                      width:
                                                                          _width,
                                                                      margin: EdgeInsets.only(
                                                                          left:
                                                                              16,
                                                                          top:
                                                                              15,
                                                                          right:
                                                                              16),
                                                                      child: Center(
                                                                          child: GestureDetector(
                                                                        onTap:
                                                                            () {
                                                                          Navigator
                                                                              .push(
                                                                            context,
                                                                            MaterialPageRoute(
                                                                                builder: (context) => OpenSavePostImage(
                                                                                      PostID: GetSavePostData?.object?[index].postUid,
                                                                                      index: index1,
                                                                                    )),
                                                                          );
                                                                        },
                                                                        child:
                                                                            Stack(
                                                                          children: [
                                                                            Align(
                                                                              alignment: Alignment.topCenter,
                                                                              child: CustomImageView(
                                                                                url: "${GetSavePostData?.object?[index].postData?[index1]}",
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
                                                                                      imageCount1.toString() + '/' + '${GetSavePostData?.object?[index].postData?.length}',
                                                                                      style: TextStyle(color: Colors.white),
                                                                                    )),
                                                                              ),
                                                                            )
                                                                          ],
                                                                        ),
                                                                      )),
                                                                    );
                                                                  } else if (GetSavePostData
                                                                          ?.object?[
                                                                              index]
                                                                          .postDataType ==
                                                                      "ATTACHMENT") {
                                                                    return Container(
                                                                        height:
                                                                            200,
                                                                        width:
                                                                            _width,
                                                                        child:
                                                                            DocumentViewScreen1(
                                                                          path: GetSavePostData
                                                                              ?.object?[index]
                                                                              .postData?[index1]
                                                                              .toString(),
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
                                                                  padding: const EdgeInsets
                                                                          .only(
                                                                      top: 0),
                                                                  child:
                                                                      Container(
                                                                    height: 20,
                                                                    child:
                                                                        DotsIndicator(
                                                                      dotsCount:
                                                                          GetSavePostData?.object?[index].postData?.length ??
                                                                              0,
                                                                      position:
                                                                          _currentPages[index]
                                                                              .toDouble(),
                                                                      decorator:
                                                                          DotsDecorator(
                                                                        size: const Size(
                                                                            10.0,
                                                                            7.0),
                                                                        activeSize: const Size(
                                                                            10.0,
                                                                            10.0),
                                                                        spacing:
                                                                            const EdgeInsets.symmetric(horizontal: 2),
                                                                        activeColor:
                                                                            ColorConstant.primary_color,
                                                                        color: Color(
                                                                            0xff6A6A6A),
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
                                  padding: const EdgeInsets.only(
                                      left: 10, right: 10, bottom: 10, top: 20),
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        border: Border.all(
                                            color: Colors.grey.shade200),
                                        borderRadius:
                                            BorderRadius.circular(15)),
                                    // height: 300,
                                    width: _width,
                                    child: Column(
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
                                                /*    await BlocProvider.of<
                                        GetGuestAllPostCubit>(context)
                                    .seetinonExpried(context); */
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
                                                              "${GetSavePostData?.object?[index].repostOn?.userUid}",
                                                          isFollowing:
                                                              GetSavePostData
                                                                  ?.object?[
                                                                      index]
                                                                  .repostOn
                                                                  ?.isFollowing));
                                                })).then(
                                                    (value) => Get_UserToken());
                                                //
                                              },
                                              child: GetSavePostData
                                                              ?.object?[index]
                                                              .repostOn
                                                              ?.userProfilePic !=
                                                          null &&
                                                      GetSavePostData
                                                              ?.object?[index]
                                                              .repostOn
                                                              ?.userProfilePic !=
                                                          ""
                                                  ? CircleAvatar(
                                                      backgroundImage: NetworkImage(
                                                          "${GetSavePostData?.object?[index].repostOn?.userProfilePic}"),
                                                      backgroundColor:
                                                          Colors.white,
                                                      radius: 25,
                                                    )
                                                  : CustomImageView(
                                                      imagePath: ImageConstant
                                                          .tomcruse,
                                                      height: 50,
                                                      width: 50,
                                                      fit: BoxFit.fill,
                                                      radius:
                                                          BorderRadius.circular(
                                                              25),
                                                    ),
                                            ),
                                            title: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                GestureDetector(
                                                  onTap: () async {
                                                    /*    await BlocProvider.of<
                                                  GetGuestAllPostCubit>(
                                              context)
                                          .seetinonExpried(context); */
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
                                                                  "${GetSavePostData?.object?[index].repostOn?.userUid}",
                                                              isFollowing:
                                                                  GetSavePostData
                                                                      ?.object?[
                                                                          index]
                                                                      .repostOn
                                                                      ?.isFollowing));
                                                    })).then((value) =>
                                                        Get_UserToken());
                                                    //
                                                  },
                                                  child: Container(
                                                    // color:
                                                    //     Colors.amber,
                                                    child: Text(
                                                      "${GetSavePostData?.object?[index].repostOn?.postUserName}",
                                                      style: TextStyle(
                                                          fontSize: 20,
                                                          fontFamily: "outfit",
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ),
                                                ),
                                                Text(
                                                  GetSavePostData
                                                              ?.object?[index]
                                                              .repostOn ==
                                                          null
                                                      ? ""
                                                      : getTimeDifference(
                                                          repostTime!),
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
                                        GetSavePostData?.object?[index].repostOn
                                                    ?.description !=
                                                null
                                            ? Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 16),
                                                child: LinkifyText(
                                                  "${GetSavePostData?.object?[index].repostOn?.description}",
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

                                                    var SelectedTest =
                                                        link.value.toString();
                                                    var Link =
                                                        SelectedTest.startsWith(
                                                            'https');
                                                    var Link1 =
                                                        SelectedTest.startsWith(
                                                            'http');
                                                    var Link2 =
                                                        SelectedTest.startsWith(
                                                            'www');
                                                    var Link3 =
                                                        SelectedTest.startsWith(
                                                            'WWW');
                                                    var Link4 =
                                                        SelectedTest.startsWith(
                                                            'HTTPS');
                                                    var Link5 =
                                                        SelectedTest.startsWith(
                                                            'HTTP');
                                                    var Link6 =
                                                        SelectedTest.startsWith(
                                                            'https://pdslink.page.link/');
                                                    print(SelectedTest
                                                        .toString());

                                                    if (User_ID == null) {
                                                      Navigator.of(context).push(
                                                          MaterialPageRoute(
                                                              builder: (context) =>
                                                                  RegisterCreateAccountScreen()));
                                                    } else {
                                                      if (Link == true ||
                                                          Link1 == true ||
                                                          Link2 == true ||
                                                          Link3 == true ||
                                                          Link4 == true ||
                                                          Link5 == true ||
                                                          Link6 == true) {
                                                        if (Link2 == true ||
                                                            Link3 == true) {
                                                          launchUrl(Uri.parse(
                                                              "https://${link.value.toString()}"));
                                                          print(
                                                              "qqqqqqqqhttps://${link.value}");
                                                        } else {
                                                          if (Link6 == true) {
                                                            print(
                                                                "yes i am inList =   room");
                                                            Navigator.push(
                                                                context,
                                                                MaterialPageRoute(
                                                              builder:
                                                                  (context) {
                                                                return NewBottomBar(
                                                                  buttomIndex:
                                                                      1,
                                                                );
                                                              },
                                                            ));
                                                          } else {
                                                            launchUrl(Uri.parse(
                                                                link.value
                                                                    .toString()));
                                                            print(
                                                                "link.valuelink.value -- ${link.value}");
                                                          }
                                                        }
                                                      } else {
                                                        if (link.value!
                                                            .startsWith('#')) {
                                                          /*   await BlocProvider.of<
                                                      GetGuestAllPostCubit>(
                                                  context)
                                              .seetinonExpried(context); */
                                                          print(
                                                              "aaaaaaaaaa == ${link}");
                                                          Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                builder: (context) =>
                                                                    HashTagViewScreen(
                                                                        title:
                                                                            "${link.value}"),
                                                              ));
                                                        } else if (link.value!
                                                            .startsWith('@')) {
                                                          /*  await BlocProvider.of<
                                                      GetGuestAllPostCubit>(
                                                  context)
                                              .seetinonExpried(context); */
                                                          var name;
                                                          var tagName;
                                                          name = SelectedTest;
                                                          tagName =
                                                              name.replaceAll(
                                                                  "@", "");
                                                          await BlocProvider.of<
                                                                      NewProfileSCubit>(
                                                                  context)
                                                              .UserTagAPI(
                                                                  context,
                                                                  tagName);

                                                          Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                  builder:
                                                                      (context) {
                                                            return ProfileScreen(
                                                                User_ID:
                                                                    "${userTagModel?.object}",
                                                                isFollowing:
                                                                    "");
                                                          })).then((value) =>
                                                              Get_UserToken());

                                                          print(
                                                              "tagName -- ${tagName}");
                                                          print(
                                                              "user id -- ${userTagModel?.object}");
                                                        }
                                                      }
                                                    }
                                                  },
                                                ))
                                            : SizedBox(),
                                        Container(
                                          width: _width,
                                          child: GetSavePostData?.object?[index]
                                                      .repostOn?.postDataType ==
                                                  null
                                              ? SizedBox()
                                              : GetSavePostData
                                                          ?.object?[index]
                                                          .repostOn
                                                          ?.postData
                                                          ?.length ==
                                                      1
                                                  ? (GetSavePostData
                                                              ?.object?[index]
                                                              .repostOn
                                                              ?.postDataType ==
                                                          "IMAGE"
                                                      ? GestureDetector(
                                                          onTap: () {
                                                            Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                  builder:
                                                                      (context) =>
                                                                          OpenSavePostImage(
                                                                            PostID:
                                                                                GetSavePostData?.object?[index].repostOn?.postUid,
                                                                            index:
                                                                                index,
                                                                          )),
                                                            );
                                                          },
                                                          child: Container(
                                                            width: _width,
                                                            height: 150,
                                                            margin:
                                                                EdgeInsets.only(
                                                                    left: 16,
                                                                    top: 15,
                                                                    right: 16),
                                                            child: Center(
                                                                child:
                                                                    CustomImageView(
                                                              url:
                                                                  "${GetSavePostData?.object?[index].repostOn?.postData?[0]}",
                                                            )),
                                                          ),
                                                        )
                                                      : GetSavePostData
                                                                  ?.object?[
                                                                      index]
                                                                  .repostOn
                                                                  ?.postDataType ==
                                                              "VIDEO"
                                                          ? /* repostMainControllers[0].value.isInitialized
                                                                              ? */
                                                          Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      right: 20,
                                                                      top: 15),
                                                              child: Column(
                                                                mainAxisSize:
                                                                    MainAxisSize
                                                                        .min,
                                                                children: [
                                                                  VideoListItem1(
                                                                    videoUrl:
                                                                        videoUrls[
                                                                            index],
                                                                    PostID: GetSavePostData
                                                                        ?.object?[
                                                                            index]
                                                                        .postUid,
                                                                    discrption: GetSavePostData
                                                                        ?.object?[
                                                                            index]
                                                                        .repostOn
                                                                        ?.description,
                                                                    /* isData: User_ID ==
                                                                      null
                                                                  ? false
                                                                  : true, */
                                                                  )
                                                                ],
                                                              ),
                                                            )
                                                          // : SizedBox()
                                                          : GetSavePostData
                                                                      ?.object?[
                                                                          index]
                                                                      .repostOn
                                                                      ?.postDataType ==
                                                                  "ATTACHMENT"
                                                              ? Stack(
                                                                  children: [
                                                                    Container(
                                                                      height:
                                                                          400,
                                                                      width:
                                                                          _width,
                                                                      color: Colors
                                                                          .transparent,
                                                                    ),
                                                                    GestureDetector(
                                                                      onTap:
                                                                          () {
                                                                        print(
                                                                            "objectobjectobjectobject");
                                                                        Navigator.push(
                                                                            context,
                                                                            MaterialPageRoute(
                                                                          builder:
                                                                              (context) {
                                                                            return DocumentViewScreen1(
                                                                              path: GetSavePostData?.object?[index].repostOn?.postData?[0].toString(),
                                                                            );
                                                                          },
                                                                        ));
                                                                      },
                                                                      child:
                                                                          Container(
                                                                        child:
                                                                            CachedNetworkImage(
                                                                          imageUrl:
                                                                              GetSavePostData?.object?[index].repostOn?.thumbnailImageUrl ?? "",
                                                                          fit: BoxFit
                                                                              .cover,
                                                                        ),
                                                                      ),
                                                                    )
                                                                  ],
                                                                )
                                                              : SizedBox())
                                                  : Column(
                                                      children: [
                                                        Stack(
                                                          children: [
                                                            if ((GetSavePostData
                                                                    ?.object?[
                                                                        index]
                                                                    .repostOn
                                                                    ?.postData
                                                                    ?.isNotEmpty ??
                                                                false)) ...[
                                                              SizedBox(
                                                                height: 300,
                                                                child: PageView
                                                                    .builder(
                                                                  onPageChanged:
                                                                      (page) {
                                                                    super
                                                                        .setState(
                                                                            () {
                                                                      _currentPages[
                                                                              index] =
                                                                          page;
                                                                      imageCount2 =
                                                                          page +
                                                                              1;
                                                                    });
                                                                  },
                                                                  controller:
                                                                      _pageControllers[
                                                                          index],
                                                                  itemCount: GetSavePostData
                                                                      ?.object?[
                                                                          index]
                                                                      .repostOn
                                                                      ?.postData
                                                                      ?.length,
                                                                  itemBuilder:
                                                                      (BuildContext
                                                                              context,
                                                                          int index1) {
                                                                    if (GetSavePostData
                                                                            ?.object?[
                                                                                index]
                                                                            .repostOn
                                                                            ?.postDataType ==
                                                                        "IMAGE") {
                                                                      return GestureDetector(
                                                                        onTap:
                                                                            () {
                                                                          print(
                                                                              "Repost Opne Full screen");

                                                                          Navigator
                                                                              .push(
                                                                            context,
                                                                            MaterialPageRoute(
                                                                                builder: (context) => OpenSavePostImage(
                                                                                      PostID: GetSavePostData?.object?[index].repostOn?.postUid,
                                                                                      index: index1,
                                                                                    )),
                                                                          );
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
                                                                              child: Stack(
                                                                            children: [
                                                                              Align(
                                                                                alignment: Alignment.topCenter,
                                                                                child: CustomImageView(
                                                                                  url: "${GetSavePostData?.object?[index].repostOn?.postData?[index1]}",
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
                                                                                        imageCount2.toString() + '/' + '${GetSavePostData?.object?[index].repostOn?.postData?.length}',
                                                                                        style: TextStyle(color: Colors.white),
                                                                                      )),
                                                                                ),
                                                                              )
                                                                            ],
                                                                          )),
                                                                        ),
                                                                      );
                                                                    } else if (GetSavePostData
                                                                            ?.object?[index]
                                                                            .repostOn
                                                                            ?.postDataType ==
                                                                        "ATTACHMENT") {
                                                                      return Container(
                                                                          height:
                                                                              400,
                                                                          width:
                                                                              _width,
                                                                          child:
                                                                              DocumentViewScreen1(
                                                                            path:
                                                                                GetSavePostData?.object?[index].repostOn?.postData?[index1].toString(),
                                                                          ));
                                                                    }
                                                                  },
                                                                ),
                                                              ),
                                                              Positioned(
                                                                  bottom: 5,
                                                                  left: 0,
                                                                  right: 0,
                                                                  child:
                                                                      Padding(
                                                                    padding: const EdgeInsets
                                                                            .only(
                                                                        top: 0),
                                                                    child:
                                                                        Container(
                                                                      height:
                                                                          20,
                                                                      child:
                                                                          DotsIndicator(
                                                                        dotsCount:
                                                                            GetSavePostData?.object?[index].repostOn?.postData?.length ??
                                                                                1,
                                                                        position:
                                                                            _currentPages[index].toDouble(),
                                                                        decorator:
                                                                            DotsDecorator(
                                                                          size: const Size(
                                                                              10.0,
                                                                              7.0),
                                                                          activeSize: const Size(
                                                                              10.0,
                                                                              10.0),
                                                                          spacing:
                                                                              const EdgeInsets.symmetric(horizontal: 2),
                                                                          activeColor:
                                                                              ColorConstant.primary_color,
                                                                          color:
                                                                              Color(0xff6A6A6A),
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
                                  padding: const EdgeInsets.only(left: 13),
                                  child: Divider(
                                    thickness: 1,
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.only(top: 0, right: 16),
                                  child: Row(
                                    children: [
                                      SizedBox(
                                        width: 14,
                                      ),
                                      GestureDetector(
                                        onTap: () async {
                                          await soicalFunationSave(
                                              apiName: 'like_post',
                                              index: index);
                                        },
                                        child: Container(
                                          color: Colors.transparent,
                                          child: Padding(
                                            padding: const EdgeInsets.all(5.0),
                                            child: GetSavePostData
                                                        ?.object?[index]
                                                        .isLiked !=
                                                    true
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
                                        width: 0,
                                      ),
                                      GetSavePostData
                                                  ?.object?[index].likedCount ==
                                              0
                                          ? SizedBox()
                                          : GestureDetector(
                                              onTap: () {
                                                /* Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                               
                                                    ShowAllPostLike("${GetSavePostData??.object?[index].postUid}"))); */

                                                Navigator.push(context,
                                                    MaterialPageRoute(
                                                  builder: (context) {
                                                    return ShowAllPostLike(
                                                        "${GetSavePostData?.object?[index].postUid}");
                                                  },
                                                ));
                                              },
                                              child: Container(
                                                color: Colors.transparent,
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(5.0),
                                                  child: Text(
                                                    "${GetSavePostData?.object?[index].likedCount}",
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
                                          BlocProvider.of<AddcommentCubit>(
                                                  context)
                                              .Addcomment(context,
                                                  '${GetSavePostData?.object?[index].postUid}');

                                          _settingModalBottomSheetSave(
                                              context, index, _height);
                                        },
                                        child: Container(
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
                                      SizedBox(
                                        width: 5,
                                      ),
                                      GetSavePostData?.object?[index]
                                                  .commentCount ==
                                              0
                                          ? SizedBox()
                                          : Text(
                                              "${GetSavePostData?.object?[index].commentCount}",
                                              style: TextStyle(
                                                  fontFamily: "outfit",
                                                  fontSize: 14),
                                            ),
                                      SizedBox(
                                        width: 8,
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          rePostBottomSheetSave(context, index);
                                        },
                                        child: Container(
                                          color: Colors.transparent,
                                          child: Padding(
                                            padding: const EdgeInsets.all(5.0),
                                            child: Image.asset(
                                              ImageConstant.vector2,
                                              height: 13,
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      GetSavePostData?.object?[index]
                                                      .repostCount ==
                                                  null ||
                                              GetSavePostData?.object?[index]
                                                      .repostCount ==
                                                  0
                                          ? SizedBox()
                                          : Text(
                                              '${GetSavePostData?.object?[index].repostCount}',
                                              style: TextStyle(
                                                  fontFamily: "outfit",
                                                  fontSize: 14),
                                            ),
                                      GestureDetector(
                                        onTap: () {
                                          _onShareXFileFromAssets(context,
                                              androidLink:
                                                  '${GetSavePostData?.object?[index].postLink}'
                                              /* iosLink:
                                              "https://apps.apple.com/inList =  /app/growder-b2b-platform/id6451333863" */
                                              );
                                        },
                                        child: Container(
                                          height: 20,
                                          width: 30,
                                          color: Colors.transparent,
                                          child: Icon(Icons.share_rounded,
                                              size: 20),
                                        ),
                                      ),
                                      Spacer(),
                                      GestureDetector(
                                        onTap: () async {
                                          await soicalFunationSave(
                                              apiName: 'savedata',
                                              index: index);
                                        },
                                        child: Container(
                                          color: Colors.transparent,
                                          child: Padding(
                                            padding: const EdgeInsets.all(5.0),
                                            child: Image.asset(
                                              GetSavePostData?.object?[index]
                                                          .isSaved ==
                                                      false
                                                  ? ImageConstant.savePin
                                                  : ImageConstant.Savefill,
                                              height: 17,
                                            ),
                                          ),
                                        ),
                                      ),
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
                            left: 0, right: 0, top: 10, bottom: 10),
                        child: GestureDetector(
                          onDoubleTap: () async {
                            await soicalFunationSave(
                                apiName: 'like_post', index: index);
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              // color: Colors.red,
                              border: Border.all(
                                  color: Color.fromRGBO(0, 0, 0,
                                      0.25)), /* borderRadius: BorderRadius.circular(15) */
                            ),
                            // height: 300,
                            width: _width,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  height: 60,
                                  child: ListTile(
                                    leading: GestureDetector(
                                      onTap: () async {
                                        /*   await BlocProvider.of<GetGuestAllPostCubit>(
                                context)
                            .seetinonExpried(context); */
                                        Navigator.push(context,
                                            MaterialPageRoute(
                                                builder: (context) {
                                          return MultiBlocProvider(
                                              providers: [
                                                BlocProvider<NewProfileSCubit>(
                                                  create: (context) =>
                                                      NewProfileSCubit(),
                                                ),
                                              ],
                                              child: ProfileScreen(
                                                  User_ID:
                                                      "${GetSavePostData?.object?[index].userUid}",
                                                  isFollowing: GetSavePostData
                                                      ?.object?[index]
                                                      .isFollowing));
                                        })).then((value) => Get_UserToken());
                                        //
                                      },
                                      child: GetSavePostData?.object?[index]
                                                      .userProfilePic !=
                                                  null &&
                                              GetSavePostData?.object?[index]
                                                      .userProfilePic !=
                                                  ""
                                          ? CircleAvatar(
                                              backgroundImage: NetworkImage(
                                                  "${GetSavePostData?.object?[index].userProfilePic}"),
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        // SizedBox(
                                        //   height: 6,
                                        // ),
                                        GestureDetector(
                                          onTap: () async {
                                            /*    await BlocProvider.of<GetGuestAllPostCubit>(
                                    context)
                                .seetinonExpried(context); */
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
                                                          "${GetSavePostData?.object?[index].userUid}",
                                                      isFollowing:
                                                          GetSavePostData
                                                              ?.object?[index]
                                                              .isFollowing));
                                            })).then(
                                                (value) => Get_UserToken());
                                            //
                                          },
                                          child: Container(
                                            // color: Colors.amber,
                                            child: Text(
                                              "${GetSavePostData?.object?[index].postUserName}",
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  fontFamily: "outfit",
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ),
                                        //FIndText
                                        Text(
                                          getTimeDifference(parsedDateTime),
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
                                GetSavePostData?.object?[index].description !=
                                        null
                                    ? Padding(
                                        padding:
                                            const EdgeInsets.only(left: 16),
                                        child:
                                            //this is the despcation
                                            GestureDetector(
                                                onTap: () async {
                                                  if (DataGet == true) {
                                                    await launch(
                                                        '${GetSavePostData?.object?[index].description}',
                                                        forceWebView: true,
                                                        enableJavaScript: true);
                                                  } else {
                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              OpenSavePostImage(
                                                                PostID: GetSavePostData
                                                                    ?.object?[
                                                                        index]
                                                                    .postUid,
                                                              )),
                                                    );
                                                  }
                                                },
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    /*  GestureDetector(
                                                                      onTap: () async {
                                                                        print("value cheak${GetSavePostData??.object?[index].isfalsegu}");
                                                                        print("value cheak${GetSavePostData??.object?[index].isfalsehin}");
                                                                        String inputText = "${GetSavePostData??.object?[index].description}";
                                                                        String translatedTextGujarati = await translateText(inputText, 'gu');
                                                                        String translatedTextHindi = await translateText(inputText, 'hi');
                                                                        String translatedTextenglish = await translateText(inputText, 'en');

                                                                        if (GetSavePostData??.object?[index].isfalsehin == null && GetSavePostData??.object?[index].isfalsegu == null) {
                                                                          super.setState(() {
                                                                            _translatedTextHindi = translatedTextHindi;

                                                                            // GetSavePostData??.object?[index].description = _translatedTextGujarati;
                                                                            GetSavePostData??.object?[index].description = _translatedTextHindi;
                                                                            GetSavePostData??.object?[index].isfalsehin = true;
                                                                          });
                                                                        } else if (GetSavePostData??.object?[index].isfalsehin == true && GetSavePostData??.object?[index].isfalsegu == null) {
                                                                          super.setState(() {
                                                                            // isDataSet = false;
                                                                            _translatedTextGujarati = translatedTextGujarati;
                                                                            // _translatedTextHindi = translatedTextHindi;

                                                                            // GetSavePostData??.object?[index].description = _translatedTextGujarati;
                                                                            GetSavePostData??.object?[index].description = _translatedTextGujarati;
                                                                            GetSavePostData??.object?[index].isfalsegu = true;
                                                                            //  isDataSet = true;
                                                                          });
                                                                        } else if (GetSavePostData??.object?[index].isfalsehin == true && GetSavePostData??.object?[index].isfalsehin == true) {
                                                                          print("this condison is working");

                                                                          super.setState(() {
                                                                            print("i'm cheaking dataa--------------------------------$initalData");
                                                                            // isDataSet = false;
                                                                            _translatedTextenglish = translatedTextenglish;
                                                                            GetSavePostData??.object?[index].description = _translatedTextenglish;
                                                                            GetSavePostData??.object?[index].isfalsegu = null;
                                                                            GetSavePostData??.object?[index].isfalsehin = null;
                                                                            // isDataSet = true;
                                                                          });
                                                                        }
                                                                      },
                                                                      child: Container(
                                                                          width: 80,
                                                                          decoration: BoxDecoration(color: ColorConstant.primaryLight_color, borderRadius: BorderRadius.circular(10)),
                                                                          child: Center(
                                                                              child: Text(
                                                                            "Translate",
                                                                            style: TextStyle(
                                                                              fontFamily: 'outfit',
                                                                              fontWeight: FontWeight.bold,
                                                                            ),
                                                                          ))),
                                                                    ), */
                                                    GetSavePostData
                                                                ?.object?[index]
                                                                .translatedDescription !=
                                                            null
                                                        ? GestureDetector(
                                                            onTap: () async {
                                                              super
                                                                  .setState(() {
                                                                if (GetSavePostData
                                                                            ?.object?[
                                                                                index]
                                                                            .isTrsnalteoption ==
                                                                        false ||
                                                                    GetSavePostData
                                                                            ?.object?[index]
                                                                            .isTrsnalteoption ==
                                                                        null) {
                                                                  GetSavePostData
                                                                      ?.object?[
                                                                          index]
                                                                      .isTrsnalteoption = true;
                                                                } else {
                                                                  GetSavePostData
                                                                      ?.object?[
                                                                          index]
                                                                      .isTrsnalteoption = false;
                                                                }
                                                              });
                                                            },
                                                            child: Container(
                                                                width: 80,
                                                                decoration:
                                                                    BoxDecoration(
                                                                  color: ColorConstant
                                                                      .primaryLight_color,
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              10),
                                                                ),
                                                                child: Center(
                                                                    child: Text(
                                                                  "Translate",
                                                                  style:
                                                                      TextStyle(
                                                                    fontFamily:
                                                                        'outfit',
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                  ),
                                                                ))),
                                                          )
                                                        : SizedBox(),
                                                    SizedBox(
                                                      height: 10,
                                                    ),
                                                    Row(
                                                      children: [
                                                        Expanded(
                                                          child: Container(
                                                            child: LinkifyText(
                                                              GetSavePostData?.object?[index].isTrsnalteoption ==
                                                                          false ||
                                                                      GetSavePostData
                                                                              ?.object?[index]
                                                                              .isTrsnalteoption ==
                                                                          null
                                                                  ? "${GetSavePostData?.object?[index].description}"
                                                                  : "${GetSavePostData?.object?[index].translatedDescription}",
                                                              linkStyle:
                                                                  TextStyle(
                                                                color:
                                                                    Colors.blue,
                                                                fontFamily:
                                                                    'outfit',
                                                              ),
                                                              textStyle:
                                                                  TextStyle(
                                                                color: Colors
                                                                    .black,
                                                                fontFamily:
                                                                    'outfit',
                                                              ),
                                                              linkTypes: [
                                                                LinkType.url,
                                                                LinkType
                                                                    .userTag,
                                                                LinkType
                                                                    .hashTag,
                                                                // LinkType
                                                                //     .email
                                                              ],
                                                              onTap:
                                                                  (link) async {
                                                                /// do stuff with `link` like
                                                                /// if(link.type == Link.url) launchUrl(link.value);

                                                                var SelectedTest =
                                                                    link.value
                                                                        .toString();
                                                                var Link = SelectedTest
                                                                    .startsWith(
                                                                        'https');
                                                                var Link1 = SelectedTest
                                                                    .startsWith(
                                                                        'http');
                                                                var Link2 =
                                                                    SelectedTest
                                                                        .startsWith(
                                                                            'www');
                                                                var Link3 =
                                                                    SelectedTest
                                                                        .startsWith(
                                                                            'WWW');
                                                                var Link4 = SelectedTest
                                                                    .startsWith(
                                                                        'HTTPS');
                                                                var Link5 = SelectedTest
                                                                    .startsWith(
                                                                        'HTTP');
                                                                var Link6 = SelectedTest
                                                                    .startsWith(
                                                                        'https://pdslink.page.link/');
                                                                print("tag -- " +
                                                                    SelectedTest
                                                                        .toString());

                                                                if (User_ID ==
                                                                    null) {
                                                                  Navigator.of(
                                                                          context)
                                                                      .push(MaterialPageRoute(
                                                                          builder: (context) =>
                                                                              RegisterCreateAccountScreen()));
                                                                } else {
                                                                  if (Link ==
                                                                          true ||
                                                                      Link1 ==
                                                                          true ||
                                                                      Link2 ==
                                                                          true ||
                                                                      Link3 ==
                                                                          true ||
                                                                      Link4 ==
                                                                          true ||
                                                                      Link5 ==
                                                                          true ||
                                                                      Link6 ==
                                                                          true) {
                                                                    if (Link2 ==
                                                                            true ||
                                                                        Link3 ==
                                                                            true) {
                                                                      launchUrl(
                                                                          Uri.parse(
                                                                              "https://${link.value.toString()}"));
                                                                      print(
                                                                          "qqqqqqqqhttps://${link.value}");
                                                                    } else {
                                                                      if (Link6 ==
                                                                          true) {
                                                                        print(
                                                                            "yes i am inList =   room");
                                                                        Navigator.push(
                                                                            context,
                                                                            MaterialPageRoute(
                                                                          builder:
                                                                              (context) {
                                                                            return NewBottomBar(
                                                                              buttomIndex: 1,
                                                                            );
                                                                          },
                                                                        ));
                                                                      } else {
                                                                        launchUrl(Uri.parse(link
                                                                            .value
                                                                            .toString()));
                                                                        print(
                                                                            "link.valuelink.value -- ${link.value}");
                                                                      }
                                                                    }
                                                                  } else if (link
                                                                          .value !=
                                                                      null) {
                                                                    if (link
                                                                        .value!
                                                                        .startsWith(
                                                                            '#')) {
                                                                      /*   await BlocProvider
                                                              .of<GetGuestAllPostCubit>(
                                                                  context)
                                                          .seetinonExpried(
                                                              context); */
                                                                      Navigator.push(
                                                                          context,
                                                                          MaterialPageRoute(
                                                                            builder: (context) =>
                                                                                HashTagViewScreen(title: "${link.value}"),
                                                                          ));
                                                                    } else if (link
                                                                        .value!
                                                                        .startsWith(
                                                                            '@')) {
                                                                      /*  await BlocProvider
                                                              .of<GetGuestAllPostCubit>(
                                                                  context)
                                                          .seetinonExpried(
                                                              context); */
                                                                      var name;
                                                                      var tagName;
                                                                      name =
                                                                          SelectedTest;
                                                                      tagName =
                                                                          name.replaceAll(
                                                                              "@",
                                                                              "");
                                                                      await BlocProvider.of<NewProfileSCubit>(context).UserTagAPI(
                                                                          context,
                                                                          tagName);

                                                                      Navigator.push(
                                                                          context,
                                                                          MaterialPageRoute(builder:
                                                                              (context) {
                                                                        return ProfileScreen(
                                                                            User_ID:
                                                                                "${userTagModel?.object}",
                                                                            isFollowing:
                                                                                "");
                                                                      })).then(
                                                                          (value) =>
                                                                              Get_UserToken());

                                                                      print(
                                                                          "tagName -- ${tagName}");
                                                                      print(
                                                                          "user id -- ${userTagModel?.object}");
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
                                                      ],
                                                    ),
                                                  ],
                                                )),
                                      )
                                    : SizedBox(),
                                // index == 0

                                Container(
                                  width: _width,
                                  child: GetSavePostData
                                              ?.object?[index].postDataType ==
                                          null
                                      ? SizedBox()
                                      : GetSavePostData?.object?[index].postData
                                                  ?.length ==
                                              1
                                          ? (GetSavePostData?.object?[index]
                                                      .postDataType ==
                                                  "IMAGE"
                                              ? GestureDetector(
                                                  onTap: () {
                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              OpenSavePostImage(
                                                                PostID: GetSavePostData
                                                                    ?.object?[
                                                                        index]
                                                                    .postUid,
                                                                index: index,
                                                              )),
                                                    );
                                                  },
                                                  child: Container(
                                                    width: _width,
                                                    margin: EdgeInsets.only(
                                                        left: 0,
                                                        top: 15,
                                                        right: 0),
                                                    child: Center(
                                                      child: /* CustomImageView(
                                                      url:
                                                          "${GetSavePostData?.object?[index].postData?[0]}",
                                                    ) */
                                                          PinchZoom(
                                                        child:
                                                            CachedNetworkImage(
                                                          imageUrl:
                                                              "${GetSavePostData?.object?[index].postData?[0]}",
                                                        ),
                                                        maxScale: 4,
                                                        onZoomStart: () {
                                                          print(
                                                              'Start zooming');
                                                        },
                                                        onZoomEnd: () {
                                                          print('Stop zooming');
                                                        },
                                                      ),
                                                    ),
                                                  ),
                                                )
                                              : GetSavePostData?.object?[index]
                                                          .postDataType ==
                                                      "VIDEO"
                                                  ? /*  mainPostControllers[0].value.isInitialized
                                                                      ? */

                                                  Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              right: 20,
                                                              top: 15),
                                                      child: Column(
                                                        mainAxisSize:
                                                            MainAxisSize.min,
                                                        children: [
                                                          /* Container(
                                                                                    height: 250,
                                                                                    width: _width,
                                                                                    child: Chewie(
                                                                                      controller: chewieController[index],
                                                                                    )), */

                                                          VideoListItem1(
                                                              videoUrl:
                                                                  videoUrls[
                                                                      index],
                                                              PostID:
                                                                  GetSavePostData
                                                                      ?.object?[
                                                                          index]
                                                                      .postUid
                                                              /* isData: User_ID == null
                                                          ? false
                                                          : true, */
                                                              ),
                                                        ],
                                                      ),
                                                    )
                                                  // : SizedBox()

                                                  : GetSavePostData
                                                              ?.object?[index]
                                                              .postDataType ==
                                                          "ATTACHMENT"
                                                      ? (GetSavePostData
                                                                  ?.object?[
                                                                      index]
                                                                  .postData
                                                                  ?.isNotEmpty ==
                                                              true)
                                                          ? Stack(
                                                              children: [
                                                                Container(
                                                                  height: 400,
                                                                  width: _width,
                                                                  color: Colors
                                                                      .transparent,
                                                                  /* child: DocumentViewScreen1(
                                                                                    path: GetSavePostData??.object?[index].postData?[0].toString(),
                                                                                  ) */
                                                                ),
                                                                GestureDetector(
                                                                  onTap: () {
                                                                    print(
                                                                        "objectobjectobjectobject");
                                                                    Navigator.push(
                                                                        context,
                                                                        MaterialPageRoute(
                                                                      builder:
                                                                          (context) {
                                                                        return DocumentViewScreen1(
                                                                          path: GetSavePostData
                                                                              ?.object?[index]
                                                                              .postData?[0]
                                                                              .toString(),
                                                                        );
                                                                      },
                                                                    ));
                                                                  },
                                                                  child:
                                                                      Container(
                                                                    child:
                                                                        CachedNetworkImage(
                                                                      imageUrl:
                                                                          GetSavePostData?.object?[index].thumbnailImageUrl ??
                                                                              "",
                                                                      fit: BoxFit
                                                                          .cover,
                                                                    ),
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
                                                    if ((GetSavePostData
                                                            ?.object?[index]
                                                            .postData
                                                            ?.isNotEmpty ??
                                                        false)) ...[
                                                      Container(
                                                        height: _height / 1.4,
                                                        child: PageView.builder(
                                                          onPageChanged:
                                                              (page) {
                                                            super.setState(() {
                                                              _currentPages[
                                                                  index] = page;
                                                              imageCount =
                                                                  page + 1;
                                                            });
                                                          },
                                                          controller:
                                                              _pageControllers[
                                                                  index],
                                                          itemCount:
                                                              GetSavePostData
                                                                  ?.object?[
                                                                      index]
                                                                  .postData
                                                                  ?.length,
                                                          itemBuilder:
                                                              (BuildContext
                                                                      context,
                                                                  int index1) {
                                                            if (GetSavePostData
                                                                    ?.object?[
                                                                        index]
                                                                    .postDataType ==
                                                                "IMAGE") {
                                                              return Container(
                                                                width: _width,
                                                                margin: EdgeInsets
                                                                    .only(
                                                                        left: 0,
                                                                        top: 15,
                                                                        right:
                                                                            0),
                                                                child: Center(
                                                                    child:
                                                                        GestureDetector(
                                                                  onTap: () {
                                                                    Navigator
                                                                        .push(
                                                                      context,
                                                                      MaterialPageRoute(
                                                                          builder: (context) =>
                                                                              OpenSavePostImage(
                                                                                PostID: GetSavePostData?.object?[index].postUid,
                                                                                index: index1,
                                                                              )),
                                                                    );
                                                                  },
                                                                  child: Stack(
                                                                    children: [
                                                                      Align(
                                                                        alignment:
                                                                            Alignment.center,
                                                                        child:
                                                                            PinchZoom(
                                                                          child:
                                                                              CachedNetworkImage(
                                                                            imageUrl:
                                                                                "${GetSavePostData?.object?[index].postData?[index1]}",
                                                                          ),
                                                                          maxScale:
                                                                              4,
                                                                          onZoomStart:
                                                                              () {
                                                                            print('Start zooming');
                                                                          },
                                                                          onZoomEnd:
                                                                              () {
                                                                            print('Stop zooming');
                                                                          },
                                                                        ),
                                                                        /*  CustomImageView(
                                                                          url:
                                                                              "${GetSavePostData?.object?[index].postData?[index1]}",
                                                                        ) */
                                                                      ),
                                                                      Align(
                                                                        alignment:
                                                                            Alignment.topRight,
                                                                        child:
                                                                            Card(
                                                                          color:
                                                                              Colors.transparent,
                                                                          elevation:
                                                                              0,
                                                                          child: Container(
                                                                              alignment: Alignment.center,
                                                                              height: 30,
                                                                              width: 50,
                                                                              decoration: BoxDecoration(
                                                                                color: Color.fromARGB(255, 2, 1, 1),
                                                                                borderRadius: BorderRadius.all(Radius.circular(50)),
                                                                              ),
                                                                              child: Text(
                                                                                imageCount.toString() + '/' + '${GetSavePostData?.object?[index].postData?.length}',
                                                                                style: TextStyle(color: Colors.white),
                                                                              )),
                                                                        ),
                                                                      )
                                                                    ],
                                                                  ),
                                                                )),
                                                              );
                                                            } else if (GetSavePostData
                                                                    ?.object?[
                                                                        index]
                                                                    .postDataType ==
                                                                "ATTACHMENT") {
                                                              return Container(
                                                                  height: 400,
                                                                  width: _width,
                                                                  child:
                                                                      DocumentViewScreen1(
                                                                    path: GetSavePostData
                                                                        ?.object?[
                                                                            index]
                                                                        .postData?[
                                                                            index1]
                                                                        .toString(),
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
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    top: 0),
                                                            child: Container(
                                                              height: 20,
                                                              child:
                                                                  DotsIndicator(
                                                                dotsCount: GetSavePostData
                                                                        ?.object?[
                                                                            index]
                                                                        .postData
                                                                        ?.length ??
                                                                    0,
                                                                position: _currentPages[
                                                                        index]
                                                                    .toDouble(),
                                                                decorator:
                                                                    DotsDecorator(
                                                                  size:
                                                                      const Size(
                                                                          10.0,
                                                                          7.0),
                                                                  activeSize:
                                                                      const Size(
                                                                          10.0,
                                                                          10.0),
                                                                  spacing: const EdgeInsets
                                                                          .symmetric(
                                                                      horizontal:
                                                                          2),
                                                                  activeColor:
                                                                      ColorConstant
                                                                          .primary_color,
                                                                  color: Color(
                                                                      0xff6A6A6A),
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
                                  padding: const EdgeInsets.only(left: 13),
                                  child: Divider(
                                    thickness: 1,
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.only(top: 0, right: 16),
                                  child: Row(
                                    children: [
                                      SizedBox(
                                        width: 14,
                                      ),
                                      GestureDetector(
                                        onTap: () async {
                                          await soicalFunationSave(
                                              apiName: 'like_post',
                                              index: index);
                                        },
                                        child: Container(
                                          color: Colors.transparent,
                                          child: Padding(
                                            padding: EdgeInsets.all(5.0),
                                            child: GetSavePostData
                                                        ?.object?[index]
                                                        .isLiked !=
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
                                      SizedBox(
                                        width: 0,
                                      ),
                                      GetSavePostData
                                                  ?.object?[index].likedCount ==
                                              0
                                          ? SizedBox()
                                          : GestureDetector(
                                              onTap: () {
                                                Navigator.push(context,
                                                    MaterialPageRoute(
                                                  builder: (context) {
                                                    return ShowAllPostLike(
                                                        "${GetSavePostData?.object?[index].postUid}");
                                                  },
                                                ));
                                              },
                                              child: Container(
                                                color: Colors.transparent,
                                                child: Padding(
                                                  padding: EdgeInsets.all(5.0),
                                                  child: Align(
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    child: Text(
                                                      "${GetSavePostData?.object?[index].likedCount}",
                                                      style: TextStyle(
                                                          fontFamily: "outfit",
                                                          fontSize: 14),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                      SizedBox(
                                        width: 8,
                                      ),
                                      GestureDetector(
                                          onTap: () async {
                                            BlocProvider.of<AddcommentCubit>(
                                                    context)
                                                .Addcomment(context,
                                                    '${GetSavePostData?.object?[index].postUid}');

                                            _settingModalBottomSheetSave(
                                                context, index, _height);
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
                                      GetSavePostData?.object?[index]
                                                  .commentCount ==
                                              0
                                          ? SizedBox()
                                          : Text(
                                              "${GetSavePostData?.object?[index].commentCount}",
                                              style: TextStyle(
                                                  fontFamily: "outfit",
                                                  fontSize: 14),
                                            ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          rePostBottomSheetSave(context, index);
                                        },
                                        child: Container(
                                          color: Colors.transparent,
                                          child: Padding(
                                            padding: const EdgeInsets.all(5.0),
                                            child: Image.asset(
                                              ImageConstant.vector2,
                                              height: 13,
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      GetSavePostData?.object?[index]
                                                      .repostCount ==
                                                  null ||
                                              GetSavePostData?.object?[index]
                                                      .repostCount ==
                                                  0
                                          ? SizedBox()
                                          : Text(
                                              '${GetSavePostData?.object?[index].repostCount}',
                                              style: TextStyle(
                                                  fontFamily: "outfit",
                                                  fontSize: 14),
                                            ),
                                      GestureDetector(
                                        onTap: () {
                                          _onShareXFileFromAssets(
                                            context,
                                            androidLink:
                                                '${GetSavePostData?.object?[index].postLink}',
                                            /* iosLink:
                                              "https://apps.apple.com/inList =  /app/growder-b2b-platform/id6451333863" */
                                          );
                                        },
                                        child: Container(
                                          height: 20,
                                          width: 30,
                                          color: Colors.transparent,
                                          child: Icon(Icons.share_rounded,
                                              size: 20),
                                        ),
                                      ),
                                      Spacer(),
                                      GestureDetector(
                                        onTap: () async {
                                          await soicalFunationSave(
                                              apiName: 'savedata',
                                              index: index);
                                        },
                                        child: Container(
                                          color: Colors.transparent,
                                          child: Padding(
                                            padding: const EdgeInsets.all(5.0),
                                            child: Image.asset(
                                              GetSavePostData?.object?[index]
                                                          .isSaved ==
                                                      false
                                                  ? ImageConstant.savePin
                                                  : ImageConstant.Savefill,
                                              height: 17,
                                            ),
                                          ),
                                        ),
                                      ),
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
            )
          : Center(
              child: Text(
                "No saved posts available.",
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'outfit',
                    fontSize: 20),
              ),
            );
    } else {
      return saveAllBlogModelData?.object?.isNotEmpty ?? true
          ? Padding(
              padding: const EdgeInsets.only(top: 10, right: 10, left: 10),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: List.generate(
                      saveAllBlogModelData?.object?.length ?? 0, (index) {
                    parsedDateTimeBlogs = DateTime.parse(
                        '${saveAllBlogModelData?.object?[index].createdAt ?? ""}');
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => RecentBlogScren(
                                  description1: saveAllBlogModelData
                                          ?.object?[index].description
                                          .toString() ??
                                      "",
                                  title: saveAllBlogModelData
                                          ?.object?[index].title
                                          .toString() ??
                                      "",
                                  imageURL: saveAllBlogModelData
                                          ?.object?[index].image
                                          .toString() ??
                                      "",
                                  ProfileScreenMove: true,
                                  index: index,
                                  saveAllBlogModelData: saveAllBlogModelData),
                            )).then((value) => getAllAPI_Data());
                      },
                      child: Container(
                        margin: EdgeInsets.only(bottom: 10),
                        height: 155,
                        decoration: BoxDecoration(
                            // color: Colors.amber,

                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: Color(0xffF1F1F1))),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 10, top: 10),
                              child: Container(
                                width: 135,
                                height: 135,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: CustomImageView(
                                  url:
                                      "${saveAllBlogModelData?.object?[index].image}",
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width - 187,
                              // color: Colors.blue,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: 15,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 20),
                                    child: Text(
                                      "${saveAllBlogModelData?.object?[index].title}",
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.black),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 20),
                                    child: Text(
                                      "${saveAllBlogModelData?.object?[index].description}",
                                      maxLines: 3,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.grey),
                                    ),
                                  ),
                                  Spacer(),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 20, right: 10, bottom: 10),
                                    child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          Text(
                                            customFormat(parsedDateTimeBlogs!),
                                            style: TextStyle(
                                                fontSize: 9.5,
                                                fontWeight: FontWeight.w400,
                                                color: Colors.grey),
                                          ),
                                          // Text(
                                          //   "10:47 pm",
                                          //   style: TextStyle(
                                          //       fontSize: 9.5,
                                          //       fontWeight: FontWeight.w400,
                                          //       color: Colors.grey),
                                          // ),

                                          Text(
                                            " ",
                                            style: TextStyle(
                                                fontSize: 9.5,
                                                fontWeight: FontWeight.w400,
                                                color: Colors.grey),
                                          ),
                                          Spacer(),
                                          // GestureDetector(
                                          //   onTap: () {
                                          //     print("click on Blog like button");

                                          //     BlocProvider.of<NewProfileSCubit>(
                                          //             context)
                                          //         .ProfileLikeBlog(
                                          //             context,
                                          //             "${User_ID}",
                                          //             "${saveAllBlogModelData?.object?[index].uid}");
                                          //     if (saveAllBlogModelData
                                          //             ?.object?[index].isLiked ==
                                          //         false) {
                                          //       saveAllBlogModelData
                                          //           ?.object?[index].isLiked = true;
                                          //     } else {
                                          //       saveAllBlogModelData?.object?[index]
                                          //           .isLiked = false;
                                          //     }
                                          //   },
                                          //   child: saveAllBlogModelData
                                          //               ?.object?[index].isLiked ==
                                          //           false
                                          //       ? Icon(Icons.favorite_border)
                                          //       : Icon(
                                          //           Icons.favorite,
                                          //           color: Colors.red,
                                          //         ),
                                          // ),
                                          // SizedBox(
                                          //   width: 10,
                                          // ),
                                          // GestureDetector(
                                          //     onTap: () {
                                          //       print("Unsave Button");

                                          //       BlocProvider.of<NewProfileSCubit>(
                                          //               context)
                                          //           .ProfileSaveBlog(
                                          //               context,
                                          //               "${User_ID}",
                                          //               "${saveAllBlogModelData?.object?[index].uid}");

                                          //       if (saveAllBlogModelData
                                          //               ?.object?[index].isSaved ==
                                          //           true) {
                                          //         saveAllBlogModelData?.object
                                          //             ?.removeAt(index);
                                          //         super.setState(() {
                                          //           SaveBlogCount =
                                          //               saveAllBlogModelData
                                          //                       ?.object?.length ??
                                          //                   0;
                                          //         });
                                          //       }
                                          //     },
                                          //     child: Container(
                                          //       height: 25,
                                          //       width: 25,
                                          //       decoration: BoxDecoration(
                                          //           borderRadius:
                                          //               BorderRadius.circular(5),
                                          //           color: Colors.white),
                                          //       child: Center(
                                          //           child: Padding(
                                          //         padding:
                                          //             const EdgeInsets.all(5.0),
                                          //         child: Image.asset(
                                          //           saveAllBlogModelData
                                          //                       ?.object?[index]
                                          //                       .isSaved ==
                                          //                   false
                                          //               ? ImageConstant.savePin
                                          //               : ImageConstant.Savefill,
                                          //           width: 12.5,
                                          //         ),
                                          //       )),
                                          //     )),
                                        ]),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  })),
            )
          : Center(
              child: Text(
                "No saved blogs available.",
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'outfit',
                    fontSize: 20),
              ),
            );
    }
  }

  Widget expertUser(_height, _width) {
    if (User_ID == NewProfileData?.object?.userUid ||
        (NewProfileData?.object?.accountType == 'PUBLIC' &&
            NewProfileData?.object?.approvalStatus != "PENDING" &&
            NewProfileData?.object?.approvalStatus != "REJECTED") ||
        (NewProfileData?.object?.isFollowing == 'FOLLOWING' &&
            NewProfileData?.object?.approvalStatus != "PENDING" &&
            NewProfileData?.object?.approvalStatus != "REJECTED")) {
      return Column(
        children: [
          ListTile(
            /*  leading: Container(
            width: 35,
            height: 35,
            decoration: ShapeDecoration(
              color: ColorConstant.primary_color,
              shape: OvalBorder(),
            ),
          ), */
            title: Text(
              'Work/ Business Details',
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            trailing: GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => EditProfileScreen(
                              newProfileData: NewProfileData,
                            ))).then((value) =>
                    widget.ProfileNotification == true
                        ? BlocProvider.of<NewProfileSCubit>(context)
                            .NewProfileSAPI(context, widget.User_ID, true)
                        : BlocProvider.of<NewProfileSCubit>(context)
                            .NewProfileSAPI(context, widget.User_ID, false));
              },
              child: User_ID == NewProfileData?.object?.userUid
                  ? Icon(
                      Icons.edit,
                      color: Colors.black,
                    )
                  : SizedBox(),
            ),
          ),
          Container(
            height: User_ID == NewProfileData?.object?.userUid
                ? _height / 1.3
                : _height / 1.5,
            width: _width,
            //  color: Colors.amber,
            child: Padding(
              padding: const EdgeInsets.only(left: 16, right: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Job Profile",
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontFamily: 'outfit',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Container(
                    width: _width,
                    child: CustomTextFormField(
                      readOnly: true,
                      controller: jobprofileController,
                      margin: EdgeInsets.only(
                        top: 10,
                      ),

                      validator: (value) {
                        RegExp nameRegExp = RegExp(r"^[a-zA-Z0-9\s'@]+$");
                        if (value!.isEmpty) {
                          return 'Please Enter Name';
                        } else if (!nameRegExp.hasMatch(value)) {
                          return 'Input cannot contains prohibited special characters';
                        } else if (value.length <= 0 || value.length > 50) {
                          return 'Minimum length required';
                        } else if (value.contains('..')) {
                          return 'username does not contain is correct';
                        }

                        return null;
                      },
                      // textStyle: theme.textTheme.titleMedium!,
                      hintText: "Job Profile",
                      // hintStyle: theme.textTheme.titleMedium!,
                      textInputAction: TextInputAction.next,
                      filled: true,
                      maxLength: 100,
                      fillColor: appTheme.gray100,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Industry Type",
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontFamily: 'outfit',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Container(
                    width: _width,
                    child: CustomTextFormField(
                      readOnly: true, maxLines: 4,
                      controller: IndustryType,
                      margin: EdgeInsets.only(
                        top: 10,
                      ),

                      validator: (value) {
                        RegExp nameRegExp = RegExp(r"^[a-zA-Z0-9\s'@]+$");
                        if (value!.isEmpty) {
                          return 'Please Enter Name';
                        } else if (!nameRegExp.hasMatch(value)) {
                          return 'Input cannot contains prohibited special characters';
                        } else if (value.length <= 0 || value.length > 50) {
                          return 'Minimum length required';
                        } else if (value.contains('..')) {
                          return 'username does not contain is correct';
                        }

                        return null;
                      },
                      // textStyle: theme.textTheme.titleMedium!,
                      hintText: "Industry Type",
                      textStyle: TextStyle(
                          fontWeight: FontWeight.w400,
                          wordSpacing: 1,
                          letterSpacing: 1,
                          fontFamily: 'outfit'),
                      // hintStyle: theme.textTheme.titleMedium!,
                      textInputAction: TextInputAction.next,
                      filled: true,
                      maxLength: 100,
                      fillColor: appTheme.gray100,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Expertise in",
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontFamily: 'outfit',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Container(
                    width: _width,
                    child: CustomTextFormField(
                      readOnly: true,
                      controller: Expertise,
                      margin: EdgeInsets.only(
                        top: 10,
                      ),

                      validator: (value) {
                        RegExp nameRegExp = RegExp(r"^[a-zA-Z0-9\s'@]+$");
                        if (value!.isEmpty) {
                          return 'Please Enter Name';
                        } else if (!nameRegExp.hasMatch(value)) {
                          return 'Input cannot contains prohibited special characters';
                        } else if (value.length <= 0 || value.length > 50) {
                          return 'Minimum length required';
                        } else if (value.contains('..')) {
                          return 'username does not contain is correct';
                        }

                        return null;
                      },
                      // textStyle: theme.textTheme.titleMedium!,
                      hintText: "Expertise in",
                      // hintStyle: theme.textTheme.titleMedium!,
                      textInputAction: TextInputAction.next,
                      filled: true,
                      maxLength: 100,
                      fillColor: appTheme.gray100,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  if (NewProfileData?.object?.module == "EXPERT")
                    //ss
                    Text(
                      "Fees",
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontFamily: 'outfit',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  NewProfileData?.object?.module == "EXPERT"
                      ? NewProfileData?.object?.fees == null
                          ? Container(
                              width: _width,
                              child: CustomTextFormField(
                                readOnly: true,
                                margin: EdgeInsets.only(
                                  top: 10,
                                ),

                                // textStyle: theme.textTheme.titleMedium!,
                                hintText: "Price / hr",
                                // hintStyle: theme.textTheme.titleMedium!,
                                textInputAction: TextInputAction.next,
                                filled: true,
                                maxLength: 100,
                                fillColor: appTheme.gray100,
                              ),
                            )
                          : Container(
                              width: _width,
                              child: CustomTextFormField(
                                readOnly: true,
                                controller: priceContrller,
                                margin: EdgeInsets.only(
                                  top: 10,
                                ),

                                validator: (value) {
                                  RegExp nameRegExp =
                                      RegExp(r"^[a-zA-Z0-9\s'@]+$");
                                  if (value!.isEmpty) {
                                    return 'Please Enter Name';
                                  } else if (!nameRegExp.hasMatch(value)) {
                                    return 'Input cannot contains prohibited special characters';
                                  } else if (value.length <= 0 ||
                                      value.length > 50) {
                                    return 'Minimum length required';
                                  } else if (value.contains('..')) {
                                    return 'username does not contain is correct';
                                  }

                                  return null;
                                },
                                // textStyle: theme.textTheme.titleMedium!,
                                hintText: "Price / hr",
                                // hintStyle: theme.textTheme.titleMedium!,
                                textInputAction: TextInputAction.next,
                                filled: true,
                                maxLength: 100,
                                fillColor: appTheme.gray100,
                              ),
                            )
                      : SizedBox(),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Working Hours",
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontFamily: 'outfit',
                      fontWeight: FontWeight.w500,
                    ),
                    // style: theme.textTheme.bodyLarge,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        GestureDetector(
                          onTap: () {
                            if (isDataSet == false) {
                              _selectStartTime(context);
                            }
                          },
                          child: Container(
                            height: 40,
                            width: 130,
                            decoration: BoxDecoration(
                                color: Color(0xffF6F6F6),
                                borderRadius: BorderRadius.circular(10)),
                            child: Row(
                              children: [
                                Padding(
                                    padding: EdgeInsets.only(left: 20),
                                    child: Text(
                                      start != null
                                          ? start.toString()
                                          : '00:00',
                                      style: TextStyle(
                                          fontSize: 15,
                                          color: Color(0xff989898)),
                                    )),
                                SizedBox(
                                  width: 7,
                                ),
                                VerticalDivider(
                                  thickness: 2,
                                  color: Color(0xff989898),
                                ),
                                Text(
                                    startAm != null ? startAm.toString() : 'AM',
                                    style: TextStyle(
                                        fontSize: 15,
                                        color: Color(0xff989898))),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          'TO',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontFamily: "outfit",
                            fontWeight: FontWeight.bold,
                            height: 0,
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        GestureDetector(
                          onTap: () {
                            if (isDataSet == false) {
                              _selectStartTime(context);
                            }
                          },
                          child: Container(
                            height: 40,
                            width: 130,
                            decoration: BoxDecoration(
                                color: Color(0xffF6F6F6),
                                borderRadius: BorderRadius.circular(10)),
                            child: Row(
                              children: [
                                Padding(
                                    padding: EdgeInsets.only(left: 20),
                                    child: Text(
                                      end != null ? end.toString() : "00:00",
                                      style: TextStyle(
                                          fontSize: 15,
                                          color: Color(0xff989898)),
                                    )),
                                SizedBox(
                                  width: 7,
                                ),
                                VerticalDivider(
                                  thickness: 2,
                                  color: Color(0xff989898),
                                ),
                                Text(endAm != null ? endAm.toString() : "PM",
                                    style: TextStyle(
                                        fontSize: 15,
                                        color: Color(0xff989898))),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  if (User_ID == NewProfileData?.object?.userUid)
                    Text(
                      "Document",
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontFamily: 'outfit',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  if (User_ID == NewProfileData?.object?.userUid)
                    Row(
                      children: [
                        Container(
                            height: 50,
                            width: _width - 175,
                            decoration: BoxDecoration(
                                color: Color(0XFFF6F6F6),
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(5),
                                    bottomLeft: Radius.circular(5))),
                            child: Padding(
                              padding: const EdgeInsets.only(top: 15, left: 20),
                              child: Text(
                                '${NewProfileData?.object?.documentName}',
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(fontSize: 16),
                              ),
                            )),
                        dopcument == "Upload Image"
                            ? GestureDetector(
                                onTap: () async {
                                  filepath = await prepareTestPdf(0);
                                },
                                child: Container(
                                  height: 50,
                                  width: _width / 4.5,
                                  decoration: BoxDecoration(
                                      color: Color(0XFF777777),
                                      borderRadius: BorderRadius.only(
                                          topRight: Radius.circular(5),
                                          bottomRight: Radius.circular(5))),
                                  child: Center(
                                    child: Text(
                                      "Choose",
                                      style: TextStyle(
                                        fontFamily: 'outfit',
                                        fontSize: 15,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            : Container(
                                height: 50,
                                width: _width / 4.5,
                                decoration: BoxDecoration(
                                    color: Color.fromARGB(255, 228, 228, 228),
                                    borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(5),
                                        bottomRight: Radius.circular(5))),
                                child: GestureDetector(
                                  onTap: () async {
                                    if (dopcument != null) {
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  DocumentViewScreen(
                                                    path: NewProfileData
                                                        ?.object?.userDocument,
                                                    title: 'Pdf',
                                                  )));
                                    }
                                  },
                                  child: Center(
                                    child: Text(
                                      "Open",
                                      style: TextStyle(
                                        fontFamily: 'outfit',
                                        fontSize: 15,
                                        color: ColorConstant.primary_color,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ), /* Icon(
                                  Icons.delete_forever,
                                  color: ColorConstant.primary_color,
                                ) */
                                ),
                              ),
                      ],
                    ),
                ],
              ),
            ),
          ),
        ],
      );
    } else {
      return SizedBox();
    }
  }

  Widget experience(_height, _width) {
    if (User_ID == NewProfileData?.object?.userUid ||
        (NewProfileData?.object?.accountType == 'PUBLIC' &&
            NewProfileData?.object?.approvalStatus != "PENDING" &&
            NewProfileData?.object?.approvalStatus != "REJECTED") ||
        (NewProfileData?.object?.isFollowing == 'FOLLOWING' &&
            NewProfileData?.object?.approvalStatus != "PENDING" &&
            NewProfileData?.object?.approvalStatus != "REJECTED")) {
      return Column(
        children: [
          ListTile(
              title: Text(
                'Experience',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  (addWorkExperienceModel?.object?.isEmpty ?? false)
                      ? SizedBox()
                      : GestureDetector(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(
                              builder: (context) {
                                return ExperienceEditScreen(
                                  userID: widget.User_ID,
                                  typeName: NewProfileData?.object?.module,
                                );
                              },
                            )).then((value) =>
                                BlocProvider.of<NewProfileSCubit>(context)
                                    .GetWorkExperienceAPI(
                                        context, widget.User_ID));
                          },
                          child: User_ID == NewProfileData?.object?.userUid &&
                                  NewProfileData?.object?.approvalStatus !=
                                      "PENDING" &&
                                  NewProfileData?.object?.approvalStatus !=
                                      "REJECTED"
                              ? Icon(
                                  Icons.edit,
                                  color: Colors.black,
                                )
                              : SizedBox(),
                        ),
                  SizedBox(
                    width: 10,
                  ),
                  GestureDetector(
                    onTap: () {
                      print(
                          "modulemodule == ${NewProfileData?.object?.module}");
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) {
                          return AddWorkExperienceScreen(
                              typeName: NewProfileData?.object?.module,
                              userID: widget.User_ID);
                        },
                      )).then((value) =>
                          BlocProvider.of<NewProfileSCubit>(context)
                              .GetWorkExperienceAPI(context, widget.User_ID));
                    },
                    child: User_ID == NewProfileData?.object?.userUid
                        ? Icon(
                            Icons.add,
                            color: Colors.black,
                            size: 25,
                          )
                        : SizedBox(),
                  )
                ],
              )),
          ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            padding: EdgeInsets.only(top: 10),
            itemCount: addWorkExperienceModel?.object?.length,
            itemBuilder: (context, index) {
              // print(
              //     "StatDate-${addWorkExperienceModel?.object?[index].startDate}");
              // print(
              //     "endData-${addWorkExperienceModel?.object?[index].endDate}");

              formattedDateStart = DateFormat('dd-MM-yyyy').format(
                  DateFormat('yyyy-MM-dd').parse(
                      addWorkExperienceModel?.object?[index].startDate ??
                          DateTime.now().toIso8601String()));
              if (addWorkExperienceModel?.object?[index].endDate != 'Present') {
                // print(
                //     "this is the Data Get-${addWorkExperienceModel?.object?[index].endDate}");
                formattedDateEnd = DateFormat('dd-MM-yyyy').format(
                    DateFormat('yyyy-MM-dd').parse(
                        addWorkExperienceModel?.object?[index].endDate ??
                            DateTime.now().toIso8601String()));
              }
              return ListTile(
                titleAlignment: ListTileTitleAlignment.top,
                leading: addWorkExperienceModel
                                ?.object?[index].userProfilePic !=
                            null &&
                        addWorkExperienceModel?.object?[index].userProfilePic !=
                            ''
                    ? CircleAvatar(
                        backgroundColor: Colors.white,
                        backgroundImage: NetworkImage(addWorkExperienceModel
                                ?.object?[index].userProfilePic ??
                            ''),
                      )
                    : CustomImageView(
                        imagePath: ImageConstant.tomcruse,
                        height: 32,
                        width: 32,
                        fit: BoxFit.fill,
                        radius: BorderRadius.circular(25),
                      ),
                title: Text(
                  '${addWorkExperienceModel?.object?[index].companyName}',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      '${addWorkExperienceModel?.object?[index].jobProfile}',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 12,
                      ),
                    ),
                    NewProfileData?.object?.module == "EXPERT"
                        ? Text(
                            '${addWorkExperienceModel?.object?[index].expertiseIn}',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 12,
                            ),
                          )
                        : SizedBox(),
                    Text(
                      '${addWorkExperienceModel?.object?[index].industryType}',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 12,
                      ),
                    ),
                    /* addWorkExperienceModel?.object?[index].startDate !=
                              null &&
                          addWorkExperienceModel?.object?[index].endDate !=
                              null
                      ? */
                    /* DateFormat('dd-MM-yyyy').format(DateTime.now()) ==
                          formattedDateEnd */
                    addWorkExperienceModel?.object?[index].endDate == "Present"
                        ? Text(
                            '${formattedDateStart} to Present',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 13,
                            ),
                          )
                        : Text(
                            '${formattedDateStart} to ${formattedDateEnd}',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 13,
                            ),
                          )
                    /* : SizedBox(), */
                  ],
                ),
              );
            },
          ),
          SizedBox(
            height: 10,
          )
        ],
      );
    } else {
      return SizedBox();
    }
  }

  Widget compnayUser(_height, _width) {
    /*  if (User_ID == NewProfileData?.object?.userUid ||
        (NewProfileData?.object?.isFollowing == 'FOLLOWING' &&
            NewProfileData?.object?.accountType == 'PRIVATE' &&
            NewProfileData?.object?.approvalStatus != "PENDING" &&
            NewProfileData?.object?.approvalStatus != "REJECTED")) */
    if (User_ID == NewProfileData?.object?.userUid ||
        (NewProfileData?.object?.accountType == 'PUBLIC' &&
            NewProfileData?.object?.approvalStatus != "PENDING" &&
            NewProfileData?.object?.approvalStatus != "REJECTED") ||
        (NewProfileData?.object?.isFollowing == 'FOLLOWING' &&
            NewProfileData?.object?.approvalStatus != "PENDING" &&
            NewProfileData?.object?.approvalStatus != "REJECTED")) {
      return Column(
        children: [
          ListTile(
            /* leading: Container(
            width: 35,
            height: 35,
            decoration: ShapeDecoration(
              color: ColorConstant.primary_color,
              shape: OvalBorder(),
            ),
          ), */
            title: Text(
              'Work/ Business Details',
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            trailing: GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => EditProfileScreen(
                              newProfileData: NewProfileData,
                            ))).then((value) =>
                    widget.ProfileNotification == true
                        ? BlocProvider.of<NewProfileSCubit>(context)
                            .NewProfileSAPI(context, widget.User_ID, true)
                        : BlocProvider.of<NewProfileSCubit>(context)
                            .NewProfileSAPI(context, widget.User_ID, false));
              },
              child: User_ID == NewProfileData?.object?.userUid &&
                      NewProfileData?.object?.approvalStatus != "PENDING"
                  ? Icon(
                      Icons.edit,
                      color: Colors.black,
                    )
                  : SizedBox(),
            ),
          ),
          Container(
            // color: Colors.amber,
            height: User_ID == NewProfileData?.object?.userUid
                ? _height / 1.9
                : 400,
            width: _width,
            child: Padding(
              padding: const EdgeInsets.only(right: 16, left: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Company Name",
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontFamily: 'outfit',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Container(
                    width: _width,
                    child: CustomTextFormField(
                      controller: CompanyName,
                      readOnly: true,
                      margin: EdgeInsets.only(
                        top: 10,
                      ),

                      validator: (value) {
                        RegExp nameRegExp = RegExp(r"^[a-zA-Z0-9\s'@]+$");
                        if (value!.isEmpty) {
                          return 'Please Enter Name';
                        } else if (!nameRegExp.hasMatch(value)) {
                          return 'Input cannot contains prohibited special characters';
                        } else if (value.length <= 0 || value.length > 50) {
                          return 'Minimum length required';
                        } else if (value.contains('..')) {
                          return 'username does not contain is correct';
                        }

                        return null;
                      },
                      // textStyle: theme.textTheme.titleMedium!,

                      hintText: "Company Name",
                      // hintStyle: theme.textTheme.titleMedium!,
                      textInputAction: TextInputAction.next,
                      filled: true,
                      maxLength: 100,
                      fillColor: appTheme.gray100,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Job Profile",
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontFamily: 'outfit',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Container(
                    width: _width,
                    child: CustomTextFormField(
                      readOnly: true,
                      controller: jobprofileController,
                      margin: EdgeInsets.only(
                        top: 10,
                      ),

                      validator: (value) {
                        RegExp nameRegExp = RegExp(r"^[a-zA-Z0-9\s'@]+$");
                        if (value!.isEmpty) {
                          return 'Please Enter Name';
                        } else if (!nameRegExp.hasMatch(value)) {
                          return 'Input cannot contains prohibited special characters';
                        } else if (value.length <= 0 || value.length > 50) {
                          return 'Minimum length required';
                        } else if (value.contains('..')) {
                          return 'username does not contain is correct';
                        }

                        return null;
                      },
                      // textStyle: theme.textTheme.titleMedium!,
                      hintText: "Job profile",
                      // hintStyle: theme.textTheme.titleMedium!,
                      textInputAction: TextInputAction.next,
                      filled: true,
                      maxLength: 100,
                      fillColor: appTheme.gray100,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Industry Type",
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontFamily: 'outfit',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Container(
                    width: _width,
                    child: CustomTextFormField(
                      readOnly: true, maxLines: 4,
                      controller: IndustryType,
                      textStyle: TextStyle(
                          fontWeight: FontWeight.w400,
                          wordSpacing: 1,
                          letterSpacing: 1,
                          fontFamily: 'outfit'),
                      margin: EdgeInsets.only(
                        top: 10,
                      ),

                      validator: (value) {
                        RegExp nameRegExp = RegExp(r"^[a-zA-Z0-9\s'@]+$");
                        if (value!.isEmpty) {
                          return 'Please Enter Name';
                        } else if (!nameRegExp.hasMatch(value)) {
                          return 'Input cannot contains prohibited special characters';
                        } else if (value.length <= 0 || value.length > 50) {
                          return 'Minimum length required';
                        } else if (value.contains('..')) {
                          return 'username does not contain is correct';
                        }

                        return null;
                      },
                      // textStyle: theme.textTheme.titleMedium!,
                      hintText: "Industry Type",
                      // hintStyle: theme.textTheme.titleMedium!,
                      textInputAction: TextInputAction.next,
                      filled: true,
                      maxLength: 100,
                      fillColor: appTheme.gray100,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  if (User_ID == NewProfileData?.object?.userUid)
                    Text(
                      "Document",
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontFamily: 'outfit',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  if (User_ID == NewProfileData?.object?.userUid)
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                              height: 50,
                              // width: _width - 175,
                              decoration: BoxDecoration(
                                  color: Color(0XFFF6F6F6),
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(5),
                                      bottomLeft: Radius.circular(5))),
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(top: 15, left: 10),
                                child: Text(
                                  '${dopcument.toString().split('/').last}',
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(fontSize: 16),
                                ),
                              )),
                        ),
                        dopcument == "Upload Image"
                            ? GestureDetector(
                                onTap: () async {
                                  print(
                                      'dopcument.toString()--${dopcument.toString()}');
                                  filepath = await prepareTestPdf(0);
                                },
                                child: Container(
                                  height: 50,
                                  // width: _width / 4.5,
                                  decoration: BoxDecoration(
                                      color: Color(0XFF777777),
                                      borderRadius: BorderRadius.only(
                                          topRight: Radius.circular(5),
                                          bottomRight: Radius.circular(5))),
                                  child: Center(
                                    child: Text(
                                      "Choose",
                                      style: TextStyle(
                                        fontFamily: 'outfit',
                                        fontSize: 15,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            : GestureDetector(
                                onTap: () async {
                                  // dopcument = "Upload Image";

                                  // super.setState(() {});
                                  print("dfsdfgsdfgdfg-${dopcument}");
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => DocumentViewScreen1(
                                            path: NewProfileData
                                                ?.object?.userDocument,
                                            title: 'Pdf',
                                          )));
                                },
                                child: Container(
                                  height: 50,
                                  width: _width / 4.5,
                                  decoration: BoxDecoration(
                                      color: Color.fromARGB(255, 228, 228, 228),
                                      borderRadius: BorderRadius.only(
                                          topRight: Radius.circular(5),
                                          bottomRight: Radius.circular(5))),
                                  child: Center(
                                    child: Text(
                                      "Open",
                                      style: TextStyle(
                                        fontFamily: 'outfit',
                                        fontSize: 15,
                                        color: ColorConstant.primary_color,
                                        fontWeight: FontWeight.w500,
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
        ],
      );
    } else {
      return SizedBox();
    }
  }

  Future<void> _selectStartTime(BuildContext context) async {
    super.setState(() {
      isDataSet = true;
    });
    TimeOfDay initialTime = TimeOfDay(hour: 0, minute: 0);

    final pickedTime = await showTimePicker(
      context: context,
      initialTime: initialTime,
    );

    String? time = pickedTime?.format(context);
    if (time?.isNotEmpty ?? false) {
      start = time?.split(' ')[0];
      startAm = time?.split(' ')[1];
    } else {
      workignStart =
          NewProfileData?.object?.workingHours.toString().split(" to ").first;

      start = workignStart?.split(' ')[0];
      startAm = workignStart?.split(' ')[1];
    }

    if (pickedTime != null && pickedTime != _startTime) {
      super.setState(() {
        _startTime = pickedTime;
      });
    }
  }

  Future<void> _selectEndTime(BuildContext context) async {
    super.setState(() {
      isDataSet = true;
    });
    TimeOfDay initialTime = TimeOfDay(hour: 0, minute: 0);

    final pickedTime = await showTimePicker(
      context: context,
      initialTime: initialTime,
    );

    String? time = pickedTime?.format(context);
    if (time?.isNotEmpty ?? false) {
      end = time?.split(' ')[0];
      endAm = time?.split(' ')[1];
    } else {
      workignend =
          NewProfileData?.object?.workingHours.toString().split(" to ").last;
      end = workignend?.split(' ')[0];
      endAm = workignend?.split(' ')[1];
    }

    if (pickedTime != null && pickedTime != _endTime) {
      super.setState(() {
        _endTime = pickedTime;
      });
    }
  }

  void showPopupMenu(BuildContext context, int index, buttonKey,
      GetAppUserPostModel? getAllPostData) {
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
    getAllPostData?.object?[index].description == null ||
            getAllPostData?.object?[index].description == ""
        ? showMenu(
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
                        color: ColorConstant.primary_color,
                        borderRadius: BorderRadius.circular(5)),
                  ),
                ),
              ]).then((value) {
            if (value == 'delete') {
              showDeleteConfirmationDialog(context, getAllPostData, index);
            }
          })
        : showMenu(
            context: context,
            position: position,
            items: <PopupMenuItem<String>>[
                PopupMenuItem<String>(
                  value: 'edit',
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CreateNewPost(
                              PostID: getAllPostData?.object?[index].postUid,
                              edittextdata:
                                  getAllPostData?.object?[index].description,
                              mutliplePost:
                                  getAllPostData?.object?[index].postData,
                              getAllPostData: getAllPostData,
                              date: getAllPostData
                                  ?.object?[index].repostOn?.createdAt,
                              desc: getAllPostData
                                  ?.object?[index].repostOn?.description,
                              postData: getAllPostData
                                  ?.object?[index].repostOn?.postData,
                              postDataTypeRepost: getAllPostData
                                  ?.object?[index].repostOn?.postDataType,
                              userProfile:
                                  getAllPostData?.object?[index].userProfilePic,
                              username: getAllPostData
                                  ?.object?[index].repostOn?.postUserName,
                              thumbNailURL: getAllPostData
                                  ?.object?[index].repostOn?.thumbnailImageUrl,
                              postDataType:
                                  getAllPostData?.object?[index].postDataType,
                            ),
                          ));
                      /*  print(getAllPostData?.object?[index].description);
                  if (getAllPostData?.object?[index].postType == "IMAGE" &&
                      getAllPostData?.object?[index].postData?.length == 1) {
                    print("sdfgsdvfsdfgsdfg");
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CreateNewPost(
                            PostID: getAllPostData?.object?[index].postUid,
                            edittextdata:
                                getAllPostData?.object?[index].description,
                            // editImage:
                            //     getAllPostData?.object?[index].postData?.first,
                          ),
                        )).then((value) {
                      if (widget.Screen?.isNotEmpty == true) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  NewBottomBar(buttomIndex: 0),
                            ));
                      } else {
                        Navigator.pop(context);
                      }
                      BlocProvider.of<NewProfileSCubit>(context).GetAppPostAPI(
                          context, "${NewProfileData?.object?.userUid}");
                    });
                  } else if (getAllPostData?.object?[index].postDataType ==
                      "IMAGE") {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CreateNewPost(
                            PostID: getAllPostData?.object?[index].postUid,
                            edittextdata:
                                getAllPostData?.object?[index].description,
                            mutliplePost:
                                getAllPostData?.object?[index].postData,
                          ),
                        )).then((value) {
                      if (widget.Screen?.isNotEmpty == true) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  NewBottomBar(buttomIndex: 0),
                            ));
                      } else {
                        Navigator.pop(context);
                      }
                      BlocProvider.of<NewProfileSCubit>(context).GetAppPostAPI(
                          context, "${NewProfileData?.object?.userUid}");
                    });
                  } else {
                    print(
                        "dfhsdfhsdfhsdfh-${getAllPostData?.object?[index].postData?.length}");
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CreateNewPost(
                            PostID: getAllPostData?.object?[index].postUid,
                            edittextdata:
                                getAllPostData?.object?[index].description,
                          ),
                        )).then((value) {
                      if (widget.Screen?.isNotEmpty == true) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  NewBottomBar(buttomIndex: 0),
                            ));
                      } else {
                        Navigator.pop(context);
                      }
                      BlocProvider.of<NewProfileSCubit>(context).GetAppPostAPI(
                          context, "${NewProfileData?.object?.userUid}");
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
              ]).then((value) {
            if (value == 'delete') {
              showDeleteConfirmationDialog(context, getAllPostData, index);
            }
          });
  }

  void showDeleteConfirmationDialog(
      BuildContext context, GetAppUserPostModel? getAllPostData, int index) {
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
                      onTap: () {
                        print(
                            "--------------------------------------------------${NewProfileData?.object?.userUid}");

                        super.setState(() {});
                        BlocProvider.of<NewProfileSCubit>(context).DeletePost(
                            '${getAllPostData?.object?[index].postUid}',
                            context);
                        getAllPostData?.object?.removeAt(index);
                        // Navigator.of(context).pop();
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

  prepareTestPdf(
    int Index,
  ) async {
    PlatformFile file;

    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf', 'png', 'doc', 'jpg'],
    );
    {
      if (result != null) {
        file = result.files.first;

        if ((file.path?.contains(".mp4") ?? false) ||
            (file.path?.contains(".mov") ?? false) ||
            (file.path?.contains(".mp3") ?? false) ||
            (file.path?.contains(".m4a") ?? false)) {
          showDialog(
            context: context,
            builder: (ctx) => AlertDialog(
              title: Text(
                "Selected File Error",
                textScaleFactor: 1.0,
              ),
              content: Text(
                "Only PDF, PNG, JPG Supported.",
                textScaleFactor: 1.0,
              ),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(ctx).pop();
                  },
                  child: Container(
                    // color: Colors.green,
                    padding: const EdgeInsets.all(10),
                    child: const Text("Okay"),
                  ),
                ),
              ],
            ),
          );
        } else {
          getFileSize(
            file.path!,
            1,
            result.files.first,
            Index,
          );
        }
      } else {}
    }
    return "";
    // "${fileparth}";
  }

  getFileSize(
    String filepath,
    int decimals,
    PlatformFile file1,
    int Index,
  ) async {
    var file = File(filepath);
    int bytes = await file.length();
    if (bytes <= 0) return "0 B";
    const suffixes = ["B", "KB", "MB", "GB", "TB", "PB", "EB", "ZB", "YB"];
    var i = (log(bytes) / log(1024)).floor();
    var STR = ((bytes / pow(1024, i)).toStringAsFixed(decimals));
    print('getFileSizevariable-${file1.path}');
    value2 = double.parse(STR);
/* 
    print("value2-->$value2"); */
    switch (i) {
      case 0:
        print("Done file size B");
        switch (Index) {
          case 1:
            if (file1.name.isNotEmpty || file1.name.toString() == null) {
              super.setState(() {
                uplopdfile.text = file1.name;
                dopcument = file1.name;
              });
            }

            break;
          default:
        }
        print('xfjsdjfjfilenamecheckKB-${file1.path}');

        break;
      case 1:
        print("Done file size KB");
        switch (Index) {
          case 0:
            print("file1.name-->${file1.name}");
            if (file1.name.isNotEmpty || file1.name.toString() == null) {
              super.setState(() {
                uplopdfile.text = file1.name;
                dopcument = file1.name;
              });
            }
            print('filenamecheckdocmenut-${dopcument}');

            break;
          default:
        }
        print('filenamecheckKB-${file1.path}');
        /* BlocProvider.of<FetchExprtiseRoomCubit>(context)
            .chooseDocumentprofile(dopcument.toString(), file1.path!, context); */
        super.setState(() {});

        break;
      case 2:
        if (value2 > 10) {
          showDialog(
            context: context,
            builder: (ctx) => AlertDialog(
              title: Text("Max Size ${10}MB"),
              content: Text(
                  "This file size ${value2} ${suffixes[i]} Selected Max size ${10}MB"),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(ctx).pop();
                  },
                  child: Container(
                    // color: Colors.green,
                    padding: const EdgeInsets.all(10),
                    child: const Text("Okay"),
                  ),
                ),
              ],
            ),
          );
        } else {
          print("Done file Size 12MB");
          print("file1.namedata-->${file1.name}");
          switch (Index) {
            case 1:
              super.setState(() {
                uplopdfile.text = file1.name;
                dopcument = file1.name;
              });
              print("DOCUMENT IN MB ---->$dopcument");
              break;
            default:
          }
          print('filecheckPath1-${file1.name}');
          super.setState(() {
            uplopdfile.text = file1.name;
            dopcument = file1.name;
          });
          /* BlocProvider.of<FetchExprtiseRoomCubit>(context)
              .chooseDocumentprofile(
                  dopcument.toString(), file1.path!, context); */
        }

        break;
      default:
    }

    return STR;
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

  void showPopupMenuBlock(
      BuildContext context, String? userID, String? userName, buttonKey) async {
    final RenderBox button =
        buttonKey.currentContext!.findRenderObject() as RenderBox;
    final RenderBox overlay =
        Overlay.of(context).context.findRenderObject() as RenderBox;

    /*  final RelativeRect position = RelativeRect.fromRect(
      Rect.fromPoints(
        button.localToGlobal(Offset.zero, ancestor: overlay),
        button.localToGlobal(button.size.bottomLeft(Offset.zero),
            ancestor: overlay),
      ),
      Offset.zero & overlay.size,
    ); */
    final double top = button.localToGlobal(Offset.zero, ancestor: overlay).dy;
    final double left = button.localToGlobal(Offset.zero, ancestor: overlay).dx;

    final RelativeRect position = RelativeRect.fromLTRB(
      left, // left
      top + button.size.height, // top
      left + button.size.width, // right
      top + button.size.height, // bottom
    );

    await showMenu(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      constraints: BoxConstraints(maxWidth: 180),
      context: context,
      position: position,
      items: <PopupMenuItem<String>>[
        PopupMenuItem<String>(
          onTap: () {
            if (widget.Screen?.isNotEmpty == true) {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => NewBottomBar(buttomIndex: 0),
                  ));
            } else {
              Navigator.pop(context);
            }
            showDialog(
              context: context,
              builder: (_) => BlockUserdailog(
                  blockUserID: userID,
                  userName: userName,
                  Blockuser: Blockuser),
            ).then((value) => widget.ProfileNotification == true
                ? BlocProvider.of<NewProfileSCubit>(context)
                    .NewProfileSAPI(context, widget.User_ID, true)
                : BlocProvider.of<NewProfileSCubit>(context)
                    .NewProfileSAPI(context, widget.User_ID, false));
          },
          height: 25,
          value: Blockuser == true ? 'Block' : 'UnBlock',
          child: GestureDetector(
            onTap: () {
              if (widget.Screen?.isNotEmpty == true) {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => NewBottomBar(buttomIndex: 0),
                    ));
              } else {
                Navigator.pop(context);
              }
              showDialog(
                context: context,
                builder: (_) => BlockUserdailog(
                    blockUserID: userID,
                    userName: userName,
                    Blockuser: Blockuser),
              ).then((value) => widget.ProfileNotification == true
                  ? BlocProvider.of<NewProfileSCubit>(context)
                      .NewProfileSAPI(context, widget.User_ID, true)
                  : BlocProvider.of<NewProfileSCubit>(context)
                      .NewProfileSAPI(context, widget.User_ID, false));
            },
            child: Container(
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Image.asset(
                      ImageConstant.block_icon,
                      height: 16,
                      width: 16,
                      color: Colors.black,
                    ),
                    Text(
                      Blockuser == true ? 'Block' : 'UnBlock',
                      style: TextStyle(color: Colors.black, fontSize: 16),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
