import 'dart:io';
import 'dart:math';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:multi_select_flutter/dialog/multi_select_dialog_field.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';
import 'package:multi_select_flutter/util/multi_select_list_type.dart';
import 'package:pds/API/Bloc/creatForum_Bloc/creat_Forum_cubit.dart';
import 'package:pds/API/Bloc/creatForum_Bloc/creat_Fourm_state.dart';
import 'package:pds/API/Model/createDocumentModel/createDocumentModel.dart';
import 'package:pds/core/utils/color_constant.dart';
import 'package:pds/core/utils/image_constant.dart';
import 'package:pds/core/utils/sharedPreferences.dart';
import 'package:pds/presentation/%20new/newbottembar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../theme/theme_helper.dart';
import '../policy_of_company/policy_screen.dart';
import '../policy_of_company/privecy_policy.dart';
import 'package:image/image.dart' as img;
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';

class CreateForamScreen extends StatefulWidget {
  const CreateForamScreen({Key? key}) : super(key: key);

  @override
  State<CreateForamScreen> createState() => _CreateForamScreenState();
}

class IndustryType {
  String industryTypeUid;
  String industryTypeName;
  IndustryType(this.industryTypeUid, this.industryTypeName);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is IndustryType &&
          runtimeType == other.runtimeType &&
          industryTypeName == other.industryTypeName;

  @override
  int get hashCode => industryTypeName.hashCode;
}

class _CreateForamScreenState extends State<CreateForamScreen> {
  TextEditingController name = TextEditingController();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController profile = TextEditingController();
  TextEditingController uplopdfile = TextEditingController();
  double value2 = 0.0;
  double finalFileSize = 0;
  double documentuploadsize = 0;
  String? dopcument;
  String? filepath;
  bool? SubmitOneTime = false;
  ChooseDocument? chooseDocument;
  List<MultiSelectItem<IndustryType>>? _industryTypes = [];
  List<IndustryType> selectedIndustryTypes = [];
  List<String> industryUUID = [];

  getDocumentSize() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    documentuploadsize =
        await double.parse(prefs.getString(PreferencesKey.fileSize) ?? "0");

    finalFileSize = documentuploadsize;
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getDocumentSize();
    BlocProvider.of<CreatFourmCubit>(context).IndustryTypeAPI(context);
    dopcument = 'Upload Document';
  }

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    double _height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: theme.colorScheme.onPrimary,
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: theme.colorScheme.onPrimary,
        title: Text(
          "Create Forum",
          style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black,
              fontFamily: "outfit",
              fontSize: 20),
        ),
      ),
      body: BlocConsumer<CreatFourmCubit, CreatFourmState>(
        listener: (context, state) {
          if (state is CreatFourmErrorState) {
            SubmitOneTime = false;
            SnackBar snackBar = SnackBar(
              content: Text(state.error.message),
              backgroundColor: ColorConstant.primary_color,
            );
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          }
          if (state is CreatFourmLoadingState) {
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
          if (state is ChooseDocumeentLoadedState) {
            chooseDocument = state.chooseDocument;
            print('ChooseDocumeentLoadedState-${state.chooseDocument.message}');
            // SnackBar snackBar = SnackBar(
            //   content: Text(state.chooseDocument.message.toString()),
            //   backgroundColor: ColorConstant.primary_color,
            // );
            // ScaffoldMessenger.of(context).showSnackBar(snackBar);
          }
          if (state is IndustryTypeLoadedState) {
            List<IndustryType> industryTypeData1 = state
                .industryTypeModel.object!
                .map((industryType) => IndustryType(
                    industryType.industryTypeUid ?? '',
                    industryType.industryTypeName ?? ''))
                .toList();
            _industryTypes = industryTypeData1
                .map((industryType) => MultiSelectItem(
                    industryType, industryType.industryTypeName))
                .toList();
          }
          if (state is CreatFourmLoadedState) {
            SnackBar snackBar = SnackBar(
              content: Text(state.createForm.object ?? ""),
              backgroundColor: ColorConstant.primary_color,
            );
            String industryType = industryUUID.join(', ');
            Map<String, dynamic> params = {
              'document': chooseDocument?.object.toString(),
              'companyName': name.text,
              'jobProfile': profile.text,
              'industryTypesUid': industryType,
              'documentName' : dopcument
            };

            // Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
            //   builder: (context) {
            //     return NewBottomBar(buttomIndex: 0);
            //   },
            // ), (route) => false).then((value) =>
            //     BlocProvider.of<CreatFourmCubit>(context).CreatFourm(
            //         params, uplopdfile.text, filepath.toString(), context));
            // ScaffoldMessenger.of(context).showSnackBar(snackBar);
            // print('check Status--${state.createForm.success}');

            Navigator.pushAndRemoveUntil(context,
                MaterialPageRoute(builder: (context) {
              return NewBottomBar(buttomIndex: 0);
            }), (route) => false).then((value) =>
                BlocProvider.of<CreatFourmCubit>(context).CreatFourm(
                    params, uplopdfile.text, filepath.toString(), context));
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
            print('check Status--${state.createForm.success}');
            print("${dopcument} :- dopcumentdopcumentdopcumentdopcumentdopcumentdopcument");
          }
        },
        builder: (context, state) {
          return SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    Center(
                      child: Container(
                        height: 50,
                        width: _width / 1.2,
                        decoration: BoxDecoration(
                            color: Color(0XFFFFE7E7),
                            borderRadius: BorderRadius.circular(5)),
                        child: Padding(
                          padding: const EdgeInsets.only(top: 15.0, left: 15),
                          child: Text(
                            "Company Details",
                            style: TextStyle(
                              fontFamily: 'outfit',
                              fontSize: 15,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 10.0, left: 35, bottom: 5),
                      child: Text(
                        "Company Name",
                        style: TextStyle(
                          fontFamily: 'outfit',
                          fontSize: 15,
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    Center(
                      child: Container(
                        height: 50,
                        width: _width / 1.2,
                        decoration: BoxDecoration(
                            color: Color(0XFFF6F6F6),
                            borderRadius: BorderRadius.circular(5)),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 5.0),
                          child: TextFormField(
                            controller: name,
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(50),
                            ],
                            cursorColor: Colors.grey,
                            decoration: InputDecoration(
                              hintText: 'Enter name',
                              counterText: '',
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 10.0, left: 35, bottom: 5),
                      child: Text(
                        "Job Profile",
                        style: TextStyle(
                          fontFamily: 'outfit',
                          fontSize: 15,
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    // CustomTextFormField(
                    //   validator: (value) {
                    //     RegExp nameRegExp = RegExp(r"^[a-zA-Z0-9\s'@]+$");
                    //     if (value!.isEmpty) {
                    //       return 'Please Enter Name';
                    //     } else if (value.trim().isEmpty) {
                    //       return 'Name can\'t be just blank spaces';
                    //     } else if (!nameRegExp.hasMatch(value)) {
                    //       return 'Input cannot contains prohibited special characters';
                    //     } else if (value.length <= 3 || value.length > 50) {
                    //       return 'Minimum length required';
                    //     } else if (value.contains('..')) {
                    //       return 'username does not contain is correct';
                    //     }

                    //     return null;
                    //   },

                    //   maxLength: 50,
                    //   // focusNode: FocusNode(),
                    //   controller: profile,
                    //   margin: EdgeInsets.only(
                    //     left: 30,
                    //     right: 30,
                    //   ),
                    //   contentPadding: EdgeInsets.only(
                    //     left: 12,
                    //     top: 14,
                    //     right: 12,
                    //     bottom: 14,
                    //   ),
                    //   // textStyle: theme.textTheme.titleMedium!,
                    //   hintText: "User Name",
                    //   hintStyle: TextStyle(
                    //       fontFamily: 'outfit',
                    //       fontSize: 15,
                    //       fontWeight: FontWeight.w400),
                    //   textInputAction: TextInputAction.next,
                    //   textInputType: TextInputType.emailAddress,
                    //   filled: true,

                    //   // fillColor: appTheme.gray100,
                    // ),
                    Center(
                      child: Container(
                        height: 50,
                        width: _width / 1.2,
                        decoration: BoxDecoration(
                            color: Color(0XFFF6F6F6),
                            borderRadius: BorderRadius.circular(5)),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: TextFormField(
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(50),
                            ],
                            controller: profile,
                            cursorColor: Colors.grey,
                            decoration: InputDecoration(
                              hintText: 'Job Profile',
                              counterText: '',
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 18, left: 35, bottom: 5),
                      child: Text(
                        "Industry Type",
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontFamily: 'outfit',
                          fontWeight: FontWeight.w500,
                        ),
                        // style: theme.textTheme.bodyLarge,
                      ),
                    ),
                    Center(
                      child: Container(
                        width: _width / 1.2,
                        decoration: BoxDecoration(color: Color(0xffEFEFEF)),
                        child: DropdownButtonHideUnderline(
                          child: Padding(
                            padding: EdgeInsets.only(left: 12),
                            child: MultiSelectDialogField<IndustryType>(
                              decoration: BoxDecoration(
                                  border:
                                      Border.all(color: Colors.transparent)),
                              buttonIcon: Icon(
                                Icons.expand_more,
                                color: Colors.black,
                              ),
                              items: _industryTypes!,
                              listType: MultiSelectListType.LIST,
                              onConfirm: (values) {
                                selectedIndustryTypes = values;
                                selectedIndustryTypes.forEach((element) {
                                  print(
                                      "sxfgsdfghdfghdfgh${element.industryTypeUid.runtimeType}");
                                  industryUUID
                                      .add("${element.industryTypeUid}");
                                });
                                setState(() {});
                              },
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 10.0, left: 35, bottom: 5),
                      child: Text(
                        "Document",
                        style: TextStyle(
                          fontFamily: 'outfit',
                          fontSize: 15,
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 35.0),
                      child: Row(
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
                          dopcument == "Upload Document"
                              ? GestureDetector(
                                  onTap: () async {
                                    filepath = await prepareTestPdf(0);
                                    setState(() {
                                      uplopdfile.text = dopcument.toString();
                                    });
                                    print('filepath-${uplopdfile.text}');
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
                              : GestureDetector(
                                  onTap: () {
                                    dopcument = "Upload Document";
                                    chooseDocument?.object = null;

                                    setState(() {});
                                  },
                                  child: Container(
                                    height: 50,
                                    width: _width / 4.5,
                                    decoration: BoxDecoration(
                                        color:
                                            Color.fromARGB(255, 228, 228, 228),
                                        borderRadius: BorderRadius.only(
                                            topRight: Radius.circular(5),
                                            bottomRight: Radius.circular(5))),
                                    child: Icon(
                                      Icons.delete_forever,
                                      color: ColorConstant.primary_color,
                                    ),
                                  ),
                                ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 35.0, right: 35.0, top: 10),
                      child: Row(
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
                            "Max size ${finalFileSize}MB",
                            style: TextStyle(
                              fontFamily: 'outfit',
                              fontSize: 15,
                              color: Colors.black.withOpacity(0.6),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    GestureDetector(
                      onTap: () async {
                        print("idfsdsdhfsdhsdfh-$industryUUID");
                        print(name.text.length);
                        if (name.text == null || name.text == '') {
                          SnackBar snackBar = SnackBar(
                            content: Text('Please Enter Company Name '),
                            backgroundColor: ColorConstant.primary_color,
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        } else if (name.text.trim().isEmpty ||
                            name.text.trim() == '') {
                          SnackBar snackBar = SnackBar(
                            content: Text(
                                'Company Name can\'t be just blank spaces '),
                            backgroundColor: ColorConstant.primary_color,
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        } else if (name.text.toString().length <= 3 ||
                            name.text.toString().length > 50) {
                          SnackBar snackBar = SnackBar(
                            content: Text('Please fill full Company Name '),
                            backgroundColor: ColorConstant.primary_color,
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        } else if (profile.text == null || profile.text == '') {
                          SnackBar snackBar = SnackBar(
                            content: Text('Please Enter Job profile '),
                            backgroundColor: ColorConstant.primary_color,
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        } else if (profile.text.trim().isEmpty ||
                            profile.text.trim() == '') {
                          SnackBar snackBar = SnackBar(
                            content: Text(
                                'Job profile can\'t be just blank spaces '),
                            backgroundColor: ColorConstant.primary_color,
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        } else if (profile.text.toString().length <= 3 ||
                            profile.text.toString().length > 50) {
                          SnackBar snackBar = SnackBar(
                            content: Text('Please fill full Job Profile'),
                            backgroundColor: ColorConstant.primary_color,
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        } else if (industryUUID.isEmpty) {
                          SnackBar snackBar = SnackBar(
                            content: Text('Please Selcted Industry Type'),
                            backgroundColor: ColorConstant.primary_color,
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        } else if (dopcument == 'Upload Document') {
                          print('upolded imah');
                          SnackBar snackBar = SnackBar(
                            content: Text('Please Upload Document'),
                            backgroundColor: ColorConstant.primary_color,
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        } else {
                          String industryType = industryUUID.join(', ');
                          print("sdgfsdfghdfgsdfgsdgf-${industryType}");
                          Map<String, dynamic> params = {
                            'document': chooseDocument?.object.toString(),
                            'companyName': name.text,
                            'jobProfile': profile.text,
                            'industryTypesUid': industryType,
                            'documentName' : dopcument
                          };

                          print('button-$params');

                          if (SubmitOneTime == false) {
                            print(
                                "${dopcument} :- dopcumentdopcumentdopcumentdopcumentdopcumentdopcument");
                            SubmitOneTime = true;
                            BlocProvider.of<CreatFourmCubit>(context)
                                .CreatFourm(params, uplopdfile.text,
                                    filepath.toString(), context);
                          }
                        }
                      },
                      child: Center(
                        child: Container(
                          height: 50,
                          width: _width / 1.2,
                          decoration: BoxDecoration(
                              color: Color(0XFFED1C25),
                              borderRadius: BorderRadius.circular(5)),
                          child: Center(
                            child: Text(
                              "Submit",
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
                    SizedBox(
                      height: 10,
                    ),
                    Align(
                      // alignment: Alignment.center,
                      child: Container(
                        // color: Colors.amber,
                        // width: 330,
                        margin: EdgeInsets.only(
                          left: 10,
                          top: 16,
                          right: 0,
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
                              // TextSpan(
                              //   text:
                              //       "Terms & Conditions  Privacy & Policy  of PDS Terms",
                              // style: TextStyle(
                              //   color: theme.colorScheme.primary,
                              //   fontSize: 14,
                              //   fontFamily: 'Outfit',
                              //   fontWeight: FontWeight.w500,
                              //   decoration: TextDecoration.underline,
                              // ),
                              // ),
                            ],
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
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
                            "Terms & Conditions ",
                            style: TextStyle(
                              color: theme.colorScheme.primary,
                              fontSize: 14,
                              fontFamily: 'Outfit',
                              fontWeight: FontWeight.w500,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                        Center(
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
                              "Privacy & Policy  of PDS Terms",
                              style: TextStyle(
                                color: theme.colorScheme.primary,
                                fontSize: 14,
                                fontFamily: 'Outfit',
                                fontWeight: FontWeight.w500,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ]),
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
          return file.path!;
        }
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
    print('getFileSizevariable-${file1.path.toString().split('.').last}');

    value2 = double.parse(STR);

    print(value2);
    switch (i) {
      case 0:
        print("Done file size B");
        switch (Index) {
          case 1:
            setState(() {
              uplopdfile.text = file1.name;
              dopcument = file1.name;
            });
            break;
          default:
        }

        break;
      case 1:
        print("Done file size KB");
        switch (Index) {
          case 0:
            print('filenamecheckdocmenut-${dopcument}');
            setState(() {
              uplopdfile.text = file1.name;
              dopcument = file1.name;
            });
            break;
          default:
        }
        if (file1.path?.split('.') != 'pdf') {
          print("this fucntion is caaling");

          CroppedFile? croppedFile = await ImageCropper().cropImage(
            sourcePath:
                // "",
                file1.path.toString(),
            aspectRatioPresets: [
              CropAspectRatioPreset.square,
              CropAspectRatioPreset.ratio3x2,
              CropAspectRatioPreset.original,
              CropAspectRatioPreset.ratio4x3,
              CropAspectRatioPreset.ratio16x9
            ],
            uiSettings: [
              AndroidUiSettings(
                  toolbarTitle: 'Cropper',
                  toolbarColor: Color(0xffED1C25),
                  toolbarWidgetColor: Colors.white,
                  initAspectRatio: CropAspectRatioPreset.original,
                  activeControlsWidgetColor: Color(0xffED1C25),
                  lockAspectRatio: false),
              IOSUiSettings(
                title: 'Cropper',
              ),
              WebUiSettings(
                context: context,
              ),
            ],
          );
          if (croppedFile != null) {
            dopcument = file1.name;
            /* setState(() {
              uplopdfile.text = croppedFile.path.split('/').last;
              dopcument = file1.name;
            }); */
            BlocProvider.of<CreatFourmCubit>(context).chooseDocumentprofile(
                dopcument.toString(), croppedFile.path, context);
          } else {
            BlocProvider.of<CreatFourmCubit>(context).chooseDocumentprofile(
                dopcument.toString(), file1.path!, context);
            setState(() {
              uplopdfile.text = file1.name;
              dopcument = file1.name;
            });
            print("cheeck wihout cutting--${file1.name}");
          }
        }

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

          /*    setState(() {
            uplopdfile.text = file1.name;
            dopcument = file1.name;
          }); */
          print('filecheckPath-${file1.path}');
          BlocProvider.of<CreatFourmCubit>(context).chooseDocumentprofile(
              dopcument.toString(), file1.path!, context);
        }

        break;
      default:
    }

    return STR;
  }
}
