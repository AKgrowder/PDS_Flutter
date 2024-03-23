import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pds/core/utils/color_constant.dart';
import 'package:pds/core/utils/image_constant.dart';

import '../API/Bloc/BlockUser_Bloc/Block_user_cubit.dart';
import '../API/Bloc/BlockUser_Bloc/Block_user_state.dart';

class UnBlockUserChatdailog extends StatefulWidget {
  String? userName;
  UnBlockUserChatdailog({Key? key, this.userName}) : super(key: key);
  @override
  State<StatefulWidget> createState() => UnBlockUserChatdailogState();
}

class UnBlockUserChatdailogState extends State<UnBlockUserChatdailog>
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
      super.setState(() {});
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
            height: 320,
            decoration: ShapeDecoration(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
            ),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    // height: 520,
                    height: 320,
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
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 15, right: 15, top: 15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Navigator.pop(context);
                                  Navigator.pop(context);
                                },
                                child: Container(
                                  // margin: EdgeInsets.only(right: 4),
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
                        ),
                        Image.asset(
                          ImageConstant.block_user_chat,
                          height: _height / 6,
                          width: _width,
                        ),
                        Text(
                              "User Blocked",
                              textScaleFactor: 1.0,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontFamily: 'outfit',
                                fontSize: 22,
                                fontWeight: FontWeight.w400,
                                color:
                                    Color(0xff797979), /* textCenter: true, */
                              )),
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 15, left: 20, right: 20),
                          child: Text(
                              "You are not able to chat with ${widget.userName}",
                              textScaleFactor: 1.0,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontFamily: 'outfit',
                                fontSize: 22,
                                fontWeight: FontWeight.w400,
                                color:
                                    Color(0xff797979), /* textCenter: true, */
                              )),
                        ),
                      ],
                    ),
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
