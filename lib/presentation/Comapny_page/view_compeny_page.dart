import 'package:flutter/material.dart';
import 'package:pds/widgets/custom_image_view.dart';

import '../../core/utils/color_constant.dart';
import '../../core/utils/image_constant.dart';

class ViewCompenyPage extends StatefulWidget {
  String? profilePic;
  String? companyName;
  String? pageid;
  String? companyType;
  String? description;

  ViewCompenyPage({
    Key? key,
    this.profilePic,
    this.companyName,
    this.pageid,
    this.companyType,
    this.description,
  }) : super(key: key);

  @override
  State<ViewCompenyPage> createState() => _ViewCompenyPageState();
}

class _ViewCompenyPageState extends State<ViewCompenyPage> {
  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    double _height = MediaQuery.of(context).size.height;
    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context);
        Navigator.pop(context);
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
              Navigator.pop(context);
            },
            child: Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
          ),
          title: Text(
            "Compny Page Details",
            style: TextStyle(color: Colors.black),
          ),
          backgroundColor: Colors.transparent,
          centerTitle: true,
          elevation: 0,
        ),
        body: SingleChildScrollView(
          child: Container(
            child: Column(
              children: [
                SizedBox(
                  height: 50,
                ),
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
                        widget.profilePic == null
                            ? Center(
                                child: ClipOval(
                                  child: FittedBox(
                                    child: Image.asset(
                                      ImageConstant.tomcruse,
                                      height: 150,
                                      // radius: BorderRadius.circular(25),
                                      width: 150,
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ),
                              )
                            : Center(
                                child: ClipOval(
                                  child: FittedBox(
                                    child: CustomImageView(
                                      url: "${widget.profilePic}",
                                      height: 150,
                                      radius: BorderRadius.circular(25),
                                      width: 150,
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ),
                              ),
                        /*  : 
                        Center(
                          child: FittedBox(
                              child: CachedNetworkImage(
                            imageUrl: "${widget.profilePic}",
                            height: 150,
                            width: 150,
                            fit: BoxFit.fill,
                          )),
                        ), */
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 25, right: 25, top: 30),
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
                        padding: const EdgeInsets.only(top: 20),
                        child: Text(
                          "Company Name",
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Container(
                        width: _width,
                        alignment: Alignment.centerLeft,
                        padding: EdgeInsets.only(left: 10),
                        height: 50,
                        decoration: BoxDecoration(
                            color: Colors.grey.shade100,
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(color: Colors.grey.shade200)),
                        child: Text(
                          "${widget.companyName}",
                          style: TextStyle(
                              fontFamily: 'outfit',
                              fontSize: 18,
                              fontWeight: FontWeight.w400),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: Text(
                          "Page ID",
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Container(
                        width: _width,
                        height: 50,
                        decoration: BoxDecoration(
                            color: Colors.grey.shade100,
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(color: Colors.grey.shade200)),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "${widget.pageid}",
                            style: TextStyle(
                              fontFamily: 'outfit',
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: Text(
                          "Comapny Type",
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Container(
                        width: _width,
                        height: 50,
                        decoration: BoxDecoration(
                            color: Colors.grey.shade100,
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(color: Colors.grey.shade200)),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "${widget.companyType}",
                            style: TextStyle(
                              fontFamily: 'outfit',
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 20,
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
                      SizedBox(
                        height: 5,
                      ),
                      Container(
                        width: _width,
                        height: 100,
                        decoration: BoxDecoration(
                            color: Colors.grey.shade100,
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(color: Colors.grey.shade200)),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "${widget.description}",
                            style: TextStyle(
                              fontFamily: 'outfit',
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
