import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:pds/API/Bloc/NewProfileScreen_Bloc/NewProfileScreen_cubit.dart';
import 'package:pds/API/Bloc/NewProfileScreen_Bloc/NewProfileScreen_state.dart';
import 'package:pds/core/utils/color_constant.dart';
import 'package:pds/presentation/%20new/AddWorkExperience_Screen.dart';

import '../../API/Model/WorkExperience_Model/WorkExperience_model.dart';
import '../../core/app_export.dart';

class ExperienceEditScreen extends StatefulWidget {
  String? userID;
  String? typeName;
  ExperienceEditScreen({
    Key? key,
    this.userID,
    this.typeName,
  }) : super(key: key);

  @override
  State<ExperienceEditScreen> createState() => _ExperienceEditScreenState();
}

String? formattedDateStart;
String? formattedDateEnd;

class _ExperienceEditScreenState extends State<ExperienceEditScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    BlocProvider.of<NewProfileSCubit>(context)
        .GetWorkExperienceAPI(context, widget.userID.toString());
  }

  GetWorkExperienceModel? addWorkExperienceModel;
  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    double _height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
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
          'Work Experience',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: BlocConsumer<NewProfileSCubit, NewProfileSState>(
          listener: (context, state) {
        if (state is NewProfileSErrorState) {
          SnackBar snackBar = SnackBar(
            content: Text(state.error),
            backgroundColor: ColorConstant.primary_color,
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
        if (state is NewProfileSLoadingState) {
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
        if (state is DeleteWorkExpereinceLoadedState) {
          SnackBar snackBar = SnackBar(
            content: Text(state.deleteWorkExperienceModel.object ?? ""),
            backgroundColor: ColorConstant.primary_color,
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);

          Navigator.pop(context);
        }
        if (state is GetWorkExpereinceLoadedState) {
          addWorkExperienceModel = state.addWorkExperienceModel;
        }
      }, builder: (context, state) {
        return Column(
          children: [
            SizedBox(
              height: _height / 1.2,
              child: ListView.builder(
                padding: EdgeInsets.only(top: 10),
                itemCount: addWorkExperienceModel?.object?.length != null
                    ? addWorkExperienceModel?.object?.length
                    : 1,
                itemBuilder: (context, index) {
                  formattedDateStart = DateFormat('dd-MM-yyyy').format(
                      DateFormat('yyyy-MM-dd').parse(
                          addWorkExperienceModel?.object?[index].startDate ??
                              DateTime.now().toIso8601String()));
                  formattedDateEnd = DateFormat('dd-MM-yyyy').format(
                      DateFormat('yyyy-MM-dd').parse(
                          addWorkExperienceModel?.object?[index].endDate ??
                              DateTime.now().toIso8601String()));
                  return Padding(
                    padding:
                        const EdgeInsets.only(top: 20, left: 20, right: 20),
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(10)),
                      child: ListTile(
                        titleAlignment: ListTileTitleAlignment.top,
                        leading: addWorkExperienceModel
                                        ?.object?[index].userProfilePic !=
                                    null &&
                                addWorkExperienceModel
                                        ?.object?[index].userProfilePic !=
                                    ''
                            ? CircleAvatar(
                                backgroundImage: NetworkImage(
                                    addWorkExperienceModel
                                            ?.object?[index].userProfilePic
                                            .toString() ??
                                        ''),
                              )
                            : CustomImageView(
                                imagePath: ImageConstant.tomcruse,
                                height: 32,
                                width: 32,
                                fit: BoxFit.fill,
                                radius: BorderRadius.circular(25),
                              ),
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                '${addWorkExperienceModel?.object?[index].companyName}',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            Row(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(context, MaterialPageRoute(
                                      builder: (context) {
                                        return AddWorkExperienceScreen(
                                          workUserID: addWorkExperienceModel
                                              ?.object?[index]
                                              .workExperienceUid,
                                          typeName: widget.typeName,
                                          companyName: addWorkExperienceModel
                                              ?.object?[index].companyName,
                                          edit: true,
                                          endDate: formattedDateEnd,
                                          expertise: addWorkExperienceModel
                                              ?.object?[index].expertiseIn,
                                          industryType: addWorkExperienceModel
                                              ?.object?[index].industryType,
                                          jobProfile: addWorkExperienceModel
                                              ?.object?[index].jobProfile,
                                          startDate: formattedDateStart,
                                          userID: widget.userID,
                                        );
                                      },
                                    ));
                                  },
                                  child: Icon(
                                    Icons.edit,
                                    color: Colors.black,
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    showDialog(
                                        context: context,
                                        builder: (context) {
                                          return Center(
                                            child: Container(
                                                color: Colors.white,
                                                margin: EdgeInsets.only(
                                                    left: 20, right: 20),
                                                height: 200,
                                                width: _width,
                                                // color: Colors.amber,
                                                child: Column(
                                                  children: [
                                                    SizedBox(
                                                      height: 10,
                                                    ),
                                                    Text(
                                                      "Delete Your Experience",
                                                      style: TextStyle(
                                                        fontFamily: 'outfit',
                                                        fontSize: 20,
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                    Divider(
                                                      color: Colors.grey,
                                                    ),
                                                    SizedBox(
                                                      height: 5,
                                                    ),
                                                    Center(
                                                        child: Text(
                                                      "Are You Sure You Want To Delete",
                                                      style: TextStyle(
                                                        fontFamily: 'outfit',
                                                        fontSize: 15,
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      ),
                                                    )),
                                                    SizedBox(
                                                      height: 50,
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceEvenly,
                                                      children: [
                                                        GestureDetector(
                                                          onTap: () =>
                                                              Navigator.pop(
                                                                  context),
                                                          child: Container(
                                                            height: 43,
                                                            width: _width / 3.5,
                                                            decoration: BoxDecoration(
                                                                color: Colors
                                                                    .transparent,
                                                                border: Border.all(
                                                                    color: Colors
                                                                        .grey
                                                                        .shade400),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            10)),
                                                            child: Center(
                                                                child: Text(
                                                              "Cancel",
                                                              style: TextStyle(
                                                                fontFamily:
                                                                    'outfit',
                                                                fontSize: 15,
                                                                color: Color(
                                                                    0xFFED1C25),
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400,
                                                              ),
                                                            )),
                                                          ),
                                                        ),
                                                        GestureDetector(
                                                          onTap: () {
                                                            BlocProvider.of<
                                                                        NewProfileSCubit>(
                                                                    context)
                                                                .DeleteWorkExperienceAPI(
                                                                    "${addWorkExperienceModel?.object?[index].workExperienceUid}",
                                                                    context);
                                                          },
                                                          child: Container(
                                                            height: 43,
                                                            width: _width / 3.5,
                                                            decoration: BoxDecoration(
                                                                color: Color(
                                                                    0xFFED1C25),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            10)),
                                                            child: Center(
                                                                child: Text(
                                                              "Delete",
                                                              style: TextStyle(
                                                                fontFamily:
                                                                    'outfit',
                                                                fontSize: 15,
                                                                color: Colors
                                                                    .white,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400,
                                                              ),
                                                            )),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                )),
                                          );
                                        }).then((value) => BlocProvider.of<
                                            NewProfileSCubit>(context)
                                        .GetWorkExperienceAPI(
                                            context, widget.userID.toString()));
                                  },
                                  child: Image.asset(
                                    ImageConstant.deleteIcon,
                                    color: Colors.black,
                                    height: 20,
                                    width: 20,
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                        subtitle: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              '${addWorkExperienceModel?.object?[index].jobProfile}',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 13,
                              ),
                            ),
                            widget.typeName == "EXPERT"
                                ? Text(
                                    '${addWorkExperienceModel?.object?[index].expertiseIn}',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 13,
                                    ),
                                  )
                                : SizedBox(),
                            Text(
                              '${addWorkExperienceModel?.object?[index].industryType}',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 13,
                              ),
                            ),
                            addWorkExperienceModel?.object?[index].startDate !=
                                        null &&
                                    addWorkExperienceModel
                                            ?.object?[index].endDate !=
                                        null
                                ? Text(
                                    '${formattedDateStart} to ${formattedDateEnd}',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 13,
                                    ),
                                  )
                                : SizedBox(),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        );
      }),
      floatingActionButton: GestureDetector(
        onTap: () {
          print("widget.typeNamewidget.typeName == ${widget.typeName}");
          Navigator.push(context, MaterialPageRoute(
            builder: (context) {
              return AddWorkExperienceScreen(
                typeName: widget.typeName,
                userID: widget.userID,
              );
            },
          ));
        },
        child: CustomImageView(
          imagePath: ImageConstant.addroomimage,
          height: 55,
          alignment: Alignment.bottomRight,
        ),
      ),
    );
  }
}
