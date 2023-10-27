// ignore_for_file: prefer_const_constructors, non_constant_identifier_names, prefer_const_literals_to_create_immutables

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pds/API/Bloc/Get_all_user_list_Bloc/get_all_user_List_state.dart';
import 'package:pds/API/Bloc/Get_all_user_list_Bloc/get_all_user_list_Cubit.dart';
import 'package:pds/API/Model/Getalluset_list_Model/get_all_userlist_model.dart';
import 'package:pds/core/utils/image_constant.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AllSearchScreen extends StatefulWidget {
  dynamic value3;
  AllSearchScreen({required this.value3});

  @override
  State<AllSearchScreen> createState() => _AllSearchScreenState();
}

class _AllSearchScreenState extends State<AllSearchScreen> {
  int sliderCurrentPosition = 0;
  dynamic dataSetup;
  TextEditingController searchController = TextEditingController();
  List text = ["All", "Experts"];
  List imageList = [
    ImageConstant.Rectangle,
    ImageConstant.Rectangle,
    ImageConstant.Rectangle,
    ImageConstant.Rectangle,
    ImageConstant.Rectangle,
  ];
  int? indexxx;
  bool dataget = false;
  GetAllUserListModel? getalluserlistModel;

  @override
  void initState() {
    indexxx = 0;
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    searchController.text = '';
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<GetAllUserCubit, GetAllUserState>(
        listener: (context, state) {
          if (state is GetAllUserLoadedState) {
            dataget = true;
            getalluserlistModel = state.getAllUserRoomData;
          }
        },
        builder: (context, state) {
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 15, right: 15, top: 60),
                child: Container(
                  height: 48,
                  decoration: BoxDecoration(
                      color: Color(0xffF0F0F0),
                      borderRadius: BorderRadius.circular(30)),
                  child: TextFormField(
                    onChanged: (value) {
                      print('value$value');
                      if (value.isNotEmpty) {
                        if (indexxx == 0) {
                          BlocProvider.of<GetAllUserCubit>(context)
                              .getalluser(1, 5, value.trim(), context);
                        } else {
                          BlocProvider.of<GetAllUserCubit>(context).getalluser(
                              1, 5, value.trim(), context,
                              filterModule: 'EXPERT');
                        }
                      }else{
                        dataget = false;
                       setState(() {
                         
                       });
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
              SizedBox(
                  // height: 40,
                  width: double.infinity,
                  child: Column(children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: List.generate(2, (index) {
                        return GestureDetector(
                          onTap: () {
                            indexxx = index;
                            dataSetup = null;

                            SharedPreferencesFunction(indexxx ?? 0);
                            setState(() {});
                            if (searchController.text.isNotEmpty) {
                            
                              if (indexxx == 0) {
                                BlocProvider.of<GetAllUserCubit>(context)
                                    .getalluser(1, 5,
                                        searchController.text.trim(), context);
                              } else {
                                BlocProvider.of<GetAllUserCubit>(context)
                                    .getalluser(1, 5,
                                        searchController.text.trim(), context,
                                        filterModule: 'EXPERT');
                              }
                            }else{

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
              dataget == true ? NavagtionPassing() : SizedBox(),
            ],
          );
        },
      ),
    );
  }

  SharedPreferencesFunction(int value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt("tabSelction", value);
  }

  Widget NavagtionPassing() {
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
                        Container(
                          height: 40,
                          width: 50,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(2)),
                          child: Stack(
                            alignment: Alignment.bottomRight,
                            children: [
                              CircleAvatar(
                                child: CachedNetworkImage(
                                  imageUrl:
                                      '${getalluserlistModel?.object?.content?[index].userProfile}',
                                  height: 120,
                                  width: 120,
                                  fit: BoxFit.cover,
                                  placeholder: (context, url) =>
                                      CircularProgressIndicator(),
                                  errorWidget: (context, url, error) =>
                                      Icon(Icons.error),
                                ),
                              ),
                              getalluserlistModel
                                          ?.object?.content?[index].isExpert ==
                                      true
                                  ? Image.asset(
                                      ImageConstant.Star,
                                      height: 20,
                                    )
                                  : SizedBox()
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          "${getalluserlistModel?.object?.content?[index].userName}",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
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
                        Stack(
                          alignment: Alignment.bottomRight,
                          children: [
                            CircleAvatar(
                              child: CachedNetworkImage(
                                imageUrl:
                                    '${getalluserlistModel?.object?.content?[index].userProfile}',
                                height: 120,
                                width: 120,
                                fit: BoxFit.cover,
                                placeholder: (context, url) =>
                                    CircularProgressIndicator(),
                                errorWidget: (context, url, error) =>
                                    Icon(Icons.error),
                              ),
                            ),
                            getalluserlistModel
                                        ?.object?.content?[index].isExpert ==
                                    true
                                ? Image.asset(
                                    ImageConstant.Star,
                                    height: 20,
                                  )
                                : SizedBox()
                          ],
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          "${getalluserlistModel?.object?.content?[index].userName}",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
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
