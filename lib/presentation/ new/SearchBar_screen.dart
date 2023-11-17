// ignore_for_file: prefer_const_constructors, non_constant_identifier_names, prefer_const_literals_to_create_immutables, must_be_immutable

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hashtagable/widgets/hashtag_text.dart';
import 'package:pds/API/Model/Getalluset_list_Model/get_all_userlist_model.dart';
import 'package:pds/API/Model/getSerchDataModel/getSerchDataModel.dart';
import 'package:pds/core/utils/color_constant.dart';
import 'package:pds/core/utils/image_constant.dart';
import 'package:pds/presentation/%20new/HashTagView_screen.dart';
import 'package:pds/presentation/%20new/newbottembar.dart';
import 'package:pds/widgets/pagenation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:pds/presentation/%20new/profileNew.dart';
import '../../API/Bloc/HashTag_Bloc/HashTag_cubit.dart';
import '../../API/Bloc/HashTag_Bloc/HashTag_state.dart';
import '../../API/Model/HashTage_Model/HashTag_model.dart';

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
  List text1 = ["All", "Experts"];
  bool dataget = false;
  GetAllUserListModel? getalluserlistModel;
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

  int? indexxx;
  bool isSerch = false;
  GetDataInSerch? getDataInSerch;
  HashtagModel? hashtagModel; /* 
  HashTagImageModel? hashTagImageModel; */
  bool apiDataSetup = false;
  getUserData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    dataSetup = 0;
    indexxx = 0;
    /*  dataSetup = prefs.getInt(
      "tabSelction",
    );
    if (dataSetup != null) {
      dataSetup = await dataSetup;
    } else {
      dataSetup = await widget.value2;
    } */
    if (mounted) {
      setState(() {
        // Update the widget's state.
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getUserData();
    BlocProvider.of<HashTagCubit>(context)
        .HashTagForYouAPI(context, 'FOR YOU', '1');
    BlocProvider.of<HashTagCubit>(context).serchDataGet(context);

    // BlocProvider.of<HashTagCubit>(context).HashTagBannerAPI(context);
  }

  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var _height = MediaQuery.of(context).size.height;
    var _width = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: BlocConsumer<HashTagCubit, HashTagState>(
        listener: (context, state) {
          if (state is HashTagErrorState) {
            print("i want error print${state.error}");
            SnackBar snackBar = SnackBar(
              content: Text(state.error),
              backgroundColor: ColorConstant.primary_color,
            );
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          }
          if (state is GetSerchData) {
            getDataInSerch = state.getDataInSerch;
          }
          if (state is HashTagLoadedState) {
            apiDataSetup = true;
            print(
                "HashTagLoadedStateHashTagLoadedState${state.HashTagData.message}dfdfh`${state.HashTagData.object}");
            hashtagModel = state.HashTagData;
          }
          if (state is GetAllUserLoadedState) {
            dataget = true;
            print("api caling");
            getalluserlistModel = state.getAllUserRoomData;
            getalluserlistModel?.object?.content?.forEach((element) {
              print(
                  "i want to check dtata-${element.hashtagNamesDto?.hashtagName}");
            });
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
                              autofocus: true,
                              onEditingComplete: () {
                                print("dsfhdsfsdsgfgsd");
                              },
                              onTap: () {
                                if (mounted) {
                                  setState(() {
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
                                print("i want to check value-${value}");
                                if (value.contains('#')) {
                                  print("value.contains('#')");
                                  if (indexxx == 0) {
                                    print("index is  0");
                                    String hashTageValue =
                                        value.replaceAll("#", "%23");
                                    BlocProvider.of<HashTagCubit>(context)
                                        .getalluser(
                                            1, hashTageValue.trim(), context);
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
                                  } else {
                                    print("else condison woking");
                                    BlocProvider.of<HashTagCubit>(context)
                                        .getalluser(1, value.trim(), context,
                                            filterModule: 'EXPERT');
                                  }
                                } else {
                                  dataget = false;
                                  if (mounted) {
                                    setState(() {
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
                                      BlocProvider.of<HashTagCubit>(context)
                                          .serchDataAdd(context, value.trim());
                                    });
                                  } else {
                                    _timer = Timer(Duration(seconds: 5), () {
                                      BlocProvider.of<HashTagCubit>(context)
                                          .serchDataAdd(context, value.trim());
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
                              setState(() {
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
                              } else {
                                BlocProvider.of<HashTagCubit>(context)
                                    .getalluser(1, value.trim(), context,
                                        filterModule: 'EXPERT');
                              }
                            } else {
                              dataget = false;
                              if (mounted) {
                                setState(() {
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
                                  setState(() {
                                    // Update the widget's state.
                                  });
                                }
                                if (searchController.text.contains('#')) {
                                  print("value.contains('#')");
                                  if (indexxx == 0) {
                                    print("index is  0");
                                    String hashTageValue = searchController.text
                                        .replaceAll("#", "%23");
                                    BlocProvider.of<HashTagCubit>(context)
                                        .getalluser(
                                            1, hashTageValue.trim(), context);
                                  } else {
                                    print("index is not 0");
                                    String hashTageValue = searchController.text
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
                                        ? Color(0xffED1C25)
                                        : dataSetup == index
                                            ? Color(0xffED1C25)
                                            : Color(0xffFBD8D9),
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
                                              : Color(0xffED1C25)),
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
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                                      setState(() {
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
                                            ? Color(0xffED1C25)
                                            : dataSetup == index
                                                ? Color(0xffED1C25)
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
                                                  : Color(0xffED1C25)),
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
                                  fit: BoxFit.cover, height: 100.0, width: 100),
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
                      ? NavagtionPassing1()
                      : SizedBox()
                  : apiDataSetup == true
                      ? NavagtionPassing(hashtagModel: hashtagModel)
                      : SizedBox()
            ],
          );
        },
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
                                setState(() {});

                                if (searchController.text.contains('#')) {
                                  String hashTageValue = searchController.text
                                      .replaceAll("#", "%23");
                                  BlocProvider.of<HashTagCubit>(context)
                                      .getalluser(
                                          1, hashTageValue.trim(), context);
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
                                setState(() {
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
                        activeColor: Color(0xffED1C25),
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
            child: PaginationWidget(
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

  Widget NavagtionPassing1() {
    var _height = MediaQuery.of(context).size.height;
    var _width = MediaQuery.of(context).size.width;

    if (indexxx != null) {
      if (indexxx == 0) {
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
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return ProfileScreen(
                                    User_ID:
                                        "${getalluserlistModel?.object?.content?[index].userUid}",
                                    isFollowing: "REQUESTED");
                              }));
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
                                Stack(
                                  alignment: Alignment.bottomRight,
                                  children: [
                                    getalluserlistModel?.object?.content?[index]
                                                .userProfile ==
                                            null
                                        ? CircleAvatar(
                                            radius: 25,
                                            child: Image.asset(
                                                ImageConstant.pdslogo))
                                        : CircleAvatar(
                                            backgroundImage: NetworkImage(
                                              "${getalluserlistModel?.object?.content?[index].userProfile}",
                                            ),
                                            radius: 25,
                                          ),
                                    getalluserlistModel?.object?.content?[index]
                                                .isExpert ==
                                            true
                                        ? Image.asset(
                                            ImageConstant.Star,
                                            height: 18,
                                          )
                                        : SizedBox()
                                  ],
                                ),
                                SizedBox(
                                  width: 8,
                                ),
                                Container(
                                  width: _width / 1.5,
                                  // color: Colors.amber,
                                  child: Text(
                                    "${getalluserlistModel?.object?.content?[index].userName}",
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                    ),
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
                    print("this mehtod");
                    BlocProvider.of<HashTagCubit>(context).getAllPagaationApi(
                        (p0 + 1), searchController.text.trim(), context);
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
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return ProfileScreen(
                                    User_ID:
                                        "${getalluserlistModel?.object?.content?[index].userUid}",
                                    isFollowing: "REQUESTED");
                              }));
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
                                Stack(
                                  alignment: Alignment.bottomRight,
                                  children: [
                                    getalluserlistModel?.object?.content?[index]
                                                .userProfile ==
                                            null
                                        ? CircleAvatar(
                                            radius: 25,
                                            child: Image.asset(
                                                ImageConstant.pdslogo))
                                        : CircleAvatar(
                                            backgroundImage: NetworkImage(
                                              "${getalluserlistModel?.object?.content?[index].userProfile}",
                                            ),
                                            radius: 25,
                                          ),
                                    getalluserlistModel?.object?.content?[index]
                                                .isExpert ==
                                            true
                                        ? Image.asset(
                                            ImageConstant.Star,
                                            height: 18,
                                          )
                                        : SizedBox()
                                  ],
                                ),
                                SizedBox(
                                  width: 8,
                                ),
                                Container(
                                  width: _width / 1.5,
                                  child: Text(
                                    "${getalluserlistModel?.object?.content?[index].userName}",
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                    ),
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
}
