import 'package:flutter/material.dart';

import '../../core/utils/image_constant.dart';
import '../../theme/theme_helper.dart';
import '../../widgets/custom_image_view.dart';

class ApiErrorScreen extends StatefulWidget {
  const ApiErrorScreen({Key? key}) : super(key: key);

  @override
  State<ApiErrorScreen> createState() => _ApiErrorScreenState();
}

class _ApiErrorScreenState extends State<ApiErrorScreen> {
  @override
  Widget build(BuildContext context) {
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
                imagePath: ImageConstant.pagenotfound,
                height: 250,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              "Page not Found",
              style: TextStyle(
                fontFamily: 'outfit',
                fontSize: 40,
                color: Colors.grey,
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              "Please try after some time",
              style: TextStyle(
                fontFamily: 'outfit',
                fontSize: 25,
                color: Colors.grey,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 80,
            ),
             
          ]),
    );
  }
}
