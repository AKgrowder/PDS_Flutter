import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:pds/core/utils/color_constant.dart';
import 'package:pds/core/utils/image_constant.dart';

class InboxScreen extends StatefulWidget {
  const InboxScreen({Key? key}) : super(key: key);

  @override
  State<InboxScreen> createState() => _InboxScreenState();
}

class _InboxScreenState extends State<InboxScreen> {
  TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          onPressed: () {},
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: ColorConstant.primary_color,
            ),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Image.asset(ImageConstant.addIcon),
              ),
            ),
          )),
      body: Container(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.only(left: 15, right: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: height * 0.06,
                ),
                Text(
                  "Inbox",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 15),
                  child: Container(
                    height: 48,
                    decoration: BoxDecoration(
                        color: Color(0xffFBD8D9),
                        border: Border.all(
                          color: ColorConstant.primary_color,
                        ),
                        borderRadius: BorderRadius.circular(10)),
                    child: TextField(
                      controller: searchController,
                      cursorColor: ColorConstant.primary_color,
                      decoration: InputDecoration(
                          hintText: "Search....",
                          hintStyle:
                              TextStyle(color: ColorConstant.primary_color),
                          border: InputBorder.none,
                          prefixIcon: Icon(
                            Icons.search,
                            color: ColorConstant.primary_color,
                          )),
                    ),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                      shrinkWrap: true,
                      padding: EdgeInsets.zero,
                      itemCount: 10,
                      itemBuilder: (context, index) {
                        return Slidable(
                          enabled: true,
                          dragStartBehavior: DragStartBehavior.start,
                          endActionPane: ActionPane(
                              extentRatio: 0.2,
                              motion: ScrollMotion(),
                              children: [
                                GestureDetector(
                                  onTap: () {},
                                  child: Container(
                                    margin: EdgeInsets.only(left: 20, top: 5),
                                    height: 50,
                                    width: 50,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Color(0xffFBD8D9)),
                                    child: Center(
                                        child: Padding(
                                      padding: const EdgeInsets.all(15),
                                      child: Image.asset(
                                        ImageConstant.deleteIcon,
                                        color: ColorConstant.primary_color,
                                      ),
                                    )),
                                  ),
                                )
                              ]),
                          child: Padding(
                            padding: const EdgeInsets.only(top: 15),
                            child: Container(
                              height: 80,
                              decoration: BoxDecoration(
                                  border:
                                      Border.all(color: Colors.grey.shade400),
                                  borderRadius: BorderRadius.circular(10)),
                              child: Padding(
                                padding: const EdgeInsets.all(10),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Stack(children: [
                                          Container(
                                            height: 60,
                                            width: 60,
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                            ),
                                            child: Image.asset(
                                               ImageConstant.placeholder2),
                                          ),
                                          Positioned(
                                              bottom: 1,
                                              right: 5,
                                              child: Container(
                                                height: 12,
                                                width: 12,
                                                decoration: BoxDecoration(
                                                    color: Colors.red,
                                                    shape: BoxShape.circle,
                                                    border: Border.all(
                                                        color: Colors.white,
                                                        width: 2)),
                                              ))
                                        ]),
                                        Padding(
                                          padding: const EdgeInsets.all(6),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "Karennne",
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                              Text(
                                                "Did you do that. Its urgent.",
                                                style: TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w600,
                                                  color: Colors.grey,
                                                ),
                                              )
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 6),
                                      child: Text(
                                        "Just Now",
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.grey,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      }),
                ),
                SizedBox(
                  height: 20,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
