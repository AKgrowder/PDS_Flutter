import 'dart:io';

import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pds/API/Bloc/PersonalChatList_Bloc/PersonalChatList_State.dart';
import 'package:pds/API/Bloc/PersonalChatList_Bloc/PersonalChatList_cubit.dart';
import 'package:pds/API/Model/serchForInboxModel/serchForinboxModel.dart';
import 'package:pds/core/utils/color_constant.dart';
import 'package:pds/core/utils/image_constant.dart';
import 'package:pds/core/utils/sharedPreferences.dart';
import 'package:pds/presentation/DMAll_Screen/Dm_Screen.dart';
import 'package:pds/widgets/pagenation.dart';
import 'package:flutter/foundation.dart' as foundation;
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
  ScrollController scrollController = ScrollController();
  SearchUserForInbox? searchUserForInbox1;
  List MultiUser = [];
  bool isChecked = false;
  bool isEmojiVisible = false;
  bool isKeyboardVisible = false;
  final focusNode = FocusNode();
  XFile? pickedImageFile;
  File? _image;
  double documentuploadsize = 0;
  ImagePicker picker = ImagePicker();
  FocusNode _focusNode = FocusNode();
  TextEditingController Add_Comment = TextEditingController();
  KeyboardVisibilityController keyboardVisibilityController =
      KeyboardVisibilityController();

  @override
  void initState() {
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

  getDocumentSize() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    int? a = prefs.getInt(PreferencesKey.mediaSize);
    documentuploadsize = double.parse("${a}");
    setState(() {});
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
            'Invite Message',
            style: TextStyle(color: Colors.black),
          ),
        ),
        body: BlocConsumer<PersonalChatListCubit, PersonalChatListState>(
          listener: (context, state) {
            if (state is SearchHistoryDataAddxtends) {
              isDataGet = true;
              searchUserForInbox1 = state.searchUserForInbox;
            }
            if (state is DMChatListLoadedState) {
              print(state.DMChatList.object);
              UserIndexUUID = state.DMChatList.object;
            }
          },
          builder: (context, state) {
            return Column(
              children: [
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
                            color: Colors.red,
                            // color: const Color.fromARGB(255, 255, 241, 240),
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
                                      Container(
                                        // color: Colors.amber,
                                        child: IconButton(
                                          icon: Icon(
                                            isEmojiVisible
                                                ? Icons.keyboard_rounded
                                                : Icons.emoji_emotions_outlined,
                                          ),
                                          onPressed: onClickedEmoji,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Container(
                                        width: _width / 2.35,
                                        // color: Colors.red,
                                        child: TextField(
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
                                      GestureDetector(
                                        onTap: () {
                                          pickProfileImage();
                                        },
                                        child: Image.asset(
                                          "assets/images/paperclip-2.png",
                                          height: 23,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 13,
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          camerapicker();
                                        },
                                        child: Image.asset(
                                          "assets/images/Vector (12).png",
                                          height: 20,
                                        ),
                                      ),
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
                                if (Add_Comment.text.isNotEmpty) {
                                  if (Add_Comment.text.length >= 255) {
                                    SnackBar snackBar = SnackBar(
                                      content: Text(
                                          'One Time Message Lenght only for 255 Your Meassge -> ${Add_Comment.text.length}'),
                                      backgroundColor:
                                          ColorConstant.primary_color,
                                    );
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(snackBar);
                                  } else {
                                    print("Multipale API CAll");
                                  }
                                } else {
                                  SnackBar snackBar = SnackBar(
                                    content: Text('Please Enter Comment'),
                                    backgroundColor:
                                        ColorConstant.primary_color,
                                  );
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(snackBar);
                                }
                                // }
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
                BlocProvider.of<PersonalChatListCubit>(context).DMChatListm(
                    "${searchUserForInbox1?.object?.content?[index].userUid}",
                    context);

                if (UserIndexUUID != "" || UserIndexUUID != null) {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return DmScreen(
                      UserName:
                          "${searchUserForInbox1?.object?.content?[index].userName}",
                      ChatInboxUid: UserIndexUUID ?? "",
                    );
                  }));
                  // UserIndexUUID = "";
                }
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
                          } else {
                            MultiUser.add(searchUserForInbox1
                                ?.object?.content?[index].userUid);
                          }
                          print(MultiUser);
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

  Future<void> pickProfileImage() async {
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
  }

  Future<void> camerapicker() async {
    pickedImageFile = await picker.pickImage(source: ImageSource.camera);
    if (pickedImageFile != null) {
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
    }
  }
}
