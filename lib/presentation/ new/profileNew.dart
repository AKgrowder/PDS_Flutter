// ignore_for_file: must_be_immutable

import 'dart:io';
import 'dart:math';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:pds/API/Bloc/NewProfileScreen_Bloc/NewProfileScreen_cubit.dart';
import 'package:pds/API/Bloc/NewProfileScreen_Bloc/NewProfileScreen_state.dart';
import 'package:pds/API/Bloc/my_account_Bloc/my_account_cubit.dart';
import 'package:pds/API/Model/FollwersModel/FllowersModel.dart';
import 'package:pds/API/Model/NewProfileScreenModel/GetAppUserPost_Model.dart';
import 'package:pds/API/Model/NewProfileScreenModel/GetSavePost_Model.dart';
import 'package:pds/API/Model/NewProfileScreenModel/GetUserPostCommet_Model.dart';
import 'package:pds/API/Model/NewProfileScreenModel/NewProfileScreen_Model.dart';
import 'package:pds/API/Model/saveAllBlogModel/saveAllBlog_Model.dart';
import 'package:pds/core/app_export.dart';
import 'package:pds/core/utils/color_constant.dart';
import 'package:pds/core/utils/sharedPreferences.dart';
import 'package:pds/presentation/%20new/OpenSavePostImage.dart';
import 'package:pds/presentation/%20new/editproilescreen.dart';
import 'package:pds/presentation/%20new/followers.dart';
import 'package:pds/presentation/recent_blog/recent_blog_screen.dart';
import 'package:pds/presentation/settings/setting_screen.dart';
import 'package:pds/widgets/commentPdf.dart';
import 'package:pds/widgets/custom_text_form_field.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatefulWidget {
  String User_ID;
  String? isFollowing;

  ProfileScreen({
    required this.User_ID,
    required this.isFollowing,
  });

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
    with SingleTickerProviderStateMixin {
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

  String? workignStart;
  String? workignend;
  String? start;
  String? startAm;
  String? end;
  String? endAm;
  TabController? _tabController;
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
  dynamic dataSetup;
  String? User_Module;
  FollowersClassModel? followersClassModel1;
  FollowersClassModel? followersClassModel2;
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
    setState(() {});

    BlocProvider.of<NewProfileSCubit>(context).get_about_me(context, userId);

    BlocProvider.of<NewProfileSCubit>(context).GetAllSaveBlog(context, userId);
  }

  @override
  void initState() {
    _tabController = TabController(length: tabData.length, vsync: this);
    BlocProvider.of<NewProfileSCubit>(context)
        .NewProfileSAPI(context, widget.User_ID);
    BlocProvider.of<NewProfileSCubit>(context)
        .getFollwerApi(context, widget.User_ID);
    BlocProvider.of<NewProfileSCubit>(context)
        .getAllFollwing(context, widget.User_ID);
    getUserSavedData();
    dataSetup = null;
    value1 = 0;

    super.initState();
  }

  getUserSavedData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    User_ID = prefs.getString(PreferencesKey.loginUserID);
    User_Module = prefs.getString(PreferencesKey.module);
  }

  @override
  void dispose() {
    _tabController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var _height = MediaQuery.of(context).size.height;
    var _width = MediaQuery.of(context).size.width;
    return BlocConsumer<NewProfileSCubit, NewProfileSState>(
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
      if (state is NewProfileSLoadedState) {
        NewProfileData = state.PublicRoomData;
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
          print(element.industryTypeName);
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
            ExpertiseData = "${ExpertiseData}${element.expertiseName}";
          } else {
            ExpertiseData = "${ExpertiseData}, ${element.expertiseName}";
          }
        });

        // ExpertiseData

        CompanyName.text = "${NewProfileData?.object?.companyName}";
        jobprofileController.text = "${NewProfileData?.object?.jobProfile}";
        IndustryType.text = industryTypesArray;
        dopcument = NewProfileData?.object?.userDocument;

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
      }
      if (state is GetAppPostByUserLoadedState) {
        print(state.GetAllPost);
        GetAllPostData = state.GetAllPost;
        UserProfilePostCount = GetAllPostData?.object?.length ?? 0;

        if (UserProfilePostCount.isOdd) {
          UserProfilePostCount = UserProfilePostCount + 1;
          var PostCount = UserProfilePostCount / 2;
          print(PostCount);
          var aa = "${PostCount}";
          int? y = int.parse(aa.split('.')[0]);
          FinalPostCount = y;
          UserProfilePostCount = UserProfilePostCount - 1;
        } else {
          print(UserProfilePostCount);
          var PostCount = UserProfilePostCount / 2;
          var aa = "${PostCount}";
          int? y = int.parse(aa.split('.')[0]);
          FinalPostCount = y;
        }
      }
      if (state is GetUserPostCommetLoadedState) {
        print(
            "Get Comment Get Comment Get Comment Get Comment Get Comment Get Comment Get Comment ");
        print(state.GetUserPostCommet);
        GetUserPostCommetData = state.GetUserPostCommet;
        CommentsPostCount = GetUserPostCommetData?.object?.length ?? 0;
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
          content: Text('Saved successfully'),
          backgroundColor: ColorConstant.primary_color,
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
      if (state is PostLikeLoadedState) {
        BlocProvider.of<NewProfileSCubit>(context)
            .NewProfileSAPI(context, widget.User_ID);
        if (state.likePost.object != 'Post Liked Successfully' &&
            state.likePost.object != 'Post Unliked Successfully') {
          SnackBar snackBar = SnackBar(
            content: Text(state.likePost.object.toString()),
            backgroundColor: ColorConstant.primary_color,
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
      }
    }, builder: (context, state) {
      return Scaffold(
          body: isDataGet == false
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
              : DefaultTabController(
                  length: tabData.length,
                  child: SingleChildScrollView(
                      child: Column(
                    children: [
                      Container(
                        height: _height / 2.6,
                        child: Stack(
                          children: [
                            Container(
                              // color: Colors.red,
                              height: _height / 3.4,
                              width: _width,
                              child: NewProfileData?.object?.userBackgroundPic ==
                                          null ||
                                      NewProfileData
                                              ?.object?.userBackgroundPic ==
                                          ''
                                  ? Image.asset(ImageConstant.pdslogo)
                                  : CustomImageView(
                                      url:
                                          "${NewProfileData?.object?.userBackgroundPic}",
                                      fit: BoxFit.cover,
                                      radius: BorderRadius.only(
                                          bottomRight: Radius.circular(20),
                                          bottomLeft: Radius.circular(20))
                                      // BorderRadius.circular(25),
                                      ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 55, left: 16),
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: Container(
                                  height: 30,
                                  width: 30,
                                  color: Color.fromRGBO(255, 255, 255, 0.3),
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
                            ),
                            Align(
                              alignment: Alignment.bottomCenter,
                              child: Container(
                                height: 150,
                                width: 150,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.white),
                                child: Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child:
                                      NewProfileData?.object?.userProfilePic ==
                                                  null ||
                                              NewProfileData?.object
                                                      ?.userProfilePic ==
                                                  ''
                                          ? Image.asset(ImageConstant.pdslogo)
                                          : CircleAvatar(
                                              backgroundImage: NetworkImage(
                                                  "${NewProfileData?.object?.userProfilePic}"),
                                              radius: 25,
                                            ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
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
                                        borderRadius: BorderRadius.circular(20),
                                        color: Color(0xffD5EED5),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            left: 15, right: 15),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Container(
                                                height: 10,
                                                width: 10,
                                                decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: Color(0xff019801),
                                                )),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Text(
                                              "Profile APPROVED",
                                              style: TextStyle(
                                                  color: Color(0xff019801),
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w600),
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
                                            color: NewProfileData?.object
                                                        ?.approvalStatus ==
                                                    "PARTIALLY_REGISTERED"
                                                ? Color(0xffB6D9EC)
                                                : NewProfileData?.object
                                                            ?.approvalStatus ==
                                                        "PENDING"
                                                    ? Color(0xffFFDBA8)
                                                    : NewProfileData?.object
                                                                ?.approvalStatus ==
                                                            "APPROVED"
                                                        ? Color(0xffD5EED5)
                                                        : Color(0xffFFE0E1),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                left: 15, right: 15),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Container(
                                                  height: 10,
                                                  width: 10,
                                                  decoration: BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      color: NewProfileData
                                                                  ?.object
                                                                  ?.approvalStatus ==
                                                              "PARTIALLY_REGISTERED"
                                                          ? Color(0xff1A94D7)
                                                          : NewProfileData
                                                                      ?.object
                                                                      ?.approvalStatus ==
                                                                  "PENDING"
                                                              ? Color(
                                                                  0xffC28432)
                                                              : NewProfileData
                                                                          ?.object
                                                                          ?.approvalStatus ==
                                                                      "APPROVED"
                                                                  ? Color(
                                                                      0xff019801)
                                                                  : Color(
                                                                      0xffFF000B)),
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
                                                          ? Color(0xff1A94D7)
                                                          : NewProfileData
                                                                      ?.object
                                                                      ?.approvalStatus ==
                                                                  "PENDING"
                                                              ? Color(
                                                                  0xffC28432)
                                                              : NewProfileData
                                                                          ?.object
                                                                          ?.approvalStatus ==
                                                                      "APPROVED"
                                                                  ? Color(
                                                                      0xff019801)
                                                                  : Color(
                                                                      0xffFF000B),
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
                              : SizedBox(),
                      Padding(
                        padding: EdgeInsets.only(top: 20),
                        child: Center(
                          child: Text(
                            '${NewProfileData?.object?.name}',
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
                      Center(
                        child: Text(
                          '@${NewProfileData?.object?.userName}',
                          style: TextStyle(
                              fontFamily: "outfit",
                              fontWeight: FontWeight.bold,
                              color: Color(0xff444444)),
                        ),
                      ),
                      /* SizedBox(
                height: 10,
              ),
              Center(
                child: Text(
                  'API mathi nathi avtu',
                  style: TextStyle(
                      fontSize: 16,
                      fontFamily: "outfit",
                      fontWeight: FontWeight.bold,
                      color: Color(0xff444444)),
                ),
              ), */
                      SizedBox(
                        height: 10,
                      ),
                      User_ID == widget.User_ID
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(context,
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
                                          ));
                                    })).then((value) =>
                                        BlocProvider.of<NewProfileSCubit>(
                                                context)
                                            .NewProfileSAPI(
                                                context, widget.User_ID));
                                  },
                                  child: Container(
                                    alignment: Alignment.center,
                                    height: 45,
                                    width: _width / 2.6,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(
                                            color: Color(0xffED1C25))),
                                    child: Text(
                                      'View Profile',
                                      maxLines: 1,
                                      style: TextStyle(
                                          fontFamily: "outfit",
                                          fontSize: 18,
                                          color: Color(0xffED1C25),
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
                                                SettingScreen()));
                                  },
                                  child: Container(
                                    margin: EdgeInsets.only(left: 10),
                                    height: 45,
                                    width: 50,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Color(0XFFED1C25)),
                                    child: Icon(
                                      Icons.settings,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            )
                          : widget.isFollowing == true
                              ? Container(
                                  alignment: Alignment.center,
                                  height: 45,
                                  width: _width / 3,
                                  decoration: BoxDecoration(
                                    color: Color(0xffED1C25),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Text(
                                    'Following',
                                    style: TextStyle(
                                        fontFamily: "outfit",
                                        fontSize: 18,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500),
                                  ),
                                )
                              : GestureDetector(
                                  onTap: () {
                                    BlocProvider.of<NewProfileSCubit>(context)
                                        .followWIngMethod(
                                            NewProfileData?.object?.userUid
                                                .toString(),
                                            context);
                                    // print(${name[0].toUpperCase()}${name.substring(1).toLowerCase()});
                                  },
                                  child: Container(
                                    alignment: Alignment.center,
                                    height: 45,
                                    width: _width / 3,
                                    decoration: BoxDecoration(
                                      color: Color(0xffED1C25),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Text(
                                      '${NewProfileData?.object?.isFollowing?.toString()[0].toUpperCase()}${NewProfileData?.object?.isFollowing?.toString().substring(1).toLowerCase()}',
                                      style: TextStyle(
                                          fontFamily: "outfit",
                                          fontSize: 18,
                                          color: Colors.white,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                ),

                      SizedBox(
                        height: 12,
                      ),
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 15, right: 15),
                          child: Container(
                            height: 80,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  color: Color(0xffD2D2D2),
                                )),
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 20, right: 20),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        updateType();
                                        arrNotiyTypeList[1].isSelected = true;
                                      });
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 20),
                                      child: Container(
                                        child: Column(
                                          children: [
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Text(
                                              '${NewProfileData?.object?.postCount}',
                                              style: TextStyle(
                                                  fontFamily: "outfit",
                                                  fontSize: 25,
                                                  color: Color(0xff000000),
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Text(
                                              'Post',
                                              style: TextStyle(
                                                  fontFamily: "outfit",
                                                  fontSize: 16,
                                                  color: Color(0xff444444),
                                                  fontWeight: FontWeight.w500),
                                            )
                                          ],
                                        ),
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
                                      if (NewProfileData?.object?.isFollowing ==
                                              'FOLLOWING' ||
                                          User_ID ==
                                              NewProfileData?.object?.userUid) {
                                        if (followersClassModel1
                                                ?.object?.isNotEmpty ==
                                            true) {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      Followers(
                                                        // OLLOWERS
                                                        appBarName: 'Followers',
                                                        followersClassModel:
                                                            followersClassModel1!,
                                                        userId: User_ID,
                                                      ))).then((value) =>
                                              BlocProvider.of<NewProfileSCubit>(
                                                      context)
                                                  .NewProfileSAPI(
                                                      context, widget.User_ID));
                                        }
                                      } else {}
                                    },
                                    child: Container(
                                      child: Column(
                                        children: [
                                          SizedBox(
                                            height: 11,
                                          ),
                                          Text(
                                            '${NewProfileData?.object?.followersCount}',
                                            style: TextStyle(
                                                fontFamily: "outfit",
                                                fontSize: 25,
                                                color: Color(0xff000000),
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text(
                                            'Followers',
                                            style: TextStyle(
                                                fontFamily: "outfit",
                                                fontSize: 16,
                                                color: Color(0xff444444),
                                                fontWeight: FontWeight.w500),
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
                                      if (NewProfileData?.object?.isFollowing ==
                                              'FOLLOWING' ||
                                          User_ID ==
                                              NewProfileData?.object?.userUid) {
                                        if (followersClassModel2
                                                ?.object?.isNotEmpty ==
                                            true) {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      Followers(
                                                        // FOLLOWING
                                                        appBarName: 'Following',
                                                        followersClassModel:
                                                            followersClassModel2!,
                                                        userId: User_ID,
                                                      ))).then((value) => null);
                                        }
                                      } else {}
                                    },
                                    child: Container(
                                      child: Column(
                                        children: [
                                          SizedBox(
                                            height: 11,
                                          ),
                                          Text(
                                            '${NewProfileData?.object?.followingCount}',
                                            style: TextStyle(
                                                fontFamily: "outfit",
                                                fontSize: 25,
                                                color: Color(0xff000000),
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text(
                                            'Following',
                                            style: TextStyle(
                                                fontFamily: "outfit",
                                                fontSize: 16,
                                                color: Color(0xff444444),
                                                fontWeight: FontWeight.w500),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
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
                      if (NewProfileData?.object?.isFollowing == 'FOLLOWING' ||
                          User_ID == NewProfileData?.object?.userUid)
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Expanded(
                              child: GestureDetector(
                                child: Column(
                                  children: [
                                    Container(
                                      height: 40,
                                      // color: arrNotiyTypeList[0].isSelected
                                      //     ? Color(0xFFED1C25)
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
                                                    textScaleFactor: 1.0,
                                                    style: TextStyle(
                                                        // color: arrNotiyTypeList[3].isSelected
                                                        //     ? Colors.white
                                                        //     : Colors.black,
                                                        fontSize: 18,
                                                        fontFamily: 'Outfit',
                                                        fontWeight:
                                                            FontWeight.bold)),
                                                Spacer(),
                                              ],
                                            ),
                                            arrNotiyTypeList[0].isSelected
                                                ? Divider(
                                                    endIndent: 20,
                                                    indent: 20,
                                                    color: Colors.black,
                                                  )
                                                : SizedBox(),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                onTap: () {
                                  setState(() {
                                    updateType();
                                    arrNotiyTypeList[0].isSelected = true;
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
                                      //     ? Color(0xFFED1C25)
                                      //     : Theme.of(context).brightness == Brightness.light
                                      //         ? Colors.white
                                      //         : Colors.black,
                                      child: Column(
                                        children: [
                                          Row(
                                            children: [
                                              const Spacer(),
                                              Text("Post",
                                                  textScaleFactor: 1.0,
                                                  style: TextStyle(
                                                      // color: arrNotiyTypeList[3].isSelected
                                                      //     ? Colors.white
                                                      //     : Colors.black,
                                                      fontSize: 18,
                                                      fontFamily: 'Outfit',
                                                      fontWeight:
                                                          FontWeight.bold)),
                                              Spacer(),
                                            ],
                                          ),
                                          arrNotiyTypeList[1].isSelected
                                              ? Divider(
                                                  endIndent: 30,
                                                  indent: 30,
                                                  color: Colors.black,
                                                )
                                              : SizedBox(),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                                onTap: () {
                                  setState(() {
                                    updateType();
                                    arrNotiyTypeList[1].isSelected = true;
                                    print("abcd");
                                  });
                                },
                              ),
                            ),
                            Container(
                              height: 1,
                              color: Colors.black12,
                            ),
                            User_ID == NewProfileData?.object?.userUid
                                ? Expanded(
                                    child: GestureDetector(
                                      child: Column(
                                        children: [
                                          Container(
                                              height: 40,
                                              alignment: Alignment.center,
                                              // color: arrNotiyTypeList[2].isSelected
                                              //     ? Color(0xFFED1C25)
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
                                                                fontSize: 18,
                                                                fontFamily:
                                                                    'Outfit',
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold)),
                                                        Spacer(),
                                                      ],
                                                    ),
                                                    arrNotiyTypeList[2]
                                                            .isSelected
                                                        ? Divider(
                                                            endIndent: 5,
                                                            indent: 5,
                                                            color: Colors.black,
                                                          )
                                                        : SizedBox(),
                                                  ],
                                                ),
                                              )),
                                        ],
                                      ),
                                      onTap: () {
                                        setState(() {
                                          updateType();
                                          arrNotiyTypeList[2].isSelected = true;
                                        });
                                        print("abcd");
                                      },
                                    ),
                                  )
                                : SizedBox(),
                            User_ID == NewProfileData?.object?.userUid
                                ? Expanded(
                                    child: GestureDetector(
                                      child: Container(
                                          height: 40,
                                          alignment: Alignment.center,
                                          // color: arrNotiyTypeList[3].isSelected
                                          //     ? Color(0xFFED1C25)
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
                                                        textScaleFactor: 1.0,
                                                        style: TextStyle(
                                                            // color: arrNotiyTypeList[3].isSelected
                                                            //     ? Colors.white
                                                            //     : Colors.black,
                                                            fontSize: 18,
                                                            fontFamily:
                                                                'Outfit',
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold)),
                                                    Spacer(),
                                                  ],
                                                ),
                                                arrNotiyTypeList[3].isSelected
                                                    ? Divider(
                                                        endIndent: 25,
                                                        indent: 25,
                                                        color: Colors.black,
                                                      )
                                                    : SizedBox(),
                                              ],
                                            ),
                                          )),
                                      onTap: () {
                                        setState(() {
                                          updateType();
                                          arrNotiyTypeList[3].isSelected = true;
                                        });
                                        print("abcd");
                                      },
                                    ),
                                  )
                                : SizedBox.shrink(),
                          ],
                        ),
                      if (NewProfileData?.object?.isFollowing == 'FOLLOWING' ||
                          User_ID == NewProfileData?.object?.userUid)
                        Container(
                          // color: Colors.red,
                          /*  height: _height, */
                          height: arrNotiyTypeList[0].isSelected == true
                              ? NewProfileData?.object?.module == "EMPLOYEE"
                                  ? _height / 3
                                  : NewProfileData?.object?.module == "EXPERT"
                                      ? 830
                                      : NewProfileData?.object?.module ==
                                              "COMPANY"
                                          ? 650
                                          : 0
                              : arrNotiyTypeList[1].isSelected == true
                                  ? FinalPostCount * 190
                                  : arrNotiyTypeList[2].isSelected == true
                                      ? CommentsPostCount * 310 + 100
                                      : arrNotiyTypeList[3].isSelected == true
                                          ? value1 == 0
                                              ?  FinalSavePostCount == 0 ? 40 : FinalSavePostCount * 230
                                              : SaveBlogCount * 155 + 100
                                          : 10,
                          child: SingleChildScrollView(
                            physics: NeverScrollableScrollPhysics(),
                            child: Column(
                              children: <Widget>[
                                /// Content of Tab 1
                                arrNotiyTypeList[0].isSelected
                                    ? Padding(
                                        padding: const EdgeInsets.only(
                                            left: 16, right: 16, top: 14),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            User_ID !=
                                                    NewProfileData
                                                        ?.object?.userUid
                                                ? NewProfileData
                                                            ?.object?.aboutMe ==
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
                                                                  color: Color(
                                                                      0xFFED1C25),
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
                                                              subtitle: Text(
                                                                '${NewProfileData?.object?.aboutMe}',
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .black,
                                                                    fontSize:
                                                                        14,
                                                                    fontFamily:
                                                                        "outfit"),
                                                              ),
                                                            ),
                                                          ],
                                                        ))
                                                : Card(
                                                    color: Colors.white,
                                                    borderOnForeground: true,
                                                    elevation: 10,
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              15.0),
                                                    ),
                                                    child: ListTile(
                                                       /*  leading: Container(
                                                          width: 35,
                                                          height: 35,
                                                          decoration:
                                                              ShapeDecoration(
                                                            color: Color(
                                                                0xFFED1C25),
                                                            shape: OvalBorder(),
                                                          ),
                                                        ), */
                                                        title: Padding(
                                                          padding: const EdgeInsets.only(left: 0),
                                                          child: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              SizedBox(
                                                                height: 15,
                                                              ),
                                                              Text(
                                                                'About Me',
                                                                style: TextStyle(
                                                                  color: Colors
                                                                      .black,
                                                                  fontSize: 18,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                height: 5,
                                                              ),
                                                              AbboutMeShow == true
                                                                  ? Container(
                                                                      alignment:
                                                                          Alignment
                                                                              .center,
                                                                      height: 50,
                                                                      width:
                                                                          _width /
                                                                              2,
                                                                      decoration: BoxDecoration(
                                                                          // color: Colors.amber
                                                                          borderRadius: BorderRadius.circular(10),
                                                                          border: Border.all(color: Color(0xffEFEFEF))),
                                                                      child: Text(
                                                                        'Enter About Me',
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                                14,
                                                                            fontWeight: FontWeight
                                                                                .w300,
                                                                            color:
                                                                                Colors.black),
                                                                      ),
                                                                    )
                                                                  : TextFormField(
                                                                      inputFormatters: [
                                                                        LengthLimitingTextInputFormatter(
                                                                            500),
                                                                      ],
                                                                      readOnly:
                                                                          isAbourtMe,
                                                                      controller:
                                                                          aboutMe,
                                                                      maxLines: 5,
                                                                      decoration:
                                                                          InputDecoration(
                                                                        border:
                                                                            OutlineInputBorder(),
                                                                      ),
                                                                    ),
                                                              //wiil DataGet
                                                              /*   : */
                                                              SizedBox(
                                                                height: 12,
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        trailing: User_ID !=
                                                                NewProfileData
                                                                    ?.object
                                                                    ?.userUid
                                                            ? SizedBox.shrink()
                                                            : GestureDetector(
                                                                onTap: () {
                                                                  setState(() {
                                                                    isUpDate =
                                                                        true;
                                                                    isAbourtMe =
                                                                        false;
                                                                    AbboutMeShow =
                                                                        false;
                                                                  });
                                                                },
                                                                child: isUpDate ==
                                                                        true
                                                                    ? GestureDetector(
                                                                        onTap:
                                                                            () {
                                                                          if (aboutMe
                                                                              .text
                                                                              .isNotEmpty) {
                                                                            BlocProvider.of<NewProfileSCubit>(context).abboutMeApi(context,
                                                                                aboutMe.text);
                                                                          } else {
                                                                            SnackBar
                                                                                snackBar =
                                                                                SnackBar(
                                                                              content: Text('Please Enter About Me'),
                                                                              backgroundColor: ColorConstant.primary_color,
                                                                            );
                                                                            ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                                                          }
                                                                        },
                                                                        child:
                                                                            Container(
                                                                          alignment:
                                                                              Alignment.center,
                                                                          height:
                                                                              30,
                                                                          width:
                                                                              70,
                                                                          decoration:
                                                                              BoxDecoration(
                                                                            borderRadius:
                                                                                BorderRadius.circular(10),
                                                                            color:
                                                                                Color(0xFFED1C25),
                                                                          ),
                                                                          child:
                                                                              Text(
                                                                            'SAVE',
                                                                            style:
                                                                                TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                                                                          ),
                                                                        ),
                                                                      )
                                                                    : Icon(
                                                                        Icons
                                                                            .edit,
                                                                        color: Colors
                                                                            .black,
                                                                      ),
                                                              ))),
                                            NewProfileData?.object?.module ==
                                                    "EXPERT"
                                                ? Card(
                                                    color: Colors.white,
                                                    borderOnForeground: true,
                                                    elevation: 10,
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              15.0),
                                                    ),
                                                    /*  child: expertUser(_height, _width) */
                                                    child: expertUser(
                                                        _height, _width),
                                                  )
                                                : SizedBox(),
                                            NewProfileData?.object?.module ==
                                                    "COMPANY"
                                                ? Card(
                                                    color: Colors.white,
                                                    borderOnForeground: true,
                                                    elevation: 10,
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              15.0),
                                                    ),
                                                    /*  child: expertUser(_height, _width) */
                                                    child: compnayUser(
                                                        _height, _width),
                                                  )
                                                : SizedBox()
                                          ],
                                        ),
                                      )
                                    : SizedBox(),

                                /// Content of Tab 2
                                arrNotiyTypeList[1].isSelected
                                    ? Container(
                                        height: FinalPostCount * 190,
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
                                            itemCount:
                                                GetAllPostData?.object?.length,
                                            itemBuilder: (context, index) {
                                              return Padding(
                                                padding: EdgeInsets.only(
                                                    bottom: 10, top: 10),
                                                child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          12.0),
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
                                                                margin: EdgeInsets.all(
                                                                    0.0),
                                                                decoration: BoxDecoration(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            20)), // Remove margin

                                                                child:
                                                                    CustomImageView(
                                                                  fit: BoxFit
                                                                      .cover,
                                                                  url:
                                                                      "${GetAllPostData?.object?[index].postData?[0]}",
                                                                ))
                                                            : GetAllPostData
                                                                        ?.object?[
                                                                            index]
                                                                        .postDataType ==
                                                                    "ATTACHMENT"
                                                                ? Container(
                                                                    margin:
                                                                        EdgeInsets.all(
                                                                            0.0),
                                                                    decoration: BoxDecoration(
                                                                        borderRadius: BorderRadius.circular(
                                                                            20)), // Remove margin

                                                                    child:
                                                                        DocumentViewScreen1(
                                                                      path: GetAllPostData
                                                                          ?.object?[
                                                                              index]
                                                                          .postData?[0],
                                                                    ))
                                                                : GetAllPostData
                                                                            ?.object?[index]
                                                                            .postDataType ==
                                                                        null
                                                                    ? Container(
                                                                        margin: EdgeInsets.all(0.0),
                                                                        decoration: BoxDecoration(border: Border.all(color: Color(0xffF0F0F0)), borderRadius: BorderRadius.circular(20)),
                                                                        child: Padding(
                                                                          padding: const EdgeInsets.only(
                                                                              top: 15,
                                                                              left: 8,
                                                                              right: 10),
                                                                          child:
                                                                              Text(
                                                                            '${GetAllPostData?.object?[index].description}',
                                                                            style:
                                                                                TextStyle(color: Colors.black, fontSize: 16),
                                                                          ),
                                                                        ))
                                                                    : SizedBox(),
                                                  ),
                                                ),
                                              );
                                            },
                                          ),
                                        ),
                                      )
                                    : SizedBox(),

                                /// Content of Tab 3
                                arrNotiyTypeList[2].isSelected
                                    ? Container(
                                        height: _height * 70,
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              left: 16, right: 16, top: 0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                height: 30,
                                                child: Row(
                                                  children: [
                                                    Container(
                                                      width: 150,
                                                      height: 25,
                                                      decoration:
                                                          ShapeDecoration(
                                                        color:
                                                            Color(0xFFFBD8D9),
                                                        shape:
                                                            RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      100),
                                                        ),
                                                      ),
                                                      child:
                                                          DropdownButtonHideUnderline(
                                                        child: DropdownButton<
                                                            String>(
                                                          // Step 3.
                                                          value: selctedValue,
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
                                                              value: value,
                                                              child: Padding(
                                                                padding: EdgeInsets
                                                                    .only(
                                                                        left:
                                                                            10),
                                                                child: Text(
                                                                  value,
                                                                  style:
                                                                      TextStyle(
                                                                    color: Color(
                                                                        0xFFF58E92),
                                                                    fontSize:
                                                                        14,
                                                                    fontFamily:
                                                                        'outfit',
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w400,
                                                                    height: 0,
                                                                  ),
                                                                ),
                                                              ),
                                                            );
                                                          }).toList(),
                                                          // Step 5.
                                                          onChanged: (String?
                                                              newValue) {
                                                            setState(() {
                                                              if (newValue ==
                                                                  "Newest to oldest") {
                                                                BlocProvider.of<
                                                                            NewProfileSCubit>(
                                                                        context)
                                                                    .GetPostCommetAPI(
                                                                        context,
                                                                        "${NewProfileData?.object?.userUid}",
                                                                        "asc"); //asc
                                                              } else if (newValue ==
                                                                  "oldest to Newest") {
                                                                BlocProvider.of<
                                                                            NewProfileSCubit>(
                                                                        context)
                                                                    .GetPostCommetAPI(
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
                                                    /* SizedBox(
                                            width: 10,
                                          ),
                                          Container(
                                            width: 110,
                                            height: 25,
                                            decoration: ShapeDecoration(
                                              color: Color(0xFFFBD8D9),
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(100),
                                              ),
                                            ),
                                            child: DropdownButtonHideUnderline(
                                              child: DropdownButton<String>(
                                                // Step 3.
                                                value: selctedValue1,
                                                // Step 4.
                                                items: <String>[
                                                  'All Date',
                                                  '1',
                                                  '2',
                                                  '3',
                                                  '4'
                                                ].map<DropdownMenuItem<String>>(
                                                    (String value) {
                                                  return DropdownMenuItem<String>(
                                                    value: value,
                                                    child: Padding(
                                                      padding: EdgeInsets.only(
                                                          left: 12),
                                                      child: Text(
                                                        value,
                                                        style: TextStyle(
                                                          color:
                                                              Color(0xFFF58E92),
                                                          fontSize: 14,
                                                          fontFamily: 'outfit',
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          height: 0,
                                                        ),
                                                      ),
                                                    ),
                                                  );
                                                }).toList(),
                                                // Step 5.
                                                onChanged: (String? newValue) {
                                                  setState(() {
                                                    selctedValue1 = newValue!;
                                                  });
                                                },
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          Container(
                                            width: 100,
                                            height: 25,
                                            decoration: ShapeDecoration(
                                              color: Color(0xFFFBD8D9),
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(100),
                                              ),
                                            ),
                                            child: DropdownButtonHideUnderline(
                                              child: DropdownButton<String>(
                                                // Step 3.
                                                value: selctedValue2,
                                                // Step 4.
                                                items: <String>[
                                                  'All Users',
                                                  '1',
                                                  '2',
                                                  '3',
                                                  '4'
                                                ].map<DropdownMenuItem<String>>(
                                                    (String value) {
                                                  return DropdownMenuItem<String>(
                                                    value: value,
                                                    child: Padding(
                                                      padding: EdgeInsets.only(
                                                          left: 12),
                                                      child: Text(
                                                        value,
                                                        style: TextStyle(
                                                          color:
                                                              Color(0xFFF58E92),
                                                          fontSize: 14,
                                                          fontFamily: 'outfit',
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          height: 0,
                                                        ),
                                                      ),
                                                    ),
                                                  );
                                                }).toList(),
                                                // Step 5.
                                                onChanged: (String? newValue) {
                                                  setState(() {
                                                    selctedValue = newValue!;
                                                  });
                                                },
                                              ),
                                            ),
                                          ), */
                                                  ],
                                                ),
                                              ),
                                              Expanded(
                                                child: ListView.builder(
                                                  physics:
                                                      NeverScrollableScrollPhysics(),
                                                  itemCount:
                                                      GetUserPostCommetData
                                                          ?.object?.length,
                                                  itemBuilder:
                                                      (context, index) {
                                                    DateTime parsedDateTime =
                                                        DateTime.parse(
                                                            '${GetUserPostCommetData?.object?[index].createdAt ?? ""}');
                                                    return Center(
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                bottom: 10),
                                                        child: GestureDetector(
                                                          onTap: () {
                                                            Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                  builder:
                                                                      (context) =>
                                                                          OpenSavePostImage(
                                                                            PostID:
                                                                                GetUserPostCommetData?.object?[index].postUid,
                                                                            profileTure:
                                                                                true,
                                                                          )),
                                                            );
                                                          },
                                                          child: ConstrainedBox(
                                                            constraints:
                                                                BoxConstraints(
                                                                    maxHeight:
                                                                        300,
                                                                    maxWidth:
                                                                        _width),
                                                            child: Container(
                                                              decoration:
                                                                  ShapeDecoration(
                                                                // color: Colors.green,
                                                                shape:
                                                                    RoundedRectangleBorder(
                                                                  side: BorderSide(
                                                                      width: 1,
                                                                      color: Color(
                                                                          0xFFD3D3D3)),
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              10),
                                                                ),
                                                              ),
                                                              child: Column(
                                                                children: [
                                                                  Expanded(
                                                                    child: Container(
                                                                        // color: Colors.amber,
                                                                        child: Row(
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .start,
                                                                      children: [
                                                                        Container(
                                                                          width:
                                                                              50,
                                                                          height:
                                                                              50,
                                                                          margin: EdgeInsets.only(
                                                                              left: 5,
                                                                              top: 10),
                                                                          child:
                                                                              CircleAvatar(
                                                                            backgroundImage:
                                                                                NetworkImage("${GetUserPostCommetData?.object?[index].userProfilePic}"),
                                                                            radius:
                                                                                25,
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
                                                                        Column(
                                                                          crossAxisAlignment:
                                                                              CrossAxisAlignment.start,
                                                                          children: [
                                                                            SizedBox(
                                                                              height: 15,
                                                                            ),
                                                                            Padding(
                                                                              padding: const EdgeInsets.only(left: 10),
                                                                              child: Text(
                                                                                '${GetUserPostCommetData?.object?[index].postUserName}',
                                                                                style: TextStyle(
                                                                                  color: Colors.black,
                                                                                  fontSize: 16,
                                                                                  fontFamily: 'outfit',
                                                                                  fontWeight: FontWeight.w600,
                                                                                ),
                                                                              ),
                                                                            ),
                                                                            Expanded(
                                                                              child: Container(
                                                                                margin: EdgeInsets.only(left: 10),
                                                                                width: _width - 100,

                                                                                // color: Colors.red,
                                                                                child: Column(
                                                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                                                  children: [
                                                                                    GetUserPostCommetData?.object?[index].description != null
                                                                                        ? Text(
                                                                                            '${GetUserPostCommetData?.object?[index].description}',
                                                                                            style: TextStyle(
                                                                                              color: Colors.black,
                                                                                              fontSize: 14,
                                                                                              fontFamily: 'outfit',
                                                                                              fontWeight: FontWeight.w400,
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
                                                                                    Expanded(
                                                                                      child: ListView.builder(
                                                                                          padding: EdgeInsets.zero,
                                                                                          shrinkWrap: true,
                                                                                          physics: NeverScrollableScrollPhysics(),
                                                                                          itemCount: GetUserPostCommetData?.object?[index].comments?.length == null ? 0 : ((GetUserPostCommetData?.object?[index].comments?.length ?? 0) > 2 ? 2 : GetUserPostCommetData?.object?[index].comments?.length),
                                                                                          itemBuilder: (context, index2) {
                                                                                            DateTime parsedDateTime2 = DateTime.parse('${GetUserPostCommetData?.object?[index].comments?[index2].createdAt}');
                                                                                            return Row(
                                                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                                                              children: [
                                                                                                Container(
                                                                                                  width: 45,
                                                                                                  height: 45,
                                                                                                  margin: EdgeInsets.only(top: 15),
                                                                                                  child: CircleAvatar(
                                                                                                    backgroundImage: NetworkImage("${GetUserPostCommetData?.object?[index].comments?[index2].profilePic}"),
                                                                                                    radius: 25,
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
                                                                                                        width: _width / 1.7,
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
                                                                                          }),
                                                                                    )
                                                                                  ],
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                        /* Container(
                                                                width: 60,
                                                                height: 60,
                                                                margin:
                                                                    EdgeInsets.only(
                                                                        left: 10,
                                                                        top: 5),
                                                                decoration:
                                                                    ShapeDecoration(
                                                                  image:
                                                                      DecorationImage(
                                                                    image: NetworkImage(
                                                                        "${GetUserPostCommetData?.object?[index].postData?[0]}"),
                                                                    fit: BoxFit.cover,
                                                                  ),
                                                                  shape: RoundedRectangleBorder(
                                                                      borderRadius:
                                                                          BorderRadius
                                                                              .circular(
                                                                                  4)),
                                                                ),
                                                              ), */
                                                                      ],
                                                                    )),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      )
                                    : SizedBox(),

                                /// Content of Tab 4

                                arrNotiyTypeList[3].isSelected
                                    ? Container(
                                        height: value1 == 0
                                            ? FinalSavePostCount == 0 ? 40 : FinalSavePostCount * 230
                                            : SaveBlogCount * 155 + 100,
                                        // color: Colors.green,
                                        child: Padding(
                                          padding: EdgeInsets.only(top: 0),
                                          child: Column(
                                            children: [
                                              Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: List.generate(
                                                      SaveList.length,
                                                      (index) =>
                                                          GestureDetector(
                                                              onTap: () {
                                                                dataSetup =
                                                                    null;
                                                                value1 = index;

                                                                SharedPreferencesFunction(
                                                                    value1 ??
                                                                        0);
                                                                setState(() {});
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
                                                                      ? Color(
                                                                          0xFFED1C25)
                                                                      : dataSetup ==
                                                                              index
                                                                          ? Color(
                                                                              0xFFED1C25)
                                                                          : Color(
                                                                              0xFFFBD8D9),
                                                                  shape:
                                                                      RoundedRectangleBorder(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            100),
                                                                  ),
                                                                ),
                                                                child: Text(
                                                                  SaveList[
                                                                      index],
                                                                  style:
                                                                      TextStyle(
                                                                    color: value1 ==
                                                                            index
                                                                        ? Colors
                                                                            .white
                                                                        : dataSetup ==
                                                                                index
                                                                            ? Colors.white
                                                                            : Color(0xFFF58E92),
                                                                    fontSize:
                                                                        14,
                                                                    fontFamily:
                                                                        "outfit",
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w400,
                                                                  ),
                                                                ),
                                                              )))),
                                              NavagtionPassing()
                                            ],
                                          ),
                                        ),
                                      )
                                    : SizedBox(),
                              ],
                            ),
                          ),
                        ),
                      SizedBox(
                        height: 20,
                      )
                    ],
                  )),
                ));
    });
  }

  SharedPreferencesFunction(int value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt(PreferencesKey.tabSelction, value);
  }

  Widget NavagtionPassing() {
    if (value1 == 0) {
      return Expanded(
          child: Padding(
        padding: EdgeInsets.only(left: 10, right: 10, top: 10),
        child: GridView.builder(
          physics: NeverScrollableScrollPhysics(),
          padding: EdgeInsets.zero,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 20,
            crossAxisSpacing: 20,
          ),
          itemCount: GetSavePostData?.object?.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: EdgeInsets.only(bottom: 0, top: 0),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => OpenSavePostImage(
                              PostID: GetSavePostData?.object?[index].postUid,
                            )),
                  );
                },
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12.0),
                  child: Container(
                      margin: EdgeInsets.all(0.0),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20)),
                      child: CustomImageView(
                        url: "${GetSavePostData?.object?[index].postData?[0]}",
                        fit: BoxFit.cover,
                      )),
                ),
              ),
            );
          },
        ),
      ));
    } else {
      return Padding(
        padding: const EdgeInsets.only(top: 10, right: 10, left: 10),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: List.generate(saveAllBlogModelData?.object?.length ?? 0,
                (index) {
              parsedDateTimeBlogs = DateTime.parse(
                  '${saveAllBlogModelData?.object?[index].createdAt ?? ""}');
              return Container(
                margin: EdgeInsets.only(bottom: 10),
                height: 155,
                decoration: BoxDecoration(
                    // color: Colors.amber,

                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Color(0xffF1F1F1))),
                child: GestureDetector(
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
                                    ""),
                          ));
                    },
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
                                    crossAxisAlignment: CrossAxisAlignment.end,
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
                                      GestureDetector(
                                        onTap: () {
                                          print("click on Blog like button");

                                          BlocProvider.of<NewProfileSCubit>(
                                                  context)
                                              .ProfileLikeBlog(
                                                  context,
                                                  "${User_ID}",
                                                  "${saveAllBlogModelData?.object?[index].uid}");
                                          if (saveAllBlogModelData
                                                  ?.object?[index].isLiked ==
                                              false) {
                                            saveAllBlogModelData
                                                ?.object?[index].isLiked = true;
                                          } else {
                                            saveAllBlogModelData?.object?[index]
                                                .isLiked = false;
                                          }
                                        },
                                        child: saveAllBlogModelData
                                                    ?.object?[index].isLiked ==
                                                false
                                            ? Icon(Icons.favorite_border)
                                            : Icon(
                                                Icons.favorite,
                                                color: Colors.red,
                                              ),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      GestureDetector(
                                          onTap: () {
                                            print("Unsave Button");

                                            BlocProvider.of<NewProfileSCubit>(
                                                    context)
                                                .ProfileSaveBlog(
                                                    context,
                                                    "${User_ID}",
                                                    "${saveAllBlogModelData?.object?[index].uid}");

                                            if (saveAllBlogModelData
                                                    ?.object?[index].isSaved ==
                                                true) {
                                              saveAllBlogModelData?.object
                                                  ?.removeAt(index);
                                              setState(() {
                                                SaveBlogCount =
                                                    saveAllBlogModelData
                                                            ?.object?.length ??
                                                        0;
                                              });
                                            }
                                          },
                                          child: Container(
                                            height: 25,
                                            width: 25,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                                color: Colors.white),
                                            child: Center(
                                                child: Padding(
                                              padding:
                                                  const EdgeInsets.all(5.0),
                                              child: Image.asset(
                                                saveAllBlogModelData
                                                            ?.object?[index]
                                                            .isSaved ==
                                                        false
                                                    ? ImageConstant.savePin
                                                    : ImageConstant.Savefill,
                                                width: 12.5,
                                              ),
                                            )),
                                          )),
                                    ]),
                              ),
                            ],
                          ),
                        )
                      ],
                    )),
              );
            })),
      );
    }
  }

  Widget expertUser(_height, _width) {
    return Column(
      children: [
        ListTile(
         /*  leading: Container(
            width: 35,
            height: 35,
            decoration: ShapeDecoration(
              color: Color(0xFFED1C25),
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
                  BlocProvider.of<NewProfileSCubit>(context)
                      .NewProfileSAPI(context, widget.User_ID));
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
          height: 550,
          width: _width,
          //  color: Colors.amber,
          child: Padding(
            padding: const EdgeInsets.only(left: 16,right: 16),
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
                    readOnly: true,
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
                if (NewProfileData?.object?.fees != null)
                  Text(
                    "Fees",
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontFamily: 'outfit',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                if (NewProfileData?.object?.fees != null)
                  Container(
                    width: _width ,
                    child: CustomTextFormField(
                      readOnly: true,
                      controller: priceContrller,
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
                      hintText: "Price / hr",
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
                          _selectStartTime(context);
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
                                    start != null ? start.toString() : '00:00',
                                    style: TextStyle(
                                        fontSize: 15, color: Color(0xff989898)),
                                  )),
                              SizedBox(
                                width: 7,
                              ),
                              VerticalDivider(
                                thickness: 2,
                                color: Color(0xff989898),
                              ),
                              Text(startAm != null ? startAm.toString() : 'AM',
                                  style: TextStyle(
                                      fontSize: 15, color: Color(0xff989898))),
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
                          _selectEndTime(context);
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
                                        fontSize: 15, color: Color(0xff989898)),
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
                                      fontSize: 15, color: Color(0xff989898))),
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
                Text(
                  "Document",
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontFamily: 'outfit',
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Row(
                  children: [
                    Container(
                        height: 50,
                        width: _width -175,
                        decoration: BoxDecoration(
                            color: Color(0XFFF6F6F6),
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(5),
                                bottomLeft: Radius.circular(5))),
                        child: Padding(
                          padding: const EdgeInsets.only(top: 15, left: 20),
                          child: Text(
                            '${dopcument.toString()}',
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(fontSize: 16),
                          ),
                        )),
                    dopcument == "Upload Image"
                        ? GestureDetector(
                            onTap: () async {
                              print(
                                  'dopcument.toString()--${dopcument.toString()}');
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
                                // dopcument = "Upload Image";
          
                                // setState(() {});
          
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => DocumentViewScreen(
                                          path: dopcument,
                                          title: 'Pdf',
                                        )));
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
  }

  Widget compnayUser(_height, _width) {
    return Column(
      children: [
        ListTile(
          /* leading: Container(
            width: 35,
            height: 35,
            decoration: ShapeDecoration(
              color: Color(0xFFED1C25),
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
                  BlocProvider.of<NewProfileSCubit>(context)
                      .NewProfileSAPI(context, widget.User_ID));
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
          height: 350,
          width: _width,

            
          child: Padding(
            padding: const EdgeInsets.only(right: 16,left: 16),
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
                  width: _width ,
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
                  width: _width ,
                  child: CustomTextFormField(
                    readOnly: true,
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
                  "Document",
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontFamily: 'outfit',
                    fontWeight: FontWeight.w500,
                  ),
                ),
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
                          padding: const EdgeInsets.only(top: 15, left: 10),
                          child: Text(
                            '${dopcument.toString()}',
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(fontSize: 16),
                          ),
                        )),
                    dopcument == "Upload Image"
                        ? GestureDetector(
                            onTap: () async {
                              print(
                                  'dopcument.toString()--${dopcument.toString()}');
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
                                // dopcument = "Upload Image";
          
                                // setState(() {});
          
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => DocumentViewScreen(
                                          path: dopcument,
                                          title: 'Pdf',
                                        )));
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
  }

  Future<void> _selectStartTime(BuildContext context) async {
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
      setState(() {
        _startTime = pickedTime;
      });
    }
  }

  Future<void> _selectEndTime(BuildContext context) async {
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
      setState(() {
        _endTime = pickedTime;
      });
    }
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
              setState(() {
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
              setState(() {
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
        setState(() {});

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
              setState(() {
                uplopdfile.text = file1.name;
                dopcument = file1.name;
              });
              print("DOCUMENT IN MB ---->$dopcument");
              break;
            default:
          }
          print('filecheckPath1-${file1.name}');
          setState(() {
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

  updateType() {
    arrNotiyTypeList.forEach((element) {
      element.isSelected = false;
    });
  }
}
