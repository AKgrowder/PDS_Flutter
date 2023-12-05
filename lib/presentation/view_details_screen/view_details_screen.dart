import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pds/API/Bloc/ViewDetails_Bloc/ViewDetails_state.dart';
import 'package:pds/API/Model/ViewDetails_Model/ViewDetails_model.dart';
import 'package:pds/core/utils/image_constant.dart';

import '../../API/Bloc/ViewDetails_Bloc/ViewDetails_cubit.dart';
import '../../core/utils/color_constant.dart';
import '../../theme/theme_helper.dart';
import '../../widgets/custom_image_view.dart';

class ViewDetailsScreen extends StatefulWidget {
  String? uuID;
  ViewDetailsScreen({Key? key, this.uuID}) : super(key: key);

  @override
  State<ViewDetailsScreen> createState() => _ViewDetailsScreenState();
}



class _ViewDetailsScreenState extends State<ViewDetailsScreen> {
   ViewDetailsModel? viewDetailsModel;
  @override
 
  void initState() {
    // TODO: implement initState
    super.initState();
    BlocProvider.of<ViewDetailsCubit>(context)
        .ViewDetailsAPI(widget.uuID ?? "", context);
  }

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
          leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
          ),
          title: Text(
            "View details",
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontFamily: "outfit",
                fontSize: 20),
          ),
        ),
        body: BlocConsumer<ViewDetailsCubit, ViewDeatilsState>(
          listener: (context, state) {
            if (state is ViewDeatilsErrorState) {
              SnackBar snackBar = SnackBar(
                content: Text(state.error),
                backgroundColor: ColorConstant.primary_color,
              );
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            }
            if (state is ViewDeatilsLoadedState) {
              print("ViewDeatilsLoadedState");
              viewDetailsModel = state.viewDeatilsModel;
            }
          },
          builder: (context, state) {
            return Padding(
              padding: const EdgeInsets.only(top: 50.0),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Align(
                      alignment: Alignment.center,
                      child: Container(
                          height: _height / 8,
                          width: _width / 3.7,
                          child: viewDetailsModel?.object?.profilePic == null || viewDetailsModel?.object?.profilePic == ""
                              ? CustomImageView(
                                  imagePath: ImageConstant.tomcruse,
                                  height: 50,
                                  radius: BorderRadius.circular(5),
                                  width: 50,
                                  fit: BoxFit.fill,
                                )
                              : CustomImageView(
                                  url: viewDetailsModel?.object?.profilePic
                                      .toString(),
                                  height: 50,
                                  radius: BorderRadius.circular(55),
                                  width: 50,
                                  fit: BoxFit.fill,
                                )),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 36.0, top: 10),
                      child: Text(
                        "User ID",
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                            fontFamily: "outfit",
                            fontSize: 15),
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Center(
                      child: Container(
                        height: 50,
                        width: _width / 1.2,
                        decoration: BoxDecoration(
                            color: Color(0xFFF6F6F6),
                            borderRadius: BorderRadius.circular(10)),
                        child: Padding(
                          padding: const EdgeInsets.only(top: 15.0, left: 10),
                          child: Text(
                            "${viewDetailsModel?.object?.userId}",
                            style: TextStyle(
                                fontWeight: FontWeight.w400,
                                color: Colors.grey.shade700,
                                fontFamily: "outfit",
                                fontSize: 15),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 36.0, top: 20),
                      child: Text(
                        "Your Name",
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                            fontFamily: "outfit",
                            fontSize: 15),
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Center(
                      child: Container(
                        height: 50,
                        width: _width / 1.2,
                        decoration: BoxDecoration(
                            color: Color(0xFFF6F6F6),
                            borderRadius: BorderRadius.circular(10)),
                        child: Padding(
                          padding: const EdgeInsets.only(top: 15.0, left: 10),
                          child: Text(
                            "${viewDetailsModel?.object?.userName}",
                            style: TextStyle(
                                fontWeight: FontWeight.w400,
                                color: Colors.grey.shade700,
                                fontFamily: "outfit",
                                fontSize: 15),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 36.0, top: 20),
                      child: Text(
                        "Email",
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                            fontFamily: "outfit",
                            fontSize: 15),
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Center(
                      child: Container(
                        height: 50,
                        width: _width / 1.2,
                        decoration: BoxDecoration(
                            color: Color(0xFFF6F6F6),
                            borderRadius: BorderRadius.circular(10)),
                        child: Padding(
                          padding: const EdgeInsets.only(top: 15.0, left: 10),
                          child: Text(
                            "${viewDetailsModel?.object?.userEmail}",
                            style: TextStyle(
                                fontWeight: FontWeight.w400,
                                color: Colors.grey.shade700,
                                fontFamily: "outfit",
                                fontSize: 15),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 36.0, top: 20),
                      child: Text(
                        "Contact no.",
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                            fontFamily: "outfit",
                            fontSize: 15),
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Center(
                      child: Container(
                        height: 50,
                        width: _width / 1.2,
                        decoration: BoxDecoration(
                            color: Color(0xFFF6F6F6),
                            borderRadius: BorderRadius.circular(10)),
                        child: Padding(
                          padding: const EdgeInsets.only(top: 15.0, left: 10),
                          child: Text(
                            "${viewDetailsModel?.object?.userMobile}",
                            style: TextStyle(
                                fontWeight: FontWeight.w400,
                                color: Colors.grey.shade700,
                                fontFamily: "outfit",
                                fontSize: 15),
                          ),
                        ),
                      ),
                    ),
                  ]),
            );
          },
        ));
  }
}
