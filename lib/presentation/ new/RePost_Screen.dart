import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:any_link_preview/any_link_preview.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_mentions/flutter_mentions.dart';
import 'package:hashtagable/widgets/hashtag_text.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:linkfy_text/linkfy_text.dart';
import 'package:pds/API/Bloc/NewProfileScreen_Bloc/NewProfileScreen_cubit.dart';
import 'package:pds/API/Bloc/OpenSaveImagepost_Bloc/OpenSaveImagepost_cubit.dart';
import 'package:pds/API/Bloc/RePost_Bloc/RePost_cubit.dart';
import 'package:pds/API/Bloc/RePost_Bloc/RePost_state.dart';
import 'package:pds/API/Model/Add_PostModel/Add_postModel_Image.dart';
import 'package:pds/API/Model/GetGuestAllPostModel/GetGuestAllPost_Model.dart';
import 'package:pds/API/Model/HasTagModel/hasTagModel.dart';
import 'package:pds/API/Model/OpenSaveImagepostModel/OpenSaveImagepost_Model.dart';
import 'package:pds/API/Model/UserTagModel/UserTag_model.dart';
import 'package:pds/API/Model/serchForInboxModel/serchForinboxModel.dart';
import 'package:pds/core/utils/color_constant.dart';
import 'package:pds/core/utils/image_constant.dart';
import 'package:pds/core/utils/sharedPreferences.dart';
import 'package:pds/presentation/%20new/HashTagView_screen.dart';
import 'package:pds/presentation/%20new/newbottembar.dart';
import 'package:pds/presentation/%20new/profileNew.dart';
import 'package:pds/presentation/Create_Post_Screen/CreatePostShow_ImageRow/photo_gallery-master/example/lib/main.dart';
import 'package:pds/presentation/register_create_account_screen/register_create_account_screen.dart';
import 'package:pds/widgets/commentPdf.dart';
import 'package:pds/widgets/custom_image_view.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:video_player/video_player.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../API/Model/HashTage_Model/HashTagView_model.dart';
import '../../API/Model/NewProfileScreenModel/GetAppUserPost_Model.dart';
import '../../API/Model/NewProfileScreenModel/GetSavePost_Model.dart';
import '../Create_Post_Screen/CreatePostShow_ImageRow/photo_gallery-master/lib/photo_gallery.dart';
import 'home_screen_new.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
class RePostScreen extends StatefulWidget {
  String? username;
  List? postData;
  String? date;
  String? desc;
  String? userProfile;
  String? postDataType;
  int? index;
  String? postUid;
  GetGuestAllPostModel? AllGuestPostRoomData;
  HashtagViewDataModel? hashTagViewData;
  OpenSaveImagepostModel? OpenSaveModelData;
  String? thumbNailURL;
  GetSavePostModel? GetSavePostData;
  GetAppUserPostModel? GetAllPostData;


  RePostScreen({Key? key, this.username, this.postData, this.date, this.desc, this.userProfile, this.postDataType, this.index, this.AllGuestPostRoomData, this.postUid, this.hashTagViewData, this.OpenSaveModelData, this.thumbNailURL, this.GetSavePostData, this.GetAllPostData}) : super(key: key);

  @override
  State<RePostScreen> createState() => _RePostScreenState();
}

class _RePostScreenState extends State<RePostScreen> {
  getDocumentSize() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    documentuploadsize = await double.parse(prefs.getString(PreferencesKey.MaxPostUploadSizeInMB) ?? "0");

    finalFileSize = documentuploadsize;
    super.setState(() {});
  }
  String title = "";

  bool? readmoree;
  int maxLength = 60;

  @override
  void initState() {
    print("check Viedo Formated-${widget.postDataType}");
    _loading = true;
    getDocumentSize();
    initAsync();
    Future.delayed(Duration(milliseconds: 150), () {
      if (mounted) {
        super.setState(() {
          _opacity = 1.0;
        });
      }
    });
    if ((widget.desc?.length ?? 0) <= 60) {
      readmoree = true;
    } else if ((widget.desc?.length ??
        0) <=
        60) {
      readmoree = true;
    } else {
      readmoree = false;
    }
    GetUserData();
    super.initState();
  }

  List<String> postTexContrlloer = [];

  ImagePicker _imagePicker = ImagePicker();
  List<File> pickedImage = [];
  double value2 = 0.0;
  double documentuploadsize = 0;
  PlatformFile? file12;
  double finalFileSize = 0;
  File? file;
  Medium? medium1;
  bool selectImage = false;
  MediaPage? page;
  bool _loading = false;
  int _currentPages = 0;
  XFile? pickedFile;
  PageController _pageControllers = PageController();
  bool isTrue = false;
  Color primaryColor = ColorConstant.primaryLight_color;
  Color textColor = ColorConstant.primary_color;
  TextEditingController postText1 = TextEditingController();
  List<String> soicalData = ["Follower", "Public"];
  int indexx = 0;
  String? User_ID;
  bool CreatePostDone = true;
  List<String>? HasetagList = [];
  List<int> currentPages = [];
  List<PageController> pageControllers = [];
  bool added = false;
  List<Album>? _albums;
  double _opacity = 0.0;
  ImageDataPost? imageDataPost;
  String? UserProfileImage;
  SearchUserForInbox? searchUserForInbox1;
  HasDataModel? getAllHashtag;
  bool isVideodata = false;
  List<Map<String, dynamic>> tageData = [];
  List<Map<String, dynamic>> heshTageData = [];
  VideoPlayerController? _controller;
  bool istageData = false;
  bool isrepostDataSet = true;
  bool isHeshTegData = false;
  UserTagModel? userTagModel;

  List<File> galleryFile = [];
  VideoPlayerController? _controllersRepost;

  GetUserData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    User_ID = prefs.getString(PreferencesKey.loginUserID);
    UserProfileImage = prefs.getString(PreferencesKey.UserProfile);
  }

  @override
  Widget build(BuildContext context) {
    var _height = MediaQuery.of(context).size.height;
    var _width = MediaQuery.of(context).size.width;
    DateTime parsedDateTime = DateTime.parse('${widget.date}');

    if (!added) {
      widget.AllGuestPostRoomData?.object?.content?.forEach((element) {
        pageControllers.add(PageController());
        currentPages.add(0);
      });
      widget.hashTagViewData?.object?.posts?.forEach((element) {
        pageControllers.add(PageController());
        currentPages.add(0);
      });
      widget.GetSavePostData?.object?.forEach((element) {
        pageControllers.add(PageController());
        currentPages.add(0);
      });
      widget.GetAllPostData?.object?.forEach((element) {
        pageControllers.add(PageController());
        currentPages.add(0);
      });
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) => super.setState(() {
            added = true;
          }));
    }
    return BlocConsumer<RePostCubit, RePostState>(listener: (context, state) async {
      if (state is AddPostImaegState) {
        imageDataPost = state.imageDataPost;
        if (state.imageDataPost.object?.status == 'failed') {
          isTrue = true;
          imageDataPost?.object?.data = null;
        } else {
          isTrue = true;

          print("imageDataPost-->${imageDataPost?.object?.data}");
        }

        if (imageDataPost?.object?.data?.isNotEmpty == true) {
          if (imageDataPost!.object!.data!.first.endsWith('.mp4')) {
            isVideodata = true;
          }
        }
        if (isVideodata == true) {
          print("this condison is working");
          _controller = VideoPlayerController.networkUrl(Uri.parse('${imageDataPost!.object!.data!.first}'));
          _controller?.initialize().then((value) => super.setState(() {}));
          super.setState(() {
            _controller?.play();
            _controller?.setLooping(true);
          });
        }
        // if (widget.postDataType == "VIDEO") {
        //   for (int i = 0; i < widget.postData!.length; i++) {
        //     _controllersRepost = VideoPlayerController.networkUrl(
        //         Uri.parse('${widget.postData?[i]}'));
        //     print("video list -- ${widget.postData}");
        //     _controllersRepost?.initialize().then((value) => super.setState(() {}));
        //     super.setState(() {
        //       _controllersRepost?.play();
        //       _controllersRepost?.pause();
        //       _controllersRepost?.setLooping(true);
        //     });
        //   }
        // }
      }
      if (state is UserTagSaveLoadedState) {
        userTagModel = await state.userTagModel;
      }
      if (state is SearchHistoryDataAddxtends) {
        searchUserForInbox1 = state.searchUserForInbox;
        searchUserForInbox1?.object?.content?.forEach((element) {
          Map<String, dynamic> dataSetup = {'id': element.userUid, 'display': element.userName, 'photo': element.userProfilePic};

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
        for (int i = 0; i < (getAllHashtag?.object?.content?.length ?? 0); i++) {
          // getAllHashtag?.object?.content?[i].split('#').last;
          Map<String, dynamic> dataSetup = {
            'id': '${i}',
            'display': '${getAllHashtag?.object?.content?[i].split('#').last}',
          };
          heshTageData.add(dataSetup);
          if (heshTageData.isNotEmpty == true) {
            isHeshTegData = true;
          }
        }
      }
      if (state is RePostLoadedState) {
        isrepostDataSet = true;
        print("lodedSate-->");
        SnackBar snackBar = SnackBar(
          content: Text(state.RePost.object.toString()),
          backgroundColor: ColorConstant.primary_color,
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
          builder: (context) {
            return NewBottomBar(
              buttomIndex: 0,
            );
          },
        ), (Route<dynamic> route) => false);
      }
    }, builder: (context, state) {
      return SafeArea(
          child: Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          color: Colors.white,
          child: Stack(
            children: [
              SingleChildScrollView(
                child: Container(
                  color: Colors.white,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 16, right: 16),
                        child: Container(
                          height: 70,
                          width: _width,
                          child: Row(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: Image.asset(
                                  ImageConstant.Post_Close,
                                  height: 20,
                                ),
                              ),
                              Spacer(),
                              GestureDetector(
                                onTap: () {
                                  HasetagList = [];
                                  CreatePostDone = true;
                                  if (isrepostDataSet == true) {
                                    dataPostFucntion();
                                  }
                                },
                                child: Container(
                                  decoration: BoxDecoration(color: primaryColor, borderRadius: BorderRadius.circular(14)),
                                  height: 40,
                                  width: 80,
                                  child: Center(
                                      child: Text(
                                    "RePost",
                                    style: TextStyle(
                                      fontFamily: "outfit",
                                      fontSize: 15,
                                      color: textColor,
                                    ),
                                  )),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 16, right: 16),
                        child: Row(
                          children: [
                            Container(
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                                    return MultiBlocProvider(
                                        providers: [
                                          BlocProvider<NewProfileSCubit>(
                                            create: (context) => NewProfileSCubit(),
                                          ),
                                        ],
                                        child: ProfileScreen(
                                          User_ID: "${User_ID}",
                                          isFollowing: 'FOLLOW',
                                        ));
                                  }));
                                },
                                child: UserProfileImage?.isEmpty == true
                                    ? SizedBox(
                                        height: 50,
                                        width: 50,
                                        child: CircleAvatar(
                                          backgroundColor: Colors.white,
                                          backgroundImage: AssetImage(ImageConstant.tomcruse),
                                        ),
                                      )
                                    : SizedBox(
                                        height: 50,
                                        width: 50,
                                        child: CircleAvatar(
                                          backgroundColor: Colors.white,
                                          backgroundImage: NetworkImage(UserProfileImage.toString()),
                                        ),
                                      ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(bottom: 15, left: 10),
                              child: GestureDetector(
                                onTapDown: (TapDownDetails details) {
                                  _showPopupMenu(
                                    details.globalPosition,
                                    context,
                                  );
                                },
                                child: Container(
                                  height: 30,
                                  width: _width / 2.5,
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                        width: 1.5,
                                        color: ColorConstant.primary_color,
                                      ),
                                      color: ColorConstant.primaryLight_color,
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Row(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(left: 7),
                                        child: Center(
                                          child: Text(
                                            soicalData[indexx].toString(),
                                            style: TextStyle(
                                              fontFamily: "outfit",
                                              fontSize: 15,
                                              color: ColorConstant.primary_color,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Spacer(),
                                      Padding(
                                        padding: EdgeInsets.only(right: 7),
                                        child: Image.asset(
                                          ImageConstant.downarrow,
                                          color: ColorConstant.primary_color,
                                          height: 10,
                                          width: 10,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      SingleChildScrollView(
                        child: Padding(
                          padding: EdgeInsets.only(left: 16, right: 16, top: 15),
                          child: SizedBox(
                            width: _width,
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 80,
                                  child: FlutterMentions(
                                    onChanged: (value) {
                                      onChangeMethod(value);
                                    },
                                    suggestionPosition: SuggestionPosition.values.last,
                                    maxLines: 10,
                                    decoration: InputDecoration(
                                      hintText: 'What’s on your head?',
                                      border: InputBorder.none,
                                      focusedBorder: InputBorder.none,
                                    ),
                                    mentions: [
                                      Mention(
                                          trigger: "@",
                                          style: TextStyle(color: Colors.blue),
                                          data: tageData,
                                          matchAll: true,
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
                                          matchAll: true,
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
                                            print("suggestionBuilder-$tageData");
                                            return Container(
                                              color: Colors.amber,
                                            );
                                          }),
                                    ],
                                  ),
                                ),
                                if(title.isNotEmpty)
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                                    child: AnyLinkPreview(
                                      link: title,
                                      displayDirection: UIDirection.uiDirectionHorizontal,
                                      showMultimedia: true,
                                      bodyMaxLines: 5,
                                      bodyTextOverflow: TextOverflow.ellipsis,
                                      titleStyle: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15,
                                      ),
                                      bodyStyle: TextStyle(color: Colors.grey, fontSize: 12),
                                      errorBody: 'Show my custom error body',
                                      errorTitle: 'Show my custom error title',
                                      errorWidget: Container(
                                        color: Colors.grey[300],
                                        child: Text('Oops!'),
                                      ),
                                      errorImage: "https://flutter.dev/",
                                      cache: Duration(days: 7),
                                      backgroundColor: Colors.grey[300],
                                      borderRadius: 12,
                                      removeElevation: false,
                                      boxShadow: [BoxShadow(blurRadius: 3, color: Colors.grey)],
                                      onTap: (){
                                        launchUrl(Uri.parse(title));
                                      }, // This disables tap event
                                    ),
                                  ),
                                /*  Padding(
                                      padding: EdgeInsets.only(top: 0.0, left: 10),
                                      child: TextFormField(
                                        controller: postText1,
                                        maxLines: null,
                                        cursorColor: Colors.grey,
                                        decoration: InputDecoration(
                                          hintText: "What's on your head?",
                                          border: InputBorder.none,
                                        ),
                                        inputFormatters: [
                                          // Custom formatter to trim leading spaces
                                          TextInputFormatter.withFunction(
                                              (oldValue, newValue) {
                                            if (newValue.text.startsWith(' ')) {
                                              return TextEditingValue(
                                                text: newValue.text.trimLeft(),
                                                selection: TextSelection.collapsed(
                                                    offset: newValue.text
                                                        .trimLeft()
                                                        .length),
                                              );
                                            }
                                            return newValue;
                                          }),
                                        ],
                                        onChanged: (value) {
                                          onChangeMethod(value);
                                          super.setState(() {
                                            primaryColor = value.isNotEmpty
                                                ? ColorConstant.primary_color
                                                : ColorConstant.primaryLight_color;
                                            textColor = value.isNotEmpty
                                                ? Colors.white
                                                : ColorConstant.primary_color;
                                          });
                                        },
                                      ),
                                    ), */
                                Padding(
                                  padding: const EdgeInsets.only(top: 5),
                                  child: SizedBox(
                                    child: isVideodata == true
                                        ? _controller!.value.isInitialized
                                            ? Container(
                                                // color: Colors.amber,
                                                height: _height / 3.5,
                                                child: Column(
                                                  children: [
                                                    AspectRatio(
                                                      aspectRatio: _controller!.value.aspectRatio,
                                                      child: VideoPlayer(_controller!),
                                                    ),
                                                    // GestureDetector(
                                                    //   onTap: () {
                                                    //     if (_controller!.value
                                                    //         .isPlaying) {
                                                    //       super.setState(() {
                                                    //         _controller
                                                    //             ?.pause();
                                                    //       });
                                                    //     } else {
                                                    //       super.setState(() {
                                                    //         _controller
                                                    //             ?.play();
                                                    //       });
                                                    //     }
                                                    //   },
                                                    //   child: Icon(
                                                    //     _controller!.value
                                                    //             .isPlaying
                                                    //         ? Icons.pause
                                                    //         : Icons
                                                    //             .play_arrow,
                                                    //   ),
                                                    // ),
                                                  ],
                                                ),
                                              )
                                            : Container()
                                        : file12?.path != null
                                            ? Container(
                                                height: 400,
                                                width: _width,
                                                child: DocumentViewScreen1(
                                                  path: imageDataPost?.object?.data?.first.toString(),
                                                ))
                                            : pickedImage.isNotEmpty
                                                ? _loading
                                                    ? Center(
                                                        child: Container(
                                                          margin: EdgeInsets.only(bottom: 100),
                                                          child: ClipRRect(
                                                            borderRadius: BorderRadius.circular(20),
                                                            child: Image.asset(ImageConstant.loader, fit: BoxFit.cover, height: 100, width: 100),
                                                          ),
                                                        ),
                                                      )
                                                    : isTrue == true
                                                        ? imageDataPost?.object?.data != null
                                                            ? SizedBox(
                                                                height: _height / 1.5,
                                                                width: _width,
                                                                child: PageView.builder(
                                                                  onPageChanged: (value) {
                                                                    super.setState(() {
                                                                      _currentPages = value;
                                                                    });
                                                                  },
                                                                  itemCount: imageDataPost?.object?.data?.length,
                                                                  controller: _pageControllers,
                                                                  itemBuilder: (context, index) {
                                                                    return SizedBox(
                                                                        height: _height / 2,
                                                                        width: _width,
                                                                        child: Padding(
                                                                          padding: const EdgeInsets.all(8.0),
                                                                          child: CachedNetworkImage(
                                                                            imageUrl: '${imageDataPost?.object?.data?[index]}',
                                                                          ),
                                                                        ));
                                                                  },
                                                                ),
                                                              )
                                                            : Container()
                                                        : SizedBox() /* Center(
                                                            child: GFLoader(
                                                                type: GFLoaderType
                                                                    .ios),
                                                          ) */
                                                : selectImage == true
                                                    ? medium1?.mediumType == MediumType.image
                                                        ? GestureDetector(
                                                            onTap: () async {
                                                              print("fgfgfhg");
                                                            },
                                                            child: FadeInImage(
                                                              fit: BoxFit.cover,
                                                              placeholder: MemoryImage(kTransparentImage),
                                                              image: PhotoProvider(mediumId: medium1!.id),
                                                            ),
                                                          )
                                                        : VideoProvider(
                                                            mediumId: medium1!.id,
                                                          )
                                                    : Container(
                                                        color: Colors.white,
                                                      ),
                                  ),
                                ),
                                imageDataPost?.object?.data != null && imageDataPost?.object?.data?.length != 1
                                    ? Container(
                                        height: 20,
                                        child: DotsIndicator(
                                          dotsCount: imageDataPost?.object?.data?.length ?? 0,
                                          position: _currentPages.toDouble(),
                                          decorator: DotsDecorator(
                                            size: const Size(10.0, 7.0),
                                            activeSize: const Size(10.0, 10.0),
                                            spacing: const EdgeInsets.symmetric(horizontal: 2),
                                            activeColor: ColorConstant.primary_color,
                                            color: Color(0xff6A6A6A),
                                          ),
                                        ),
                                      )
                                    : SizedBox(),
                                Padding(
                                  padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10, top: 20),
                                  child: Container(
                                    decoration: BoxDecoration(color: Colors.white, border: Border.all(color: Color.fromRGBO(0, 0, 0, 0.25)), borderRadius: BorderRadius.circular(15)),
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
                                              onTap: () {
                                                // if (uuid == null) {
                                                //   Navigator.of(context).push(
                                                //       MaterialPageRoute(
                                                //           builder:
                                                //               (context) =>
                                                //                   RegisterCreateAccountScreen()));
                                                // } else {
                                                //   Navigator.push(context,
                                                //       MaterialPageRoute(
                                                //           builder:
                                                //               (context) {
                                                //     return ProfileScreen(
                                                //         User_ID:
                                                //             "${AllGuestPostRoomData?.object?.content?[index].userUid}",
                                                //         isFollowing:
                                                //             AllGuestPostRoomData
                                                //                 ?.object
                                                //                 ?.content?[
                                                //                     index]
                                                //                 .isFollowing);
                                                //   }));
                                                // }
                                              },
                                              child: widget.userProfile != null
                                                  ? CircleAvatar(
                                                      backgroundColor: Colors.white,
                                                      backgroundImage: NetworkImage("${widget.userProfile}"),
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
                                                Container(
                                                  child: Text(
                                                    "${widget.username}",
                                                    style: TextStyle(fontSize: 20, fontFamily: "outfit", fontWeight: FontWeight.bold),
                                                  ),
                                                ),
                                                Text(
                                                  customFormat(parsedDateTime),
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
                                        widget.desc != null
                                            ? Padding(
                                                padding: const EdgeInsets.only(left: 16),
                                                child: Column(
                                                  children: [
                                                    LinkifyText(
                                                      readmoree == true
                                                          ?  "${widget.desc ?? ""}${(widget.desc?.length ?? 0) > maxLength ? ' ...ReadLess' : ''}"

                                                          :  "${widget.desc?.substring(0, maxLength)} ...ReadMore ",

                                                      // opem save post image
                                                      linkStyle: TextStyle(
                                                        color: Colors.blue,
                                                        fontFamily: 'outfit',
                                                      ),
                                                      textStyle: TextStyle(
                                                        color: Colors.white,
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
                                                        if ((widget.desc?.length ?? 0) > maxLength) {
                                                          setState(() {
                                                            if (readmoree == true) {
                                                              readmoree = false;
                                                              print("--------------false ");
                                                            } else {
                                                              readmoree = true;
                                                              print("-------------- true");
                                                            }
                                                          });
                                                        }
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
                                                              if (isYouTubeUrl(SelectedTest)) {
                                                                playLink(SelectedTest, context);
                                                              } else
                                                                launchUrl(Uri.parse("https://${link.value.toString()}"));
                                                            } else {
                                                              if (Link6 == true) {
                                                                print("yes i am in room");
                                                                Navigator.push(context, MaterialPageRoute(
                                                                  builder: (context) {
                                                                    return NewBottomBar(
                                                                      buttomIndex: 1,
                                                                    );
                                                                  },
                                                                ));
                                                              } else {
                                                                if (isYouTubeUrl(SelectedTest)) {
                                                                  playLink(SelectedTest, context);
                                                                } else
                                                                  launchUrl(Uri.parse(link.value.toString()));
                                                                print("link.valuelink.value -- ${link.value}");
                                                              }
                                                            }
                                                          } else {
                                                            if (link.value!.startsWith('#')) {
                                                              print("${link}");
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
                                                              await BlocProvider.of<OpenSaveCubit>(context).UserTagAPI(context, tagName);

                                                              Navigator.push(context, MaterialPageRoute(builder: (context) {
                                                                return ProfileScreen(User_ID: "${userTagModel?.object}", isFollowing: "");
                                                              }));

                                                              print("tagName -- ${tagName}");
                                                              print("user id -- ${userTagModel?.object}");
                                                            } else {
                                                              // launchUrl(Uri.parse(
                                                              //     "https://${link.value.toString()}"));
                                                            }
                                                          }
                                                        }
                                                      },
                                                    ),
                                                    if (extractUrls(widget.desc ?? "").isNotEmpty)
                                                      isYouTubeUrl(extractUrls(widget.desc ?? "").first)
                                                          ? FutureBuilder(
                                                              future: fetchYoutubeThumbnail(extractUrls(widget.desc ?? "").first),
                                                              builder: (context, snap) {
                                                                return Container(
                                                                  height: 200,
                                                                  decoration: BoxDecoration(image: DecorationImage(image: CachedNetworkImageProvider(snap.data.toString())), borderRadius: BorderRadius.circular(10)),
                                                                  clipBehavior: Clip.antiAlias,
                                                                  child: Center(
                                                                      child: IconButton(
                                                                    icon: Icon(
                                                                      Icons.play_circle_fill_rounded,
                                                                      color: Colors.white,
                                                                      size: 60,
                                                                    ),
                                                                    onPressed: () {
                                                                      playLink(extractUrls(widget.desc ?? "").first, context);
                                                                    },
                                                                  )),
                                                                );
                                                              })
                                                          : Padding(
                                                              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                                                              child: AnyLinkPreview(
                                                                link: extractUrls(widget.desc ?? "").first,
                                                                displayDirection: UIDirection.uiDirectionHorizontal,
                                                                showMultimedia: true,
                                                                bodyMaxLines: 5,
                                                                bodyTextOverflow: TextOverflow.ellipsis,
                                                                titleStyle: TextStyle(
                                                                  color: Colors.black,
                                                                  fontWeight: FontWeight.bold,
                                                                  fontSize: 15,
                                                                ),
                                                                bodyStyle: TextStyle(color: Colors.grey, fontSize: 12),
                                                                errorBody: 'Show my custom error body',
                                                                errorTitle: 'Show my custom error title',
                                                                errorWidget: null,
                                                                errorImage: "https://flutter.dev/",
                                                                cache: Duration(days: 7),
                                                                backgroundColor: Colors.grey[300],
                                                                borderRadius: 12,
                                                                removeElevation: false,
                                                                boxShadow: [BoxShadow(blurRadius: 3, color: Colors.grey)],
                                                                onTap: () {
                                                                  launchUrl(Uri.parse(extractUrls(widget.desc ?? "").first));
                                                                }, // This disables tap event
                                                              ),
                                                            ),
                                                  ],
                                                ),
                                              )
                                            : SizedBox(),
                                        GestureDetector(
                                          onTap: () {
                                            // Navigator.push(
                                            //   context,
                                            //   MaterialPageRoute(
                                            //       builder: (context) =>
                                            //           OpenSavePostImage(
                                            //             PostID:
                                            //                 AllGuestPostRoomData
                                            //                     ?.object
                                            //                     ?.content?[
                                            //                         index]
                                            //                     .postUid,
                                            //           )),
                                            // );
                                          },
                                          child: widget.postDataType == 'VIDEO'
                                              ? Padding(
                                                  padding: const EdgeInsets.all(20),
                                                  child: VideoListItem(videoUrl: widget.postData?[0]),
                                                )
                                              : Container(
                                                  width: _width,
                                                  child: widget.postDataType == null
                                                      ? SizedBox()
                                                      : widget.postData?.length == 1
                                                          ? widget.postDataType == "IMAGE"
                                                              ? Container(
                                                                  width: _width,
                                                                  height: 150,
                                                                  margin: EdgeInsets.only(left: 16, top: 15, right: 16),
                                                                  child: Center(
                                                                      child: CustomImageView(
                                                                    url: "${widget.postData?[0]}",
                                                                  )),
                                                                )
                                                              // : widget.postDataType ==
                                                              //         "VIDEO"
                                                              //     ? _controllersRepost!
                                                              //             .value
                                                              //             .isInitialized
                                                              //         ? Padding(
                                                              //             padding: const EdgeInsets
                                                              //                     .only(
                                                              //                 left:
                                                              //                     15,
                                                              //                 right:
                                                              //                     15,
                                                              //                 top:
                                                              //                     15),
                                                              //             child:
                                                              //                 Container(
                                                              //               height:
                                                              //                   200,
                                                              //               child:
                                                              //                   Stack(
                                                              //                 children: [
                                                              //                   AspectRatio(
                                                              //                     aspectRatio:
                                                              //                         _controllersRepost!.value.aspectRatio,
                                                              //                     child:
                                                              //                         VideoPlayer(_controllersRepost!),
                                                              //                   ),
                                                              //                   Positioned(
                                                              //                     right:
                                                              //                         0,
                                                              //                     bottom:
                                                              //                         0,
                                                              //                     child:
                                                              //                         IconButton(
                                                              //                       color: ColorConstant.primary_color,
                                                              //                       icon: Icon(
                                                              //                         /*  _isFullScreen ? Icons.fullscreen_exit : */ Icons.fullscreen,
                                                              //                       ),
                                                              //                       onPressed: () {
                                                              //                         Navigator.push(context, MaterialPageRoute(
                                                              //                           builder: (context) {
                                                              //                             return VideoFullScreen(
                                                              //                               postData: widget.postData?[0],
                                                              //                             );
                                                              //                           },
                                                              //                         ));
                                                              //                       }, /* _toggleFullScreen */
                                                              //                     ),
                                                              //                   ),
                                                              //                   Positioned
                                                              //                       .fill(
                                                              //                     child:
                                                              //                         GestureDetector(
                                                              //                       onTap: () {
                                                              //                         // _playPause(index);
                                                              //                         if (_controllersRepost!.value.isPlaying) {
                                                              //                           super.setState(() {
                                                              //                             _controllersRepost!.pause();
                                                              //                           });
                                                              //                         } else {
                                                              //                           super.setState(() {
                                                              //                             _controllersRepost!.play();
                                                              //                           });
                                                              //                         }
                                                              //                       },
                                                              //                       child: _controllersRepost!.value.isPlaying
                                                              //                           ? Icon(
                                                              //                               Icons.pause_circle_outline,
                                                              //                               size: 50,
                                                              //                               color: Colors.white,
                                                              //                             )
                                                              //                           : Icon(
                                                              //                               Icons.play_circle_outline,
                                                              //                               size: 50,
                                                              //                               color: Colors.white,
                                                              //                             ),
                                                              //                     ),
                                                              //                   ),
                                                              //                 ],
                                                              //               ),
                                                              //             ),
                                                              //           )
                                                              //         : SizedBox()
                                                              : widget.postDataType == "ATTACHMENT"
                                                                  ? /*  Container(
                                                                      height:
                                                                          400,
                                                                      width:
                                                                          _width,
                                                                      child:
                                                                          DocumentViewScreen1(
                                                                        path: widget
                                                                            .postData?[0],
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
                                                                                  path: widget.postData?[0].toString(),
                                                                                );
                                                                              },
                                                                            ));
                                                                          },
                                                                          child: Container(
                                                                            child: CachedNetworkImage(
                                                                              imageUrl: widget.thumbNailURL ?? "",
                                                                              fit: BoxFit.cover,
                                                                            ),
                                                                          ),
                                                                        )
                                                                      ],
                                                                    )
                                                                  : SizedBox()
                                                          : Column(
                                                              children: [
                                                                Stack(
                                                                  children: [
                                                                    if ((widget.postData?.isNotEmpty ?? false)) ...[
                                                                      SizedBox(
                                                                        height: 300,
                                                                        child: PageView.builder(
                                                                          onPageChanged: (page) {
                                                                            super.setState(() {
                                                                              currentPages[widget.index ?? 0] = page;
                                                                            });
                                                                          },
                                                                          controller: pageControllers[widget.index ?? 0],
                                                                          itemCount: widget.postData?.length,
                                                                          itemBuilder: (BuildContext context, int index1) {
                                                                            if (widget.postDataType == "IMAGE") {
                                                                              return Container(
                                                                                width: _width,
                                                                                margin: EdgeInsets.only(left: 16, top: 15, right: 16),
                                                                                child: Center(
                                                                                    child: CustomImageView(
                                                                                  url: "${widget.postData?[index1]}",
                                                                                )),
                                                                              );
                                                                            } else if (widget.postDataType == "ATTACHMENT") {
                                                                              return Container(
                                                                                  height: 400,
                                                                                  width: _width,
                                                                                  child: DocumentViewScreen1(
                                                                                    path: widget.postData?[index1].toString(),
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
                                                                                dotsCount: widget.postData?.length ?? 1,
                                                                                position: currentPages[widget.index ?? 0].toDouble(),
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
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              if (widget.postDataType != 'VIDEO')
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Column(
                    children: [
                      Spacer(),
                      Padding(
                        padding: EdgeInsets.only(left: 16, right: 0),
                        child: Container(
                          color: Colors.white,
                          child: Row(
                            children: [
                              SizedBox(
                                // margin: EdgeInsets.all(8),
                                height: 90,
                                width: 90,
                                child: Center(
                                  child: GestureDetector(
                                    onTap: () async {
                                      print("asdfdfgdfg");
                                      _getImageFromCamera();
                                    },
                                    child: Container(
                                      // margin: EdgeInsets.all(8),
                                      height: 80,
                                      width: 80,
                                      decoration: BoxDecoration(
                                        // color: Color.fromARGB(255, 0, 0, 0),
                                        border: Border.all(color: Color.fromARGB(255, 174, 174, 174), width: 2),
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: Center(
                                        child: Image.asset(
                                          ImageConstant.Cameraicon,
                                          color: ColorConstant.primary_color,
                                          height: 30,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                height: 90,
                                width: _width - 106,
                                // color: Colors.green,
                                child: _loading
                                    ? Center(
                                        child: Container(
                                          margin: EdgeInsets.only(bottom: 100),
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.circular(20),
                                            child: Image.asset(ImageConstant.loader, fit: BoxFit.cover, height: 100, width: 100),
                                          ),
                                        ),
                                      )
                                    : LayoutBuilder(
                                        builder: (context, constraints) {
                                          double gridWidth = (constraints.maxWidth - 20) / 3;
                                          double gridHeight = gridWidth + 33;
                                          double ratio = gridWidth / gridHeight;
                                          return Padding(
                                            padding: const EdgeInsets.only(top: 5, bottom: 5),
                                            child: Container(
                                              // padding: EdgeInsets.all(5),
                                              child: SizedBox(
                                                height: 100,
                                                child: GridView.count(
                                                  crossAxisCount: 1,
                                                  mainAxisSpacing: 5.0,
                                                  crossAxisSpacing: 10.0,
                                                  scrollDirection: Axis.horizontal,
                                                  children: <Widget>[
                                                    ...page!.items.map(
                                                      (medium) => GestureDetector(
                                                        onTap: () async {
                                                          medium1 = medium;
                                                          selectImage = true;

                                                          file = await PhotoGallery.getFile(
                                                            mediumId: medium1!.id,
                                                            mediumType: MediumType.image,
                                                          );
                                                          file12 = null;
                                                          pickedImage.isEmpty;
                                                          super.setState(() {});
                                                          print("medium1!.id--.${medium1?.filename}");
                                                          BlocProvider.of<RePostCubit>(context).UplodeImageAPI(context, medium1?.filename ?? '', file?.path ?? '');
                                                        },
                                                        child: Container(
                                                          height: 100,
                                                          width: 100,
                                                          decoration: BoxDecoration(color: Colors.grey[300], borderRadius: BorderRadius.circular(10)),
                                                          child: ClipRRect(
                                                            borderRadius: BorderRadius.circular(10),
                                                            child: FadeInImage(
                                                              fit: BoxFit.cover,
                                                              placeholder: MemoryImage(kTransparentImage),
                                                              image: ThumbnailProvider(
                                                                mediumId: medium.id,
                                                                mediumType: medium.mediumType,
                                                                highQuality: true,
                                                              ),
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
                              ),
                            ],
                          ),
                        ),
                      ),
                      if (widget.postDataType != 'VIDEO')
                        Container(
                          height: 30,
                          color: Colors.white,
                          child: Padding(
                            padding: EdgeInsets.only(left: 20, right: 16),
                            child: Row(
                              children: [
                                GestureDetector(
                                  onTap: () async {
                                    prepareTestPdf(0);
                                  },
                                  child: Image.asset(
                                    ImageConstant.aTTACHMENT,
                                    color: ColorConstant.primary_color,
                                    height: 20,
                                  ),
                                ),
                                SizedBox(
                                  width: 30,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    _getImageFromSource();
                                  },
                                  child: Image.asset(
                                    ImageConstant.gallery,
                                    color: ColorConstant.primary_color,
                                    height: 20,
                                  ),
                                ),
                                SizedBox(
                                  width: 30,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    getVideo();
                                  },
                                  child: Icon(
                                    Icons.play_circle_outline_sharp,
                                    color: ColorConstant.primary_color,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                    ],
                  ),
                )
            ],
          ),
        ),
      ));
    });
  }

  Future<void> _getImageFromSource() async {
    try {
      final pickedFile = await _imagePicker.pickMultiImage();
      List<XFile> xFilePicker = pickedFile;

      if (xFilePicker.isNotEmpty) {
        if (xFilePicker.length <= 5) {
          for (var i = 0; i < xFilePicker.length; i++) {
            if (!_isGifOrSvg(xFilePicker[i].path)) {
              pickedImage.add(File(xFilePicker[i].path));
              super.setState(() {});
              getFileSize1(pickedImage[i].path, 1, pickedImage[i], 0);
              if ((xFilePicker[i].path.contains(".mp4")) || (xFilePicker[i].path.contains(".mov")) || (xFilePicker[i].path.contains(".mp3")) || (xFilePicker[i].path.contains(".m4a"))) {
                showDialog(
                  context: context,
                  builder: (ctx) => AlertDialog(
                    title: Text(
                      "Selected File Error",
                      textScaleFactor: 1.0,
                    ),
                    content: Text(
                      "Only PNG, JPG Supported.",
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
              }
            }
            print("xFilePickerxFilePicker - ${xFilePicker[i].path}");
          }
        } else {
          SnackBar snackBar = SnackBar(
            content: Text('Max 5 Images upload allowed !'),
            backgroundColor: ColorConstant.primary_color,
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
      } else {}
    } catch (e) {}
  }

  String customFormat(DateTime date) {
    String day = date.day.toString();
    // String month = _getMonthName(date.month);
    String year = date.year.toString();
    String time = DateFormat('h:mm a').format(date);

    String formattedDate = '$time';
    return formattedDate;
  }

  bool _isGifOrSvg(String imagePath) {
    // Check if the image file has a .gif or .svg extension
    final lowerCaseImagePath = imagePath.toLowerCase();
    return lowerCaseImagePath.endsWith('.gif') || lowerCaseImagePath.endsWith('.svg') || lowerCaseImagePath.endsWith('.pdf') || lowerCaseImagePath.endsWith('.doc') || lowerCaseImagePath.endsWith('.mp4') || lowerCaseImagePath.endsWith('.mov') || lowerCaseImagePath.endsWith('.mp3') || lowerCaseImagePath.endsWith('.m4a');
  }

  getFileSize1(String filepath, int decimals, File file1, int Index) async {
    var file = File(filepath);
    int bytes = await file.length();
    if (bytes <= 0) return "0 B";
    const suffixes = ["B", "KB", "MB", "GB", "TB", "PB", "EB", "ZB", "YB"];
    var i = (log(bytes) / log(1024)).floor();
    var STR = ((bytes / pow(1024, i)).toStringAsFixed(decimals));
    print('getFileSizevariable-${file1.path}');
    value2 = double.parse(STR);
    print(file1);
    print(value2);
    switch (i) {
      case 0:
        print("Done file size B");

        print('xfjsdjfjfilenamecheckKB-${file1.path}');

        break;
      case 1:
        print("Done file size KB");

        print('filenamecheckKB-${file1.path}');
        BlocProvider.of<RePostCubit>(context).UplodeImageAPIImane(
          context,
          pickedImage,
        );
        super.setState(() {});

        break;
      case 2:
        if (value2 > documentuploadsize) {
          print("this file size ${value2} ${suffixes[i]} Selected Max size ${documentuploadsize}MB");

          showDialog(
            context: context,
            builder: (ctx) => AlertDialog(
              title: Text("Max Size ${documentuploadsize}MB"),
              content: Text("This file size ${value2} ${suffixes[i]} Selected Max size ${documentuploadsize}MB"),
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
          print('filecheckPath-${file1.path}');
          print('filecheckPath-${file1.path}');
          BlocProvider.of<RePostCubit>(context).UplodeImageAPIImane(
            context,
            pickedImage,
          );
        }

        break;
      default:
    }
    file12 = null;

    return STR;
  }

  Future<void> initAsync() async {
    if (await _promptPermissionSetting()) {
      List<Album> albums = await PhotoGallery.listAlbums(mediumType: MediumType.image);
      if (albums.isNotEmpty) {
        page = await albums.first.listMedia();
      }
      super.setState(() {
        _albums = albums;
        _loading = false;
      });
    }
    super.setState(() {
      _loading = false;
    });
  }

  Future<bool> _promptPermissionSetting() async {
    if (Platform.isIOS) {
      if (await Permission.photos.request().isGranted || await Permission.storage.request().isGranted) {
        return true;
      }
    }
    if (Platform.isAndroid) {
      if (await Permission.storage.request().isGranted || await Permission.photos.request().isGranted && await Permission.videos.request().isGranted) {
        return true;
      }
    }
    return false;
  }

  prepareTestPdf(
    int Index,
  ) async {
    this.file = null;
    pickedImage = [];
    PlatformFile file;
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );
    {
      if (result != null) {
        file = result.files.first;

        if ((file.path?.contains(".mp4") ?? false) || (file.path?.contains(".mov") ?? false) || (file.path?.contains(".mp3") ?? false) || (file.path?.contains(".png") ?? false) || (file.path?.contains(".doc") ?? false) || (file.path?.contains(".jpg") ?? false) || (file.path?.contains(".m4a") ?? false) || (file.path?.contains(".gif") ?? false)) {
          showDialog(
            context: context,
            builder: (ctx) => AlertDialog(
              title: Text(
                "Selected File Error",
                textScaleFactor: 1.0,
              ),
              content: Text(
                "Only PDF Allowed.",
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
          getFileSize(file.path!, 1, result.files.first, Index);
        }
      } else {}
    }
    return "";
    // "${fileparth}";
  }

  getFileSize(String filepath, int decimals, PlatformFile file1, int Index) async {
    var file = File(filepath);
    int bytes = await file.length();
    if (bytes <= 0) return "0 B";
    const suffixes = ["B", "KB", "MB", "GB", "TB", "PB", "EB", "ZB", "YB"];
    var i = (log(bytes) / log(1024)).floor();
    var STR = ((bytes / pow(1024, i)).toStringAsFixed(decimals));
    print('getFileSizevariable-${file1.path}');
    value2 = double.parse(STR);

    print("value2-->$value2");
    switch (i) {
      case 0:
        print("Done file size B");
        switch (Index) {
          case 1:
            if (file1.name.isNotEmpty || file1.name.toString() == null) {
              super.setState(() {
                file12 = file1;
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
                file12 = file1;
              });
            }

            break;
          default:
        }
        print('filenamecheckKB-${file1.path}');
        print("file111.name-->${file1.name}");
        BlocProvider.of<RePostCubit>(context).UplodeImageAPI(context, file1.name, file1.path.toString());

        super.setState(() {});

        break;
      case 2:
        print("value2check-->$value2");
        print("finalFileSize-->${finalFileSize}");

        if (value2 > finalFileSize) {
          print("this file size ${value2} ${suffixes[i]} Selected Max size ${finalFileSize}MB");

          showDialog(
            context: context,
            builder: (ctx) => AlertDialog(
              title: Text("Max Size ${finalFileSize}MB"),
              content: Text("This file size ${value2} ${suffixes[i]} Selected Max size ${finalFileSize}MB"),
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
              break;
            default:
          }
          print('filecheckPath1111-${file1.name}');
          print("file222.name-->${file1.name}");
          super.setState(() {
            file12 = file1;
          });

          BlocProvider.of<RePostCubit>(context).UplodeImageAPI(context, file1.name, file1.path.toString());
        }

        break;
      default:
    }

    return STR;
  }

  Future getVideo() async {
    final pickedFile = await _imagePicker.pickVideo(source: ImageSource.gallery, preferredCameraDevice: CameraDevice.front, maxDuration: const Duration(minutes: 10));
    XFile? xfilePick = pickedFile;
    super.setState(
      () {
        galleryFile.clear();
        if (xfilePick != null) {
          galleryFile.add(File(pickedFile!.path));
          BlocProvider.of<RePostCubit>(context).UplodeImageAPIImane(
            context,
            galleryFile,
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(// is this context <<<
              const SnackBar(content: Text('Nothing is selected')));
        }
      },
    );
  }

  Future<void> _getImageFromCamera() async {
    try {
      pickedFile = await _imagePicker.pickImage(source: ImageSource.camera);

      if (pickedFile != null) {
        if (!_isGifOrSvg(pickedFile!.path)) {
          pickedImage.add(File(pickedFile!.path));
          getFileSize1(pickedImage[0].path, 1, pickedImage[0], 0);
        } else {
          Navigator.pop(context);

          showDialog(
            context: context,
            builder: (ctx) => AlertDialog(
              title: Text(
                "Selected File Error",
                textScaleFactor: 1.0,
              ),
              content: Text(
                "Only PNG, JPG Supported.",
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
        }
      }
    } catch (e) {}
  }

  void _showPopupMenu(
    Offset position,
    BuildContext context,
  ) async {
    final RenderBox overlay = Overlay.of(context).context.findRenderObject() as RenderBox;
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
            soicalData.length,
            (index) => PopupMenuItem(
                onTap: () {
                  super.setState(() {
                    indexx = index;
                  });
                },
                child: Container(
                  decoration: BoxDecoration(color: indexx == index ? ColorConstant.primary_color : Colors.transparent, borderRadius: BorderRadius.circular(5)),
                  width: 130,
                  height: 40,
                  child: Center(
                    child: Text(
                      soicalData[index],
                      style: TextStyle(color: indexx == index ? Colors.white : Colors.black),
                    ),
                  ),
                ))));
    if (selectedOption != null) {
      print("Selected option index: $selectedOption");
    }
  }
  Timer? _timer;

  onChangeMethod(String value) {
    super.setState(() {
      postText1.text = value;
      title = "";
    });
    if (value.contains('@')) {
      title = "";
      print("if this condison is working-${value}");
      if (value.length >= 1 && value.contains('@')) {
        print("value check --${value.endsWith(' #')}");
        if (value.endsWith(' #')) {
          String data1 = value.split(' #').last.replaceAll('#', '');
          BlocProvider.of<RePostCubit>(context).GetAllHashtag(context, '10', '#${data1.trim()}');
        } else {
          String data = value.split(' @').last.replaceAll('@', '');
          BlocProvider.of<RePostCubit>(context).search_user_for_inbox(context, '${data.trim()}', '1');
        }
      } else if (value.endsWith(' #')) {
        print("ends with value-${value}");
      } else {
        print("check lenth else-${value.length}");
      }
      if (AnyLinkPreview.isValidLink(extractUrls(value).first)) {
        if (_timer != null) {
          _timer?.cancel();
          _timer = Timer(Duration(seconds: 2), () {
            setState(() {
              title = extractUrls(value).first;
            });
          });
        } else {
          _timer = Timer(Duration(seconds: 2), () {
            setState(() {
              title = extractUrls(value).first;
            });
          });
        }
      }
    } else if (value.contains('#')) {
      title = "";
      print("check length-${value}");
      String data1 = value.split(' #').last.replaceAll('#', '');
      BlocProvider.of<RePostCubit>(context).GetAllHashtag(context, '10', '#${data1.trim()}');
      if (AnyLinkPreview.isValidLink(extractUrls(value).first)) {
        if (_timer != null) {
          _timer?.cancel();
          _timer = Timer(Duration(seconds: 2), () {
            setState(() {
              title = extractUrls(value).first;
            });
          });
        } else {
          _timer = Timer(Duration(seconds: 2), () {
            setState(() {
              title = extractUrls(value).first;
            });
          });
        }
      }
    }else if (AnyLinkPreview.isValidLink(extractUrls(value).first)) {
      if (_timer != null) {
        _timer?.cancel();
        _timer = Timer(Duration(seconds: 2), () {
          setState(() {
            title = extractUrls(value).first;
          });
        });
      } else {
        _timer = Timer(Duration(seconds: 2), () {
          setState(() {
            title = extractUrls(value).first;
          });
        });
      }
    }  else {
      super.setState(() {
        istageData = false;
        isHeshTegData = false;
        title = "";
      });
    }
  }

  dataPostFucntion() {
    print("dfhghghfhgh-${pickedFile?.path}");
    print("FBSDFNFBDBFSBF--${postText1.text.length}");

    // String text = postText1.text;
    RegExp exp = new RegExp(r"\B#\w+");

    if (postText1.text.length >= 1000) {
      CreatePostDone = false;
      SnackBar snackBar = SnackBar(
        content: Text('Please enter less than 1000 letter!!'),
        backgroundColor: ColorConstant.primary_color,
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } else {
      exp.allMatches(postText1.text).forEach((match) {
        var aa = "${match.group(0)}";
        print("aa.length aa.length aa.length aa.length aa.length aa.length aa.length aa.length aa.length aa.length ");
        print("  ");
        print(aa);
        print(aa.length);
        if (aa.length <= 100) {
          HasetagList?.add("$match");
        } else {
          CreatePostDone = false;
          SnackBar snackBar = SnackBar(
            content: Text('Please HaseTag less than 100 letter!!'),
            backgroundColor: ColorConstant.primary_color,
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
      });

      print(HasetagList?.length);
      if ((HasetagList?.length)! <= 25) {
        /* if (postText1.text.length >= 1000) {
          SnackBar snackBar = SnackBar(
            content: Text('Please enter less than 1000 letter!!'),
            backgroundColor: ColorConstant.primary_color,
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        } else { */
        if (CreatePostDone == true) {
          super.setState(() {
            isrepostDataSet = false;
          });
          if (postText1.text.isNotEmpty && file?.path != null) {
            Map<String, dynamic> param = {"description": postText1.text, "postData": imageDataPost?.object?.data, "postDataType": "IMAGE", "postType": soicalData[indexx].toString().toUpperCase(),};
            BlocProvider.of<RePostCubit>(context).RePostAPI(context, param, widget.postUid, "");
          } else if (postText1.text.isNotEmpty && file12?.path != null) {
            Map<String, dynamic> param = {"description": postText1.text, "postData": imageDataPost?.object?.data, "postDataType": "ATTACHMENT", "postType": soicalData[indexx].toString().toUpperCase()};
            BlocProvider.of<RePostCubit>(context).RePostAPI(context, param, widget.postUid, "");
          } else if (postText1.text.isNotEmpty && pickedImage.isNotEmpty) {
            Map<String, dynamic> param = {"description": postText1.text, "postData": imageDataPost?.object?.data, "postDataType": "IMAGE", "postType": soicalData[indexx].toString().toUpperCase()};
            BlocProvider.of<RePostCubit>(context).RePostAPI(context, param, widget.postUid, "");
          } else if (pickedFile?.path != null && postText1.text.isNotEmpty) {
            Map<String, dynamic> param = {"description": postText1.text, "postData": imageDataPost?.object?.data, "postDataType": "IMAGE", "postType": soicalData[indexx].toString().toUpperCase()};
            BlocProvider.of<RePostCubit>(context).RePostAPI(context, param, widget.postUid, "");
          } else if (postText1.text.isNotEmpty && _controller?.value.isPlaying == true) {
            Map<String, dynamic> param = {"description": postText1.text, "postData": imageDataPost?.object?.data, "postDataType": "VIDEO", "postType": soicalData[indexx].toString().toUpperCase()};
            BlocProvider.of<RePostCubit>(context).RePostAPI(context, param, widget.postUid, "");
          } else {
            if (postText1.text.isNotEmpty) {
              Map<String, dynamic> param = {"description": postText1.text, "postType": soicalData[indexx].toString().toUpperCase()};
              BlocProvider.of<RePostCubit>(context).RePostAPI(context, param, widget.postUid, "");
            } else if (file?.path != null) {
              Map<String, dynamic> param = {
                "postData": imageDataPost?.object?.data,
                "postDataType": "IMAGE",
                "postType": soicalData[indexx].toString().toUpperCase(),
              };
              BlocProvider.of<RePostCubit>(context).RePostAPI(context, param, widget.postUid, "");
            } else if (pickedFile?.path != null) {
              Map<String, dynamic> param = {
                "postData": imageDataPost?.object?.data,
                "postDataType": "IMAGE",
                "postType": soicalData[indexx].toString().toUpperCase(),
              };
              BlocProvider.of<RePostCubit>(context).RePostAPI(context, param, widget.postUid, "");
            } else if (file12?.path != null) {
              Map<String, dynamic> param = {
                "postData": imageDataPost?.object?.data,
                "postDataType": "ATTACHMENT",
                "postType": soicalData[indexx].toString().toUpperCase(),
              };
              BlocProvider.of<RePostCubit>(context).RePostAPI(context, param, widget.postUid, "");
            } else if (pickedImage.isNotEmpty) {
              Map<String, dynamic> param = {
                "postData": imageDataPost?.object?.data,
                "postDataType": "IMAGE",
                "postType": soicalData[indexx].toString().toUpperCase(),
              };
              BlocProvider.of<RePostCubit>(context).RePostAPI(context, param, widget.postUid, "");
            } else if (_controller?.value.isPlaying == true) {
              Map<String, dynamic> param = {
                "postData": imageDataPost?.object?.data,
                "postDataType": "VIDEO",
                "postType": soicalData[indexx].toString().toUpperCase(),
              };
              BlocProvider.of<RePostCubit>(context).RePostAPI(context, param, widget.postUid, "");
            } else {
              SnackBar snackBar = SnackBar(
                content: Text('Please selcte image either fill Text'),
                backgroundColor: ColorConstant.primary_color,
              );
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            }
          }
        }
        /* } */
      } else {
        CreatePostDone = false;
        SnackBar snackBar = SnackBar(
          content: Text('Please HaseTag less than 25 letter!!'),
          backgroundColor: ColorConstant.primary_color,
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    }
  }

  Future<String> fetchYoutubeThumbnail(String url) async {
    try {
      // Extract video ID from YouTube URL
      // We will use this to build our own custom UI
      List<String> urls = extractUrls(url);
      Metadata? _metadata = await AnyLinkPreview.getMetadata(
        link: urls.first,
        cache: Duration(days: 1),
        // proxyUrl: "https://cors-anywhere.herokuapp.com/", // Need for web
      );
      return _metadata?.image ?? "";
    } catch (e) {
      print('Error: $e');
      return "";
    }
  }

  List<String> extractUrls(String text) {
    RegExp regExp = RegExp(
      r"https?:\/\/[\w\-]+(\.[\w\-]+)+[\w\-.,@?^=%&:/~\+#]*[\w\-@?^=%&/~\+#]?",
      caseSensitive: false,
    );

    List<String> urls = regExp.allMatches(text).map((match) => match.group(0)!).toList();
    List<String> finalUrls = [];
    RegExp urlRegex = RegExp(r"(http(s)?://)", caseSensitive: false);
    urls.forEach((element) {
      if (urlRegex.allMatches(element).toList().length > 1) {
        String xyz = element.replaceAll("http", ",http");
        List<String> splitted = xyz.split(RegExp(r",|;"));
        splitted.forEach((element1) {
          if (element1.isNotEmpty) finalUrls.add(element1);
        });
      } else {
        finalUrls.add(element);
      }
    });
    return finalUrls;
  }

  bool isYouTubeUrl(String url) {
    // Regular expression pattern to match YouTube URLs
    RegExp youtubeVideoRegex = RegExp(r"^https?://(?:www\.)?youtube\.com/(?:watch\?v=)?([^#&?]+)");
    RegExp youtubeShortsRegex = RegExp(r"^https?://(?:www\.)?youtube\.com/shorts/([^#&?]+)");

    if (youtubeVideoRegex.hasMatch(url) || youtubeShortsRegex.hasMatch(url)) {
      return true;
    }

    // Additional checks based on specific test link patterns (optional)
    if (url.contains("youtu.be/")) {
      // This check might need adjustments if Youtube short URLs change format
      return true;
    }

    return false;
  }

  void playLink(String videoUrl, BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext ctx) {
        return Center(
          child: Container(
              width: MediaQuery.of(context).size.width * 0.90,
              height: MediaQuery.of(context).size.width * 0.80,
              decoration: ShapeDecoration(color: Colors.black, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
              clipBehavior: Clip.antiAlias,
              child: Stack(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      FutureBuilder(future: getYoutubePlayer(videoUrl, () {
                        Navigator.pop(ctx);
                        launchUrl(Uri.parse(videoUrl));
                      }), builder: (context,snap){
                        if(snap.data != null)
                          return snap.data as Widget;
                        else return Center(
                          child: CircularProgressIndicator(color: Colors.white,),
                        );
                      })
                    ],
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: Material(
                      color: Colors.transparent,
                      child: IconButton(
                        icon: Icon(
                          Icons.close,
                          color: Colors.white,
                          size: 30,
                        ),
                        onPressed: () {
                          Navigator.pop(ctx);
                        },
                      ),
                    ),
                  )
                ],
              )),
        );
      },
    );
  }

  late PlayerState _playerState;
  late YoutubeMetaData _videoMetaData;
  bool _isPlayerReady = false;

  String extractPlaylistId(String playlistLink) {
    Uri uri = Uri.parse(playlistLink);

    String playlistId = '';

    // Check if the link is a valid YouTube playlist link
    if (uri.host == 'www.youtube.com' || uri.host == 'youtube.com') {
      if (uri.pathSegments.contains('playlist')) {
        int index = uri.pathSegments.indexOf('playlist');
        if (index != -1 /*&& index + 1 < uri.pathSegments.length*/) {
          playlistId = uri.queryParameters['list']!;
        }
      }
    } else if (uri.host == 'youtu.be') {
      // If the link is a short link
      playlistId = uri.pathSegments.first;
    }

    return playlistId;
  }


  Future<List<String>> getPlaylistVideos(String playlistId) async {
    // final url = "https://www.youtube.com/playlist?list=RDF0SflZWxv8k";
    final url = "https://www.googleapis.com/youtube/v3/playlistItems?part=snippet&maxResults=50&playlistId=$playlistId&key=AIzaSyAT_gzTjHn9XuvQsmGdY63br7lKhD2KRdo";
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      // Parse the HTML content to extract video IDs (implementation depends on website structure)
      List<String> videoIds = [];
      final Map<String, dynamic> data = json.decode(response.body);
      for (var item in data['items']) {
        videoIds.add(item['snippet']['resourceId']['videoId']);
      }
      return videoIds; // List of video IDs
    } else {
      print ("Failed to fetch playlist videos");
      return [];
    }
  }

  String extractLiveId(String liveLink) {
    Uri uri = Uri.parse(liveLink);

    String liveId = '';

    // Check if the link is a valid YouTube live link
    if (uri.host == 'www.youtube.com' || uri.host == 'youtube.com') {
      if (uri.pathSegments.contains('watch')) {
        // If the link contains 'watch' segment
        int index = uri.pathSegments.indexOf('watch');
        if (index != -1 && index + 1 < uri.pathSegments.length) {
          // Get the video ID
          liveId = uri.queryParameters['v']!;
        }
      } else if (uri.pathSegments.contains('live')) {
        // If the link contains 'live' segment
        int index = uri.pathSegments.indexOf('live');
        if (index != -1 && index + 1 < uri.pathSegments.length) {
          // Get the live ID
          liveId = uri.pathSegments[index + 1];
        }
      }
    } else if (uri.host == 'youtu.be') {
      // If the link is a short link
      liveId = uri.pathSegments.first;
    }

    return liveId;
  }


  Future<Widget> getYoutubePlayer(String videoUrl, Function() fullScreen) async{
    late YoutubePlayerController _controller;
    String videoId = "";
    if(videoUrl.toLowerCase().contains("playlist")){
      String playlistId = extractPlaylistId(videoUrl);
      var videoIds = await getPlaylistVideos(playlistId);
      videoId = videoIds.first;
    }else if(videoUrl.toLowerCase().contains("live")){
      videoId = extractLiveId(videoUrl);
    }else{
      videoId = YoutubePlayer.convertUrlToId(videoUrl)!;
    }
    print("video id ========================> $videoId");
    _controller = YoutubePlayerController(
      initialVideoId: videoId,
      flags: YoutubePlayerFlags(
        mute: false,
        autoPlay: true,
        disableDragSeek: false,
        loop: false,
        isLive: videoUrl.toLowerCase().contains("live"),
        forceHD: false,
        enableCaption: true,
      ),
    );
    _videoMetaData = const YoutubeMetaData();
    _playerState = PlayerState.unknown;

    return YoutubePlayerBuilder(
      onEnterFullScreen: () {
        _controller.toggleFullScreenMode();
        _controller.dispose();
        fullScreen.call();
      },
      builder: (context, player) {
        return player;
      },
      player: YoutubePlayer(
        controller: _controller,
        showVideoProgressIndicator: true,
        progressIndicatorColor: Colors.red,
        progressColors: const ProgressBarColors(
          playedColor: Colors.red,
          handleColor: Colors.redAccent,
        ),
        bottomActions: [
          const SizedBox(width: 14.0),
          CurrentPosition(),
          const SizedBox(width: 8.0),
          ProgressBar(
            isExpanded: true,
            colors: const ProgressBarColors(
              playedColor: Colors.red,
              handleColor: Colors.redAccent,
            ),
          ),
          RemainingDuration(),
          const PlaybackSpeedButton(),
          IconButton(
            icon: Icon(
              _controller.value.isFullScreen
                  ? Icons.fullscreen_exit
                  : Icons.fullscreen,
              color: Colors.white,
            ),
            onPressed: () => fullScreen.call(),
          ),
        ],
        onReady: () {
          _controller.addListener(() {
            if (_isPlayerReady && mounted && !_controller.value.isFullScreen) {
              setState(() {
                _playerState = _controller.value.playerState;
                _videoMetaData = _controller.metadata;
              });
            }
          });
        },
      ),
    );
  }
}
