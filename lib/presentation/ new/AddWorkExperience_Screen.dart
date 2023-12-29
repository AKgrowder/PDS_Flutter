import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:pds/API/Model/FetchExprtiseModel/fetchExprtiseModel.dart';
import 'package:pds/API/Model/IndustrytypeModel/Industrytype_Model.dart';
import 'package:pds/core/utils/color_constant.dart';

import '../../API/Bloc/NewProfileScreen_Bloc/NewProfileScreen_cubit.dart';
import '../../API/Bloc/NewProfileScreen_Bloc/NewProfileScreen_state.dart';

class AddWorkExperienceScreen extends StatefulWidget {
  String? workUserID;
  String? typeName;
  bool? edit;
  String? companyName;
  String? jobProfile;
  String? startDate;
  String? endDate;
  String? industryType;
  String? expertise;
  String? industryTypeID;
  String? expertiseID;
  String? userID;
  AddWorkExperienceScreen(
      {Key? key,
      this.typeName,
      this.edit,
      this.companyName,
      this.jobProfile,
      this.startDate,
      this.endDate,
      this.industryType,
      this.expertise,
      this.industryTypeID,
      this.expertiseID,
      this.workUserID,
      this.userID})
      : super(key: key);

  @override
  State<AddWorkExperienceScreen> createState() =>
      _AddWorkExperienceScreenState();
}

class Expertise {
  final String uid;
  final String expertiseName;
  Expertise(this.uid, this.expertiseName);
}

class IndustryType {
  final String industryTypeUid;
  final String industryTypeName;
  IndustryType(this.industryTypeUid, this.industryTypeName);
}

class _AddWorkExperienceScreenState extends State<AddWorkExperienceScreen> {
  TextEditingController companyNameController = TextEditingController();
  TextEditingController JobProfileController = TextEditingController();
  TextEditingController IndustryTypeController = TextEditingController();
  TextEditingController StartDateController = TextEditingController();
  TextEditingController EndDateController = TextEditingController();
  TextEditingController ExpertiseInController = TextEditingController();
  bool value = false;
  bool valuesecond = false;
  List<Expertise> expertiseData = [];
  Expertise? selectedExpertise;
  FetchExprtise? _fetchExprtise;
  List<IndustryType> _industryTypes = [];
  IndustryType? selectedIndustryTypes;
  IndustryTypeModel? industryTypeModel;
  String? formattedDateStart;
  String? apiDateStart;
  String? apiDatepresent;
  String? apiDateEnd;
  String? formattedDateEnd;
  DateTime? pickedStartDate;

  void initState() {
    super.initState();
    if (widget.typeName != "COMPANY") {
      BlocProvider.of<NewProfileSCubit>(context).fetchExprties(context);
    }
    print("widget.endDate"+widget.endDate.toString());
    valuesecond= widget.endDate=="Present";
    BlocProvider.of<NewProfileSCubit>(context).IndustryTypeAPI(context);
    if (widget.edit == true) {
      companyNameController.text = widget.companyName.toString();
      JobProfileController.text = widget.jobProfile.toString();

      StartDateController.text = widget.startDate.toString();
      EndDateController.text = widget.endDate.toString();
      print("startDate${widget.startDate.toString()}");
      print("endDate${widget.endDate.toString()}");
      

      //  widget.typeName != "COMPANY" ? selectedExpertise.expertiseName = widget.expertise : "";
    }
  }

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
          'Add Work Experience',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: BlocConsumer<NewProfileSCubit, NewProfileSState>(
        listener: (context, state) async {
          if (state is NewProfileSErrorState) {
            SnackBar snackBar = SnackBar(
              content: Text(state.error),
              backgroundColor: ColorConstant.primary_color,
            );
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          }
          if (state is FetchexprtiseRoomLoadedState) {
            _fetchExprtise = state.fetchExprtise;

            expertiseData = state.fetchExprtise.object!
                .map((expertiseJson) => Expertise(
                      expertiseJson.uid.toString(),
                      expertiseJson.expertiseName.toString(),
                    ))
                .toList();
            expertiseData.forEach((element) {
              if (element.expertiseName == widget.expertise) {
                selectedExpertise = element;
              }
            });
          }
          if (state is IndustryTypeLoadedState) {
            print("this is the calling");
            industryTypeModel = state.industryTypeModel;
            _industryTypes =
                state.industryTypeModel.object!.map((industryTypejson) {
              return IndustryType(industryTypejson.industryTypeUid.toString(),
                  industryTypejson.industryTypeName.toString());
            }).toList();
            _industryTypes.forEach((element) {
              if (element.industryTypeName == widget.industryType) {
                selectedIndustryTypes = element;
              }
            });
            //ankur

            // List<IndustryType> industryTypeData1 = state
            //     .industryTypeModel.object!
            //     .map((industryType) => IndustryType(
            //         industryType.industryTypeUid ?? '',
            //         industryType.industryTypeName ?? ''))
            //     .toList();
            // _industryTypes = industryTypeData1
            //     .map((industryType) => MultiSelectItem(
            //         industryType, industryType.industryTypeName))
            //     .toList();
          }
          if (state is AddWorkExpereinceLoadedState) {
            SnackBar snackBar = SnackBar(
              content: Text(state.addWorkExperienceModel.object.toString()),
              backgroundColor: ColorConstant.primary_color,
            );
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
            BlocProvider.of<NewProfileSCubit>(context)
                .GetWorkExperienceAPI(context, widget.userID.toString());
            Navigator.pop(context);
          }
        },
        builder: (context, state) {
          return SingleChildScrollView(
            child: Stack(
              children: [
                Container(
                  height: _height / 1.2,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 36, right: 36),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 15, bottom: 10),
                            child: Text(
                              "Company Name",
                              style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w500,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          customTextFeild(
                              controller: companyNameController,
                              width: _width / 1.1,
                              hintText: "Company Name",
                              maxLength: 50,
                              textInputAction: TextInputAction.next),
                          Padding(
                            padding: const EdgeInsets.only(top: 15, bottom: 10),
                            child: Text(
                              "Job Profile",
                              style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w500,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          customTextFeild(
                              controller: JobProfileController,
                              width: _width / 1.1,
                              hintText: "Job Profile",
                              maxLength: 50,
                              textInputAction: TextInputAction.next),
                          Padding(
                            padding: const EdgeInsets.only(top: 15, bottom: 10),
                            child: Text(
                              "Industry Type",
                              style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w500,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          Container(
                            width: _width,
                            decoration: BoxDecoration(
                                border: Border.all(
                                  color: Color.fromARGB(255, 157, 157, 157),
                                ),
                                borderRadius: BorderRadius.circular(5)),
                            child: DropdownButtonHideUnderline(
                              child: Padding(
                                padding: EdgeInsets.only(left: 12),
                                child: DropdownButton<IndustryType>(
                                  value: selectedIndustryTypes,
                                  hint: Text('Please select an option'),
                                  onChanged: (IndustryType? newValue) {
                                    // When the user selects an option from the dropdown.
                                    if (newValue != null) {
                                      setState(() {
                                        selectedIndustryTypes = newValue;
                                        print(
                                            "SelectedIndustryType: ${newValue.industryTypeUid}");
                                      });
                                    }
                                  },
                                  items: _industryTypes
                                      .map<DropdownMenuItem<IndustryType>>(
                                          (IndustryType industryType) {
                                    return DropdownMenuItem<IndustryType>(
                                      value: industryType,
                                      child:
                                          Text(industryType.industryTypeName),
                                    );
                                  }).toList(),
                                ),
                              ),
                            ), /* DropdownButtonHideUnderline(
                                          child: Padding(
                                            padding: EdgeInsets.only(left: 12),
                                            child: MultiSelectDialogField<IndustryType>(
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: Colors.transparent)),
                                              buttonIcon: Icon(
                                                Icons.expand_more,
                                                color: Colors.black,
                                              ),
                                              items: _industryTypes!,
                                              listType: MultiSelectListType.LIST,
                                              onConfirm: (values) {
                                                selectedIndustryTypes = values;
                                                selectedIndustryTypes
                                                    .forEach((element) {
                                                  print(
                                                      "sxfgsdfghdfghdfgh${element.industryTypeUid}");
                                                  industryUUID.add(
                                                      "${element.industryTypeUid}");
                                                });
                                                setState(() {});
                                              },
                                            ),
                                          ),
                                        ), */
                          ),
                          widget.typeName != "COMPANY"
                              ? Padding(
                                  padding: const EdgeInsets.only(
                                      top: 15, bottom: 10),
                                  child: Text(
                                    "Expertise In",
                                    style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black,
                                    ),
                                  ),
                                )
                              : SizedBox(),
                          widget.typeName != "COMPANY"
                              ? Container(
                                  height: 50,
                                  width: _width,
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                        color:
                                            Color.fromARGB(255, 157, 157, 157),
                                      ),
                                      borderRadius: BorderRadius.circular(5)),
                                  child: DropdownButtonHideUnderline(
                                    child: Padding(
                                      padding: EdgeInsets.only(left: 12),
                                      child: DropdownButton<Expertise>(
                                        value: selectedExpertise,
                                        hint: Text('Please select an option'),
                                        onChanged: (Expertise? newValue) {
                                          // When the user selects an option from the dropdown.
                                          if (newValue != null) {
                                            setState(() {
                                              selectedExpertise = newValue;
                                              print(
                                                  "Selectedexpertise: ${newValue.uid}");
                                            });
                                          }
                                        },
                                        items: expertiseData
                                            .map<DropdownMenuItem<Expertise>>(
                                                (Expertise expertise) {
                                          return DropdownMenuItem<Expertise>(
                                            value: expertise,
                                            child:
                                                Text(expertise.expertiseName),
                                          );
                                        }).toList(),
                                      ),
                                    ),
                                  ),
                                )
                              : SizedBox(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Checkbox( 
                                activeColor: ColorConstant.primary_color,
                                value: this.valuesecond,
                                onChanged: (bool? value ) {
                                  setState(() {
                                    this.valuesecond = value!;

                                    if (valuesecond == true) {
                                      EndDateController.text = "Present";
                                    } else {
                                      EndDateController.text = "";
                                    }
                                  });
                                },
                              ),
                              Text("Current Working in this Role"),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 15, bottom: 10),
                                    child: Text(
                                      "Start Date",
                                      style: TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                  customTextFeild(
                                    controller: StartDateController,
                                    width: _width / 2.8,
                                    hintText: "dd-mm-yyyy",
                                    isReadOnly: true,
                                    textInputAction: TextInputAction.next,
                                    onTap: () async {
                                      pickedStartDate = await showDatePicker(
                                          context: context,
                                          initialDate: DateTime.now(),
                                          firstDate: DateTime(2000),
                                          lastDate: DateTime.now());

                                      if (pickedStartDate != null) {
                                        print(
                                            "pickedStartDate${pickedStartDate}");
                                        formattedDateStart =
                                            DateFormat('dd-MM-yyyy').format(
                                                pickedStartDate ??
                                                    DateTime.now());
                                        apiDateStart = DateFormat('yyyy-MM-dd')
                                            .format(pickedStartDate ??
                                                DateTime.now());

                                        print(
                                            "formattedDate Start--${formattedDateStart}");

                                        setState(() {
                                          StartDateController.text =
                                              formattedDateStart.toString();
                                        });
                                      } else {
                                        print("Date is not selected");
                                      }
                                    },
                                  ),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 15, bottom: 10),
                                    child: /* valuesecond==true? Text(
                                      "Current Date",
                                      style: TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black,
                                      ),
                                    ): */
                                        Text(
                                      "End Date",
                                      style: TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                  customTextFeild(
                                    controller: EndDateController,
                                    width: _width / 2.8,
                                    hintText: "dd-mm-yyyy",
                                    isReadOnly: true,
                                    textInputAction: TextInputAction.next,
                                    onTap: () async {
                                      if (valuesecond != true) {
                                        if (StartDateController
                                            .text.isNotEmpty) {
                                          DateTime? pickedDate =
                                              await showDatePicker(
                                                  context: context,
                                                  initialDate:
                                                      pickedStartDate ??
                                                          DateTime.now(),
                                                  firstDate: pickedStartDate ??
                                                      DateTime.now(),
                                                  lastDate: DateTime(2101));

                                          if (pickedDate != null) {
                                            print(pickedDate);
                                            formattedDateEnd =
                                                DateFormat('dd-MM-yyyy')
                                                    .format(pickedDate);
                                            apiDateEnd =
                                                DateFormat('yyyy-MM-dd')
                                                    .format(pickedDate);
                                            print(
                                                "formattedDate end--${formattedDateEnd}");

                                            setState(() {
                                              EndDateController.text =
                                                  formattedDateEnd.toString();
                                            });
                                          } else {
                                            print("Date is not selected");
                                          }
                                        } else {
                                          SnackBar snackBar = SnackBar(
                                            content: Text(
                                                'Please Select Start Date'),
                                            backgroundColor:
                                                ColorConstant.primary_color,
                                          );
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(snackBar);
                                        }
                                      }
                                    },
                                  ),
                                ],
                              )
                            ],
                          ),
                        ]),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 36, right: 36),
                    child: GestureDetector(
                      onTap: () {
                        if (widget.edit == true) {
                          if (widget.typeName == "COMPANY") {
                            if (companyNameController.text == null ||
                                companyNameController.text == "") {
                              SnackBar snackBar = SnackBar(
                                content: Text('Please Enter Company Name'),
                                backgroundColor: ColorConstant.primary_color,
                              );
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                            } else if (companyNameController.text.isNotEmpty &&
                                companyNameController.text.length < 4) {
                              SnackBar snackBar = SnackBar(
                                content: Text(
                                    'Minimum length required in Company Namne'),
                                backgroundColor: ColorConstant.primary_color,
                              );
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                            } else if (JobProfileController.text == null ||
                                JobProfileController.text == "") {
                              SnackBar snackBar = SnackBar(
                                content: Text('Please Enter Job Profile'),
                                backgroundColor: ColorConstant.primary_color,
                              );
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                            } else if (JobProfileController.text.isNotEmpty &&
                                JobProfileController.text.length < 4) {
                              SnackBar snackBar = SnackBar(
                                content: Text(
                                    'Minimum length required in Job Profiie'),
                                backgroundColor: ColorConstant.primary_color,
                              );
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                            } else if (selectedIndustryTypes?.industryTypeName
                                    .toString() ==
                                null) {
                              SnackBar snackBar = SnackBar(
                                content: Text('Please Selcted Industry Type'),
                                backgroundColor: ColorConstant.primary_color,
                              );
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                            } else if (StartDateController.text.isEmpty) {
                              SnackBar snackBar = SnackBar(
                                content: Text('Please select Start Date'),
                                backgroundColor: ColorConstant.primary_color,
                              );
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                            } else if (EndDateController.text.isEmpty) {
                              SnackBar snackBar = SnackBar(
                                content: Text('Please select End Date'),
                                backgroundColor: ColorConstant.primary_color,
                              );
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                            } else {
                              apiDatepresent = DateFormat('yyyy-MM-dd')
                                  .format(DateTime.now());
                              print("date print -- ${apiDatepresent}");
                              var params = {
                                "companyName": companyNameController.text,
                                "industryType":
                                    selectedIndustryTypes?.industryTypeName,
                                "jobProfile": JobProfileController.text,
                                "endDate": EndDateController.text == "Present"
                                    ? apiDatepresent
                                    : apiDateEnd,
                                "startDate": apiDateStart,
                                "userWorkExperienceUid": widget.workUserID
                              };
                              print(
                                  "AddWorkExperienceAPIAddWorkExperienceAPI${params}");
                              BlocProvider.of<NewProfileSCubit>(context)
                                  .AddWorkExperienceAPI(params, context);
                            }
                          } else {
                            if (companyNameController.text == null ||
                                companyNameController.text == "") {
                              SnackBar snackBar = SnackBar(
                                content: Text('Please Enter Company Name'),
                                backgroundColor: ColorConstant.primary_color,
                              );
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                            } else if (companyNameController.text.isNotEmpty &&
                                companyNameController.text.length < 4) {
                              SnackBar snackBar = SnackBar(
                                content: Text(
                                    'Minimum length required in Company Name'),
                                backgroundColor: ColorConstant.primary_color,
                              );
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                            } else if (JobProfileController.text == null ||
                                JobProfileController.text == "") {
                              SnackBar snackBar = SnackBar(
                                content: Text('Please Enter Job Profile'),
                                backgroundColor: ColorConstant.primary_color,
                              );
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                            } else if (JobProfileController.text.isNotEmpty &&
                                JobProfileController.text.length < 4) {
                              SnackBar snackBar = SnackBar(
                                content: Text(
                                    'Minimum length required in Job Profiie'),
                                backgroundColor: ColorConstant.primary_color,
                              );
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                            } else if (selectedExpertise?.expertiseName
                                    .toString() ==
                                null) {
                              SnackBar snackBar = SnackBar(
                                content: Text('Please select Expertise in'),
                                backgroundColor: ColorConstant.primary_color,
                              );
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                            } else if (selectedIndustryTypes?.industryTypeName
                                    .toString() ==
                                null) {
                              SnackBar snackBar = SnackBar(
                                content: Text('Please Selcted Industry Type'),
                                backgroundColor: ColorConstant.primary_color,
                              );
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                            } else if (StartDateController.text.isEmpty) {
                              SnackBar snackBar = SnackBar(
                                content: Text('Please select Start Date'),
                                backgroundColor: ColorConstant.primary_color,
                              );
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                            } else if (EndDateController.text.isEmpty) {
                              SnackBar snackBar = SnackBar(
                                content: Text('Please select End Date'),
                                backgroundColor: ColorConstant.primary_color,
                              );
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                            } else {
                              apiDatepresent = DateFormat('yyyy-MM-dd')
                                  .format(DateTime.now());
                              var params1 = {
                                "companyName": companyNameController.text,
                                "industryType":
                                    selectedIndustryTypes?.industryTypeName,
                                "expertiseIn": selectedExpertise?.expertiseName,
                                "jobProfile": JobProfileController.text,
                                "endDate": EndDateController.text == "Present"
                                    ? apiDatepresent
                                    : apiDateEnd,
                                "startDate": apiDateStart,
                                "userWorkExperienceUid": widget.workUserID
                              };
                              print("NewProfileSCubit${params1}");
                              print("widget.workUserID${widget.workUserID}");
                              BlocProvider.of<NewProfileSCubit>(context)
                                  .AddWorkExperienceAPI(params1, context);
                            }
                          }
                        } else {
                          if (widget.typeName == "COMPANY") {
                            if (companyNameController.text == null ||
                                companyNameController.text == "") {
                              SnackBar snackBar = SnackBar(
                                content: Text('Please Enter Company Name'),
                                backgroundColor: ColorConstant.primary_color,
                              );
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                            } else if (companyNameController.text.isNotEmpty &&
                                companyNameController.text.length < 4) {
                              SnackBar snackBar = SnackBar(
                                content: Text(
                                    'Minimum length required in Company Name'),
                                backgroundColor: ColorConstant.primary_color,
                              );
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                            } else if (JobProfileController.text == null ||
                                JobProfileController.text == "") {
                              SnackBar snackBar = SnackBar(
                                content: Text('Please Enter Job Profile'),
                                backgroundColor: ColorConstant.primary_color,
                              );
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                            } else if (JobProfileController.text.isNotEmpty &&
                                JobProfileController.text.length < 4) {
                              SnackBar snackBar = SnackBar(
                                content: Text(
                                    'Minimum length required in Job Profiie'),
                                backgroundColor: ColorConstant.primary_color,
                              );
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                            } else if (selectedIndustryTypes?.industryTypeName
                                    .toString() ==
                                null) {
                              SnackBar snackBar = SnackBar(
                                content: Text('Please Selcted Industry Type'),
                                backgroundColor: ColorConstant.primary_color,
                              );
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                            } else if (StartDateController.text.isEmpty) {
                              SnackBar snackBar = SnackBar(
                                content: Text('Please select Start Date'),
                                backgroundColor: ColorConstant.primary_color,
                              );
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                            } else if (EndDateController.text.isEmpty) {
                              SnackBar snackBar = SnackBar(
                                content: Text('Please select End Date'),
                                backgroundColor: ColorConstant.primary_color,
                              );
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                            } else {
                              apiDatepresent = DateFormat('yyyy-MM-dd')
                                  .format(DateTime.now());
                              var params = {
                                "companyName": companyNameController.text,
                                "industryType":
                                    selectedIndustryTypes?.industryTypeName,
                                "jobProfile": JobProfileController.text,
                                "endDate": EndDateController.text == "Present"
                                    ? apiDatepresent
                                    : apiDateEnd,
                                "startDate": apiDateStart
                              };
                              print(
                                  "AddWorkExperienceAPIAddWorkExperienceAPI${params}");
                              BlocProvider.of<NewProfileSCubit>(context)
                                  .AddWorkExperienceAPI(params, context);
                            }
                          } else {
                            if (companyNameController.text == null ||
                                companyNameController.text == "") {
                              SnackBar snackBar = SnackBar(
                                content: Text('Please Enter Company Name'),
                                backgroundColor: ColorConstant.primary_color,
                              );
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                            } else if (companyNameController.text.isNotEmpty &&
                                companyNameController.text.length < 4) {
                              SnackBar snackBar = SnackBar(
                                content: Text(
                                    'Minimum length required in Company Name'),
                                backgroundColor: ColorConstant.primary_color,
                              );
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                            } else if (JobProfileController.text == null ||
                                JobProfileController.text == "") {
                              SnackBar snackBar = SnackBar(
                                content: Text('Please Enter Job Profile'),
                                backgroundColor: ColorConstant.primary_color,
                              );
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                            } else if (JobProfileController.text.isNotEmpty &&
                                JobProfileController.text.length < 4) {
                              SnackBar snackBar = SnackBar(
                                content: Text(
                                    'Minimum length required in Job Profiie'),
                                backgroundColor: ColorConstant.primary_color,
                              );
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                            } else if (selectedExpertise?.expertiseName
                                    .toString() ==
                                null) {
                              SnackBar snackBar = SnackBar(
                                content: Text('Please select Expertise in'),
                                backgroundColor: ColorConstant.primary_color,
                              );
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                            } else if (selectedIndustryTypes?.industryTypeName
                                    .toString() ==
                                null) {
                              SnackBar snackBar = SnackBar(
                                content: Text('Please Selcted Industry Type'),
                                backgroundColor: ColorConstant.primary_color,
                              );
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                            } else if (StartDateController.text.isEmpty) {
                              SnackBar snackBar = SnackBar(
                                content: Text('Please select Start Date'),
                                backgroundColor: ColorConstant.primary_color,
                              );
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                            } else if (EndDateController.text.isEmpty) {
                              SnackBar snackBar = SnackBar(
                                content: Text('Please select End Date'),
                                backgroundColor: ColorConstant.primary_color,
                              );
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                            } else {
                              apiDatepresent = DateFormat('yyyy-MM-dd')
                                  .format(DateTime.now());
                              var params1 = {
                                "companyName": companyNameController.text,
                                "industryType":
                                    selectedIndustryTypes?.industryTypeName,
                                "expertiseIn": selectedExpertise?.expertiseName,
                                "jobProfile": JobProfileController.text,
                                "endDate": EndDateController.text == "Present"
                                    ? apiDatepresent
                                    : apiDateEnd,
                                "startDate": apiDateStart,
                              };
                              print("NewProfileSCubit${params1}");
                              print("widget.workUserID${widget.workUserID}");
                              BlocProvider.of<NewProfileSCubit>(context)
                                  .AddWorkExperienceAPI(params1, context);
                            }
                          }
                        }
                      },
                      child: Container(
                        height: 50,
                        width: _width,
                        decoration: BoxDecoration(
                            color: ColorConstant.primary_color,
                            borderRadius: BorderRadius.circular(10)),
                        child: Center(
                          child: Text(
                           "Save",
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  customTextFeild(
      {double? width,
      TextEditingController? controller,
      Color? color,
      String? hintText,
      bool? isReadOnly,
      List<TextInputFormatter>? inputFormatters,
      void Function()? onTap,
      int? maxLength,
      TextInputAction? textInputAction}) {
    return Container(
      // height: 50,
      width: width,
      decoration: BoxDecoration(
          color: color,
          border: Border.all(
            color: Color.fromARGB(255, 157, 157, 157),
          ),
          borderRadius: BorderRadius.circular(5)),
      child: Padding(
        padding: EdgeInsets.only(left: 12),
        child: TextFormField(
          maxLength: maxLength,
          onTap: onTap,
          readOnly: isReadOnly ?? false,
          controller: controller,
          autofocus: false,
          inputFormatters: inputFormatters,
          textInputAction: textInputAction,
          cursorColor: ColorConstant.primary_color,
          decoration: InputDecoration(
            counterText: "",
            hintText: hintText,
            hintStyle: TextStyle(color: Color(0xff565656)),
            border: InputBorder.none,
          ),
        ),
      ),
    );
  }
}
