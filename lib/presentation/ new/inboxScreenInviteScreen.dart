import 'dart:io';
import 'dart:math';

import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart' as foundation;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pds/API/Bloc/PersonalChatList_Bloc/PersonalChatList_State.dart';
import 'package:pds/API/Bloc/PersonalChatList_Bloc/PersonalChatList_cubit.dart';
import 'package:pds/API/Model/createDocumentModel/createDocumentModel.dart';
import 'package:pds/API/Model/serchForInboxModel/serchForinboxModel.dart';
import 'package:pds/core/utils/color_constant.dart';
import 'package:pds/core/utils/image_constant.dart';
import 'package:pds/core/utils/sharedPreferences.dart';
import 'package:pds/presentation/DMAll_Screen/Dm_Screen.dart';
import 'package:pds/widgets/pagenation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class InviteMeesage extends StatefulWidget {
  const InviteMeesage({Key? key}) : super(key: key);

  @override
  State<InviteMeesage> createState() => _InviteMeesageState();
}

class _InviteMeesageState extends State<InviteMeesage> {
  TextEditingController searchController = TextEditingController();
  bool isDataGet = false;
  String? UserIndexUUID = "";
  int Index = 0;

  ScrollController scrollController = ScrollController();
  SearchUserForInbox? searchUserForInbox1;
  List MultiUser = [];
  List<Map<String, dynamic>> MultiUsermap = [];
  bool isChecked = false;
  bool isEmojiVisible = false;
  bool isKeyboardVisible = false;
  bool singleTap = false;
  final focusNode = FocusNode();
  XFile? pickedImageFile;
  File? _image;
  double documentuploadsize = 0;
  double finalFileSize = 0;

  ImagePicker picker = ImagePicker();
  FocusNode _focusNode = FocusNode();
  TextEditingController Add_Comment = TextEditingController();
  KeyboardVisibilityController keyboardVisibilityController =
      KeyboardVisibilityController();
  double value2 = 0.0;
  PlatformFile? file12;
  ChooseDocument1? imageDataPost;
  final ScrollController _firstController = ScrollController();
  String? userID;
  getDocumentSize() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    documentuploadsize = await double.parse(
        prefs.getString(PreferencesKey.MaxPostUploadSizeInMB) ?? "0");

    finalFileSize = documentuploadsize;
    userID = prefs.getString(PreferencesKey.loginUserID);
    print("userid-chelc-${userID}");
    setState(() {});
  }

  @override
  void initState() {
    getDocumentSize();
    keyboardVisibilityController.onChange.listen((bool isKeyboardVisible) {
      this.isKeyboardVisible = isKeyboardVisible;

      if (isKeyboardVisible && isEmojiVisible) {
        isEmojiVisible = false;
      }
    });
    getDocumentSize();
    super.initState();
  }

  @override
  void dispose() {
    searchController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  Future<bool> onBackPress() {
    if (isEmojiVisible) {
      toggleEmojiKeyboard();
    } else {
      Navigator.pop(context);
    }

    return Future.value(false);
  }

  Future toggleEmojiKeyboard() async {
    if (isKeyboardVisible) {
      FocusScope.of(context).unfocus();
    }

    setState(() {
      isEmojiVisible = !isEmojiVisible;
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

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    double _height = MediaQuery.of(context).size.height;
    return WillPopScope(
      onWillPop: onBackPress,
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          centerTitle: true,
          elevation: 0,
          leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              Icons.arrow_back,
              color: Colors.grey,
            ),
          ),
          title: Text(
            'New Message',
            style: TextStyle(color: Colors.black),
          ),
        ),
        body: BlocConsumer<PersonalChatListCubit, PersonalChatListState>(
          listener: (context, state) {
            if (state is SearchHistoryDataAddxtends) {
              isDataGet = true;
              searchUserForInbox1 = state.searchUserForInbox;
              searchUserForInbox1?.object?.content?.forEach((element) {
                if (userID == element.userUid)
                  searchUserForInbox1?.object?.content?.remove(element);
              });
            }
            if (state is DMChatListLoadedState) {
              print(state.DMChatList.object);
              UserIndexUUID = state.DMChatList.object;

              if (UserIndexUUID != "" && UserIndexUUID != null) {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return DmScreen(
                    UserUID:
                        "${searchUserForInbox1?.object?.content?[Index].userUid}",
                    UserName:
                        "${searchUserForInbox1?.object?.content?[Index].userName}",
                    ChatInboxUid: UserIndexUUID ?? "",
                    UserImage:
                        "${searchUserForInbox1?.object?.content?[Index].userProfilePic}",
                  );
                }));
                // UserIndexUUID = "";
              }
            }
            if (state is SelectMultipleUsers_ChatLoadestate) {
              MultiUser = [];
              MultiUsermap.clear();
              _image = null;
              isDataGet = false;
              Add_Comment.clear();
              searchController.clear();
              SnackBar snackBar = SnackBar(
                content:
                    Text(state.selectMultipleUsersChatModel.object.toString()),
                backgroundColor: ColorConstant.primary_color,
              );
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            }
            if (state is AddPostImaegState) {
              imageDataPost = state.imageDataPost;
            }
          },
          builder: (context, state) {
            return Column(
              children: [
                if (MultiUsermap.isNotEmpty)
                  Container(
                    width: MediaQuery.of(context).size.width,
                    constraints: BoxConstraints(
                      maxHeight: 100,
                      minHeight: 50,
                    ),
                    decoration: BoxDecoration(
                        border: Border.all(
                      color: Colors.grey.withOpacity(0.5),
                    )),
                    child: RawScrollbar(
                      thumbVisibility: true,
                      thumbColor: Colors.grey,
                      minOverscrollLength: 2,
                      minThumbLength: 30,
                      thickness: 10,
                      radius: const Radius.circular(5),
                      controller: _firstController,
                      child: ScrollConfiguration(
                        behavior: ScrollConfiguration.of(context)
                            .copyWith(scrollbars: false),
                        child: SingleChildScrollView(
                          controller: _firstController,
                          // physics: widget.pickedItemsScrollPhysics,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Wrap(
                              spacing: 5,
                              runSpacing: 5,
                              children: MultiUsermap.map((Element) => Container(
                                    height: 40,
                                    decoration: BoxDecoration(
                                      color: Color(0xffED1C25),
                                      borderRadius: BorderRadius.circular(20),
                                      border:
                                          Border.all(color: Colors.grey[400]!),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8),
                                      child: FittedBox(
                                        child: Row(
                                          children: [
                                            Text(
                                              Element['username'],
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            GestureDetector(
                                                onTap: () {
                                                  setState(() {
                                                    MultiUser.forEach(
                                                        (element) {
                                                      if (element ==
                                                          Element['userUid']) {
                                                        MultiUser.remove(
                                                            element);
                                                      }
                                                    });
                                                    MultiUsermap.remove(
                                                        Element);
                                                    /* if(Element['userUid']) */
                                                  });
                                                },
                                                child: Container(
                                                    height: 25,
                                                    width: 25,
                                                    color: Colors.transparent,
                                                    child: Icon(
                                                      Icons.close,
                                                      color: Colors.white,
                                                    )))
                                          ],
                                        ),
                                      ),
                                    ),
                                  )).toList(),
                              /* children: [
                                /* ...MultiUsermap.map(
                                  (e) => TapRegion(
                                    onTapInside: (event) {
                                      /*    if (widget.isOverlay) {
                                        _overlayPortalController.show();
                                      } */
                                    },
                                    child: GestureDetector(
                                      behavior: HitTestBehavior.opaque,
                                      onTap: () {
                                        // _onRemoveItem(e);
                                      },
                                      child: IgnorePointer(
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            border: Border.all(
                                                color: Colors.grey[400]!),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(8),
                                            child: Text('ankur'),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ), */
                              ], */
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),

                /* if (MultiUser.isNotEmpty)
                  Flexible(
                    child: Container(
                      child: GridView.builder(
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        itemCount: MultiUser.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2, // Number of columns
                          mainAxisSpacing: 1, // Vertical spacing between items
                          crossAxisSpacing:
                              0, // Horizontal spacing between items
                        ),
                        itemBuilder: (context, index) {
                          return Text(MultiUser[index]);
                        },
                      ),
                    ),
                  ), */
                Padding(
                  padding: const EdgeInsets.only(top: 15, left: 16, right: 16),
                  child: Container(
                    height: 48,
                    decoration: BoxDecoration(
                        color: Color(0xffFBD8D9),
                        border: Border.all(
                          color: ColorConstant.primary_color,
                        ),
                        borderRadius: BorderRadius.circular(10)),
                    child: TextFormField(
                      // focusNode: _focusNode,
                      onChanged: (value) {
                        print("value check if their-$value");
                        if (value.isNotEmpty) {
                          BlocProvider.of<PersonalChatListCubit>(context)
                              .search_user_for_inbox(
                                  context, searchController.text.trim(), '1');
                        } else if (value.isEmpty) {
                          print("Check value-${value}");
                          searchController.clear();
                          setState(() {
                            isDataGet = false;
                          });
                        }
                      },
                      controller: searchController,
                      cursorColor: ColorConstant.primary_color,
                      decoration: InputDecoration(
                          suffixIcon: IconButton(
                              onPressed: () {
                                print("vgfdghdfgh");
                                searchController.clear();
                                setState(() {
                                  _focusNode.unfocus();
                                  isDataGet = false;
                                });
                                print("dhfdsfbdf-$isDataGet");
                              },
                              icon: Icon(
                                Icons.close,
                                color: Colors.black,
                              )),
                          hintText: "Search....",
                          hintStyle:
                              TextStyle(color: ColorConstant.primary_color),
                          border: InputBorder.none,
                          prefixIcon: Icon(
                            Icons.search,
                            color: ColorConstant.primary_color,
                          )),
                    ),
                  ),
                ),
                isDataGet == true
                    ? serInboxdata(_width)
                    : Expanded(
                        child:
                            SizedBox()) /* SizedBox(height: _height / 1.37,) */,
                isDataGet == true ? SizedBox() : Spacer(),
                MultiUser.isEmpty == true
                    ? SizedBox()
                    : _image != null
                        ? Container(
                            height: 90,
                            // color: Colors.red,
                            color: const Color.fromARGB(255, 255, 241, 240),
                            width: _width,
                            child: Row(
                              children: [
                                Container(
                                  height: 90,
                                  width: 150,
                                  child: Stack(
                                    children: [
                                      Image.file(
                                        _image!,
                                        height: 100,
                                        width: 150,
                                        fit: BoxFit.cover,
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            _image = null;
                                          });
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              right: 5, top: 5),
                                          child: Align(
                                            alignment: Alignment.topRight,
                                            child: Container(
                                                height: 22,
                                                width: 20,
                                                child: Image.asset(
                                                  ImageConstant.delete,
                                                  color: Colors.red,
                                                )),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          )
                        : SizedBox(),
                MultiUser.isEmpty == true
                    ? SizedBox()
                    : Container(
                        height: 70,
                        // color: Colors.red[100],
                        child: Row(
                          children: [
                            SizedBox(
                              width: 15,
                            ),
                            Container(
                              height: 50,
                              // width: _width - 90,
                              decoration: BoxDecoration(
                                  color: Color(0xFFF5F5F5),
                                  borderRadius: BorderRadius.circular(20)),
                              child: Row(children: [
                                SizedBox(
                                  width: 10,
                                ),
                                Container(
                                  width: _width / 1.32,
                                  // color: Colors.amber,
                                  child: Row(
                                    children: [
                                      /*  Container(
                                        // color: Colors.amber,
                                        child: IconButton(
                                          icon: Icon(
                                            isEmojiVisible
                                                ? Icons.keyboard_rounded
                                                : Icons.emoji_emotions_outlined,
                                          ),
                                          onPressed: onClickedEmoji,
                                        ),
                                      ), */
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Container(
                                        width: _width / 1.5, //old is 1.8
                                        // color: Colors.red,
                                        child: TextField(
                                          maxLines: null,
                                          controller: Add_Comment,
                                          cursorColor: Colors.grey,
                                          decoration: InputDecoration(
                                            border: InputBorder.none,
                                            hintText: "Add Comment",
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      /* GestureDetector(
                                        onTap: () {
                                          prepareTestPdf(0);
                                        },
                                        child: Image.asset(
                                          "assets/images/paperclip-2.png",
                                          height: 23,
                                        ),
                                      ), */
                                      SizedBox(
                                        width: 13,
                                      ),
                                      /* GestureDetector(
                                        onTap: () {
                                          camerapicker();
                                        },
                                        child: Image.asset(
                                          "assets/images/Vector (12).png",
                                          height: 20,
                                        ),
                                      ), */
                                      SizedBox(
                                        width: 8,
                                      ),
                                    ],
                                  ),
                                ),
                              ]),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            GestureDetector(
                              onTap: () async {
                                if (singleTap == false) {
                                  print(
                                      'MultiUserLengthCheck-${MultiUsermap.length}');
                                  if (Add_Comment.text.isNotEmpty) {
                                    if (Add_Comment.text.length >= 1000) {
                                      SnackBar snackBar = SnackBar(
                                        content: Text(
                                            'One Time Message Lenght only for 1000 Your Meassge -> ${Add_Comment.text.length}'),
                                        backgroundColor:
                                            ColorConstant.primary_color,
                                      );
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(snackBar);
                                    } else {
                                      if (MultiUser.isNotEmpty) {
                                        print("check Multi User-$MultiUser");

                                        var parmes = {
                                          "message": Add_Comment.text,
                                          "messageType": "TEXT",
                                          "usersIds": MultiUser
                                        };
                                        BlocProvider.of<PersonalChatListCubit>(
                                                context)
                                            .selectMultipleUsers_ChatMethod(
                                                parmes, context);
                                      }
                                    }
                                  } else if (MultiUser.isNotEmpty &&
                                      _image != null) {
                                    var parmes = {
                                      "message": imageDataPost?.object,
                                      "messageType": "IMAGE",
                                      "usersIds": MultiUser
                                    };
                                    BlocProvider.of<PersonalChatListCubit>(
                                            context)
                                        .selectMultipleUsers_ChatMethod(
                                            parmes, context);
                                  } else {
                                    SnackBar snackBar = SnackBar(
                                      content: Text('Please Enter Comment'),
                                      backgroundColor:
                                          ColorConstant.primary_color,
                                    );
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(snackBar);
                                  }
                                  singleTap = true;
                                  MultiUser = [];
                                  MultiUsermap.clear();
                                  _image = null;
                                  isDataGet = false;
                                  Add_Comment.clear();
                                  searchController.clear();
                                }
                              },
                              child: Container(
                                height: 50,
                                // width: 50,
                                decoration: BoxDecoration(
                                    color: Color(0xFFED1C25),
                                    borderRadius: BorderRadius.circular(25)),
                                child: Image.asset(
                                  "assets/images/Vector (13).png",
                                  color: Colors.white,
                                ),

                                // width: width - 95,
                              ),
                            ),
                          ],
                        ),
                      ),
                MultiUser.isEmpty == true
                    ? SizedBox()
                    : Offstage(
                        offstage: !isEmojiVisible,
                        child: Container(
                            height: 250,
                            color: Colors.green,
                            child: EmojiPicker(
                              textEditingController: Add_Comment,
                              onBackspacePressed: _onBackspacePressed,
                              config: Config(
                                columns: 7,
                                // Issue: https://github.com/flutter/flutter/issues/28894
                                emojiSizeMax: 32 *
                                    (foundation.defaultTargetPlatform ==
                                            TargetPlatform.iOS
                                        ? 1.30
                                        : 1.0),
                                verticalSpacing: 0,
                                horizontalSpacing: 0,
                                gridPadding: EdgeInsets.zero,
                                initCategory: Category.RECENT,
                                bgColor: const Color(0xFFF2F2F2),
                                indicatorColor: Colors.blue,
                                iconColor: Colors.grey,
                                iconColorSelected: Colors.blue,
                                backspaceColor: Colors.blue,
                                skinToneDialogBgColor: Colors.white,
                                skinToneIndicatorColor: Colors.grey,
                                enableSkinTones: true,
                                recentTabBehavior: RecentTabBehavior.RECENT,
                                recentsLimit: 28,
                                replaceEmojiOnLimitExceed: false,
                                noRecents: const Text(
                                  'No Recents',
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.black26),
                                  textAlign: TextAlign.center,
                                ),
                                loadingIndicator: const SizedBox.shrink(),
                                tabIndicatorAnimDuration: kTabScrollDuration,
                                categoryIcons: const CategoryIcons(),
                                buttonMode: ButtonMode.MATERIAL,
                                checkPlatformCompatibility: true,
                              ),
                            )),
                      ),
              ],
            );
          },
        ),
      ),
    );
  }

  _onBackspacePressed() {
    Add_Comment
      ..text = Add_Comment.text.characters.toString()
      ..selection = TextSelection.fromPosition(
          TextPosition(offset: Add_Comment.text.length));
  }

  serInboxdata(width) {
    return Expanded(
        child: SingleChildScrollView(
      controller: scrollController,
      child: PaginationWidget(
        scrollController: scrollController,
        totalSize: searchUserForInbox1?.object?.totalElements,
        offSet: searchUserForInbox1?.object?.pageable?.pageNumber,
        onPagination: (p0) async {
          BlocProvider.of<PersonalChatListCubit>(context)
              .search_user_for_inboxPagantion(
            context,
            searchController.text.trim(),
            '${(p0 + 1)}',
          );
        },
        items: ListView.builder(
          shrinkWrap: true,
          itemCount: searchUserForInbox1?.object?.content?.length,
          padding: EdgeInsets.zero,
          physics: NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                // DMChatListm
                Index = index;
                BlocProvider.of<PersonalChatListCubit>(context).DMChatListm(
                    "${searchUserForInbox1?.object?.content?[index].userUid}",
                    context);

                /*  if (UserIndexUUID != "" && UserIndexUUID != null) {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return DmScreen(
                      UserName:
                          "${searchUserForInbox1?.object?.content?[index].userName}",
                      ChatInboxUid: UserIndexUUID ?? "",
                      UserImage:
                          "${searchUserForInbox1?.object?.content?[index].userProfilePic}",
                    );
                  }));
                  // UserIndexUUID = "";
                } */
              },
              child: Container(
                margin: EdgeInsets.all(10),
                height: 70,
                width: 110,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Color(0xffE6E6E6))),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: GestureDetector(
                        onTap: () {
                          if (MultiUser.contains(searchUserForInbox1
                              ?.object?.content?[index].userUid)) {
                            MultiUser.remove(searchUserForInbox1
                                ?.object?.content?[index].userUid);
                            MultiUsermap.removeAt(index);
                          } else {
                            MultiUser.add(searchUserForInbox1
                                ?.object?.content?[index].userUid);
                            Map<String, dynamic> map = {
                              'userUid': searchUserForInbox1
                                  ?.object?.content?[index].userUid,
                              'username': searchUserForInbox1
                                  ?.object?.content?[index].userName,
                            };
                            MultiUsermap.add(map);
                          }

                          setState(() {});
                        },
                        child: Container(
                          height: 20,
                          width: 20,
                          child: MultiUser.contains(searchUserForInbox1
                                  ?.object?.content?[index].userUid)
                              ? Image.asset(ImageConstant.check_box)
                              : Image.asset(ImageConstant.check),
                        ),
                      ),
                    ),
                    searchUserForInbox1
                                    ?.object?.content?[index].userProfilePic !=
                                null &&
                            searchUserForInbox1?.object?.content?[index]
                                    .userProfilePic?.isNotEmpty ==
                                true
                        ? Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: CircleAvatar(
                              radius: 30.0,
                              backgroundImage: NetworkImage(
                                  "${searchUserForInbox1?.object?.content?[index].userProfilePic}"),
                              backgroundColor: Colors.transparent,
                            ),
                          )
                        : Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: CircleAvatar(
                              radius: 30.0,
                              backgroundImage:
                                  AssetImage(ImageConstant.tomcruse),
                              backgroundColor: Colors.transparent,
                            ),
                          ),
                    Container(
                      width: width / 1.6,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Text(
                          searchUserForInbox1
                                  ?.object?.content?[index].userName ??
                              '',
                          style: TextStyle(
                            overflow: TextOverflow.ellipsis,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            );
          },
        ),
      ),
    ));
  }

  /*  Future<void> pickProfileImage() async {
    pickedImageFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedImageFile != null) {
      if (!_isGifOrSvg(pickedImageFile!.path)) {
        setState(() {
          _image = File(pickedImageFile!.path);
        });
        final sizeInBytes = await _image!.length();
        final sizeInMB = sizeInBytes / (1024 * 1024);
        // print('documentuploadsize-$documentuploadsize');

        if (sizeInMB > documentuploadsize) {
          setState(() {
            _image = null;
          });
          showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: Text("Image Size Exceeded"),
                  content: Text(
                      "Selected image size exceeds $documentuploadsize MB."),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text("OK"),
                    ),
                  ],
                );
              });
        }
      } else {
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
  } */

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
          getFileSize(file.path!, 1, result.files.first, Index);
        }

        /*     setState(() {
          // fileparth = file.path!;

          switch (Index) {
            case 1:
              GSTName = "";
              // file.name;

              break;
            case 2:
              PanName = file.name;

              break;
            case 3:
              UdhyanName = file.name;

              break;
            default:
          }

          BlocProvider.of<DocumentUploadCubit>(context)
              .documentUpload(file.path!);
        });  */
      } else {}
    }
    return "";
    // "${fileparth}";
  }

  Future<void> camerapicker() async {
    pickedImageFile = await picker.pickImage(source: ImageSource.camera);
    if (pickedImageFile != null) {
      _image = File(pickedImageFile!.path);
      setState(() {});
      final int fileSizeInBytes = await _image!.length();
      if (fileSizeInBytes <= finalFileSize * 1024 * 1024) {
        BlocProvider.of<PersonalChatListCubit>(context)
            .UplodeImageAPI(context, File(_image!.path));
      } else {
        showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: Text("Max Size ${finalFileSize}MB"),
            content: Text(
                "This file size ${value2} ${fileSizeInBytes} Selected Max size ${finalFileSize}MB"),
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

    /*    if (pickedImageFile != null) {
      if (!_isGifOrSvg(pickedImageFile!.path)) {
        setState(() {
          _image = File(pickedImageFile!.path);
        });
          
        final sizeInBytes = await _image!.length();
        final sizeInMB = sizeInBytes / (1024 * 1024);

        if (sizeInMB > documentuploadsize) {
          // print('documentuploadsize-$documentuploadsize');
          showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: Text("Image Size Exceeded"),
                  content: Text(
                      "Selected image size exceeds $documentuploadsize MB."),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text("OK"),
                    ),
                  ],
                );
              });
        }
      } else {
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
    } */
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
                _image = File(file1.path.toString());
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
                _image = File(file1.path.toString());
              });
            }

            break;
          default:
        }
        print('filenamecheckKB-${file1.path}');
        print("file111.name-->${file1.name}");
        BlocProvider.of<PersonalChatListCubit>(context)
            .UplodeImageAPI(context, File(_image!.path));

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
            _image = File(file1.path.toString());
          });

          BlocProvider.of<PersonalChatListCubit>(context)
              .UplodeImageAPI(context, File(_image!.path));
        }

        break;
      default:
    }

    return STR;
  }
}
