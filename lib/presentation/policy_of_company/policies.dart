import 'package:flutter/material.dart';
import 'package:pds/presentation/policy_of_company/policy_screen.dart';
import 'package:pds/presentation/policy_of_company/privecy_policy.dart';
import 'package:pds/widgets/custom_image_view.dart';

import '../../core/utils/image_constant.dart';
import '../../widgets/app_bar/custom_app_bar.dart';

class PoliciesScreen extends StatefulWidget {
  const PoliciesScreen({Key? key}) : super(key: key);

  @override
  State<PoliciesScreen> createState() => _PoliciesScreenState();
}

class _PoliciesScreenState extends State<PoliciesScreen> {
  @override
  Widget build(BuildContext context) {
    var _height = MediaQuery.of(context).size.height;
    var _width = MediaQuery.of(context).size.width;
    //  double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      // backgroundColor: Colors.white,
      appBar: CustomAppBar(
        height: 84,
        leadingWidth: 84,
        leading: Container(
            height: 44,
            width: 44,
            margin: EdgeInsets.only(left: 30, top: 7),
            child: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Padding(
                padding: const EdgeInsets.only(top: 0),
                child: Icon(
                  Icons.arrow_back,
                  color: Theme.of(context).brightness == Brightness.light
                      ? Color(0XFF989898)
                      : Color(0xFFC5C0C0),
                ),
              ),
            )),
        centerTitle: true,
        title: Text(
          "Policies",
          textScaleFactor: 1.0,
          style: TextStyle(
            color: Theme.of(context).brightness == Brightness.light
                ? Colors.black
                : Colors.white,
          ),
          // style: AppStyle.txtOutfitBold16
          //     .copyWith(fontSize: getFontSize(20),
          //     )
        ),
      ),
      body: Column(
        children: [
          SizedBox(
            height: _height / 26,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Policies(
                              title: "Terms of Use",
                              data: Policy_Data.turms_of_use,
                            )));
              },
              child: Container(
                height: _height / 15,
                // width: width / 1.2,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  // color: const Color(0XFFF6F6F6),
                  color: Theme.of(context).brightness == Brightness.light
                      ? Color(0xFFF6F4F4)
                      : Color(0XFF212121),
                ),
                child: Center(
                  child: Row(
                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                          padding: const EdgeInsets.only(left: 20.0),
                          child: CustomImageView(
                            imagePath: ImageConstant.turms_of_use,
                            height: 20,
                          )),
                      Padding(
                        padding: const EdgeInsets.only(
                            right: 20.0, top: 0.5, left: 20),
                        child: Text(
                          "Terms of Use",
                          textScaleFactor: 1.0,
                          style: TextStyle(
                              color: Color(0XFF939393),
                              fontFamily: 'Outfit',
                              fontWeight: FontWeight.bold,
                              fontSize: 16),
                        ),
                      ),
                      Spacer(),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(
                          Icons.arrow_forward_ios,
                          color: Color(0XFF939393),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: _height / 45,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Policies(
                              title: /* "Privacy Policy" */ '',
                              data: Policy_Data.privacy_policy1,
                            )));
              },
              child: Container(
                height: _height / 15,
                // width: width / 1.2,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  // color: const Color(0XFFF6F6F6),
                  color: Theme.of(context).brightness == Brightness.light
                      ? Color(0xFFF6F4F4)
                      : Color(0XFF212121),
                ),
                child: Center(
                  child: Row(
                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                          padding: const EdgeInsets.only(left: 20.0),
                          child: CustomImageView(
                            imagePath: ImageConstant.privecy_policy,
                            height: 20,
                          )),
                      Padding(
                        padding: const EdgeInsets.only(
                            right: 20.0, top: 0.5, left: 20),
                        child: Text(
                          "Privacy Policy",
                          textScaleFactor: 1.0,
                          style: TextStyle(
                              color: Color(0XFF939393),
                              fontFamily: 'Outfit',
                              fontWeight: FontWeight.bold,
                              fontSize: 16),
                        ),
                      ),
                      Spacer(),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(
                          Icons.arrow_forward_ios,
                          color: Color(0XFF939393),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
          /* SizedBox(
            height: height / 45,
          ),
          Container(
            height: height / 15,
            width: width / 1.2,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: const Color(0XFFF6F6F6),
            ),
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0),
                    child: Image.asset(
                      "assets/images/about_us.png",
                      height: 20,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 140.0, top: 0.5),
                    child: Text(
                      "About Us",
                      style: TextStyle(
                          color: Color(0XFF939393),
                          fontFamily: 'Outfit',
                          fontWeight: FontWeight.bold,
                          fontSize: 16),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(
                      Icons.arrow_forward_ios,
                      color: Color(0XFF939393),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: height / 45,
          ),
          Container(
            height: height / 15,
            width: width / 1.2,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: const Color(0XFFF6F6F6),
            ),
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0),
                    child: Image.asset(
                      "assets/images/disclaimer.png",
                      height: 20,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 135.0, top: 0.5),
                    child: Text(
                      "Disclaimer a",
                      style: TextStyle(
                          color: Color(0XFF939393),
                          fontFamily: 'Outfit',
                          fontWeight: FontWeight.bold,
                          fontSize: 16),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(
                      Icons.arrow_forward_ios,
                      color: Color(0XFF939393),
                    ),
                  ),
                ],
              ),
            ),
          ), */
        ],
      ),
    );
  }
}
