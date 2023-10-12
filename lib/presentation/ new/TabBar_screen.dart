// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:pds/core/utils/image_constant.dart';

class CameraAccsessScreen extends StatefulWidget {
  @override
  State<CameraAccsessScreen> createState() => _CameraAccsessScreenState();
}

class _CameraAccsessScreenState extends State<CameraAccsessScreen> {
  List gridImage = [
    ImageConstant.gridImage,
    ImageConstant.gridImage,
    ImageConstant.gridImage,
    ImageConstant.gridImage,
    ImageConstant.gridImage,
    ImageConstant.gridImage,
    ImageConstant.gridImage,
    ImageConstant.gridImage,
    ImageConstant.gridImage,
  ];
  int indexx = 0;
  bool? isTrue;
  TabController? tabController;
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: GestureDetector(
            onTap: () {
              /* Navigator.pop(context); */
            },
            child: Container(
              margin: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: Color(0xffFFD8D9),
                  borderRadius: BorderRadius.circular(5)),
              child: Icon(
                Icons.arrow_back,
                color: Color(0xffED1C25),
              ),
            ),
          ),
          title: Text(
            "Select Photo",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
          ),
          centerTitle: true,
          actions: [
            Padding(
              padding: const EdgeInsets.all(15),
              child: Image.asset(ImageConstant.camera),
            )
          ],
        ),
        body: Column(
          children: [
            Container(
              height: 50,
              decoration: BoxDecoration(
                  border: Border.all(
                color: Colors.grey,
              )),
              child: TabBar(
                  padding: EdgeInsets.all(5),
                  indicator: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: Color(0xffED1C25)),
                  unselectedLabelColor: Color(0xffED1C25),
                  indicatorColor: Colors.white,
                  controller: tabController,
                  physics: NeverScrollableScrollPhysics(),
                  labelColor: Colors.white,
                  tabs: [
                    Container(
                      // padding: EdgeInsets.all(10),
                      // height: 30,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: Color(0xffED1C25))),
                      child: Center(
                          child: Text(
                        "Camera Roll",
                      )),
                    ),
                    Container(
                      // padding: EdgeInsets.all(10),
                      // height: 30,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: Color(0xffED1C25))),
                      child: Center(
                          child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Uploads Photos",
                          ),
                          GestureDetector(
                              onTap: () {
                                _showPopupMenu(Offset(277.3, 150.2), context);
                              },
                              child: Icon(Icons.keyboard_arrow_down_outlined))
                        ],
                      )),
                    )
                  ]),
            ),
            Expanded(
              child: TabBarView(
                  physics: NeverScrollableScrollPhysics(),
                  controller: tabController,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 45, right: 45),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              ImageConstant.cameraData,
                              height: 50,
                              width: 50,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 10, bottom: 10),
                              child: Text(
                                "Allow Access to your camera roll",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            Text(
                              "Allow access to share photos and videos. You can also change this in your device settings",
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w400,
                                color: Colors.black,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 20),
                              child: Container(
                                height: 40,
                                width: 120,
                                decoration: BoxDecoration(
                                    color: Color(0xffED1C25),
                                    borderRadius: BorderRadius.circular(5)),
                                child: Center(
                                  child: Text(
                                    "Allow Access",
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    indexx == 0
                        ? Padding(
                            padding: const EdgeInsets.only(
                                left: 10, right: 10, top: 10),
                            child: GridView.builder(
                              itemCount: gridImage.length,
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 3,
                                      crossAxisSpacing: 10.0,
                                      mainAxisSpacing: 2),
                              itemBuilder: (context, index) {
                                return Image.asset("${gridImage[index]}");
                              },
                            ),
                          )
                        : ListView.builder(
                            itemCount: 4,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.all(8),
                                child: Column(
                                  children: [
                                    Container(
                                      height: 160,
                                      width: double.infinity,
                                      decoration: BoxDecoration(

                                          // color: Colors.amber,
                                          border: Border.all(
                                              color: Colors.grey, width: 0.5),
                                          borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(10),
                                              topRight: Radius.circular(10))),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                            "PreviewPreviewPreviewPreviewPreviewPreviewPreviewPreviewPreviewPreviewPreviewPreviewPreviewPreviewPreviewPreviewPreviewPreviewPreviewPreviewPreviewPreviewPreviewPreviewPreviewPreviewPreviewPreviewPreviewPreviewPreviewPreviewPreviewPreviewPreviewPreviewPreviewPreviewPreviewPreviewPreviewPreviewPreviewPreviewPreviewPreview"),
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        Container(
                                          height: 40,
                                          width: 40,
                                          decoration: BoxDecoration(
                                              color: Color(0xffFFD2D4),
                                              border: Border.all(
                                                  color: Color(0xffFFE8E8),
                                                  width: 0.5),
                                              borderRadius: BorderRadius.only(
                                                bottomLeft: Radius.circular(10),
                                              )),
                                          child: Center(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Image.asset(
                                                  ImageConstant.pin_icon),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: GestureDetector(
                                            onTap: () {},
                                            child: Container(
                                              height: 40,
                                              // width: double.infinity,
                                              decoration: BoxDecoration(
                                                  color: Color(0xffFFE8E8),
                                                  border: Border.all(
                                                      color: Color(0xffFFE8E8),
                                                      width: 0.5),
                                                  borderRadius:
                                                      BorderRadius.only(
                                                          bottomRight:
                                                              Radius.circular(
                                                                  10))),
                                              child: Align(
                                                alignment: Alignment.centerLeft,
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 10),
                                                  child: Text(
                                                    "Doc.pdf",
                                                    style: TextStyle(
                                                      decoration: TextDecoration
                                                          .underline,
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      color: Colors.black,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              );
                            },
                          )
                  ]),
            )
          ],
        ),
      ),
    );
  }

  void _showPopupMenu(
    Offset offset,
    BuildContext context,
  ) async {
    List<String> ankur = ["Photos", "Documents"];
    double right = offset.dx;
    double top = offset.dy;
    double _width = MediaQuery.of(context).size.width;
    double _height = MediaQuery.of(context).size.height;
    await showMenu(
        context: context,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        position: RelativeRect.fromLTRB(
          right,
          top,
          25,
          0,
        ),
        items: List.generate(
            ankur.length,
            (index) => PopupMenuItem(
                onTap: () {
                  setState(() {
                    indexx = index;
                  });
                  print("indexx--->$indexx");
                },
                child: Container(
                  decoration: BoxDecoration(
                      color: indexx == index
                          ? Color(0xffED1C25)
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(5)),
                  width: 80,
                  height: 40,
                  child: Center(
                    child: Text(
                      ankur[index],
                      style: TextStyle(
                          color: indexx == index ? Colors.white : Colors.black),
                      textScaleFactor: 1.0,
                    ),
                  ),
                ))));
  }
}
