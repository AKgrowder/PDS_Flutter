import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pds/API/Model/FetchAllExpertsModel/FetchAllExperts_Model.dart';
import 'package:pds/core/utils/image_constant.dart';
import 'package:pds/core/utils/sharedPreferences.dart';
import 'package:pds/widgets/custom_image_view.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../API/Bloc/sherinvite_Block/sherinvite_cubit.dart';
import '../../API/Bloc/sherinvite_Block/sherinvite_state.dart';
import '../../core/utils/color_constant.dart';
import '../../theme/theme_helper.dart';
import '../register_create_account_screen/register_create_account_screen.dart';
import 'Room_selection_screen.dart';

class ExpertsScreen extends StatefulWidget {
  String? RoomUUID;
  ExpertsScreen({this.RoomUUID});

  @override
  State<ExpertsScreen> createState() => _ExpertsScreenState();
}

var selecteoneArray;
String? User_ID;
Map userData = {
  "userData": [
    {
      "image": "assets/images/pexels-tima-miroshnichenko-5452201 2 (1).png",
    },
    {
      "image": "assets/images/pexels-tima-miroshnichenko-5452201 2 (3).png",
    },
    {
      "image": "assets/images/pexels-tima-miroshnichenko-5452201 2 (4).png",
    },
    {
      "image": "assets/images/pexels-tima-miroshnichenko-5452201 2 (5).png",
    },
  ],
};

List<String> experts = [
  "Expert 1",
  "Expert 2",
  "Expert 3",
  "Expert 4",
];

class _ExpertsScreenState extends State<ExpertsScreen> {
  var _containerColor;
  FetchAllExpertsModel? FetchAllExpertsData;
  void initState() {
    getUserID();

    BlocProvider.of<SherInviteCubit>(context).FetchAllExpertsAPI(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var _height = MediaQuery.of(context).size.height;
    var _width = MediaQuery.of(context).size.width;

    return Scaffold(
        backgroundColor: theme.colorScheme.onPrimary,
        appBar: AppBar(
          backgroundColor: theme.colorScheme.onPrimary,
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
            "Experts",
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontFamily: "outfit",
                fontSize: 20),
          ),
        ),
        body: BlocConsumer<SherInviteCubit, SherInviteState>(
            listener: (context, state) {
          if (state is SherInviteErrorState) {
            SnackBar snackBar = SnackBar(
              content: Text(state.error),
              backgroundColor: ColorConstant.primary_color,
            );
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          }
          if (state is SherInviteLoadingState) {
            Center(
              child: Container(
                margin: EdgeInsets.only(bottom: 100),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.asset(ImageConstant.loader,
                      fit: BoxFit.cover, height: 100.0, width: 100),
                ),
              ),
            );
          }
          if (state is SherInviteLoadedState) {
            SnackBar snackBar = SnackBar(
              content: Text(state.sherInvite.message ?? ""),
              backgroundColor: ColorConstant.primary_color,
            );
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
            Future.delayed(const Duration(milliseconds: 900), () {
              Navigator.pop(context);
            });
          }
          if (state is FetchAllExpertsLoadedState) {
            FetchAllExpertsData = state.FetchAllExpertsData;
          }
        }, builder: (context, state) {
          if (state is FetchAllExpertsLoadedState) {
            return SingleChildScrollView(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Padding(
                    //   padding: const EdgeInsets.only(top: 20.0, right: 25, left: 25),
                    //   child: Row(
                    //     children: [
                    //       Container(
                    //         width: 55,
                    //         height: 45,
                    //         decoration: BoxDecoration(
                    //             color: Color(0xFFED1C25),
                    //             borderRadius: BorderRadius.only(
                    //                 topLeft: Radius.circular(5),
                    //                 bottomLeft: Radius.circular(5))),
                    //         child: Center(
                    //           child: CustomImageView(
                    //             imagePath: ImageConstant.searchimage,
                    //             color: Colors.white,
                    //             height: 30,
                    //           ),
                    //         ),
                    //       ),
                    //       Container(
                    //         height: 45,
                    //         width: 230,
                    //         decoration: BoxDecoration(
                    //           color: Color(0xFFF6F6F6),
                    //           border: Border.all(
                    //             color: Color(0xFFEFEFEF),
                    //           ),
                    //           borderRadius: BorderRadius.only(
                    //               topRight: Radius.circular(5),
                    //               bottomLeft: Radius.circular(5)),
                    //         ),
                    //         child: Padding(
                    //           padding: const EdgeInsets.only(top: 0.0, left: 10),
                    //           child: TextField(
                    //             decoration: InputDecoration(
                    //                 hintText: 'Search here...', border: InputBorder.none),
                    //           ),
                    //         ),
                    //       ),
                    //       SizedBox(
                    //         width: 10,
                    //       ),
                    //       Container(
                    //         height: 40,
                    //         width: 50,
                    //         decoration: BoxDecoration(
                    //             color: Color(0xFFFFE7E7),
                    //             border: Border.all(
                    //               color: Color(0xFFED1C25),
                    //             ),
                    //             borderRadius: BorderRadius.all(Radius.circular(5))),
                    //         child: Center(
                    //           child: CustomImageView(
                    //             imagePath: ImageConstant.filterimage,
                    //             height: 25,
                    //           ),
                    //         ),
                    //       )
                    //     ],
                    //   ),
                    // ),
                    // SizedBox(
                    //   height: 20,
                    // ),
                    Padding(
                      padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                      child: Container(
                        // color: Colors.amber,
                        // height: _height ,
                        child: GridView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              childAspectRatio: 0.50,
                              mainAxisSpacing: 0,
                              crossAxisSpacing: 0,
                              crossAxisCount: 2,
                            ),
                            itemCount: FetchAllExpertsData?.object?.length,
                            itemBuilder: (BuildContext context, int index) {
                              return GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _containerColor = index;
                                  });
                                },
                                child: Padding(
                                  padding: EdgeInsets.only(top:10.0,left: 8,right: 8,bottom: 25),
                                  child: Container(
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            color: _containerColor == index
                                                ? Colors.red
                                                : Colors.transparent),
                                        color: _containerColor == index
                                            ? Color(0xFFFFE7E7)
                                            : Colors.transparent,
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(10),
                                        ),
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          FetchAllExpertsData?.object?[index]
                                                          .profilePic ==
                                                      "" ||
                                                  FetchAllExpertsData
                                                          ?.object?[index]
                                                          .profilePic ==
                                                      null
                                              ? Stack(
                                                  children: [
                                                    CustomImageView(
                                                      height: _height / 4.8,
                                                      width: _width,
                                                      fit: BoxFit.fill,
                                                      imagePath: ImageConstant
                                                          .brandlogo,
                                                    ),

                                                    /* index == 1
                                        ? Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Container(
                                              height: 14,
                                              width: 60,
                                              decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(2))),
                                              child: Row(children: [
                                                SizedBox(
                                                  width: 2,
                                                ),
                                                CircleAvatar(
                                                  maxRadius: 5,
                                                  backgroundColor: Colors.grey,
                                                ),
                                                SizedBox(
                                                  width: 5,
                                                ),
                                                Text(
                                                  "Offline",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      color: Colors.grey,
                                                      fontFamily: "outfit",
                                                      fontSize: 13),
                                                )
                                              ]),
                                            ),
                                          )
                                        : Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Container(
                                              height: 14,
                                              width: 60,
                                              decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(2))),
                                              child: Row(children: [
                                                SizedBox(
                                                  width: 2,
                                                ),
                                                CircleAvatar(
                                                  maxRadius: 5,
                                                  backgroundColor: Colors.red,
                                                ),
                                                SizedBox(
                                                  width: 5,
                                                ),
                                                Text(
                                                  "Online",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      color: Colors.red,
                                                      fontFamily: "outfit",
                                                      fontSize: 13),
                                                )
                                              ]),
                                            ),
                                          ), */
                                                  ],
                                                )
                                              : Stack(
                                                  children: [
                                                    CustomImageView(
                                                      url:
                                                          "${FetchAllExpertsData?.object?[index].profilePic}",
                                                      height: _height / 4.8,
                                                      width: _width,
                                                      fit: BoxFit.fill,
                                                      radius:
                                                          BorderRadius.circular(
                                                              10),
                                                    ),
                                                  ],
                                                ),

                                          Row(
                                            children: [
                                              Text(
                                                "${FetchAllExpertsData?.object?[index].userName}",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.black,
                                                    fontFamily: "outfit",
                                                    fontSize: 18),
                                              ),
                                              /*  Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: CustomImageView(
                                        imagePath: ImageConstant.imgright,
                                        height: 15,
                                      ),
                                    ) */
                                            ],
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 5, top: 0),
                                            child: Row(
                                              children: [
                                                CustomImageView(
                                                  imagePath: ImageConstant.bag,
                                                  height: 25,
                                                ),
                                                SizedBox(
                                                  width: 5,
                                                ),
                                                Text(
                                                  "${FetchAllExpertsData?.object?[index].expertise?[0].expertiseName}",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      color: Colors.grey,
                                                      fontFamily: "outfit",
                                                      fontSize: 15),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 5, top: 5),
                                            child: Row(
                                              children: [
                                                CustomImageView(
                                                  imagePath:
                                                      ImageConstant.timeimage,
                                                  height: 25,
                                                ),
                                                SizedBox(
                                                  width: 5,
                                                ),
                                                Text(
                                                  "${FetchAllExpertsData?.object?[index].workingHours}",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      color: Colors.black,
                                                      fontFamily: "outfit",
                                                      fontSize: 13),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 7, top: 10),
                                            child: Row(
                                              children: [
                                                CustomImageView(
                                                  imagePath:
                                                      ImageConstant.roundrupee,
                                                  height: 20,
                                                ),
                                                SizedBox(
                                                  width: 5,
                                                ),
                                                Text(
                                                  "₹${FetchAllExpertsData?.object?[index].fees}",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      color: Colors.black,
                                                      fontFamily: "outfit",
                                                      fontSize: 15),
                                                ),
                                              ],
                                            ),
                                          ),
                                          /* Padding(
                                  padding:
                                      const EdgeInsets.only(left: 5, top: 5),
                                  child: Row(
                                    children: [
                                      CustomImageView(
                                        imagePath: ImageConstant.starimage,
                                        height: 25,
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        "4.86 (20 reviews)",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w400,
                                            color: Colors.black,
                                            fontFamily: "outfit",
                                            fontSize: 15),
                                      ),
                                    ],
                                  ),
                                ), */
                                          /* SizedBox(
                                            height: 17.2,
                                          ), */
                                          Spacer(),
                                          // index == 1 || index == 0
                                          //     ?
                                          GestureDetector(
                                            onTap: () {
                                              if (widget.RoomUUID == null ||
                                                  widget.RoomUUID == "") {
                                                User_ID != null
                                                    ? Navigator.push(context,
                                                        MaterialPageRoute(
                                                            builder: (context) {
                                                        return RoomSelection(
                                                          ExperID:
                                                              "${FetchAllExpertsData?.object?[index].userEmail}",
                                                        );
                                                      }))
                                                    : Navigator.of(context)
                                                        .push(MaterialPageRoute(
                                                            builder: (context) =>
                                                                RegisterCreateAccountScreen()));
                                              } else {
                                                print(widget.RoomUUID);
                                                print(FetchAllExpertsData
                                                    ?.object?[index].userEmail);

                                                BlocProvider.of<
                                                            SherInviteCubit>(
                                                        context)
                                                    .sherInviteApi(
                                                        widget.RoomUUID
                                                            .toString(),
                                                        FetchAllExpertsData
                                                                ?.object?[index]
                                                                .userEmail
                                                                .toString() ??
                                                            "",
                                                        context);
                                              }
                                            },
                                            child: Container(
                                              height: 30,
                                              width: _width,
                                              decoration: BoxDecoration(
                                                color: Color(0xFFED1C25),
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(10)),
                                              ),
                                              child: Center(
                                                // child: index == 1
                                                //     ? Text(
                                                //         "invite sent",
                                                //         style: TextStyle(
                                                //             fontWeight:
                                                //                 FontWeight.w400,
                                                //             color: Colors.white,
                                                //             fontFamily: "outfit",
                                                //             fontSize: 15),
                                                //       )
                                                //     : Text(
                                                //         "invite",
                                                //         style: TextStyle(
                                                //             fontWeight:
                                                //                 FontWeight.w400,
                                                //             color: Colors.white,
                                                //             fontFamily: "outfit",
                                                //             fontSize: 15),
                                                //       ),
                                                child: Text(
                                                  "Invite",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      color: Colors.white,
                                                      fontFamily: "outfit",
                                                      fontSize: 15),
                                                ),
                                              ),
                                            ),
                                          )
                                          // : Container(
                                          //     height: 30,
                                          //     width: _width,
                                          //     decoration: BoxDecoration(
                                          //         color: Colors.white,
                                          //         border: Border.all(
                                          //           color: index == 3
                                          //               ? Colors.red
                                          //               : Colors.green,
                                          //         ),
                                          //         borderRadius: BorderRadius.all(
                                          //             Radius.circular(10))),
                                          //     child: Row(children: [
                                          //       SizedBox(
                                          //         width: 20,
                                          //       ),
                                          //       index == 3
                                          //           ? Padding(
                                          //               padding:
                                          //                   const EdgeInsets.only(
                                          //                       left: 20),
                                          //               child: Icon(
                                          //                 Icons.close,
                                          //                 color: Colors.red,
                                          //               ),
                                          //             )
                                          //           : Padding(
                                          //               padding:
                                          //                   const EdgeInsets.only(
                                          //                       left: 20),
                                          //               child: Icon(
                                          //                 Icons.done,
                                          //                 color: Colors.green,
                                          //               ),
                                          //             ),
                                          //       index == 3
                                          //           ? Text(
                                          //               "Rejected",
                                          //               style: TextStyle(
                                          //                   color: Colors.red,
                                          //                   fontFamily: 'outfit',
                                          //                   fontSize: 13,
                                          //                   fontWeight:
                                          //                       FontWeight.w300),
                                          //             )
                                          //           : Text(
                                          //               "Accepted",
                                          //               style: TextStyle(
                                          //                   color: Colors.green,
                                          //                   fontFamily: 'outfit',
                                          //                   fontSize: 13,
                                          //                   fontWeight:
                                          //                       FontWeight.w300),
                                          //             )
                                          //     ]),
                                          //   ),
                                        ],
                                      )),
                                ),
                              );
                            }),
                      ),
                    ),
                  ]),
            );
          }
          return Center(
            child: Container(
              margin: EdgeInsets.only(bottom: 100),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.asset(ImageConstant.loader,
                    fit: BoxFit.cover, height: 100.0, width: 100),
              ),
            ),
          );
        }));
  }

  getUserID() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    User_ID = prefs.getString(PreferencesKey.loginUserID);
  }
}
