import 'package:flutter/material.dart';
import 'package:pds/core/app_export.dart';
import 'package:pds/presentation/%20new/profileNew.dart';
import 'package:pds/presentation/%20new/stroycommenwoget.dart';

class HomeScreenNew extends StatefulWidget {
  const HomeScreenNew({Key? key}) : super(key: key);

  @override
  State<HomeScreenNew> createState() => _HomeScreenNewState();
}

class _HomeScreenNewState extends State<HomeScreenNew> {
  List a = ['1', '2', '3', '4'];
  List<String> image = [
    ImageConstant.placeholder4,
    ImageConstant.placeholder4,
    ImageConstant.placeholder4,
    ImageConstant.placeholder4,
  ];
  @override
  Widget build(BuildContext context) {
    var _height = MediaQuery.of(context).size.height;
    var _width = MediaQuery.of(context).size.width;
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          backgroundColor: Color(0xffED1C25),
          onPressed: () {},
          child: Image.asset(
            ImageConstant.huge,
            height: 30,
          ),
          elevation: 0,
        ),
        // backgroundColor: Colors.red,
        body: SingleChildScrollView(
          child: Column(
            children: [
              Stack(  
                children: [
                  Container(
                    height: 300 * 10,
                    child: ListView.builder(
                        primary: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: 10,
                        shrinkWrap: true,
                        itemBuilder: ((context, index) => index % 2 == 0
                            ? Transform.translate(
                                offset: Offset(index == 0 ? -300 : -350,
                                    index == 0 ? -90 : 150),
                                child: Container(
                                  height: 240,
                                  width: 150,
                                  margin: EdgeInsets.only(
                                      top: index == 0 ? 0 : 600),
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      //  color: Colors.amber,
                                      boxShadow: [
                                        BoxShadow(
                                            // color: Colors.black,
                                            color: Color(0xffFFE9E9),
                                            blurRadius: 70,
                                            spreadRadius: 150),
                                      ]),
                                ),
                              )
                            : Transform.translate(
                                offset: Offset(index == 0 ? 50 : 290, 90),
                                child: Container(
                                  height: 190,
                                  width: 150,
                                  margin: EdgeInsets.only(top: 400),
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      // color: Colors.red,
                                      boxShadow: [
                                        BoxShadow(
                                            // color: Colors.red,
                                            color: Color(0xffFFE9E9),
                                            blurRadius: 70.0,
                                            spreadRadius: 110),
                                      ]),
                                ),
                              ))),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 16, right: 16),
                    child: Container(
                      height: 300 * 10,
                      // color: Colors.amber,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 50,
                          ),
                          Row(
                            children: [
                              SizedBox(
                                  height: 40,
                                  child:
                                      Image.asset(ImageConstant.splashImage)),
                              Spacer(),
                              Container(
                                height: 50,
                                width: 50,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Color(0xffED1C25)),
                                child: Icon(
                                  Icons.person_add_alt,
                                  color: Colors.white,
                                ),
                              ),
                              SizedBox(
                                width: 17,
                              ),
                              GestureDetector(
                                onTap: (){
                                  Navigator.push(context, MaterialPageRoute(builder: (context)=> ProfileScreen()));
                                },
                                child: SizedBox(
                                  height: 50,
                                  width: 50,
                                  child: CircleAvatar(
                                    backgroundImage:
                                        AssetImage(ImageConstant.placeholder),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          SizedBox(height: 120, child: StoryPage()),
                          Expanded(
                            child: ListView.separated(
                              physics: NeverScrollableScrollPhysics(),
                              primary: true,
                              itemCount: 10,
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                return Container(
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      border: Border.all(
                                          color: Color.fromRGBO(0, 0, 0, 0.25)),
                                      borderRadius: BorderRadius.circular(15)),
                                  // height: 300,
                                  width: _width,
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 15, right: 15),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Container(
                                          // color: Colors.amber,
                                          height: 50,
                                          // width: _width / 1.2,
                                          child: ListTile(
                                            leading: CircleAvatar(
                                              backgroundImage: AssetImage(
                                                ImageConstant.placeholder2,
                                              ),
                                              radius: 25,
                                            ),
                                            title: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                SizedBox(
                                                  height: 6,
                                                ),
                                                Text(
                                                  "Kriston Watshon",
                                                  style: TextStyle(
                                                      fontSize: 20,
                                                      fontFamily: "outfit",
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                Text(
                                                  "08:39 am",
                                                  style: TextStyle(
                                                    fontSize: 12,
                                                    fontFamily: "outfit",
                                                  ),
                                                ),
                                              ],
                                            ),
                                            trailing: Container(
                                              height: 25,
                                              alignment: Alignment.center,
                                              width: 65,
                                              margin:
                                                  EdgeInsets.only(bottom: 5),
                                              decoration: BoxDecoration(
                                                  color: Color(0xffED1C25),
                                                  borderRadius:
                                                      BorderRadius.circular(4)),
                                              child: Text(
                                                'Follow',
                                                style: TextStyle(
                                                    fontFamily: "outfit",
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.white),
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 16),
                                          child: Text(
                                            'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fringilla natoque id aenean.',
                                            style: TextStyle(
                                                fontFamily: "outfit",
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black),
                                          ),
                                        ),
                                        index == 0
                                            ? Container(
                                                margin: EdgeInsets.only(
                                                    left: 14, top: 15,right: 10),
                                                child: Image.asset(
                                                    ImageConstant.Rectangle),
                                              )
                                            : Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 13),
                                                child: Divider(
                                                  thickness: 1,
                                                ),
                                              ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Row(
                                          children: [
                                            SizedBox(
                                              width: 14,
                                            ),
                                            Image.asset(
                                              ImageConstant.thumShup,
                                              height: 20,
                                            ),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            Text(
                                              '1,964',
                                              style: TextStyle(
                                                  fontFamily: "outfit",
                                                  fontSize: 14),
                                            ),
                                            SizedBox(
                                              width: 18,
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.only(top: 1),
                                              child: Image.asset(
                                                ImageConstant.meesage,
                                                height: 14,
                                              ),
                                            ),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            Text(
                                              '135',
                                              style: TextStyle(
                                                  fontFamily: "outfit",
                                                  fontSize: 14),
                                            ),
                                            SizedBox(
                                              width: 18,
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.only(top: 1),
                                              child: Image.asset(
                                                ImageConstant.vector2,
                                                height: 12,
                                              ),
                                            ),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            Text(
                                              '1335',
                                              style: TextStyle(
                                                  fontFamily: "outfit",
                                                  fontSize: 14),
                                            ),
                                            Spacer(),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 1, right: 5),
                                              child: Image.asset(
                                                ImageConstant.savePin,
                                                height: 16,
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                              separatorBuilder:
                                  (BuildContext context, int index) {
                                if (index == 1) {
                                  return Column(
                                    children: [
                                      SizedBox(
                                        height: 30,
                                      ),
                                      Row(
                                        children: [
                                          Container(
                                            margin: EdgeInsets.only(left: 10),
                                            child: Text(
                                              'Experts',
                                              style: TextStyle(
                                                  fontFamily: "outfit",
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black),
                                            ),
                                          ),
                                          Spacer(),
                                          SizedBox(
                                              height: 20,
                                              child: Icon(
                                                Icons.arrow_forward_rounded,
                                                color: Colors.black,
                                              )),
                                          SizedBox(
                                            width: 10,
                                          ),
                                        ],
                                      ),
                                      Container(
                                        height: 230,
                                        width: _width,
                                        child: ListView.builder(
                                          itemCount: image.length,
                                          scrollDirection: Axis.horizontal,
                                          itemBuilder: (context, index) {
                                            return Stack(
                                              children: [
                                                Column(
                                                  children: [
                                                    Container(
                                                      height: 170,
                                                      margin:
                                                          EdgeInsets.all(10),
                                                      decoration: BoxDecoration(
                                                          border: Border.all(
                                                            width: 3,
                                                            color: Color(
                                                                0xffED1C25),
                                                          ),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      14)),
                                                      child: Image.asset(
                                                        image[index],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Positioned(
                                                  top: 15,
                                                  left: 30,
                                                  child: Container(
                                                    height: 24,
                                                    alignment: Alignment.center,
                                                    width: 80,
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.only(
                                                        bottomLeft:
                                                            Radius.circular(8),
                                                        bottomRight:
                                                            Radius.circular(8),
                                                      ),
                                                      color: Color.fromRGBO(
                                                          237, 28, 37, 0.5),
                                                    ),
                                                    child: Row(
                                                      children: [
                                                        SizedBox(
                                                          width: 10,
                                                        ),
                                                        Icon(
                                                          Icons.person_add_alt,
                                                          size: 16,
                                                          color: Colors.white,
                                                        ),
                                                        SizedBox(
                                                          width: 4,
                                                        ),
                                                        Text(
                                                          'Follow',
                                                          style: TextStyle(
                                                              fontFamily:
                                                                  "outfit",
                                                              fontSize: 12,
                                                              color:
                                                                  Colors.white,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                Positioned(
                                                  bottom: 55,
                                                  /*  right: 2,
                                                  left: 2, */
                                                  left: 14,
                                                  child: Align(
                                                    alignment:
                                                        Alignment.bottomRight,
                                                    child: Container(
                                                      alignment:
                                                          Alignment.center,
                                                      height: 25,
                                                      width: 115,
                                                      color: Color(0xffED1C25),
                                                      child: Text(
                                                        'Invite',
                                                        style: TextStyle(
                                                            fontFamily:
                                                                "outfit",
                                                            fontSize: 13,
                                                            color: Colors.white,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Positioned(
                                                  bottom: 70,
                                                  left: 15,
                                                  child: Container(
                                                    height: 40,
                                                    width: 115,
                                                    // color: Colors.amber,
                                                    child: Column(
                                                      children: [
                                                        Row(
                                                          children: [
                                                            SizedBox(
                                                              width: 5,
                                                            ),
                                                            Text(
                                                              "Kriston Watshon",
                                                              style: TextStyle(
                                                                  fontSize: 11,
                                                                  color: Colors
                                                                      .white,
                                                                  fontFamily:
                                                                      "outfit",
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            ),
                                                            SizedBox(
                                                              width: 2,
                                                            ),
                                                            Image.asset(
                                                              ImageConstant
                                                                  .Star,
                                                              height: 11,
                                                            ),
                                                          ],
                                                        ),
                                                        Row(
                                                          children: [
                                                            SizedBox(
                                                              width: 5,
                                                            ),
                                                            SizedBox(
                                                                height: 14,
                                                                child: Image.asset(
                                                                    ImageConstant
                                                                        .beg)),
                                                            SizedBox(
                                                              width: 2,
                                                            ),
                                                            Text(
                                                              'Expertise in....',
                                                              maxLines: 1,
                                                              style: TextStyle(
                                                                  fontFamily:
                                                                      "outfit",
                                                                  fontSize: 11,
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                  color: Colors
                                                                      .white,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            ),
                                                          ],
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            );
                                          },
                                        ),
                                      )
                                    ],
                                  );
                                }
                                if (index == 4) {
                                  print("index check$index");
                                  return Column(
                                    children: [
                                      SizedBox(
                                        height: 30,
                                      ),
                                      Row(
                                        children: [
                                          Container(
                                            margin: EdgeInsets.only(left: 10),
                                            child: Text(
                                              'Blogs',
                                              style: TextStyle(
                                                  fontFamily: "outfit",
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black),
                                            ),
                                          ),
                                          Spacer(),
                                          SizedBox(
                                              height: 20,
                                              child: Icon(
                                                Icons.arrow_forward_rounded,
                                                color: Colors.black,
                                              )),
                                          SizedBox(
                                            width: 10,
                                          ),
                                        ],
                                      ),
                                      Container(
                                        height: _height / 3.23,
                                        width: _width,
                                        margin: EdgeInsets.only(bottom: 15),
                                        child: ListView.builder(
                                          scrollDirection: Axis.horizontal,
                                          itemBuilder: (context, index) {
                                            return Container(
                                              height: 220,
                                              width: _width / 1.6,
                                              margin: EdgeInsets.only(
                                                  left: 10, top: 10),
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(12),
                                                  color: Colors.white,
                                                  border: Border.all(
                                                      // color: Colors.black,
                                                      color: Color(0xffF1F1F1),
                                                      width: 5)),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Image.asset(
                                                    ImageConstant.rendom,
                                                    fit: BoxFit.fill,
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 9, top: 7),
                                                    child: Text(
                                                      'Baluran Wild The Savvanah',
                                                      maxLines: 1,
                                                      style: TextStyle(
                                                          fontSize: 16,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          fontFamily: "outfit",
                                                          fontWeight:
                                                              FontWeight.w400),
                                                    ),
                                                  ),
                                                  Row(
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                left: 10,
                                                                top: 3),
                                                        child: Text(
                                                          '27th June 2020 10:47 pm',
                                                          style: TextStyle(
                                                              fontFamily:
                                                                  "outfit",
                                                              fontSize: 12,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                              color: Color(
                                                                  0xffABABAB)),
                                                        ),
                                                      ),
                                                      Container(
                                                        height: 6,
                                                        width: 7,
                                                        margin: EdgeInsets.only(
                                                            top: 5, left: 2),
                                                        decoration:
                                                            BoxDecoration(
                                                                shape: BoxShape
                                                                    .circle,
                                                                color: Color(
                                                                    0xffABABAB)),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                top: 4,
                                                                left: 1),
                                                        child: Text(
                                                          '12.3K Views',
                                                          style: TextStyle(
                                                              fontSize: 11,
                                                              color: Color(
                                                                  0xffABABAB)),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Row(
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                left: 7,
                                                                top: 4),
                                                        child: index != 0
                                                            ? Icon(Icons
                                                                .favorite_border)
                                                            : Icon(
                                                                Icons.favorite,
                                                                color:
                                                                    Colors.red,
                                                              ),
                                                      ),
                                                      SizedBox(
                                                        width: 15,
                                                      ),
                                                      SizedBox(
                                                        height: 15,
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .only(top: 2),
                                                          child: Image.asset(
                                                              ImageConstant
                                                                  .arrowright),
                                                        ),
                                                      ),
                                                      Spacer(),
                                                      SizedBox(
                                                        height: 35,
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .only(top: 6),
                                                          child: Image.asset(
                                                              ImageConstant
                                                                  .blogunsaveimage),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: 10,
                                                      ),
                                                    ],
                                                  )
                                                ],
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                    ],
                                  );
                                } else {
                                  return SizedBox(
                                    height: 30,
                                  );
                                }
                              },
                            ),
                          ),
                        ],
                      ),

                      //  color: const Color.fromARGB(88, 76, 175, 79),
                    ),
                  )
                ],
              ),
            ],
          ),
        ));
  }
}
