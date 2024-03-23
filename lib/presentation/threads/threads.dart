// import 'package:flutter/material.dart';

// import '../../core/utils/image_constant.dart';
// import '../../theme/theme_helper.dart';
// import '../../widgets/custom_image_view.dart';
 

// class ThreadsScreen extends StatefulWidget {
//   const ThreadsScreen({Key? key}) : super(key: key);

//   @override
//   State<ThreadsScreen> createState() => _ThreadsScreenState();
// }

// class _ThreadsScreenState extends State<ThreadsScreen> {
//   @override
//   Widget build(BuildContext context) {
//     double _width = MediaQuery.of(context).size.width;
//     double _height = MediaQuery.of(context).size.height;
//     return Scaffold(
//       backgroundColor: theme.colorScheme.onPrimary,
//       appBar: AppBar(
//         centerTitle: true,
//         backgroundColor: theme.colorScheme.onPrimary,
//         elevation: 0,
//         title: Row(
//           mainAxisAlignment: MainAxisAlignment.start,
//           children: [
//             Icon(
//               Icons.arrow_back,
//               color: Colors.grey,
//             ),
//             SizedBox(
//               width: 120,
//             ),
//             Text(
//               " Threads",
//               style: TextStyle(
//                 fontFamily: 'outfit',
//                 fontSize: 23,
//                 color: Colors.black,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//           ],
//         ),
//       ),
//       body: SingleChildScrollView(
//         child: Column(children: [
//           ListView.builder(
//             itemCount: aa.length,
//             shrinkWrap: true,
//             physics: NeverScrollableScrollPhysics(),
//             itemBuilder: (context, index) {
//               return Padding(
//                 padding:
//                     const EdgeInsets.symmetric(horizontal: 35, vertical: 5),
//                 child: GestureDetector(
//                   onTap: () {},
//                   child: Container(
//                     // height: demo.contains(index) ? null: height / 16,
//                     width: _width / 1.2,
//                     decoration: BoxDecoration(
//                         border: Border.all(
//                             color: const Color(0XFFD9D9D9), width: 2),
//                         borderRadius: BorderRadius.circular(5)),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             Padding(
//                               padding: EdgeInsets.only(
//                                   left: 8.0, top: 10, bottom: 10),
//                               child: Row(
//                                 mainAxisAlignment:
//                                     MainAxisAlignment.spaceBetween,
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Padding(
//                                     padding: const EdgeInsets.only(
//                                         left: 2.0, top: 5),
//                                     child: CircleAvatar(
//                                         backgroundColor: Colors.black,
//                                         maxRadius: 3),
//                                   ),
//                                   SizedBox(
//                                     width: 3,
//                                   ),
//                                   Text(
//                                     aa[index],
//                                     maxLines: 2,
//                                     textScaleFactor: 1.0,
//                                     style: TextStyle(
//                                         fontWeight: FontWeight.bold,
//                                         color: Colors.black,
//                                         fontFamily: "outfit",
//                                         fontSize: 14),
//                                   ),
//                                   GestureDetector(
//                                     onTap: () {
//                                       super.setState(() {
//                                         if (image?.contains(index) ?? false) {
//                                           image?.remove(index);
//                                         } else {
//                                           image?.add(index);
//                                         }
//                                       });
//                                     },
//                                     child: (image?.contains(index) ?? false)
//                                         ? CustomImageView(
//                                             imagePath: ImageConstant
//                                                 .unselectedimgVector,
//                                             height: 20,
//                                           )
//                                         : CustomImageView(
//                                             imagePath:
//                                                 ImageConstant.selectedimage,
//                                             height: 20,
//                                           ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ],
//                         ),
//                         Row(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           mainAxisAlignment: MainAxisAlignment.start,
//                           children: [
//                             Padding(
//                               padding: const EdgeInsets.only(left: 10),
//                               child: CustomImageView(
//                                 imagePath: ImageConstant.tomcruse,
//                                 height: 20,
//                               ),
//                             ),
//                             Text(
//                               tomcruse[index],
//                               style: TextStyle(
//                                   fontWeight: FontWeight.w400,
//                                   color: Colors.black,
//                                   fontFamily: "outfit",
//                                   fontSize: 14),
//                             ),
//                           ],
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.only(left: 8.0),
//                           child: Text(
//                             threadsss[index],
//                             style: TextStyle(
//                                 fontWeight: FontWeight.w400,
//                                 color: Colors.black,
//                                 fontFamily: "outfit",
//                                 fontSize: 12),
//                           ),
//                         ),
//                         Divider(
//                           color: Colors.black,
//                         ),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceAround,
//                           children: [
//                             Padding(
//                               padding: const EdgeInsets.only(right: 30.0),
//                               child: Text(
//                                 comment[index],
//                                 style: TextStyle(
//                                     fontWeight: FontWeight.w400,
//                                     color: Colors.black,
//                                     fontFamily: "outfit",
//                                     fontSize: 15),
//                               ),
//                             ),
//                             Padding(
//                               padding: const EdgeInsets.only(left: 30.0),
//                               child: Text(
//                                 commentss[index],
//                                 style: TextStyle(
//                                     fontWeight: FontWeight.w400,
//                                     color: Colors.grey,
//                                     fontFamily: "outfit",
//                                     fontSize: 15),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               );
//             },
//           ),
//         ]),
//       ),
//     );
//   }
// }
