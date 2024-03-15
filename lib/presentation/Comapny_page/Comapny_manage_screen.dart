import 'package:flutter/material.dart';
import 'package:pds/core/utils/color_constant.dart';
import 'package:pds/presentation/Comapny_page/Create_company_Screen.dart';

import '../../core/utils/image_constant.dart';
import '../../widgets/custom_image_view.dart';

class ComapnyManageScreen extends StatefulWidget {
  const ComapnyManageScreen({Key? key}) : super(key: key);

  @override
  State<ComapnyManageScreen> createState() => _ComapnyManageScreenState();
}

class _ComapnyManageScreenState extends State<ComapnyManageScreen> {
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
        body: ListView.builder(
          itemCount: 10,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.only(right: 15, left: 15, bottom: 15),
              child: Container(
                height: 70,
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(10)),
                child: Padding(
                  padding: const EdgeInsets.only(right: 15, left: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          CustomImageView(
                            imagePath: ImageConstant.tomcruse,
                            height: 50,
                            radius: BorderRadius.circular(25),
                            width: 50,
                            fit: BoxFit.fill,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 13, bottom: 13, left: 10),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Flexible(
                                  child: Container(
                                    width: _width / 2.5,
                                    child: Text(
                                      "Inpackaging",
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                ),
                                Flexible(
                                  child: Container(
                                    width: _width / 2.5,
                                    child: Text(
                                      "Private Limited",
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
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
                            showPopUp(details.globalPosition, context);
                          },
                          child: Icon(Icons.more_vert))
                    ],
                  ),
                ),
              ),
            );
          },
        ));
  }

  void showPopUp(
    Offset offset,
    BuildContext context,
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
              )),
          PopupMenuItem(
              value: 2,
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
              value: 1,
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
        ]); /* .then((value){
          return 
        }); */
  }
}
