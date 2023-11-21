// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// import '../API/Bloc/CreateRoom_Bloc/CreateRoom_cubit.dart';
// import '../API/Bloc/CreateRoom_Bloc/CreateRoom_state.dart';
// import '../core/utils/color_constant.dart';
// import '../core/utils/image_constant.dart';
// import '../widgets/custom_image_view.dart';

// class CreateRoomScreen extends StatefulWidget {
//   @override
//   State<StatefulWidget> createState() => _CreateRoomScreenState();
// }



// class _CreateRoomScreenState extends State<CreateRoomScreen>
//     with SingleTickerProviderStateMixin {
//   late AnimationController controller;

//   late Animation<double> scaleAnimation;
//   double? rateStar = 5.0;
//   var IsGuestUserEnabled;
//   var GetTimeSplash;
//   @override
//   void initState() {
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
//     roomName.clear();
//     DescriptionText.clear();

//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     var _height = MediaQuery.of(context).size.height;
//     var _width = MediaQuery.of(context).size.width;
//     return BlocConsumer<CreateRoomCubit, CreateRoomState>(
//         listener: (context, state) async {
//       if (state is CreateRoomLoadingState) {
//         Center(
//           child: Container(
//             margin: EdgeInsets.only(bottom: 100),
//             child: ClipRRect(
//               borderRadius: BorderRadius.circular(20),
//               child: Image.asset(ImageConstant.loader,
//                   fit: BoxFit.cover, height: 100.0, width: 100),
//             ),
//           ),
//         );
//       }
//       if (state is CreateRoomLoadedState) {
//         print('this is the data get');
//         SnackBar snackBar = SnackBar(
//           content: Text(state.PublicRoomData.message ?? ""),
//           backgroundColor: ColorConstant.primary_color,
//         );
//         ScaffoldMessenger.of(context).showSnackBar(snackBar);
//         Navigator.pop(context);
//       }
//       if (state is CreateRoomErrorState) {
//         print('CreateRoomErrorState');
//         SnackBar snackBar = SnackBar(
//           content: Text(state.error),
//           backgroundColor: ColorConstant.primary_color,
//         );
//         ScaffoldMessenger.of(context).showSnackBar(snackBar);
//       }
//     }, builder: (context, state) {
//       return Center(
//         child: Material(
//           color: Color.fromARGB(0, 255, 255, 255),
//           child: ScaleTransition(
//             scale: scaleAnimation,
//             child: Container(
//               height: _height / 2,
//               width: _width / 1.17,
//               decoration: ShapeDecoration(
//                 // color: Colors.black,

//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(15.0),
//                 ),
//               ),
//               child: Column(
//                 children: [
//                   Center(
//                     child: Container(
//                       height: 350,
//                       width: _width / 1.2,
//                       decoration: BoxDecoration(
//                         color: Colors.white,
//                         borderRadius: BorderRadius.all(Radius.circular(5)),
//                       ),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Padding(
//                             padding: const EdgeInsets.only(top: 8.0, left: 20),
//                             child: Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 Text(
//                                   "Create Room",
//                                   style: TextStyle(
//                                     fontFamily: 'outfit',
//                                     fontSize: 20,
//                                     color: Colors.black,
//                                     fontWeight: FontWeight.bold,
//                                   ),
//                                 ),
//                                 GestureDetector(
//                                   onTap: () => Navigator.pop(context),
//                                   child: CustomImageView(
//                                     imagePath: ImageConstant.closeimage,
//                                     height: 40,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                           Divider(
//                             color: Colors.grey,
//                           ),
//                           Padding(
//                             padding: const EdgeInsets.only(
//                               left: 5.0,
//                             ),
//                             child: Text(
//                               "Room Name",
//                               style: TextStyle(
//                                 fontFamily: 'outfit',
//                                 fontSize: 15,
//                                 color: Colors.black,
//                                 fontWeight: FontWeight.w400,
//                               ),
//                             ),
//                           ),
//                           Center(
//                             child: Padding(
//                               padding: EdgeInsets.only(
//                                 top: 10.0,
//                                 left: 10,
//                                 right: 20,
//                               ),
//                               child: TextField(
//                                 maxLength: 50,
//                                 controller: roomName,
//                                 cursorColor: Colors.grey,
//                                 inputFormatters: [
//                                   LengthLimitingTextInputFormatter(50)
//                                 ],
//                                 decoration: InputDecoration(
//                                   hintText: 'Room Name',
//                                   counterText: '',
//                                   border: OutlineInputBorder(
//                                       borderRadius: BorderRadius.circular(10),
//                                       borderSide:
//                                           BorderSide(color: Color(0xffDBDBDB))),
//                                 ),
//                               ),
//                             ),
//                           ),
//                           Padding(
//                             padding: const EdgeInsets.only(
//                                 left: 15.0, top: 20, bottom: 10),
//                             child: Text(
//                               "Description",
//                               style: TextStyle(
//                                 fontFamily: 'outfit',
//                                 fontSize: 15,
//                                 color: Colors.black,
//                                 fontWeight: FontWeight.w400,
//                               ),
//                             ),
//                           ),
//                           Center(
//                             child: Container(
//                               height: 80,
//                               width: _width / 1.3,
//                               decoration: BoxDecoration(
//                                   color: Colors.transparent,
//                                   border:
//                                       Border.all(color: Colors.grey.shade300),
//                                   borderRadius: BorderRadius.circular(10)),
//                               child: Padding(
//                                 padding: EdgeInsets.only(top: 0.0, left: 10),
//                                 child: TextField(
//                                   controller: DescriptionText,
//                                   maxLines: 5,
//                                   cursorColor: Colors.grey,
//                                   decoration: InputDecoration(
//                                     hintText:
//                                         'Describe your problem or topic here..',
//                                     border: InputBorder.none,
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ),
//                           Padding(
//                             padding: const EdgeInsets.only(top: 20.0),
//                             child: Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                               children: [
//                                 GestureDetector(
//                                   onTap: () => Navigator.pop(context),
//                                   child: Container(
//                                     height: 43,
//                                     width: _width / 3,
//                                     decoration: BoxDecoration(
//                                         color: Colors.transparent,
//                                         border: Border.all(
//                                             color: Colors.grey.shade400),
//                                         borderRadius:
//                                             BorderRadius.circular(10)),
//                                     child: Center(
//                                         child: Text(
//                                       "Cancel",
//                                       style: TextStyle(
//                                         fontFamily: 'outfit',
//                                         fontSize: 15,
//                                         color: Color(0xFFED1C25),
//                                         fontWeight: FontWeight.w400,
//                                       ),
//                                     )),
//                                   ),
//                                 ),
//                                 GestureDetector(
//                                   onTap: () {
//                                     if (roomName.text == null ||
//                                         roomName.text == '') {
//                                       SnackBar snackBar = SnackBar(
//                                         content: Text('Please Enter Room Name'),
//                                         backgroundColor:
//                                             ColorConstant.primary_color,
//                                       );
//                                       ScaffoldMessenger.of(context)
//                                           .showSnackBar(snackBar);
//                                     } else if (roomName.text.trim().isEmpty ||
//                                         roomName.text.trim() == '') {
//                                       SnackBar snackBar = SnackBar(
//                                         content: Text(
//                                             'Room Name can\'t be just blank spaces'),
//                                         backgroundColor:
//                                             ColorConstant.primary_color,
//                                       );
//                                       ScaffoldMessenger.of(context)
//                                           .showSnackBar(snackBar);
//                                     } else if (DescriptionText.text == null ||
//                                         DescriptionText.text == '') {
//                                       SnackBar snackBar = SnackBar(
//                                         content:
//                                             Text('Please Enter Description'),
//                                         backgroundColor:
//                                             ColorConstant.primary_color,
//                                       );
//                                       ScaffoldMessenger.of(context)
//                                           .showSnackBar(snackBar);
//                                     } else if (DescriptionText.text
//                                             .trim()
//                                             .isEmpty ||
//                                         DescriptionText.text.trim() == '') {
//                                       SnackBar snackBar = SnackBar(
//                                         content: Text(
//                                             'Description can\'t be just blank spaces'),
//                                         backgroundColor:
//                                             ColorConstant.primary_color,
//                                       );
//                                       ScaffoldMessenger.of(context)
//                                           .showSnackBar(snackBar);
//                                     } else {
//                                       var params = {
//                                         "roomQuestion": roomName.text,
//                                         "description": DescriptionText.text,
//                                         "roomType": "PRIVTAE"
//                                       };

//                                       print(params);

//                                       BlocProvider.of<CreateRoomCubit>(context)
//                                           .CreateRoomAPI(params);
//                                       roomName.clear();

//                                       DescriptionText.clear();
//                                     }
//                                     // if (roomName.text == null ||
//                                     //     roomName.text.isEmpty) {
//                                     //   SnackBar snackBar = SnackBar(
//                                     //     content: Text('Please Enter Room Name'),
//                                     //     backgroundColor:
//                                     //         ColorConstant.primary_color,
//                                     //   );
//                                     //   ScaffoldMessenger.of(context)
//                                     //       .showSnackBar(snackBar);
//                                     // }
//                                     // if (DescriptionText.text == null ||
//                                     //     DescriptionText.text.isEmpty) {
//                                     //   SnackBar snackBar = SnackBar(
//                                     //     content:
//                                     //         Text('Please Enter Description'),
//                                     //     backgroundColor:
//                                     //         ColorConstant.primary_color,
//                                     //   );
//                                     //   ScaffoldMessenger.of(context)
//                                     //       .showSnackBar(snackBar);
//                                     // }
//                                   },
//                                   child: Container(
//                                     height: 43,
//                                     width: _width / 3,
//                                     decoration: BoxDecoration(
//                                         color: Color(0xFFED1C25),
//                                         borderRadius:
//                                             BorderRadius.circular(10)),
//                                     child: Center(
//                                         child: Text(
//                                       "Create",
//                                       style: TextStyle(
//                                         fontFamily: 'outfit',
//                                         fontSize: 15,
//                                         color: Colors.white,
//                                         fontWeight: FontWeight.w400,
//                                       ),
//                                     )),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           )
//                         ],
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       );
//     });
//   }
// }
