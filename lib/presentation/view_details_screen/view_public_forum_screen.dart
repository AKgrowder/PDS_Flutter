import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../API/Bloc/senMSG_Bloc/senMSG_cubit.dart';
import '../../core/utils/image_constant.dart';
// import '../../core/utils/size_utils.dart';
import '../../theme/theme_helper.dart';
import '../../widgets/custom_image_view.dart';
import '../home/home.dart';
import '../view_comments/view_comments_screen.dart';

class ViewDetailsScreen extends StatefulWidget {
  const ViewDetailsScreen({Key? key}) : super(key: key);

  @override
  State<ViewDetailsScreen> createState() => _ViewDetailsScreenState();
}

class _ViewDetailsScreenState extends State<ViewDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    double _height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: theme.colorScheme.onPrimary,
      appBar: AppBar(
        backgroundColor: theme.colorScheme.onPrimary,
        centerTitle: true,
        elevation: 0,
        leading: GestureDetector(onTap: () {
          Navigator.pop(context);
        },
          child: Icon(
            Icons.arrow_back,
            color: Colors.grey,
          ),
        ),
        title: Text(
          "Public Forum",
          style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black,
              fontFamily: "outfit",
              fontSize: 20),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 50.0),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              ListView.builder(
                        itemCount: PublicRoomModelData?.object?.length,
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
                                width: _width,
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: const Color(0XFFD9D9D9), width: 2),
                                    borderRadius: BorderRadius.circular(5)),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Padding(
                                            padding:
                                                const EdgeInsets.only(left: 10),
                                            child: CustomImageView(
                                              imagePath: ImageConstant.tomcruse,
                                              height: 20,
                                            )),
                                        Padding(
                                          padding: const EdgeInsets.only(left: 5),
                                          child: Text(
                                             User_Name != null
                                            ? "${User_Name}"
                                            : "Tom_cruze",
                                            style: TextStyle(
                                                fontWeight: FontWeight.w800,
                                                color: Colors.black,
                                                fontFamily: "outfit",
                                                fontSize: 14),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(
                                              left: 8.0, top: 10, bottom: 10),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 2.0, top: 5),
                                                child: CircleAvatar(
                                                    backgroundColor: Colors.black,
                                                    maxRadius: 3),
                                              ),
                                              SizedBox(
                                                width: 3,
                                              ),
                                              Container(
                                                width: _width / 1.4,
                                                child: Text(
                                                  "${PublicRoomModelData?.object?[index].roomQuestion}",
                                                  maxLines: 2,
                                                  textScaleFactor: 1.0,
                                                  style: TextStyle(
                                                      fontWeight: FontWeight.bold,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      color: Colors.black,
                                                      fontFamily: "outfit",
                                                      fontSize: 14),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Padding(
                                            padding:
                                                const EdgeInsets.only(left: 10),
                                            child: CustomImageView(
                                              imagePath: ImageConstant.tomcruse,
                                              height: 20,
                                            )),
                                        Padding(
                                          padding: const EdgeInsets.only(left: 5),
                                          child: Container(
                                            width: _width / 1.4,
                                            child: Text(
                                              "${PublicRoomModelData?.object?[index].uid}",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w800,
                                                  color: Colors.black,
                                                  fontFamily: "outfit",
                                                  fontSize: 14),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(left: 35, top: 2),
                                      child: Text(
                                        "${PublicRoomModelData?.object?[index].message?.message ?? ""}",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w400,
                                            color: Colors.black,
                                            fontFamily: "outfit",
                                            fontSize: 12),
                                      ),
                                    ),
                                    Divider(
                                      color: Colors.black,
                                    ),
                                    Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            Navigator.push(context,
                                                MaterialPageRoute(
                                                    builder: (context) {
                                              return MultiBlocProvider(
                                                providers: [
                                                  BlocProvider(
                                                    create: (context) =>
                                                        senMSGCubit(),
                                                  ),
                                                ],
                                                child: ViewCommentScreen(
                                                  Room_ID:
                                                      "${PublicRoomModelData?.object?[index].uid ?? ""}",
                                                  Title:
                                                      "${PublicRoomModelData?.object?[index].roomQuestion ?? ""}",
                                                ),
                                              );
                                            }));
                                          },
                                          child: Text(
                                            "Add New Comment",
                                            style: TextStyle(
                                                fontWeight: FontWeight.w400,
                                                color: Colors.black,
                                                fontFamily: "outfit",
                                                fontSize: 15),
                                          ),
                                        ),
                                        // Spacer(),
                                        Flexible(
                                          flex: 0,
                                          child: Container(
                                            //  height: 50,
                                            alignment: Alignment.centerRight,
                                            // width: 150,
                                            // color: Colors.amber,
                                            child: Text(
                                              "${PublicRoomModelData?.object?[index].message?.messageCount ?? "0"} Comments",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w400,
                                                  color: Colors.grey,
                                                  fontFamily: "outfit",
                                                  fontSize: 13),
                                            ),
                                          ),
                                        ),
                                       
                                      ],
                                    ), ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
          ]),
        ),
      ),
    );
  }
}
