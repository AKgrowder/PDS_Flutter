// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:pds/API/Bloc/NewProfileScreen_Bloc/NewProfileScreen_cubit.dart';
// import 'package:pds/API/Bloc/NewProfileScreen_Bloc/NewProfileScreen_state.dart';
// import 'package:pds/API/Model/FollwersModel/FllowersModel.dart';
// import 'package:pds/API/Model/NewProfileScreenModel/NewProfileScreen_Model.dart';
// import 'package:pds/API/Model/saveAllBlogModel/saveAllBlog_Model.dart';
// import 'package:pds/core/utils/color_constant.dart';
// import 'package:pds/core/utils/image_constant.dart';
// import 'package:pds/presentation/%20new/profileNew.dart';
// import 'package:pds/presentation/DMAll_Screen/Dm_Screen.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:file_picker/file_picker.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_mentions/flutter_mentions.dart';
// import 'package:intl/intl.dart';
// import 'package:linkfy_text/linkfy_text.dart';
// import 'package:pds/API/Bloc/NewProfileScreen_Bloc/NewProfileScreen_cubit.dart';
// import 'package:pds/API/Bloc/NewProfileScreen_Bloc/NewProfileScreen_state.dart';
// import 'package:pds/API/Bloc/followerBlock/followBlock.dart';
// import 'package:pds/API/Bloc/my_account_Bloc/my_account_cubit.dart';
// import 'package:pds/API/Model/FollwersModel/FllowersModel.dart';
// import 'package:pds/API/Model/NewProfileScreenModel/GetAppUserPost_Model.dart';
// import 'package:pds/API/Model/NewProfileScreenModel/GetSavePost_Model.dart';
// import 'package:pds/API/Model/NewProfileScreenModel/GetUserPostCommet_Model.dart';
// import 'package:pds/API/Model/NewProfileScreenModel/NewProfileScreen_Model.dart';
// import 'package:pds/API/Model/saveAllBlogModel/saveAllBlog_Model.dart';
// import 'package:pds/core/app_export.dart';
// import 'package:pds/core/utils/color_constant.dart';
// import 'package:pds/core/utils/sharedPreferences.dart';
// import 'package:pds/presentation/%20new/AddWorkExperience_Screen.dart';
// import 'package:pds/presentation/%20new/ExperienceEdit_screen.dart';
// import 'package:pds/presentation/%20new/HashTagView_screen.dart';
// import 'package:pds/presentation/%20new/OpenSavePostImage.dart';
// import 'package:pds/presentation/%20new/editproilescreen.dart';
// import 'package:pds/presentation/%20new/followers.dart';
// import 'package:pds/presentation/%20new/newbottembar.dart';
// import 'package:pds/presentation/%20new/test.dart';
// import 'package:pds/presentation/%20new/view_profile_background.dart';
// import 'package:pds/presentation/DMAll_Screen/Dm_Screen.dart';
// import 'package:pds/presentation/recent_blog/recent_blog_screen.dart';
// import 'package:pds/presentation/register_create_account_screen/register_create_account_screen.dart';
// import 'package:pds/presentation/settings/setting_screen.dart';
// import 'package:pds/widgets/commentPdf.dart';
// import 'package:pds/widgets/custom_text_form_field.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:url_launcher/url_launcher.dart';
// import 'package:video_thumbnail/video_thumbnail.dart';

// import '../../API/Model/HasTagModel/hasTagModel.dart';
// import '../../API/Model/WorkExperience_Model/WorkExperience_model.dart';
// import '../../API/Model/serchForInboxModel/serchForinboxModel.dart';

// class TestScreen extends StatefulWidget {
//   String User_ID;
//   String? isFollowing;

//   TestScreen({
//     required this.User_ID,
//     required this.isFollowing,
//   });

//   @override
//   State<TestScreen> createState() => _TestScreenState();
// }

// class _TestScreenState extends State<TestScreen>
//     with SingleTickerProviderStateMixin {
//   final bodyGlobalKey = GlobalKey();
//   final List<Widget> myTabs = [
//     Tab(text: 'Details'),
//     Tab(text: 'Post'),
//     Tab(text: 'Comments'),
//   ];
//   late TabController _tabController;
//   late ScrollController _scrollController;
//   bool? fixedScroll;
//   saveAllBlogModel? saveAllBlogModelData;
//   int SaveBlogCount = 0;
//   FollowersClassModel? followersClassModel1;
//   FollowersClassModel? followersClassModel2;
//   bool AbboutMeShow = true;
//   TextEditingController aboutMe = TextEditingController();
//   NewProfileScreen_Model? NewProfileData;
//   String industryTypesArray = "";
//   String ExpertiseData = "";
//   bool isDataGet = false;
//   TextEditingController jobprofileController = TextEditingController();
//   TextEditingController IndustryType = TextEditingController();
//   TextEditingController priceContrller = TextEditingController();
//   TextEditingController uplopdfile = TextEditingController();
//   TextEditingController CompanyName = TextEditingController();
//   TextEditingController Expertise = TextEditingController();
//   String? dopcument;
//   String? User_Module;
//   int UserProfilePostCount = 0;
//   SearchUserForInbox? searchUserForInbox1;

//   int FinalPostCount = 0;
//   int SavePostCount = 0;

//   String? workignStart;
//   String? workignend;
//   String? start;
//   String? startAm;
//   String? end;
//   String? endAm;
//   GetAppUserPostModel? GetAllPostData;
//   GetUserPostCommetModel? GetUserPostCommetData;
//   int CommentsPostCount = 0;
//   GetSavePostModel? GetSavePostData;
//   int FinalSavePostCount = 0;
//   bool isAbourtMe = true;
//   bool isUpDate = false;
//   GetWorkExperienceModel? addWorkExperienceModel;
//   bool istageData = false;
//   bool isHeshTegData = false;
//   HasDataModel? getAllHashtag;
//   List<Map<String, dynamic>> tageData = [];
//   List<Map<String, dynamic>> heshTageData = [];

//   Widget _buildCarousel() {
//     return Stack(
//       children: <Widget>[
//         Placeholder(fallbackHeight: 100),
//         Positioned.fill(
//             child: Align(alignment: Alignment.center, child: Text('Slider'))),
//       ],
//     );
//   }

//   savedataFuntion(String userId) async {
//     final SharedPreferences prefs = await SharedPreferences.getInstance();
//     User_Module = prefs.getString(PreferencesKey.module);
//     super.setState(() {});

//     BlocProvider.of<NewProfileSCubit>(context).get_about_me(context, userId);

//     BlocProvider.of<NewProfileSCubit>(context).GetAllSaveBlog(context, userId);
//   }

//   @override
//   void initState() {
//     _scrollController = ScrollController();
//     _scrollController.addListener(_scrollListener);
//     _tabController = TabController(length: 3, vsync: this);
//     _tabController.addListener(_smoothScrollToTop);
//     getAllAPI_Data();
//     getUserSavedData();
//     dataSetup = null;
//     value1 = 0;
//     super.initState();
//   }

//   getAllAPI_Data() async {
//     BlocProvider.of<NewProfileSCubit>(context)
//         .NewProfileSAPI(context, widget.User_ID);
//     BlocProvider.of<NewProfileSCubit>(context)
//         .getFollwerApi(context, widget.User_ID);
//     BlocProvider.of<NewProfileSCubit>(context)
//         .getAllFollwing(context, widget.User_ID);
//     BlocProvider.of<NewProfileSCubit>(context)
//         .GetWorkExperienceAPI(context, widget.User_ID);
//   }

//   getUserSavedData() async {
//     final SharedPreferences prefs = await SharedPreferences.getInstance();
//     User_ID = prefs.getString(PreferencesKey.loginUserID);
//     User_Module = prefs.getString(PreferencesKey.module);
//   }

//   @override
//   void dispose() {
//     _tabController.dispose();
//     _scrollController.dispose();
//     super.dispose();
//   }

//   _scrollListener() {
//     if (fixedScroll ?? false) {
//       _scrollController.jumpTo(0);
//     }
//   }

//   _smoothScrollToTop() {
//     _scrollController.animateTo(
//       0,
//       duration: Duration(microseconds: 300),
//       curve: Curves.ease,
//     );

//     super.setState(() {
//       fixedScroll = _tabController.index == 2;
//     });
//   }

//   _buildTabContext(int lineCount) => Container(
//         child: ListView.builder(
//           physics: const ClampingScrollPhysics(),
//           itemCount: lineCount,
//           itemBuilder: (BuildContext context, int index) {
//             return Text('some content');
//           },
//         ),
//       );

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: BlocConsumer<NewProfileSCubit, NewProfileSState>(
//         listener: (context, state) {
//           if (state is NewProfileSErrorState) {
//             SnackBar snackBar = SnackBar(
//               content: Text(state.error),
//               backgroundColor: ColorConstant.primary_color,
//             );
//             ScaffoldMessenger.of(context).showSnackBar(snackBar);
//           }
//           if (state is AboutMeLoadedState1) {
//             print("this data i will get-->${state.aboutMe.object}");
//             if (state.aboutMe.object?.isNotEmpty == true) {
//               AbboutMeShow = false;
//             }
//             aboutMe.text = state.aboutMe.object.toString();
//           }
//           if (state is saveAllBlogModelLoadedState1) {
//             saveAllBlogModelData = state.saveAllBlogModelData;
//             SaveBlogCount = saveAllBlogModelData?.object?.length ?? 0;
//           }
//           if (state is NewProfileSLoadingState) {
//             Center(
//               child: Container(
//                 margin: EdgeInsets.only(bottom: 100),
//                 child: ClipRRect(
//                   borderRadius: BorderRadius.circular(20),
//                   child: Image.asset(ImageConstant.loader,
//                       fit: BoxFit.cover, height: 100.0, width: 100),
//                 ),
//               ),
//             );
//           }
//           if (state is FollowersClass) {
//             followersClassModel1 = state.followersClassModel;
//           }
//           if (state is FollowersClass1) {
//             followersClassModel2 = state.followersClassModel1;
//           }
//           if (state is DMChatListLoadedState) {
//             Navigator.push(context, MaterialPageRoute(builder: (context) {
//               return DmScreen(
//                 UserUID: "${NewProfileData?.object?.userUid}",
//                 UserName: "${NewProfileData?.object?.userName}",
//                 ChatInboxUid: state.DMChatList.object ?? "",
//                 UserImage: "${NewProfileData?.object?.userProfilePic}",
//               );
//             }));
//           }
//           if (state is NewProfileSLoadedState) {
//             industryTypesArray = "";
//             ExpertiseData = "";
//             NewProfileData = state.PublicRoomData;
//             print("i check accountTyp--${NewProfileData?.object?.accountType}");
//             isDataGet = true;
//             print(NewProfileData?.object?.module);
//             BlocProvider.of<NewProfileSCubit>(context)
//                 .GetAppPostAPI(context, "${NewProfileData?.object?.userUid}");

//             BlocProvider.of<NewProfileSCubit>(context)
//                 .GetSavePostAPI(context, "${NewProfileData?.object?.userUid}");

//             BlocProvider.of<NewProfileSCubit>(context).GetPostCommetAPI(
//                 context, "${NewProfileData?.object?.userUid}", "desc");
//             savedataFuntion(NewProfileData?.object?.userUid ?? '');

//             NewProfileData?.object?.industryTypes?.forEach((element) {
//               // industryTypesArray.add("${element.industryTypeName}");

//               if (industryTypesArray == "") {
//                 industryTypesArray =
//                     "${industryTypesArray}${element.industryTypeName}";
//               } else {
//                 industryTypesArray =
//                     "${industryTypesArray}, ${element.industryTypeName}";
//               }
//             });

//             NewProfileData?.object?.expertise?.forEach((element) {
//               if (ExpertiseData == "") {
//                 ExpertiseData = "${element.expertiseName}";
//               } else {
//                 ExpertiseData = "${element.expertiseName}";
//               }
//             });

//             // ExpertiseData

//             CompanyName.text = "${NewProfileData?.object?.companyName}";
//             jobprofileController.text = "${NewProfileData?.object?.jobProfile}";
//             IndustryType.text = industryTypesArray;

//             if (NewProfileData?.object?.userDocument != null) {
//               dopcument = NewProfileData?.object?.documentName;
//             } else {
//               dopcument = 'Upload Image';
//             }

//             priceContrller.text = "${NewProfileData?.object?.fees}";
//             Expertise.text = ExpertiseData;
//             if (state.PublicRoomData.object?.workingHours != null) {
//               workignStart = state.PublicRoomData.object?.workingHours
//                   .toString()
//                   .split(" to ")
//                   .first;

//               start = workignStart?.split(' ')[0];
//               startAm = workignStart?.split(' ')[1];
//               workignend = state.PublicRoomData.object?.workingHours
//                   .toString()
//                   .split(" to ")
//                   .last;
//               end = workignend?.split(' ')[0];
//               endAm = workignend?.split(' ')[1];
//             }
//           }
//           if (state is GetAppPostByUserLoadedState) {
//             print(state.GetAllPost);
//             GetAllPostData = state.GetAllPost;
//             UserProfilePostCount = GetAllPostData?.object?.length ?? 0;

//             if (UserProfilePostCount.isOdd) {
//               UserProfilePostCount = UserProfilePostCount + 1;
//               var PostCount = UserProfilePostCount / 2;
//               var aa = "${PostCount}";
//               print(
//                   "PostCountPostCountPostCountPostCountPostCountPostCountPostCountPostCountPostCount : 1 :- ${PostCount}  :::::- ${UserProfilePostCount}");
//               print("sadasdsadasdsadasdsadasdsadasdsadasd : ------> ${aa}");

//               int? y = int.parse(aa.split('.')[0]);
//               print("sadasdsadasdsadasdsadasdsadasdsadasd : ------> ${y}");
//               FinalPostCount = y;
//               UserProfilePostCount = UserProfilePostCount - 1;
//               print(
//                   "sadasdsadasdsadasdsadasdsadasdsadasd : ------> ${FinalPostCount}");
//             } else {
//               print(UserProfilePostCount);
//               var PostCount = UserProfilePostCount / 2;
//               print(
//                   "PostCountPostCountPostCountPostCountPostCountPostCountPostCountPostCountPostCount : 2 :- ${PostCount}  :::::- ${UserProfilePostCount}");
//               var aa = "${PostCount}";
//               print("sadasdsadasdsadasdsadasdsadasdsadasd : ------> ${aa}");

//               int? y = int.parse(aa.split('.')[0]);
//               print("sadasdsadasdsadasdsadasdsadasdsadasd : ------> ${y}");

//               FinalPostCount = y;
//               print(
//                   "sadasdsadasdsadasdsadasdsadasdsadasd : ------> ${FinalPostCount}");
//             }
//           }
//           if (state is GetUserPostCommetLoadedState) {
//             print(
//                 "Get Comment Get Comment Get Comment Get Comment Get Comment Get Comment Get Comment ");
//             print(state.GetUserPostCommet);
//             GetUserPostCommetData = state.GetUserPostCommet;
//             CommentsPostCount = GetUserPostCommetData?.object?.length ?? 0;
//           }
//           if (state is GetSavePostLoadedState) {
//             GetSavePostData = state.GetSavePost;
//             SavePostCount = GetSavePostData?.object?.length ?? 0;
//             if (SavePostCount.isOdd) {
//               SavePostCount = SavePostCount + 1;
//               var PostCount = SavePostCount / 2;
//               var aa = "${PostCount}";
//               int? y = int.parse(aa.split('.')[0]);
//               FinalSavePostCount = y;
//               SavePostCount = SavePostCount - 1;
//             } else {
//               var PostCount = SavePostCount / 2;
//               var aa = "${PostCount}";
//               int? y = int.parse(aa.split('.')[0]);
//               FinalSavePostCount = y;
//             }
//           }
//           if (state is AboutMeLoadedState) {
//             isAbourtMe = true;
//             isUpDate = false;
//             print("dfgsfgdsfg-${isAbourtMe}");
//             SnackBar snackBar = SnackBar(
//               content: Text('Saved Successfully'),
//               backgroundColor: ColorConstant.primary_color,
//             );
//             ScaffoldMessenger.of(context).showSnackBar(snackBar);
//           }
//           if (state is PostLikeLoadedState) {
//             BlocProvider.of<NewProfileSCubit>(context)
//                 .NewProfileSAPI(context, widget.User_ID);
//             if (state.likePost.object != 'Post Liked Successfully' &&
//                 state.likePost.object != 'Post Unliked Successfully') {
//               SnackBar snackBar = SnackBar(
//                 content: Text(state.likePost.object.toString()),
//                 backgroundColor: ColorConstant.primary_color,
//               );
//               ScaffoldMessenger.of(context).showSnackBar(snackBar);
//             }
//           }
//           if (state is GetWorkExpereinceLoadedState) {
//             addWorkExperienceModel = state.addWorkExperienceModel;
//           }
//           if (state is UserTagLoadedState) {
//             Navigator.push(context, MaterialPageRoute(builder: (context) {
//               return ProfileScreen(
//                   User_ID: "${state.userTagModel.object}", isFollowing: "");
//             }));

//             // print("tagName -- ${tagName}");
//             print("user id -- ${state.userTagModel..object}");
//           }
//           if (state is SearchHistoryDataAddxtends) {
//             searchUserForInbox1 = state.searchUserForInbox;

//             /*  isTagData = true;
//           isHeshTegData = false; */
//             searchUserForInbox1?.object?.content?.forEach((element) {
//               Map<String, dynamic> dataSetup = {
//                 'id': element.userUid,
//                 'display': element.userName,
//                 'photo': element.userProfilePic,
//               };

//               tageData.add(dataSetup);
//               List<Map<String, dynamic>> uniqueTageData = [];
//               Set<String> encounteredIds = Set<String>();
//               for (Map<String, dynamic> data in tageData) {
//                 if (!encounteredIds.contains(data['id'])) {
//                   // If the ID hasn't been encountered, add to the result list
//                   uniqueTageData.add(data);

//                   // Mark the ID as encountered
//                   encounteredIds.add(data['id']);
//                 }
//                 tageData = uniqueTageData;
//               }
//               if (tageData.isNotEmpty == true) {
//                 istageData = true;
//               }
//             });
//           }

//           if (state is GetAllHashtagState) {
//             getAllHashtag = state.getAllHashtag;

//             for (int i = 0;
//                 i < (getAllHashtag?.object?.content?.length ?? 0);
//                 i++) {
//               // getAllHashtag?.object?.content?[i].split('#').last;
//               Map<String, dynamic> dataSetup = {
//                 'id': '${i}',
//                 'display':
//                     '${getAllHashtag?.object?.content?[i].split('#').last}',
//                 'style': TextStyle(color: Colors.blue)
//               };
//               heshTageData.add(dataSetup);
//               if (heshTageData.isNotEmpty == true) {
//                 isHeshTegData = true;
//               }
//               print("check heshTageData -$heshTageData");
//             }
//           }
//         },
//         builder: (context, state) {
//           return NestedScrollView(
//             controller: _scrollController,
//             headerSliverBuilder: (context, value) {
//               return [
//                 SliverToBoxAdapter(child: _buildCarousel()),
//                 SliverToBoxAdapter(
//                   child: TabBar(

//                     controller: _tabController,
//                     labelColor: Colors.redAccent,
//                     isScrollable: true,
//                     tabs: myTabs,
//                   ),
//                 ),
//               ];
//             },
//             body: isDataGet == false
//                 ? Center(
//                     child: Container(
//                       margin: EdgeInsets.only(bottom: 100),
//                       child: ClipRRect(
//                         borderRadius: BorderRadius.circular(20),
//                         child: Image.asset(ImageConstant.loader,
//                             fit: BoxFit.cover, height: 100.0, width: 100),
//                       ),
//                     ),
//                   )
//                 : Container(
//                     child: TabBarView(
//                       controller: _tabController,
//                       children: [
//                         _buildTabContext(2),
//                         _buildTabContext(200),
//                         _buildTabContext(2)
//                       ],
//                     ),
//                   ),
//           );
//         },
//       ),
//     );
//   }
// }
