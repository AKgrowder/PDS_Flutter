import 'dart:io';
import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pds/API/Bloc/Comapny_Manage_bloc/Comapny_Manage_cubit.dart';
import 'package:pds/API/Model/createDocumentModel/createDocumentModel.dart';
import 'package:pds/API/Model/removeFolloweModel/removeFollowerModel.dart';
import 'package:pds/core/utils/color_constant.dart';
import 'package:pds/core/utils/image_constant.dart';
import 'package:pds/presentation/policy_of_company/policy_screen.dart';
import 'package:pds/presentation/policy_of_company/privecy_policy.dart';
import 'package:pds/theme/theme_helper.dart';
import 'package:pds/widgets/custom_text_form_field.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../API/Bloc/Comapny_Manage_bloc/Comapny_Manage_state.dart';
import '../../core/utils/sharedPreferences.dart';

class CreateComapnyScreen extends StatefulWidget {
  const CreateComapnyScreen({Key? key}) : super(key: key);

  @override
  State<CreateComapnyScreen> createState() => _CreateComapnyScreenState();
}

class _CreateComapnyScreenState extends State<CreateComapnyScreen> {
  List<String> list = [
    'Proprietor',
    'Partnership',
    'Private Limited',
    'Public',
  ];

  File? _image;
  ImagePicker picker = ImagePicker();
  ChooseDocument? chooseDocumentuploded;
  double value2 = 0.0;
  double documentuploadsize = 0;
  String? User_ID;
  bool isChecked = false;
  String? dropdownValue;
  TextEditingController comapnyNameController = TextEditingController();
  TextEditingController pageIDController = TextEditingController();
  TextEditingController descController = TextEditingController();

  dataSetUpMethod() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    User_ID = prefs.getString(PreferencesKey.loginUserID);
    int? a = prefs.getInt(PreferencesKey.mediaSize);
    documentuploadsize = double.parse("${a}");
  }

  @override
  void initState() {
    // TODO: implement initState
    dataSetUpMethod();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    double _height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back,
            color: Colors.grey,
          ),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Text(
          "Create Company Page",
          style: TextStyle(
            // fontFamily: 'outfit',
            color: Colors.black, fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
      ),
      body: BlocConsumer<ComapnyManageCubit, ComapnyManageState>(
        listener: (context, state) {
          if (state is chooseDocumentLoadedState) {
            print("chooseDocumentLoadedState");
            if (state.chooseDocument.object == null) {
              SnackBar snackBar = SnackBar(
                content: Text(state.chooseDocument.message.toString()),
                backgroundColor: ColorConstant.primary_color,
              );
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            } else {
              // widget.newProfileData?.object?.userProfilePic = null;
              chooseDocumentuploded = state.chooseDocument;
            }
          }
        },
        builder: (context, state) {
          return SingleChildScrollView(
            child: Container(
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      height: 150,
                      width: 150,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                      ),
                      child: Stack(
                        children: [
                          chooseDocumentuploded?.object != null
                              ? Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: ClipOval(
                                    child: FittedBox(
                                      child: CachedNetworkImage(
                                        height: 150,
                                        width: 150,
                                        imageUrl:
                                            '${chooseDocumentuploded?.object.toString()}',
                                        errorWidget: (context, url, error) =>
                                            Icon(Icons.error),
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                  ),
                                )
                              : Center(
                                  child: FittedBox(
                                    child: Image.asset(
                                      ImageConstant.tomcruse,
                                      // fit: BoxFit.cover,
                                      height: 150,
                                      width: 150,
                                    ),
                                  ),
                                ),
                          Positioned(
                            bottom: 7,
                            right: -0,
                            child: GestureDetector(
                              onTap: () {
                                gallerypicker();
                              },
                              child: Container(
                                height: 40,
                                width: 40,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Color(0xffFFFFFF), width: 4),
                                  shape: BoxShape.circle,
                                  color: Color(0xffFBD8D9),
                                ),
                                child: Icon(
                                  Icons.camera_alt_outlined,
                                  color: ColorConstant.primary_color,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 25, right: 25, top: 30),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 45,
                          width: _width,
                          decoration: BoxDecoration(
                              color: ColorConstant.primaryLight_color,
                              borderRadius: BorderRadius.circular(5)),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 15),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  "Company Details",
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 15),
                          child: Text(
                            "Company Name",
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        Container(
                          width: _width,
                          child: CustomTextFormField(
                            controller: comapnyNameController,
                            margin: EdgeInsets.only(
                              top: 10,
                            ),

                            validator: (value) {
                              RegExp nameRegExp = RegExp(r"^[a-zA-Z0-9\s'@]+$");
                              if (value!.isEmpty) {
                                return 'Please Enter Name';
                              } else if (!nameRegExp.hasMatch(value)) {
                                return 'Input cannot contains prohibited special characters';
                              } else if (value.length <= 0 ||
                                  value.length > 50) {
                                return 'Minimum length required';
                              } else if (value.contains('..')) {
                                return 'username does not contain is correct';
                              }

                              return null;
                            },
                            // textStyle: theme.textTheme.titleMedium!,
                            hintText: "Enter name",
                            textStyle: TextStyle(
                              fontWeight: FontWeight.w400,
                              wordSpacing: 1,
                              letterSpacing: 1,
                            ),
                            // hintStyle: theme.textTheme.titleMedium!,
                            textInputAction: TextInputAction.next,
                            filled: true,

                            fillColor: appTheme.gray100,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: Text(
                            "Page ID",
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        Container(
                          width: _width,
                          child: CustomTextFormField(
                            controller: pageIDController,
                            margin: EdgeInsets.only(
                              top: 10,
                            ),

                            validator: (value) {
                              RegExp nameRegExp = RegExp(r"^[a-zA-Z0-9\s'@]+$");
                              if (value!.isEmpty) {
                                return 'Please Enter Name';
                              } else if (!nameRegExp.hasMatch(value)) {
                                return 'Input cannot contains prohibited special characters';
                              } else if (value.length <= 0 ||
                                  value.length > 50) {
                                return 'Minimum length required';
                              } else if (value.contains('..')) {
                                return 'username does not contain is correct';
                              }

                              return null;
                            },
                            // textStyle: theme.textTheme.titleMedium!,
                            hintText: "Enter page ID",
                            textStyle: TextStyle(
                              fontWeight: FontWeight.w400,
                              wordSpacing: 1,
                              letterSpacing: 1,
                            ),
                            // hintStyle: theme.textTheme.titleMedium!,
                            textInputAction: TextInputAction.next,
                            filled: true,

                            fillColor: appTheme.gray100,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: Text(
                            "Comapny Type",
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        Container(
                          height: 50,
                          width: _width,
                          decoration: BoxDecoration(
                              color: Colors.grey[100],
                              border: Border.all(color: Colors.grey.shade200),
                              borderRadius: BorderRadius.circular(5)),
                          child: DropdownButtonHideUnderline(
                            child: Padding(
                              padding: EdgeInsets.only(left: 12),
                              child: DropdownButton<String>(
                                icon: Icon(Icons.keyboard_arrow_down),
                                value: dropdownValue,
                                hint: Text('Comapny type'),
                                onChanged: (String? value) {
                                  // When the user selects an option from the dropdown.
                                  setState(() {
                                    dropdownValue = value!;
                                  });
                                },
                                items: list.map<DropdownMenuItem<String>>(
                                    (String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(
                                      value,
                                    ),
                                  );
                                }).toList(),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            top: 10,
                          ),
                          child: Text(
                            "Description",
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        Container(
                          width: _width,
                          child: CustomTextFormField(
                            maxLines: 4,
                            controller: descController,
                            margin: EdgeInsets.only(
                              top: 10,
                            ),

                            validator: (value) {
                              RegExp nameRegExp = RegExp(r"^[a-zA-Z0-9\s'@]+$");
                              if (value!.isEmpty) {
                                return 'Please Enter Name';
                              } else if (!nameRegExp.hasMatch(value)) {
                                return 'Input cannot contains prohibited special characters';
                              } else if (value.length <= 0 ||
                                  value.length > 50) {
                                return 'Minimum length required';
                              } else if (value.contains('..')) {
                                return 'username does not contain is correct';
                              }

                              return null;
                            },
                            // textStyle: theme.textTheme.titleMedium!,
                            hintText: "Type here...",
                            textStyle: TextStyle(
                              fontWeight: FontWeight.w400,
                              wordSpacing: 1,
                              letterSpacing: 1,
                            ),
                            // hintStyle: theme.textTheme.titleMedium!,
                            textInputAction: TextInputAction.next,
                            filled: true,
                            maxLength: 255,
                            fillColor: appTheme.gray100,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: Row(
                            children: [
                              Checkbox(
                                activeColor: ColorConstant.primary_color,
                                checkColor: Colors.white,
                                value: isChecked,
                                onChanged: (bool? value) {
                                  super.setState(() {
                                    isChecked = value!;
                                  });
                                },
                              ),
                              Text(
                                "I have Read and Agree to ",
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 12,
                                  fontFamily: 'Outfit',
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => Policies(
                                          title: " ",
                                          data: Policy_Data.turms_of_use,
                                        ),
                                      ));
                                },
                                child: Text(
                                  "Terms of Use ",
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    color: theme.colorScheme.primary,
                                    fontSize: 12,
                                    fontFamily: 'Outfit',
                                    fontWeight: FontWeight.w500,
                                    decoration: TextDecoration.underline,
                                  ),
                                ),
                              ),
                              Text(
                                "& ",
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  color: theme.colorScheme.primary,
                                  fontSize: 12,
                                  fontFamily: 'Outfit',
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 2),
                                child: Center(
                                  child: GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => Policies(
                                              title: " ",
                                              data: Policy_Data.privacy_policy1,
                                            ),
                                          ));
                                    },
                                    child: Text(
                                      "Privacy Policy",
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        color: theme.colorScheme.primary,
                                        fontSize: 12,
                                        fontFamily: 'Outfit',
                                        fontWeight: FontWeight.w500,
                                        decoration: TextDecoration.underline,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          alignment: Alignment.center,
                          height: 50,
                          width: _width,
                          decoration: BoxDecoration(
                              color: ColorConstant.primary_color,
                              borderRadius: BorderRadius.circular(5)),
                          child: Text(
                            'Submit',
                            style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'outfit',
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Future<void> gallerypicker() async {
    print("this is the gallerypicker");
    var pickedImageFile = await picker.pickImage(source: ImageSource.gallery);
    super.setState(() {
      _image = File(pickedImageFile?.path ?? '');
    });
    if (_image != null) {
      if (!_isGifOrSvg(_image!.path)) {
        _image = File(_image!.path);
        super.setState(() {});
        getUploadeProfile(_image!.path, 1, _image!, 0);
      }
    }
    print("image selcted Path set-->$_image");
  }

  bool _isGifOrSvg(String imagePath) {
    // Check if the image file has a .gif or .svg extension
    final lowerCaseImagePath = imagePath.toLowerCase();
    return lowerCaseImagePath.endsWith('.gif') ||
        lowerCaseImagePath.endsWith('.svg') ||
        lowerCaseImagePath.endsWith('.pdf') ||
        lowerCaseImagePath.endsWith('.doc') ||
        lowerCaseImagePath.endsWith('.mp4') ||
        lowerCaseImagePath.endsWith('.mov') ||
        lowerCaseImagePath.endsWith('.mp3') ||
        lowerCaseImagePath.endsWith('.m4a');
  }

  getUploadeProfile(
      String filepath, int decimals, File file1, int Index) async {
    var file = File(filepath);
    int bytes = await file.length();
    if (bytes <= 0) return "0 B";
    const suffixes = ["B", "KB", "MB", "GB", "TB", "PB", "EB", "ZB", "YB"];
    var i = (log(bytes) / log(1024)).floor();
    var STR = ((bytes / pow(1024, i)).toStringAsFixed(decimals));
    print('getFileSizevariable-${file1.path}');
    value2 = double.parse(STR);
    print(file1);
    print(value2);
    switch (i) {
      case 0:
        BlocProvider.of<ComapnyManageCubit>(context)
            .upoldeProfilePic(_image!, context);
        break;
      case 1:
        print("Done file size KB");

        print('filenamecheckKB-${file1.path}');
        BlocProvider.of<ComapnyManageCubit>(context)
            .upoldeProfilePic(_image!, context);
        super.setState(() {});

        break;
      case 2:
        if (value2 > documentuploadsize) {
          print(
              "this file size ${value2} ${suffixes[i]} Selected Max size ${documentuploadsize}MB");

          showDialog(
            context: context,
            builder: (ctx) => AlertDialog(
              title: Text("Max Size ${documentuploadsize}MB"),
              content: Text(
                  "This file size ${value2} ${suffixes[i]} Selected Max size ${documentuploadsize}MB"),
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
          print('filecheckPath-${file1.path}');
          print('filecheckPath-${file1.path}');
          BlocProvider.of<ComapnyManageCubit>(context)
              .upoldeProfilePic(_image!, context);
        }

        break;
      default:
    }

    return STR;
  }
}
