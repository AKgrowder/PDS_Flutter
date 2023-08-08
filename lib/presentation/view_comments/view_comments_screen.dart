import 'package:archit_s_application1/API/Model/coment/coment_model.dart';
import 'package:archit_s_application1/presentation/register_create_account_screen/register_create_account_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../API/Bloc/senMSG_Bloc/senMSG_cubit.dart';
import '../../API/Bloc/senMSG_Bloc/senMSG_state.dart';
import '../../core/utils/color_constant.dart';
import '../../core/utils/image_constant.dart';
import '../../core/utils/sharedPreferences.dart';
import '../../theme/theme_helper.dart';
import '../../widgets/custom_image_view.dart';

class ViewCommentScreen extends StatefulWidget {
  final Room_ID;
  final Title;

  const ViewCommentScreen({required this.Room_ID, required this.Title});

  @override
  State<ViewCommentScreen> createState() => _ViewCommentScreenState();
}

List<String> commentslist = [
  "Lectus scelerisque vulputate tortor pellentesque ac. Fringilla cras ut facilisis amet imperdiet vitae etiam pellentesque pellentesque. Pellentesq",
  "Lectus scelerisque vulputate tortor pellentesque ac. Fringilla cras ut facilisis amet imperdiet vitae etiam pellentesque pellentesque. Pellentesq",
  "Lectus scelerisque vulputate tortor pellentesque ac. Fringilla cras ut facilisis amet imperdiet vitae etiam pellentesque pellentesque. Pellentesq",
  "Lectus scelerisque vulputate tortor pellentesque ac. Fringilla cras ut facilisis amet imperdiet vitae etiam pellentesque pellentesque. Pellentesq",
];

class _ViewCommentScreenState extends State<ViewCommentScreen> {
  Object? get index => null;
  ComentApiModel? modelData;
  TextEditingController Add_Comment = TextEditingController();

  @override
  void initState() {
    BlocProvider.of<senMSGCubit>(context)
        .coomentPage(widget.Room_ID, ShowLoader: true);
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
            "View Comments",
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontFamily: "outfit",
                fontSize: 20),
          ),
        ),
        body: BlocConsumer<senMSGCubit, senMSGState>(
            listener: (context, state) async {
          if (state is senMSGErrorState) {
            SnackBar snackBar = SnackBar(
              content: Text(state.error),
              backgroundColor: ColorConstant.primary_color,
            );
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          }

          if (state is senMSGLoadingState) {
            // Center(
            //   child: Container(
            //     margin: EdgeInsets.only(bottom: 100),
            //     child: ClipRRect(
            //       borderRadius: BorderRadius.circular(20),
            //       child: Image.asset(ImageConstant.loader,
            //           fit: BoxFit.cover, height: 100.0, width: 100),
            //     ),
            //   ),
            // );
          }
          if (state is senMSGLoadedState) {
            BlocProvider.of<senMSGCubit>(context)
                .coomentPage(widget.Room_ID, ShowLoader: true);
          }
          if (state is ComentApiState) {
            modelData = state.comentApiClass;
          }
        }, builder: (context, state) {
          // if (state is ComentApiState) {
          return Padding(
              padding: const EdgeInsets.only(left: 16, right: 16),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(
                        color: const Color.fromARGB(101, 158, 158, 158))),
                child: SingleChildScrollView(
                  child: Column(children: [
                    Container(
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 5.5, right: 5),
                                    child: CircleAvatar(
                                      backgroundColor: Colors.black,
                                      maxRadius: 4,
                                    ),
                                  ),
                                  Container(
                                    width: _width / 1.2,
                                    // color: Colors.amber,
                                    child: Text(
                                      "${widget.Title}",
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 2,
                                      style: TextStyle(
                                        fontFamily: 'outfit',
                                        fontSize: 15,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ),
                                  /*   GestureDetector(
                            onTap: () {
                              setState(() {
                                if (image?.contains(index) ?? false) {
                                  image?.remove(index);
                                } else {
                                  image?.add(index);
                                }
                              });
                            },
                            child: (image?.contains(index) ?? false)
                                ? CustomImageView(
                                    imagePath:
                                        ImageConstant.unselectedimgVector,
                                    height: 20,
                                  )
                                : CustomImageView(
                                    imagePath: ImageConstant.selectedimage,
                                    height: 20,
                                  ),
                          ), */
                                ]),
                          ),
                          Divider(
                            color: Color.fromARGB(53, 117, 117, 117),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10, right: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "10th March 2023",
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontFamily: 'outfit',
                                    fontSize: 13,
                                    color: Colors.grey.shade600,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                Text(
                                  "${modelData?.object?.messageOutputList?.content?.length != null ? modelData?.object?.messageOutputList?.content?.length : '0'} Comments",
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontFamily: 'outfit',
                                    fontSize: 13,
                                    color: Colors.grey.shade600,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Divider(
                            color: Color.fromARGB(53, 117, 117, 117),
                          ),
                          // Padding(
                          //   padding: const EdgeInsets.only(right: 150.0),
                          //   child: Stack(
                          //     // mainAxisAlignment: MainAxisAlignment.start,
                          //     children: [
                          //       CustomImageView(
                          //         imagePath: ImageConstant.viewcommentimage,
                          //         height: 100,
                          //       ),
                          //       Padding(
                          //         padding: const EdgeInsets.only(left: 100.0, top: 5),
                          //         child: CustomImageView(
                          //           imagePath: ImageConstant.deleteimage,
                          //           height: 30,
                          //           // alignment: Alignment.topCenter,
                          //         ),
                          //       ),
                          //     ],
                          //   ),
                          // ),
                          //-----------------------------------------------------------
                          // Container(
                          //   height: 60,
                          //   width: width,
                          //   // color: Colors.red,
                          //   child: Row(
                          //     children: [
                          //       Stack(
                          //         children: [
                          //           Container(
                          //             height: 50,
                          //             width: width - 90,
                          //             decoration: BoxDecoration(
                          //                 color: Color(0xFFF5F5F5),
                          //                 borderRadius:
                          //                     BorderRadius.circular(25)),
                          //             child: Padding(
                          //               padding: const EdgeInsets.only(
                          //                   left: 45, right: 10),
                          //               child: TextField(
                          //                 controller: Add_Comment,
                          //                 cursorColor: Colors.grey,
                          //                 decoration: InputDecoration(
                          //                   border: InputBorder.none,
                          //                   hintText: "Add Comment",
                          //                 ),
                          //               ),
                          //             ),
                          //           ),
                          //           Container(
                          //             height: 50,
                          //             width: width - 90,
                          //             child: Row(
                          //               children: [
                          //                 Padding(
                          //                   padding: const EdgeInsets.all(8.0),
                          //                   child: Image.asset(
                          //                     "assets/images/ic_outline-emoji-emotions.png",
                          //                     height: 30,
                          //                   ),
                          //                 ),
                          //                 Spacer(),
                          //                 Image.asset(
                          //                   "assets/images/paperclip-2.png",
                          //                   height: 30,
                          //                 ),
                          //                 Padding(
                          //                   padding: const EdgeInsets.all(8.0),
                          //                   child: Image.asset(
                          //                     "assets/images/Vector (12).png",
                          //                     height: 22,
                          //                   ),
                          //                 ),
                          //               ],
                          //             ),
                          //           ),
                          //         ],
                          //       ),
                          //     GestureDetector(
                          //       onTap: () {
                          //         print(
                          //             "Add comment button-${Add_Comment.text}");
                          //         if (Add_Comment.text.isNotEmpty) {
                          //           checkGuestUser();
                          //         } else {
                          //           SnackBar snackBar = SnackBar(
                          //             content: Text('Please Enter Comment'),
                          //             backgroundColor:
                          //                 ColorConstant.primary_color,
                          //           );
                          //           ScaffoldMessenger.of(context)
                          //               .showSnackBar(snackBar);
                          //         }
                          //       },
                          //       child: Container(
                          //         height: 50,
                          //         // width: 50,
                          //         decoration: BoxDecoration(
                          //             color: Color(0xFFED1C25),
                          //             borderRadius:
                          //                 BorderRadius.circular(25)),
                          //         child: Image.asset(
                          //           "assets/images/Vector (13).png",
                          //           color: Colors.white,
                          //         ),

                          //         // width: width - 95,
                          //       ),
                          //     ),
                          //   ],
                          // ),
                          // ),
                          Row(
                            children: [
                              Container(
                                height: 50,
                                width: _width - 90,
                                decoration: BoxDecoration(
                                    color: Color(0xFFF5F5F5),
                                    borderRadius: BorderRadius.circular(25)),
                                child: Row(children: [
                                  SizedBox(
                                    width: 10,
                                  ),
                                  GestureDetector(onTap: () {
                                    // buildSticker();
                                  },
                                    child: Image.asset(
                                      "assets/images/ic_outline-emoji-emotions.png",
                                      height: 30,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Container(
                                    height: 40,
                                    width: _width / 2.1,
                                    // color: Colors.amber,
                                    child: TextField(
                                      controller: Add_Comment,
                                      cursorColor: Colors.grey,
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: "Add Comment",
                                      ),
                                    ),
                                  ),
                                  Spacer(),
                                  Image.asset(
                                    "assets/images/paperclip-2.png",
                                    height: 30,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Image.asset(
                                    "assets/images/Vector (12).png",
                                    height: 22,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                ]),
                                // child: TextField(
                                //   controller: Add_Comment,
                                //   cursorColor: Colors.grey,
                                //   decoration: InputDecoration(
                                //     border: InputBorder.none,
                                //     hintText: "Add Comment",
                                //   ),
                                // ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  print(
                                      "Add comment button-${Add_Comment.text}");
                                  if (Add_Comment.text.isNotEmpty) {
                                    checkGuestUser();
                                  } else {
                                    SnackBar snackBar = SnackBar(
                                      content: Text('Please Enter Comment'),
                                      backgroundColor:
                                          ColorConstant.primary_color,
                                    );
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(snackBar);
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
                        ],
                      ),
                    ),
                    Container(
                      height: _height / 1.4,
                      // color: Colors.red[200],
                      child: Padding(
                        padding: const EdgeInsets.only(top: 15),
                        child: modelData?.object?.messageOutputList != null
                            ? ListView.builder(
                                itemCount: modelData?.object?.messageOutputList
                                    ?.content?.length,
                                shrinkWrap: true,
                                // physics: NeverScrollableScrollPhysics(),
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(
                                        /* horizontal: 35, vertical: 5 */),
                                    child: GestureDetector(
                                      onTap: () {},
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 10, right: 3),
                                                child: CustomImageView(
                                                  imagePath:
                                                      ImageConstant.tomcruse,
                                                  height: 20,
                                                ),
                                              ),
                                              Text(
                                                "tom_cruse",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w400,
                                                    color: Colors.black,
                                                    fontFamily: "outfit",
                                                    fontSize: 14),
                                              ),
                                              /*  Spacer(), */
                                              /*   Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 10),
                                                child: GestureDetector(
                                                  onTap: () {
                                                    setState(() {
                                                      if (image?.contains(
                                                              index) ??
                                                          false) {
                                                        image?.remove(index);
                                                      } else {
                                                        image?.add(index);
                                                      }
                                                    });
                                                  },
                                                  child: (image?.contains(
                                                              index) ??
                                                          false)
                                                      ? CustomImageView(
                                                          imagePath:
                                                              ImageConstant.pin,
                                                          height: 17,
                                                        )
                                                      : CustomImageView(
                                                          imagePath:
                                                              ImageConstant
                                                                  .selectedpin,
                                                          height: 17,
                                                        ),
                                                ),
                                              ), */
                                            ],
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          /* index == 2
                                          ? Padding(
                                              padding: const EdgeInsets.only(
                                                left: 8.0,
                                              ),
                                              child: Row(
                                                children: [
                                                  CustomImageView(
                                                    imagePath: ImageConstant
                                                        .viewcommentimage,
                                                    height: 60,
                                                  ),
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                  CustomImageView(
                                                    imagePath:
                                                        ImageConstant.mobileman,
                                                    height: 60,
                                                  ),
                                                ],
                                              ),
                                            )
                                          : SizedBox(), */
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Padding(
                                                padding: EdgeInsets.only(
                                                    left: 8.0,
                                                    top: 5,
                                                    bottom: 10),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 2.0,
                                                              top: 5),
                                                      // child: CircleAvatar(
                                                      //     backgroundColor: Colors.black,
                                                      //     maxRadius: 3),
                                                    ),
                                                    SizedBox(
                                                      width: 3,
                                                    ),
                                                    Container(
                                                      height: 45,
                                                      width: _width / 1.3,
                                                      // color: Colors.amber,
                                                      child: Text(
                                                        modelData
                                                                ?.object
                                                                ?.messageOutputList
                                                                ?.content?[
                                                                    index]
                                                                .message ??
                                                            "",
                                                        maxLines: 3,
                                                        textScaleFactor: 1.0,
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color: Colors.grey,
                                                            fontFamily:
                                                                "outfit",
                                                            fontSize: 12),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              Text(
                                                "10th March 2023 2:23 PM",
                                                maxLines: 3,
                                                textScaleFactor: 1.0,
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.grey,
                                                    fontFamily: "outfit",
                                                    fontSize: 12),
                                              ),
                                            ],
                                          ),
                                          Divider(
                                            color: const Color.fromARGB(
                                                117, 0, 0, 0),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                })
                            : SizedBox(),
                      ),
                    ), 
                  ]),
                ),
              ));
          // }
          // return Center(
          //   child: Container(
          //     margin: EdgeInsets.only(bottom: 100),
          //     child: ClipRRect(
          //       borderRadius: BorderRadius.circular(20),
          //       child: Image.asset(ImageConstant.loader,
          //           fit: BoxFit.cover, height: 100.0, width: 100),
          //     ),
          //   ),
          // );
        }));
  }
//  Widget buildSticker() {
//     return EmojiPicker( 
  
//   onEmojiSelected: (emoji, category) {
//     print(emoji);
     
//   },
//     );
//   }
  checkGuestUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var UserLogin_ID = prefs.getString(PreferencesKey.loginUserID);

    if (UserLogin_ID != null) {
      print("user login Mood");
      if (Add_Comment.text.isNotEmpty) {
        BlocProvider.of<senMSGCubit>(context)
            .senMSGAPI(widget.Room_ID, Add_Comment.text, ShowLoader: true);
        Add_Comment.text = '';
      } else {
        if (UserLogin_ID != null) {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => RegisterCreateAccountScreen()));
        } else {
          SnackBar snackBar = SnackBar(
            content: Text('Please Enter Comment'),
            backgroundColor: ColorConstant.primary_color,
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
      }
    } else {
      print("User guest Mood on");
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => RegisterCreateAccountScreen()));
    }
  }
}
