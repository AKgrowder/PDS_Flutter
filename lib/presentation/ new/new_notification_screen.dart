// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:intl/intl.dart';
// import 'package:pds/API/Bloc/Invitation_Bloc/Invitation_cubit.dart';
// import 'package:pds/API/Model/InvitationModel/Invitation_Model.dart';
// import 'package:pds/core/utils/color_constant.dart';
// import 'package:pds/presentation/room_members/room_members_screen.dart';
// import 'package:pds/widgets/custom_image_view.dart';

// import '../../API/Bloc/Invitation_Bloc/Invitation_state.dart';
// import '../../core/utils/image_constant.dart';

// class NotificationScreen extends StatefulWidget {
//   const NotificationScreen({Key? key}) : super(key: key);

//   @override
//   State<NotificationScreen> createState() => _NotificationScreenState();
// }

// class NotificationModel {
//   int id;
//   String title;
//   bool isSelected;

//   NotificationModel(this.id, this.title, {this.isSelected = false});
// }

// class _NotificationScreenState extends State<NotificationScreen>
//     with SingleTickerProviderStateMixin {
//   TabController? _tabController;

//   List arrNotiyTypeList = [
//     NotificationModel(
//       1,
//       " ",
//       isSelected: true,
//     ),
//     NotificationModel(
//       2,
//       " ",
//     ),
//     NotificationModel(
//       3,
//       " ",
//     )
//   ];

//   String customFormat(DateTime date) {
//     String day = date.day.toString();
//     String month = _getMonthName(date.month);
//     String year = date.year.toString();
//     String time = DateFormat('h:mm a').format(date);

//     String formattedDate = '$day$month $year $time';
//     return formattedDate;
//   }

//   String _getMonthName(int month) {
//     switch (month) {
//       case 1:
//         return 'st January';
//       case 2:
//         return 'nd February';
//       case 3:
//         return 'rd March';
//       case 4:
//         return 'th April';
//       case 5:
//         return 'th May';
//       case 6:
//         return 'th June';
//       case 7:
//         return 'th July';
//       case 8:
//         return 'th August';
//       case 9:
//         return 'th September';
//       case 10:
//         return 'th October';
//       case 11:
//         return 'th November';
//       case 12:
//         return 'th December';
//       default:
//         return '';
//     }
//   }

//   InvitationModel? InvitationRoomData;
//   var Show_NoData_Image = false;

//   @override
//   Widget build(BuildContext context) {
//     var _height = MediaQuery.of(context).size.height;
//     var _width = MediaQuery.of(context).size.width;
//      appBar: AppBar(
//             elevation: 0,
//             backgroundColor: Colors.transparent,
//             actions: [
//               Transform.translate(
//                 offset: Offset(
//                   200,
//                   -110,
//                 ),
//                 child: Container(
//                   height: 240,
//                   width: 100,
//                   decoration: BoxDecoration(shape: BoxShape.circle, boxShadow: [
//                     BoxShadow(
//                         // color: Colors.black,
//                         color: Color(0xffFFE9E9),
//                         blurRadius: 90,
//                         spreadRadius: 150),
//                   ]),
//                 ),
//               )
//             ],
//             title: Text(
//               "Notifications",
//               style: TextStyle(
//                 // fontFamily: 'outfit',
//                 color: Colors.black, fontWeight: FontWeight.bold,
//                 fontSize: 25,
//               ),
//             ),
//             centerTitle: true,
//           );
//     return BlocConsumer<InvitationCubit, InvitationState>(
//         listener: (context, state) async {
//       if (state is InvitationErrorState) {
//         print('error state');
//         if (state.error == "not found") {
//           print("Show Image");
//           Show_NoData_Image = true;
//         } else {
//           SnackBar snackBar = SnackBar(
//             content: Text(state.error),
//             backgroundColor: ColorConstant.primary_color,
//           );
//           ScaffoldMessenger.of(context).showSnackBar(snackBar);
//         }
//       }

//       if (state is InvitationLoadingState) {
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
//       if (state is InvitationLoadedState) {
//         InvitationRoomData = state.InvitationRoomData;
//         print(InvitationRoomData?.message);
//         if (InvitationRoomData?.object?.length == null ||
//             InvitationRoomData?.object?.length == 0) {
//           Show_NoData_Image = true;
//         } else {
//           Show_NoData_Image = false;
//         }
//         // setState(() {});
//       }
//       if (state is AcceptRejectInvitationModelLoadedState) {
//         SnackBar snackBar = SnackBar(
//           content: Text(state.acceptRejectInvitationModel.message.toString()),
//           backgroundColor: ColorConstant.primary_color,
//         );
//         ScaffoldMessenger.of(context).showSnackBar(snackBar);
//         BlocProvider.of<InvitationCubit>(context).InvitationAPI(context);
//       }
//     }, builder: (context, state) {
//       return DefaultTabController(
//         length: 3,
//         child: Scaffold(
//             backgroundColor: Colors.white,
//             body: SafeArea(
//               child: SingleChildScrollView(
//                 child: Column(
//                   children: [
//                     Stack(
//                       children: [
//                         Container(
//                           height: _height / 1,
//                           child: ListView.builder(
//                               primary: true,
//                               physics: NeverScrollableScrollPhysics(),
//                               itemCount: 5,
//                               shrinkWrap: true,
//                               itemBuilder: ((context, index) => index % 2 == 0
//                                   ? Transform.translate(
//                                       offset: Offset(index == 0 ? -300 : -350,
//                                           index == 0 ? -90 : 150),
//                                       child: Container(
//                                         height: 240,
//                                         width: 150,
//                                         margin: EdgeInsets.only(
//                                             top: index == 0 ? 0 : 600),
//                                         decoration: BoxDecoration(
//                                             shape: BoxShape.circle,
//                                             //  color: Colors.amber,
//                                             boxShadow: [
//                                               BoxShadow(
//                                                   // color: Colors.black,
//                                                   color: Color(0xffFFE9E9),
//                                                   blurRadius: 70,
//                                                   spreadRadius: 150),
//                                             ]),
//                                       ),
//                                     )
//                                   : Transform.translate(
//                                       offset: Offset(index == 0 ? 50 : 290, 90),
//                                       child: Container(
//                                         height: 190,
//                                         width: 150,
//                                         margin: EdgeInsets.only(top: 400),
//                                         decoration: BoxDecoration(
//                                             shape: BoxShape.circle,
//                                             // color: Colors.red,
//                                             boxShadow: [
//                                               BoxShadow(
//                                                   // color: Colors.red,
//                                                   color: Color(0xffFFE9E9),
//                                                   blurRadius: 70.0,
//                                                   spreadRadius: 110),
//                                             ]),
//                                       ),
//                                     ))),
//                         ),
//                         Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Container(
//                               decoration: BoxDecoration(
//                                   border: Border.all(color: Colors.grey)),
//                               child: TabBar(
//                                 onTap: (value) {
//                                   _tabController?.index = value;

//                                   if (value == 2) {
//                                     BlocProvider.of<InvitationCubit>(context)
//                                         .InvitationAPI(context);
//                                   }
//                                 },
//                                 controller: _tabController,
//                                 unselectedLabelStyle: TextStyle(
//                                   color: Colors.black,
//                                 ),
//                                 unselectedLabelColor: Colors.black,
//                                 indicator: BoxDecoration(
//                                     // borderRadius: BorderRadius.circular(8.0),
//                                     color: Color(0xFFED1C25)),
//                                 tabs: [
//                                   Container(
//                                     width: 150,
//                                     height: 50,
//                                     // color: Color(0xFFED1C25),
//                                     child: Center(
//                                       child: Row(
//                                         mainAxisAlignment:
//                                             MainAxisAlignment.center,
//                                         children: [
//                                           Spacer(),
//                                           Text(
//                                             "All",
//                                             textScaleFactor: 1.0,
//                                             style: TextStyle(
//                                                 fontSize: 18,
//                                                 fontFamily: 'Outfit',
//                                                 fontWeight: FontWeight.bold),
//                                           ),
//                                           Spacer(),
//                                         ],
//                                       ),
//                                     ),
//                                   ),
//                                   Container(
//                                     height: 50,
//                                     // color: Color(0xFFED1C25),
//                                     child: Center(
//                                       child: Row(
//                                         mainAxisAlignment:
//                                             MainAxisAlignment.center,
//                                         children: [
//                                           Text(
//                                             "Requests",
//                                             textScaleFactor: 1.0,
//                                             style: TextStyle(
//                                                 fontSize: 18,
//                                                 fontFamily: 'Outfit',
//                                                 fontWeight: FontWeight.bold),
//                                           ),
//                                         ],
//                                       ),
//                                     ),
//                                   ),
//                                   Container(
//                                     height: 50,
//                                     // color: Color(0xFFED1C25),
//                                     child: Center(
//                                       child: Row(
//                                         mainAxisAlignment:
//                                             MainAxisAlignment.center,
//                                         children: [
//                                           Text(
//                                             "Invitations",
//                                             textScaleFactor: 1.0,
//                                             style: TextStyle(
//                                                 fontSize: 18,
//                                                 fontFamily: 'Outfit',
//                                                 fontWeight: FontWeight.bold),
//                                           ),
//                                         ],
//                                       ),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                             Container(
//                               height: _height / 1.15,
//                               child: TabBarView(
//                                 children: [
//                                   Center(child: Text('Tab 1 Content')),
//                                   SingleChildScrollView(
//                                       child: Column(children: [
//                                     requestsection_today(),
//                                     Padding(
//                                       padding: const EdgeInsets.only(left: 35),
//                                       child: Row(
//                                         children: [
//                                           Text(
//                                             "Previous Requests",
//                                             style: TextStyle(
//                                                 fontFamily: 'outfit',
//                                                 fontSize: 20,
//                                                 fontWeight: FontWeight.bold),
//                                           ),
//                                         ],
//                                       ),
//                                     ),
//                                     requestsection_previous_request(),
//                                   ])),
//                                   Expanded(
//                                     child: Container(
//                                         child: state is InvitationLoadedState
//                                             ? Show_NoData_Image == false
//                                                 ? SingleChildScrollView(
//                                                     child: Column(
//                                                       children: [
//                                                         ListView.builder(
//                                                           // itemCount: aa.length,

//                                                           itemCount:
//                                                               InvitationRoomData
//                                                                   ?.object
//                                                                   ?.length,
//                                                           /* (image?.contains(index) ?? false)
//                                                       ? aa.length
//                                                       : aa.length, */
//                                                           shrinkWrap: true,
//                                                           physics:
//                                                               NeverScrollableScrollPhysics(),
//                                                           itemBuilder:
//                                                               (context, index) {
//                                                             DateTime
//                                                                 parsedDateTime =
//                                                                 DateTime.parse(
//                                                                     '${InvitationRoomData?.object?[index].createdAt}');
//                                                             return Padding(
//                                                               padding: const EdgeInsets
//                                                                       .symmetric(
//                                                                   horizontal:
//                                                                       35,
//                                                                   vertical: 5),
//                                                               child:
//                                                                   GestureDetector(
//                                                                 onTap: () {},
//                                                                 child:
//                                                                     Container(
//                                                                   // height: demo.contains(index) ? null: height / 16,
//                                                                   width:
//                                                                       _width /
//                                                                           1.2,
//                                                                   decoration: BoxDecoration(
//                                                                       border: Border.all(
//                                                                           color: const Color(
//                                                                               0XFFED1C25),
//                                                                           width:
//                                                                               1),
//                                                                       borderRadius:
//                                                                           BorderRadius.circular(
//                                                                               5)),
//                                                                   child: Column(
//                                                                     crossAxisAlignment:
//                                                                         CrossAxisAlignment
//                                                                             .start,
//                                                                     children: [
//                                                                       Padding(
//                                                                         padding: EdgeInsets.only(
//                                                                             left:
//                                                                                 8.0,
//                                                                             top:
//                                                                                 10,
//                                                                             right:
//                                                                                 10,
//                                                                             bottom:
//                                                                                 10),
//                                                                         child:
//                                                                             Row(
//                                                                           mainAxisAlignment:
//                                                                               MainAxisAlignment.spaceBetween,
//                                                                           children: [
//                                                                             Text(
//                                                                               customFormat(parsedDateTime),
//                                                                               maxLines: 2,
//                                                                               textScaleFactor: 1.0,
//                                                                               style: TextStyle(fontWeight: FontWeight.w500, color: Colors.grey, fontFamily: "outfit", fontSize: 14),
//                                                                             ),
//                                                                           ],
//                                                                         ),
//                                                                       ),
//                                                                       Row(
//                                                                         crossAxisAlignment:
//                                                                             CrossAxisAlignment.start,
//                                                                         mainAxisAlignment:
//                                                                             MainAxisAlignment.start,
//                                                                         children: [
//                                                                           Padding(
//                                                                             padding:
//                                                                                 const EdgeInsets.only(left: 10),
//                                                                             child:
//                                                                                 Text(
//                                                                               "${InvitationRoomData?.object?[index].companyName}",
//                                                                               style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black, fontFamily: "outfit", fontSize: 14),
//                                                                             ),
//                                                                           ),
//                                                                         ],
//                                                                       ),
//                                                                       SizedBox(
//                                                                         height:
//                                                                             5,
//                                                                       ),
//                                                                       Row(
//                                                                         crossAxisAlignment:
//                                                                             CrossAxisAlignment.start,
//                                                                         mainAxisAlignment:
//                                                                             MainAxisAlignment.start,
//                                                                         children: [
//                                                                           Padding(
//                                                                             padding:
//                                                                                 const EdgeInsets.only(left: 10),
//                                                                             child:
//                                                                                 Container(
//                                                                               // color: Colors.amber,
//                                                                               width: _width / 1.3,
//                                                                               child: Text(
//                                                                                 "${InvitationRoomData?.object?[index].roomQuestion}",
//                                                                                 style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black, fontFamily: "outfit", fontSize: 14),
//                                                                               ),
//                                                                             ),
//                                                                           ),
//                                                                         ],
//                                                                       ),
//                                                                       Padding(
//                                                                         padding:
//                                                                             const EdgeInsets.only(left: 8.0),
//                                                                         child:
//                                                                             Text(
//                                                                           "${InvitationRoomData?.object?[index].description}",
//                                                                           style: TextStyle(
//                                                                               fontWeight: FontWeight.w400,
//                                                                               color: Colors.black.withOpacity(0.5),
//                                                                               fontFamily: "outfit",
//                                                                               fontSize: 14),
//                                                                         ),
//                                                                       ),
//                                                                       SizedBox(
//                                                                         height:
//                                                                             10,
//                                                                       ),
//                                                                       GestureDetector(
//                                                                         onTap:
//                                                                             () {
//                                                                           Navigator.push(
//                                                                               context,
//                                                                               MaterialPageRoute(
//                                                                             builder:
//                                                                                 (context) {
//                                                                               return RoomMembersScreen(roomname: "${InvitationRoomData?.object?[index].roomQuestion}", RoomOwner: false, roomdescription: "${InvitationRoomData?.object?[index].description}", room_Id: '${InvitationRoomData?.object?[index].roomUid.toString()}');
//                                                                             },
//                                                                           ));
//                                                                         },
//                                                                         child:
//                                                                             Padding(
//                                                                           padding: const EdgeInsets.only(
//                                                                               left: 10.0,
//                                                                               right: 10),
//                                                                           child:
//                                                                               Row(
//                                                                             mainAxisAlignment:
//                                                                                 MainAxisAlignment.spaceBetween,
//                                                                             children: [
//                                                                               InvitationRoomData?.object?[index].roomMembers?.length == 0 || InvitationRoomData?.object?[index].roomMembers?.isEmpty == true
//                                                                                   ? SizedBox()
//                                                                                   : InvitationRoomData?.object?[index].roomMembers?.length == 1
//                                                                                       ? Container(
//                                                                                           width: 99,
//                                                                                           height: 27.88,
//                                                                                           child: Stack(
//                                                                                             children: [
//                                                                                               Positioned(
//                                                                                                 left: 0,
//                                                                                                 top: 0,
//                                                                                                 child: Container(
//                                                                                                     width: 26.88,
//                                                                                                     height: 26.87,
//                                                                                                     decoration: BoxDecoration(color: ColorConstant.primary_color, shape: BoxShape.circle),
//                                                                                                     child: CustomImageView(
//                                                                                                       url: InvitationRoomData?.object?[index].roomMembers?[0].userProfilePic?.isNotEmpty ?? false ? "${InvitationRoomData?.object?[index].roomMembers?[0].userProfilePic}" : "https://t3.ftcdn.net/jpg/03/46/83/96/360_F_346839683_6nAPzbhpSkIpb8pmAwufkC7c5eD7wYws.jpg",
//                                                                                                       height: 20,
//                                                                                                       radius: BorderRadius.circular(20),
//                                                                                                       width: 20,
//                                                                                                       fit: BoxFit.fill,
//                                                                                                     )),
//                                                                                               ),
//                                                                                             ],
//                                                                                           ),
//                                                                                         )
//                                                                                       : InvitationRoomData?.object?[index].roomMembers?.length == 2
//                                                                                           ? Container(
//                                                                                               width: 99,
//                                                                                               height: 27.88,
//                                                                                               child: Stack(
//                                                                                                 children: [
//                                                                                                   Positioned(
//                                                                                                     left: 0,
//                                                                                                     top: 0,
//                                                                                                     child: Container(
//                                                                                                         width: 26.88,
//                                                                                                         height: 26.87,
//                                                                                                         decoration: BoxDecoration(color: ColorConstant.primary_color, shape: BoxShape.circle),
//                                                                                                         child: CustomImageView(
//                                                                                                           url: InvitationRoomData?.object?[index].roomMembers?[0].userProfilePic?.isNotEmpty ?? false ? "${InvitationRoomData?.object?[index].roomMembers?[0].userProfilePic}" : "https://t3.ftcdn.net/jpg/03/46/83/96/360_F_346839683_6nAPzbhpSkIpb8pmAwufkC7c5eD7wYws.jpg",
//                                                                                                           height: 20,
//                                                                                                           radius: BorderRadius.circular(20),
//                                                                                                           width: 20,
//                                                                                                           fit: BoxFit.fill,
//                                                                                                         )),
//                                                                                                   ),
//                                                                                                   Positioned(
//                                                                                                     left: 22.56,
//                                                                                                     top: 0,
//                                                                                                     child: Container(
//                                                                                                         width: 26.88,
//                                                                                                         height: 26.87,
//                                                                                                         decoration: BoxDecoration(color: ColorConstant.primary_color, shape: BoxShape.circle),
//                                                                                                         child: CustomImageView(
//                                                                                                           url: InvitationRoomData?.object?[index].roomMembers?[1].userProfilePic?.isNotEmpty ?? false ? "${InvitationRoomData?.object?[index].roomMembers?[1].userProfilePic}" : "https://t3.ftcdn.net/jpg/03/46/83/96/360_F_346839683_6nAPzbhpSkIpb8pmAwufkC7c5eD7wYws.jpg",
//                                                                                                           height: 20,
//                                                                                                           radius: BorderRadius.circular(20),
//                                                                                                           width: 20,
//                                                                                                           fit: BoxFit.fill,
//                                                                                                         )),
//                                                                                                   ),
//                                                                                                 ],
//                                                                                               ),
//                                                                                             )
//                                                                                           : InvitationRoomData?.object?[index].roomMembers?.length == 3
//                                                                                               ? Container(
//                                                                                                   width: 99,
//                                                                                                   height: 27.88,
//                                                                                                   child: Stack(
//                                                                                                     children: [
//                                                                                                       Positioned(
//                                                                                                         left: 0,
//                                                                                                         top: 0,
//                                                                                                         child: Container(
//                                                                                                             width: 26.88,
//                                                                                                             height: 26.87,
//                                                                                                             decoration: BoxDecoration(color: ColorConstant.primary_color, shape: BoxShape.circle),
//                                                                                                             child: CustomImageView(
//                                                                                                               url: InvitationRoomData?.object?[index].roomMembers?[0].userProfilePic?.isNotEmpty ?? false ? "${InvitationRoomData?.object?[index].roomMembers?[0].userProfilePic}" : "https://t3.ftcdn.net/jpg/03/46/83/96/360_F_346839683_6nAPzbhpSkIpb8pmAwufkC7c5eD7wYws.jpg",
//                                                                                                               height: 20,
//                                                                                                               radius: BorderRadius.circular(20),
//                                                                                                               width: 20,
//                                                                                                               fit: BoxFit.fill,
//                                                                                                             )),
//                                                                                                       ),
//                                                                                                       Positioned(
//                                                                                                         left: 22.56,
//                                                                                                         top: 0,
//                                                                                                         child: Container(
//                                                                                                             width: 26.88,
//                                                                                                             height: 26.87,
//                                                                                                             decoration: BoxDecoration(color: ColorConstant.primary_color, shape: BoxShape.circle),
//                                                                                                             child: CustomImageView(
//                                                                                                               url: InvitationRoomData?.object?[index].roomMembers?[1].userProfilePic?.isNotEmpty ?? false ? "${InvitationRoomData?.object?[index].roomMembers?[1].userProfilePic}" : "https://t3.ftcdn.net/jpg/03/46/83/96/360_F_346839683_6nAPzbhpSkIpb8pmAwufkC7c5eD7wYws.jpg",
//                                                                                                               height: 20,
//                                                                                                               radius: BorderRadius.circular(20),
//                                                                                                               width: 20,
//                                                                                                               fit: BoxFit.fill,
//                                                                                                             )),
//                                                                                                       ),
//                                                                                                       // error get
//                                                                                                       Positioned(
//                                                                                                         left: 45.12,
//                                                                                                         top: 0,
//                                                                                                         child: Container(
//                                                                                                             width: 26.88,
//                                                                                                             height: 26.87,
//                                                                                                             decoration: BoxDecoration(color: ColorConstant.primary_color, shape: BoxShape.circle),
//                                                                                                             child: CustomImageView(
//                                                                                                               url: InvitationRoomData?.object?[index].roomMembers?[2].userProfilePic?.isNotEmpty ?? false ? "${InvitationRoomData?.object?[index].roomMembers?[2].userProfilePic}" : "https://t3.ftcdn.net/jpg/03/46/83/96/360_F_346839683_6nAPzbhpSkIpb8pmAwufkC7c5eD7wYws.jpg",
//                                                                                                               height: 20,
//                                                                                                               radius: BorderRadius.circular(20),
//                                                                                                               width: 20,
//                                                                                                               fit: BoxFit.fill,
//                                                                                                             )),
//                                                                                                       ),
//                                                                                                     ],
//                                                                                                   ),
//                                                                                                 )
//                                                                                               : Container(
//                                                                                                   width: 99,
//                                                                                                   height: 27.88,
//                                                                                                   child: Stack(
//                                                                                                     children: [
//                                                                                                       Positioned(
//                                                                                                         left: 0,
//                                                                                                         top: 0,
//                                                                                                         child: Container(
//                                                                                                             width: 26.88,
//                                                                                                             height: 26.87,
//                                                                                                             decoration: BoxDecoration(color: ColorConstant.primary_color, shape: BoxShape.circle),
//                                                                                                             child: CustomImageView(
//                                                                                                               url: InvitationRoomData?.object?[index].roomMembers?[0].userProfilePic?.isNotEmpty ?? false ? "${InvitationRoomData?.object?[index].roomMembers?[0].userProfilePic}" : "https://t3.ftcdn.net/jpg/03/46/83/96/360_F_346839683_6nAPzbhpSkIpb8pmAwufkC7c5eD7wYws.jpg",
//                                                                                                               height: 20,
//                                                                                                               radius: BorderRadius.circular(20),
//                                                                                                               width: 20,
//                                                                                                               fit: BoxFit.fill,
//                                                                                                             )),
//                                                                                                       ),
//                                                                                                       Positioned(
//                                                                                                         left: 22.56,
//                                                                                                         top: 0,
//                                                                                                         child: Container(
//                                                                                                             width: 26.88,
//                                                                                                             height: 26.87,
//                                                                                                             decoration: BoxDecoration(color: ColorConstant.primary_color, shape: BoxShape.circle),
//                                                                                                             child: CustomImageView(
//                                                                                                               url: InvitationRoomData?.object?[index].roomMembers?[1].userProfilePic?.isNotEmpty ?? false ? "${InvitationRoomData?.object?[index].roomMembers?[1].userProfilePic}" : "https://t3.ftcdn.net/jpg/03/46/83/96/360_F_346839683_6nAPzbhpSkIpb8pmAwufkC7c5eD7wYws.jpg",
//                                                                                                               height: 20,
//                                                                                                               radius: BorderRadius.circular(20),
//                                                                                                               width: 20,
//                                                                                                               fit: BoxFit.fill,
//                                                                                                             )),
//                                                                                                       ),
//                                                                                                       Positioned(
//                                                                                                         left: 45.12,
//                                                                                                         top: 0,
//                                                                                                         child: Container(
//                                                                                                             width: 26.88,
//                                                                                                             height: 26.87,
//                                                                                                             decoration: BoxDecoration(color: ColorConstant.primary_color, shape: BoxShape.circle),
//                                                                                                             child: CustomImageView(
//                                                                                                               url: InvitationRoomData?.object?[index].roomMembers?[2].userProfilePic?.isNotEmpty ?? false ? "${InvitationRoomData?.object?[index].roomMembers?[2].userProfilePic}" : "https://t3.ftcdn.net/jpg/03/46/83/96/360_F_346839683_6nAPzbhpSkIpb8pmAwufkC7c5eD7wYws.jpg",
//                                                                                                               height: 20,
//                                                                                                               radius: BorderRadius.circular(20),
//                                                                                                               width: 20,
//                                                                                                               fit: BoxFit.fill,
//                                                                                                             )),
//                                                                                                       ),
//                                                                                                       Positioned(
//                                                                                                         left: 78,
//                                                                                                         top: 7,
//                                                                                                         child: SizedBox(
//                                                                                                           width: 21,
//                                                                                                           height: 16,
//                                                                                                           child: Text(
//                                                                                                             "+${(InvitationRoomData?.object?[index].roomMembers?.length ?? 0) - 3}",
//                                                                                                             style: TextStyle(
//                                                                                                               color: Color(0xFF2A2A2A),
//                                                                                                               fontSize: 14,
//                                                                                                               fontFamily: 'Outfit',
//                                                                                                               fontWeight: FontWeight.w400,
//                                                                                                             ),
//                                                                                                           ),
//                                                                                                         ),
//                                                                                                       ),
//                                                                                                     ],
//                                                                                                   ),
//                                                                                                 ),
//                                                                               // GestureDetector(
//                                                                               //   onTap: () {
//                                                                               //     showDialog(
//                                                                               //       context: context,
//                                                                               //       builder:
//                                                                               //           (BuildContext context) {
//                                                                               //         print(
//                                                                               //             'uid print-${InvitationRoomData?.object?[index].roomUid}');
//                                                                               //         return MultiBlocProvider(
//                                                                               //             providers: [
//                                                                               //               BlocProvider<
//                                                                               //                   SherInviteCubit>(
//                                                                               //                 create: (_) =>
//                                                                               //                     SherInviteCubit(),
//                                                                               //               ),
//                                                                               //             ],
//                                                                               //             child: InviteDilogScreen(
//                                                                               //               Room_UUID:
//                                                                               //                   "${InvitationRoomData?.object?[index].roomUid}",
//                                                                               //             ));
//                                                                               //       },
//                                                                               //     );
//                                                                               //   },
//                                                                               //   child: Container(
//                                                                               //     width: 140,
//                                                                               //     height: 22.51,
//                                                                               //     decoration: ShapeDecoration(
//                                                                               //       color: Color(0xFFFFD9DA),
//                                                                               //       shape: RoundedRectangleBorder(
//                                                                               //         side: BorderSide(
//                                                                               //           width: 1,
//                                                                               //           color: Color(0xFFED1C25),
//                                                                               //         ),
//                                                                               //         borderRadius:
//                                                                               //             BorderRadius.circular(50),
//                                                                               //       ),
//                                                                               //     ),
//                                                                               //     child: Center(
//                                                                               //         child: Text(
//                                                                               //       "Invite User",
//                                                                               //       style: TextStyle(
//                                                                               //           fontWeight: FontWeight.w400,
//                                                                               //           color: Color(0xFFED1C25),
//                                                                               //           fontFamily: "outfit",
//                                                                               //           fontSize: 13),
//                                                                               //     )),
//                                                                               //   ),
//                                                                               // )
//                                                                             ],
//                                                                           ),
//                                                                         ),
//                                                                       ),
//                                                                       SizedBox(
//                                                                         height:
//                                                                             10,
//                                                                       ),
//                                                                       Row(
//                                                                         mainAxisAlignment:
//                                                                             MainAxisAlignment.spaceBetween,
//                                                                         children: [
//                                                                           Expanded(
//                                                                             flex:
//                                                                                 2,
//                                                                             child:
//                                                                                 GestureDetector(
//                                                                               onTap: () {
//                                                                                 print('chek data get-${InvitationRoomData?.object?[index].invitationLink.toString()}');
//                                                                                 BlocProvider.of<InvitationCubit>(context).GetRoomInvitations(false, InvitationRoomData?.object?[index].invitationLink.toString() ?? "", context);
//                                                                               },
//                                                                               child: Container(
//                                                                                 height: 40,
//                                                                                 width: _width / 2.48,
//                                                                                 decoration: BoxDecoration(
//                                                                                     // color: Color(0XFF9B9B9B),
//                                                                                     color: Color(0XFF9B9B9B),
//                                                                                     borderRadius: BorderRadius.only(bottomLeft: Radius.circular(4))),
//                                                                                 child: Center(
//                                                                                   child: Text(
//                                                                                     "Reject",
//                                                                                     style: TextStyle(fontWeight: FontWeight.w400, color: Colors.white, fontFamily: "outfit", fontSize: 15),
//                                                                                   ),
//                                                                                 ),
//                                                                               ),
//                                                                             ),
//                                                                           ),
//                                                                           SizedBox(
//                                                                             width:
//                                                                                 1,
//                                                                           ),
//                                                                           Expanded(
//                                                                             flex:
//                                                                                 2,
//                                                                             child:
//                                                                                 GestureDetector(
//                                                                               onTap: () {
//                                                                                 BlocProvider.of<InvitationCubit>(context).GetRoomInvitations(true, InvitationRoomData?.object?[index].invitationLink.toString() ?? "", context);
//                                                                               },
//                                                                               child: Container(
//                                                                                 height: 40,
//                                                                                 width: _width / 2.48,
//                                                                                 decoration: BoxDecoration(
//                                                                                   borderRadius: BorderRadius.only(
//                                                                                     bottomRight: Radius.circular(4),
//                                                                                   ),
//                                                                                   color: Color(0xFFED1C25),
//                                                                                 ),
//                                                                                 child: Center(
//                                                                                   child: Text(
//                                                                                     "Accept",
//                                                                                     style: TextStyle(fontWeight: FontWeight.w400, color: Colors.white, fontFamily: "outfit", fontSize: 15),
//                                                                                   ),
//                                                                                 ),
//                                                                               ),
//                                                                             ),
//                                                                           ),
//                                                                         ],
//                                                                       ),
//                                                                     ],
//                                                                   ),
//                                                                 ),
//                                                               ),
//                                                             );
//                                                           },
//                                                         ),
//                                                       ],
//                                                     ),
//                                                   )
//                                                 : Center(
//                                                     child: Text(
//                                                       "No Invitations For Now",
//                                                       style: TextStyle(
//                                                         fontFamily: 'outfit',
//                                                         fontSize: 20,
//                                                         color:
//                                                             Color(0XFFED1C25),
//                                                         fontWeight:
//                                                             FontWeight.bold,
//                                                       ),
//                                                     ),
//                                                   )
//                                             : Center(
//                                                 child: Container(
//                                                   margin: EdgeInsets.only(
//                                                       bottom: 100),
//                                                   child: ClipRRect(
//                                                     borderRadius:
//                                                         BorderRadius.circular(
//                                                             20),
//                                                     child: Image.asset(
//                                                         ImageConstant.loader,
//                                                         fit: BoxFit.cover,
//                                                         height: 100.0,
//                                                         width: 100),
//                                                   ),
//                                                 ),
//                                               )),
//                                   ),
//                                 ],
//                               ),
//                             )
//                           ],
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//             )),
//       );
//     });
//   }

//   requestsection_today() {
//     var _height = MediaQuery.of(context).size.height;
//     var _width = MediaQuery.of(context).size.width;
//     return ListView.builder(
//         shrinkWrap: true,
//         physics: BouncingScrollPhysics(),
//         itemCount: 5,
//         // itemCount: 5,
//         itemBuilder: (BuildContext context, int index) {
//           return Container(
//             child: Column(
//               children: [
//                 Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: Column(
//                     children: [
//                       Container(
//                         height: 80,
//                         width: _width / 1.2,
//                         decoration: BoxDecoration(
//                             border: Border.all(color: Colors.grey, width: 1),
//                             color: Colors.white,
//                             borderRadius: BorderRadius.circular(15)),
//                         child: Row(children: [
//                           Image.asset(
//                             ImageConstant.expertone,
//                           ),
//                           Column(
//                             children: [
//                               Row(
//                                 children: [
//                                   Text(
//                                     "Karennne Watsaon",
//                                     style: TextStyle(
//                                         fontFamily: "outfit",
//                                         fontWeight: FontWeight.bold,
//                                         fontSize: 13),
//                                   ),
//                                   SizedBox(
//                                     width: 4,
//                                   ),
//                                   Text(
//                                     "started following you.",
//                                     style: TextStyle(
//                                         fontFamily: "outfit",
//                                         fontWeight: FontWeight.w200,
//                                         fontSize: 13),
//                                   ),
//                                 ],
//                               ),
//                               SizedBox(
//                                 height: 10,
//                               ),
//                               Padding(
//                                 padding: const EdgeInsets.only(right: 30.0),
//                                 child: Row(
//                                   children: [
//                                     Container(
//                                       height: 30,
//                                       width: 100,
//                                       decoration: BoxDecoration(
//                                           color: Color(0xFFED1C25),
//                                           borderRadius:
//                                               BorderRadius.circular(10)),
//                                       child: Center(
//                                           child: Text(
//                                         "Accept",
//                                         style: TextStyle(
//                                             fontFamily: 'outfit',
//                                             color: Colors.white),
//                                       )),
//                                     ),
//                                     SizedBox(
//                                       width: 5,
//                                     ),
//                                     Container(
//                                       height: 30,
//                                       width: 100,
//                                       decoration: BoxDecoration(
//                                           borderRadius:
//                                               BorderRadius.circular(10),
//                                           border: Border.all(
//                                               color: Color(0xFFED1C25))),
//                                       child: Center(
//                                           child: Text(
//                                         "Reject",
//                                         style: TextStyle(
//                                             fontFamily: 'outfit',
//                                             color: Color(0xFFED1C25)),
//                                       )),
//                                     )
//                                   ],
//                                 ),
//                               ),
//                               Padding(
//                                 padding: const EdgeInsets.only(left: 85),
//                                 child: Text(
//                                   customFormat(DateTime.now()),
//                                   maxLines: 2,
//                                   textScaleFactor: 1.0,
//                                   style: TextStyle(
//                                       fontWeight: FontWeight.w500,
//                                       color: Colors.grey,
//                                       fontFamily: "outfit",
//                                       fontSize: 14),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ]),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           );
//         });
//   }

//   requestsection_previous_request() {
//     var _height = MediaQuery.of(context).size.height;
//     var _width = MediaQuery.of(context).size.width;
//     return ListView.builder(
//         shrinkWrap: true,
//         physics: BouncingScrollPhysics(),
//         itemCount: 5,
//         // itemCount: 5,
//         itemBuilder: (BuildContext context, int index) {
//           return Container(
//             child: Column(
//               children: [
//                 Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: Column(
//                     children: [
//                       Container(
//                         height: 80,
//                         width: _width / 1.2,
//                         decoration: BoxDecoration(
//                             border: Border.all(color: Colors.grey, width: 1),
//                             color: Colors.white.withOpacity(1),
//                             borderRadius: BorderRadius.circular(15)),
//                         child: Row(children: [
//                           Image.asset(
//                             ImageConstant.expertone,
//                           ),
//                           Column(
//                             children: [
//                               Row(
//                                 children: [
//                                   Text(
//                                     "Karennne Watsaon",
//                                     style: TextStyle(
//                                         fontFamily: "outfit",
//                                         fontWeight: FontWeight.bold,
//                                         fontSize: 13),
//                                   ),
//                                   SizedBox(
//                                     width: 4,
//                                   ),
//                                   Text(
//                                     "started following you.",
//                                     style: TextStyle(
//                                         fontFamily: "outfit",
//                                         fontWeight: FontWeight.w200,
//                                         fontSize: 13),
//                                   ),
//                                 ],
//                               ),
//                               SizedBox(
//                                 height: 10,
//                               ),
//                               Padding(
//                                 padding: const EdgeInsets.only(right: 30.0),
//                                 child: Row(
//                                   children: [
//                                     Container(
//                                       height: 30,
//                                       width: 100,
//                                       decoration: BoxDecoration(
//                                           color: Color(0xFFED1C25),
//                                           borderRadius:
//                                               BorderRadius.circular(10)),
//                                       child: Center(
//                                           child: Text(
//                                         "Accept",
//                                         style: TextStyle(
//                                             fontFamily: 'outfit',
//                                             color: Colors.white),
//                                       )),
//                                     ),
//                                     SizedBox(
//                                       width: 5,
//                                     ),
//                                     Container(
//                                       height: 30,
//                                       width: 100,
//                                       decoration: BoxDecoration(
//                                           borderRadius:
//                                               BorderRadius.circular(10),
//                                           border: Border.all(
//                                               color: Color(0xFFED1C25))),
//                                       child: Center(
//                                           child: Text(
//                                         "Reject",
//                                         style: TextStyle(
//                                             fontFamily: 'outfit',
//                                             color: Color(0xFFED1C25)),
//                                       )),
//                                     )
//                                   ],
//                                 ),
//                               ),
//                               Padding(
//                                 padding: const EdgeInsets.only(left: 85),
//                                 child: Text(
//                                   customFormat(DateTime.now()),
//                                   maxLines: 2,
//                                   textScaleFactor: 1.0,
//                                   style: TextStyle(
//                                       fontWeight: FontWeight.w500,
//                                       color: Colors.grey,
//                                       fontFamily: "outfit",
//                                       fontSize: 14),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ]),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           );
//         });
//   }

//   updateType() {
//     arrNotiyTypeList.forEach((element) {
//       element.isSelected = false;
//     });
//   }
// }
