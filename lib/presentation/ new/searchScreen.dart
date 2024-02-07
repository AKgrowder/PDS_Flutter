import 'package:flutter/material.dart';
import 'package:pds/core/utils/color_constant.dart';
import 'package:pds/core/utils/image_constant.dart';

class NewExpertScreen extends StatefulWidget {
  const NewExpertScreen({Key? key}) : super(key: key);

  @override
  State<NewExpertScreen> createState() => _NewExpertScreenState();
}

class _NewExpertScreenState extends State<NewExpertScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  void initState() {
    super.initState();
    _tabController = TabController(
        length: 2, vsync: this); // Specify the number of tabs you want
  }

  @override
  Widget build(BuildContext context) {
    var _height = MediaQuery.of(context).size.height;
    var _width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
          backgroundColor: Colors.white,
          body: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              Container(
                height: 40,
                width: _width / 1.1,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Color(0xFFF0F0F0)),
                child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 10,
                      ),
                      Center(
                        child: Icon(
                          Icons.search,
                          size: 30,
                          color: Colors.grey,
                        ),
                      ),
                      Container(
                        width: 280,
                        // color: Colors.amber,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: TextField(
                            cursorColor: Colors.black,
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "Karenne..."),
                          ),
                        ),
                      ),
                      Spacer(),
                      Center(
                          child: Icon(
                        Icons.close,
                        size: 30,
                        color: Colors.grey,
                      )),
                      SizedBox(
                        width: 10,
                      )
                    ]),
              ),
              SizedBox(
                height: 10,
              ),
              Divider(
                color: Colors.grey,
              ),
              SizedBox(
                height: 10,
              ),
              TabBar(
                indicatorColor: Colors.transparent,
                controller: _tabController,
                tabs: [
                  Container(
                      height: 35,
                      width: 120,
                      decoration: BoxDecoration(
                          color: ColorConstant.primary_color,
                          borderRadius: BorderRadius.circular(20)),
                      child: Tab(
                        child: Text(
                          "All",
                          style: TextStyle(
                            fontFamily: 'outfit',
                            fontSize: 18,
                          ),
                        ),
                      )),
                  Container(
                    height: 35,
                    width: 120,
                    decoration: BoxDecoration(
                        color: Color(0xFFFBD8D9),
                        borderRadius: BorderRadius.circular(20)),
                    child: Tab(
                      child: Text(
                        "Experts",
                        style: TextStyle(color: Color(0xFFF58E93)),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 15,
              ),
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    ListView.builder(
                      itemCount: 5,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                top: 10,
                              ),
                              child: Container(
                                height: 60,
                                width: _width / 1.1,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(color: Colors.grey)),
                                child: Row(children: [
                                  Image.asset(
                                    ImageConstant.expertone,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    "Karennne",
                                    style: TextStyle(
                                      fontFamily: 'outfit',
                                      fontSize: 18,
                                    ),
                                  )
                                ]),
                              ),
                            )
                          ],
                        );
                      },
                    ),
                    // Your content for Tab 2
                    ListView.builder(
                      itemCount: 5,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                top: 10,
                              ),
                              child: Container(
                                height: 60,
                                width: _width / 1.1,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(color: Colors.grey)),
                                child: Row(children: [
                                  Image.asset(
                                    ImageConstant.expertone,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    "Karennne",
                                    style: TextStyle(
                                      fontFamily: 'outfit',
                                      fontSize: 18,
                                    ),
                                  )
                                ]),
                              ),
                            )
                          ],
                        );
                      },
                    ),
                    // Your content for Tab 3
                  ],
                ),
              ),
            ],
          )),
    );
  }
}
