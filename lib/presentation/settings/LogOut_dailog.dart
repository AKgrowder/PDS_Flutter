import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pds/core/utils/color_constant.dart';
import 'package:pds/core/utils/sharedPreferences.dart';
import 'package:pds/presentation/%20new/newbottembar.dart';
import 'package:pds/videocallCommenClass.dart/commenFile.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../API/Bloc/logOut_bloc/LogOut_state.dart';
import '../../API/Bloc/logOut_bloc/logOut_cubit.dart';

class LogOutdailog extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => LogOutdailogState();
}

class LogOutdailogState extends State<LogOutdailog>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> scaleAnimation;

  TextEditingController reasonController = TextEditingController();

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
    // double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Center(
      child: Material(
        color: Color.fromARGB(0, 255, 255, 255),
        child: ScaleTransition(
          scale: scaleAnimation,
          child: Container(
            // height: height / 1.4,
            decoration: ShapeDecoration(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
            ),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  BlocConsumer<LogOutCubit, LogOutState>(
                      listener: (context, state) async {
                    if (state is LogOutErrorState) {
                      if (state.error != "error in fetch room") {
                        SnackBar snackBar = SnackBar(
                          content: Text(state.error),
                          backgroundColor: ColorConstant.primary_color,
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      }
                    }
                    if (state is LogOutLoadedState) {
                      final SharedPreferences prefs =
                          await SharedPreferences.getInstance();
                      prefs.clear();

                      SnackBar snackBar = SnackBar(
                        content: Text(state.LoginOutModel.message.toString()),
                        backgroundColor: ColorConstant.primary_color,
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);

                      Navigator.pushAndRemoveUntil(context,
                          MaterialPageRoute(builder: (context) {
                        return NewBottomBar(buttomIndex: 0);
                      }), (route) => false);
                    }
                  }, builder: (context, state) {
                    return AlertDialog(
                      title: const Text(
                        'Logout',
                        style: TextStyle(
                          fontFamily: "outfit",
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      content: const Text(
                        'Do You Want To Logout ?',
                        style: TextStyle(
                          fontFamily: "outfit",
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      actions: <Widget>[
                        Row(
                          children: [
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.grey,
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(10),
                                    )),
                                height: 50,
                                child: TextButton(
                                  style: TextButton.styleFrom(),
                                  child: const Text(
                                    'No',
                                    style: TextStyle(color: Colors.black),
                                  ),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                    color: ColorConstant.primary_color,
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(10),
                                    )),
                                height: 50,
                                child: TextButton(
                                  style: TextButton.styleFrom(),
                                  child: const Text('Yes',
                                      style: TextStyle(color: Colors.white)),
                                  onPressed: () async {
                                      onUserLogout();
                                    BlocProvider.of<LogOutCubit>(context)
                                        .LogOutApi(context);
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    );
                  })
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
