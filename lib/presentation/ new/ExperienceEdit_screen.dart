import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pds/API/Bloc/NewProfileScreen_Bloc/NewProfileScreen_cubit.dart';
import 'package:pds/API/Bloc/NewProfileScreen_Bloc/NewProfileScreen_state.dart';
import 'package:pds/core/utils/color_constant.dart';
import 'package:pds/presentation/%20new/AddWorkExperience_Screen.dart';

import '../../API/Model/WorkExperience_Model/WorkExperience_model.dart';
import '../../core/app_export.dart';

class ExperienceEditScreen extends StatefulWidget {
  String? typeName;
  GetWorkExperienceModel? addWorkExperienceModel;
  ExperienceEditScreen({Key? key, this.typeName, this.addWorkExperienceModel})
      : super(key: key);

  @override
  State<ExperienceEditScreen> createState() => _ExperienceEditScreenState();
}

class _ExperienceEditScreenState extends State<ExperienceEditScreen> {
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
        if (state is DeleteWorkExpereinceLoadedState) {
          SnackBar snackBar = SnackBar(
            content: Text(state.deleteWorkExperienceModel.object ?? ""),
            backgroundColor: ColorConstant.primary_color,
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);

          Navigator.pop(context);
          Navigator.pop(context);
        }
      }, builder: (context, state) {
        return Column(
          children: [
            SizedBox(
              height: _height / 1.2,
              child: ListView.builder(
                padding: EdgeInsets.only(top: 10),
                itemCount: widget.addWorkExperienceModel?.object?.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding:
                        const EdgeInsets.only(top: 20, left: 20, right: 20),
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(10)),
                      child: ListTile(
                        titleAlignment: ListTileTitleAlignment.top,
                        leading: CustomImageView(
                          imagePath: ImageConstant.tomcruse,
                          height: 32,
                          width: 32,
                          fit: BoxFit.fill,
                          radius: BorderRadius.circular(25),
                        ),
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '${widget.addWorkExperienceModel?.object?[index].companyName}',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Row(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(context, MaterialPageRoute(
                                      builder: (context) {
                                        return AddWorkExperienceScreen(
                                          companyName: widget
                                              .addWorkExperienceModel
                                              ?.object?[index]
                                              .companyName,
                                          edit: true,
                                          endDate: widget.addWorkExperienceModel
                                              ?.object?[index].endDate,
                                          expertise: widget
                                              .addWorkExperienceModel
                                              ?.object?[index]
                                              .expertiseIn,
                                          industryType: widget
                                              .addWorkExperienceModel
                                              ?.object?[index]
                                              .industryType,
                                          jobProfile: widget
                                              .addWorkExperienceModel
                                              ?.object?[index]
                                              .jobProfile,
                                          startDate: widget
                                              .addWorkExperienceModel
                                              ?.object?[index]
                                              .startDate,
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
                                                                    "${widget.addWorkExperienceModel?.object?[index].workExperienceUid}",
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
                                        });
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
                              '${widget.addWorkExperienceModel?.object?[index].jobProfile}',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 13,
                              ),
                            ),
                            Text(
                              '${widget.addWorkExperienceModel?.object?[index].industryType}',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 13,
                              ),
                            ),
                            widget.addWorkExperienceModel?.object?[index]
                                            .startDate !=
                                        null &&
                                    widget.addWorkExperienceModel
                                            ?.object?[index].endDate !=
                                        null
                                ? Text(
                                    '${widget.addWorkExperienceModel?.object?[index].startDate} to ${widget.addWorkExperienceModel?.object?[index].endDate}',
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
