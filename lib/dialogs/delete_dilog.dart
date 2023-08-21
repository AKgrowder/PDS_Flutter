import 'package:archit_s_application1/API/Bloc/DeleteRoom_bloc/Delete_room_cubit.dart';
import 'package:archit_s_application1/API/Bloc/DeleteRoom_bloc/Delete_room_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../core/utils/color_constant.dart';
import '../core/utils/image_constant.dart';
import '../widgets/custom_image_view.dart';
  
class DeleteDilogScreen extends StatefulWidget {
  String? userId;
  DeleteDilogScreen({this.userId});
  @override
  State<StatefulWidget> createState() => DeleteDilogScreenState();
}

TextEditingController RateUSController = TextEditingController();

class DeleteDilogScreenState extends State<DeleteDilogScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> scaleAnimation;

  double? rateStar = 5.0;
  var IsGuestUserEnabled;
  var GetTimeSplash;
  @override
  void initState() {
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
              // color: Colors.black,

              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
            ),
            child: BlocConsumer<DeleteRoomCubit, DeleteRoomState>(
              listener: (context, state) {
                if (state is DeleteRoomLoadingState) {
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
                if (state is DeleteRoomLoadedState) {
                  SnackBar snackBar = SnackBar(
                    content: Text(state.DeleteRoom.message ?? ""),
                    backgroundColor: ColorConstant.primary_color,
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  print(
                      'deldelDataCheck-${state.DeleteRoom.message.toString()}');
                  Navigator.pop(context);
                }
                if (state is DeleteRoomErrorState) {
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
                        height: 270,
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
                                    "Delete Room",
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
                            SizedBox(
                              height: 5,
                            ),
                            Center(
                                child: Text(
                              "Are You Sure You Want To Delete This Room",
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
                                    BlocProvider.of<DeleteRoomCubit>(context)
                                        .DeleteRoomm(widget.userId.toString());
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
                                      "Delete",
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
