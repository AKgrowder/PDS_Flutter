import 'package:pds/presentation/history_screen/history_details_screen.dart';
import 'package:flutter/material.dart';

import '../../theme/theme_helper.dart';
import '../notifications/notification_screen.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({Key? key}) : super(key: key);

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  @override
  Widget build(BuildContext context) {
    var _height = MediaQuery.of(context).size.height;
    var _width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: theme.colorScheme.onPrimary,
      appBar: AppBar(
        backgroundColor: theme.colorScheme.onPrimary,
        centerTitle: true,
        elevation: 0,
        leading: GestureDetector(
          onTap: () {},
          child: Icon(
            Icons.arrow_back,
            color: Colors.grey,
          ),
        ),
        title: Text(
          "History",
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
            decoration:
                BoxDecoration(border: Border.all(color: Colors.grey.shade200)),
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: GestureDetector(
                      child: Container(
                        height: 50,
                        color: arrNotiyTypeList[0].isSelected
                            ? Color(0xFFED1C25)
                            : Theme.of(context).brightness == Brightness.light
                                ? Colors.white
                                : Colors.black,
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Spacer(),
                              Text(
                                "All",
                                textScaleFactor: 1.0,
                                style: TextStyle(
                                    color: arrNotiyTypeList[0].isSelected
                                        ? Colors.white
                                        : Colors.black,
                                    fontSize: 18,
                                    fontFamily: 'Outfit',
                                    fontWeight: FontWeight.bold),
                              ),
                              Spacer(),
                              Container(
                                width: 1,
                                color: Colors.grey.shade300,
                              ),
                            ],
                          ),
                        ),
                      ),
                      onTap: () {
                        setState(() {
                          updateType();
                          arrNotiyTypeList[0].isSelected = true;
                          print("abcd");
                        });
                      },
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      child: Container(
                          height: 50,
                          color: arrNotiyTypeList[1].isSelected
                              ? Color(0xFFED1C25)
                              : Theme.of(context).brightness == Brightness.light
                                  ? Colors.white
                                  : Colors.black,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Spacer(),
                              Text("Ongoing ",
                                  textScaleFactor: 1.0,
                                  style: TextStyle(
                                      color: arrNotiyTypeList[1].isSelected
                                          ? Colors.white
                                          : Colors.black,
                                      fontSize: 18,
                                      fontFamily: 'Outfit',
                                      fontWeight: FontWeight.bold)),
                              Spacer(),
                              Container(
                                color: Colors.grey.shade300,
                                width: 1,
                              )
                              // Spacer(),
                            ],
                          )),
                      onTap: () {
                        setState(() {
                          updateType();
                          arrNotiyTypeList[1].isSelected = true;
                          print("abcd");
                        });
                      },
                    ),
                  ),
                  Container(
                    height: 1,
                    color: Colors.black12,
                  ),
                  Expanded(
                    child: GestureDetector(
                      child: Container(
                          height: 50,
                          alignment: Alignment.center,
                          color: arrNotiyTypeList[2].isSelected
                              ? Color(0xFFED1C25)
                              : Theme.of(context).brightness == Brightness.light
                                  ? Colors.white
                                  : Colors.black,
                          child: Center(
                            child: Row(
                              children: [
                                const Spacer(),
                                Text("Closed ",
                                    textScaleFactor: 1.0,
                                    style: TextStyle(
                                        color: arrNotiyTypeList[2].isSelected
                                            ? Colors.white
                                            : Colors.black,
                                        fontSize: 18,
                                        fontFamily: 'Outfit',
                                        fontWeight: FontWeight.bold)),
                                Spacer(),
                              ],
                            ),
                          )),
                      onTap: () {
                        setState(() {
                          updateType();
                          arrNotiyTypeList[2].isSelected = true;
                        });
                        print("abcd");
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
         /*  Column(
            children: [
              arrNotiyTypeList[0].isSelected == true
                  ? Container(
                      height: _height / 1.35, 
                      child: ListView.builder(
                        // physics: NeverScrollableScrollPhysics(),
                        itemCount: 2,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return Container(
                            margin:
                                EdgeInsets.only(left: 13, right: 13, top: 5),
                            // height: 175,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(color: Color(0xff989898))),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "06/06/2023, 00:00",
                                        style: TextStyle(
                                          fontFamily: 'outfit',
                                          fontSize: 15,
                                          color: Colors.grey,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                      Spacer(),
                                      index % 2 != 1
                                          ? CircleAvatar(
                                              backgroundColor: Colors.green,
                                              maxRadius: 5,
                                            )
                                          : CircleAvatar(
                                              backgroundColor: Colors.red,
                                              maxRadius: 5,
                                            ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      index % 2 != 1
                                          ? Text('Ongoing')
                                          : Text('Closed'),
                                      SizedBox(
                                        width: 20,
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    "Company Name",
                                    style: TextStyle(
                                      fontFamily: 'outfit',
                                      fontSize: 15,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    "Product Name",
                                    style: TextStyle(
                                      fontFamily: 'outfit',
                                      fontSize: 15,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    "Expert user ID",
                                    style: TextStyle(
                                      fontFamily: 'outfit',
                                      fontSize: 15,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    "Address specific packaging challenges....",
                                    style: TextStyle(
                                      fontFamily: 'outfit',
                                      fontSize: 15,
                                      color: Colors.grey,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                HistoryDetailsScren(),
                                          ));
                                    },
                                    child: Container(
                                      alignment: Alignment.center,
                                      height: 50,
                                      width: 170,
                                      decoration: BoxDecoration(
                                          color: Color(0xFFFFD9DA),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(5)),
                                          border: Border.all(
                                              color: Color(0xFFED1C25))),
                                      child: Text(
                                        "Payment Details",
                                        style: TextStyle(
                                          fontFamily: 'outfit',
                                          fontSize: 15,
                                          color: Color(0xFFED1C25),
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 13,
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    )
                  : SizedBox(),
            ],
          )
       */  ]),
      ),
    );
  }

  updateType() {
    arrNotiyTypeList.forEach((element) {
      element.isSelected = false;
    });
  }
}
// SizedBox(
//                 height: 10,
//               ),
//               Padding(
//                 padding: const EdgeInsets.only(top: 8.0),
//                 child: Container(
//                   height: _height / 4.8,
//                   width: _width / 1.1,
//                   decoration: BoxDecoration(
//                     border: Border.all(color: Colors.grey),
//                     borderRadius: BorderRadius.all(
//                       Radius.circular(10),
//                     ),
//                   ),
//                   child: Column(
//                       mainAxisAlignment: MainAxisAlignment.start,
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Padding(
//                           padding: const EdgeInsets.only(
//                               top: 10.0, left: 10, right: 10),
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.start,
//                             children: [
//                               Text(
//                                 "06/06/2023, 00:00",
//                                 style: TextStyle(
//                                   fontFamily: 'outfit',
//                                   fontSize: 15,
//                                   color: Colors.grey,
//                                   fontWeight: FontWeight.w400,
//                                 ),
//                               ),
//                               Spacer(),
//                               index == 0
//                                   ? CircleAvatar(
//                                       backgroundColor: Colors.green,
//                                       maxRadius: 4,
//                                     )
//                                   : CircleAvatar(
//                                       backgroundColor: Colors.red,
//                                       maxRadius: 4,
//                                     ),
//                               SizedBox(
//                                 width: 5,
//                               ),
//                               index == 0
//                                   ? Text(
//                                       "Ongoing",
//                                       style: TextStyle(
//                                         fontFamily: 'outfit',
//                                         fontSize: 15,
//                                         color: Colors.black,
//                                         fontWeight: FontWeight.w400,
//                                       ),
//                                     )
//                                   : Text(
//                                       "Closed",
//                                       style: TextStyle(
//                                         fontFamily: 'outfit',
//                                         fontSize: 15,
//                                         color: Colors.black,
//                                         fontWeight: FontWeight.w400,
//                                       ),
//                                     )
//                             ],
//                           ),
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.only(left: 10.0),
//                           child: Text(
//                             "Company Name",
//                             style: TextStyle(
//                               fontFamily: 'outfit',
//                               fontSize: 15,
//                               color: Colors.black,
//                               fontWeight: FontWeight.w400,
//                             ),
//                           ),
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.only(left: 10.0),
//                           child: Text(
//                             "Room Name",
//                             style: TextStyle(
//                               fontFamily: 'outfit',
//                               fontSize: 15,
//                               color: Colors.black,
//                               fontWeight: FontWeight.w400,
//                             ),
//                           ),
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.only(left: 10.0),
//                           child: Text(
//                             "Expert user ID",
//                             style: TextStyle(
//                               fontFamily: 'outfit',
//                               fontSize: 20,
//                               color: Colors.black,
//                               fontWeight: FontWeight.w400,
//                             ),
//                           ),
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.only(left: 10.0),
//                           child: Text(
//                             "Address specific packaging challenges....",
//                             style: TextStyle(
//                               fontFamily: 'outfit',
//                               fontSize: 15,
//                               color: Colors.grey,
//                               fontWeight: FontWeight.w400,
//                             ),
//                           ),
//                         ),
//                         GestureDetector(
//                           onTap: () {
//                             Navigator.push(
//                                 context,
//                                 MaterialPageRoute(
//                                   builder: (context) => HistoryDetailsScren(),
//                                 ));
//                           },
//                           child: Padding(
//                             padding: const EdgeInsets.all(8.0),
//                             child: Container(
//                               height: 35,
//                               width: _width / 3,
//                               decoration: BoxDecoration(
//                                   color: Color(0xFFFFD9DA),
//                                   borderRadius:
//                                       BorderRadius.all(Radius.circular(5)),
//                                   border: Border.all(color: Color(0xFFED1C25))),
//                               child: Center(
//                                   child: Text(
//                                 "Payment Details",
//                                 style: TextStyle(
//                                   fontFamily: 'outfit',
//                                   fontSize: 15,
//                                   color: Color(0xFFED1C25),
//                                   fontWeight: FontWeight.w500,
//                                 ),
//                               )),
//                             ),
//                           ),
//                         )
//                       ]),
//                 ),
//               ),
//             ]);