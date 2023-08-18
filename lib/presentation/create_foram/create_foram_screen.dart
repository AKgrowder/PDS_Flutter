import 'dart:io';
import 'dart:math';

import 'package:archit_s_application1/API/Bloc/Fatch_All_PRoom_Bloc/Fatch_PRoom_cubit.dart';
import 'package:archit_s_application1/API/Bloc/GetAllPrivateRoom_Bloc/GetAllPrivateRoom_cubit.dart';
import 'package:archit_s_application1/API/Bloc/PublicRoom_Bloc/CreatPublicRoom_cubit.dart';
import 'package:archit_s_application1/API/Bloc/auth/register_Block.dart';
import 'package:archit_s_application1/API/Bloc/creatForum_Bloc/creat_Forum_cubit.dart';
import 'package:archit_s_application1/API/Bloc/creatForum_Bloc/creat_Fourm_state.dart';
import 'package:archit_s_application1/API/Bloc/senMSG_Bloc/senMSG_cubit.dart';
import 'package:archit_s_application1/API/Model/createDocumentModel/createDocumentModel.dart';
import 'package:archit_s_application1/core/utils/color_constant.dart';
import 'package:archit_s_application1/core/utils/image_constant.dart';
import 'package:archit_s_application1/core/utils/sharedPreferences.dart';
import 'package:archit_s_application1/custom_bottom_bar/custom_bottom_bar.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../API/Bloc/Invitation_Bloc/Invitation_cubit.dart';
import '../../theme/theme_helper.dart';

class CreateForamScreen extends StatefulWidget {
  const CreateForamScreen({Key? key}) : super(key: key);

  @override
  State<CreateForamScreen> createState() => _CreateForamScreenState();
}

class _CreateForamScreenState extends State<CreateForamScreen> {
  TextEditingController name = TextEditingController();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController profile = TextEditingController();
  TextEditingController uplopdfile = TextEditingController();
  double value2 = 0.0;
  double finalFileSize = 12.0;
  String? dopcument;
  String? filepath;
  ChooseDocument? chooseDocument;
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
            SnackBar snackBar = SnackBar(
              content: Text(state.error),
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
            SnackBar snackBar = SnackBar(
              content: Text(state.chooseDocument.message.toString()),
              backgroundColor: ColorConstant.primary_color,
            );
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          }
          if (state is CreatFourmLoadedState) {
            SnackBar snackBar = SnackBar(
              content: Text(state.createForm.message ?? ""),
              backgroundColor: ColorConstant.primary_color,
            );
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return MultiBlocProvider(providers: [
                BlocProvider<FetchAllPublicRoomCubit>(
                  create: (context) => FetchAllPublicRoomCubit(),
                ),
                BlocProvider<CreatPublicRoomCubit>(
                  create: (context) => CreatPublicRoomCubit(),
                ),
                BlocProvider<senMSGCubit>(
                  create: (context) => senMSGCubit(),
                ),
                BlocProvider<RegisterCubit>(
                  create: (context) => RegisterCubit(),
                ),
                BlocProvider<GetAllPrivateRoomCubit>(
                  create: (context) => GetAllPrivateRoomCubit(),
                ),
                BlocProvider<InvitationCubit>(
                  create: (context) => InvitationCubit(),
                ),
              ], child: BottombarPage(buttomIndex: 0));
            }));
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
            print('check Status--${state.createForm.success}');
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
                          padding: const EdgeInsets.only(left:5.0),
                          child: TextFormField(
                            controller: name,maxLength: 50,
                            cursorColor: Colors.grey,
                            decoration: InputDecoration(
                              hintText: 'Enter name',counterText: '',
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
                    Center(
                      child: Container(
                        height: 50,
                        width: _width / 1.2,
                        decoration: BoxDecoration(
                            color: Color(0XFFF6F6F6),
                            borderRadius: BorderRadius.circular(5)),
                        child: Padding(
                          padding: const EdgeInsets.only(left:8.0),
                          child: TextFormField(maxLength: 50,
                            controller: profile,
                            cursorColor: Colors.grey,
                            decoration: InputDecoration(
                              hintText: 'Job Profile',counterText: '',
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
                            width: _width / 1.65,
                            decoration: BoxDecoration(
                                color: Color(0XFFF6F6F6),
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(5),
                                    bottomLeft: Radius.circular(5))),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextFormField(
                                readOnly: true,
                                // maxLines: null,
                                controller: uplopdfile,
                                cursorColor: Colors.grey,
                                decoration: InputDecoration(
                                  hintText: 'Upload Image',
                                  border: InputBorder.none,
                                ),
                                style:
                                    TextStyle(overflow: TextOverflow.ellipsis),
                              ),
                            ),
                          ),
                          GestureDetector(
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
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    GestureDetector(
                      onTap: () async {
                        if (name.text != null && name.text != "") {
                          if (profile.text != null && profile.text != "") {
                            if (uplopdfile.text != null &&
                                uplopdfile.text != "") {
                            } else {
                              SnackBar snackBar = SnackBar(
                                content: Text('Please upload Document'),
                                backgroundColor: ColorConstant.primary_color,
                              );
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                            }
                          } else {
                            SnackBar snackBar = SnackBar(
                              content: Text('Please Profile Name'),
                              backgroundColor: ColorConstant.primary_color,
                            );
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                          }
                          print('vaildate');
                          final SharedPreferences prefs =
                              await SharedPreferences.getInstance();
                          String? jwtToken =
                              await prefs.getString(PreferencesKey.loginJwt);
                          print('jwttokenGet -$jwtToken');
                          Map<String, dynamic> params = {
                            'document': chooseDocument?.object.toString(),
                            'companyName': name.text,
                            'jobProfile': profile.text,
                          };
                          print('button-$params');
                          BlocProvider.of<CreatFourmCubit>(context).CreatFourm(
                              params, uplopdfile.text, filepath.toString());
                        } else {
                          SnackBar snackBar = SnackBar(
                            content: Text('Please Enter Company Name'),
                            backgroundColor: ColorConstant.primary_color,
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "By submitting you are agreeing to",
                          style: TextStyle(
                            fontFamily: 'outfit',
                            fontSize: 15,
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {},
                          child: Text(
                            " Terms & Cinditions",
                            style: TextStyle(
                              fontFamily: 'outfit',
                              decoration: TextDecoration.underline,
                              fontSize: 15,
                              color: Color(0xFFED1C25),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Center(
                      child: GestureDetector(
                        onTap: () {},
                        child: Text(
                          "Privacy & Policy of PDS Terms",
                          style: TextStyle(
                            fontFamily: 'outfit',
                            fontSize: 15,
                            decoration: TextDecoration.underline,
                            color: Color(0xFFED1C25),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
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
            setState(() {
              uplopdfile.text = file1.name;
              dopcument = file1.name;
            });
            print('filenamecheckdocmenut-${dopcument}');

            break;
          default:
        }
        print('filenamecheckKB-${file1.path}');
        BlocProvider.of<CreatFourmCubit>(context)
            .chooseDocumentprofile(dopcument.toString(), file1.path!);
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
          print('filecheckPath-${file1.path}');
          BlocProvider.of<CreatFourmCubit>(context)
              .chooseDocumentprofile(dopcument.toString(), file1.path!);
        }

        break;
      default:
    }

    return STR;
  }
}
