import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:archit_s_application1/core/app_export.dart';
import '../../API/Bloc/Fatch_All_PRoom_Bloc/Fatch_PRoom_cubit.dart';
import '../../API/Bloc/Fatch_All_PRoom_Bloc/Fatch_PRoom_state.dart';
import '../../API/Bloc/senMSG_Bloc/senMSG_cubit.dart';
import '../../API/Model/HomeScreenModel/PublicRoomModel.dart';
import '../../core/utils/color_constant.dart';
import '../../dialogs/create_room_dilog.dart';
import '../add_threads/add_threads.dart';
import '../view_comments/view_comments_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

int selectedIndex = 0;
int? isselectedimage = -1;
List? image = [];
dynamic _CallBackCheck;
PublicRoomModel? PublicRoomModelData;
List<String> aa = [
  "Baluran Wild The Savvanah Baluran Wild The \nSavvanah",
  "Baluran Wild The Savvanah Baluran Wild The \nSavvanah",
  "Baluran Wild The Savvanah Baluran Wild The \nSavvanah",
  "Baluran Wild The Savvanah Baluran Wild The \nSavvanah",
];
List<String> tomcruse = [
  "Tom_cruse",
  "Tom_cruse",
  "Tom_cruse",
  "Tom_cruse",
];
List<String> threadsss = [
  "Lectus scelerisque vulputate tortor pellentesque ac. Fringilla cras ut facilisis amet imperdiet vitae etiam pellentesque pellentesque. Pellentesq...",
  "Lectus scelerisque vulputate tortor pellentesque ac. Fringilla cras ut facilisis amet imperdiet vitae etiam pellentesque pellentesque. Pellentesq...",
  "Lectus scelerisque vulputate tortor pellentesque ac. Fringilla cras ut facilisis amet imperdiet vitae etiam pellentesque pellentesque. Pellentesq...",
  "Lectus scelerisque vulputate tortor pellentesque ac. Fringilla cras ut facilisis amet imperdiet vitae etiam pellentesque pellentesque. Pellentesq...",
];
List<String> comment = [
  "Add New Comment",
  "Add New Comment",
  "Add New Comment",
  "Add New Comment",
];
List<String> commentss = [
  "2078 Comments",
  "2078 Comments",
  "2078 Comments",
  "2078 Comments",
];

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    BlocProvider.of<FetchAllPublicRoomCubit>(context).FetchAllPublicRoom();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
          backgroundColor: theme.colorScheme.onPrimary,
          body: BlocConsumer<FetchAllPublicRoomCubit, FetchAllPublicRoomState>(
              listener: (context, state) async {
            if (state is FetchAllPublicRoomErrorState) {
              SnackBar snackBar = SnackBar(
                content: Text(state.error),
                backgroundColor: ColorConstant.primary_color,
              );
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            }

            if (state is FetchAllPublicRoomLoadingState) {
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

            if (state is FetchAllPublicRoomLoadedState) {
              PublicRoomModelData = state.PublicRoomData;
            }
          }, builder: (context, state) {
            if (_CallBackCheck != null) {
              print(
                  "back_back_back_back_back_back_back_back_back_back_back_back_back_back_");
              setState(() {});
              // records.removeAt(index);
              // records.insert(index, _data);
            }
            if (state is FetchAllPublicRoomLoadedState) {
              return SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(height: 30),
                    Padding(
                      padding: const EdgeInsets.only(left: 35, right: 35),
                      child: Row(
                        children: [
                          CustomImageView(
                            imagePath: ImageConstant.imgRectangle39829,
                            height: getSize(
                              80,
                            ),
                            width: getSize(
                              80,
                            ),
                            radius: BorderRadius.circular(
                              getHorizontalSize(
                                65,
                              ),
                            ),
                            alignment: Alignment.center,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              // mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Good Morning !",
                                  style: TextStyle(
                                      fontFamily: 'outfit',
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey),
                                ),
                                Text(
                                  "User ID",
                                  style: TextStyle(
                                    fontFamily: 'outfit',
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Row(
                                  children: [
                                    CircleAvatar(
                                      backgroundColor: Colors.green,
                                      maxRadius: 5,
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      "Active",
                                      style: TextStyle(
                                          fontFamily: 'outfit',
                                          fontSize: 13,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.grey),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      child: CustomImageView(
                        imagePath: ImageConstant.homeimage,
                        height: 180,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    GestureDetector(
                      onTap: () {
                        // CreateForamScreen

                        //          showDialog(
                        //   context: context,
                        //   builder: (BuildContext context) {
                        //     return CreateRoomScreen();
                        //   },
                        // );
                      },
                      child: Container(
                        height: 50,
                        width: width / 1.2,
                        decoration: BoxDecoration(
                            color: Color(0XFFED1C25),
                            borderRadius: BorderRadius.circular(5)),
                        child: Center(
                          child: Text(
                            "Create Forum",
                            style: TextStyle(
                              fontFamily: 'outfit',
                              fontSize: 15,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      height: 50,
                      width: width / 1.2,
                      decoration: BoxDecoration(
                          color: Color(0XFFFFD9DA),
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(color: Color(0XFFED1C25))),
                      child: Center(
                        child: Text(
                          "Become an Expert",
                          style: TextStyle(
                            fontFamily: 'outfit',
                            fontSize: 15,
                            color: Color(0XFFED1C25),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    // SizedBox(
                    //   height: 20,
                    // ),
                    ListView.builder(
                      itemCount: 1,
                      physics: BouncingScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(30.0),
                          child: Container(
                            // height: demo.contains(index) ? null: height / 16,

                            width: width / 1.2,
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: Color(0XFFD9D9D9), width: 2),
                                borderRadius: BorderRadius.circular(5)),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  " Your Thread",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                      fontFamily: "outfit",
                                      fontSize: 25),
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(
                                          left: 8.0, top: 10, bottom: 10),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 2.0, top: 5),
                                            child: CircleAvatar(
                                                backgroundColor: Colors.black,
                                                maxRadius: 3),
                                          ),
                                          SizedBox(
                                            width: 3,
                                          ),
                                          Text(
                                            "Your Thread",
                                            maxLines: 2,
                                            textScaleFactor: 1.0,
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black,
                                                fontFamily: "outfit",
                                                fontSize: 14),
                                          ),
                                          // CustomImageView(
                                          //   imagePath:
                                          //       ImageConstant.unselectedimgVector,
                                          //   height: 20,
                                          // ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left: 10),
                                      child: CustomImageView(
                                        imagePath: ImageConstant.tomcruse,
                                        height: 20,
                                      ),
                                    ),
                                    Text(
                                      "Your Thread",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          color: Colors.black,
                                          fontFamily: "outfit",
                                          fontSize: 14),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: Text(
                                    "Your Thread",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        color: Colors.grey,
                                        fontFamily: "outfit",
                                        fontSize: 12),
                                  ),
                                ),
                                Divider(
                                  color: Colors.black,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    // Padding(
                                    //   padding: const EdgeInsets.only(right: 30.0,),
                                    //   child: Text(
                                    //     comment[index],
                                    //     style: TextStyle(
                                    //         fontWeight: FontWeight.w400,
                                    //         color: Colors.black,
                                    //         fontFamily: "outfit",
                                    //         fontSize: 15),
                                    //   ),
                                    // ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(right: 10.0),
                                      child: Text(
                                        "2078 Comments",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w400,
                                            color: Colors.grey,
                                            fontFamily: "outfit",
                                            fontSize: 15),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 0.0, right: 35, left: 35),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Public Threads",
                            style: TextStyle(
                              fontFamily: 'outfit',
                              fontSize: 23,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Add_Threads();
                            },
                            child: Text(
                              "+ Add Threads",
                              style: TextStyle(
                                fontFamily: 'outfit',
                                fontSize: 15,
                                color: Color(0XFFED1C25),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    /*   Container(
                      height: height / 5,
                      width: width / 1.1,
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey.shade400),
                          borderRadius: BorderRadius.circular(6)),
                      child: Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: 5,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 4),
                                  child: CircleAvatar(
                                      backgroundColor: Colors.black, maxRadius: 3),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  " Baluran Wild The Savvanah Baluran Wild The\n Savvanah",
                                  style: TextStyle(fontFamily: 'outfit'),
                                ),
                                SizedBox(
                                  width: 35,
                                ),
                                CustomImageView(
                                  imagePath: ImageConstant.unselectedimgVector,
                                  height: 20,
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  CustomImageView(
                                    imagePath: ImageConstant.tomcruse,
                                    height: 20,
                                  ),
                                  Text(
                                    " Tom_cruse",
                                    style: TextStyle(fontFamily: 'outfit'),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 5),
                              child: Text(
                                "Lectus scelerisque vulputate tortor pellentesque ac. Fringilla cras ut facilisis amet imperdiet vitae etiam pellentesque pellentesque. Pellentesq...",
                                style: TextStyle(
                                    fontFamily: 'outfit',
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey  ),
                              ),
                            ),
                            Divider(
                              color: Colors.black,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 15, right: 15),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Add New Comment",
                                    style: TextStyle(fontFamily: 'outfit'),
                                  ),
                                  Text(
                                    "2078 Comments",
                                    style: TextStyle(fontFamily: 'outfit'),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 10,),
                    Container(
                      height: height / 5,
                      width: width / 1.1,
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey.shade400),
                          borderRadius: BorderRadius.circular(6)),
                      child: Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: 5,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 4),
                                  child: CircleAvatar(
                                      backgroundColor: Colors.black, maxRadius: 3),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  " Baluran Wild The Savvanah Baluran Wild The\n Savvanah",
                                  style: TextStyle(fontFamily: 'outfit'),
                                ),
                                SizedBox(
                                  width: 35,
                                ),
                                CustomImageView(
                                  imagePath: ImageConstant.unselectedimgVector,
                                  height: 20,
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  CustomImageView(
                                    imagePath: ImageConstant.tomcruse,
                                    height: 20,
                                  ),
                                  Text(
                                    " Tom_cruse",
                                    style: TextStyle(fontFamily: 'outfit'),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 5),
                              child: Text(
                                "Lectus scelerisque vulputate tortor pellentesque ac. Fringilla cras ut facilisis amet imperdiet vitae etiam pellentesque pellentesque. Pellentesq...",
                                style: TextStyle(
                                    fontFamily: 'outfit',
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey  ),
                              ),
                            ),
                            Divider(
                              color: Colors.black,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 15, right: 15),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Add New Comment",
                                    style: TextStyle(fontFamily: 'outfit'),
                                  ),
                                  Text(
                                    "2078 Comments",
                                    style: TextStyle(fontFamily: 'outfit'),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ), */
                    ListView.builder(
                      itemCount: PublicRoomModelData?.object?.length,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 35, vertical: 5),
                          child: GestureDetector(
                            onTap: () {},
                            child: Container(
                              // height: demo.contains(index) ? null: height / 16,
                              width: width / 1.2,
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: const Color(0XFFD9D9D9), width: 2),
                                  borderRadius: BorderRadius.circular(5)),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(
                                            left: 8.0, top: 10, bottom: 10),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 2.0, top: 5),
                                              child: CircleAvatar(
                                                  backgroundColor: Colors.black,
                                                  maxRadius: 3),
                                            ),
                                            SizedBox(
                                              width: 3,
                                            ),
                                            Text(
                                              "${PublicRoomModelData?.object?[index].roomQuestion}",
                                              maxLines: 2,
                                              textScaleFactor: 1.0,
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black,
                                                  fontFamily: "outfit",
                                                  fontSize: 14),
                                            ),

                                            /* GestureDetector(
                                              onTap: () {
                                                setState(() {
                                                  if (image?.contains(index) ??
                                                      false) {
                                                    image?.remove(index);
                                                  } else {
                                                    image?.add(index);
                                                  }
                                                });
                                              },
                                              child: (image?.contains(index) ??
                                                      false)
                                                  ? CustomImageView(
                                                      imagePath: ImageConstant
                                                          .unselectedimgVector,
                                                      height: 20,
                                                    )
                                                  : CustomImageView(
                                                      imagePath: ImageConstant
                                                          .selectedimage,
                                                      height: 20,
                                                    ),
                                            ), */
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Padding(
                                          padding:
                                              const EdgeInsets.only(left: 10),
                                          child: CustomImageView(
                                            imagePath: ImageConstant.tomcruse,
                                            height: 20,
                                          )),
                                      Padding(
                                        padding: const EdgeInsets.only(left: 5),
                                        child: Text(
                                          "${PublicRoomModelData?.object?[index].uid}",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w800,
                                              color: Colors.black,
                                              fontFamily: "outfit",
                                              fontSize: 14),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsets.only(left: 35, top: 2),
                                    child: Text(
                                      "${PublicRoomModelData?.object?[index].message?.message ?? ""}",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          color: Colors.black,
                                          fontFamily: "outfit",
                                          fontSize: 12),
                                    ),
                                  ),
                                  Divider(
                                    color: Colors.black,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          //
                                          // Navigator.push(
                                          //     context,
                                          //     MaterialPageRoute(
                                          //       builder: (context) =>
                                          //           ViewCommentScreen(Room_ID:   "${PublicRoomModelData?.object?[index].uid ?? ""}",),
                                          //     ));
                                          Navigator.push(context,
                                              MaterialPageRoute(
                                                  builder: (context) {
                                            return MultiBlocProvider(
                                              providers: [
                                                BlocProvider(
                                                  create: (context) =>
                                                      senMSGCubit(),
                                                ),
                                              ],
                                              child: ViewCommentScreen(
                                                Room_ID:
                                                    "${PublicRoomModelData?.object?[index].uid ?? ""}",
                                              ),
                                            );
                                          }));
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              right: 30.0),
                                          child: Text(
                                            "Add New Comment",
                                            style: TextStyle(
                                                fontWeight: FontWeight.w400,
                                                color: Colors.black,
                                                fontFamily: "outfit",
                                                fontSize: 15),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 30.0),
                                        child: Text(
                                          "${PublicRoomModelData?.object?[index].message?.messageCount ?? "0"} Comments",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w400,
                                              color: Colors.grey,
                                              fontFamily: "outfit",
                                              fontSize: 15),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      height: 50,
                      width: width / 1.2,
                      decoration: BoxDecoration(
                          color: Color(0XFFED1C25),
                          borderRadius: BorderRadius.circular(6)),
                      child: Center(
                          child: Text(
                        "View More",
                        style: TextStyle(
                            fontWeight: FontWeight.w400,
                            color: Colors.white,
                            fontFamily: "outfit",
                            fontSize: 16),
                      )),
                    ),
                    // SizedBox(height: 10,),
                    Padding(
                      padding:
                          const EdgeInsets.only(right: 30.0, left: 30, top: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Our Extperts",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                                fontFamily: "outfit",
                                fontSize: 25),
                          ),
                          Icon(
                            Icons.arrow_forward,
                            size: 30,
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: 240,
                      width: width / 1.2,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        physics: BouncingScrollPhysics(),
                        itemCount: 8,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              height: 100,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  color: Colors.red,
                                ),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Stack(
                                    children: [
                                      Container(
                                        height: 150,
                                        child: CustomImageView(
                                          imagePath: ImageConstant.experts,
                                          height: 50,
                                          width: width / 2.8,
                                          radius: BorderRadius.circular(10),
                                        ),
                                      ),
                                      Positioned(
                                        top: 7,
                                        left: 4,
                                        child: Container(
                                          width: 70,
                                          height: 18,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                              color: Colors.white),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              CircleAvatar(
                                                backgroundColor: Colors.red,
                                                maxRadius: 5,
                                              ),
                                              Text(
                                                "Online",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w400,
                                                    color: Color(0XFFED1C25),
                                                    fontFamily: "outfit",
                                                    fontSize: 15),
                                              ),
                                            ],
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "Expert 1",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black,
                                            fontFamily: "outfit",
                                            fontSize: 20),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: CustomImageView(
                                          imagePath: ImageConstant.imgright,
                                          height: 15,
                                          // fit: BoxFit.fill,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      CustomImageView(
                                        imagePath: ImageConstant.bag,
                                        height: 15,
                                        // fit: BoxFit.fill,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          "Expertise in....",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w300,
                                              color: Colors.grey.shade700,
                                              fontFamily: "outfit",
                                              fontSize: 15),
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    /*    // BottombarPage(buttomIndex: 0),
                    //----------------------------------------------------------------------------------------------
                    // BottomAppBar(
                    //   // color: Colors.amber,

                    //   height: 75,
                    //   shape: const CircularNotchedRectangle(),
                    //   child: Padding(
                    //     padding: EdgeInsets.only(top: 17, bottom: 0),
                    //     child: Row(
                    //       mainAxisAlignment: MainAxisAlignment.spaceAround,
                    //       children: [
                    //         GestureDetector(
                    //           onTap: () {
                    //             setState(() {
                    //               selectedIndex = 0;
                    //             });
                    //           },
                    //           child: Container(
                    //             // color: Colors.green,

                    //             height: 65,
                    //             width: 40,
                    //             child: Column(
                    //               children: [
                    //                 Container(
                    //                   child: selectedIndex != 0
                    //                       ? Image.asset(
                    //                           "${ImageConstant.bottomhome}",
                    //                           height: 30,
                    //                           width: 30,
                    //                         )
                    //                       : Container(
                    //                           height: 30,
                    //                           width: 30,
                    //                           child: Column(
                    //                             children: [
                    //                               Image.asset(
                    //                                 "${ImageConstant.bottomhome}",
                    //                               ),
                    //                             ],
                    //                           ),
                    //                           decoration: BoxDecoration(
                    //                             borderRadius: BorderRadius.only(
                    //                                 topLeft: Radius.circular(20),
                    //                                 topRight: Radius.circular(20),
                    //                                 bottomLeft: Radius.circular(20),
                    //                                 bottomRight: Radius.circular(20)),
                    //                             boxShadow: [
                    //                               BoxShadow(
                    //                                 color: Color.fromARGB(
                    //                                     45, 255, 89, 0),
                    //                                 spreadRadius: 5,
                    //                                 blurRadius: 7,
                    //                                 offset: Offset(0, 3),
                    //                               ),
                    //                             ],
                    //                           ),
                    //                         ),
                    //                 ),
                    //               ],
                    //             ),
                    //           ),
                    //         ),
                    //         GestureDetector(
                    //           onTap: () {
                    //             Navigator.push(
                    //                 context,
                    //                 MaterialPageRoute(
                    //                     builder: (context) => HomeScreen()));
                    //           },
                    //           child: Container(
                    //             height: 65,
                    //             width: 50,
                    //             // color: Colors.green,
                    //             child: Column(
                    //               children: [
                    //                 Padding(
                    //                   padding: const EdgeInsets.only(top:6.0,),
                    //                   child: Container(
                    //                     child: selectedIndex != 1
                    //                         ? Image.asset(
                    //                             "${ImageConstant.bottomgroup}",
                    //                             height: 30,
                    //                             width: 20,
                    //                           )
                    //                         : Container(
                    //                             height:30,
                    //                             width: 20,
                    //                             child: Column(
                    //                               children: [
                    //                                 Image.asset(
                    //                                   "${ImageConstant.bottomgroup}",
                    //                                 ),
                    //                               ],
                    //                             ),
                    //                             decoration: BoxDecoration(
                    //                               borderRadius: BorderRadius.only(
                    //                                   topLeft: Radius.circular(20),
                    //                                   topRight: Radius.circular(20),
                    //                                   bottomLeft: Radius.circular(20),
                    //                                   bottomRight: Radius.circular(20)),
                    //                               boxShadow: [
                    //                                 BoxShadow(
                    //                                   color: Color.fromARGB(
                    //                                       45, 255, 89, 0),
                    //                                   spreadRadius: 5,
                    //                                   blurRadius: 7,
                    //                                   offset: Offset(0, 3),
                    //                                 ),
                    //                               ],
                    //                             ),
                    //                           ),
                    //                   ),
                    //                 ),
                    //                 // Spacer(),
                    //                 // Container(
                    //                 //   child: selectedIndex != 1
                    //                 //       ? Container()
                    //                 //       : Container(
                    //                 //           height: 5,
                    //                 //           width: 30,
                    //                 //           child: Image.asset(
                    //                 //             "${ImageConstant.bag}",
                    //                 //             fit: BoxFit.cover,
                    //                 //           ),
                    //                 //         ),
                    //                 // ),
                    //               ],
                    //             ),
                    //           ),
                    //         ),
                    //         GestureDetector(
                    //           onTap: () {
                    //             Navigator.push(
                    //                 context,
                    //                 MaterialPageRoute(
                    //                     builder: (context) => HomeScreen()));
                    //           },
                    //           child: Container(
                    //             height: 65,
                    //             width: 40,
                    //             color: Colors.white,
                    //             child: Column(
                    //               children: [
                    //                 Padding(
                    //                   padding: const EdgeInsets.only(top: 5),
                    //                   child: Container(
                    //                     child: selectedIndex != 2
                    //                         ? Image.asset(
                    //                             "${ImageConstant.bottomtimer}",
                    //                             height: 24,
                    //                             width: 24,
                    //                           )
                    //                         : Container(
                    //                             height: 30,
                    //                             width: 30,
                    //                             child: Column(
                    //                               children: [
                    //                                 Image.asset(
                    //                                   "${ImageConstant.bottomtimer}",
                    //                                   height: 24,
                    //                                   width: 24,
                    //                                 ),
                    //                               ],
                    //                             ),
                    //                             decoration: BoxDecoration(
                    //                               // color: Colors.white,
                    //                               borderRadius: BorderRadius.only(
                    //                                   topLeft: Radius.circular(20),
                    //                                   topRight: Radius.circular(20),
                    //                                   bottomLeft: Radius.circular(20),
                    //                                   bottomRight:
                    //                                       Radius.circular(20)),
                    //                               boxShadow: [
                    //                                 BoxShadow(
                    //                                   color: Color.fromARGB(
                    //                                       45, 255, 89, 0),
                    //                                   spreadRadius: 5,
                    //                                   blurRadius: 7,
                    //                                   offset: Offset(0, 3),
                    //                                 )
                    //                               ],
                    //                             ),
                    //                           ),
                    //                   ),
                    //                 ),
                    //                 Spacer(),
                    //                 // Container(
                    //                 //   child: selectedIndex != 2
                    //                 //       ? Container()
                    //                 //       : Container(
                    //                 //           height: 5,
                    //                 //           width: 30,
                    //                 //           child: Image.asset(
                    //                 //             "${ImageConstant.bag}",
                    //                 //             fit: BoxFit.cover,
                    //                 //           ),
                    //                 //         ),
                    //                 // ),
                    //               ],
                    //             ),
                    //           ),
                    //         ),
                    //         GestureDetector(
                    //           onTap: () {
                    //             Navigator.push(
                    //                 context,
                    //                 MaterialPageRoute(
                    //                     builder: (context) => HomeScreen()));
                    //           },
                    //           child: Container(
                    //             height: 65,
                    //             width: 40,
                    //             color: Colors.white,
                    //             child: Column(
                    //               children: [
                    //                 Padding(
                    //                   padding: const EdgeInsets.only(top: 5),
                    //                   child: Container(
                    //                     child: selectedIndex != 3
                    //                         ? Image.asset(
                    //                             "${ImageConstant.bottombell}",
                    //                             height: 26,
                    //                             width: 26,
                    //                           )
                    //                         : Container(
                    //                             height: 30,
                    //                             width: 30,
                    //                             child: Column(
                    //                               children: [
                    //                                 Image.asset(
                    //                                   "${ImageConstant.bottombell}",
                    //                                   height: 26,
                    //                                   width: 26,
                    //                                 ),
                    //                               ],
                    //                             ),
                    //                             decoration: BoxDecoration(
                    //                               borderRadius: BorderRadius.only(
                    //                                   topLeft: Radius.circular(20),
                    //                                   topRight: Radius.circular(20),
                    //                                   bottomLeft: Radius.circular(20),
                    //                                   bottomRight:
                    //                                       Radius.circular(20)),
                    //                               boxShadow: [
                    //                                 BoxShadow(
                    //                                   color: Color.fromARGB(
                    //                                       45, 255, 89, 0),
                    //                                   spreadRadius: 5,
                    //                                   blurRadius: 7,
                    //                                   offset: Offset(0, 3),
                    //                                 ),
                    //                               ],
                    //                             ),
                    //                           ),
                    //                   ),
                    //                 ),
                    //                 // Spacer(),
                    //                 // Container(
                    //                 //   // height: 35,
                    //                 //   child: selectedIndex != 3
                    //                 //       ? Container()
                    //                 //       : Container(
                    //                 //           // color: Colors.indigo,
                    //                 //           height: 5,
                    //                 //           width: 30,
                    //                 //           child: Image.asset(
                    //                 //             "${ImageConstant.bag}",
                    //                 //             fit: BoxFit.cover,
                    //                 //             // fit: BoxFit.scaleDown,
                    //                 //             // height: 60,
                    //                 //             // width: 60,
                    //                 //           ),
                    //                 //         ),
                    //                 // ),
                    //               ],
                    //             ),
                    //           ),
                    //         ),
                    //         // / ------------------------------------------------------------------
                    //         GestureDetector(
                    //           onTap: () {
                    //             Navigator.push(
                    //                 context,
                    //                 MaterialPageRoute(
                    //                     builder: (context) => HomeScreen()));
                    //           },
                    //           child: Container(
                    //             height: 65,
                    //             width: 40,
                    //             color: Colors.white,
                    //             child: Column(
                    //               children: [
                    //                 Padding(
                    //                   padding: const EdgeInsets.only(top: 5),
                    //                   child: Container(
                    //                     // height: 35,
                    //                     child: selectedIndex != 4
                    //                         ? Image.asset(
                    //                             "${ImageConstant.bottomprofile}",
                    //                             height: 26,
                    //                             width: 26,
                    //                           )
                    //                         : Container(
                    //                             // color: Colors.indigo,
                    //                             height: 30,
                    //                             width: 30,
                    //                             child: Column(
                    //                               children: [
                    //                                 Image.asset(
                    //                                   "${ImageConstant.bottomprofile}",
                    //                                   // fit: BoxFit.cover,
                    //                                   // fit: BoxFit.scaleDown,
                    //                                   height: 26,
                    //                                   width: 26,
                    //                                 ),
                    //                               ],
                    //                             ),
                    //                             decoration: BoxDecoration(
                    //                               color: Colors.white,
                    //                               borderRadius: BorderRadius.only(
                    //                                   topLeft: Radius.circular(20),
                    //                                   topRight: Radius.circular(20),
                    //                                   bottomLeft: Radius.circular(20),
                    //                                   bottomRight:
                    //                                       Radius.circular(20)),
                    //                               boxShadow: [
                    //                                 BoxShadow(
                    //                                   color: Color.fromARGB(
                    //                                       45, 255, 89, 0),
                    //                                   //  Colors.grey.withOpacity(0.5),
                    //                                   spreadRadius: 5,
                    //                                   blurRadius: 7,
                    //                                   offset: Offset(0,
                    //                                       3), // changes position of shadow
                    //                                 ),
                    //                               ],
                    //                             ),
                    //                           ),
                    //                   ),
                    //                 ),
                    //               ],
                    //             ),
                    //           ),
                    //         ),
                    //       ],
                    //     ),
                    //   ),
                    // ),
                */
                  ],
                ),
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
          })),
    );
  }

  Add_Threads() async {
    _CallBackCheck = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => AddThreadsScreen(),
        ));
  }
}
