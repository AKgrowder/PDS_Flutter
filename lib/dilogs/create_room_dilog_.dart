import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pds/API/Bloc/GetAllPrivateRoom_Bloc/GetAllPrivateRoom_cubit.dart';
import 'package:pds/core/utils/color_constant.dart';
import 'package:pds/presentation/%20new/newbottembar.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../API/Bloc/CreateRoom_Bloc/CreateRoom_cubit.dart';
import '../API/Bloc/CreateRoom_Bloc/CreateRoom_state.dart';
import '../core/utils/image_constant.dart';
import '../core/utils/sharedPreferences.dart';
import '../widgets/custom_image_view.dart';

class CreateRoomScreen extends StatefulWidget {
  void Function()? onClose;
  CreateRoomScreen({
    Key? key,
    this.onClose,
  }) : super(key: key);
  @override
  State<StatefulWidget> createState() => _CreateRoomScreenState();
}

TextEditingController RateUSController = TextEditingController();

class _CreateRoomScreenState extends State<CreateRoomScreen>
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
            height: 400,
            decoration: ShapeDecoration(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
            ),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  BlocConsumer<CreateRoomCubit, CreateRoomState>(
                    listener: (context, state) {
                      if (state is CreateRoomLoadingState) {
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
                      if (state is CreateRoomLoadedState) {
                        print('this is the data get');
                        method();
                        _roomName.clear();
                        _DescriptionText.clear();

                        SnackBar snackBar = SnackBar(
                          content: Text(state.PublicRoomData.message ?? ""),
                          backgroundColor: ColorConstant.primary_color,
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        SubmitOneTime = false;
                        Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                                builder: (context) => NewBottomBar(
                                      buttomIndex: 1,
                                    )),
                            (Route<dynamic> route) => false);

                        // Navigator.pop(context);
                      }
                      if (state is CreateRoomErrorState) {
                        print('CreateRoomErrorState');
                        SnackBar snackBar = SnackBar(
                          content: Text(state.error.message),
                          backgroundColor: ColorConstant.primary_color,
                        );
                        SubmitOneTime = false;
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      }
                    },
                    builder: (context, state) {
                      return Container(
                        // height: 520,
                        height: 400,
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
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 8.0, left: 20),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Create Room",
                                    style: TextStyle(
                                      fontFamily: 'outfit',
                                      fontSize: 20,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: widget.onClose,
                                    /*  () {
                                      Navigator.pop(context);
                                      SubmitOneTime = false;
                                    }, */
                                    child: CustomImageView(
                                      imagePath: ImageConstant.closeimage,
                                      height: 40,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Divider(
                              color: Colors.grey,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                left: 10.0,
                              ),
                              child: Text(
                                "Room Name",
                                style: TextStyle(
                                  fontFamily: 'outfit',
                                  fontSize: 15,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                            Center(
                              child: Padding(
                                padding: EdgeInsets.only(
                                  top: 10.0,
                                  left: 10,
                                  right: 10,
                                ),
                                child: TextField(
                                  // maxLength: 50,
                                  controller: _roomName,
                                  cursorColor: Colors.grey,
                                  inputFormatters: [
                                    LengthLimitingTextInputFormatter(50)
                                  ],
                                  decoration: InputDecoration(
                                    hintText: 'Room Name',
                                    // counterText: '',
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: BorderSide(
                                            color: Color(0xffDBDBDB))),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 10.0, top: 20, bottom: 10),
                              child: Text(
                                "Description",
                                style: TextStyle(
                                  fontFamily: 'outfit',
                                  fontSize: 15,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                            Center(
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(left: 10, right: 10),
                                child: Container(
                                  height: 80,
                                  width: _width / 1.3,
                                  decoration: BoxDecoration(
                                      color: Colors.transparent,
                                      border: Border.all(
                                          color: Colors.grey.shade300),
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Padding(
                                    padding:
                                        EdgeInsets.only(top: 0.0, left: 10),
                                    child: TextField(
                                      // maxLength: 255,
                                      controller: _DescriptionText,
                                      maxLines: 5,
                                      cursorColor: Colors.grey,
                                      // maxLength: 500,
                                      inputFormatters: [
                                        LengthLimitingTextInputFormatter(500),
                                      ],
                                      decoration: InputDecoration(
                                        // counterText: "",
                                        hintText:
                                            'Describe your problem or topic here..',
                                        border: InputBorder.none,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 30,
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
                                      onTap: () {
                                        if (_roomName.text.isEmpty) {
                                          show_Icon_Flushbar(context,
                                              msg: "Please Enter Room Name");
                                        } else if (_roomName.text
                                                .trim()
                                                .isEmpty ||
                                            _roomName.text.trim() == '') {
                                          show_Icon_Flushbar(context,
                                              msg:
                                                  'Room Name can\'t be just blank spaces');
                                        } else if (_DescriptionText
                                                .text.isEmpty ||
                                            _DescriptionText.text == '') {
                                          show_Icon_Flushbar(context,
                                              msg: 'Please Enter Description');
                                        } else if (_DescriptionText.text
                                                .trim()
                                                .isEmpty ||
                                            _DescriptionText.text.trim() ==
                                                '') {
                                          show_Icon_Flushbar(context,
                                              msg:
                                                  'Description can\'t be just blank spaces');
                                        } else {
                                          var params = {
                                            "roomQuestion": _roomName.text,
                                            "description":
                                                _DescriptionText.text,
                                            "roomType": "PRIVTAE"
                                          };

                                          print(params);

                                          if (SubmitOneTime == false) {
                                            SubmitOneTime = true;
                                            BlocProvider.of<CreateRoomCubit>(
                                                    context)
                                                .CreateRoomAPI(params, context);
                                          }
                                        }
                                      },
                                      child: Container(
                                        height: 43,
                                        width: _width / 3,
                                        decoration: BoxDecoration(
                                            color: ColorConstant.primary_color,
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: Center(
                                            child: Text(
                                          "Create",
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
                                  SizedBox(
                                    width: 20,
                                  ), //SizedBox
                                  Flexible(
                                    flex: 2,
                                    fit: FlexFit.tight,
                                    child: GestureDetector(
                                      onTap: widget.onClose,
                                      child: Container(
                                        height: 43,
                                        width: _width / 3,
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
                                            color: ColorConstant.primary_color,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        )),
                                      ),
                                    ),
                                  )
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

  method() async {
    print('this methosd perint or not');

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    User_Mood = prefs.getString(PreferencesKey.module);
    var User_ID = prefs.getString(PreferencesKey.loginUserID);
    if (User_ID != "" && User_ID?.isNotEmpty == true) {
      await BlocProvider.of<GetAllPrivateRoomCubit>(context)
          .seetinonExpried(context);
      await BlocProvider.of<GetAllPrivateRoomCubit>(context)
          .chckUserStaus(context);

      await BlocProvider.of<GetAllPrivateRoomCubit>(context)
          .getAllNoticationsCountAPI(context);
    }

    await BlocProvider.of<GetAllPrivateRoomCubit>(context)
        .GetAllPrivateRoomAPI(context);
  }
}

 