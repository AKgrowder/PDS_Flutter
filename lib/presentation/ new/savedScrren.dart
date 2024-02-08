// // ignore_for_file: must_be_immutable

// import 'package:flutter/material.dart';
// import 'package:pds/core/utils/image_constant.dart';
// import 'package:pds/core/utils/sharedPreferences.dart';
// import 'package:pds/presentation/%20new/posttabbar.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class ListSaveScreen extends StatefulWidget {
//   List tabs;
//   dynamic value2;
//   List? image;

//   ListSaveScreen({required this.tabs, required this.value2, this.image});

//   @override
//   State<ListSaveScreen> createState() => _ListSaveScreenState();
// }

// class _ListSaveScreenState extends State<ListSaveScreen>
//     with SingleTickerProviderStateMixin {
//   int? value1;
//   dynamic dataSetup;
//   getUserData() async {
//     final SharedPreferences prefs = await SharedPreferences.getInstance();
//     dataSetup = prefs.getInt(
//       PreferencesKey.tabSelction,
//     );
//     if (dataSetup != null) {
//       dataSetup = await dataSetup;
//     } else {
//       dataSetup = await widget.value2;
//     }
//     super.setState(() {});
//   }

//   void initState() {
//     getUserData();
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return DefaultTabController(
//       length: widget.tabs.length,
//       child: Scaffold(
//           body: Padding(
//         padding: const EdgeInsets.only(top: 10),
//         child: Column(
//           children: [
//             Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: List.generate(
//                     widget.tabs.length,
//                     (index) => GestureDetector(
//                         onTap: () {
//                           dataSetup = null;
//                           value1 = index;

//                           SharedPreferencesFunction(value1 ?? 0);
//                           super.setState(() {});
//                         },
//                         child: Container(
//                           alignment: Alignment.center,
//                           margin: EdgeInsets.only(left: 15),
//                           width: 100,
//                           height: 25,
//                           decoration: ShapeDecoration(
//                             color: value1 == index
//                                 ? ColorConstant.primary_color
//                                 : dataSetup == index
//                                     ?ColorConstant.primary_color
//                                     : Color(0xFFFBD8D9),
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(100),
//                             ),
//                           ),
//                           child: Text(
//                             widget.tabs[index],
//                             style: TextStyle(
//                               color: value1 == index
//                                   ? Colors.white
//                                   : dataSetup == index
//                                       ? Colors.white
//                                       : Color(0xFFF58E92),
//                               fontSize: 14,
//                               fontFamily: "outfit",
//                               fontWeight: FontWeight.w400,
//                             ),
//                           ),
//                         )))),
//             NavagtionPassing()
//           ],
//         ),
//       )),
//     );
//   }

//   SharedPreferencesFunction(int value) async {
//     final SharedPreferences prefs = await SharedPreferences.getInstance();
//     prefs.setInt(PreferencesKey.tabSelction, value);
//   }

//   Widget NavagtionPassing() {
//     if (dataSetup != null) {
//       if (dataSetup == 0) {
//         return Expanded(child: PostTabbarView(image: widget.image ?? []));
//       } else {
//         return BlogScreen();
//       }
//     } else {
//       if (value1 != null) {
//         if (value1 == 0) {
//           return Expanded(child: PostTabbarView(image: widget.image ?? []));
//         } else {
//           return BlogScreen();
//         }
//       }
//     }
//     return Expanded(
//         child: Container(
//       color: Colors.white,
//     ));
//   }
// }

// class BlogScreen extends StatelessWidget {
//   const BlogScreen({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Expanded(
//       child: ListView.builder(
//         physics: NeverScrollableScrollPhysics(),
//         itemCount: 2,
//         itemBuilder: (context, index) {
//           return Padding(
//             padding:
//                 const EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 10),
//             child: Container(
//               height: 130,
//               decoration: BoxDecoration(
                
//                   borderRadius: BorderRadius.circular(15),
//                   border: Border.all(color: Colors.grey, width: 0.5)),
//               child: Padding(
//                 padding: const EdgeInsets.all(5.0),
//                 child: Row(
//                   children: [
//                     Stack(
//                       children: [
//                         Image.asset(
//                           ImageConstant.dummyImage,
//                           width: 135,
//                         ),
//                         Positioned(
//                             top: 8,
//                             left: 8,
//                             child: Container(
//                               height: 25,
//                               width: 25,
//                               decoration: BoxDecoration(
//                                   borderRadius: BorderRadius.circular(5),
//                                   color: Colors.white),
//                               child: Center(
//                                   child: Padding(
//                                 padding: const EdgeInsets.all(5.0),
//                                 child: Image.asset(ImageConstant.save_icon_360),
//                               )),
//                             ))
//                       ],
//                     ),
//                     Expanded(
//                       child: Padding(
//                         padding: const EdgeInsets.only(left: 5),
//                         child: Column(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             Column(
//                               children: [
//                                 Text(
//                                   "Guide to Professional looking packaing desigm",
//                                   style: TextStyle(
//                                       fontSize: 15,
//                                       fontWeight: FontWeight.w600,
//                                       color: Colors.black),
//                                 ),
//                                 Text(
//                                   "Lectus scelerisque vulputate tortor pellentesque ac. Fringilla cras ut facilisis amet imperdiet...",
//                                   style: TextStyle(
//                                       fontSize: 12,
//                                       fontWeight: FontWeight.w600,
//                                       color: Colors.grey),
//                                 ),
//                               ],
//                             ),
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 Text(
//                                   "27th June 2020",
//                                   style: TextStyle(
//                                       fontSize: 9.5,
//                                       fontWeight: FontWeight.w400,
//                                       color: Colors.grey),
//                                 ),
//                                 Text(
//                                   "10:47 pm",
//                                   style: TextStyle(
//                                       fontSize: 9.5,
//                                       fontWeight: FontWeight.w400,
//                                       color: Colors.grey),
//                                 ),
//                                 Text(
//                                   "12.3K Views",
//                                   style: TextStyle(
//                                       fontSize: 9.5,
//                                       fontWeight: FontWeight.w400,
//                                       color: Colors.grey),
//                                 ),
//                                 Image.asset(
//                                   ImageConstant.like_icon_360,
//                                   height: 15,
//                                 ),
//                                 Image.asset(
//                                   ImageConstant.arrowright,
//                                   height: 15,
//                                 ),
//                               ],
//                             )
//                           ],
//                         ),
//                       ),
//                     )
//                   ],
//                 ),
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
