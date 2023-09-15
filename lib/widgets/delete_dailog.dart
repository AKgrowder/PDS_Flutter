import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pds/API/Bloc/DeleteUser_Bloc/DeleteUser_cubit.dart';
import 'package:pds/API/Bloc/DeleteUser_Bloc/DeleteUser_state.dart';
import 'package:pds/API/Bloc/Fatch_All_PRoom_Bloc/Fatch_PRoom_cubit.dart';
import 'package:pds/API/Bloc/GetAllPrivateRoom_Bloc/GetAllPrivateRoom_cubit.dart';
import 'package:pds/API/Bloc/Invitation_Bloc/Invitation_cubit.dart';
import 'package:pds/API/Bloc/PublicRoom_Bloc/CreatPublicRoom_cubit.dart';
import 'package:pds/API/Bloc/auth/register_Block.dart';
import 'package:pds/API/Bloc/senMSG_Bloc/senMSG_cubit.dart';
import 'package:pds/core/utils/color_constant.dart';
import 'package:pds/core/utils/image_constant.dart';
import 'package:pds/custom_bottom_bar/custom_bottom_bar.dart';
import 'package:pds/widgets/custom_text_form_field.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../core/utils/sharedPreferences.dart';

class DeleteUserdailog extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => DeleteUserdailogState();
}

class DeleteUserdailogState extends State<DeleteUserdailog>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> scaleAnimation;

  TextEditingController reasonController = TextEditingController();
  String? User_ID;

  @override
  void initState() {
    super.initState();

    controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 450));
    scaleAnimation =
        CurvedAnimation(parent: controller, curve: Curves.elasticInOut);

    controller.addListener(() {
      setState(() {});
    });

    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    double _height = MediaQuery.of(context).size.height;

    return Center(
      child: Material(
        color: Color.fromARGB(0, 255, 255, 255),
        child: ScaleTransition(
          scale: scaleAnimation,
          child: Container(
            height: 480,
            decoration: ShapeDecoration(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
            ),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  BlocConsumer<DeleteUserCubit, DeleteUserState>(
                    listener: (context, state) async {
                      if (state is DeleteUserErrorState) {
                        if (state.error != "error in fetch room") {
                          SnackBar snackBar = SnackBar(
                            content: Text(state.error),
                            backgroundColor: ColorConstant.primary_color,
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        }
                      }
                      if (state is DeleteUserLoadedState) {
                        final SharedPreferences prefs =
                            await SharedPreferences.getInstance();
                        prefs.remove(PreferencesKey.loginUserID);
                        prefs.remove(PreferencesKey.loginJwt);
                        prefs.remove(PreferencesKey.module);
                        SnackBar snackBar = SnackBar(
                          content:
                              Text(state.deleteUserModel.message.toString()),
                          backgroundColor: ColorConstant.primary_color,
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);

                        Navigator.pushAndRemoveUntil(context,
                            MaterialPageRoute(builder: (context) {
                          return MultiBlocProvider(providers: [
                            BlocProvider<FetchAllPublicRoomCubit>(
                              create: (context) => FetchAllPublicRoomCubit(),
                            ),
                            BlocProvider<CreatPublicRoomCubit>(
                              create: (context) => CreatPublicRoomCubit(),
                            ),
                            BlocProvider<senMSGCubit>(
                              create: (context) => senMSGCubit(),
                            ),
                            BlocProvider<RegisterCubit>(
                              create: (context) => RegisterCubit(),
                            ),
                            BlocProvider<GetAllPrivateRoomCubit>(
                              create: (context) => GetAllPrivateRoomCubit(),
                            ),
                            BlocProvider<InvitationCubit>(
                              create: (context) => InvitationCubit(),
                            ),
                          ], child: BottombarPage(buttomIndex: 0));
                        }), (route) => false);
                      }
                    },
                    builder: (context, state) {
                      return Container(
                        // height: 520,
                        height: 480,
                        width: _width / 1.1,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: Color.fromARGB(255, 255, 255, 255),
                          // color: Theme.of(context).brightness == Brightness.light
                          //     ? Color(0XFFEFEFEF)
                          //     : Color(0XFF212121),
                        ),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Spacer(),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                  child: Container(
                                    margin: EdgeInsets.only(right: 4),
                                    height: 50,
                                    width: 50,
                                    color: Color.fromARGB(0, 0, 0, 0),
                                    child: Align(
                                      alignment: Alignment.centerRight,
                                      child: Image.asset(
                                        ImageConstant.closeimage,
                                        height: 40,
                                        width: 40,
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              height: 130,
                              width: 130,
                              color: Color.fromARGB(0, 32, 192, 157),
                              child: Image.asset(
                                ImageConstant.closeimage,
                                fit: BoxFit.fill,
                                color: ColorConstant.primary_color,
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                                "Are you Sure you want to \n Delete your Account?",
                                textScaleFactor: 1.0,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontFamily: 'outfit',
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  color: ColorConstant
                                      .primary_color, /* textCenter: true, */
                                )),
                            // Padding(
                            //   padding: const EdgeInsets.only(top: 7),
                            //   child: Text(
                            //     "All the data will be deleted from the \n server after 30 days.",
                            //     textScaleFactor: 1.0,
                            //     textAlign: TextAlign.center,
                            //     style: TextStyle(
                            //       fontFamily: 'outfit',
                            //       fontSize: 14,
                            //       fontWeight: FontWeight.w500,
                            //       // textCenter: true,
                            //       // color: Colors.black45,
                            //       color: Theme.of(context).brightness ==
                            //               Brightness.light
                            //           ? Colors.black45
                            //           : Colors.grey,
                            //     ),
                            //   ),
                            // ),
                            Padding(
                                padding: EdgeInsets.only(left: 15),
                                child: Row(children: [
                                  Padding(
                                      padding:
                                          EdgeInsets.only(top: 5, bottom: 5),
                                      child: Text("Reason",
                                          textScaleFactor: 1.0,
                                          overflow: TextOverflow.ellipsis,
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                            fontFamily: 'outfit',
                                            color: ColorConstant.primary_color,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                          ))),
                                  Padding(
                                      padding:
                                          EdgeInsets.only(left: 5, bottom: 2),
                                      child: Text("*",
                                          textScaleFactor: 1.0,
                                          overflow: TextOverflow.ellipsis,
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                            color: ColorConstant.primary_color,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                          )))
                                ])),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 15, right: 15),
                              child: Container(
                                // color: Colors.red,
                                height:100,
                                child: CustomTextFormField(
                                  // focusNode: FocusNode(),
                                  controller: reasonController,
                                  hintText: "",
                                  maxLength: 150,
                                  // padding: TextFormFieldPadding.PaddingT44,
                                  maxLines: 5,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 25, left: 30, right: 30),
                              child: Row(
                                children: [
                                  Flexible(
                                    flex: 2,
                                    fit: FlexFit.tight,
                                    child: GestureDetector(
                                      onTap: () async {
                                        final SharedPreferences prefs =
                                            await SharedPreferences
                                                .getInstance();
                                        User_ID = prefs.getString(
                                            PreferencesKey.loginUserID);
                                        if (reasonController.text.isNotEmpty) {
                                          BlocProvider.of<DeleteUserCubit>(
                                                  context)
                                              .DeleteUserApi(
                                                  User_ID.toString(), context);
                                        } else {
                                          show_Icon_Flushbar(context,
                                              msg:
                                                  "Please Enter Valid Reason.");
                                        }
                                        // Navigator.pop(context);
                                      },
                                      child: Container(
                                        // width: 163,
                                        height: 48,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: ColorConstant.primary_color,
                                        ),
                                        child: Center(
                                          child: Text("Yes",
                                              textScaleFactor: 1.0,
                                              style: TextStyle(
                                                  fontFamily: 'outfit',
                                                  fontSize: 16,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w600)),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 20,
                                  ), //SizedBox
                                  Flexible(
                                      flex: 2,
                                      fit: FlexFit.tight,
                                      child: GestureDetector(
                                        onTap: () {
                                          Navigator.pop(context);
                                        },
                                        child: Container(
                                            // width: 163,
                                            height: 48,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              // color: ColorConstant.whiteA700,
                                              color: Theme.of(context)
                                                          .brightness ==
                                                      Brightness.light
                                                  ? Colors.white
                                                  : Colors.black,
                                              border: Border.all(
                                                // color: ColorConstant.orangeA700,
                                                color: Theme.of(context)
                                                            .brightness ==
                                                        Brightness.light
                                                    ? ColorConstant
                                                        .primary_color
                                                    : ColorConstant
                                                        .primary_color,
                                                width: 1.5,
                                                style: BorderStyle.solid,
                                                strokeAlign: BorderSide
                                                    .strokeAlignInside,
                                              ),
                                            ),
                                            child: Center(
                                              child: Text(
                                                "No",
                                                textScaleFactor: 1.0,
                                                style: TextStyle(
                                                    fontFamily: 'outfit',
                                                    fontSize: 16,
                                                    // color: ColorConstant.orangeA700,
                                                    color: Theme.of(context)
                                                                .brightness ==
                                                            Brightness.light
                                                        ? Colors.black
                                                        : ColorConstant
                                                            .primary_color,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                            )),
                                      ))
                                ],
                                mainAxisAlignment: MainAxisAlignment.center,
                              ),
                            ),
                            // SizedBox(
                            //   height: 20,
                            // ),
                          ],
                        ),
                      );
                    },
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void show_Icon_Flushbar(BuildContext context, {String? msg}) {
    Flushbar(
        backgroundColor: ColorConstant.primary_color,
        animationDuration: Duration(milliseconds: 500),
        duration: Duration(seconds: 3),
        message: msg)
      ..show(context);
  }
}
