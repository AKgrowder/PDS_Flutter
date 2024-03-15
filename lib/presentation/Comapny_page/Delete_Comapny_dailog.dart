import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pds/API/Bloc/BlockUser_Bloc/Block_user_state.dart';
import 'package:pds/core/utils/color_constant.dart';
import 'package:pds/core/utils/image_constant.dart';
import 'package:pds/presentation/Comapny_page/Final_delete_comapnyDailog.dart';

class DeleteComapnyDailog extends StatefulWidget {
  const DeleteComapnyDailog({Key? key}) : super(key: key);

  @override
  State<DeleteComapnyDailog> createState() => _DeleteComapnyDailogState();
}

class _DeleteComapnyDailogState extends State<DeleteComapnyDailog>
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
            height: 250,
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
                    height: 250,
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
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text("Delete this company page?",
                                    style: TextStyle(
                                      fontFamily: 'outfit',
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600,
                                      color:
                                          Colors.black, /* textCenter: true, */
                                    )),
                              ),
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
                        Divider(thickness: 2),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 15, right: 15, top: 15),
                          child: Column(
                            children: [
                              Text(
                                  "Are you sure you want to delete the \nComapny page?",
                                  textScaleFactor: 1.0,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontFamily: 'outfit',
                                    fontSize: 15,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.black, /* textCenter: true, */
                                  )),
                              SizedBox(
                                height: 30,
                              ),
                              GestureDetector(
                                onTap: () {
                                  showDialog(
                                    context: context,
                                    builder: (_) => FinalDeleteComapnyDailog(),
                                  );
                                },
                                child: Container(
                                  width: 163,
                                  height: 48,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: ColorConstant.primary_color,
                                  ),
                                  child: Center(
                                    child: Text('Delete',
                                        textScaleFactor: 1.0,
                                        style: TextStyle(
                                            fontFamily: 'outfit',
                                            fontSize: 16,
                                            color: Colors.white,
                                            fontWeight: FontWeight.w600)),
                                  ),
                                ),
                              ),
                            ],
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
