// ignore_for_file: prefer_const_constructors, non_constant_identifier_names, prefer_const_literals_to_create_immutables, must_be_immutable

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hashtagable/widgets/hashtag_text.dart';
import 'package:pds/API/Bloc/NewProfileScreen_Bloc/NewProfileScreen_cubit.dart';
import 'package:pds/API/Model/Getalluset_list_Model/get_all_userlist_model.dart';
import 'package:pds/API/Model/SearchPagesModel/SearchPagesModel.dart';
import 'package:pds/API/Model/getSerchDataModel/getSerchDataModel.dart';
import 'package:pds/core/utils/color_constant.dart';
import 'package:pds/core/utils/image_constant.dart';
import 'package:pds/core/utils/sharedPreferences.dart';
import 'package:pds/presentation/%20new/HashTagView_screen.dart';
import 'package:pds/presentation/%20new/newbottembar.dart';
import 'package:pds/presentation/%20new/profileNew.dart';
import 'package:pds/presentation/register_create_account_screen/register_create_account_screen.dart';
import 'package:pds/widgets/pagenation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../API/Bloc/HashTag_Bloc/HashTag_cubit.dart';
import '../../API/Bloc/HashTag_Bloc/HashTag_state.dart';
import '../../API/Model/HashTage_Model/HashTag_model.dart';
import '../../widgets/custom_image_view.dart';

class SearchBarScreen extends StatefulWidget {
  dynamic value2;
  SearchBarScreen({required this.value2});

  @override
  State<SearchBarScreen> createState() => _SearchBarScreenState();
}

class _SearchBarScreenState extends State<SearchBarScreen> {
  int sliderCurrentPosition = 0;
  dynamic dataSetup;
  TextEditingController searchController = TextEditingController();
  List text = ["For You", "Trending"];
  List text1 = ["All", "Pages", "Experts"];
  bool dataget = false;
  GetAllUserListModel? getalluserlistModel;
  SearchPages? searchPages;
  List imageList = [
    ImageConstant.Rectangle,
    ImageConstant.Rectangle,
    ImageConstant.Rectangle,
    ImageConstant.Rectangle,
    ImageConstant.Rectangle,
  ];
  Timer? _timer;
  ScrollController scrollController = ScrollController();
  ScrollController scrollController1 = ScrollController();
  ScrollController scrollController2 = ScrollController();
  FocusNode _focusNode = FocusNode();

  int? indexxx;
  bool isSerch = false;
  bool isExpert = false;
  var UserLogin_ID;
  GetDataInSerch? getDataInSerch;
  int? length;
  HashtagModel? hashtagModel; /* 
  HashTagImageModel? hashTagImageModel; */
  bool apiDataSetup = false;
  bool isSerchCompnayPage = false;

  getUserData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    dataSetup = 0;
    indexxx = 0;

    /* await BlocProvider.of<HashTagCubit>(context).seetinonExpried(context);
    await BlocProvider.of<HashTagCubit>(context)
        .getAllNoticationsCountAPI(context);
    await BlocProvider.of<HashTagCubit>(context)
        .HashTagForYouAPI(context, 'FOR YOU', '1');
         await BlocProvider.of<HashTagCubit>(context).serchDataGet(
      context,
    ); */
    if (UserLogin_ID == null) {
      // await BlocProvider.of<HashTagCubit>(context)
      //     .getAllNoticationsCountAPI(context);
      await BlocProvider.of<HashTagCubit>(context)
          .HashTagForYouAPI(context, 'FOR YOU', '1');
    } else {
      await BlocProvider.of<HashTagCubit>(context).seetinonExpried(context);
      await BlocProvider.of<HashTagCubit>(context)
          .getAllNoticationsCountAPI(context);
      await BlocProvider.of<HashTagCubit>(context)
          .HashTagForYouAPI(context, 'FOR YOU', '1');
      await BlocProvider.of<HashTagCubit>(context).serchDataGet(
        context,
      );
    }
  }

  checkGuestUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    UserLogin_ID = prefs.getString(PreferencesKey.loginUserID);
  }

  @override
  void initState() {
    super.initState();
    checkGuestUser();
    getUserData();
  }

  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var _height = MediaQuery.of(context).size.height;
    var _width = MediaQuery.of(context).size.width;
    return WillPopScope(
      onWillPop: () async {
        if (isSerch == true) {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => NewBottomBar(buttomIndex: 2)));
          return true;
        } else {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => NewBottomBar(buttomIndex: 0)));
          return true;
        }
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: BlocConsumer<HashTagCubit, HashTagState>(
          listener: (context, state) {
            if (state is HashTagErrorState) {
              apiDataSetup = true;
              // print("i want error print${state.error}");
              // SnackBar snackBar = SnackBar(
              //   content: Text(state.error),
              //   backgroundColor: ColorConstant.primary_color,
              // );
              // ScaffoldMessenger.of(context).showSnackBar(snackBar);
            }
            if (state is GetSerchData) {
              getDataInSerch = state.getDataInSerch;
              if (getDataInSerch?.object != null) {
                getDataInSerch?.object?.forEach((element) {
                  print("foreachcheck-${element}");
                });
                if (getDataInSerch!.object!.length <= 5) {
                  length = getDataInSerch!.object!.length;
                } else {
                  length = 5;
                }
              }
            }
            if (state is HashTagLoadedState) {
              apiDataSetup = true;

              hashtagModel = state.HashTagData;
              hashtagModel!.object!.content!.forEach((element) {
                print("Hashtag search history : ${element.hashtagName}");
              });
            }
            if (state is GetNotificationCountLoadedState) {
              print(state.GetNotificationCountData.object);
              saveNotificationCount(
                  state.GetNotificationCountData.object?.notificationCount ?? 0,
                  state.GetNotificationCountData.object?.messageCount ?? 0);
            }
            if (state is GetAllUserLoadedState) {
              dataget = true;
              print("api caling");
              getalluserlistModel = state.getAllUserRoomData;

              isExpert = true;
            }
            if (state is SearchPagesLoadedState) {
              searchPages = state.serchPages;
              dataget = true;
              isSerchCompnayPage = true;
            }
            /* if (state is HashTagBannerLoadedState) {
              print("HashTagBannerLoadedState - ${hashTagImageModel?.object}");
              hashTagImageModel = state.hashTagImageModel;
            } */
          },
          builder: (context, state) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 15, right: 15, top: 60),
                  child: isSerch == true
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            NewBottomBar(buttomIndex: 2),
                                      ));
                                },
                                child: Icon(Icons.arrow_back)),
                            Container(
                              height: 48,
                              width: _width / 1.25,
                              decoration: BoxDecoration(
                                  color: Color(0xffF0F0F0),
                                  borderRadius: BorderRadius.circular(30)),
                              child: TextFormField(
                                enabled: true,
                                focusNode: _focusNode,
                                autofocus: true,
                                onEditingComplete: () {},
                                onTap: () {
                                  if (mounted) {
                                    super.setState(() {
                                      isSerch = true;
                                    });
                                  }

                                  print("xfhdsfhsdfgsdfg-$isSerch");
                                  /*    Navigator.push(context, MaterialPageRoute(
                              builder: (context) {
                                return AllSearchScreen();
                              },
                            )); */
                                },
                                onChanged: (value) {
                                  if (value.contains('#')) {
                                    print("value.contains('#')");
                                    if (indexxx == 0) {
                                      print("index is  0");
                                      String hashTageValue =
                                          value.replaceAll("#", "%23");
                                      BlocProvider.of<HashTagCubit>(context)
                                          .getalluser(
                                              1, hashTageValue.trim(), context);
                                    } else if (indexxx == 1) {
                                      String hashTageValue = searchController
                                          .text
                                          .replaceAll("#", "%23");
                                      BlocProvider.of<HashTagCubit>(context)
                                          .serchPagesCompnay(context, '1',
                                              hashTageValue.trim());
                                    } else {
                                      print("index is not 0");
                                      String hashTageValue =
                                          value.replaceAll("#", "%23");
                                      BlocProvider.of<HashTagCubit>(context)
                                          .getalluser(
                                              1, hashTageValue.trim(), context,
                                              filterModule: 'EXPERT');
                                    }
                                  } else if (value.isNotEmpty) {
                                    if (indexxx == 0) {
                                      print("if condison woking");

                                      BlocProvider.of<HashTagCubit>(context)
                                          .getalluser(1, value.trim(), context);
                                    } else if (indexxx == 1) {
                                      BlocProvider.of<HashTagCubit>(context)
                                          .serchPagesCompnay(
                                        context,
                                        '1',
                                        searchController.text.trim(),
                                      );
                                    } else {
                                      print("else condison woking");
                                      BlocProvider.of<HashTagCubit>(context)
                                          .getalluser(1, value.trim(), context,
                                              filterModule: 'EXPERT');
                                    }
                                  } else {
                                    isSerchCompnayPage = false;
                                    isExpert = false;
                                    dataget = false;
                                    if (mounted) {
                                      super.setState(() {
                                        // Update the widget's state.
                                      });
                                    }
                                  }
                                  print("dataGet-${value.trim()}");

                                  if (text.isNotEmpty) {
                                    print("valuee check--${value.trim()}");
                                    if (_timer != null) {
                                      _timer?.cancel();
                                      _timer = Timer(Duration(seconds: 5), () {
                                        if (UserLogin_ID != null) {
                                          BlocProvider.of<HashTagCubit>(context)
                                              .serchDataAdd(
                                                  context, value.trim());
                                        }
                                      });
                                    } else {
                                      _timer = Timer(Duration(seconds: 5), () {
                                        if (UserLogin_ID != null) {
                                          BlocProvider.of<HashTagCubit>(context)
                                              .serchDataAdd(
                                                  context, value.trim());
                                        }
                                      });
                                    }
                                  }
                                },
                                controller: searchController,
                                cursorColor: Colors.grey,
                                decoration: InputDecoration(
                                    hintText: "Search....",
                                    hintStyle: TextStyle(color: Colors.grey),
                                    border: InputBorder.none,
                                    prefixIcon: Icon(
                                      Icons.search,
                                      color: Colors.grey,
                                    )),
                              ),
                            ),
                          ],
                        )
                      : Container(
                          height: 48,
                          decoration: BoxDecoration(
                              color: Color(0xffF0F0F0),
                              borderRadius: BorderRadius.circular(30)),
                          child: TextFormField(
                            onTap: () {
                              if (mounted) {
                                super.setState(() {
                                  isSerch = true;
                                });
                              }
                            },
                            onChanged: (value) {
                              if (value.isNotEmpty) {
                                if (indexxx == 0) {
                                  print("i want to  chrck-${value.trim()}");
                                  BlocProvider.of<HashTagCubit>(context)
                                      .getalluser(1, value.trim(), context);
                                } else if (indexxx == 1) {
                                  BlocProvider.of<HashTagCubit>(context)
                                      .serchPagesCompnay(
                                    context,
                                    '1',
                                    searchController.text.trim(),
                                  );
                                } else {
                                  BlocProvider.of<HashTagCubit>(context)
                                      .getalluser(1, value.trim(), context,
                                          filterModule: 'EXPERT');
                                }
                              } else {
                                isSerchCompnayPage = false;
                                isExpert = false;
                                dataget = false;
                                if (mounted) {
                                  super.setState(() {
                                    // Update the widget's state.
                                  });
                                }
                              }
                            },
                            controller: searchController,
                            cursorColor: Colors.grey,
                            decoration: InputDecoration(
                                hintText: "Search....",
                                hintStyle: TextStyle(color: Colors.grey),
                                border: InputBorder.none,
                                prefixIcon: Icon(
                                  Icons.search,
                                  color: Colors.grey,
                                )),
                          ),
                        ),
                ),
                Divider(
                  color: Colors.grey,
                ),
                isSerch == true
                    ? SizedBox(
                        // height: 40,
                        width: double.infinity,
                        child: Column(children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: List.generate(text1.length, (index) {
                              return GestureDetector(
                                onTap: () {
                                  indexxx = index;
                                  dataSetup = null;

                                  SharedPreferencesFunction(indexxx ?? 0);
                                  if (mounted) {
                                    super.setState(() {
                                      // Update the widget's state.
                                    });
                                  }
                                  if (searchController.text.contains('#')) {
                                    print("value.contains('#')");
                                    if (indexxx == 0) {
                                      print("index is  0");
                                      String hashTageValue = searchController
                                          .text
                                          .replaceAll("#", "%23");
                                      BlocProvider.of<HashTagCubit>(context)
                                          .getalluser(
                                              1, hashTageValue.trim(), context);
                                    } else if (indexxx == 1) {
                                      String hashTageValue = searchController
                                          .text
                                          .replaceAll("#", "%23");
                                      BlocProvider.of<HashTagCubit>(context)
                                          .serchPagesCompnay(
                                        context,
                                        '1',
                                        hashTageValue.trim(),
                                      );
                                    } else {
                                      print("index is not 0");
                                      String hashTageValue = searchController
                                          .text
                                          .replaceAll("#", "%23");
                                      BlocProvider.of<HashTagCubit>(context)
                                          .getalluser(
                                              1, hashTageValue.trim(), context,
                                              filterModule: 'EXPERT');
                                    }
                                  } else if (searchController.text.isNotEmpty) {
                                    if (indexxx == 0) {
                                      BlocProvider.of<HashTagCubit>(context)
                                          .getalluser(
                                              1,
                                              searchController.text.trim(),
                                              context);
                                    } else if (indexxx == 1) {
                                      BlocProvider.of<HashTagCubit>(context)
                                          .serchPagesCompnay(
                                        context,
                                        '1',
                                        searchController.text.trim(),
                                      );
                                    } else {
                                      BlocProvider.of<HashTagCubit>(context)
                                          .getalluser(
                                              1,
                                              searchController.text.trim(),
                                              context,
                                              filterModule: 'EXPERT');
                                    }
                                  } else {}
                                },
                                child: Container(
                                  margin: EdgeInsets.all(5),
                                  height: 25,
                                  width: 120,
                                  decoration: BoxDecoration(
                                      color: indexxx == index
                                          ? ColorConstant.primary_color
                                          : dataSetup == index
                                              ? ColorConstant.primary_color
                                              : ColorConstant
                                                  .primaryLight_color,
                                      borderRadius: BorderRadius.circular(20)),
                                  child: Center(
                                      child: Text(
                                    text1[index],
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                        color: indexxx == index
                                            ? Colors.white
                                            : dataSetup == index
                                                ? Colors.white
                                                : ColorConstant.primary_color),
                                  )),
                                ),
                              );
                            }),
                          )
                        ]))
                    : apiDataSetup == true
                        ? SizedBox(
                            width: double.infinity,
                            child: Column(children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: List.generate(text.length, (index) {
                                  return GestureDetector(
                                    onTap: () {
                                      indexxx = index;
                                      dataSetup = null;
                                      print("indexxx$indexxx");
                                      SharedPreferencesFunction(indexxx ?? 0);
                                      if (indexxx == 1) {
                                        //TRENDING
                                        BlocProvider.of<HashTagCubit>(context)
                                            .HashTagForYouAPI(
                                                context, 'TRENDING', '1');
                                      } else {
                                        BlocProvider.of<HashTagCubit>(context)
                                            .HashTagForYouAPI(
                                                context, 'FOR YOU', '1');
                                      }
                                      if (mounted) {
                                        super.setState(() {
                                          // Update the widget's state.
                                        });
                                      }
                                    },
                                    child: Container(
                                      margin: EdgeInsets.all(5),
                                      height: 25,
                                      width: 120,
                                      decoration: BoxDecoration(
                                          color: indexxx == index
                                              ? ColorConstant.primary_color
                                              : dataSetup == index
                                                  ? ColorConstant.primary_color
                                                  : Color(0xffFBD8D9),
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      child: Center(
                                          child: Text(
                                        text[index],
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400,
                                            color: indexxx == index
                                                ? Colors.white
                                                : dataSetup == index
                                                    ? Colors.white
                                                    : ColorConstant
                                                        .primary_color),
                                      )),
                                    ),
                                  );
                                }),
                              )
                            ]))
                        : Center(
                            child: Container(
                              margin: EdgeInsets.only(bottom: 100),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: Image.asset(ImageConstant.loader,
                                    fit: BoxFit.cover,
                                    height: 100.0,
                                    width: 100),
                              ),
                            ),
                          ),
                Divider(
                  color: Colors.grey,
                ),
                /* isSerch == true
                    ? SizedBox()
                    : indexxx == 0
                        ? getDataInSerch?.object?.isEmpty == false
                            ? SizedBox()
                            : Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: Text(
                                  "History",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                      color: ColorConstant.primary_color),
                                ),
                              )
                        : SizedBox(),
                isSerch == true
                    ? SizedBox()
                    : indexxx == 0
                        ? Padding(
                            padding: const EdgeInsets.only(top: 5),
                            child: historyData(),
                          )
                        : SizedBox(), */
                /*       isSerch == true
                    ? SizedBox()
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Divider(
                            height: 3,
                            color: Colors.grey,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Text(
                              "For You",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  color: ColorConstant.primary_color),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                        ],
                      ), */
                isSerch == true
                    ? dataget == true
                        ? NavagtionPassing1(isSerchCompnayPage)
                        : Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  'Recent',
                                  style: TextStyle(
                                      color: Colors.grey, fontSize: 18),
                                ),
                              ),
                              Container(
                                height: 300,
                                width: _width,
                                // color: Colors.amber,
                                child: Column(
                                  children:
                                      List.generate((length ?? 0), (index) {
                                    return Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: GestureDetector(
                                        onTap: () {
                                          super.setState(() {
                                            _focusNode.requestFocus();

                                            isSerch = true;
                                            searchController.text =
                                                '${getDataInSerch?.object?[index].toString()}';
                                          });
                                          if (searchController.text
                                              .contains('#')) {
                                            print("value.contains('#')");
                                            if (indexxx == 0) {
                                              print("index is  0");
                                              String hashTageValue =
                                                  searchController.text
                                                      .replaceAll("#", "%23");
                                              BlocProvider.of<HashTagCubit>(
                                                      context)
                                                  .getalluser(
                                                      1,
                                                      hashTageValue.trim(),
                                                      context);
                                            } else if (indexxx == 1) {
                                              String hashTageValue =
                                                  searchController.text
                                                      .replaceAll("#", "%23");
                                              BlocProvider.of<HashTagCubit>(
                                                      context)
                                                  .serchPagesCompnay(
                                                context,
                                                '1',
                                                hashTageValue.trim(),
                                              );
                                            } else {
                                              print("index is not 0");
                                              String hashTageValue =
                                                  searchController.text
                                                      .replaceAll("#", "%23");
                                              BlocProvider.of<HashTagCubit>(
                                                      context)
                                                  .getalluser(
                                                      1,
                                                      hashTageValue.trim(),
                                                      context,
                                                      filterModule: 'EXPERT');
                                            }
                                          } else if (searchController
                                              .text.isNotEmpty) {
                                            if (indexxx == 0) {
                                              BlocProvider.of<HashTagCubit>(
                                                      context)
                                                  .getalluser(
                                                      1,
                                                      searchController.text
                                                          .trim(),
                                                      context);
                                            } else if (indexxx == 1) {
                                              BlocProvider.of<HashTagCubit>(
                                                      context)
                                                  .serchPagesCompnay(
                                                context,
                                                '1',
                                                searchController.text.trim(),
                                              );
                                            } else {
                                              BlocProvider.of<HashTagCubit>(
                                                      context)
                                                  .getalluser(
                                                      1,
                                                      searchController.text
                                                          .trim(),
                                                      context,
                                                      filterModule: 'EXPERT');
                                            }
                                          } else {}
                                        },
                                        child: Row(
                                          children: [
                                            if (getDataInSerch?.object?[index]
                                                    .isNotEmpty ==
                                                true)
                                              Icon(Icons.history),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            if (getDataInSerch?.object?[index]
                                                    .isNotEmpty ==
                                                true)
                                              Text(
                                                  '${getDataInSerch?.object?[index]}')
                                          ],
                                        ),
                                      ),
                                    );
                                  }),
                                ),
                              )
                            ],
                          )
                    : apiDataSetup == true
                        ? NavagtionPassing(hashtagModel: hashtagModel)
                        : SizedBox()
              ],
            );
          },
        ),
      ),
    );
  }

  Widget historyData() {
    return getDataInSerch?.object?.isNotEmpty == true
        ? Column(
            children: List.generate(
                getDataInSerch?.object?.length ?? 0,
                (index) => getDataInSerch?.object?[index].isNotEmpty == true
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Divider(
                            height: 3,
                            color: Colors.grey,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          GestureDetector(
                            onTap: () {
                              if (getDataInSerch?.object?.isNotEmpty == true) {
                                isSerch = true;
                                searchController.text =
                                    getDataInSerch?.object?[index].toString() ??
                                        '';
                                super.setState(() {});

                                if (searchController.text.contains('#')) {
                                  String hashTageValue = searchController.text
                                      .replaceAll("#", "%23");
                                  BlocProvider.of<HashTagCubit>(context)
                                      .getalluser(
                                          1, hashTageValue.trim(), context);
                                } else if (indexxx == 1) {
                                  String hashTageValue = searchController.text
                                      .replaceAll("#", "%23");
                                  BlocProvider.of<HashTagCubit>(context)
                                      .serchPagesCompnay(
                                    context,
                                    '1',
                                    hashTageValue.trim(),
                                  );
                                } else {
                                  BlocProvider.of<HashTagCubit>(context)
                                      .getalluser(
                                          1,
                                          searchController.text.trim(),
                                          context);
                                }
                              }
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: Text(
                                getDataInSerch?.object?[index] ?? '',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          )
                        ],
                      )
                    : SizedBox()))
        : SizedBox();
  }

  /*  Widget TopSlider({HashTagImageModel? hashTagImageModel}) {
    return Column(
      children: [
        Stack(
          children: [
            SizedBox(
              height: 180,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: ExcludeSemantics(
                  child: CarouselSlider.builder(
                      options: CarouselOptions(
                          height: 350.00,
                          initialPage: 0,
                          autoPlay: true,
                          viewportFraction: 1.0,
                          enableInfiniteScroll: false,
                          scrollDirection: Axis.horizontal,
                          onPageChanged: (index, reason) {
                            WidgetsBinding.instance.addPostFrameCallback((_) {
                              if (mounted) {
                                super.setState(() {
                                  sliderCurrentPosition = index;
                                });
                              }
                            });
                          }),
                      itemCount: hashTagImageModel?.object?.length ?? 0,
                      itemBuilder: (context, index, realIndex) {
                        return GestureDetector(
                          onTap: () {},
                          child: Padding(
                            padding: const EdgeInsets.only(left: 12, right: 12),
                            child: Container(
                              width: double.infinity,
                              child: CachedNetworkImage(
                                imageUrl:
                                    '${hashTagImageModel?.object?[index]}',
                                height: 120,
                                width: 120,
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                        );
                      }),
                ),
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
                      dotsCount: hashTagImageModel?.object?.length ?? 1,
                      position: sliderCurrentPosition.toDouble(),
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
          ],
        ),
      ],
    );
  } */

  SharedPreferencesFunction(int value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt("tabSelction", value);
  }

  Widget NavagtionPassing({HashtagModel? hashtagModel}) {
    if (indexxx != null) {
      if (indexxx == 0) {
        return Expanded(
          child: SingleChildScrollView(
            controller: scrollController,
            child: PaginationWidget1(
              scrollController: scrollController1,
              totalSize: hashtagModel?.object?.totalElements,
              offSet: hashtagModel?.object?.pageable?.pageNumber,
              onPagination: (p0) async {
                BlocProvider.of<HashTagCubit>(context)
                    .HashTagForYouAPIDataGet(context, 'FOR YOU', '${(p0 + 1)}');
              },
              items: ListView.builder(
                padding: EdgeInsets.zero,
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                primary: true,
                itemCount: hashtagModel?.object?.content?.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      index == 0
                          ? SizedBox()
                          : Divider(
                              height: 3,
                              color: Colors.grey,
                            ),
                      SizedBox(
                        width: double.infinity,
                        child: Padding(
                          padding: EdgeInsets.only(
                              top: 5, left: 10, right: 10, bottom: 5),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              HashTagText(
                                text:
                                    "${hashtagModel?.object?.content?[index].hashtagName}",
                                decoratedStyle: TextStyle(
                                    fontFamily: "outfit",
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: ColorConstant.HasTagColor),
                                basicStyle: TextStyle(
                                    fontFamily: "outfit",
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                                onTap: (text) {
                                  print('sdshfsdfh');
                                  if (UserLogin_ID != null) {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              BlocProvider<HashTagCubit>(
                                            create: (context) => HashTagCubit(),
                                            child: HashTagViewScreen(
                                                title:
                                                    "${hashtagModel?.object?.content?[index].hashtagName}"),
                                          ),
                                        ));
                                  } else {
                                    NaviRegisterScreen();
                                  }
                                },
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 5),
                                child: Text(
                                  "${hashtagModel?.object?.content?[index].postCount} posts",
                                  style: TextStyle(
                                    color: Color(0xff808080),
                                    fontSize: 12,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        );
      } else {
        return apiDataSetup == true
            ? Expanded(
                child: SingleChildScrollView(
                  controller: scrollController2,
                  child: Column(
                    children: [
                      PaginationWidget(
                        scrollController: scrollController2,
                        totalSize: hashtagModel?.object?.totalElements,
                        offSet: hashtagModel?.object?.pageable?.pageNumber,
                        onPagination: (p0) async {
                          BlocProvider.of<HashTagCubit>(context)
                              .HashTagForYouAPIDataGet(
                                  context, 'TRENDING', '${(p0 + 1)}');
                        },
                        items: ListView.builder(
                          shrinkWrap: true,
                          padding: EdgeInsets.zero,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: hashtagModel?.object?.content?.length,
                          itemBuilder: (context, index) {
                            return Column(
                              children: [
                                index == 0
                                    ? SizedBox()
                                    : Divider(
                                        height: 3,
                                        color: Colors.grey,
                                      ),
                                SizedBox(
                                  width: double.infinity,
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                        top: 5, left: 10, right: 10, bottom: 5),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        HashTagText(
                                          text:
                                              "${hashtagModel?.object?.content?[index].hashtagName}",
                                          decoratedStyle: TextStyle(
                                              fontFamily: "outfit",
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                              color: ColorConstant.HasTagColor),
                                          basicStyle: TextStyle(
                                              fontFamily: "outfit",
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black),
                                          onTap: (text) {
                                            print(text);
                                            if (UserLogin_ID != null) {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        BlocProvider<
                                                            HashTagCubit>(
                                                      create: (context) =>
                                                          HashTagCubit(),
                                                      child: HashTagViewScreen(
                                                          title:
                                                              "${hashtagModel?.object?.content?[index].hashtagName}"),
                                                    ),
                                                  ));
                                            } else {
                                              NaviRegisterScreen();
                                            }
                                          },
                                        ),
                                        SizedBox(
                                          height: 3,
                                        )
                                        /* Padding(
                                          padding: EdgeInsets.only(top: 5),
                                          child: Text(
                                            "${hashtagModel?.object?.content?[index].postCount} posts",
                                            style: TextStyle(
                                              color: Color(0xff808080),
                                              fontSize: 12,
                                            ),
                                          ),
                                        ) */
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              )
            : SizedBox();
      }
    } else {
      return Expanded(
          child: Container(
        color: Colors.white,
      ));
    }
  }

  Widget NavagtionPassing1(bool isSerchCompnayPage) {
    var _height = MediaQuery.of(context).size.height;
    var _width = MediaQuery.of(context).size.width;

    if (indexxx != null) {
      if (indexxx == 0) {
        if (searchController.text.isEmpty &&
            getDataInSerch?.object?.isNotEmpty == true) {
          return Expanded(
            child: Column(
              children: [Text('')],
            ),
          );
        } else {
          return Expanded(
            child: SingleChildScrollView(
              controller: scrollController,
              child: PaginationWidget(
                scrollController: scrollController,
                totalSize: getalluserlistModel?.object?.totalElements,
                offSet: getalluserlistModel?.object?.pageable?.pageNumber,
                onPagination: (p0) async {
                  if (searchController.text.contains("#")) {
                    String hashTageValue =
                        searchController.text.replaceAll("#", "%23");
                    BlocProvider.of<HashTagCubit>(context).getAllPagaationApi(
                        (p0 + 1), hashTageValue.trim(), context);
                  } else {
                    if (searchController.text.isNotEmpty) {
                      BlocProvider.of<HashTagCubit>(context).getAllPagaationApi(
                          (p0 + 1), searchController.text.trim(), context);
                    }
                  }
                },
                items: ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  padding: EdgeInsets.zero,
                  itemCount: getalluserlistModel?.object?.content?.length,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        if (getalluserlistModel
                                ?.object?.content?[index].hashtagNamesDto ==
                            null)
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: GestureDetector(
                              onTap: () {
                                if (UserLogin_ID != null) {
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
                                            User_ID:
                                                "${getalluserlistModel?.object?.content?[index].userUid}",
                                            isFollowing: "REQUESTED"));
                                  }));
                                } else {
                                  NaviRegisterScreen();
                                }
                              },
                              child: Container(
                                height: 55,
                                width: _width / 1.1,
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.grey),
                                    borderRadius: BorderRadius.circular(10)),
                                child: Row(children: [
                                  SizedBox(
                                    width: 8,
                                  ),
                                  getalluserlistModel?.object?.content?[index]
                                              .userProfile ==
                                          null
                                      ? CircleAvatar(
                                          backgroundColor: Colors.white,
                                          radius: 25,
                                          child: Image.asset(
                                              ImageConstant.tomcruse))
                                      : CircleAvatar(
                                          backgroundColor: Colors.white,
                                          backgroundImage: NetworkImage(
                                            "${getalluserlistModel?.object?.content?[index].userProfile}",
                                          ),
                                          radius: 25,
                                        ),
                                  SizedBox(
                                    width: 8,
                                  ),
                                  Container(
                                    // color: Colors.amber,
                                    margin: EdgeInsets.only(right: 5),
                                    child: Text(
                                      "${getalluserlistModel?.object?.content?[index].userName}",
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15,
                                      ),
                                    ),
                                  ),
                                  if (getalluserlistModel
                                          ?.object?.content?[index].isExpert ==
                                      true)
                                    Padding(
                                      padding: const EdgeInsets.only(bottom: 4),
                                      child: Image.asset(
                                        ImageConstant.Star,
                                        height: 18,
                                      ),
                                    )
                                ]),
                              ),
                            ),
                          ),
                        if (getalluserlistModel
                                ?.object?.content?[index].hashtagNamesDto !=
                            null)
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: GestureDetector(
                              onTap: () {
                                if (UserLogin_ID != null) {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            BlocProvider<HashTagCubit>(
                                          create: (context) => HashTagCubit(),
                                          child: HashTagViewScreen(
                                              title:
                                                  "${getalluserlistModel?.object?.content?[index].hashtagNamesDto?.hashtagName}"),
                                        ),
                                      ));
                                } else {
                                  NaviRegisterScreen();
                                }
                              },
                              child: Container(
                                height: 50,
                                width: _width / 1.1,
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.grey),
                                    borderRadius: BorderRadius.circular(10)),
                                child: Row(
                                  children: [
                                    SizedBox(
                                      width: 8,
                                    ),
                                    Container(
                                      width: _width / 1.5,
                                      child: Text(
                                        "${getalluserlistModel?.object?.content?[index].hashtagNamesDto?.hashtagName}",
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 8,
                                    ),
                                    Text(
                                      "${getalluserlistModel?.object?.content?[index].hashtagNamesDto?.postCount} Post",
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          )
                      ],
                    );
                  },
                ),
              ),
            ),
          );
        }
      } else if (indexxx == 0) {
        print("fdggsdfgsdfgsdgfdfgsdfgsdfg");
        return ListView.builder(
          itemCount: 10,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.only(right: 15, left: 15, bottom: 15),
              child: Container(
                height: 70,
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(10)),
                child: Padding(
                  padding: const EdgeInsets.only(right: 15, left: 15),
                  child: Row(
                    children: [
                      CustomImageView(
                        imagePath: ImageConstant.tomcruse,
                        height: 50,
                        radius: BorderRadius.circular(25),
                        width: 50,
                        fit: BoxFit.fill,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 13, bottom: 13, left: 10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                              child: Container(
                                width: _width / 2.5,
                                child: Text(
                                  "Inpackaging",
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ),
                            Flexible(
                              child: Container(
                                width: _width / 2.5,
                                child: Text(
                                  "Private Limited",
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontSize: 14,
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
                ),
              ),
            );
          },
        );
      } else if (indexxx == 1) {
        print("check lenth index1");
        return isSerchCompnayPage == false
            ? SizedBox()
            : Expanded(
                child: SingleChildScrollView(
                  controller: scrollController,
                  child: PaginationWidget(
                    scrollController: scrollController,
                    totalSize: searchPages?.object?.totalElements,
                    offSet: searchPages?.object?.pageable?.pageNumber,
                    onPagination: (p0) async {
                      if (searchController.text.contains("#")) {
                        String hashTageValue =
                            searchController.text.replaceAll("#", "%23");
                        BlocProvider.of<HashTagCubit>(context)
                            .serchPagesCompnayPagaationApi(
                                context, '${(p0 + 1)}', hashTageValue.trim());
                      } else {
                        if (searchController.text.isNotEmpty) {
                          print("this mehtod");
                          BlocProvider.of<HashTagCubit>(context)
                              .serchPagesCompnayPagaationApi(context,
                                  '${(p0 + 1)}', searchController.text.trim());
                        }
                      }
                    },
                    items: ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      padding: EdgeInsets.only(top: 5),
                      itemCount: searchPages?.object?.content?.length ?? 0,
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            Container(
                              height: 55,
                              width: _width / 1.1,
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey),
                                  borderRadius: BorderRadius.circular(10)),
                              child: Row(children: [
                                SizedBox(
                                  width: 8,
                                ),
                                searchPages?.object?.content?[index]
                                            .companyPageProfilePic ==
                                        null
                                    ? CircleAvatar(
                                        backgroundColor: Colors.white,
                                        radius: 25,
                                        child:
                                            Image.asset(ImageConstant.tomcruse))
                                    : CircleAvatar(
                                        backgroundColor: Colors.white,
                                        backgroundImage: NetworkImage(
                                          "${searchPages?.object?.content?[index].companyPageProfilePic}",
                                        ),
                                        radius: 25,
                                      ),
                                SizedBox(
                                  width: 8,
                                ),
                                Container(
                                  // color: Colors.amber,
                                  margin: EdgeInsets.only(right: 5),
                                  child: Text(
                                    "${searchPages?.object?.content?[index].companyPageName}",
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                    ),
                                  ),
                                ),
                              ]),
                            ),
                            SizedBox(
                              height: 10,
                            )
                          ],
                        );
                      },
                    ),
                  ),
                ),
              );
      } else {
        return isExpert == false
            ? SizedBox()
            : Expanded(
                child: SingleChildScrollView(
                  controller: scrollController,
                  child: PaginationWidget(
                    scrollController: scrollController,
                    totalSize: getalluserlistModel?.object?.totalElements,
                    offSet: getalluserlistModel?.object?.pageable?.pageNumber,
                    onPagination: (p0) async {
                      if (searchController.text.contains("#")) {
                        String hashTageValue =
                            searchController.text.replaceAll("#", "%23");
                        BlocProvider.of<HashTagCubit>(context)
                            .getAllPagaationApi(
                                (p0 + 1), hashTageValue.trim(), context);
                      } else {
                        if (searchController.text.isNotEmpty) {
                          print("this mehtod");
                          BlocProvider.of<HashTagCubit>(context)
                              .getAllPagaationApi((p0 + 1),
                                  searchController.text.trim(), context);
                        }
                      }
                    },
                    items: ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      padding: EdgeInsets.zero,
                      itemCount: getalluserlistModel?.object?.content?.length,
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            if (getalluserlistModel
                                    ?.object?.content?[index].hashtagNamesDto ==
                                null)
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: GestureDetector(
                                  onTap: () {
                                    if (UserLogin_ID != null) {
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
                                                User_ID:
                                                    "${getalluserlistModel?.object?.content?[index].userUid}",
                                                isFollowing: "REQUESTED"));
                                      }));
                                    } else {
                                      NaviRegisterScreen();
                                    }
                                  },
                                  child: Container(
                                    height: 55,
                                    width: _width / 1.1,
                                    decoration: BoxDecoration(
                                        border: Border.all(color: Colors.grey),
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Row(children: [
                                      SizedBox(
                                        width: 8,
                                      ),
                                      getalluserlistModel
                                                  ?.object
                                                  ?.content?[index]
                                                  .userProfile ==
                                              null
                                          ? CircleAvatar(
                                              backgroundColor: Colors.white,
                                              radius: 25,
                                              child: Image.asset(
                                                  ImageConstant.tomcruse))
                                          : CircleAvatar(
                                              backgroundColor: Colors.white,
                                              backgroundImage: NetworkImage(
                                                "${getalluserlistModel?.object?.content?[index].userProfile}",
                                              ),
                                              radius: 25,
                                            ),
                                      SizedBox(
                                        width: 8,
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(right: 10),
                                        // width: _width / 1.5,
                                        child: Text(
                                          "${getalluserlistModel?.object?.content?[index].userName}",
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15,
                                          ),
                                        ),
                                      ),
                                      Image.asset(
                                        ImageConstant.Star,
                                        height: 18,
                                      )
                                    ]),
                                  ),
                                ),
                              ),
                            if (getalluserlistModel
                                    ?.object?.content?[index].hashtagNamesDto !=
                                null)
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: GestureDetector(
                                  onTap: () {
                                    if (UserLogin_ID != null) {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                BlocProvider<HashTagCubit>(
                                              create: (context) =>
                                                  HashTagCubit(),
                                              child: HashTagViewScreen(
                                                  title:
                                                      "${getalluserlistModel?.object?.content?[index].hashtagNamesDto?.hashtagName}"),
                                            ),
                                          ));
                                    } else {
                                      NaviRegisterScreen();
                                    }
                                  },
                                  child: Container(
                                    height: 50,
                                    width: _width / 1.1,
                                    decoration: BoxDecoration(
                                        border: Border.all(color: Colors.grey),
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Row(
                                      children: [
                                        SizedBox(
                                          width: 8,
                                        ),
                                        Container(
                                          width: _width / 1.5,
                                          child: Text(
                                            "${getalluserlistModel?.object?.content?[index].hashtagNamesDto?.hashtagName}",
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 15,
                                            ),
                                          ),
                                        ),
                                        Container(
                                          width: 10,
                                        ),
                                        Text(
                                          "${getalluserlistModel?.object?.content?[index].hashtagNamesDto?.postCount} Post",
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              )
                          ],
                        );
                      },
                    ),
                  ),
                ),
              );
      }
    } else {
      return Expanded(
          child: Container(
        color: Colors.red,
      ));
    }
  }

  saveNotificationCount(int NotificationCount, int MessageCount) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt(PreferencesKey.NotificationCount, NotificationCount);
    prefs.setInt(PreferencesKey.MessageCount, MessageCount);
  }

  NaviRegisterScreen() {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => RegisterCreateAccountScreen(
              backSearch: true,
            )));
  }
}
