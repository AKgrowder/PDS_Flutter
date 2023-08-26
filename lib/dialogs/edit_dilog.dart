// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pds/API/Bloc/Edit_room_bloc/Edit_room_state.dart';
import 'package:pds/API/Bloc/Edit_room_bloc/edit_room_cubit.dart';
import 'package:pds/core/utils/color_constant.dart';

import '../core/utils/image_constant.dart';
import '../widgets/custom_image_view.dart';

class EditDilogScreen extends StatefulWidget {
  String? uid;
  String? parentName;
  EditDilogScreen({this.uid, this.parentName});
  @override
  State<StatefulWidget> createState() => EditDilogScreenState();
}

class EditDilogScreenState extends State<EditDilogScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> scaleAnimation;
  TextEditingController RateUSController = TextEditingController();
  TextEditingController editroom = TextEditingController();
  double? rateStar = 5.0;
  var IsGuestUserEnabled;
  var GetTimeSplash;
  @override
  void initState() {
    editroom.text = widget.parentName.toString();
    // setUserRating();
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

  var userRating;

  @override
  void dispose() {
    RateUSController.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var _height = MediaQuery.of(context).size.height;
    var _width = MediaQuery.of(context).size.width;
    return Center(
      child: Material(
        color: Color.fromARGB(0, 255, 255, 255),
        child: ScaleTransition(
          scale: scaleAnimation,
          child: Container(
            height: _height / 2,
            width: _width / 1.17,
            decoration: ShapeDecoration(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
            ),
            child: BlocConsumer<EditroomCubit, EditroomState>(
              listener: (context, state) {
                if (state is EditroomLoadingState) {
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
                if (state is EditroomLoadedState) {
                  editroom.clear();
                  SnackBar snackBar = SnackBar(
                    content: Text(state.editRoom.message ?? ""),
                    backgroundColor: ColorConstant.primary_color,
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  Future.delayed(const Duration(milliseconds: 900), () {
                    Navigator.pop(context);
                  });
                }
                if (state is EditroomErrorState) {
                  SnackBar snackBar = SnackBar(
                    content: Text(state.error.toString()),
                    backgroundColor: ColorConstant.primary_color,
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                }
              },
              builder: (context, state) {
                return Column(
                  children: [
                    Center(
                      child: Container(
                        height: 230,
                        width: _width / 1.25,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(5)),
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
                                    "Edit Room",
                                    style: TextStyle(
                                      fontFamily: 'outfit',
                                      fontSize: 20,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () => Navigator.pop(context),
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
                              padding: const EdgeInsets.only(left: 22.0),
                              child: Text(
                                "Edit Details",
                                style: TextStyle(
                                  fontFamily: 'outfit',
                                  fontSize: 15,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Center(
                              child: Container(
                                // height: 40,
                                width: _width / 1.45,
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.grey),
                                    borderRadius: BorderRadius.circular(5)),
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 10),
                                  child: TextField(
                                    // maxLength: 30,
                                    inputFormatters: [
                                      LengthLimitingTextInputFormatter(30),
                                    ],
                                    cursorColor: Colors.grey,
                                    controller: editroom,
                                    decoration: InputDecoration(
                                        // counterText: '',s
                                        border: InputBorder.none,
                                        hintText: 'Edit'),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                GestureDetector(
                                  onTap: () => Navigator.pop(context),
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
                                        color: Color(0xFFED1C25),
                                        fontWeight: FontWeight.w400,
                                      ),
                                    )),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    if (editroom.text.isEmpty) {
                                      SnackBar snackBar = SnackBar(
                                        content:
                                            Text('Room Name Can Not Be Blank'),
                                        backgroundColor:
                                            ColorConstant.primary_color,
                                      );
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(snackBar);
                                    } else {
                                      print('uid-${widget.uid}');
                                      var params = {
                                        "roomQuestion": editroom.text
                                      };

                                      print(params);

                                      BlocProvider.of<EditroomCubit>(context)
                                          .Editroom(params,
                                              widget.uid.toString(), context);
                                    }
                                  },
                                  child: Container(
                                    height: 43,
                                    width: _width / 3.5,
                                    decoration: BoxDecoration(
                                        color: Color(0xFFED1C25),
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Center(
                                        child: Text(
                                      "Update",
                                      style: TextStyle(
                                        fontFamily: 'outfit',
                                        fontSize: 15,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    )),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 8,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
