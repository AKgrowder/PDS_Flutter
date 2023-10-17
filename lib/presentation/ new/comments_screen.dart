import 'package:flutter/material.dart';
import 'package:pds/core/utils/color_constant.dart';
import 'package:pds/core/utils/image_constant.dart';

import '../../theme/theme_helper.dart';

class CommentsScreen extends StatefulWidget {
  const CommentsScreen({Key? key}) : super(key: key);

  @override
  State<CommentsScreen> createState() => _CommentsScreenState();
}

class _CommentsScreenState extends State<CommentsScreen> {
  @override
  Widget build(BuildContext context) {
    var _height = MediaQuery.of(context).size.height;
    var _width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: theme.colorScheme.onPrimary,
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
        backgroundColor: theme.colorScheme.onPrimary,
        elevation: 0,
        centerTitle: true,
        title: Text(
          "Comments",
          style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black,
              fontFamily: "outfit",
              fontSize: 20),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(children: [
          Container(
            // color: Colors.amber,
            height: _height / 1.3,
            child: ListView.builder(
              itemCount: 10,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: index == 0
                          ? Padding(
                              padding: const EdgeInsets.only(right: 50),
                              child: Container(
                                height: 80,
                                width: _width / 1.2,
                                decoration: BoxDecoration(
                                    // color: Colors.grey,
                                    borderRadius: BorderRadius.circular(15)),
                                child: Row(children: [
                                  Image.asset(
                                    ImageConstant.expertone,
                                    height: 65,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            "Kriston Watshon",
                                            style: TextStyle(
                                                fontFamily: 'outfit',
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          Text("1w",
                                              style: TextStyle(
                                                  fontFamily: 'outfit',
                                                  fontSize: 13,
                                                  fontWeight: FontWeight.w500)),
                                        ],
                                      ),
                                      Text("Lorem ipsum dolor sit..",
                                          style: TextStyle(
                                              fontFamily: 'outfit',
                                              fontSize: 16,
                                              fontWeight: FontWeight.w400)),
                                    ],
                                  ),
                                  SizedBox(
                                    width: 15,
                                  ),
                                ]),
                              ),
                            )
                          : Padding(
                              padding: const EdgeInsets.only(left: 50.0),
                              child: Container(
                                height: 80,
                                width: _width / 1.2,
                                decoration: BoxDecoration(
                                    // color: Colors.grey,
                                    borderRadius: BorderRadius.circular(15)),
                                child: Row(children: [
                                  Image.asset(
                                    ImageConstant.expertone,
                                    height: 45,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            "Kriston Watshon",
                                            style: TextStyle(
                                                fontFamily: 'outfit',
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          Text("1w",
                                              style: TextStyle(
                                                  fontFamily: 'outfit',
                                                  fontSize: 13,
                                                  fontWeight: FontWeight.w500)),
                                        ],
                                      ),
                                      Container(
                                        width: _width / 1.6,
                                        height: 50,
                                        // color: Colors.amber,
                                        child: Text(
                                            "Lorem ipsum dolor sit.wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww.",
                                            maxLines: 2,
                                            style: TextStyle(
                                                fontFamily: 'outfit',
                                                overflow: TextOverflow.ellipsis,
                                                fontSize: 16,
                                                fontWeight: FontWeight.w400)),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    width: 15,
                                  ),
                                ]),
                              ),
                            ),
                    ),
                  ],
                );
              },
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 50,
                width: _width / 1.3,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  border: Border.all(color: Colors.red, width: 2),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: TextField(
                    cursorColor: ColorConstant.primary_color,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Add Comment",
                        icon: Icon(
                          Icons.emoji_emotions_outlined,
                          color: Colors.grey,
                        )),
                  ),
                ),
              ),
              SizedBox(
                width: 5,
              ),
              CircleAvatar(
                maxRadius: 25,
                backgroundColor: ColorConstant.primary_color,
                child: Center(
                  child: Image.asset(
                    ImageConstant.commentarrow,
                    height: 18,
                  ),
                ),
              )
            ],
          )
        ]),
      ),
    );
  }
}
