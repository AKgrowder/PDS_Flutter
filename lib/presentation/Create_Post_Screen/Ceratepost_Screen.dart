import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_mentions/flutter_mentions.dart';
import 'package:getwidget/getwidget.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pds/API/Bloc/NewProfileScreen_Bloc/NewProfileScreen_cubit.dart';
import 'package:pds/API/Bloc/postData_Bloc/postData_Bloc.dart';
import 'package:pds/API/Bloc/postData_Bloc/postData_state.dart';
import 'package:pds/API/Model/Add_PostModel/Add_postModel_Image.dart';
import 'package:pds/API/Model/HasTagModel/hasTagModel.dart';
import 'package:pds/core/utils/color_constant.dart';
import 'package:pds/core/utils/sharedPreferences.dart';
import 'package:pds/presentation/%20new/profileNew.dart';
import 'package:pds/presentation/Create_Post_Screen/CreatePostShow_ImageRow/photo_gallery-master/example/lib/main.dart';
import 'package:pds/presentation/Create_Post_Screen/CreatePostShow_ImageRow/photo_gallery-master/lib/photo_gallery.dart';
import 'package:pds/widgets/commentPdf.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:pinput/pinput.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:video_player/video_player.dart';

import '../../API/Model/serchForInboxModel/serchForinboxModel.dart';
import '../../core/utils/image_constant.dart';

class CreateNewPost extends StatefulWidget {
  String? edittextdata;
  String? PostID;
  CreateNewPost({key, this.edittextdata, this.PostID});

  @override
  State<CreateNewPost> createState() => _CreateNewPostState();
}

class _CreateNewPostState extends State<CreateNewPost> {
  int indexx = 0;
  double value2 = 0.0;
  List<Album>? _albums;
  bool _loading = false;
  bool CreatePostDone = true;
  MediaPage? page;
  double finalFileSize = 0;
  double documentuploadsize = 0;
  PlatformFile? file12;
  XFile? pickedFile;
  ImagePicker _imagePicker = ImagePicker();
  List<File> pickedImage = [];
  File? pickedVedio;
  List<File>? croppedFiles;
  bool isTrue = false;
  String? User_ID;
  Medium? medium1;
  bool selectImage = false;
  TextEditingController postText = TextEditingController();
  List<String> postTexContrlloer = [];
  File? file;
  ImageDataPost? imageDataPost;
  FocusNode _focusNode = FocusNode();
  String? userUiid;
  double _opacity = 0.0;
  // bool _mounted = false;
  PageController _pageControllers = PageController();
  int _currentPages = 0;
  Color primaryColor = ColorConstant.primaryLight_color;
  Color textColor = ColorConstant.primary_color;
  List<String>? HasetagList = [];
  bool colorVaralble = false;
  String? UserProfileImage;
  List<TextSpan> _textSpans = [];
  bool isHeshTegData = false;
  bool isTagData = false;
  SearchUserForInbox? searchUserForInbox1;
  List<File> galleryFile = [];
  bool isVideodata = false;
  VideoPlayerController? _controller;
  HasDataModel? getAllHashtag;
  String enteredText = '';
  List<String> postTexHashContrlloer = [];
  GlobalKey<FlutterMentionsState> key = GlobalKey<FlutterMentionsState>();
  List<Map<String,dynamic>> hastageData = [];
/*   void _onTextChanged() {
    String text = postText.text;

    // Split the entered text by space
    List<String> words = text.split(' ');

    // Create TextSpan list with different colors
    _textSpans.clear();
    for (int i = 0; i < words.length; i++) {
      String word = words[i];
      Color textColor = Colors.black;

      // Check if the word starts with '#' and set the color accordingly
      if (word.startsWith('#')) {
        textColor = Colors.blue;
      }

      // Add TextSpan to the list
      _textSpans
          .add(TextSpan(text: word + ' ', style: TextStyle(color: textColor)));
    }

    setState(() {});
  } */

  getDocumentSize() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    documentuploadsize = await double.parse(
        prefs.getString(PreferencesKey.MaxPostUploadSizeInMB) ?? "0");

    finalFileSize = documentuploadsize;
    setState(() {});
  }

  @override
  void initState() {
    _loading = true;
    postText.text = widget.edittextdata ?? "";
    getDocumentSize();
    initAsync();
    Future.delayed(Duration(milliseconds: 150), () {
      if (mounted) {
        setState(() {
          _opacity = 1.0;
        });
      }
    });
    GetUserData();

    super.initState();
  }

  GetUserData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    User_ID = prefs.getString(PreferencesKey.loginUserID);
    UserProfileImage = prefs.getString(PreferencesKey.UserProfile);
  }

//Public
// Following
//  List<String> postTexHashContrlloer = [];
  List<String> soicalData = ["Public", "Follower"];
  bool _isLink(String input) {
    RegExp linkRegex = RegExp(
        r'^https?:\/\/(?:www\.)?[a-zA-Z0-9-]+(?:\.[a-zA-Z]+)+(?:[^\s]*)$');
    return linkRegex.hasMatch(input);
  }

  @override
  Widget build(BuildContext context) {
    var _height = MediaQuery.of(context).size.height;
    var _width = MediaQuery.of(context).size.width;
    return BlocConsumer<AddPostCubit, AddPostState>(
      listener: (context, state) {
        if (state is AddPostImaegState) {
          imageDataPost?.object?.data?.clear();
          imageDataPost = state.imageDataPost;
          print(" check Data-${imageDataPost?.object?.data}");
          if (imageDataPost?.object?.data?.isNotEmpty == true) {
            if (imageDataPost!.object!.data!.first.endsWith('.mp4')) {
              isVideodata = true;
            }
          }

          if (state.imageDataPost.object?.status == 'failed') {
            isTrue = true;
            imageDataPost?.object?.data = null;
          } else {
            isTrue = true;

            print("imageDataPost-->${imageDataPost?.object?.data}");
          }
          if (isVideodata == true) {
            print("this condison is working");
            _controller = VideoPlayerController.networkUrl(
                Uri.parse('${imageDataPost!.object!.data!.first}'));
            _controller?.initialize().then((value) => setState(() {}));
            setState(() {
              _controller?.play();
              _controller?.setLooping(true);
            });
          }
        }
        if (state is GetAllHashtagState) {
          getAllHashtag = state.getAllHashtag;
          isHeshTegData = true;
          isTagData = false;
        }
        if (state is AddPostLoadedState) {
          if (state.addPost.object.toString() ==
              'Comment contains a restricted word') {
          } else {
            Navigator.pop(context);
          }
          SnackBar snackBar = SnackBar(
            content: Text(state.addPost.object.toString()),
            backgroundColor: ColorConstant.primary_color,
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
          //
        }
        if (state is SearchHistoryDataAddxtends) {
          searchUserForInbox1 = state.searchUserForInbox;
          isTagData = true;
          isHeshTegData = false;
        }
      },
      builder: (context, state) {
        return Portal(
          child: MaterialApp(
            home: SafeArea(
                child: Scaffold(
              resizeToAvoidBottomInset: true,
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
                              padding:
                                  const EdgeInsets.only(left: 16, right: 16),
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
                                        dataPostFucntion();
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                            color: primaryColor,
                                            borderRadius:
                                                BorderRadius.circular(14)),
                                        height: 40,
                                        width: 70,
                                        child: Center(
                                            child: Text(
                                          "Post",
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
                              padding:
                                  const EdgeInsets.only(left: 16, right: 16),
                              child: Row(
                                children: [
                                  Container(
                                    child: GestureDetector(
                                      onTap: () {
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
                                                backgroundImage: AssetImage(
                                                    ImageConstant.tomcruse),
                                              ),
                                            )
                                          : SizedBox(
                                              height: 50,
                                              width: 50,
                                              child: CircleAvatar(
                                                backgroundColor: Colors.white,
                                                backgroundImage: NetworkImage(
                                                    UserProfileImage
                                                        .toString()),
                                              ),
                                            ),
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        EdgeInsets.only(bottom: 15, left: 10),
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
                                              color: Color(0xffED1C25),
                                            ),
                                            color: ColorConstant
                                                .primaryLight_color,
                                            borderRadius:
                                                BorderRadius.circular(10)),
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
                                                    color: ColorConstant
                                                        .primary_color,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Spacer(),
                                            Padding(
                                              padding:
                                                  EdgeInsets.only(right: 7),
                                              child: Image.asset(
                                                ImageConstant.downarrow,
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
                            Padding(
                              padding:
                                  EdgeInsets.only(left: 16, right: 16, top: 15),
                              child: Stack(
                                children: [
                                  Column(
                                    children: [
                                      FlutterMentions(
                                        key: key,
                                        suggestionPosition:
                                            SuggestionPosition.Top,
                                        maxLines: 5,
                                        minLines: 1,
                                        mentions: [
                                          Mention(
                                              trigger: "@",
                                              style: TextStyle(
                                                  color: Colors.purple),
                                              data: [
                                                {
                                                  "id": "61as61fsa",
                                                  "display": "fayeedP",
                                                  "photo":
                                                      "https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg"
                                                },
                                                {
                                                  "id": "61asasgasgsag6a",
                                                  "display": "khaled",
                                                  "photo":
                                                      "https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg",
                                                },
                                              ],
                                              matchAll: false,
                                              suggestionBuilder: (data) {
                                                return Container(
                                                  padding: EdgeInsets.all(10.0),
                                                  child: Row(
                                                    children: <Widget>[
                                                      CircleAvatar(
                                                        backgroundImage:
                                                            NetworkImage(
                                                          data['photo'],
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: 20.0,
                                                      ),
                                                      Column(
                                                        children: <Widget>[
                                                          Text(
                                                              '@${data['display']}'),
                                                        ],
                                                      )
                                                    ],
                                                  ),
                                                );
                                              })
                                        ],
                                      ),
                                      /*  TextFormField(
                                        controller: postText,
                                        maxLines: null,
                                        cursorColor: Colors.grey,
                                        decoration: InputDecoration(
                                          hintText: 'What’s on your head?',
                                          border: InputBorder.none,
                                          focusedBorder: InputBorder.none,
                                        ),
                                        inputFormatters: [
                                          // Custom formatter to trim leading spaces
                                        ],
                                        onChanged: (value) async {
                                          (value);
                                          onChangeMethod(value);
          
                                          //this is the link
                                          print("controller text ${postText}");
                                        },
                                        onTap: () async {
                                          //this is the link
                                        },
                                        style: TextStyle(
                                            decoration: TextDecoration.none,
                                            decorationColor: Colors.white),
                                        /* style: TextStyle(
                                          color: colorVaralble == true
                                              ? Colors.blue
                                          decoration: TextDecoration.underline,
                                          decorationColor: colorVaralble == true
                                              ? Colors.blue
                                              : Colors.transparent,
                                        ), */
                                      ), */
                                      Padding(
                                        padding: EdgeInsets.only(
                                            top: isHeshTegData == true ||
                                                    isTagData == true
                                                ? 330
                                                : 5),
                                        child: SizedBox(
                                          child: isVideodata == true
                                              ? _controller!.value.isInitialized
                                                  ? Container(
                                                      // color: Colors.amber,
                                                      height: _height / 2,
                                                      child: Column(
                                                        children: [
                                                          AspectRatio(
                                                            aspectRatio:
                                                                _controller!
                                                                    .value
                                                                    .aspectRatio,
                                                            child: VideoPlayer(
                                                                _controller!),
                                                          ),
                                                          // GestureDetector(
                                                          //   onTap: () {
                                                          //     if (_controller!.value
                                                          //         .isPlaying) {
                                                          //       setState(() {
                                                          //         _controller
                                                          //             ?.pause();
                                                          //       });
                                                          //     } else {
                                                          //       setState(() {
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
                                                      child:
                                                          DocumentViewScreen1(
                                                        path: imageDataPost
                                                            ?.object!
                                                            .data!
                                                            .first
                                                            .toString(),
                                                      ))
                                                  : pickedImage.isNotEmpty
                                                      ? _loading
                                                          ? Center(
                                                              child: Container(
                                                                margin: EdgeInsets
                                                                    .only(
                                                                        bottom:
                                                                            100),
                                                                child:
                                                                    ClipRRect(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              20),
                                                                  child: Image.asset(
                                                                      ImageConstant
                                                                          .loader,
                                                                      fit: BoxFit
                                                                          .cover,
                                                                      height:
                                                                          100,
                                                                      width:
                                                                          100),
                                                                ),
                                                              ),
                                                            )
                                                          : isTrue == true
                                                              ? imageDataPost
                                                                          ?.object
                                                                          ?.data !=
                                                                      null
                                                                  ? SizedBox(
                                                                      height:
                                                                          _height /
                                                                              2,
                                                                      width:
                                                                          _width,
                                                                      child: PageView
                                                                          .builder(
                                                                        onPageChanged:
                                                                            (value) {
                                                                          setState(
                                                                              () {
                                                                            _currentPages =
                                                                                value;
                                                                          });
                                                                        },
                                                                        itemCount: imageDataPost
                                                                            ?.object
                                                                            ?.data
                                                                            ?.length,
                                                                        controller:
                                                                            _pageControllers,
                                                                        itemBuilder:
                                                                            (context,
                                                                                index) {
                                                                          return SizedBox(
                                                                              height: _height / 2,
                                                                              width: _width,
                                                                              child: Padding(
                                                                                padding: const EdgeInsets.all(8.0),
                                                                                child: CachedNetworkImage(
                                                                                  imageUrl: '${imageDataPost?.object?.data?[index]}',
                                                                                  fit: BoxFit.cover,
                                                                                ),
                                                                              ));
                                                                        },
                                                                      ),
                                                                    )
                                                                  : Container()
                                                              : Center(
                                                                  child: GFLoader(
                                                                      type: GFLoaderType
                                                                          .ios),
                                                                )
                                                      : selectImage == true
                                                          ? medium1?.mediumType ==
                                                                  MediumType
                                                                      .image
                                                              ? GestureDetector(
                                                                  onTap:
                                                                      () async {
                                                                    print(
                                                                        "this is the Medium");
                                                                  },
                                                                  child: imageDataPost
                                                                              ?.object
                                                                              ?.data?[0] !=
                                                                          null
                                                                      ? CachedNetworkImage(
                                                                          imageUrl:
                                                                              '${imageDataPost?.object?.data?[0]}',
                                                                          fit: BoxFit
                                                                              .cover,
                                                                        )
                                                                      : SizedBox(),
                                                                  /*    child: FadeInImage(
                                                                fit: BoxFit.cover,
                                                                placeholder: MemoryImage(
                                                                    kTransparentImage),
                                                                image: PhotoProvider(
                                                                    mediumId:
                                                                        medium1!.id),
                                                              ), */
                                                                )
                                                              : VideoProvider(
                                                                  mediumId:
                                                                      medium1!
                                                                          .id,
                                                                )
                                                          : Container(
                                                              color:
                                                                  Colors.white,
                                                            ),
                                        ),
                                      ),
                                      imageDataPost?.object?.data != null &&
                                              imageDataPost
                                                      ?.object?.data?.length !=
                                                  1
                                          ? Container(
                                              height: 20,
                                              child: DotsIndicator(
                                                dotsCount: imageDataPost?.object
                                                        ?.data?.length ??
                                                    0,
                                                position:
                                                    _currentPages.toDouble(),
                                                decorator: DotsDecorator(
                                                  size: const Size(10.0, 7.0),
                                                  activeSize:
                                                      const Size(10.0, 10.0),
                                                  spacing: const EdgeInsets
                                                      .symmetric(horizontal: 2),
                                                  activeColor:
                                                      Color(0xffED1C25),
                                                  color: Color(0xff6A6A6A),
                                                ),
                                              ),
                                            )
                                          : SizedBox(),
                                    ],
                                  ),
                                  if (isHeshTegData)
                                    Container(
                                      margin: EdgeInsets.only(
                                          top: postText.length >= 100
                                              ? (postText.length + 0)
                                              : 100),
                                      height:
                                          imageDataPost?.object?.data != null
                                              ? _height / 3
                                              : _height,
                                      width: _width,
                                      // color: Colors.amber,
                                      child: ListView.builder(
                                        // physics: NeverScrollableScrollPhysics(),
                                        shrinkWrap: true,
                                        itemCount: getAllHashtag
                                            ?.object?.content?.length,
                                        itemBuilder: (context, index) {
                                          return Container(
                                            margin: EdgeInsets.all(10),
                                            height: 70,
                                            width: _width,

                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                                border: Border.all(
                                                    color: Color(0xffE6E6E6))),
                                            child: GestureDetector(
                                              onTap: () {
                                                setState(() {
                                                  if (postText
                                                      .text.isNotEmpty) {
                                                    postTexHashContrlloer.add(
                                                        '${getAllHashtag?.object?.content?[index]}');
                                                    postText.text = postText
                                                            .text +
                                                        '' +
                                                        '${getAllHashtag?.object?.content?[index].replaceAll("#", "")}';
                                                    postText.selection =
                                                        TextSelection
                                                            .fromPosition(
                                                      TextPosition(
                                                          offset: postText
                                                              .text.length),
                                                    );
                                                  }

                                                  isHeshTegData = false;

                                                  // postText.text = '${postText.text}@${searchUserForInbox1?.object?.content?[index].userName}';
                                                });
                                              },
                                              child: Row(
                                                children: [
                                                  Container(
                                                    width: _width / 1.6,
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 10),
                                                      child: Text(
                                                        '${getAllHashtag?.object?.content?[index]}',
                                                        style: TextStyle(
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          color: Colors.black,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                            // color: Colors.green,
                                          );
                                        },
                                      ),
                                    ),
                                  if (isTagData)
                                    Container(
                                      margin: EdgeInsets.only(
                                          top: postText.length >= 100
                                              ? (postText.length + 0)
                                              : 100),
                                      height:
                                          imageDataPost?.object?.data != null
                                              ? _height / 3
                                              : _height,
                                      width: _width,
                                      // color: Colors.amber,
                                      child: ListView.builder(
                                        // physics: NeverScrollableScrollPhysics(),
                                        shrinkWrap: true,
                                        itemCount: searchUserForInbox1
                                            ?.object?.content?.length,
                                        itemBuilder: (context, index) {
                                          return Container(
                                            margin: EdgeInsets.all(10),
                                            height: 70,
                                            width: _width,
                                            // color: Colors.green,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                                border: Border.all(
                                                    color: Color(0xffE6E6E6))),
                                            child: GestureDetector(
                                              onTap: () {
                                                /* setState(() {
                                                  if (postText.text.isNotEmpty) {
                                                    // postText.text =
                                                    //     '${postText.text} @${searchUserForInbox1?.object?.content?[index].userName}';
                                                    postTexContrlloer.add(
                                                        '@${searchUserForInbox1?.object?.content?[index].userName}');
                                                    postText.text = postText.text +
                                                        '' +
                                                        '${searchUserForInbox1?.object?.content?[index].userName}';
                                                    postText.selection =
                                                        TextSelection.fromPosition(
                                                      TextPosition(
                                                          offset:
                                                              postText.text.length),
                                                    );
          
                                                    print(
                                                        "postText${postText.text.split("@").first}");
                                                  }
          
                                                  isTagData = false;
          
                                                  // postText.text = '${postText.text}@${searchUserForInbox1?.object?.content?[index].userName}';
                                                }); */
                                              },
                                              child: Row(
                                                children: [
                                                  searchUserForInbox1
                                                                  ?.object
                                                                  ?.content?[
                                                                      index]
                                                                  .userProfilePic !=
                                                              null &&
                                                          searchUserForInbox1
                                                                  ?.object
                                                                  ?.content?[
                                                                      index]
                                                                  .userProfilePic
                                                                  ?.isNotEmpty ==
                                                              true
                                                      ? Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  left: 10),
                                                          child: CircleAvatar(
                                                            radius: 30.0,
                                                            backgroundImage:
                                                                NetworkImage(
                                                                    "${searchUserForInbox1?.object?.content?[index].userProfilePic}"),
                                                            backgroundColor:
                                                                Colors
                                                                    .transparent,
                                                          ),
                                                        )
                                                      : Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  left: 10),
                                                          child: CircleAvatar(
                                                            radius: 30.0,
                                                            backgroundImage:
                                                                AssetImage(
                                                                    ImageConstant
                                                                        .tomcruse),
                                                            backgroundColor:
                                                                Colors
                                                                    .transparent,
                                                          ),
                                                        ),
                                                  Container(
                                                    width: _width / 1.6,
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 10),
                                                      child: Text(
                                                        searchUserForInbox1
                                                                ?.object
                                                                ?.content?[
                                                                    index]
                                                                .userName ??
                                                            '',
                                                        style: TextStyle(
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          color: Colors.black,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                            // color: Colors.green,
                                          );
                                        },
                                      ),
                                    ),
                                ],
                              ),
                            ),
                            Container(
                              color: Color.fromARGB(255, 255, 255, 255),
                              height: 120,
                            )
                          ],
                        ),
                      ),
                    ),
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
                                            border: Border.all(
                                                color: Color.fromARGB(
                                                    255, 174, 174, 174),
                                                width: 2),
                                            borderRadius:
                                                BorderRadius.circular(20),
                                          ),
                                          child: Center(
                                            child: Image.asset(
                                              ImageConstant.Cameraicon,
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
                                              margin:
                                                  EdgeInsets.only(bottom: 100),
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                                child: Image.asset(
                                                    ImageConstant.loader,
                                                    fit: BoxFit.cover,
                                                    height: 100,
                                                    width: 100),
                                              ),
                                            ),
                                          )
                                        : LayoutBuilder(
                                            builder: (context, constraints) {
                                              double gridWidth =
                                                  (constraints.maxWidth - 20) /
                                                      3;
                                              double gridHeight =
                                                  gridWidth + 33;
                                              double ratio =
                                                  gridWidth / gridHeight;
                                              return Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 5, bottom: 5),
                                                child: Container(
                                                  // padding: EdgeInsets.all(5),
                                                  child: SizedBox(
                                                    height: 100,
                                                    child: GridView.count(
                                                      crossAxisCount: 1,
                                                      mainAxisSpacing: 5.0,
                                                      crossAxisSpacing: 10.0,
                                                      scrollDirection:
                                                          Axis.horizontal,
                                                      children: <Widget>[
                                                        ...page!.items.map(
                                                          (medium) =>
                                                              GestureDetector(
                                                            onTap: () async {
                                                              medium1 = medium;
                                                              file =
                                                                  await PhotoGallery
                                                                      .getFile(
                                                                mediumId:
                                                                    medium1!.id,
                                                                mediumType:
                                                                    MediumType
                                                                        .image,
                                                              );

                                                              selectImage =
                                                                  true;

                                                              file12 = null;
                                                              pickedImage
                                                                  .isEmpty;
                                                              setState(() {});

                                                              CroppedFile?
                                                                  croppedFile =
                                                                  await ImageCropper()
                                                                      .cropImage(
                                                                sourcePath: file!
                                                                    .path
                                                                    .toString(),
                                                                aspectRatioPresets: [
                                                                  CropAspectRatioPreset
                                                                      .square,
                                                                  CropAspectRatioPreset
                                                                      .ratio3x2,
                                                                  CropAspectRatioPreset
                                                                      .original,
                                                                  CropAspectRatioPreset
                                                                      .ratio4x3,
                                                                  CropAspectRatioPreset
                                                                      .ratio16x9
                                                                ],
                                                                uiSettings: [
                                                                  AndroidUiSettings(
                                                                      toolbarTitle:
                                                                          'Cropper',
                                                                      activeControlsWidgetColor:
                                                                          Color(
                                                                              0xffED1C25),
                                                                      toolbarColor:
                                                                          Color(
                                                                              0xffED1C25),
                                                                      toolbarWidgetColor:
                                                                          Colors
                                                                              .white,
                                                                      initAspectRatio:
                                                                          CropAspectRatioPreset
                                                                              .original,
                                                                      lockAspectRatio:
                                                                          false),
                                                                  IOSUiSettings(
                                                                    title:
                                                                        'Cropper',
                                                                  ),
                                                                  WebUiSettings(
                                                                    context:
                                                                        context,
                                                                  ),
                                                                ],
                                                              );

                                                              if (croppedFile !=
                                                                  null) {
                                                                print(
                                                                    'Image cropped and saved at: ${croppedFile.path}');
                                                                BlocProvider.of<
                                                                            AddPostCubit>(
                                                                        context)
                                                                    .UplodeImageAPI(
                                                                        context,
                                                                        medium1?.filename ??
                                                                            '',
                                                                        croppedFile
                                                                            .path);
                                                              } else {
                                                                BlocProvider.of<
                                                                            AddPostCubit>(
                                                                        context)
                                                                    .UplodeImageAPI(
                                                                        context,
                                                                        medium1?.filename ??
                                                                            '',
                                                                        file?.path ??
                                                                            '');
                                                              }
                                                            },
                                                            child: Container(
                                                              height: 100,
                                                              width: 100,
                                                              decoration: BoxDecoration(
                                                                  color: Colors
                                                                          .grey[
                                                                      300],
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              10)),
                                                              child: ClipRRect(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            10),
                                                                child:
                                                                    FadeInImage(
                                                                  fit: BoxFit
                                                                      .cover,
                                                                  placeholder:
                                                                      MemoryImage(
                                                                          kTransparentImage),
                                                                  image:
                                                                      ThumbnailProvider(
                                                                    mediumId:
                                                                        medium
                                                                            .id,
                                                                    mediumType:
                                                                        medium
                                                                            .mediumType,
                                                                    highQuality:
                                                                        true,
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
                                  /*   GestureDetector(
                                      onTap: () {},
                                      child: Icon(
                                        Icons.videocam,
                                        color: Colors.red,
                                      )), */

                                  /*  SizedBox(
                                    width: 30,
                                  ),
                                  Image.asset(
                                    ImageConstant.Gif_icon,
                                    height: 20,
                                  ), */
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
            )),
          ),
        );
      },
    );
  }

  onChangeMethod(String value) {
    if (value.contains('@')) {
      print("if this condison is working-${value}");
      if (value.length >= 3 && value.contains('@')) {
        print("value check --${value.endsWith(' #')}");
        if (value.endsWith(' #')) {
          String data1 = value.split(' #').last.replaceAll('#', '');
          BlocProvider.of<AddPostCubit>(context)
              .GetAllHashtag(context, '10', '#${data1.trim()}');
        } else {
          String data = value.split(' @').last.replaceAll('@', '');
          BlocProvider.of<AddPostCubit>(context)
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
      BlocProvider.of<AddPostCubit>(context)
          .GetAllHashtag(context, '10', '#${data1.trim()}');
    } else {
      setState(() {
        // postText.text = postText.text + ' ' + postTexContrlloer.join(' ,');
        isTagData = false;
        isHeshTegData = false;
      });
    }
  }
/* 
  onChangeMethod(String value) {
    if (value.contains('@')) {
      print("value@ -$value");
      setState(() {
        isHeshTegData = false;
        isTagData = true;
      });
      String data = value.split(' @').last.replaceAll('@', '');

      if (mounted) {
        print("Data check-${data.trim()}");
        print("check endwith-${data.endsWith(' #')}");
        print("DatAddin@-${data.length}");

        if (data.endsWith(' #')) {
          setState(() {
            isHeshTegData = true;
            isTagData = false;
          });
          String data1 = data.split(' #').last.replaceAll('#', '');
          BlocProvider.of<AddPostCubit>(context)
              .GetAllHashtag(context, '10', '#${data1.trim()}');
        }
        if (data.length <= 3 && value.contains('@')) {
          setState(() {
            isHeshTegData = false;
            isTagData = true;
          });
          print("then if cnosin  is working");
          BlocProvider.of<AddPostCubit>(context)
              .search_user_for_inbox(context, '${data.trim()}', '1');
        }
      }
    } else if (value.contains('#')) {
      print("value#-${value}");
      print("value#-${value.endsWith(',@')}");

      String data = value.split(' #').last.replaceAll('#', '');
      setState(() {
        isHeshTegData = true;
      });
      print("Data Length-$data");
      if (data.length <= 1) {
        BlocProvider.of<AddPostCubit>(context)
            .GetAllHashtag(context, '10', '#${data.trim()}');
      }
    } else {
      setState(() {
        isHeshTegData = false;
        isTagData = false;
      });
    }
    /*     if (value.contains('#')) {
                                        setState(() {
                                          isHeshTegData = true;
                                        });
                                        if (value.contains(' #')) {
                                          print("check data Get in #-${value}");
                                          if (value.length >= 1) {
                                            BlocProvider.of<AddPostCubit>(
                                                    context)
                                                .GetAllHashtag(context, '10',
                                                    value.split(' ').last);
                                          }
                                        } else {
                                          print("checl Else condoins-${value}");
                                          if (value.endsWith('@')) {
                                            String data = value
                                                .split(' @')
                                                .last
                                                .replaceAll('@', '');
                                            if (mounted) {
                                              setState(() {
                                                isTagData = true;
                                              });
                                              BlocProvider.of<AddPostCubit>(
                                                      context)
                                                  .search_user_for_inbox(
                                                      context,
                                                      data.trim(),
                                                      '1');
                                            }
                                          } else {
                                            if (value.length >= 1) {
                                              BlocProvider.of<AddPostCubit>(
                                                      context)
                                                  .GetAllHashtag(context, '10',
                                                      value.trim());
                                            } else {
                                              setState(() {
                                                isHeshTegData = false;
                                                isTagData = false;
                                              });
                                            }
                                          }
                                        }
                                      } else if (value.contains('@')) {
                                        if (value.length >= 3) {
                                          if (value.contains(' @')) {
                                            String data = value
                                                .split(' @')
                                                .last
                                                .replaceAll('@', '');
                                            if (mounted) {
                                              setState(() {
                                                isTagData = true;
                                              });
                                              BlocProvider.of<AddPostCubit>(
                                                      context)
                                                  .search_user_for_inbox(
                                                      context,
                                                      data.trim(),
                                                      '1');
                                            }
                                          } else {
                                            String data =
                                                value.replaceAll('@', '');
                                            if (mounted) {
                                              setState(() {
                                                isTagData = true;
                                              });
                                            }

                                            BlocProvider.of<AddPostCubit>(
                                                    context)
                                                .search_user_for_inbox(
                                                    context, data.trim(), '1');
                                          }
                                        } else {
                                          setState(() {
                                            isTagData = false;
                                          });
                                        }
                                      } else {
                                        setState(() {
                                          isHeshTegData = false;
                                          isTagData = false;
                                        });
                                      } */
  } */

  bool _isGifOrSvg(String imagePath) {
    // Check if the image file has a .gif or .svg extension
    final lowerCaseImagePath = imagePath.toLowerCase();
    return lowerCaseImagePath.endsWith('.gif') ||
        lowerCaseImagePath.endsWith('.svg') ||
        lowerCaseImagePath.endsWith('.pdf') ||
        lowerCaseImagePath.endsWith('.doc') ||
        lowerCaseImagePath.endsWith('.mp4') ||
        lowerCaseImagePath.endsWith('.mov') ||
        lowerCaseImagePath.endsWith('.mp3') ||
        lowerCaseImagePath.endsWith('.m4a');
  }

  Future<void> _getImageFromCamera() async {
    try {
      pickedFile = await _imagePicker.pickImage(source: ImageSource.camera);

      if (pickedFile != null) {
        if (!_isGifOrSvg(pickedFile!.path)) {
          pickedImage.add(File(pickedFile!.path));
          getFileSize1(pickedImage, 1, 0);
        } else {
          if ((pickedFile?.path.contains(".mp4") ?? false) ||
              (pickedFile?.path.contains(".mov") ?? false) ||
              (pickedFile?.path.contains(".mp3") ?? false) ||
              (pickedFile?.path.contains(".m4a") ?? false)) {
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
      }
    } catch (e) {}
  }

  Future<void> _getImageFromSource() async {
    try {
      final pickedFile = await _imagePicker.pickMultiImage();
      List<XFile> xFilePicker = pickedFile;

      pickedImage.clear();
      if (xFilePicker.isNotEmpty) {
        if (xFilePicker.length <= 5) {
          for (var i = 0; i < xFilePicker.length; i++) {
            if (!_isGifOrSvg(xFilePicker[i].path)) {
              pickedImage.add(File(xFilePicker[i].path));
              setState(() {});
              getFileSize1(pickedImage, 1, i);
              if ((xFilePicker[i].path.contains(".mp4")) ||
                  (xFilePicker[i].path.contains(".mov")) ||
                  (xFilePicker[i].path.contains(".mp3")) ||
                  (xFilePicker[i].path.contains(".m4a"))) {
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

  Future getVideo() async {
    final pickedFile = await _imagePicker.pickVideo(
        source: ImageSource.gallery,
        preferredCameraDevice: CameraDevice.front,
        maxDuration: const Duration(minutes: 10));
    XFile? xfilePick = pickedFile;
    setState(
      () {
        galleryFile.clear();
        if (xfilePick != null) {
          galleryFile.add(File(pickedFile!.path));
          BlocProvider.of<AddPostCubit>(context).UplodeImageAPIImane(
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

        if ((file.path?.contains(".mp4") ?? false) ||
            (file.path?.contains(".mov") ?? false) ||
            (file.path?.contains(".mp3") ?? false) ||
            (file.path?.contains(".png") ?? false) ||
            (file.path?.contains(".doc") ?? false) ||
            (file.path?.contains(".jpg") ?? false) ||
            (file.path?.contains(".m4a") ?? false) ||
            (file.path?.contains(".gif") ?? false)) {
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

  getFileSize1(List<File> filepath, int decimals, int Index) async {
    var file = filepath[Index];
    int bytes = await file.length();
    if (bytes <= 0) return "0 B";
    const suffixes = ["B", "KB", "MB", "GB", "TB", "PB", "EB", "ZB", "YB"];
    var i = (log(bytes) / log(1024)).floor();
    var STR = ((bytes / pow(1024, i)).toStringAsFixed(decimals));

    value2 = double.parse(STR);

    print(value2);
    switch (i) {
      case 0:
        print("Done file size B");

        break;
      case 1:
        print("Done file size KB");
        if (Index + 1 < filepath.length) {
          getFileSize1(filepath, decimals, Index + 1);
        } else {
          BlocProvider.of<AddPostCubit>(context).UplodeImageAPIImane(
            context,
            pickedImage,
          );
        }

        setState(() {});

        break;
      case 2:
        if (value2 > documentuploadsize) {
          print(
              "this file size ${value2} ${suffixes[i]} Selected Max size ${documentuploadsize}MB");

          showDialog(
            context: context,
            builder: (ctx) => AlertDialog(
              title: Text("Max Size ${documentuploadsize}MB"),
              content: Text(
                  "This file size ${value2} ${suffixes[i]} Selected Max size ${documentuploadsize}MB"),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    if (Index + 1 < filepath.length) {
                      getFileSize1(filepath, decimals, Index + 1);
                    }
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
          if (Index + 1 < filepath.length) {
            getFileSize1(filepath, decimals, Index + 1);
          } else {
            BlocProvider.of<AddPostCubit>(context).UplodeImageAPIImane(
              context,
              pickedImage,
            );
          }
        }

        break;
      default:
    }
    file12 = null;

    return STR;
  }

  ////
  getFileSize(
      String filepath, int decimals, PlatformFile file1, int Index) async {
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
              setState(() {
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
              setState(() {
                file12 = file1;
              });
            }

            break;
          default:
        }
        print('filenamecheckKB-${file1.path}');
        print("file111.name-->${file1.name}");
        BlocProvider.of<AddPostCubit>(context)
            .UplodeImageAPI(context, file1.name, file1.path.toString());

        setState(() {});

        break;
      case 2:
        print("value2check-->$value2");
        print("finalFileSize-->${finalFileSize}");

        if (value2 > finalFileSize) {
          print(
              "this file size ${value2} ${suffixes[i]} Selected Max size ${finalFileSize}MB");

          showDialog(
            context: context,
            builder: (ctx) => AlertDialog(
              title: Text("Max Size ${finalFileSize}MB"),
              content: Text(
                  "This file size ${value2} ${suffixes[i]} Selected Max size ${finalFileSize}MB"),
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
          setState(() {
            file12 = file1;
          });

          BlocProvider.of<AddPostCubit>(context)
              .UplodeImageAPI(context, file1.name, file1.path.toString());
        }

        break;
      default:
    }

    return STR;
  }
  ////

  dataPostFucntion() {
    print("dfhghghfhgh-${pickedFile?.path}");
    print("FBSDFNFBDBFSBF--${postText.text.length}");

    // String text = postText.text;
    RegExp exp = new RegExp(r"\B#\w+");

    if (postText.text.length >= 1000) {
      CreatePostDone = false;
      SnackBar snackBar = SnackBar(
        content: Text('Please enter less than 1000 letter!!'),
        backgroundColor: ColorConstant.primary_color,
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } else {
      exp.allMatches(postText.text).forEach((match) {
        var aa = "${match.group(0)}";
        print(
            "aa.length aa.length aa.length aa.length aa.length aa.length aa.length aa.length aa.length aa.length ");
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
        /* if (postText.text.length >= 1000) {
          SnackBar snackBar = SnackBar(
            content: Text('Please enter less than 1000 letter!!'),
            backgroundColor: ColorConstant.primary_color,
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        } else { */
        if (CreatePostDone == true) {
          if (postText.text.isNotEmpty && file?.path != null) {
            Map<String, dynamic> param = {
              "description": postText.text,
              "postData": imageDataPost?.object?.data,
              "postDataType": "IMAGE",
              "postType": soicalData[indexx].toString().toUpperCase()
            };
            BlocProvider.of<AddPostCubit>(context)
                .InvitationAPI(context, param);
          } else if (postText.text.isNotEmpty && file12?.path != null) {
            Map<String, dynamic> param = {
              "description": postText.text,
              "postData": imageDataPost?.object?.data,
              "postDataType": "ATTACHMENT",
              "postType": soicalData[indexx].toString().toUpperCase()
            };
            BlocProvider.of<AddPostCubit>(context)
                .InvitationAPI(context, param);
          } else if (postText.text.isNotEmpty && pickedImage.isNotEmpty) {
            Map<String, dynamic> param = {
              "description": postText.text,
              "postData": imageDataPost?.object?.data,
              "postDataType": "IMAGE",
              "postType": soicalData[indexx].toString().toUpperCase()
            };
            BlocProvider.of<AddPostCubit>(context)
                .InvitationAPI(context, param);
          } else if (pickedFile?.path != null && postText.text.isNotEmpty) {
            Map<String, dynamic> param = {
              "description": postText.text,
              "postData": imageDataPost?.object?.data,
              "postDataType": "IMAGE",
              "postType": soicalData[indexx].toString().toUpperCase()
            };
            BlocProvider.of<AddPostCubit>(context)
                .InvitationAPI(context, param);
          } else if (postText.text.isNotEmpty &&
              _controller?.value.isPlaying == true) {
            Map<String, dynamic> param = {
              "description": postText.text,
              "postData": imageDataPost?.object?.data,
              "postDataType": "VIDEO",
              "postType": soicalData[indexx].toString().toUpperCase()
            };
            BlocProvider.of<AddPostCubit>(context)
                .InvitationAPI(context, param);
          } else {
            if (postText.text.isNotEmpty) {
              Map<String, dynamic> param = {};
              if (widget.edittextdata != "" || widget.edittextdata != null) {
                param = {
                  "description": postText.text,
                  "postType": soicalData[indexx].toString().toUpperCase(),
                  "postUid": widget.PostID
                };
              } else {
                param = {
                  "description": postText.text,
                  "postType": soicalData[indexx].toString().toUpperCase()
                };
              }

              BlocProvider.of<AddPostCubit>(context)
                  .InvitationAPI(context, param);
            } else if (file?.path != null) {
              Map<String, dynamic> param = {
                "postData": imageDataPost?.object?.data,
                "postDataType": "IMAGE",
                "postType": soicalData[indexx].toString().toUpperCase(),
              };
              BlocProvider.of<AddPostCubit>(context)
                  .InvitationAPI(context, param);
            } else if (pickedFile?.path != null) {
              Map<String, dynamic> param = {
                "postData": imageDataPost?.object?.data,
                "postDataType": "IMAGE",
                "postType": soicalData[indexx].toString().toUpperCase(),
              };
              BlocProvider.of<AddPostCubit>(context)
                  .InvitationAPI(context, param);
            } else if (file12?.path != null) {
              Map<String, dynamic> param = {
                "postData": imageDataPost?.object?.data,
                "postDataType": "ATTACHMENT",
                "postType": soicalData[indexx].toString().toUpperCase(),
              };
              BlocProvider.of<AddPostCubit>(context)
                  .InvitationAPI(context, param);
            } else if (pickedImage.isNotEmpty) {
              Map<String, dynamic> param = {
                "postData": imageDataPost?.object?.data,
                "postDataType": "IMAGE",
                "postType": soicalData[indexx].toString().toUpperCase(),
              };
              BlocProvider.of<AddPostCubit>(context)
                  .InvitationAPI(context, param);
            } else if (_controller?.value.isPlaying == true) {
              Map<String, dynamic> param = {
                "postData": imageDataPost?.object?.data,
                "postDataType": "VIDEO",
                "postType": soicalData[indexx].toString().toUpperCase(),
              };
              BlocProvider.of<AddPostCubit>(context)
                  .InvitationAPI(context, param);
            } else {
              SnackBar snackBar = SnackBar(
                content: Text('Please Select Image either fill Text'),
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

  void _showPopupMenu(
    Offset position,
    BuildContext context,
  ) async {
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
            soicalData.length,
            (index) => PopupMenuItem(
                onTap: () {
                  setState(() {
                    indexx = index;
                  });
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
                      soicalData[index],
                      style: TextStyle(
                          color: indexx == index ? Colors.white : Colors.black),
                    ),
                  ),
                ))));
    if (selectedOption != null) {
      print("Selected option index: $selectedOption");
    }
  }

  Future<void> initAsync() async {
    if (await _promptPermissionSetting()) {
      List<Album> albums =
          await PhotoGallery.listAlbums(mediumType: MediumType.image);
      if (albums.isNotEmpty) {
        page = await albums.first.listMedia();
      }
      setState(() {
        _albums = albums;
        _loading = false;
      });
    }
    setState(() {
      _loading = false;
    });
  }

  Future<bool> _promptPermissionSetting() async {
    if (Platform.isIOS) {
      if (await Permission.photos.request().isGranted ||
          await Permission.storage.request().isGranted) {
        return true;
      }
    }
    if (Platform.isAndroid) {
      if (await Permission.storage.request().isGranted ||
          await Permission.photos.request().isGranted &&
              await Permission.videos.request().isGranted) {
        return true;
      }
    }
    return false;
  }
}

class ViewerPage extends StatelessWidget {
  final Medium medium;

  ViewerPage(Medium medium) : medium = medium;

  @override
  Widget build(BuildContext context) {
    DateTime? date = medium.creationDate ?? medium.modifiedDate;
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: Icon(Icons.arrow_back_ios),
          ),
          title: date != null ? Text(date.toLocal().toString()) : null,
        ),
        body: Container(
          alignment: Alignment.center,
          child: medium.mediumType == MediumType.image
              ? GestureDetector(
                  onTap: () async {
                    PhotoGallery.deleteMedium(mediumId: medium.id);
                  },
                  child: FadeInImage(
                    fit: BoxFit.cover,
                    placeholder: MemoryImage(kTransparentImage),
                    image: PhotoProvider(mediumId: medium.id),
                  ),
                )
              : VideoProvider(
                  mediumId: medium.id,
                ),
        ),
      ),
    );
  }
}

class CustomTextEditingController extends TextEditingController {
  Color currentColor = Colors.black;

  void updateColor() {
    final String text = this.text;
    final int lastSpaceIndex = text.lastIndexOf(' ');

    if (lastSpaceIndex == -1) {
      currentColor = Colors.black;
    } else {
      currentColor = Colors.green;
    }
  }
}
