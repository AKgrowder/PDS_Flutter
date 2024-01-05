// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';

// import '../core/utils/image_constant.dart';
// import '../widgets/custom_image_view.dart';

// class InviteDilogScreen extends StatefulWidget {
//   @override
//   State<StatefulWidget> createState() => _InviteDilogScreenState();
// }

// TextEditingController RateUSController = TextEditingController();
// TextEditingController controllerr = TextEditingController();

// class _InviteDilogScreenState extends State<InviteDilogScreen>
//     with SingleTickerProviderStateMixin {
//   late AnimationController controller;
//   late Animation<double> scaleAnimation;

//   double? rateStar = 5.0;
//   var IsGuestUserEnabled;
//   var GetTimeSplash;
//   @override
//   void initState() {
//     // setUserRating();
//     super.initState();

//     controller =
//         AnimationController(vsync: this, duration: Duration(milliseconds: 450));
//     scaleAnimation =
//         CurvedAnimation(parent: controller, curve: Curves.elasticInOut);

//     controller.addListener(() {
//       setState(() {});
//     });

//     controller.forward();
//   }

//   var userRating;

//   @override
//   void dispose() {
//     // TODO: implement dispose
//     RateUSController.clear();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     var _height = MediaQuery.of(context).size.height;
//     var _width = MediaQuery.of(context).size.width;
//     return Center(
//       child: Material(
//         color: Color.fromARGB(0, 255, 255, 255),
//         child: ScaleTransition(
//           scale: scaleAnimation,
//           child: Container(
//             height: _height / 2,
//             width: _width / 1.17,
//             decoration: ShapeDecoration(
//               // color: Colors.black,

//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(15.0),
//               ),
//             ),
//             child: Column(
//               children: [
//                 Center(
//                   child: Container(
//                     height: 270,
//                     width: _width / 1.25,
//                     decoration: BoxDecoration(
//                       color: Colors.white,
//                       borderRadius: BorderRadius.all(Radius.circular(5)),
//                     ),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Padding(
//                           padding: const EdgeInsets.only(top: 8.0, left: 20),
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Text(
//                                 "Invite",
//                                 style: TextStyle(
//                                   fontFamily: 'outfit',
//                                   fontSize: 20,
//                                   color: Colors.black,
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                               ),
//                               GestureDetector(
//                                 onTap: () => Navigator.pop(context),
//                                 child: CustomImageView(
//                                   imagePath: ImageConstant.closeimage,
//                                   height: 40,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                         Divider(
//                           color: Colors.grey,
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.only(left: 22.0),
//                           child: Text(
//                             "Enter Email ID s",
//                             style: TextStyle(
//                               fontFamily: 'outfit',
//                               fontSize: 15,
//                               color: Colors.black,
//                               fontWeight: FontWeight.w500,
//                             ),
//                           ),
//                         ),
//                         SizedBox(
//                           height: 5,
//                         ),
//                         Center(
//                           child: Container(
//                             height: 40,
//                             width: _width / 1.45,
//                             decoration: BoxDecoration(
//                                 border: Border.all(color: Colors.grey),
//                                 borderRadius: BorderRadius.circular(5)),
//                             child: Padding(
//                               padding:
//                                   const EdgeInsets.only(top: 8.0, left: 10),
//                               child: TextField(
//                                 cursorColor: Colors.grey,
//                                 controller: controllerr,
//                                 decoration: InputDecoration(
//                                     border: InputBorder.none,
//                                     hintText: 'Email'),
//                               ),
//                             ),
//                           ),
//                         ),
//                         SizedBox(
//                           height: 30,
//                         ),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                           children: [
//                             GestureDetector(
//                               onTap: () => Navigator.pop(context),
//                               child: Container(
//                                 height: 43,
//                                 width: _width / 3.5,
//                                 decoration: BoxDecoration(
//                                     color: Colors.transparent,
//                                     border:
//                                         Border.all(color: Colors.grey.shade400),
//                                     borderRadius: BorderRadius.circular(10)),
//                                 child: Center(
//                                     child: Text(
//                                   "Cancel",
//                                   style: TextStyle(
//                                     fontFamily: 'outfit',
//                                     fontSize: 15,
//                                     color: ColorConstant.primary_color,
//                                     fontWeight: FontWeight.w400,
//                                   ),
//                                 )),
//                               ),
//                             ),
//                             Container(
//                               height: 43,
//                               width: _width / 3.5,
//                               decoration: BoxDecoration(
//                                   color: ColorConstant.primary_color,
//                                   borderRadius: BorderRadius.circular(10)),
//                               child: Center(
//                                   child: Text(
//                                 "Invite",
//                                 style: TextStyle(
//                                   fontFamily: 'outfit',
//                                   fontSize: 15,
//                                   color: Colors.white,
//                                   fontWeight: FontWeight.w400,
//                                 ),
//                               )),
//                             ),
//                           ],
//                         ),
//                         SizedBox(
//                           height: 8,
//                         ),
//                         Divider(
//                           color: Colors.black,
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.only(left: 10.0),
//                           child: Row(
//                             children: [
//                               GestureDetector(
//                                 onTap: () {
//                                   Clipboard.setData(new ClipboardData(
//                                           text: controllerr.text))
//                                       .then((_) {
//                                     controllerr.clear();
//                                     ScaffoldMessenger.of(context).showSnackBar(
//                                         SnackBar(
//                                             content: Text(
//                                                 'Copied to your clipboard !')));
//                                   });
//                                 },
//                                 child: CustomImageView(
//                                   imagePath: ImageConstant.copyimage,
//                                   height: 20,
//                                 ),
//                               ),
//                               Padding(
//                                 padding: const EdgeInsets.all(8.0),
//                                 child: Text(
//                                   "Copy Link",
//                                   style: TextStyle(
//                                     fontFamily: 'outfit',
//                                     fontSize: 15,
//                                     color:ColorConstant.primary_color,
//                                     fontWeight: FontWeight.w400,
//                                   ),
//                                 ),
//                               )
//                             ],
//                           ),
//                         )
//                       ],
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
