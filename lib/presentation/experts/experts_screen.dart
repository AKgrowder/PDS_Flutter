import 'package:archit_s_application1/core/utils/image_constant.dart';
import 'package:archit_s_application1/core/utils/size_utils.dart';
import 'package:archit_s_application1/widgets/custom_image_view.dart';
import 'package:flutter/material.dart';

import '../../theme/theme_helper.dart';

class ExpertsScreen extends StatefulWidget {
  const ExpertsScreen({Key? key}) : super(key: key);

  @override
  State<ExpertsScreen> createState() => _ExpertsScreenState();
}

class _ExpertsScreenState extends State<ExpertsScreen> {
  @override
  Widget build(BuildContext context) {
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
          "Experts",
          style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black,
              fontFamily: "outfit",
              fontSize: 20),
        ),
      ),
      body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Padding(
          padding: const EdgeInsets.only(top: 20.0, right: 25, left: 25),
          child: Row(
            children: [
              Container(
                width: 55,
                height: 50,
                decoration: BoxDecoration(
                    color: Color(0xFFED1C25),
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(5),
                        bottomLeft: Radius.circular(5))),
                child: Center(
                  child: CustomImageView(
                    imagePath: ImageConstant.searchimage,
                    color: Colors.white,
                    height: 30,
                  ),
                ),
              ),
              Container(
                height: 50,
                width: 230,
                decoration: BoxDecoration(
                  color: Color(0xFFF6F6F6),
                  border: Border.all(
                    color: Color(0xFFEFEFEF),
                  ),
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(5),
                      bottomLeft: Radius.circular(5)),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(top: 2.0, left: 10),
                  child: TextField(
                    decoration: InputDecoration(
                        hintText: 'Search here...', border: InputBorder.none),
                  ),
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Container(
                height: 50,
                width: 55,
                decoration: BoxDecoration(
                    color: Color(0xFFFFE7E7),
                    border: Border.all(
                      color: Color(0xFFED1C25),
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(5))),
                child: Center(
                  child: CustomImageView(
                    imagePath: ImageConstant.filterimage,
                    height: 30,
                  ),
                ),
              )
            ],
          ),
        ),
        Container(
          width: width,
          height: height / 1.2,
          child: GridView.builder(
            itemCount: 4,
            gridDelegate:
                SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(5.0),
                child: Container(
                  // height: 50,
                  // width: 50,
                  decoration:
                      BoxDecoration(border: Border.all(color: Colors.red),borderRadius: BorderRadius.all(Radius.circular(8))),
                ),
              );
            },
          ),
        )
      ]),
    );
  }
}
