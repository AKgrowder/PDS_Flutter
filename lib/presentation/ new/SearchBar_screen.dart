// ignore_for_file: prefer_const_constructors, non_constant_identifier_names, prefer_const_literals_to_create_immutables

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hashtagable/widgets/hashtag_text.dart';
import 'package:pds/API/Model/Getalluset_list_Model/get_all_userlist_model.dart';
import 'package:pds/core/utils/color_constant.dart';
import 'package:pds/core/utils/image_constant.dart';
import 'package:pds/presentation/%20new/HashTagView_screen.dart';
import 'package:pds/presentation/%20new/newbottembar.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../API/Bloc/HashTag_Bloc/HashTag_cubit.dart';
import '../../API/Bloc/HashTag_Bloc/HashTag_state.dart';
import '../../API/Model/HashTage_Model/HashTagBanner_model.dart';
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
  int? indexxx;
  bool isSerch = false;
  HashtagModel? hashtagModel;
  HashTagImageModel? hashTagImageModel;

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
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserData();
    BlocProvider.of<HashTagCubit>(context).HashTagForYouAPI(context);
    BlocProvider.of<HashTagCubit>(context).HashTagBannerAPI(context);
  }

  @override
  Widget build(BuildContext context) {
    var _height = MediaQuery.of(context).size.height;
    var _width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: BlocConsumer<HashTagCubit, HashTagState>(
        listener: (context, state) {
          if (state is HashTagErrorState) {
            SnackBar snackBar = SnackBar(
              content: Text(state.error),
              backgroundColor: ColorConstant.primary_color,
            );
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          }

          if (state is HashTagLoadedState) {
            print("HashTagLoadedStateHashTagLoadedState");
            hashtagModel = state.HashTagData;
          }
          if (state is GetAllUserLoadedState) {
            dataget = true;
            getalluserlistModel = state.getAllUserRoomData;
          }
          if (state is HashTagBannerLoadedState) {
            print("HashTagBannerLoadedState - ${hashTagImageModel?.object}");
            hashTagImageModel = state.hashTagImageModel;
          }
        },
        builder: (context, state) {
          return Column(
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
                              onTap: () {
                                setState(() {
                                  isSerch = true;
                                });

                                print("xfhdsfhsdfgsdfg-$isSerch");
                                /*    Navigator.push(context, MaterialPageRoute(
                            builder: (context) {
                              return AllSearchScreen();
                            },
                          )); */
                              },
                              onChanged: (value) {
                                if (value.contains('#')) {
                                  
                                  String hashTageValue = value.replaceAll("#", "%23");  
                                    BlocProvider.of<HashTagCubit>(context)
                                        .getalluser(
                                            1, 5, hashTageValue.trim(), context);

                                }
                                if (value.isNotEmpty) {
                                  print("fgdfhdfghdfgh-${value.trim()}");
                                  if (indexxx == 0) {
                                    BlocProvider.of<HashTagCubit>(context)
                                        .getalluser(
                                            1, 5, value.trim(), context);
                                  } else {
                                    BlocProvider.of<HashTagCubit>(context)
                                        .getalluser(1, 5, value.trim(), context,
                                            filterModule: 'EXPERT');
                                  }
                                } else {
                                  dataget = false;
                                  setState(() {});
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
                            setState(() {
                              isSerch = true;
                            });

                            print("xfhdsfhsdfgsdfg-$isSerch");
                            /*    Navigator.push(context, MaterialPageRoute(
                        builder: (context) {
                          return AllSearchScreen();
                        },
                      )); */
                          },
                          onChanged: (value) {
                            if (value.isNotEmpty) {
                              if (indexxx == 0) {
                                print("i want to  chrck-${value.trim()}");
                                BlocProvider.of<HashTagCubit>(context)
                                    .getalluser(1, 5, value.trim(), context);
                              } else {
                                BlocProvider.of<HashTagCubit>(context)
                                    .getalluser(1, 5, value.trim(), context,
                                        filterModule: 'EXPERT');
                              }
                            } else {
                              dataget = false;
                              setState(() {});
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
                            print("fdshfsdgfgsdfgsdfg--${text1[index]}");
                            return GestureDetector(
                              onTap: () {
                                indexxx = index;
                                dataSetup = null;

                                SharedPreferencesFunction(indexxx ?? 0);
                                setState(() {});
                                if (searchController.text.isNotEmpty) {
                                  if (indexxx == 0) {
                                    BlocProvider.of<HashTagCubit>(context)
                                        .getalluser(
                                            1,
                                            5,
                                            searchController.text.trim(),
                                            context);
                                  } else {
                                    BlocProvider.of<HashTagCubit>(context)
                                        .getalluser(
                                            1,
                                            5,
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
                  : SizedBox(
                      width: double.infinity,
                      child: Column(children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: List.generate(text.length, (index) {
                            return GestureDetector(
                              onTap: () {
                                indexxx = index;
                                dataSetup = null;

                                SharedPreferencesFunction(indexxx ?? 0);
                                setState(() {});
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
                      ])),
              Divider(
                color: Colors.grey,
              ),
              isSerch == true
                  ? SizedBox()
                  : TopSlider(hashTagImageModel: hashTagImageModel),
              isSerch == true
                  ? dataget == true
                      ? NavagtionPassing1()
                      : SizedBox()
                  : NavagtionPassing(hashtagModel: hashtagModel)
            ],
          );
        },
      ),
    );
  }

  Widget TopSlider({HashTagImageModel? hashTagImageModel}) {
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
                              setState(() {
                                sliderCurrentPosition = index;
                              });
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
  }

  SharedPreferencesFunction(int value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt("tabSelction", value);
  }

  Widget NavagtionPassing({HashtagModel? hashtagModel}) {
    if (indexxx != null) {
      if (indexxx == 0) {
        return Expanded(
          child: ListView.builder(
            padding: EdgeInsets.zero,
            itemCount: hashtagModel?.object?.length,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  Divider(
                    height: 3,
                    color: Colors.grey,
                  ),
                  SizedBox(
                    height: 70,
                    width: double.infinity,
                    child: Padding(
                      padding: const EdgeInsets.only(
                          top: 5, left: 10, right: 10, bottom: 5),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Trending in India",
                            style: TextStyle(
                              color: Color(0xff808080),
                              fontSize: 12,
                            ),
                          ),
                          HashTagText(
                            text: "${hashtagModel?.object?[index].hashtagName}",
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
                                        BlocProvider<HashTagCubit>(
                                      create: (context) => HashTagCubit(),
                                      child: HashTagViewScreen(
                                          title:
                                              "${hashtagModel?.object?[index].hashtagName}"),
                                    ),
                                  ));
                            },
                          ),
                          Text(
                            "${hashtagModel?.object?[index].postCount} posts",
                            style: TextStyle(
                              color: Color(0xff808080),
                              fontSize: 12,
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
        );
      } else {
        return Container(
          height: 100,
          width: double.infinity,
          color: Colors.amber,
        );

        /* Expanded(
          child: ListView.builder(
            padding: EdgeInsets.zero,
            itemCount: 5,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  Divider(
                    height: 3,
                    color: Colors.grey,
                  ),
                  SizedBox(
                    height: 70,
                    width: double.infinity,
                    child: Padding(
                      padding: const EdgeInsets.only(
                          top: 5, left: 10, right: 10, bottom: 5),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Trending in India",
                            style: TextStyle(
                              color: Color(0xff808080),
                              fontSize: 12,
                            ),
                          ),
                          Text(
                            "#EcofriendlyPackaingDesign",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                                fontWeight: FontWeight.w500),
                          ),
                          Text(
                            "2.64M posts",
                            style: TextStyle(
                              color: Color(0xff808080),
                              fontSize: 12,
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
        );
      */
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
          child: ListView.builder(
            padding: EdgeInsets.zero,
            itemCount: getalluserlistModel?.object?.content?.length,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
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
                            getalluserlistModel
                                        ?.object?.content?[index].userProfile ==
                                    null
                                ? CircleAvatar(
                                    radius: 25,
                                    child: Image.asset(ImageConstant.pdslogo))
                                : CircleAvatar(
                                    backgroundImage: NetworkImage(
                                      "${getalluserlistModel?.object?.content?[index].userProfile}",
                                    ),
                                    radius: 25,
                                  ),
                            getalluserlistModel
                                        ?.object?.content?[index].isExpert ==
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
                        Text(
                          "${getalluserlistModel?.object?.content?[index].userName}",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        )
                      ]),
                    ),
                  )
                ],
              );
            },
          ),
        );
      } else {
        return Expanded(
          child: ListView.builder(
            padding: EdgeInsets.zero,
            itemCount: getalluserlistModel?.object?.content?.length,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
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
                            getalluserlistModel
                                        ?.object?.content?[index].userProfile ==
                                    null
                                ? CircleAvatar(
                                    radius: 25,
                                    child: Image.asset(ImageConstant.pdslogo))
                                : CircleAvatar(
                                    backgroundImage: NetworkImage(
                                      "${getalluserlistModel?.object?.content?[index].userProfile}",
                                    ),
                                    radius: 25,
                                  ),
                            getalluserlistModel
                                        ?.object?.content?[index].isExpert ==
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
                        Text(
                          "${getalluserlistModel?.object?.content?[index].userName}",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        )
                      ]),
                    ),
                  )
                ],
              );
            },
          ),
        );
      }
    } else {
      return Expanded(
          child: Container(
        color: Colors.white,
      ));
    }
  }
}
