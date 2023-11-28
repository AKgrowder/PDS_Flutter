import 'dart:io';
import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:getwidget/components/loader/gf_loader.dart';
import 'package:getwidget/types/gf_loader_type.dart';
import 'package:hashtagable/widgets/hashtag_text.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:pds/API/Bloc/RePost_Bloc/RePost_cubit.dart';
import 'package:pds/API/Bloc/RePost_Bloc/RePost_state.dart';
import 'package:pds/API/Model/Add_PostModel/Add_postModel_Image.dart';
import 'package:pds/API/Model/GetGuestAllPostModel/GetGuestAllPost_Model.dart';
import 'package:pds/API/Model/OpenSaveImagepostModel/OpenSaveImagepost_Model.dart';
import 'package:pds/core/utils/color_constant.dart';
import 'package:pds/core/utils/image_constant.dart';
import 'package:pds/core/utils/sharedPreferences.dart';
import 'package:pds/presentation/%20new/newbottembar.dart';
import 'package:pds/presentation/%20new/profileNew.dart';
import 'package:pds/presentation/Create_Post_Screen/CreatePostShow_ImageRow/photo_gallery-master/example/lib/main.dart';
import 'package:pds/widgets/commentPdf.dart';
import 'package:pds/widgets/custom_image_view.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:transparent_image/transparent_image.dart';

import '../../API/Model/HashTage_Model/HashTagView_model.dart';
import '../Create_Post_Screen/CreatePostShow_ImageRow/photo_gallery-master/lib/photo_gallery.dart';

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
  RePostScreen({
    Key? key,
    this.username,
    this.postData,
    this.date,
    this.desc,
    this.userProfile,
    this.postDataType,
    this.index,
    this.AllGuestPostRoomData,
    this.postUid,
    this.hashTagViewData,
    this.OpenSaveModelData,
  }) : super(key: key);

  @override
  State<RePostScreen> createState() => _RePostScreenState();
}

class _RePostScreenState extends State<RePostScreen> {
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
  TextEditingController postText = TextEditingController();
  List<String> soicalData = ["Following", "Public"];
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
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) => setState(() {
            added = true;
          }));
    }
    return BlocConsumer<RePostCubit, RePostState>(listener: (context, state) {
      if (state is AddPostImaegState) {
        imageDataPost = state.imageDataPost;
        if (state.imageDataPost.object?.status == 'failed') {
          isTrue = true;
          imageDataPost?.object?.data = null;
        } else {
          isTrue = true;

          print("imageDataPost-->${imageDataPost?.object?.data}");
        }
      }
      if (state is RePostLoadedState) {
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
                                  dataPostFucntion();
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: primaryColor,
                                      borderRadius: BorderRadius.circular(14)),
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
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => ProfileScreen(
                                                User_ID: "${User_ID}",
                                                isFollowing: 'FOLLOW',
                                              )));
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
                                              UserProfileImage.toString()),
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
                                        color: Color(0xffED1C25),
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
                                              color:
                                                  ColorConstant.primary_color,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Spacer(),
                                      Padding(
                                        padding: EdgeInsets.only(right: 7),
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
                      SingleChildScrollView(
                        child: Padding(
                          padding:
                              EdgeInsets.only(left: 16, right: 16, top: 15),
                          child: SizedBox(
                            width: _width,
                            child: Column(
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(top: 0.0, left: 10),
                                  child: TextFormField(
                                    controller: postText,
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
                                      setState(() {
                                        primaryColor = value.isNotEmpty
                                            ? ColorConstant.primary_color
                                            : ColorConstant.primaryLight_color;
                                        textColor = value.isNotEmpty
                                            ? Colors.white
                                            : ColorConstant.primary_color;
                                      });
                                    },
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 5),
                                  child: SizedBox(
                                    child: file12?.path != null
                                        ? Container(
                                            height: 400,
                                            width: _width,
                                            child: DocumentViewScreen1(
                                              path: imageDataPost?.object
                                                  .toString(),
                                            ))
                                        : pickedImage.isNotEmpty
                                            ? _loading
                                                ? Center(
                                                    child: Container(
                                                      margin: EdgeInsets.only(
                                                          bottom: 100),
                                                      child: ClipRRect(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(20),
                                                        child: Image.asset(
                                                            ImageConstant
                                                                .loader,
                                                            fit: BoxFit.cover,
                                                            height: 100,
                                                            width: 100),
                                                      ),
                                                    ),
                                                  )
                                                : isTrue == true
                                                    ? imageDataPost?.object
                                                                ?.data !=
                                                            null
                                                        ? SizedBox(
                                                            height:
                                                                _height / 1.5,
                                                            width: _width,
                                                            child: PageView
                                                                .builder(
                                                              onPageChanged:
                                                                  (value) {
                                                                setState(() {
                                                                  _currentPages =
                                                                      value;
                                                                });
                                                              },
                                                              itemCount:
                                                                  imageDataPost
                                                                      ?.object
                                                                      ?.data
                                                                      ?.length,
                                                              controller:
                                                                  _pageControllers,
                                                              itemBuilder:
                                                                  (context,
                                                                      index) {
                                                                return SizedBox(
                                                                    height:
                                                                        _height /
                                                                            2,
                                                                    width:
                                                                        _width,
                                                                    child:
                                                                        Padding(
                                                                      padding:
                                                                          const EdgeInsets.all(
                                                                              8.0),
                                                                      child:
                                                                          CachedNetworkImage(
                                                                        imageUrl:
                                                                            '${imageDataPost?.object?.data?[index]}',
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
                                                        MediumType.image
                                                    ? GestureDetector(
                                                        onTap: () async {
                                                          print("fgfgfhg");
                                                        },
                                                        child: FadeInImage(
                                                          fit: BoxFit.cover,
                                                          placeholder: MemoryImage(
                                                              kTransparentImage),
                                                          image: PhotoProvider(
                                                              mediumId:
                                                                  medium1!.id),
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
                                imageDataPost?.object?.data != null &&
                                        imageDataPost?.object?.data?.length != 1
                                    ? Container(
                                        height: 20,
                                        child: DotsIndicator(
                                          dotsCount: imageDataPost
                                                  ?.object?.data?.length ??
                                              0,
                                          position: _currentPages.toDouble(),
                                          decorator: DotsDecorator(
                                            size: const Size(10.0, 7.0),
                                            activeSize: const Size(10.0, 10.0),
                                            spacing: const EdgeInsets.symmetric(
                                                horizontal: 2),
                                            activeColor: Color(0xffED1C25),
                                            color: Color(0xff6A6A6A),
                                          ),
                                        ),
                                      )
                                    : SizedBox(),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 10, right: 10, bottom: 10, top: 20),
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        border: Border.all(
                                            color:
                                                Color.fromRGBO(0, 0, 0, 0.25)),
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
                                                      backgroundColor:
                                                          Colors.white,
                                                      backgroundImage: NetworkImage(
                                                          "${widget.userProfile}"),
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
                                                Container(
                                                  child: Text(
                                                    "${widget.username}",
                                                    style: TextStyle(
                                                        fontSize: 20,
                                                        fontFamily: "outfit",
                                                        fontWeight:
                                                            FontWeight.bold),
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
                                                padding: const EdgeInsets.only(
                                                    left: 16),
                                                child: HashTagText(
                                                  text: "${widget.desc}",
                                                  decoratedStyle: TextStyle(
                                                      fontFamily: "outfit",
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: ColorConstant
                                                          .HasTagColor),
                                                  basicStyle: TextStyle(
                                                      fontFamily: "outfit",
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.black),
                                                  onTap: (text) {},
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
                                          child: Container(
                                            width: _width,
                                            child: widget.postDataType == null
                                                ? SizedBox()
                                                : widget.postData?.length == 1
                                                    ? widget.postDataType ==
                                                            "IMAGE"
                                                        ? Container(
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
                                                                  "${widget.postData?[0]}",
                                                            )),
                                                          )
                                                        : widget.postDataType ==
                                                                "ATTACHMENT"
                                                            ? Container(
                                                                height: 400,
                                                                width: _width,
                                                                child:
                                                                    DocumentViewScreen1(
                                                                  path: "",
                                                                ))
                                                            : SizedBox()
                                                    : Column(
                                                        children: [
                                                          Stack(
                                                            children: [
                                                              if ((widget
                                                                      .postData
                                                                      ?.isNotEmpty ??
                                                                  false)) ...[
                                                                SizedBox(
                                                                  height: 300,
                                                                  child: PageView
                                                                      .builder(
                                                                    onPageChanged:
                                                                        (page) {
                                                                      setState(
                                                                          () {
                                                                        currentPages[widget.index ??
                                                                                0] =
                                                                            page;
                                                                      });
                                                                    },
                                                                    controller:
                                                                        pageControllers[
                                                                            widget.index ??
                                                                                0],
                                                                    itemCount: widget
                                                                        .postData
                                                                        ?.length,
                                                                    itemBuilder:
                                                                        (BuildContext
                                                                                context,
                                                                            int index1) {
                                                                      if (widget
                                                                              .postDataType ==
                                                                          "IMAGE") {
                                                                        return Container(
                                                                          width:
                                                                              _width,
                                                                          margin: EdgeInsets.only(
                                                                              left: 16,
                                                                              top: 15,
                                                                              right: 16),
                                                                          child: Center(
                                                                              child: CustomImageView(
                                                                            url:
                                                                                "${widget.postData?[index1]}",
                                                                          )),
                                                                        );
                                                                      } else if (widget
                                                                              .postDataType ==
                                                                          "ATTACHMENT") {
                                                                        return Container(
                                                                            height:
                                                                                400,
                                                                            width:
                                                                                _width,
                                                                            child:
                                                                                DocumentViewScreen1(
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
                                                                              widget.postData?.length ?? 1,
                                                                          position:
                                                                              currentPages[widget.index ?? 0].toDouble(),
                                                                          decorator:
                                                                              DotsDecorator(
                                                                            size:
                                                                                const Size(10.0, 7.0),
                                                                            activeSize:
                                                                                const Size(10.0, 10.0),
                                                                            spacing:
                                                                                const EdgeInsets.symmetric(horizontal: 2),
                                                                            activeColor:
                                                                                Color(0xffED1C25),
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
                      Container(
                        color: Colors.white,
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
                                      borderRadius: BorderRadius.circular(20),
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
                                        margin: EdgeInsets.only(bottom: 100),
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
                                            (constraints.maxWidth - 20) / 3;
                                        double gridHeight = gridWidth + 33;
                                        double ratio = gridWidth / gridHeight;
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
                                                    (medium) => GestureDetector(
                                                      onTap: () async {
                                                        medium1 = medium;
                                                        selectImage = true;

                                                        file =
                                                            await PhotoGallery
                                                                .getFile(
                                                          mediumId: medium1!.id,
                                                          mediumType:
                                                              MediumType.image,
                                                        );
                                                        file12 = null;
                                                        pickedImage.isEmpty;
                                                        setState(() {});
                                                        print(
                                                            "medium1!.id--.${medium1?.filename}");
                                                        BlocProvider.of<
                                                                    RePostCubit>(
                                                                context)
                                                            .UplodeImageAPI(
                                                                context,
                                                                medium1?.filename ??
                                                                    '',
                                                                file?.path ??
                                                                    '');
                                                      },
                                                      child: Container(
                                                        height: 100,
                                                        width: 100,
                                                        decoration: BoxDecoration(
                                                            color: Colors
                                                                .grey[300],
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10)),
                                                        child: ClipRRect(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                          child: FadeInImage(
                                                            fit: BoxFit.cover,
                                                            placeholder:
                                                                MemoryImage(
                                                                    kTransparentImage),
                                                            image:
                                                                ThumbnailProvider(
                                                              mediumId:
                                                                  medium.id,
                                                              mediumType: medium
                                                                  .mediumType,
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
                            Image.asset(
                              ImageConstant.Gif_icon,
                              height: 20,
                            ),
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
        for (var i = 0; i < xFilePicker.length; i++) {
          if (!_isGifOrSvg(xFilePicker[i].path)) {
            pickedImage.add(File(xFilePicker[i].path));
            setState(() {});
            getFileSize1(pickedImage[i].path, 1, pickedImage[i], 0);
          }
          print("xFilePickerxFilePicker - ${xFilePicker[i].path}");
        }
      }
      /*   if (!_isGifOrSvg(pickedFile!.path)) {
          pickedImage = File(pickedFile!.path);
          setState(() {});
          getFileSize1(pickedImage!.path, 1, pickedImage!, 0);
        } */
      else {
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
    return lowerCaseImagePath.endsWith('.gif') ||
        lowerCaseImagePath.endsWith('.svg') ||
        lowerCaseImagePath.endsWith('.pdf') ||
        lowerCaseImagePath.endsWith('.doc') ||
        lowerCaseImagePath.endsWith('.mp4') ||
        lowerCaseImagePath.endsWith('.mov') ||
        lowerCaseImagePath.endsWith('.mp3') ||
        lowerCaseImagePath.endsWith('.m4a');
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

  prepareTestPdf(
    int Index,
  ) async {
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
            (file.path?.contains(".m4a") ?? false)) {
          showDialog(
            context: context,
            builder: (ctx) => AlertDialog(
              title: Text(
                "Selected File Error",
                textScaleFactor: 1.0,
              ),
              content: Text(
                "Only PDF Allowed",
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
        BlocProvider.of<RePostCubit>(context)
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

          BlocProvider.of<RePostCubit>(context)
              .UplodeImageAPI(context, file1.name, file1.path.toString());
        }

        break;
      default:
    }

    return STR;
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
            BlocProvider.of<RePostCubit>(context)
                .RePostAPI(context, param, widget.postUid);
          } else if (postText.text.isNotEmpty && file12?.path != null) {
            Map<String, dynamic> param = {
              "description": postText.text,
              "postData": imageDataPost?.object?.data,
              "postDataType": "ATTACHMENT",
              "postType": soicalData[indexx].toString().toUpperCase()
            };
            BlocProvider.of<RePostCubit>(context)
                .RePostAPI(context, param, widget.postUid);
          } else if (postText.text.isNotEmpty && pickedImage.isNotEmpty) {
            Map<String, dynamic> param = {
              "description": postText.text,
              "postData": imageDataPost?.object?.data,
              "postDataType": "IMAGE",
              "postType": soicalData[indexx].toString().toUpperCase()
            };
            BlocProvider.of<RePostCubit>(context)
                .RePostAPI(context, param, widget.postUid);
          } else if (pickedFile?.path != null && postText.text.isNotEmpty) {
            Map<String, dynamic> param = {
              "description": postText.text,
              "postData": imageDataPost?.object?.data,
              "postDataType": "IMAGE",
              "postType": soicalData[indexx].toString().toUpperCase()
            };
            BlocProvider.of<RePostCubit>(context)
                .RePostAPI(context, param, widget.postUid);
          } else {
            if (postText.text.isNotEmpty) {
              Map<String, dynamic> param = {
                "description": postText.text,
                "postType": soicalData[indexx].toString().toUpperCase()
              };
              BlocProvider.of<RePostCubit>(context)
                  .RePostAPI(context, param, widget.postUid);
            } else if (file?.path != null) {
              Map<String, dynamic> param = {
                "postData": imageDataPost?.object?.data,
                "postDataType": "IMAGE",
                "postType": soicalData[indexx].toString().toUpperCase(),
              };
              BlocProvider.of<RePostCubit>(context)
                  .RePostAPI(context, param, widget.postUid);
            } else if (pickedFile?.path != null) {
              Map<String, dynamic> param = {
                "postData": imageDataPost?.object?.data,
                "postDataType": "IMAGE",
                "postType": soicalData[indexx].toString().toUpperCase(),
              };
              BlocProvider.of<RePostCubit>(context)
                  .RePostAPI(context, param, widget.postUid);
            } else if (file12?.path != null) {
              Map<String, dynamic> param = {
                "postData": imageDataPost?.object?.data,
                "postDataType": "ATTACHMENT",
                "postType": soicalData[indexx].toString().toUpperCase(),
              };
              BlocProvider.of<RePostCubit>(context)
                  .RePostAPI(context, param, widget.postUid);
            } else if (pickedImage.isNotEmpty) {
              Map<String, dynamic> param = {
                "postData": imageDataPost?.object?.data,
                "postDataType": "IMAGE",
                "postType": soicalData[indexx].toString().toUpperCase(),
              };
              BlocProvider.of<RePostCubit>(context)
                  .RePostAPI(context, param, widget.postUid);
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
}
