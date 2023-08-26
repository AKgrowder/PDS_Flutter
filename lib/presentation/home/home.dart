import 'package:pds/API/Bloc/Invitation_Bloc/Invitation_cubit.dart';
import 'package:pds/core/app_export.dart';
import 'package:pds/presentation/become_an_expert_screen/become_an_expert_screen.dart';
import 'package:pds/presentation/experts/experts_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../API/Bloc/Fatch_All_PRoom_Bloc/Fatch_PRoom_cubit.dart';
import '../../API/Bloc/Fatch_All_PRoom_Bloc/Fatch_PRoom_state.dart';
import '../../API/Bloc/FetchExprtise_Bloc/fetchExprtise_cubit.dart';
import '../../API/Bloc/GetAllPrivateRoom_Bloc/GetAllPrivateRoom_cubit.dart';
import '../../API/Bloc/PublicRoom_Bloc/CreatPublicRoom_cubit.dart';
import '../../API/Bloc/auth/register_Block.dart';
import '../../API/Bloc/creatForum_Bloc/creat_Forum_cubit.dart';
import '../../API/Bloc/senMSG_Bloc/senMSG_cubit.dart';
import '../../API/Model/FetchAllExpertsModel/FetchAllExperts_Model.dart';
import '../../API/Model/HomeScreenModel/PublicRoomModel.dart';
import '../../core/utils/color_constant.dart';
import '../../core/utils/sharedPreferences.dart';
import '../../custom_bottom_bar/custom_bottom_bar.dart';
import '../add_threads/add_threads.dart';
import '../create_foram/create_foram_screen.dart';
import '../register_create_account_screen/register_create_account_screen.dart';
import '../view_comments/view_comments_screen.dart';
import 'Invitation_Screen.dart';
import 'PublicRoom.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

int selectedIndex = 0;
int? isselectedimage = -1;
List? image = [];
dynamic _CallBackCheck;
String? User_Name;
String? User_Mood;
String? User_ID;
bool refresh = false;

PublicRoomModel? PublicRoomModelData;
FetchAllExpertsModel? FetchAllExpertsData;
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
var checkuserdata = "";

class _HomeScreenState extends State<HomeScreen> {
  api() {
    BlocProvider.of<FetchAllPublicRoomCubit>(context)
        .FetchAllPublicRoom(context);
    BlocProvider.of<FetchAllPublicRoomCubit>(context)
        .FetchAllExpertsAPI(context);
    BlocProvider.of<FetchAllPublicRoomCubit>(context).chckUserStaus(context);
  }
  @override
  void initState() {
    api();
    saveUserProfile();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
     if (refresh) {
      setState(() {
        refresh = false;
        api();
      });
    }

    var _height = MediaQuery.of(context).size.height;
    var _width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
          backgroundColor: theme.colorScheme.onPrimary,
          body: BlocConsumer<FetchAllPublicRoomCubit, FetchAllPublicRoomState>(
              listener: (context, state) async {
            if (state is FetchAllPublicRoomErrorState) {
              if (state.error != "error in fetch room") {
                SnackBar snackBar = SnackBar(
                  content: Text(state.error),
                  backgroundColor: ColorConstant.primary_color,
                );
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              }
            }

            if (state is CheckuserLoadedState) {
              checkuserdata = state.CheckUserStausModeldata.object ?? "";
              print("&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&__-->" +
                  checkuserdata);
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

            if (state is FetchAllExpertsLoadedState) {
              FetchAllExpertsData = state.FetchAllExpertsData;
              print(FetchAllExpertsData?.message);
            }
          }, builder: (context, state) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.only(left: 16, right: 16),
                    child: Row(
                      children: [
                        CustomImageView(
                          imagePath: ImageConstant.pdslogo,
                          height: 40,
                        ),
                        Spacer(),
                        User_ID != null
                            ? Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    Column(
                                      // mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          User_Name != null
                                              ? "${User_Name}"
                                              : "User ID",
                                          style: TextStyle(
                                            fontFamily: 'outfit',
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Row(
                                          children: [
                                            CircleAvatar(
                                              backgroundColor: Colors.green,
                                              maxRadius: 4,
                                            ),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            Text(
                                              "Active",
                                              style: TextStyle(
                                                  fontFamily: 'outfit',
                                                  fontSize: 10,
                                                  fontWeight: FontWeight.w300,
                                                  color: Colors.grey),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              )
                            : Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: GestureDetector(
                                  onTap: () {
                                    if (User_ID != null) {
                                      print("user login Mood");
                                    } else {
                                      print("User guest Mood on");
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  RegisterCreateAccountScreen()));
                                    }
                                  },
                                  child: Container(
                                    child: Text(
                                      "Login",
                                      style: TextStyle(
                                        fontFamily: 'outfit',
                                        fontSize: 18,
                                        color: Color(0XFFED1C25),
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                        User_ID != null
                            ? CustomImageView(
                                imagePath: ImageConstant.imgRectangle39829,
                                height: 50,
                                radius: BorderRadius.circular(65),
                                alignment: Alignment.center,
                              )
                            : Container()
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 7,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 16, right: 16),
                    child: Container(
                      child: CustomImageView(
                        imagePath: ImageConstant.homeimage,
                        fit: BoxFit.fill,
                        height: 160,
                        width: _width,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 16, top: 10, right: 16, bottom: 0),
                    child: Container(
                      child: User_Mood == "COMPANY"
                          ? SizedBox()
                          : User_Mood == "EXPERT"
                              ? Container(
                                  // color: Colors.lightGreen,
                                  height: 50,
                                  child: GestureDetector(
                                    onTap: () {
                                      if (User_ID != null) {
                                        /*  Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                RoomsScreen(),
                                          )); */
                                        Navigator.push(context,
                                            MaterialPageRoute(
                                                builder: (context) {
                                          return MultiBlocProvider(providers: [
                                            BlocProvider<InvitationCubit>(
                                              create: (context) =>
                                                  InvitationCubit(),
                                            ),
                                          ], child: InvitationScreen());
                                        }));
                                      } else {
                                        print("User guest Mood on");
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    RegisterCreateAccountScreen()));
                                      }
                                    },
                                    child: Container(
                                      height: 50,
                                      decoration: BoxDecoration(
                                          color: Color(0XFFED1C25),
                                          borderRadius:
                                              BorderRadius.circular(5)),
                                      child: Container(
                                        // width: _width / 2.5,
                                        child: Align(
                                          alignment: Alignment.center,
                                          child: Text(
                                            "Invitations",
                                            style: TextStyle(
                                              fontFamily: 'outfit',
                                              fontSize: 13,
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                              : User_Mood == "EMPLOYEE"
                                  ? checkuserdata == "PARTIALLY_REGISTERED"
                                      ? Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Expanded(
                                              flex: 2,
                                              child: GestureDetector(
                                                onTap: () {
                                                  if (User_Name != null) {
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                          builder: (context) =>
                                                              CreateForamScreen(),
                                                        ));
                                                  } else {
                                                    print("User guest Mood on");
                                                    Navigator.of(context).push(
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                RegisterCreateAccountScreen()));
                                                  }
                                                },
                                                child: GestureDetector(
                                                  onTap: () {
                                                    CreateForum();

                                                    // Navigator.push(context,
                                                    //     MaterialPageRoute(
                                                    //         builder: (context) {
                                                    //   return MultiBlocProvider(
                                                    //       providers: [
                                                    //         BlocProvider<CreatFourmCubit>(
                                                    //           create: (context) =>
                                                    //               CreatFourmCubit(),
                                                    //         ),
                                                    //       ],
                                                    //       child: CreateForamScreen());
                                                    // }));
                                                  },
                                                  child: Container(
                                                    height: 50,
                                                    decoration: BoxDecoration(
                                                        color:
                                                            Color(0XFFED1C25),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5)),
                                                    child: Container(
                                                      width: _width / 2.5,
                                                      child: Align(
                                                        alignment:
                                                            Alignment.center,
                                                        child: Text(
                                                          "Create Forum",
                                                          style: TextStyle(
                                                            fontFamily:
                                                                'outfit',
                                                            fontSize: 13,
                                                            color: Colors.white,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Expanded(
                                              flex: 2,
                                              child: GestureDetector(
                                                onTap: () {
                                                  becomeAnExport();

                                                  /* Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  BecomeExpertScreen(),
                                            )); */
                                                },
                                                child: Container(
                                                  height: 50,
                                                  decoration: BoxDecoration(
                                                      color: Color(0XFFFFD9DA),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5),
                                                      border: Border.all(
                                                          color: Color(
                                                              0XFFED1C25))),
                                                  child: Center(
                                                    child: Text(
                                                      "Become an Expert",
                                                      style: TextStyle(
                                                        fontFamily: 'outfit',
                                                        fontSize: 13,
                                                        color:
                                                            Color(0XFFED1C25),
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        )
                                      : checkuserdata == "REJECTED"
                                          ? GestureDetector(
                                              onTap: () {
                                                Navigator.push(context,
                                                    MaterialPageRoute(
                                                        builder: (context) {
                                                  return MultiBlocProvider(
                                                      providers: [
                                                        BlocProvider<
                                                            FetchAllPublicRoomCubit>(
                                                          create: (context) =>
                                                              FetchAllPublicRoomCubit(),
                                                        ),
                                                        BlocProvider<
                                                            CreatPublicRoomCubit>(
                                                          create: (context) =>
                                                              CreatPublicRoomCubit(),
                                                        ),
                                                        BlocProvider<
                                                            senMSGCubit>(
                                                          create: (context) =>
                                                              senMSGCubit(),
                                                        ),
                                                        BlocProvider<
                                                            RegisterCubit>(
                                                          create: (context) =>
                                                              RegisterCubit(),
                                                        ),
                                                        BlocProvider<
                                                            GetAllPrivateRoomCubit>(
                                                          create: (context) =>
                                                              GetAllPrivateRoomCubit(),
                                                        ),
                                                        BlocProvider<
                                                            InvitationCubit>(
                                                          create: (context) =>
                                                              InvitationCubit(),
                                                        ),
                                                      ],
                                                      child: BottombarPage(
                                                          buttomIndex: 4));
                                                }));
                                              },
                                              child: Container(
                                                height: 25,
                                                width: _width,
                                                // color: Colors.red,
                                                child: Center(
                                                  child: Text(
                                                    "Your Account Rejected Update, click here..",
                                                    style: TextStyle(
                                                      fontFamily: 'outfit',
                                                      fontSize: 15,
                                                      color: Color(0XFFED1C25),
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            )
                                          : SizedBox()
                                  : Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Expanded(
                                              flex: 2,
                                              child: GestureDetector(
                                                onTap: () {
                                                  if (User_Name != null) {
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                          builder: (context) =>
                                                              CreateForamScreen(),
                                                        ));
                                                  } else {
                                                    print("User guest Mood on");
                                                    Navigator.of(context).push(
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                RegisterCreateAccountScreen()));
                                                  }
                                                },
                                                child: GestureDetector(
                                                  onTap: () {
                                                    CreateForum();

                                                    // Navigator.push(context,
                                                    //     MaterialPageRoute(
                                                    //         builder: (context) {
                                                    //   return MultiBlocProvider(
                                                    //       providers: [
                                                    //         BlocProvider<CreatFourmCubit>(
                                                    //           create: (context) =>
                                                    //               CreatFourmCubit(),
                                                    //         ),
                                                    //       ],
                                                    //       child: CreateForamScreen());
                                                    // }));
                                                  },
                                                  child: Container(
                                                    height: 50,
                                                    decoration: BoxDecoration(
                                                        color:
                                                            Color(0XFFED1C25),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5)),
                                                    child: Container(
                                                      width: _width / 2.5,
                                                      child: Align(
                                                        alignment:
                                                            Alignment.center,
                                                        child: Text(
                                                          "Create Forum",
                                                          style: TextStyle(
                                                            fontFamily:
                                                                'outfit',
                                                            fontSize: 13,
                                                            color: Colors.white,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Expanded(
                                              flex: 2,
                                              child: GestureDetector(
                                                onTap: () {
                                                  becomeAnExport();

                                                  /* Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  BecomeExpertScreen(),
                                            )); */
                                                },
                                                child: Container(
                                                  height: 50,
                                                  decoration: BoxDecoration(
                                                      color: Color(0XFFFFD9DA),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5),
                                                      border: Border.all(
                                                          color: Color(
                                                              0XFFED1C25))),
                                                  child: Center(
                                                    child: Text(
                                                      "Become an Expert",
                                                      style: TextStyle(
                                                        fontFamily: 'outfit',
                                                        fontSize: 13,
                                                        color:
                                                            Color(0XFFED1C25),
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                    ),
                  ),
                  FetchAllExpertsData?.object?.length != 0
                      ? User_Mood != "EXPERT"
                          ? Padding(
                              padding: const EdgeInsets.only(
                                  right: 20.0, left: 20, top: 7),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Our Experts",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                        fontFamily: "outfit",
                                        fontSize: 23),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                ExpertsScreen(),
                                          )).then((value) => setState(() {
                                            refresh = true;
                                          }));
                                    },
                                    child: Icon(
                                      Icons.arrow_forward,
                                      size: 30,
                                    ),
                                  ),
                                ],
                              ),
                            )
                          : SizedBox()
                      : SizedBox(),
                  User_Mood != "EXPERT"
                      ? Container(
                          // color: Colors.red,
                          height: FetchAllExpertsData?.object?.length != 0
                              ? 200
                              : 0,
                          width: _width / 1.1,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            physics: BouncingScrollPhysics(),
                            itemCount:
                                (FetchAllExpertsData?.object?.length ?? 0) > 5
                                    ? 5
                                    : FetchAllExpertsData?.object?.length,
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  // height: 100,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                      color: Colors.red,
                                    ),
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Stack(
                                        children: [
                                          Container(
                                            height: 120,
                                            width: _width / 2.8,
                                            child: (FetchAllExpertsData?.object?[index].profilePic?.isNotEmpty ?? false) ? CustomImageView(
                                             url: "${FetchAllExpertsData?.object?[index].profilePic}",
                                              // height: 50,
                                              // width: _width/1.2,
                                              radius: BorderRadius.circular(10),
                                            ) : CustomImageView(
                                              imagePath: ImageConstant.experts,
                                              // height: 50,
                                              // width: _width/1.2,
                                              radius: BorderRadius.circular(10),
                                            ),
                                          ),
                                          // Positioned(
                                          //   top: 7,
                                          //   left: 4,
                                          //   child: Container(
                                          //     width: 70,
                                          //     height: 18,
                                          //     decoration: BoxDecoration(
                                          //         borderRadius:
                                          //             BorderRadius.circular(5),
                                          //         color: Colors.white),
                                          //     child: Row(
                                          //       mainAxisAlignment:
                                          //           MainAxisAlignment
                                          //               .spaceAround,
                                          //       children: [
                                          //         CircleAvatar(
                                          //           backgroundColor: Colors.red,
                                          //           maxRadius: 5,
                                          //         ),
                                          //         Text(
                                          //           "Online",
                                          //           style: TextStyle(
                                          //               fontWeight:
                                          //                   FontWeight.w400,
                                          //               color:
                                          //                   Color(0XFFED1C25),
                                          //               fontFamily: "outfit",
                                          //               fontSize: 15),
                                          //         ),
                                          //       ],
                                          //     ),
                                          //   ),
                                          // )
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
                                          // Padding(
                                          //   padding: const EdgeInsets.all(8.0),
                                          //   child: CustomImageView(
                                          //     imagePath: ImageConstant.imgright,
                                          //     height: 15,
                                          //     // fit: BoxFit.fill,
                                          //   ),
                                          // ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          CustomImageView(
                                            imagePath: ImageConstant.bag,
                                            height: 15,
                                            // fit: BoxFit.fill,
                                          ),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          Text(
                                            "${FetchAllExpertsData?.object?[index].expertise?[0].expertiseName}",
                                            style: TextStyle(
                                                fontWeight: FontWeight.w300,
                                                color: Colors.grey.shade700,
                                                fontFamily: "outfit",
                                                fontSize: 15),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        )
                      : SizedBox(),
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 0.0, right: 16, left: 16),
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
                        User_Mood != "EXPERT"
                            ? GestureDetector(
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
                              )
                            : SizedBox(),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  state is FetchAllPublicRoomLoadedState
                      ? ListView.builder(
                          itemCount:
                              (PublicRoomModelData?.object?.length ?? 0) > 5
                                  ? 5
                                  : PublicRoomModelData?.object?.length,
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.only(
                                  left: 16, right: 16, bottom: 10),
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (context) {
                                    return MultiBlocProvider(
                                      providers: [
                                        BlocProvider(
                                          create: (context) => senMSGCubit(),
                                        ),
                                      ],
                                      child: ViewCommentScreen(
                                        Room_ID:
                                            "${PublicRoomModelData?.object?[index].uid ?? ""}",
                                        Title:
                                            "${PublicRoomModelData?.object?[index].roomQuestion ?? ""}",
                                      ),
                                    );
                                  })).then((value) {
                                    setState(() {
                                      refresh = true;
                                    });
                                  });
                                },
                                child: Container(
                                  // height: demo.contains(index) ? null: height / 16,
                                  width: _width,
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: const Color(0XFFD9D9D9),
                                          width: 2),
                                      borderRadius: BorderRadius.circular(5)),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 10),
                                              child: PublicRoomModelData
                                                          ?.object?[index]
                                                          .ownerUserName !=
                                                      null
                                                  ? CustomImageView(
                                                    // imagePath: ImageConstant
                                                    //       .tomcruse,
                                                       url: "${PublicRoomModelData?.object?[index].ownerUsreProfilePic}",
                                                      height: 20,
                                                         radius: BorderRadius
                                                                        .circular(
                                                                            20),
                                                                    width: 20,
                                                                    fit: BoxFit
                                                                        .fill,
                                                    )
                                                  : CustomImageView(
                                                      imagePath: ImageConstant
                                                          .tomcruse,
                                                      height: 20,
                                                    )),
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(left: 5),
                                            child: Text(
                                              "${PublicRoomModelData?.object?[index].ownerUserName}",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w800,
                                                  color: Colors.black,
                                                  fontFamily: "outfit",
                                                  fontSize: 14),
                                            ),
                                          ),
                                          // Spacer(),
                                          // Padding(
                                          //   padding: const EdgeInsets.only(
                                          //       right: 10),
                                          //   child: GestureDetector(
                                          //     onTap: () {
                                          //       // if (image?.contains(index) ??
                                          //       //     false) {
                                          //       //   image?.remove(index);
                                          //       // } else {
                                          //       //   image?.add(index);
                                          //       // }
                                          //     },
                                          //     child: (image?.contains(index) ??
                                          //             false)
                                          //         ? CustomImageView(
                                          //             imagePath: ImageConstant
                                          //                 .selectedimage,
                                          //             height: 17,
                                          //           )
                                          //         : CustomImageView(
                                          //             imagePath: ImageConstant
                                          //                 .unselectedimgVector,
                                          //             height: 17,
                                          //           ),
                                          //   ),
                                          // ),
                                        ],
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
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 2.0, top: 5),
                                                  child: CircleAvatar(
                                                      backgroundColor:
                                                          Colors.black,
                                                      maxRadius: 3),
                                                ),
                                                SizedBox(
                                                  width: 3,
                                                ),
                                                Container(
                                                  width: _width / 1.4,
                                                  child: Text(
                                                    "${PublicRoomModelData?.object?[index].roomQuestion}",
                                                    maxLines: 2,
                                                    textScaleFactor: 1.0,
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        color: Colors.black,
                                                        fontFamily: "outfit",
                                                        fontSize: 14),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 10),
                                              child: (PublicRoomModelData
                                                          ?.object?[index]
                                                          .message
                                                          ?.userProfilePic?.isNotEmpty ?? false)
                                                      
                                                  ? CustomImageView(
                                                      url:
                                                      // "https://pds-testing-images.s3.amazonaws.com/PROFILE_PIC4ee8376e-6667-495a-9a17-47afabf8f732/4ee8376e-6667-495a-9a17-47afabf8f732_409dabd0_60cf_4c69_97d2_ef689d8d8f95.ile_example_JPG_2500kB.jpg",
                                                          "${PublicRoomModelData?.object?[index].message?.userProfilePic}",
                                                      height: 20,
                                                       radius: BorderRadius
                                                                        .circular(
                                                                            20),
                                                                    width: 20,
                                                                    fit: BoxFit
                                                                        .fill,
                                                    )
                                                  : CustomImageView(
                                                      imagePath: ImageConstant
                                                          .tomcruse,
                                                      height: 20,
                                                    )),
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(left: 5),
                                            child: Container(
                                              width: _width / 1.4,
                                              child: Text(
                                                "${PublicRoomModelData?.object?[index].message?.userName}",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w800,
                                                    color: Colors.black,
                                                    fontFamily: "outfit",
                                                    fontSize: 14),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 35, top: 2),
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
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          GestureDetector(
                                            onTap: () {
                                              Navigator.push(context,
                                                  MaterialPageRoute(
                                                      builder: (context) {
                                                return MultiBlocProvider(
                                                  providers: [
                                                    BlocProvider(
                                                        create: (context) =>
                                                            senMSGCubit())
                                                  ],
                                                  child: ViewCommentScreen(
                                                    Room_ID:
                                                        "${PublicRoomModelData?.object?[index].uid ?? ""}",
                                                    Title:
                                                        "${PublicRoomModelData?.object?[index].roomQuestion ?? ""}",
                                                  ),
                                                );
                                              })).then((value) {
                                    setState(() {
                                      refresh = true;
                                    });
                                  });
                                            },
                                            child: Text(
                                              "Add New Comment",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w400,
                                                  color: Colors.black,
                                                  fontFamily: "outfit",
                                                  fontSize: 15),
                                            ),
                                          ),
                                          // Spacer(),
                                          Flexible(
                                            flex: 0,
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 5),
                                              child: Container(
                                                //  height: 50,
                                                alignment:
                                                    Alignment.centerRight,
                                                // width: 150,
                                                // color: Colors.amber,
                                                child: Text(
                                                  "${PublicRoomModelData?.object?[index].message?.messageCount ?? "0"} Comments",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      color: Colors.grey,
                                                      fontFamily: "outfit",
                                                      fontSize: 13),
                                                ),
                                              ),
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
                        )
                      : Container(),
                  SizedBox(
                    height: 10,
                  ),
                  PublicRoomModelData?.object?.length != 0
                      ? GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => PublicRoomList(
                                      PublicRoomModelData: PublicRoomModelData,
                                    )));
                          },
                          child: Container(
                            height: 50,
                            width: _width / 1.2,
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
                        )
                      : SizedBox(),
                  SizedBox(
                    height: 10,
                  ),
                ],
              ),
            );

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
          })),
    );
  }

  Add_Threads() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var UserLogin_ID = prefs.getString(PreferencesKey.loginUserID);

    if (UserLogin_ID != null) {
      print("user login Mood");
      _CallBackCheck = await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => AddThreadsScreen(),
          )).then((value) {
        setState(() {
          refresh = true;
        });
      });
    }else {
      print("User guest Mood on");
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => RegisterCreateAccountScreen()));
    }
  }

  becomeAnExport() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var UserLogin_ID = prefs.getString(PreferencesKey.loginUserID);

    if (UserLogin_ID == null) {
      print("user login Mood");
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => RegisterCreateAccountScreen()));
    } else {
      print('no login');
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return MultiBlocProvider(providers: [
          BlocProvider<FetchExprtiseRoomCubit>(
            create: (context) => FetchExprtiseRoomCubit(),
          ),
        ], child: BecomeExpertScreen());
      }));
    }
  }

  CreateForum() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var UserLogin_ID = prefs.getString(PreferencesKey.loginUserID);

    if (UserLogin_ID == null) {
      print("user login Mood");
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => RegisterCreateAccountScreen()));
    } else {
      print('no login');
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return MultiBlocProvider(providers: [
          BlocProvider<CreatFourmCubit>(
            create: (context) => CreatFourmCubit(),
          ),
        ], child: CreateForamScreen());
      }));
    }
  }

  saveUserProfile() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    // prefs.getString(PreferencesKey.ProfileUserName);
    User_ID = prefs.getString(PreferencesKey.loginUserID);
    User_Name = prefs.getString(PreferencesKey.ProfileName);
    User_Mood = prefs.getString(PreferencesKey.module);

    var Token = prefs.getString(PreferencesKey.loginJwt);
    var FCMToken = prefs.getString(PreferencesKey.fcmToken);

    print("---------------------->> : ${FCMToken}");
    print("User Token :--- " + "${Token}");
    // prefs.getString(PreferencesKey.ProfileEmail);
    // prefs.getString(PreferencesKey.ProfileModule);
    // prefs.getString(PreferencesKey.ProfileMobileNo);
  }
}
