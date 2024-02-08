import 'package:flutter/material.dart';

class TagAndHestagScreen extends StatefulWidget {
  const TagAndHestagScreen({Key? key}) : super(key: key);

  @override
  State<TagAndHestagScreen> createState() => _TagAndHestagScreenState();
}

class _TagAndHestagScreenState extends State<TagAndHestagScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        elevation: 0,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back,
            color: Colors.grey,
          ),
        ),
        title: Text(
          "tag people / tag #",
          style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black,
              fontFamily: "outfit",
              fontSize: 20),
        ),
        actions: [],
      ),
      body: Column(
        children: [],
      ),
    );
  }
}

/* 
if (isHeshTegData)
                                Container(
                                  margin: EdgeInsets.only(
                                      top: postText.length >= 100
                                          ? (postText.length + 0)
                                          : 100),
                                  height: imageDataPost?.object?.data != null
                                      ? _height / 3
                                      : _height,
                                  width: _width,
                                  // color: Colors.amber,
                                  child: ListView.builder(
                                    // physics: NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount:
                                        getAllHashtag?.object?.content?.length,
                                    itemBuilder: (context, index) {
                                      return Container(
                                        margin: EdgeInsets.all(10),
                                        height: 70,
                                        width: _width,

                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            border: Border.all(
                                                color: Color(0xffE6E6E6))),
                                        child: GestureDetector(
                                          onTap: () {
                                            super.setState(() {
                                              if (postText.text.isNotEmpty) {
                                                postTexHashContrlloer.add(
                                                    '${getAllHashtag?.object?.content?[index]}');
                                                postText.text = postText.text +
                                                    '' +
                                                    '${getAllHashtag?.object?.content?[index].replaceAll("#", "")}';
                                                postText.selection =
                                                    TextSelection.fromPosition(
                                                  TextPosition(
                                                      offset:
                                                          postText.text.length),
                                                );
                                              }

                                              isHeshTegData = false;

                                              // postText.text = '${postText.text}@${searchUserForInbox1?.object?.content?[index].userName}';
                                            });
                                          },
                                          child: Row(
                                            children: [
                                              Container(
                                                width: _width / 1.6,
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 10),
                                                  child: Text(
                                                    '${getAllHashtag?.object?.content?[index]}',
                                                    style: TextStyle(
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                        // color: Colors.green,
                                      );
                                    },
                                  ),
                                ),
                              if (isTagData)
                                Container(
                                  margin: EdgeInsets.only(
                                      top: postText.length >= 100
                                          ? (postText.length + 0)
                                          : 100),
                                  height: imageDataPost?.object?.data != null
                                      ? _height / 3
                                      : _height,
                                  width: _width,
                                  // color: Colors.amber,
                                  child: ListView.builder(
                                    // physics: NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount: searchUserForInbox1
                                        ?.object?.content?.length,
                                    itemBuilder: (context, index) {
                                      return Container(
                                        margin: EdgeInsets.all(10),
                                        height: 70,
                                        width: _width,
                                        // color: Colors.green,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            border: Border.all(
                                                color: Color(0xffE6E6E6))),
                                        child: GestureDetector(
                                          onTap: () {
                                            super.setState(() {
                                              if (postText.text.isNotEmpty) {
                                                // postText.text =
                                                //     '${postText.text} @${searchUserForInbox1?.object?.content?[index].userName}';
                                                postTexContrlloer.add(
                                                    '@${searchUserForInbox1?.object?.content?[index].userName}');
                                                postText.text = postText.text +
                                                    '' +
                                                    '${searchUserForInbox1?.object?.content?[index].userName}';
                                                postText.selection =
                                                    TextSelection.fromPosition(
                                                  TextPosition(
                                                      offset:
                                                          postText.text.length),
                                                );

                                                print(
                                                    "postText${postText.text.split("@").first}");
                                              }

                                              isTagData = false;
                                            });
                                          },
                                          child: Row(
                                            children: [
                                              searchUserForInbox1
                                                              ?.object
                                                              ?.content?[index]
                                                              .userProfilePic !=
                                                          null &&
                                                      searchUserForInbox1
                                                              ?.object
                                                              ?.content?[index]
                                                              .userProfilePic
                                                              ?.isNotEmpty ==
                                                          true
                                                  ? Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 10),
                                                      child: CircleAvatar(
                                                        radius: 30.0,
                                                        backgroundImage:
                                                            NetworkImage(
                                                                "${searchUserForInbox1?.object?.content?[index].userProfilePic}"),
                                                        backgroundColor:
                                                            Colors.transparent,
                                                      ),
                                                    )
                                                  : Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 10),
                                                      child: CircleAvatar(
                                                        radius: 30.0,
                                                        backgroundImage:
                                                            AssetImage(
                                                                ImageConstant
                                                                    .tomcruse),
                                                        backgroundColor:
                                                            Colors.transparent,
                                                      ),
                                                    ),
                                              Container(
                                                width: _width / 1.6,
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 10),
                                                  child: Text(
                                                    searchUserForInbox1
                                                            ?.object
                                                            ?.content?[index]
                                                            .userName ??
                                                        '',
                                                    style: TextStyle(
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                        // color: Colors.green,
                                      );
                                    },
                                  ),
                                ), */
