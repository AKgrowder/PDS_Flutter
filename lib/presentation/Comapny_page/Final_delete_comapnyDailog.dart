import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pds/API/Bloc/BlockUser_Bloc/Block_user_state.dart';
import 'package:pds/core/utils/color_constant.dart';
import 'package:pds/core/utils/image_constant.dart';

class FinalDeleteComapnyDailog extends StatefulWidget {
  const FinalDeleteComapnyDailog({Key? key}) : super(key: key);

  @override
  State<FinalDeleteComapnyDailog> createState() => _DeleteComapnyDailogState();
}

class _DeleteComapnyDailogState extends State<FinalDeleteComapnyDailog>
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
            height: 300,
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
                    height: 300,
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
                          ImageConstant.deleteComapny,
                          height: _height / 6,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: Text(
                            "Page deleted successfully",
                            style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.w600,
                                color: Colors.grey,
                                fontFamily: "outfit"),
                          ),
                        )
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
