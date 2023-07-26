import 'package:archit_s_application1/core/utils/size_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../API/Bloc/Fatch_All_PRoom_Bloc/Fatch_PRoom_cubit.dart';
import '../../API/Bloc/PublicRoom_Bloc/CreatPublicRoom_cubit.dart';
import '../../API/Bloc/PublicRoom_Bloc/CreatPublicRoom_state.dart';
import '../../core/utils/color_constant.dart';
import '../../core/utils/image_constant.dart';
import '../../theme/theme_helper.dart';
import '../../widgets/custom_image_view.dart';

class AddThreadsScreen extends StatefulWidget {
  const AddThreadsScreen({Key? key}) : super(key: key);

  @override
  State<AddThreadsScreen> createState() => _AddThreadsScreenState();
}

class _AddThreadsScreenState extends State<AddThreadsScreen> {
  TextEditingController RoomTitleController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: theme.colorScheme.onPrimary,
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: theme.colorScheme.onPrimary,
          elevation: 0,
          leading: GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Icon(
              Icons.arrow_back,
              color: Colors.grey,
            ),
          ),
          title: Text(
            "Add Thread",
            style: TextStyle(
              fontFamily: 'outfit',
              fontSize: 23,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: BlocProvider<CreatPublicRoomCubit>(
          create: (_) => CreatPublicRoomCubit(),
          child: BlocConsumer<CreatPublicRoomCubit, CreatPublicRoomState>(
              listener: (context, state) async {
            if (state is CreatPublicRoomErrorState) {
              print("error");
              SnackBar snackBar = SnackBar(
                content: Text(state.error),
                backgroundColor: ColorConstant.primary_color,
              );
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            }

            if (state is CreatPublicRoomLoadingState) {
              print("loading");
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
            if (state is CreatPublicRoomLoadedState) {
              SnackBar snackBar = SnackBar(
                content: Text(state.PublicRoomData.message ?? ""),
                backgroundColor: ColorConstant.primary_color,
              );
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
              Navigator.pop(context);
            }
          }, builder: (context, state) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    "Description",
                    style: TextStyle(
                      fontFamily: 'outfit',
                      fontSize: 15,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Center(
                  child: Container(
                    height: 230,
                    width: width / 1.1,
                    decoration: BoxDecoration(
                      color: Color(0XFFEFEFEF),
                      border:
                          Border.all(color: Colors.grey.shade300, width: 1),
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 0.5, right: 0.5),
                              child: Container(
                                height: 50,
                                width: width / 1.11,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.grey.shade300,
                                  ),
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      CustomImageView(
                                        imagePath: ImageConstant.boldimage,
                                        height: 20,
                                      ),
                                      CustomImageView(
                                        imagePath:
                                            ImageConstant.italicimage,
                                        height: 15,
                                      ),
                                      CustomImageView(
                                        imagePath: ImageConstant.abimage,
                                        height: 30,
                                      ),
                                      CustomImageView(
                                        imagePath: ImageConstant.h1image,
                                        height: 15,
                                      ),
                                      CustomImageView(
                                        imagePath: ImageConstant.lineimage,
                                        height: 25,
                                      ),
                                      CustomImageView(
                                        imagePath: ImageConstant.imageline,
                                        height: 20,
                                      ),
                                      CustomImageView(
                                        imagePath: ImageConstant.pinimage,
                                        height: 20,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextField(
                            controller: RoomTitleController,
                            cursorColor: Colors.grey,
                            maxLines: 6,
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Add Description....'),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                GestureDetector(
                  onTap: () {
                    var params = {
                      "roomQuestion": RoomTitleController.text,
                      "description": "",
                      "roomType": "PUBLIC"
                    };

                    BlocProvider.of<CreatPublicRoomCubit>(context)
                        .CreatPublicRoomAPI(params);
                  },
                  child: Center(
                    child: Container(
                      height: 50,
                      width: width / 1.2,
                      decoration: BoxDecoration(
                          color: Color(0XFFED1C25),
                          borderRadius: BorderRadius.circular(5)),
                      child: Center(
                        child: Text(
                          "Create Forum",
                          style: TextStyle(
                            fontFamily: 'outfit',
                            fontSize: 15,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          }),
        ));
  }
}
