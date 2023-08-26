import 'dart:io';
import 'dart:math';

import 'package:pds/API/Bloc/FetchExprtise_Bloc/fetchExprtise_cubit.dart';
import 'package:pds/API/Bloc/FetchExprtise_Bloc/fetchExprtise_state.dart';
import 'package:pds/API/Model/FetchExprtiseModel/fetchExprtiseModel.dart';
import 'package:pds/API/Model/createDocumentModel/createDocumentModel.dart';
import 'package:pds/core/utils/color_constant.dart';
import 'package:pds/core/utils/sharedPreferences.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/utils/image_constant.dart';
import '../../theme/theme_helper.dart';
import '../../widgets/custom_text_form_field.dart';

class BecomeExpertScreen extends StatefulWidget {
  const BecomeExpertScreen({Key? key}) : super(key: key);

  @override
  State<BecomeExpertScreen> createState() => _BecomeExpertScreenState();
}

class Expertise {
  final String uid;
  final String expertiseName;

  Expertise(this.uid, this.expertiseName);
}

class _BecomeExpertScreenState extends State<BecomeExpertScreen> {
  double value2 = 0.0;
  double finalFileSize = 12.0;
  String? dopcument;
  String? filepath;
  FetchExprtise? _fetchExprtise;
  String? selctedIndex;
  List<Expertise> expertiseData = [];
  Expertise? selectedExpertise;
  // String selctedexpertiseData = "";

  @override
  List<String> working_houres = [
    'MORNING("9:00 AM", "12:00 PM"),',
    'AFTERNOON("1:00 PM", "5:00 PM"),',
    'EVENING("6:00 PM", "9:00 PM");'
  ];
  String selectedWorkingHoures = 'MORNING("9:00 AM", "12:00 PM"),';
  TextEditingController jobprofileController = TextEditingController();
  TextEditingController feesController = TextEditingController();
  TextEditingController uplopdfile = TextEditingController();
  TimeOfDay? _startTime;
  TimeOfDay? _endTime;
  ChooseDocument? chooseDocument;
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TimeOfDay initialTime = TimeOfDay(hour: 0, minute: 0);
  Future<void> _selectStartTime(BuildContext context) async {
    TimeOfDay initialTime = TimeOfDay(hour: 0, minute: 0);

    final pickedTime = await showTimePicker(
      context: context,
      initialTime: initialTime,
    );

    if (pickedTime != null && pickedTime != _startTime) {
      setState(() {
        _startTime = pickedTime;
      });
    }
  }

  Future<void> _selectEndTime(BuildContext context) async {
    TimeOfDay initialTime = TimeOfDay(hour: 0, minute: 0);

    final pickedTime = await showTimePicker(
      context: context,
      initialTime: initialTime,
    );

    if (pickedTime != null && pickedTime != _endTime) {
      setState(() {
        _endTime = pickedTime;
      });
    }
  }

  void initState() {
    super.initState();
    BlocProvider.of<FetchExprtiseRoomCubit>(context).fetchExprties(context);
    dopcument = 'Upload Image';
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
            color: Colors.grey,
          ),
        ),
        title: Text(
          "Become an Expert",
          style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black,
              fontFamily: "outfit",
              fontSize: 20),
        ),
      ),
      body: BlocConsumer<FetchExprtiseRoomCubit, FetchExprtiseRoomState>(
        listener: (context, state) {
          if (state is FetchExprtiseRoomLoadingState) {
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
          if (state is FetchExprtiseRoomErrorState) {
            SnackBar snackBar = SnackBar(
              content: Text(state.error),
              backgroundColor: ColorConstant.primary_color,
            );
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          }
          if (state is chooseDocumentLoadedextends) {
            chooseDocument = state.chooseDocumentuploded;
            // print('choosDocumentGetorNot-${chooseDocument?.object}');
            // SnackBar snackBar = SnackBar(
            //   content: Text(state.chooseDocumentuploded.message.toString()),
            //   backgroundColor: ColorConstant.primary_color,
            // );
            // ScaffoldMessenger.of(context).showSnackBar(snackBar);
          }

          if (state is FetchExprtiseRoomLoadedState) {
            _fetchExprtise = state.fetchExprtise;
            // selctedIndex = state.fetchExprtise.object?[0].expertiseName;

            expertiseData = state.fetchExprtise.object!
                .map((expertiseJson) => Expertise(
                      expertiseJson.uid.toString(),
                      expertiseJson.expertiseName.toString(),
                    ))
                .toList();

            // selectedExpertise =
            //     expertiseData.isNotEmpty ? expertiseData[0] : null;
          }
          if (state is AddExportLoadedState) {
            SnackBar snackBar = SnackBar(
              content: Text(state.addExpertProfile.message.toString()),
              backgroundColor: ColorConstant.primary_color,
            );
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
            Navigator.pop(context);
          }
        },
        builder: (context, state) {
          return Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(left: 30, right: 30, top: 10),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        height: _height / 15,
                        width: _width / 1,
                        decoration: BoxDecoration(
                            color: Color(0xFFFFE7E7),
                            borderRadius: BorderRadius.all(Radius.circular(5))),
                        child: Padding(
                          padding: const EdgeInsets.only(
                            top: 20.0,
                            left: 10,
                          ),
                          child: Text(
                            "Professional Details",
                            style: TextStyle(
                                fontFamily: 'outfit',
                                fontWeight: FontWeight.bold,
                                fontSize: 15),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          top: 18,
                        ),
                        child: Text(
                          "Job Profile",
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontFamily: 'outfit',
                            fontWeight: FontWeight.w500,
                          ),
                          // style: theme.textTheme.bodyLarge,
                        ),
                      ),
                      CustomTextFormField(
                        // focusNode: FocusNode(),
                        // autofocus: true,

                        controller: jobprofileController,
                        margin: EdgeInsets.only(
                          top: 4,
                        ),
                        contentPadding: EdgeInsets.only(
                          left: 12,
                          top: 14,
                          right: 12,
                          bottom: 14,
                        ),
                        validator: (value) {
                          RegExp nameRegExp = RegExp(r"^[a-zA-Z0-9\s'@]+$");
                          if (value!.isEmpty) {
                            return 'Please Enter Name';
                          } else if (!nameRegExp.hasMatch(value)) {
                            return 'Input cannot contains prohibited special characters';
                          } else if (value.length <= 0 || value.length > 50) {
                            return 'Minimum length required';
                          } else if (value.contains('..')) {
                            return 'username does not contain is correct';
                          }

                          return null;
                        },
                        // textStyle: theme.textTheme.titleMedium!,
                        hintText: "Job Profile",
                        // hintStyle: theme.textTheme.titleMedium!,
                        textInputAction: TextInputAction.next,
                        filled: true,
                        maxLength: 100,
                        fillColor: appTheme.gray100,
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          top: 18,
                        ),
                        child: Text(
                          "Expertise in",
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontFamily: 'outfit',
                            fontWeight: FontWeight.w500,
                          ),
                          // style: theme.textTheme.bodyLarge,
                        ),
                      ),
                      Container(
                        height: 50,
                        width: _width,
                        decoration: BoxDecoration(color: Color(0xffEFEFEF)),
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
                                    print("Selectedexpertise: ${newValue.uid}");
                                  });
                                }
                              },
                              items: expertiseData
                                  .map<DropdownMenuItem<Expertise>>(
                                      (Expertise expertise) {
                                return DropdownMenuItem<Expertise>(
                                  value: expertise,
                                  child: Text(expertise.expertiseName),
                                );
                              }).toList(),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          top: 18,
                        ),
                        child: Text(
                          "Fees",
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontFamily: 'outfit',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      CustomTextFormField(
                        // focusNode: FocusNode(),
                        // autofocus: true,
                        controller: feesController,
                        margin: EdgeInsets.only(
                          top: 4,
                        ),
                        contentPadding: EdgeInsets.only(
                          left: 12,
                          top: 14,
                          right: 12,
                          bottom: 14,
                        ),

                        inputFormatters: [
                          FilteringTextInputFormatter.allow(
                              RegExp(r'^\d{0,4}(\.\d{0,2})?')),
                        ],
                        textInputType: TextInputType.numberWithOptions(
                          decimal: true,
                        ),

                        // textStyle: theme.textTheme.titleMedium!,
                        hintText: "Price / hr",
                        // hintStyle: theme.textTheme.titleMedium!,
                        textInputAction: TextInputAction.next,
                        filled: true,
                        maxLength: 50,
                        fillColor: appTheme.gray100,
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          top: 18,
                        ),
                        child: Text(
                          "Working Hours",
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontFamily: 'outfit',
                            fontWeight: FontWeight.w500,
                          ),
                          // style: theme.textTheme.bodyLarge,
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () {
                              _selectStartTime(context);
                            },
                            child: Container(
                              height: 50,
                              width: 140,
                              decoration: BoxDecoration(
                                  color: Color(0xffF6F6F6),
                                  borderRadius: BorderRadius.circular(5)),
                              child: Row(
                                children: [
                                  Padding(
                                      padding: EdgeInsets.only(left: 20),
                                      child: Text(
                                        _startTime != null
                                            ? _startTime!
                                                .format(context)
                                                .toString()
                                                .split(' ')
                                                .first
                                            : '00:00',
                                        style: TextStyle(
                                            fontSize: 16,
                                            color: Color(0xff989898)),
                                      )),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 10, bottom: 6),
                                    child: VerticalDivider(
                                      thickness: 2,
                                      color: Color(0xff989898),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                      _startTime != null
                                          ? _startTime!
                                              .format(context)
                                              .toString()
                                              .split(' ')
                                              .last
                                          : 'AM',
                                      style: TextStyle(
                                          fontSize: 16,
                                          color: Color(0xff989898))),
                                ],
                              ),
                            ),
                          ),
                          Text('To'),
                          GestureDetector(
                            onTap: () {
                              _selectEndTime(context);
                            },
                            child: Container(
                              height: 50,
                              width: 140,
                              decoration: BoxDecoration(
                                  color: Color(0xffF6F6F6),
                                  borderRadius: BorderRadius.circular(5)),
                              child: Row(
                                children: [
                                  Padding(
                                      padding: EdgeInsets.only(left: 20),
                                      child: Text(
                                        _endTime != null
                                            ? _endTime!
                                                .format(context)
                                                .toString()
                                                .split(" ")
                                                .first
                                            : ' 00:00',
                                        style: TextStyle(
                                            fontSize: 16,
                                            color: Color(0xff989898)),
                                      )),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 10, bottom: 6),
                                    child: VerticalDivider(
                                      thickness: 2,
                                      color: Color(0xff989898),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                      _endTime != null
                                          ? _endTime!
                                              .format(context)
                                              .toString()
                                              .split(" ")
                                              .last
                                          : 'PM',
                                      style: TextStyle(
                                          fontSize: 16,
                                          color: Color(0xff989898))),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      //   children: [
                      //     Flexible(
                      //       child: Container(
                      //          height: 70,
                      //         // width: 150, // Adjust the w
                      //         child: TextField(
                      //           controller: _startTimeController,
                      //           readOnly: true,
                      //           onTap: () =>
                      //               _selectTime(context, _startTimeController),
                      //           decoration: InputDecoration(
                      //               filled: true,
                      //               fillColor: Color(0xffF6F6F6),
                      //               border: OutlineInputBorder(),
                      //               suffix: Container(
                      //                 height: 50,
                      //                 width: 2,
                      //                 margin: EdgeInsets.only(right: 30,top: 30,),
                      //                 color: Colors.amber,
                      //               )
                      //               //  suffixIcon: Icon(Icons.access_time),
                      //               ),
                      //         ),
                      //       ),
                      //     ),
                      //     SizedBox(width: 10),
                      //     Flexible(
                      //       child: TextField(
                      //         controller: _endTimeController,
                      //         readOnly: true,
                      //         onTap: () =>
                      //             _selectTime(context, _endTimeController),
                      //         decoration: InputDecoration(
                      //           // filled: true,
                      //           fillColor: Color(0xffF6F6F6),
                      //           border: OutlineInputBorder(),
                      //         ),
                      //       ),
                      //     ),
                      //   ],
                      // ),
                      // Container(
                      //   height: 50,
                      //   width: _width,
                      //   decoration: BoxDecoration(color: Color(0xffEFEFEF)),
                      //   child: DropdownButtonHideUnderline(
                      //     child: Padding(
                      //       padding: const EdgeInsets.only(left: 12),
                      //       child: DropdownButton<String>(
                      //         value: selectedWorkingHoures,
                      //         onChanged: (String? newValue) {
                      //           // When the user selects an option from the dropdown.
                      //           if (newValue != null) {
                      //             selectedWorkingHoures = newValue;
                      //             // Refresh the UI to reflect the selected item.
                      //             setState(() {});
                      //           }
                      //         },
                      //         items: working_houres
                      //             .map<DropdownMenuItem<String>>(
                      //                 (String value) {
                      //           return DropdownMenuItem<String>(
                      //             value: value,
                      //             child: Text(value.toLowerCase()),
                      //           );
                      //         }).toList(),
                      //       ),
                      //     ),
                      //   ),
                      // ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Document",
                        style: TextStyle(
                          fontFamily: 'outfit',
                          fontSize: 15,
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                              height: 50,
                              width: _width / 1.6,
                              decoration: BoxDecoration(
                                  color: Color(0XFFF6F6F6),
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(5),
                                      bottomLeft: Radius.circular(5))),
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(top: 15, left: 20),
                                child: Text(
                                  '${dopcument.toString()}',
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(fontSize: 16),
                                ),
                              )),
                          dopcument == "Upload Image"
                              ? GestureDetector(
                                  onTap: () async {
                                    filepath = await prepareTestPdf(0);
                                    print(
                                        'dopcument.toString()${dopcument.toString()}');
                                  },
                                  child: Container(
                                    height: 50,
                                    width: _width / 4.5,
                                    decoration: BoxDecoration(
                                        color: Color(0XFF777777),
                                        borderRadius: BorderRadius.only(
                                            topRight: Radius.circular(5),
                                            bottomRight: Radius.circular(5))),
                                    child: Center(
                                      child: Text(
                                        "Choose",
                                        style: TextStyle(
                                          fontFamily: 'outfit',
                                          fontSize: 15,
                                          color: Colors.white,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                              : Container(
                                  height: 50,
                                  width: _width / 4.5,
                                  decoration: BoxDecoration(
                                      color: Color.fromARGB(255, 228, 228, 228),
                                      borderRadius: BorderRadius.only(
                                          topRight: Radius.circular(5),
                                          bottomRight: Radius.circular(5))),
                                  child: GestureDetector(
                                      onTap: () {
                                        dopcument = "Upload Image";
                                        chooseDocument?.object = null;

                                        setState(() {});
                                      },
                                      child: Icon(
                                        Icons.delete_forever,
                                        color: ColorConstant.primary_color,
                                      )),
                                ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Only JPG, PNG & PDF allowed",
                            style: TextStyle(
                              fontFamily: 'outfit',
                              fontSize: 15,
                              color: Colors.grey,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            "Max size 12MB",
                            style: TextStyle(
                              fontFamily: 'outfit',
                              fontSize: 15,
                              color: Colors.black.withOpacity(0.6),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      GestureDetector(
                        onTap: () async {
                          print(
                              'i want to check data -${selectedExpertise?.expertiseName}');
                          final SharedPreferences prefs =
                              await SharedPreferences.getInstance();
                          String? userid =
                              await prefs.getString(PreferencesKey.loginUserID);
                          print("userid-$userid");
                          if (jobprofileController.text == null ||
                              jobprofileController.text == "") {
                            SnackBar snackBar = SnackBar(
                              content: Text('Please Enter job Profile'),
                              backgroundColor: ColorConstant.primary_color,
                            );
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                          } else if (jobprofileController.text.isNotEmpty &&
                              jobprofileController.text.length < 4) {
                            SnackBar snackBar = SnackBar(
                              content: Text('Minimum length required in Job Profiie'),
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
                          } else if (selectedExpertise?.expertiseName
                                  .toString() ==
                              null) {
                            SnackBar snackBar = SnackBar(
                              content: Text('Please select Expertise in'),
                              backgroundColor: ColorConstant.primary_color,
                            );
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                          } else if (feesController.text == null ||
                              feesController.text == '') {
                            SnackBar snackBar = SnackBar(
                              content: Text('Please select Fees'),
                              backgroundColor: ColorConstant.primary_color,
                            );
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                          } else if (feesController.text == null ||
                              feesController.text == '') {
                            SnackBar snackBar = SnackBar(
                              content: Text('Please select Fees'),
                              backgroundColor: ColorConstant.primary_color,
                            );
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                          } else if (_endTime == null && _startTime == null) {
                            SnackBar snackBar = SnackBar(
                              content: Text('Please select Working Hours'),
                              backgroundColor: ColorConstant.primary_color,
                            );
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                          } else if (_endTime == null && _startTime == null) {
                            SnackBar snackBar = SnackBar(
                              content: Text('Please Selcte Working Hours'),
                              backgroundColor: ColorConstant.primary_color,
                            );
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                          } else if (dopcument == 'Upload Image') {
                            SnackBar snackBar = SnackBar(
                              content: Text('Please Upload Image'),
                              backgroundColor: ColorConstant.primary_color,
                            );
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                          } else {
                            String time =
                                '${_startTime!.format(context).toString().split(" ").first} TO ${_endTime!.format(context).toString().split(" ").first}';
                            print(
                                'sddfsdm,gndfgj${chooseDocument?.object.toString()}');
                            dynamic params = {
                              "document":
                                  "${chooseDocument?.object.toString()}",
                              "expertUId": [
                                "${selectedExpertise?.uid.toString()}"
                              ],
                              "fees": feesController.text,
                              "jobProfile": jobprofileController.text,
                              "uid": userid.toString(),
                              "workingHours": time.toString(),
                            };
                            print('pwarems-$params');
                            BlocProvider.of<FetchExprtiseRoomCubit>(context)
                                .addExpertProfile(params,context);
                          }
                          /*     if (jobprofileController.text != null &&22
                              jobprofileController.text != "") {
                            if (jobprofileController.text.length < 4) {
                              SnackBar snackBar = SnackBar(
                                content: Text('Minimum length required'),
                                backgroundColor: ColorConstant.primary_color,
                              );
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                            }
                            if (selectedExpertise?.expertiseName.toString() !=
                                null) {
                              print('this conidison yes');
                              if (_endTime != null && _startTime != null) {
                                print('i want to check data -$dopcument');
                                if (dopcument == 'Upload Image') {
                                  print('upolded imah');
                                  SnackBar snackBar = SnackBar(
                                    content: Text('Please Upload Image'),
                                    backgroundColor:
                                        ColorConstant.primary_color,
                                  );
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(snackBar);
                                } else {
                                  String time =
                                      '${_startTime!.format(context).toString().split(" ").first} TO ${_endTime!.format(context).toString().split(" ").first}';
                                  print(
                                      'sddfsdm,gndfgj${chooseDocument?.object.toString()}');
                                  dynamic params = {
                                    "document":
                                        "${chooseDocument?.object.toString()}",
                                    "expertUId": [
                                      "${selectedExpertise?.uid.toString()}"
                                    ],
                                    "fees": feesController.text,
                                    "jobProfile": jobprofileController.text,
                                    "uid": userid.toString(),
                                    "workingHours": time.toString(),
                                  };
                                  print('pwarems-$params');
                                  BlocProvider.of<FetchExprtiseRoomCubit>(
                                          context)
                                      .addExpertProfile(params, context);
                                }
                              } else {
                                SnackBar snackBar = SnackBar(
                                  content: Text('Please Selcte Working Hours'),
                                  backgroundColor: ColorConstant.primary_color,
                                );
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(snackBar);
                              }
                            } else {
                              print('esle');
                              SnackBar snackBar = SnackBar(
                                content: Text('Please Selcte Expertise in'),
                                backgroundColor: ColorConstant.primary_color,
                              );
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                            }
                          } else {
                            SnackBar snackBar = SnackBar(
                              content: Text('Please Enter job Profile'),
                              backgroundColor: ColorConstant.primary_color,
                            );
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                          } */
                        },
                        child: Container(
                          alignment: Alignment.center,
                          margin: EdgeInsets.only(top: 15),
                          height: 50,
                          width: _width,
                          decoration: BoxDecoration(
                              color: Color(0xffED1C25),
                              borderRadius: BorderRadius.circular(5)),
                          child: Text(
                            'Submit',
                            style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'outfit',
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),
                      Align(
                        // alignment: Alignment.center,
                        child: Container(
                          // width: 330,
                          margin: EdgeInsets.only(
                            left: 10,
                            top: 16,
                            right: 10,
                          ),
                          child: RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: "By Submitting you are agreeing to ",
                                  style: TextStyle(
                                    color: appTheme.black900,
                                    fontSize: 14,
                                    fontFamily: 'Outfit',
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                TextSpan(
                                  text:
                                      "Terms & Conditions  Privacy & Policy  of PDS Terms",
                                  style: TextStyle(
                                    color: theme.colorScheme.primary,
                                    fontSize: 14,
                                    fontFamily: 'Outfit',
                                    fontWeight: FontWeight.w500,
                                    decoration: TextDecoration.underline,
                                  ),
                                ),
                              ],
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      )
                    ]),
              ),
            ),
          );
        },
      ),
    );
  }

  prepareTestPdf(
    int Index,
  ) async {
    PlatformFile file;

    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf', 'png', 'doc', 'jpg'],
    );
    {
      if (result != null) {
        file = result.files.first;

        if ((file.path?.contains(".mp4") ?? false) ||
            (file.path?.contains(".mov") ?? false) ||
            (file.path?.contains(".mp3") ?? false) ||
            (file.path?.contains(".m4a") ?? false)) {
          showDialog(
            context: context,
            builder: (ctx) => AlertDialog(
              title: Text(
                "Selected File Error",
                textScaleFactor: 1.0,
              ),
              content: Text(
                "Only PDF, PNG, JPG Supported.",
                textScaleFactor: 1.0,
              ),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(ctx).pop();
                  },
                  child: Container(
                    // color: Colors.green,
                    padding: const EdgeInsets.all(10),
                    child: const Text("Okay"),
                  ),
                ),
              ],
            ),
          );
        } else {
          getFileSize(file.path!, 1, result.files.first, Index);
        }

        /*     setState(() {
          // fileparth = file.path!;

          switch (Index) {
            case 1:
              GSTName = "";
              // file.name;

              break;
            case 2:
              PanName = file.name;

              break;
            case 3:
              UdhyanName = file.name;

              break;
            default:
          }

          BlocProvider.of<DocumentUploadCubit>(context)
              .documentUpload(file.path!);
        });  */
      } else {}
    }
    return "";
    // "${fileparth}";
  }

  getFileSize(
      String filepath, int decimals, PlatformFile file1, int Index) async {
    var file = File(filepath);
    int bytes = await file.length();
    if (bytes <= 0) return "0 B";
    const suffixes = ["B", "KB", "MB", "GB", "TB", "PB", "EB", "ZB", "YB"];
    var i = (log(bytes) / log(1024)).floor();
    var STR = ((bytes / pow(1024, i)).toStringAsFixed(decimals));
    print('getFileSizevariable-${file1.path}');
    value2 = double.parse(STR);

    print(value2);
    switch (i) {
      case 0:
        print("Done file size B");
        switch (Index) {
          case 1:
            if (file1.name.isNotEmpty || file1.name.toString() == null) {
              setState(() {
                uplopdfile.text = file1.name;
                dopcument = file1.name;
              });
            }

            break;
          default:
        }
        print('xfjsdjfjfilenamecheckKB-${file1.path}');

        break;
      case 1:
        print("Done file size KB");
        switch (Index) {
          case 0:
            if (file1.name.isNotEmpty || file1.name.toString() == null) {
              setState(() {
                uplopdfile.text = file1.name;
                dopcument = file1.name;
              });
            }
            print('filenamecheckdocmenut-${dopcument}');

            break;
          default:
        }
        print('filenamecheckKB-${file1.path}');
        BlocProvider.of<FetchExprtiseRoomCubit>(context)
            .chooseDocumentprofile(dopcument.toString(), file1.path!, context);
        setState(() {});

        break;
      case 2:
        if (value2 > finalFileSize) {
          print(
              "this file size ${value2} ${suffixes[i]} Selected Max size ${finalFileSize}MB");

          showDialog(
            context: context,
            builder: (ctx) => AlertDialog(
              title: Text("Max Size ${finalFileSize}MB"),
              content: Text(
                  "This file size ${value2} ${suffixes[i]} Selected Max size ${finalFileSize}MB"),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(ctx).pop();
                  },
                  child: Container(
                    // color: Colors.green,
                    padding: const EdgeInsets.all(10),
                    child: const Text("Okay"),
                  ),
                ),
              ],
            ),
          );
        } else {
          print("Done file Size 12MB");

          switch (Index) {
            case 1:
              setState(() {
                uplopdfile.text = file1.name;
                dopcument = file1.name;
              });
              break;

            default:
          }
          print('filecheckPath-${file1.path}');
          print('filecheckPath-${file1.path}');
          BlocProvider.of<FetchExprtiseRoomCubit>(context)
              .chooseDocumentprofile(
                  dopcument.toString(), file1.path!, context);
        }

        break;
      default:
    }

    return STR;
  }
}
