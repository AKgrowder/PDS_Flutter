import 'package:archit_s_application1/dialogs/create_room_dilog.dart';
import 'package:archit_s_application1/dilogs/invite_dilog.dart';
import 'package:archit_s_application1/presentation/view_comments/view_comments_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../API/Bloc/CreateRoom_Bloc/CreateRoom_cubit.dart';
import '../../API/Bloc/Invitation_Bloc/Invitation_cubit.dart';
import '../../API/Bloc/Invitation_Bloc/Invitation_state.dart';
import '../../API/Bloc/senMSG_Bloc/senMSG_cubit.dart';
import '../../API/Model/GetAllPrivateRoom/GetAllPrivateRoom_Model.dart';
import '../../API/Model/InvitationModel/Invitation_Model.dart';
import '../../core/utils/color_constant.dart';
import '../../core/utils/image_constant.dart';
import '../../dialogs/assigh_adminn_dilog..dart';
import '../../theme/theme_helper.dart';
import '../../widgets/custom_image_view.dart';

class InvitationScreen extends StatefulWidget {
  const InvitationScreen({Key? key}) : super(key: key);

  @override
  State<InvitationScreen> createState() => _InvitationScreenState();
}

List? image = [];
List? imagee = [];
List? close = [];
List? closee = [];
InvitationModel? InvitationRoomData;

class _InvitationScreenState extends State<InvitationScreen> {
  var Show_NoData_Image = false;
  @override
  void initState() {
    Show_NoData_Image = true;

    BlocProvider.of<InvitationCubit>(context).InvitationAPI();
    setState(() {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // var _height = MediaQuery.of(context).size.height;
    var _width = MediaQuery.of(context).size.width;

    // int selectedIndex = 0;
    return Scaffold(
        backgroundColor: theme.colorScheme.onPrimary,
        appBar: AppBar(
          backgroundColor: theme.colorScheme.onPrimary,
          elevation: 0,
          centerTitle: true,
          leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              Icons.arrow_back,
              color: Colors.grey,
            ),
          ),
          title: Text(
            "Rooms",
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontFamily: "outfit",
                fontSize: 20),
          ),
        ),
        body: BlocConsumer<InvitationCubit, InvitationState>(
            listener: (context, state) async {
          if (state is InvitationErrorState) {
            if (state.error == "not found") {
              print("Show Image");
              Show_NoData_Image = true;
            } else {
              SnackBar snackBar = SnackBar(
                content: Text(state.error),
                backgroundColor: ColorConstant.primary_color,
              );
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            }
          }

          if (state is InvitationLoadingState) {
            Center(
              child: Container(
                margin: EdgeInsets.only(bottom: 100),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.asset(ImageConstant.loader,
                      fit: BoxFit.cover, height: 100.0, width: 100),
                ),
              ),
            );
          }
          if (state is InvitationLoadedState) {
            Show_NoData_Image = false;
            InvitationRoomData = state.InvitationRoomData;
            print(InvitationRoomData?.message);
          }
        }, builder: (context, state) {
          return SingleChildScrollView(
            child: Column(children: [
              ListView.builder(
                // itemCount: aa.length,
                itemCount: InvitationRoomData?.object?.length,
                /* (image?.contains(index) ?? false)
                          ? aa.length
                          : aa.length, */
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 35, vertical: 5),
                    child: GestureDetector(
                      onTap: () {},
                      child: Container(
                        // height: demo.contains(index) ? null: height / 16,
                        width: _width / 1.2,
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: const Color(0XFFED1C25), width: 1),
                            borderRadius: BorderRadius.circular(5)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                  left: 8.0,
                                  top: 10,
                                  right: 10,
                                  bottom: 10),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Create Date",
                                    maxLines: 2,
                                    textScaleFactor: 1.0,
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        color: Colors.grey,
                                        fontFamily: "outfit",
                                        fontSize: 14),
                                  ),
                                ],
                              ),
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 10),
                                  child: Text(
                                    "${InvitationRoomData?.object?[index].companyName}",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                        fontFamily: "outfit",
                                        fontSize: 14),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 10),
                                  child: Text(
                                    "${InvitationRoomData?.object?[index].roomQuestion}",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                        fontFamily: "outfit",
                                        fontSize: 14),
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: Text(
                                "${InvitationRoomData?.object?[index].description}",
                                style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    color: Colors.black.withOpacity(0.5),
                                    fontFamily: "outfit",
                                    fontSize: 14),
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                           /*  Padding(
                              padding: const EdgeInsets.only(
                                  left: 10.0, right: 10),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    width: 99,
                                    height: 28.87,
                                    child: Stack(
                                      children: [
                                        Positioned(
                                          left: 0,
                                          top: 0,
                                          child: Container(
                                            width: 28.88,
                                            height: 28.87,
                                            child: CustomImageView(
                                              imagePath:
                                                  ImageConstant.expertone,
                                              height: 30,
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                          left: 22.56,
                                          top: 0,
                                          child: Container(
                                            width: 28.88,
                                            height: 28.87,
                                            child: CustomImageView(
                                              imagePath:
                                                  ImageConstant.experttwo,
                                              height: 30,
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                          left: 45.12,
                                          top: 0,
                                          child: Container(
                                            width: 28.88,
                                            height: 28.87,
                                            child: CustomImageView(
                                              imagePath:
                                                  ImageConstant.expertthree,
                                              height: 30,
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                          left: 78,
                                          top: 7,
                                          child: SizedBox(
                                            width: 21,
                                            height: 16,
                                            child: Text(
                                              '+5',
                                              style: TextStyle(
                                                color: Color(0xFF2A2A2A),
                                                fontSize: 12,
                                                fontFamily: 'Outfit',
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            */
                            SizedBox(
                              height: 20,
                            ),
                            Row(
                              mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  flex: 2,
                                  child: GestureDetector(
                                    onTap: () {},
                                    child: Container(
                                      height: 40,
                                      width: _width / 2.48,
                                      decoration: BoxDecoration(
                                          // color: Color(0XFF9B9B9B),
                                          color: Color(0XFF9B9B9B),
                                          borderRadius: BorderRadius.only(
                                              bottomLeft:
                                                  Radius.circular(4))),
                                      child: Center(
                                        child: Text(
                                          "Reject",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w400,
                                              color: Colors.white,
                                              fontFamily: "outfit",
                                              fontSize: 15),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 1,
                                ),
                                Expanded(
                                  flex: 2,
                                  child: GestureDetector(
                                    onTap: () {},
                                    child: Container(
                                      height: 40,
                                      width: _width / 2.48,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.only(
                                          bottomRight: Radius.circular(4),
                                        ),
                                        color: Color(0xFFED1C25),
                                      ),
                                      child: Center(
                                        child: Text(
                                          "Accept",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w400,
                                              color: Colors.white,
                                              fontFamily: "outfit",
                                              fontSize: 15),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),

                            // Container(
                            //   color: Colors.amber,
                            //   child: Stack(
                            //     children: [
                            //       Row(
                            //         children: [
                            //           CustomImageView(
                            //             imagePath: ImageConstant.expertone,
                            //             height: 30,
                            //           ),
                            //           CustomImageView(
                            //             imagePath: ImageConstant.experttwo,
                            //             height: 30,
                            //           ),
                            //           CustomImageView(
                            //             imagePath: ImageConstant.expertthree,
                            //             height: 30,
                            //           ),
                            //         ],
                            //       ),
                            //     ],
                            //   ),
                            // ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ]),
          );
        }));
  }
}
