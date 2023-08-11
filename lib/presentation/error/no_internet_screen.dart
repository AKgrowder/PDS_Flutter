import 'package:archit_s_application1/core/utils/size_utils.dart';
import 'package:flutter/material.dart';

import '../../core/utils/image_constant.dart';
import '../../theme/theme_helper.dart';
import '../../widgets/custom_image_view.dart';

class NoInternetScreen extends StatefulWidget {
  const NoInternetScreen({Key? key}) : super(key: key);

  @override
  State<NoInternetScreen> createState() => _NoInternetScreenState();
}

class _NoInternetScreenState extends State<NoInternetScreen> {
  @override
  Widget build(BuildContext context) {
      var _height = MediaQuery.of(context).size.height;
    var _width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: theme.colorScheme.onPrimary,
      body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 100,
            ),
            Center(
              child: CustomImageView(
                imagePath: ImageConstant.nointernetimage,
                height: 250,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              "No Internet",
              style: TextStyle(
                fontFamily: 'outfit',
                fontSize: 50,
                color: Colors.grey,
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              "Please check your Internet Connection",
              style: TextStyle(
                fontFamily: 'outfit',
                fontSize: 20,
                color: Colors.grey,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 80,
            ),
            GestureDetector(
              onTap: () {},
              child: Container(
                height: 50,
                width: _width / 2,
                decoration: BoxDecoration(
                    color: Color(0xFFED1C25),
                    borderRadius: BorderRadius.all(Radius.circular(5))),
                child: Center(
                  child: Text(
                    "Retury",
                    style: TextStyle(
                      fontFamily: 'outfit',
                      fontSize: 15,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            )
          ]),
    );
  }
}
