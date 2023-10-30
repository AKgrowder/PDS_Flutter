// import 'package:flutter/material.dart';
// import 'package:pds/API/Bloc/add_comment_bloc/add_comment_cubit.dart';
// import 'package:pds/API/Bloc/add_comment_bloc/add_comment_state.dart';
// import 'package:pds/core/utils/color_constant.dart';
// import 'package:pds/core/utils/image_constant.dart';
// import 'package:pds/presentation/register_create_account_screen/register_create_account_screen.dart';
// import 'package:pds/theme/theme_helper.dart';

// void _settingModalBottomSheet1(context, index,_width) {
  
//     void _goToElement() {
//       scroll.animateTo((1000 * 20),
//           duration: const Duration(milliseconds: 300), curve: Curves.easeOut);
//     }

//     showModalBottomSheet(
//         context: context,
//         builder: (BuildContext bc) {
//           return Scaffold(
//             resizeToAvoidBottomInset: true,
//             backgroundColor: theme.colorScheme.onPrimary,
//             // appBar: AppBar(
//               leading: GestureDetector(
//                 onTap: () {
//                   Navigator.pop(
//                     context,
//                   );
//                 },
//                 child: Icon(
//                   Icons.arrow_back,
//                   color: Colors.black,
//                 ),
//               ),
//               backgroundColor: Colors.white,
//               elevation: 0,
//               centerTitle: true,
//               title: Text(
//                 "Comments",
//                 style: TextStyle(
//                     fontWeight: FontWeight.bold,
//                     color: Colors.black,
//                     fontFamily: "outfit",
//                     fontSize: 20),
//               ),
//             ),
//             body: BlocConsumer<AddcommentCubit, AddCommentState>(
//               listener: (context, state) async {
//                 if (state is AddCommentLoadedState) {
//                   addCommentModeldata = state.commentdata;
//                 }

//                 if (state is AddCommentErrorState) {
//                   SnackBar snackBar = SnackBar(
//                     content: Text(state.error),
//                     backgroundColor: ColorConstant.primary_color,
//                   );
//                   ScaffoldMessenger.of(context).showSnackBar(snackBar);
//                 }

//                 if (state is AddnewCommentLoadedState) {
//                   addcomment.clear();
//                   Object1 object =
//                       Object1.fromJson(state.addnewCommentsModeldata['object']);

//                   addCommentModeldata?.object?.add(object);
//                   print(
//                       "cghfdgfgghgh->${addCommentModeldata?.object?.last.runtimeType}");
//                   _goToElement();
//                 }
//               },
//               builder: (context, state) {
//                 if (state is AddCommentLoadingState) {
//                   return Center(
//                     child: Container(
//                       margin: EdgeInsets.only(bottom: 100),
//                       child: ClipRRect(
//                         borderRadius: BorderRadius.circular(20),
//                         child: Image.asset(ImageConstant.loader,
//                             fit: BoxFit.cover, height: 100.0, width: 100),
//                       ),
//                     ),
//                   );
//                 }
//                 return Stack(
//                   children: [
//                     SingleChildScrollView(
//                       physics: BouncingScrollPhysics(),
//                       child: Column(
//                         children: [
//                           Container(
//                             child: Row(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Padding(
//                                     padding: EdgeInsets.only(left: 16),
//                                     child: CustomImageView(
//                                       radius: BorderRadius.circular(50),
//                                       url:
//                                           '${AllGuestPostRoomData?.object?.content?[index].userProfilePic}',
//                                       fit: BoxFit.fill,
//                                       height: 50,
//                                       width: 50,
//                                     ),
//                                   ),
//                                   SizedBox(
//                                     width: 10,
//                                   ),
//                                   Expanded(
//                                     child: Column(
//                                       // crossAxisAlignment: CrossAxisAlignment.start,
//                                       // mainAxisAlignment: MainAxisAlignment.start,
//                                       children: [
//                                         Row(
//                                           children: [
//                                             Text(
//                                               '${AllGuestPostRoomData?.object?.content?[index].postUserName}',
//                                               style: TextStyle(
//                                                   fontFamily: 'outfit',
//                                                   fontSize: 18,
//                                                   fontWeight: FontWeight.bold),
//                                             ),
//                                             SizedBox(
//                                               width: 5,
//                                             ),
//                                             Text("1w",
//                                                 // customFormat(parsedDateTime),
//                                                 style: TextStyle(
//                                                     fontFamily: 'outfit',
//                                                     fontSize: 13,
//                                                     fontWeight:
//                                                         FontWeight.w500)),
//                                           ],
//                                         ),
//                                         Padding(
//                                           padding:
//                                               const EdgeInsets.only(bottom: 5),
//                                           child: Align(
//                                             alignment: Alignment.centerLeft,
//                                             child: Text(
//                                                 ' ${AllGuestPostRoomData?.object?.content?[index].description}',
//                                                 // maxLines: 2,
//                                                 style: TextStyle(
//                                                     fontFamily: 'outfit',
//                                                     // overflow: TextOverflow.ellipsis,
//                                                     fontSize: 16,
//                                                     fontWeight:
//                                                         FontWeight.w400)),
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                 ]),
//                           ),
//                           Padding(
//                             padding: const EdgeInsets.only(bottom: 70),
//                             child: ListView.builder(
//                               // physics: NeverScrollableScrollPhysics(),
//                               itemCount: addCommentModeldata?.object?.length,
//                               shrinkWrap: true,
//                               controller: scroll,
//                               itemBuilder: (context, index) {
//                                 DateTime parsedDateTime = DateTime.parse(
//                                     '${addCommentModeldata?.object?[index].createdAt ?? ""}');

//                                 return Column(
//                                   mainAxisAlignment: MainAxisAlignment.start,
//                                   children: [
//                                     Padding(
//                                       padding: EdgeInsets.only(
//                                           top: 15.0, left: 35.0),
//                                       child: Container(
//                                         // height: 80,
//                                         // width: _width / 1.2,
//                                         decoration: BoxDecoration(
//                                             // color: Colors.grey,
//                                             borderRadius:
//                                                 BorderRadius.circular(15)),
//                                         child: Row(
//                                             crossAxisAlignment:
//                                                 CrossAxisAlignment.start,
//                                             children: [
//                                               addCommentModeldata
//                                                           ?.object?[index]
//                                                           .profilePic ==
//                                                       null
//                                                   ? CustomImageView(
//                                                       radius:
//                                                           BorderRadius.circular(
//                                                               50),
//                                                       imagePath:
//                                                           ImageConstant.pdslogo,
//                                                       fit: BoxFit.fill,
//                                                       height: 35,
//                                                       width: 35,
//                                                     )
//                                                   : CustomImageView(
//                                                       radius:
//                                                           BorderRadius.circular(
//                                                               50),
//                                                       url:
//                                                           "${addCommentModeldata?.object?[index].profilePic}",
//                                                       fit: BoxFit.fill,
//                                                       height: 35,
//                                                       width: 35,
//                                                     ),
//                                               SizedBox(
//                                                 width: 10,
//                                               ),
//                                               Column(
//                                                 crossAxisAlignment:
//                                                     CrossAxisAlignment.start,
//                                                 mainAxisAlignment:
//                                                     MainAxisAlignment.center,
//                                                 children: [
//                                                   Row(
//                                                     children: [
//                                                       Text(
//                                                         "${addCommentModeldata?.object?[index].userName}",
//                                                         style: TextStyle(
//                                                             fontFamily:
//                                                                 'outfit',
//                                                             fontSize: 18,
//                                                             fontWeight:
//                                                                 FontWeight
//                                                                     .bold),
//                                                       ),
//                                                       SizedBox(
//                                                         width: 5,
//                                                       ),
//                                                       Text(
//                                                           // "1w",
//                                                           customFormat(
//                                                               parsedDateTime),
//                                                           style: TextStyle(
//                                                               fontFamily:
//                                                                   'outfit',
//                                                               fontSize: 13,
//                                                               fontWeight:
//                                                                   FontWeight
//                                                                       .w500)),
//                                                     ],
//                                                   ),
//                                                   Container(
//                                                     width: _width / 1.4,
//                                                     // height: 50,
//                                                     // color: Colors.amber,
//                                                     child: Text(
//                                                         "${addCommentModeldata?.object?[index].comment}",
//                                                         // maxLines: 2,

//                                                         style: TextStyle(
//                                                             fontFamily:
//                                                                 'outfit',
//                                                             overflow:
//                                                                 TextOverflow
//                                                                     .visible,
//                                                             fontSize: 16,
//                                                             fontWeight:
//                                                                 FontWeight
//                                                                     .w400)),
//                                                   ),
//                                                 ],
//                                               ),
//                                               SizedBox(
//                                                 width: 15,
//                                               ),
//                                             ]),
//                                       ),
//                                     ),
//                                   ],
//                                 );
//                               },
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                     Align(
//                       alignment: Alignment.bottomCenter,
//                       child: Container(
//                         height: 70,
//                         color: Colors.white,
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             Container(
//                               height: 50,
//                               width: _width / 1.3,
//                               decoration: BoxDecoration(
//                                   borderRadius: BorderRadius.circular(25),
//                                   border: Border.all(
//                                     color: Colors.red,
//                                     width: 2,
//                                   ),
//                                   color: Colors.white),
//                               child: Padding(
//                                 padding: const EdgeInsets.only(left: 10.0),
//                                 child: TextField(
//                                   controller: addcomment,
//                                   cursorColor: ColorConstant.primary_color,
//                                   decoration: InputDecoration(
//                                       border: InputBorder.none,
//                                       hintText: "Add Comment",
//                                       icon: Icon(
//                                         Icons.emoji_emotions_outlined,
//                                         color: Colors.grey,
//                                       )),
//                                 ),
//                               ),
//                             ),
//                             SizedBox(
//                               width: 8,
//                             ),
//                             GestureDetector(
//                               onTap: () {
//                                 if (User_ID == null) {
//                                   Navigator.of(context).push(MaterialPageRoute(
//                                       builder: (context) =>
//                                           RegisterCreateAccountScreen()));
//                                 } else if (addcomment.text == null ||
//                                     addcomment.text.isEmpty) {
//                                   SnackBar snackBar = SnackBar(
//                                     content: Text('Please Add Comment'),
//                                     backgroundColor:
//                                         ColorConstant.primary_color,
//                                   );
//                                   ScaffoldMessenger.of(context)
//                                       .showSnackBar(snackBar);
//                                 } else {
//                                   Map<String, dynamic> params = {
//                                     "comment": addcomment.text,
//                                     "postUid": '${AllGuestPostRoomData?.object?.content?[index].postUid}',
//                                   };

//                                   BlocProvider.of<AddcommentCubit>(context)
//                                       .AddPostApiCalling(context, params);
//                                 }
//                               },
//                               child: CircleAvatar(
//                                 maxRadius: 25,
//                                 backgroundColor: ColorConstant.primary_color,
//                                 child: Center(
//                                   child: Image.asset(
//                                     ImageConstant.commentarrow,
//                                     height: 18,
//                                   ),
//                                 ),
//                               ),
//                             )
//                           ],
//                         ),
//                       ),
//                     ),
//                   ],
//                   alignment: Alignment.topRight,
//                 );
//               },
//             ),
//           );
//         });
//   }