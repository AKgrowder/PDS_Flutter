import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pds/core/utils/color_constant.dart';
import 'package:pds/presentation/Comapny_page/Create_company_Screen.dart';
import 'package:pds/presentation/Comapny_page/Delete_Comapny_dailog.dart';
import 'package:pds/presentation/Comapny_page/view_compeny_page.dart';
import 'package:share_plus/share_plus.dart';

import '../../API/Bloc/Comapny_Manage_bloc/Comapny_Manage_cubit.dart';
import '../../API/Bloc/Comapny_Manage_bloc/Comapny_Manage_state.dart';
import '../../API/Model/getall_compeny_page_model/getall_compeny_page.dart';
import '../../core/utils/image_constant.dart';
import '../../widgets/custom_image_view.dart';

class ComapnyManageScreen extends StatefulWidget {
  const ComapnyManageScreen({Key? key}) : super(key: key);

  @override
  State<ComapnyManageScreen> createState() => _ComapnyManageScreenState();
}

class _ComapnyManageScreenState extends State<ComapnyManageScreen> {
  GetAllCompenyPageModel? getallcompenypage;
  @override
  void initState() {
    BlocProvider.of<ComapnyManageCubit>(context).getallcompenypagee(context);

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
            "Manage Company Page",
            style: TextStyle(
              // fontFamily: 'outfit',
              color: Colors.black, fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          centerTitle: true,
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(
              builder: (context) {
                return CreateComapnyScreen();
              },
            ));
          },
          child: Icon(Icons.add),
          backgroundColor: ColorConstant.primary_color,
        ),
        body: BlocConsumer<ComapnyManageCubit, ComapnyManageState>(
          listener: (context, state) {
            if (state is Getallcompenypagelodedstate) {
              getallcompenypage = state.getallcompenypagemodel;
            }
          },
          builder: (context, state) {
            return getallcompenypage?.object == null
                ? Center(
                    child: Container(
                      margin: EdgeInsets.only(bottom: 100),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.asset(ImageConstant.loader,
                            fit: BoxFit.cover, height: 100.0, width: 100),
                      ),
                    ),
                  )
                : getallcompenypage?.object?.content?.length == 1
                    ? Center(
                        child: Image.asset(
                          ImageConstant.emptylistimage,
                          height: _height / 2,
                        ),
                      )
                    : ListView.builder(
                        itemCount: getallcompenypage?.object?.content?.length,
                        itemBuilder: (context, index) {
                          if (getallcompenypage
                                  ?.object?.content?[index].companyPageName ==
                              null) {
                            return SizedBox();
                          } else {
                            return Padding(
                              padding: const EdgeInsets.only(
                                  right: 15, left: 15, bottom: 15),
                              child: Container(
                                height: 70,
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.grey),
                                    borderRadius: BorderRadius.circular(10)),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      right: 15, left: 15),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          getallcompenypage
                                                      ?.object
                                                      ?.content?[index]
                                                      .companyPageProfilePic ==
                                                  null
                                              ? CustomImageView(
                                                  imagePath:
                                                      ImageConstant.tomcruse,
                                                  height: 50,
                                                  radius:
                                                      BorderRadius.circular(25),
                                                  width: 50,
                                                  fit: BoxFit.fill,
                                                )
                                              : GestureDetector(
                                                  onTap: () {
                                                    print(
                                                        "as per image-${getallcompenypage?.object?.content?[index].companyPageProfilePic}");
                                                  },
                                                  child: CustomImageView(
                                                    url:
                                                        "${getallcompenypage?.object?.content?[index].companyPageProfilePic}",
                                                    height: 50,
                                                    radius:
                                                        BorderRadius.circular(
                                                            25),
                                                    width: 50,
                                                    fit: BoxFit.fill,
                                                  ),
                                                ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 13, bottom: 13, left: 10),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Flexible(
                                                  child: Container(
                                                    width: _width / 2.5,
                                                    child: Text(
                                                      " ${getallcompenypage?.object?.content?[index].companyPageName}",
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: TextStyle(
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        color: Colors.black,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Flexible(
                                                  child: Container(
                                                    width: _width / 2.5,
                                                    child: Text(
                                                      " ${getallcompenypage?.object?.content?[index].companyPageType}",
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: TextStyle(
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        color: Colors.black,
                                                      ),
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      GestureDetector(
                                          onTapDown: (details) {
                                            showPopUp(details.globalPosition,
                                                context, index);
                                          },
                                          child: Icon(Icons.more_vert))
                                    ],
                                  ),
                                ),
                              ),
                            );
                          }
                        },
                      );
          },
        ));
  }

  void showPopUp(
    Offset offset,
    BuildContext context,
    int index,
  ) async {
    double right = offset.dx;
    double top = offset.dy;
    double _width = MediaQuery.of(context).size.width;
    double _height = MediaQuery.of(context).size.height;
    await showMenu(
        context: context,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(20),
          ),
        ),
        position: RelativeRect.fromLTRB(
          right,
          top,
          50,
          10,
        ),
        items: [
          PopupMenuItem(
              value: 0,
              onTap: () {
                print("yes i sm comming!!");
              },
              enabled: true,
              child: GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(
                    builder: (context) {
                      return ViewCompenyPage(
                        profilePic: getallcompenypage
                            ?.object?.content?[index].companyPageProfilePic,
                        companyName:
                            "${getallcompenypage?.object?.content?[index].companyPageName}",
                        pageid:
                            "${getallcompenypage?.object?.content?[index].pageId}",
                        companyType:
                            "${getallcompenypage?.object?.content?[index].companyPageType}",
                        description:
                            "${getallcompenypage?.object?.content?[index].pageDescription}",
                      );
                    },
                  ));
                },
                child: Container(
                  width: 120,
                  child: Row(
                    children: [
                      CustomImageView(
                        imagePath: ImageConstant.infoimage,
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8),
                        child: Text(
                          "View Details",
                          style: TextStyle(color: Colors.black),
                          textScaleFactor: 1.0,
                        ),
                      ),
                    ],
                  ),
                ),
              )),
          PopupMenuItem(
              value: 1,
              onTap: () {
                print("yes i sm comming!!");
              },
              enabled: true,
              child: Container(
                width: 110,
                child: Row(
                  children: [
                    CustomImageView(
                      imagePath: ImageConstant.arrowleftimage,
                      height: 22,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Share",
                        style: TextStyle(color: Colors.black),
                        textScaleFactor: 1.0,
                      ),
                    ),
                  ],
                ),
              )),
          PopupMenuItem(
              onTap: () {
                print("yes i sm comming!!");
              },
              value: 2,
              enabled: true,
              child: Container(
                width: 110,
                child: Row(
                  children: [
                    CustomImageView(
                      imagePath: ImageConstant.delete,
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Delete",
                        style: TextStyle(color: Colors.black),
                        textScaleFactor: 1.0,
                      ),
                    ),
                  ],
                ),
              )),
        ]).then((value) {
      if (value != null) {
        if (kDebugMode) {
          print("selected==>$value");
        }
        if (value == 0) {}
        if (value == 1) {
          _onShareXFileFromAssets(context, androidLink: ' ');
          //add link
        }
        if (value == 2) {
          showDialog(
            context: context,
            builder: (_) => DeleteComapnyDailog(
              postUid:
                  '${getallcompenypage?.object?.content?[index].userCompanyPageUid}',
            ),
          ).then((value) => BlocProvider.of<ComapnyManageCubit>(context)
              .getallcompenypagee(context));
          /* BlocProvider.of<ComapnyManageCubit>(context).deletecompenypagee(context,'${getallcompenypage?.object?[index].pageUid}'); */
        }
      }
    });
  }

  void _onShareXFileFromAssets(BuildContext context,
      {String? androidLink}) async {
    // RenderBox? box = context.findAncestorRenderObjectOfType();

    var directory = await getApplicationDocumentsDirectory();

    if (Platform.isAndroid) {
      Share.shareXFiles(
        [XFile("/sdcard/download/IP__image.jpg")],
        subject: "Share",
        text: "Try This Awesome App \n\n Android :- ${androidLink}",
        // sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size,
      );
    } else {
      Share.shareXFiles(
        [
          XFile(directory.path +
              Platform.pathSeparator +
              'Growder_Image/IP__image.jpg')
        ],
        subject: "Share",
        text: "Try This Awesome App \n\n Android :- ${androidLink}",
        // sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size,
      );
    }
  }
}
