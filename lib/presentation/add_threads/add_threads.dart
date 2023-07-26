import 'package:archit_s_application1/core/utils/size_utils.dart';
import 'package:flutter/material.dart';

import '../../core/utils/image_constant.dart';
import '../../theme/theme_helper.dart';
import '../../widgets/custom_image_view.dart';

class AddThreadsScreen extends StatefulWidget {
  const AddThreadsScreen({Key? key}) : super(key: key);

  @override
  State<AddThreadsScreen> createState() => _AddThreadsScreenState();
}

class _AddThreadsScreenState extends State<AddThreadsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: theme.colorScheme.onPrimary,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: theme.colorScheme.onPrimary,
        elevation: 0,
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Icon(
            Icons.arrow_back,
            color: Colors.grey,
          ),
        ),
        title: Text(
          "Add Thread",
          style: TextStyle(
            fontFamily: 'outfit',
            fontSize: 23,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              "Description",
              style: TextStyle(
                fontFamily: 'outfit',
                fontSize: 15,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Center(
            child: Container(
              height: 230,
              width: width / 1.1,
              decoration: BoxDecoration(
                color: Color(0XFFEFEFEF),
                border: Border.all(color: Colors.grey.shade300, width: 1),
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 0.5, right: 0.5),
                        child: Container(
                          height: 50,
                          width: width / 1.11,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.grey.shade300,
                            ),
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                CustomImageView(
                                  imagePath: ImageConstant.boldimage,
                                  height: 20,
                                ),
                                CustomImageView(
                                  imagePath: ImageConstant.italicimage,
                                  height: 15,
                                ),
                                CustomImageView(
                                  imagePath: ImageConstant.abimage,
                                  height: 30,
                                ),
                                CustomImageView(
                                  imagePath: ImageConstant.h1image,
                                  height: 15,
                                ),
                                CustomImageView(
                                  imagePath: ImageConstant.lineimage,
                                  height: 25,
                                ),
                                CustomImageView(
                                  imagePath: ImageConstant.imageline,
                                  height: 20,
                                ),
                                CustomImageView(
                                  imagePath: ImageConstant.pinimage,
                                  height: 20,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      cursorColor: Colors.grey,
                      maxLines: 6,
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Add Description....'),
                    ),
                  ),
                ],
              ),
            ),
          ),SizedBox(height: 10,),
          Center(
            child: Container(
              height: 50,
              width: width / 1.2,
              decoration: BoxDecoration(
                  color: Color(0XFFED1C25),
                  borderRadius: BorderRadius.circular(5)),
              child: Center(
                child: Text(
                  "Create Forum",
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
        ],
      ),
    );
  }
}
