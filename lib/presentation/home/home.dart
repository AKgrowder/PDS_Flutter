import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pds/API/Bloc/Invitation_Bloc/Invitation_cubit.dart';
import 'package:pds/core/app_export.dart';
import 'package:pds/presentation/become_an_expert_screen/become_an_expert_screen.dart';
import 'package:pds/presentation/experts/experts_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../API/Bloc/sherinvite_Block/sherinvite_cubit.dart';
import '../../API/Bloc/Fatch_All_PRoom_Bloc/Fatch_PRoom_cubit.dart';
import '../../API/Bloc/Fatch_All_PRoom_Bloc/Fatch_PRoom_state.dart';
import '../../API/Bloc/FetchExprtise_Bloc/fetchExprtise_cubit.dart';
import '../../API/Bloc/GetAllPrivateRoom_Bloc/GetAllPrivateRoom_cubit.dart';
import '../../API/Bloc/PublicRoom_Bloc/CreatPublicRoom_cubit.dart';
import '../../API/Bloc/auth/register_Block.dart';
import '../../API/Bloc/creatForum_Bloc/creat_Forum_cubit.dart';
import '../../API/Bloc/senMSG_Bloc/senMSG_cubit.dart';
import '../../API/Model/FetchAllExpertsModel/FetchAllExperts_Model.dart';
import '../../API/Model/Get_all_blog_Model/get_all_blog_model.dart';
import '../../API/Model/HomeScreenModel/MyPublicRoom_model.dart';
import '../../API/Model/HomeScreenModel/PublicRoomModel.dart';
import '../../API/Model/HomeScreenModel/getLoginPublicRoom_model.dart';
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
String? User_Module = "";
String? UserProfile;
String? User_ID;
bool refresh = false;

PublicRoomModel? PublicRoomModelData;
LoginPublicRoomModel? FetchPublicRoomModelData;
MyPublicRoom? MyPublicRoomData;
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
GetallBlogModel? getallBlogdata;

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    saveUserProfile();
    BlocProvider.of<FetchAllPublicRoomCubit>(context)
        .FetchAllExpertsAPI(context);

    BlocProvider.of<FetchAllPublicRoomCubit>(context).GetallBlog(context);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (refresh) {
      setState(() {
        refresh = false;
        // saveUserProfile();
        // User_ID == null ? api() : NewApi();
        saveUserProfile();
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
              print(
                  'check datat user data Get--> ${state.CheckUserStausModeldata.object}');
              var final_status =
                  state.CheckUserStausModeldata.object?.split('-').first;
              print(final_status);
              if (final_status == 'REJECTED') {
                setUserStatusFunction(
                    rejectionReason: state.CheckUserStausModeldata.object);
              } else {
                setUserStatusFunction(
                    acticueUser: state.CheckUserStausModeldata.object);
              }
              checkuserdata = final_status ?? "";
              print("&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&__-->" +
                  checkuserdata);
            }

            if (state is GetallblogLoadedState) {
              getallBlogdata = state.getallBlogdata;
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
              setState(() {
                PublicRoomModelData = state.PublicRoomData;
                print(PublicRoomModelData?.object?.length);
              });
            }

            if (state is FetchAllExpertsLoadedState) {
              FetchAllExpertsData = state.FetchAllExpertsData;
              print(FetchAllExpertsData?.message);
            }
            if (state is FetchPublicRoomLoadedState) {
              FetchPublicRoomModelData = state.FetchPublicRoomData;
              print(
                  "++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++");
              print(FetchPublicRoomModelData?.object?.length);
            }

            if (state is MyPublicRoom1LoadedState) {
              MyPublicRoomData = state.MyPublicRoomData;
              print(MyPublicRoomData?.message);
              print(MyPublicRoomData?.object?.length);
            }

            if (state is fetchUserModulemodelLoadedState) {
              print("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@" +
                  "${state.fetchUserModule.object}");
              var user_Module = state.fetchUserModule.object?.userModule ?? "";
              final SharedPreferences prefs =
                  await SharedPreferences.getInstance();

              prefs.setString(PreferencesKey.module, user_Module);
              setState(() {
                //  saveUserProfile();
                 User_Module = user_Module;
              });
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
                            ? GestureDetector(
                                onTap: () {
                                  OpenProfileSave();
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (context) {
                                    return MultiBlocProvider(providers: [
                                      BlocProvider<FetchAllPublicRoomCubit>(
                                        create: (context) =>
                                            FetchAllPublicRoomCubit(),
                                      ),
                                      BlocProvider<CreatPublicRoomCubit>(
                                        create: (context) =>
                                            CreatPublicRoomCubit(),
                                      ),
                                      BlocProvider<senMSGCubit>(
                                        create: (context) => senMSGCubit(),
                                      ),
                                      BlocProvider<RegisterCubit>(
                                        create: (context) => RegisterCubit(),
                                      ),
                                      BlocProvider<GetAllPrivateRoomCubit>(
                                        create: (context) =>
                                            GetAllPrivateRoomCubit(),
                                      ),
                                      BlocProvider<InvitationCubit>(
                                        create: (context) => InvitationCubit(),
                                      ),
                                    ], child: BottombarPage(buttomIndex: 4));
                                  }));
                                },
                                child: CustomImageView(
                                  // imagePath: ImageConstant.imgRectangle39829,
                                  url: UserProfile,
                                  height: 50,
                                  width: 50,
                                  fit: BoxFit.fill,
                                  radius: BorderRadius.circular(25),
                                  alignment: Alignment.center,
                                ),
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
                      child: User_Module == "COMPANY"
                          ? SizedBox()
                          : User_Module == "EXPERT"
                              ? Container(
                                  // color: Colors.lightGreen,
                                  height:  checkuserdata == "REJECTED" ? 80:50,
                                  child: Column(
                                    children: [
                                       checkuserdata == "REJECTED"
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
                                          : SizedBox(),
                                      Spacer(),
                                      GestureDetector(
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
                                    ],
                                  ),  
                                )
                              : User_Module == "EMPLOYEE"
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
                                                    color: Color(0XFFED1C25),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5)),
                                                child: Container(
                                                  width: _width / 2.5,
                                                  child: Align(
                                                    alignment: Alignment.center,
                                                    child: Text(
                                                      "Create Forum",
                                                      style: TextStyle(
                                                        fontFamily: 'outfit',
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
                                                      BorderRadius.circular(5),
                                                  border: Border.all(
                                                      color:
                                                          Color(0XFFED1C25))),
                                              child: Center(
                                                child: Text(
                                                  "Become an Expert",
                                                  style: TextStyle(
                                                    fontFamily: 'outfit',
                                                    fontSize: 13,
                                                    color: Color(0XFFED1C25),
                                                    fontWeight: FontWeight.bold,
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
                      ? User_Module != "EXPERT"
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
                                                MultiBlocProvider(
                                                    providers: [
                                                  BlocProvider<SherInviteCubit>(
                                                    create: (_) =>
                                                        SherInviteCubit(),
                                                  ),
                                                ],
                                                    child: ExpertsScreen(
                                                        RoomUUID: "")),
                                            // ExpertsScreen(RoomUUID:  PriveateRoomData?.object?[index].uid),
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
                  User_Module != "EXPERT"
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
                                              child: (FetchAllExpertsData
                                                          ?.object?[index]
                                                          .profilePic
                                                          ?.isNotEmpty ??
                                                      false)
                                                  ? CustomImageView(
                                                      url:
                                                          "${FetchAllExpertsData?.object?[index].profilePic}",
                                                      // height: 50,
                                                      // width: _width/1.2,
                                                      fit: BoxFit.fill,
                                                      radius:
                                                          BorderRadius.circular(
                                                              10),
                                                    )
                                                  : CustomImageView(
                                                      imagePath:
                                                          ImageConstant.experts,
                                                      // height: 50,
                                                      // width: _width/1.2,
                                                      fit: BoxFit.fill,
                                                      radius:
                                                          BorderRadius.circular(
                                                              10),
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
                                    )),
                              );
                            },
                          ),
                        )
                      : SizedBox(),
                  User_ID != null
                      ? MyPublicRoomData?.object?.length == 0
                          ? SizedBox()
                          : User_Module == "COMPANY" ||
                                  User_Module == "EMPLOYEE"
                              ? state is MyPublicRoom1LoadedState
                                  ? Padding(
                                      padding: const EdgeInsets.only(
                                          top: 0.0, right: 16, left: 16),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "Your Forum",
                                            style: TextStyle(
                                              fontFamily: 'outfit',
                                              fontSize: 23,
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  : SizedBox()
                              : SizedBox()
                      : SizedBox(),
                  User_ID != null
                      ? MyPublicRoomData?.object?.length != 0 ||
                              MyPublicRoomData?.object?.isNotEmpty == false
                          ? User_Module == "COMPANY" ||
                                  User_Module == "EMPLOYEE"
                              ? state is MyPublicRoom1LoadedState
                                  ? ListView.builder(
                                      itemCount: (MyPublicRoomData
                                                      ?.object?.length ??
                                                  0) >
                                              5
                                          ? 5
                                          : MyPublicRoomData?.object?.length,
                                      shrinkWrap: true,
                                      physics: NeverScrollableScrollPhysics(),
                                      itemBuilder: (context, index) {
                                        return Padding(
                                          padding: const EdgeInsets.only(
                                              left: 16, right: 16, bottom: 10),
                                          child: GestureDetector(
                                            onTap: () {
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
                                                        "${MyPublicRoomData?.object?[index].uid ?? ""}",
                                                    Title:
                                                        "${MyPublicRoomData?.object?[index].roomQuestion ?? ""}",
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
                                                      color: const Color(
                                                          0XFFD9D9D9),
                                                      width: 2),
                                                  borderRadius:
                                                      BorderRadius.circular(5)),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  SizedBox(
                                                    height: 10,
                                                  ),
                                                  Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      // Padding(
                                                      //     padding:
                                                      //         const EdgeInsets
                                                      //                 .only(
                                                      //             left: 10),
                                                      //     child: MyPublicRoomData
                                                      //                 ?.object?[
                                                      //                     index]
                                                      //                 .ownerUsreProfilePic
                                                      //                 ?.isNotEmpty ==
                                                      //             false
                                                      //         ? CustomImageView(
                                                      //             // imagePath: ImageConstant
                                                      //             //       .tomcruse,
                                                      //             url:
                                                      //                 "${MyPublicRoomData?.object?[index].ownerUsreProfilePic}",
                                                      //             height: 20,
                                                      //             radius: BorderRadius
                                                      //                 .circular(
                                                      //                     20),
                                                      //             width: 20,
                                                      //             fit: BoxFit
                                                      //                 .fill,
                                                      //           )
                                                      //         : CustomImageView(
                                                      //             imagePath:
                                                      //                 ImageConstant
                                                      //                     .tomcruse,
                                                      //             height: 20,
                                                      //           )),
                                                      // Padding(
                                                      //   padding:
                                                      //       const EdgeInsets
                                                      //           .only(left: 5),
                                                      //   child: Text(
                                                      //     "${MyPublicRoomData?.object?[index].ownerUserName}",
                                                      //     style: TextStyle(
                                                      //         fontWeight:
                                                      //             FontWeight
                                                      //                 .w800,
                                                      //         color:
                                                      //             Colors.black,
                                                      //         fontFamily:
                                                      //             "outfit",
                                                      //         fontSize: 14),
                                                      //   ),
                                                      // ),
                                                    ],
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                                left: 8.0,
                                                                top: 10,
                                                                bottom: 10),
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      left: 2.0,
                                                                      top: 5),
                                                              child: CircleAvatar(
                                                                  backgroundColor:
                                                                      Colors
                                                                          .black,
                                                                  maxRadius: 3),
                                                            ),
                                                            SizedBox(
                                                              width: 3,
                                                            ),
                                                            Container(
                                                              width:
                                                                  _width / 1.4,
                                                              child: Text(
                                                                "${MyPublicRoomData?.object?[index].roomQuestion}",
                                                                maxLines: 2,
                                                                textScaleFactor:
                                                                    1.0,
                                                                style: TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    overflow: TextOverflow
                                                                        .ellipsis,
                                                                    color: Colors
                                                                        .black,
                                                                    fontFamily:
                                                                        "outfit",
                                                                    fontSize:
                                                                        14),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  MyPublicRoomData
                                                              ?.object?[index]
                                                              .message
                                                              ?.message !=
                                                          null
                                                      ? Row(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .only(
                                                                        left:
                                                                            10),
                                                                child: MyPublicRoomData
                                                                            ?.object?[index]
                                                                            .message
                                                                            ?.userProfilePic !=
                                                                        null
                                                                    ? CustomImageView(
                                                                        url:
                                                                            // "https://pds-testing-images.s3.amazonaws.com/PROFILE_PIC4ee8376e-6667-495a-9a17-47afabf8f732/4ee8376e-6667-495a-9a17-47afabf8f732_409dabd0_60cf_4c69_97d2_ef689d8d8f95.ile_example_JPG_2500kB.jpg",
                                                                            "${MyPublicRoomData?.object?[index].message?.userProfilePic}",
                                                                        height:
                                                                            20,
                                                                        radius:
                                                                            BorderRadius.circular(20),
                                                                        width:
                                                                            20,
                                                                        fit: BoxFit
                                                                            .fill,
                                                                      )
                                                                    : CustomImageView(
                                                                        imagePath:
                                                                            ImageConstant.tomcruse,
                                                                        height:
                                                                            20,
                                                                      )),
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      left: 5),
                                                              child: Container(
                                                                width: _width /
                                                                    1.4,
                                                                child: Text(
                                                                  "${MyPublicRoomData?.object?[index].message?.userName}",
                                                                  style: TextStyle(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w800,
                                                                      color: Colors
                                                                          .black,
                                                                      fontFamily:
                                                                          "outfit",
                                                                      fontSize:
                                                                          14),
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        )
                                                      : SizedBox(),
                                                  MyPublicRoomData
                                                              ?.object?[index]
                                                              .message
                                                              ?.message !=
                                                          null
                                                      ? Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  left: 35,
                                                                  top: 2),
                                                          child: Text(
                                                            "${MyPublicRoomData?.object?[index].message?.message ?? ""}",
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400,
                                                                color: Colors
                                                                    .black,
                                                                fontFamily:
                                                                    "outfit",
                                                                fontSize: 12),
                                                          ),
                                                        )
                                                      : SizedBox(),
                                                  Divider(
                                                    color: Colors.black,
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      GestureDetector(
                                                        onTap: () {
                                                          Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                  builder:
                                                                      (context) {
                                                            return MultiBlocProvider(
                                                              providers: [
                                                                BlocProvider(
                                                                    create: (context) =>
                                                                        senMSGCubit())
                                                              ],
                                                              child:
                                                                  ViewCommentScreen(
                                                                Room_ID:
                                                                    "${MyPublicRoomData?.object?[index].uid ?? ""}",
                                                                Title:
                                                                    "${MyPublicRoomData?.object?[index].roomQuestion ?? ""}",
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
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                              color:
                                                                  Colors.black,
                                                              fontFamily:
                                                                  "outfit",
                                                              fontSize: 15),
                                                        ),
                                                      ),
                                                      // Spacer(),
                                                      Flexible(
                                                        flex: 0,
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  right: 5),
                                                          child: Container(
                                                            //  height: 50,
                                                            alignment: Alignment
                                                                .centerRight,
                                                            // width: 150,
                                                            // color: Colors.amber,
                                                            child: Text(
                                                              "${MyPublicRoomData?.object?[index].message?.messageCount ?? "0"} Comments",
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400,
                                                                  color: Colors
                                                                      .grey,
                                                                  fontFamily:
                                                                      "outfit",
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
                                  : Container()
                              : SizedBox()
                          : SizedBox()
                      : SizedBox(),
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 0.0, right: 16, left: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Public Forum",
                          style: TextStyle(
                            fontFamily: 'outfit',
                            fontSize: 23,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        User_Module != "EXPERT"
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
                  User_ID == null
                      ? /* state is FetchAllPublicRoomLoadedState
                          ? */
                      PublicRoomModelData?.object?.length == 0 ||
                              PublicRoomModelData?.object?.isNotEmpty ==
                                  false ||
                              PublicRoomModelData?.object == null
                          ? SizedBox()
                          : PublicRoomModelData?.object?.length != 0 ||
                                  PublicRoomModelData?.object?.isNotEmpty ==
                                      true
                              ? ListView.builder(
                                  itemCount:
                                      (PublicRoomModelData?.object?.length ??
                                                  0) >
                                              5
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
                                                  color:
                                                      const Color(0XFFD9D9D9),
                                                  width: 2),
                                              borderRadius:
                                                  BorderRadius.circular(5)),
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
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 10),
                                                      child: PublicRoomModelData
                                                                  ?.object?[
                                                                      index]
                                                                  .ownerUsreProfilePic
                                                                  ?.isNotEmpty ==
                                                              false
                                                          ? CustomImageView(
                                                              // imagePath: ImageConstant
                                                              //       .tomcruse,
                                                              url:
                                                                  "${PublicRoomModelData?.object?[index].ownerUsreProfilePic}",
                                                              height: 20,
                                                              radius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          20),
                                                              width: 20,
                                                              fit: BoxFit.fill,
                                                            )
                                                          : CustomImageView(
                                                              imagePath:
                                                                  ImageConstant
                                                                      .tomcruse,
                                                              height: 20,
                                                            )),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 5),
                                                    child: Text(
                                                      "${PublicRoomModelData?.object?[index].ownerUserName}",
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w800,
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
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                        left: 8.0,
                                                        top: 10,
                                                        bottom: 10),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  left: 2.0,
                                                                  top: 5),
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
                                                            textScaleFactor:
                                                                1.0,
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                                color: Colors
                                                                    .black,
                                                                fontFamily:
                                                                    "outfit",
                                                                fontSize: 14),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              PublicRoomModelData
                                                          ?.object?[index]
                                                          .message
                                                          ?.message !=
                                                      null
                                                  ? Row(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      children: [
                                                        Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    left: 10),
                                                            child: PublicRoomModelData
                                                                        ?.object?[
                                                                            index]
                                                                        .message
                                                                        ?.userProfilePic !=
                                                                    null
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
                                                                    imagePath:
                                                                        ImageConstant
                                                                            .tomcruse,
                                                                    height: 20,
                                                                  )),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  left: 5),
                                                          child: Container(
                                                            width: _width / 1.4,
                                                            child: Text(
                                                              "${PublicRoomModelData?.object?[index].message?.userName}",
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w800,
                                                                  color: Colors
                                                                      .black,
                                                                  fontFamily:
                                                                      "outfit",
                                                                  fontSize: 14),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    )
                                                  : SizedBox(),
                                              PublicRoomModelData
                                                          ?.object?[index]
                                                          .message
                                                          ?.message !=
                                                      null
                                                  ? Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 35, top: 2),
                                                      child: Text(
                                                        "${PublicRoomModelData?.object?[index].message?.message ?? ""}",
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            color: Colors.black,
                                                            fontFamily:
                                                                "outfit",
                                                            fontSize: 12),
                                                      ),
                                                    )
                                                  : SizedBox(),
                                              Divider(
                                                color: Colors.black,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  GestureDetector(
                                                    onTap: () {
                                                      Navigator.push(context,
                                                          MaterialPageRoute(
                                                              builder:
                                                                  (context) {
                                                        return MultiBlocProvider(
                                                          providers: [
                                                            BlocProvider(
                                                                create: (context) =>
                                                                    senMSGCubit())
                                                          ],
                                                          child:
                                                              ViewCommentScreen(
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
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          color: Colors.black,
                                                          fontFamily: "outfit",
                                                          fontSize: 15),
                                                    ),
                                                  ),
                                                  // Spacer(),
                                                  Flexible(
                                                    flex: 0,
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              right: 5),
                                                      child: Container(
                                                        //  height: 50,
                                                        alignment: Alignment
                                                            .centerRight,
                                                        // width: 150,
                                                        // color: Colors.amber,
                                                        child: Text(
                                                          "${PublicRoomModelData?.object?[index].message?.messageCount ?? "0"} Comments",
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                              color:
                                                                  Colors.grey,
                                                              fontFamily:
                                                                  "outfit",
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
                              : SizedBox()
                      : FetchPublicRoomModelData?.object?.length == 0 ||
                              FetchPublicRoomModelData?.object?.isNotEmpty ==
                                  false ||
                              FetchPublicRoomModelData?.object == null
                          ? SizedBox()
                          : FetchPublicRoomModelData?.object?.length != 0 ||
                                  FetchPublicRoomModelData
                                          ?.object?.isNotEmpty ==
                                      true
                              ? ListView.builder(
                                  itemCount: (FetchPublicRoomModelData
                                                  ?.object?.length ??
                                              0) >
                                          5
                                      ? 5
                                      : FetchPublicRoomModelData
                                          ?.object?.length,
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemBuilder: (context, index) {
                                    return Padding(
                                      padding: const EdgeInsets.only(
                                          left: 16, right: 16, bottom: 10),
                                      child: GestureDetector(
                                        onTap: () {
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
                                                    "${FetchPublicRoomModelData?.object?[index].uid ?? ""}",
                                                Title:
                                                    "${FetchPublicRoomModelData?.object?[index].roomQuestion ?? ""}",
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
                                                  color:
                                                      const Color(0XFFD9D9D9),
                                                  width: 2),
                                              borderRadius:
                                                  BorderRadius.circular(5)),
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
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 10),
                                                      child: FetchPublicRoomModelData
                                                                  ?.object?[
                                                                      index]
                                                                  .ownerUsreProfilePic !=
                                                              null
                                                          ? CustomImageView(
                                                              // imagePath: ImageConstant
                                                              //       .tomcruse,
                                                              url:
                                                                  "${FetchPublicRoomModelData?.object?[index].ownerUsreProfilePic}",
                                                              height: 20,
                                                              radius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          20),
                                                              width: 20,
                                                              fit: BoxFit.fill,
                                                            )
                                                          : CustomImageView(
                                                              imagePath:
                                                                  ImageConstant
                                                                      .tomcruse,
                                                              height: 20,
                                                            )),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 5),
                                                    child: Text(
                                                      "${FetchPublicRoomModelData?.object?[index].ownerUserName}",
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w800,
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
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                        left: 8.0,
                                                        top: 10,
                                                        bottom: 10),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  left: 2.0,
                                                                  top: 5),
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
                                                            "${FetchPublicRoomModelData?.object?[index].roomQuestion}",
                                                            maxLines: 2,
                                                            textScaleFactor:
                                                                1.0,
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                                color: Colors
                                                                    .black,
                                                                fontFamily:
                                                                    "outfit",
                                                                fontSize: 14),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              FetchPublicRoomModelData
                                                          ?.object?[index]
                                                          .message
                                                          ?.message !=
                                                      null
                                                  ? Row(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      children: [
                                                        Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    left: 10),
                                                            child: FetchPublicRoomModelData
                                                                        ?.object?[
                                                                            index]
                                                                        .message
                                                                        ?.userProfilePic !=
                                                                    null
                                                                ? CustomImageView(
                                                                    url:
                                                                        // "https://pds-testing-images.s3.amazonaws.com/PROFILE_PIC4ee8376e-6667-495a-9a17-47afabf8f732/4ee8376e-6667-495a-9a17-47afabf8f732_409dabd0_60cf_4c69_97d2_ef689d8d8f95.ile_example_JPG_2500kB.jpg",
                                                                        "${FetchPublicRoomModelData?.object?[index].message?.userProfilePic}",
                                                                    height: 20,
                                                                    radius: BorderRadius
                                                                        .circular(
                                                                            20),
                                                                    width: 20,
                                                                    fit: BoxFit
                                                                        .fill,
                                                                  )
                                                                : CustomImageView(
                                                                    imagePath:
                                                                        ImageConstant
                                                                            .tomcruse,
                                                                    height: 20,
                                                                  )),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  left: 5),
                                                          child: Container(
                                                            width: _width / 1.4,
                                                            child: Text(
                                                              "${FetchPublicRoomModelData?.object?[index].message?.userName}",
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w800,
                                                                  color: Colors
                                                                      .black,
                                                                  fontFamily:
                                                                      "outfit",
                                                                  fontSize: 14),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    )
                                                  : SizedBox(),
                                              FetchPublicRoomModelData
                                                          ?.object?[index]
                                                          .message
                                                          ?.message !=
                                                      null
                                                  ? Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 35, top: 2),
                                                      child: Text(
                                                        "${FetchPublicRoomModelData?.object?[index].message?.message}",
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            color: Colors.black,
                                                            fontFamily:
                                                                "outfit",
                                                            fontSize: 12),
                                                      ),
                                                    )
                                                  : SizedBox(),
                                              Divider(
                                                color: Colors.black,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  GestureDetector(
                                                    onTap: () {
                                                      Navigator.push(context,
                                                          MaterialPageRoute(
                                                              builder:
                                                                  (context) {
                                                        return MultiBlocProvider(
                                                          providers: [
                                                            BlocProvider(
                                                                create: (context) =>
                                                                    senMSGCubit())
                                                          ],
                                                          child:
                                                              ViewCommentScreen(
                                                            Room_ID:
                                                                "${FetchPublicRoomModelData?.object?[index].uid ?? ""}",
                                                            Title:
                                                                "${FetchPublicRoomModelData?.object?[index].roomQuestion ?? ""}",
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
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          color: Colors.black,
                                                          fontFamily: "outfit",
                                                          fontSize: 15),
                                                    ),
                                                  ),
                                                  // Spacer(),
                                                  Flexible(
                                                    flex: 0,
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              right: 5),
                                                      child: Container(
                                                        //  height: 50,
                                                        alignment: Alignment
                                                            .centerRight,
                                                        // width: 150,
                                                        // color: Colors.amber,
                                                        child: Text(
                                                          "${FetchPublicRoomModelData?.object?[index].message?.messageCount ?? "0"} Comments",
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                              color:
                                                                  Colors.grey,
                                                              fontFamily:
                                                                  "outfit",
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
                              : SizedBox(),
                  SizedBox(
                    height: 10,
                  ),
                  PublicRoomModelData?.object?.length != 0 ||
                          PublicRoomModelData?.object?.isNotEmpty == true
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
                      : FetchPublicRoomModelData?.object?.length != 0 ||
                              FetchPublicRoomModelData?.object?.isNotEmpty ==
                                  true
                          ? GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => PublicRoomList(
                                          FetchPublicRoomModelData:
                                              FetchPublicRoomModelData,
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
                  getallBlogdata?.object?.length == 0  ||  getallBlogdata?.object?.isNotEmpty == false ? SizedBox(): Padding(
                    padding:
                        const EdgeInsets.only(right: 20.0, left: 20, top: 7),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Recent Blogs",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              fontFamily: "outfit",
                              fontSize: 23),
                        ),
                        GestureDetector(
                          onTap: () {},
                          child: Icon(
                            Icons.arrow_forward,
                            size: 30,
                          ),
                        ),
                      ],
                    ),
                  ),
                   getallBlogdata?.object?.length == 0  ||  getallBlogdata?.object?.isNotEmpty == false ? SizedBox():
                  Container(
                    // color: Colors.red,
                    height: _height / 3,
                    width: _width / 1.1,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      physics: BouncingScrollPhysics(),
                      itemCount: getallBlogdata?.object?.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                              // height: 100,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                // border: Border.all(
                                //   color: Colors.red,
                                // ),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Stack(
                                    // alignment: Alignment.topRight,
                                    children: [
                                      Container(
                                        height: _height / 3.2,
                                        width: _width / 1.2,
                                        child: CustomImageView(
                                          // imagePath: ImageConstant.blogimage,

                                          url: getallBlogdata
                                                  ?.object?[index].image
                                                  .toString() ??
                                              "",
                                          // height: 50,
                                          width: _width,
                                          fit: BoxFit.fill,
                                          radius: BorderRadius.circular(10),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 290, top: 10),
                                        child: Image.asset(
                                          ImageConstant.blogsaveimage,
                                          height: 40,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                          top: 180,
                                        ),
                                        child: Container(
                                          height: _height / 10,
                                          width: _width / 1.2,
                                          decoration: BoxDecoration(
                                              color:
                                                  Colors.white.withOpacity(0.7),
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          child: Column(children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 10),
                                              child: Row(
                                                children: [
                                                  Text(
                                                    getallBlogdata
                                                            ?.object?[index]
                                                            .description
                                                            .toString() ??
                                                        "",
                                                    style: TextStyle(
                                                        fontFamily: 'outfit',
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Row(
                                              children: [
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                Text(
                                                    getallBlogdata
                                                            ?.object?[index]
                                                            .createdAt
                                                            .toString() ??
                                                        "",
                                                    style: TextStyle(
                                                        fontFamily: 'outfit',
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.bold)),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                CircleAvatar(
                                                  backgroundColor: Colors.black,
                                                  maxRadius: 2,
                                                ),
                                                SizedBox(
                                                  width: 2,
                                                ),
                                                Text("12.3K Views",
                                                    style: TextStyle(
                                                        fontFamily: 'outfit',
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.bold)),
                                                Spacer(),
                                                Image.asset(
                                                  ImageConstant.like_image,
                                                  height: 20,
                                                ),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                Image.asset(
                                                  ImageConstant.arrowleftimage,
                                                  height: 30,
                                                  color: Colors.black,
                                                ),
                                                SizedBox(
                                                  width: 10,
                                                )
                                              ],
                                            )
                                          ]),
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              )),
                        );
                      },
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(right: 20.0, left: 20, top: 7),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Previous Blogs",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              fontFamily: "outfit",
                              fontSize: 23),
                        ),
                        GestureDetector(
                          onTap: () {},
                          child: Icon(
                            Icons.arrow_forward,
                            size: 30,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    // color: Colors.red,
                    height: _height / 3.5,
                    width: _width / 1.1,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      physics: BouncingScrollPhysics(),
                      itemCount: 5,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            // height: 100,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                color: Colors.grey.shade300,
                              ),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Stack(
                                  children: [
                                    Container(
                                      height: 120,
                                      width: _width / 2.35,
                                      child: CustomImageView(
                                        imagePath: ImageConstant.blogimage,
                                        // height: 50,
                                        // width: _width/1.2,
                                        fit: BoxFit.fill,
                                        radius: BorderRadius.circular(10),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text(
                                      "Baluran Wild The",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          color: Colors.black,
                                          fontFamily: "outfit",
                                          fontSize: 20),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text(
                                      "Savvanah",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          color: Colors.black,
                                          fontFamily: "outfit",
                                          fontSize: 20),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text("27th june 2020  10:47 PM",
                                        style: TextStyle(
                                            fontFamily: 'outfit',
                                            fontSize: 10,
                                            fontWeight: FontWeight.w100)),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    CircleAvatar(
                                      backgroundColor: Colors.black,
                                      maxRadius: 2,
                                    ),
                                    SizedBox(
                                      width: 2,
                                    ),
                                    Text("12.3K Views",
                                        style: TextStyle(
                                            fontFamily: 'outfit',
                                            fontSize: 10,
                                            fontWeight: FontWeight.w100)),
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Image.asset(
                                      ImageConstant.like_image,
                                      height: 20,
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Image.asset(
                                      ImageConstant.arrowleftimage,
                                      height: 30,
                                      color: Colors.black,
                                    ),
                                    SizedBox(width: _width / 4.8),
                                    Image.asset(
                                      ImageConstant.setting_save,
                                      height: 20,
                                      color: Colors.black,
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      physics: BouncingScrollPhysics(),
                      itemCount: 4,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            // height: 100,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                color: Colors.grey.shade300,
                              ),
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  height: 110,
                                  width: _width / 4,
                                  child: CustomImageView(
                                    imagePath: ImageConstant.blogimage,
                                    // height: 50,
                                    // width: _width/1.2,
                                    fit: BoxFit.fill,
                                    radius: BorderRadius.circular(10),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 2),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text("Baluran Wild The Savvanah",
                                          style: TextStyle(
                                              fontFamily: 'outfit',
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold)),
                                      Container(
                                        height: 70,
                                        width: _width / 1.6,
                                        // color: Colors.amber,
                                        child: Text(
                                            "Lectus scelerisque vulputate tortor pellentesque ac. Fringilla cras ut facilisis amet imperdiet vitae etiam pellentesque pellentesque. Pellentesq",
                                            style: TextStyle(
                                                fontFamily: 'outfit',
                                                fontSize: 14,
                                                fontWeight: FontWeight.w300)),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Row(
                                        children: [
                                          Text("27th June 2020",
                                              style: TextStyle(
                                                  fontFamily: 'outfit',
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w300)),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Text("10:47 pm",
                                              style: TextStyle(
                                                  fontFamily: 'outfit',
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w300)),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          CircleAvatar(
                                            maxRadius: 2,
                                            backgroundColor: Colors.grey,
                                          ),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          Text("12.3K Views",
                                              style: TextStyle(
                                                  fontFamily: 'outfit',
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w300)),
                                          SizedBox(
                                            width: 4,
                                          ),
                                          Image.asset(
                                            ImageConstant.like_image,
                                            height: 20,
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Image.asset(
                                            ImageConstant.arrowleftimage,
                                            height: 20,
                                            color: Colors.black,
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  SizedBox(
                    height: 30,
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
    } else {
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
    if (User_ID != "" && User_ID != null) {
      BlocProvider.of<FetchAllPublicRoomCubit>(context).chckUserStaus(context);
    }
    User_ID == null ? api() : NewApi();
    User_Name = prefs.getString(PreferencesKey.ProfileName);
    User_Module = prefs.getString(PreferencesKey.module);
    if (User_Module == null || User_Module == "") {
      BlocProvider.of<FetchAllPublicRoomCubit>(context).UserModel(context);
    }
    UserProfile = prefs.getString(PreferencesKey.UserProfile);
    prefs.setBool(PreferencesKey.OpenProfile, false);
    var Token = prefs.getString(PreferencesKey.loginJwt);
    var FCMToken = prefs.getString(PreferencesKey.fcmToken);

    print("---------------------->> : ${FCMToken}");
    print("User Token :--- " + "${Token}");

    print('usrId-$User_ID');

    setState(() {});
    // prefs.getString(PreferencesKey.ProfileEmail);
    // prefs.getString(PreferencesKey.ProfileModule);
    // prefs.getString(PreferencesKey.ProfileMobileNo);
  }
   OpenProfileSave() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(PreferencesKey.OpenProfile, true);
  }

  api() {
    BlocProvider.of<FetchAllPublicRoomCubit>(context)
        .FetchAllPublicRoom(context);

    // BlocProvider.of<FetchAllPublicRoomCubit>(context).chckUserStaus(context);
  }

  NewApi() async {
    print("1111111111111${User_ID}");
    await BlocProvider.of<FetchAllPublicRoomCubit>(context).UserModel(context);
    await BlocProvider.of<FetchAllPublicRoomCubit>(context)
        .FetchPublicRoom("${User_ID}", context);
    await BlocProvider.of<FetchAllPublicRoomCubit>(context)
        .MyPublicRoom("${User_ID}", context);
  }

  setUserStatusFunction({String? acticueUser, String? rejectionReason}) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    if (acticueUser == null) {
      print('if condison check$rejectionReason');
      prefs.setString(PreferencesKey.userStatus, rejectionReason.toString());
    } else {
      print('elseif condison check$acticueUser');
      prefs.setString(PreferencesKey.userStatus, acticueUser.toString());
    }
  }
}
