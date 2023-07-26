import 'package:archit_s_application1/core/utils/size_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../API/Bloc/senMSG_Bloc/senMSG_cubit.dart';
import '../../core/utils/image_constant.dart';
import '../../theme/theme_helper.dart';
import '../../widgets/custom_image_view.dart';
import '../home/home.dart';

class ViewCommentScreen extends StatefulWidget {
  final Room_ID;

  const ViewCommentScreen({required this.Room_ID});

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

  TextEditingController Add_Comment = TextEditingController();

  @override
  Widget build(BuildContext context) {
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
            "View details",
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontFamily: "outfit",
                fontSize: 20),
          ),
        ),
        body: BlocProvider<senMSGCubit>(
          create: (_) => senMSGCubit(),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(left: 16, right: 16),
              child: Column(children: [
                Center(
                  child: Container(
                    // height: height,
                    // width: width / 1.2,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(
                            color:
                                const Color.fromARGB(101, 158, 158, 158))),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                              mainAxisAlignment:
                                  MainAxisAlignment.spaceAround,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 4.0),
                                  child: CircleAvatar(
                                    backgroundColor: Colors.black,
                                    maxRadius: 4,
                                  ),
                                ),
                                Text(
                                  "Baluran Wild The Savvanah Baluran Wild The\n Savvanah",
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontFamily: 'outfit',
                                    fontSize: 13,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w400,
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
                          padding:
                              const EdgeInsets.only(left: 10, right: 10),
                          child: Row(
                            mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
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
                                "6 Comments",
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
                        Row(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 0, top: 10),
                              child: Row(
                                children: [
                                  Container(
                                    height: 50,
                                    width: width - 90,
                                    decoration: BoxDecoration(
                                        color: Color(0XFFF5F5F5),
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    child: Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            left: 5.0, right: 5.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Container(
                                              child: Image.asset(
                                                "assets/images/ic_outline-emoji-emotions.png",
                                                height: 30,
                                              ),
                                            ),
                                            Expanded(
                                                child: TextField(
                                              controller: Add_Comment,
                                              cursorColor: Colors.grey,
                                              decoration: InputDecoration(
                                                border: InputBorder.none,
                                                hintText: "Add Comment",
                                              ),
                                            )),
                                            // SizedBox(
                                            //   width: 180,
                                            // ),
                                            Container(
                                              child: Image.asset(
                                                "assets/images/paperclip-2.png",
                                                height: 30,
                                              ),
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Container(
                                              child: Image.asset(
                                                "assets/images/Vector (12).png",
                                                height: 22,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),

                                    // child: Padding(
                                    //   padding: const EdgeInsets.only(left: 5),
                                    //   child: TextField(
                                    //     cursorColor: Colors.grey,
                                    //     decoration: InputDecoration(
                                    //       disabledBorder: InputBorder.none,hintText: 'Add Comment',
                                    //       border: InputBorder.none,
                                    //       icon: Image.asset(
                                    //         "assets/images/ic_outline-emoji-emotions.png",
                                    //         height: 30,
                                    //       ),
                                    //     ),
                                    //   ),
                                    // ),
                                  ),
                                  SizedBox(
                                    width: 8,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                       
                                      BlocProvider.of<senMSGCubit>(context)
                                          .senMSGAPI(widget.Room_ID,
                                              Add_Comment.text);
                                    },
                                    child: Container(
                                      child: CircleAvatar(
                                        backgroundColor: Colors.red,
                                        maxRadius: 23,
                                        child: Center(
                                            child: Image.asset(
                                          "assets/images/Vector (13).png",
                                          color: Colors.white,
                                        )),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Divider(
                          color: const Color.fromARGB(117, 0, 0, 0),
                        ),
                        ListView.builder(
                          itemCount: (image?.contains(index) ?? false)
                              ? commentslist.length
                              : commentslist.length,
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
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
                                        Spacer(),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              right: 10),
                                          child: GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                if (image
                                                        ?.contains(index) ??
                                                    false) {
                                                  image?.remove(index);
                                                } else {
                                                  image?.add(index);
                                                }
                                              });
                                            },
                                            child: (image
                                                        ?.contains(index) ??
                                                    false)
                                                ? CustomImageView(
                                                    imagePath:
                                                        ImageConstant.pin,
                                                    height: 17,
                                                  )
                                                : CustomImageView(
                                                    imagePath: ImageConstant
                                                        .selectedpin,
                                                    height: 17,
                                                  ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    index == 2
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
                                                  imagePath: ImageConstant
                                                      .mobileman,
                                                  height: 60,
                                                ),
                                              ],
                                            ),
                                          )
                                        : SizedBox(),
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
                                                        left: 2.0, top: 5),
                                                // child: CircleAvatar(
                                                //     backgroundColor: Colors.black,
                                                //     maxRadius: 3),
                                              ),
                                              SizedBox(
                                                width: 3,
                                              ),
                                              Container(
                                                height: 45,
                                                width: width / 1.3,
                                                // color: Colors.amber,
                                                child: Text(
                                                  commentslist[index],
                                                  maxLines: 3,
                                                  textScaleFactor: 1.0,
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.grey,
                                                      fontFamily: "outfit",
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

                                    // Padding(
                                    // padding: const EdgeInsets.only(left: 8.0),
                                    // child: Text(
                                    //   threadsss[index],
                                    //   style: TextStyle(
                                    //       fontWeight: FontWeight.w400,
                                    //       color: Colors.black,
                                    //       fontFamily: "outfit",
                                    //       fontSize: 12),
                                    // ),
                                    // ),
                                    Divider(
                                      color: const Color.fromARGB(
                                          117, 0, 0, 0),
                                    ),

                                    // Row(
                                    //   mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    //   children: [
                                    //     Padding(
                                    //       padding: const EdgeInsets.only(right: 30.0),
                                    //       child: Text(
                                    //         comment[index],
                                    //         style: TextStyle(
                                    //             fontWeight: FontWeight.w400,
                                    //             color: Colors.black,
                                    //             fontFamily: "outfit",
                                    //             fontSize: 15),
                                    //       ),
                                    //     ),
                                    //     Padding(
                                    //       padding: const EdgeInsets.only(left: 30.0),
                                    //       child: Text(
                                    //         commentss[index],
                                    //         style: TextStyle(
                                    //             fontWeight: FontWeight.w400,
                                    //             color: Colors.grey,
                                    //             fontFamily: "outfit",
                                    //             fontSize: 15),
                                    //       ),
                                    //     ),
                                    //   ],
                                    // ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                    // child: ListView.builder(itemCount: 1,
                    //   itemBuilder: (context, index) {
                    //     return Column(
                    //       children: [
                    //         Text( tomcruse[index],),
                    //       ],
                    //     );
                    //   },
                    // ),
                  ),
                )
              ]),
            ),
          ),
        ));
  }
}
