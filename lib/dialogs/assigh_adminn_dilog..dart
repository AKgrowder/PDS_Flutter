import 'package:flutter/material.dart';

import '../core/utils/image_constant.dart';
import '../widgets/custom_image_view.dart';

class AssignAdminScreenn extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _AssignAdminScreennState();
}

TextEditingController RateUSController = TextEditingController();

class _AssignAdminScreennState extends State<AssignAdminScreenn>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> scaleAnimation;
  List<String> users = [
    "User 1",
    "User 2",
    "User 3",
    "User 4",
    "User 5",
  ];
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
    // TODO: implement dispose
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
            child: Column(
              children: [
                Center(
                  child: Container(
                    height: 345,
                    width: _width / 1.25,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0, left: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Assign Admin",
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
                        ListView.builder(
                          itemCount: 5,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  CustomImageView(
                                    imagePath: ImageConstant.workimage,
                                    height: 30,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(users[index]),
                                  ),
                                  Spacer(),
                                  Container(
                                    width: 80,
                                    height: 20,
                                    decoration: ShapeDecoration(
                                      color: Color(0xFFED1C25),
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(49.46),
                                      ),
                                    ),
                                    child: Center(
                                        child: Text(
                                      "Assign",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          color: Colors.white,
                                          fontFamily: "outfit",
                                          fontSize: 10),
                                    )),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                        Center(
                          child: Container(
                            width: 65,
                            height: 23,
                            padding: const EdgeInsets.only(
                                top: 5, left: 9, right: 8, bottom: 5),
                            decoration: ShapeDecoration(
                              color: Color(0xFFE4E4E4),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5)),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  'Load More',
                                  style: TextStyle(
                                    color: Color(0xFFB9B9B9),
                                    fontSize: 10,
                                    fontFamily: 'Outfit',
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
