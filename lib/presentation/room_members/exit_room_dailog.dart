import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pds/API/Bloc/GetAllPrivateRoom_Bloc/GetAllPrivateRoom_cubit.dart';
import 'package:pds/core/utils/color_constant.dart';
import 'package:pds/presentation/%20new/newbottembar.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../API/Bloc/GetAllPrivateRoom_Bloc/GetAllPrivateRoom_state.dart';

class ExitRoomDailog extends StatefulWidget {
  void Function()? onClose;
  String? roomID;
  ExitRoomDailog({Key? key, this.onClose, this.roomID}) : super(key: key);
  @override
  State<StatefulWidget> createState() => _ExitRoomDailogState();
}

TextEditingController RateUSController = TextEditingController();

class _ExitRoomDailogState extends State<ExitRoomDailog>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;

  late Animation<double> scaleAnimation;
  String? User_Mood;
  TextEditingController _roomName = TextEditingController();
  TextEditingController _DescriptionText = TextEditingController();
  bool SubmitOneTime = false;

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

  var userRating;

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
            width: 400,
            height: 200,
            decoration: ShapeDecoration(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
            ),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  BlocConsumer<GetAllPrivateRoomCubit, GetAllPrivateRoomState>(
                    listener: (context, state) {
                      if (state is DeleteRoomLoadedState) {
                        SnackBar snackBar = SnackBar(
                          content: Text(state.DeleteRoom.object ?? ""),
                          backgroundColor: ColorConstant.primary_color,
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);

                        Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                                builder: (context) => NewBottomBar(
                                      buttomIndex: 1,
                                    )),
                            (Route<dynamic> route) => false);
                      }
                    },
                    builder: (context, state) {
                      return Container(
                          // height: 520,
                          height: 200,
                          width: 400,
                          decoration: BoxDecoration(
                            // border: Border.all(color: Colors.black),
                            borderRadius: BorderRadius.circular(10.0),
                            color: Color.fromARGB(255, 255, 255, 255),
                            // color: Theme.of(context).brightness == Brightness.light
                            //     ? Color(0XFFEFEFEF)
                            //     : Color(0XFF212121),
                          ),
                          child: Column(
                            children: [
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                "Exit Room",
                                style: TextStyle(
                                  fontFamily: 'outfit',
                                  fontSize: 20,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Divider(
                                color: Colors.grey,
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Center(
                                  child: Text(
                                "Are You Sure You Want To Exit This Room",
                                style: TextStyle(
                                  fontFamily: 'outfit',
                                  fontSize: 15,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500,
                                ),
                              )),
                              SizedBox(
                                height: 50,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 30, right: 30),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Flexible(
                                      flex: 2,
                                      fit: FlexFit.tight,
                                      child: GestureDetector(
                                        onTap: widget.onClose,
                                        child: Container(
                                          height: 43,
                                          width: _width / 3.5,
                                          decoration: BoxDecoration(
                                              color: Colors.transparent,
                                              border: Border.all(
                                                  color: Colors.grey.shade400),
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          child: Center(
                                              child: Text(
                                            "Cancel",
                                            style: TextStyle(
                                              fontFamily: 'outfit',
                                              fontSize: 15,
                                              color:
                                                  ColorConstant.primary_color,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          )),
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
                                          BlocProvider.of<
                                                      GetAllPrivateRoomCubit>(
                                                  context)
                                              .DeleteRoomm(
                                                  widget.roomID.toString(),
                                                  'Exit',
                                                  context);

                                          Navigator.pop(context);
                                        },
                                        child: Container(
                                          height: 43,
                                          width: _width / 3.5,
                                          decoration: BoxDecoration(
                                              color:
                                                  ColorConstant.primary_color,
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          child: Center(
                                              child: Text(
                                            "Exit",
                                            style: TextStyle(
                                              fontFamily: 'outfit',
                                              fontSize: 15,
                                              color: Colors.white,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          )),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ));
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
