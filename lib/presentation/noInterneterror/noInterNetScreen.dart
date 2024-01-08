import 'package:flutter/material.dart';
import 'package:pds/core/utils/color_constant.dart';
import 'package:pds/core/utils/image_constant.dart';
import 'package:pds/core/utils/internet_utils.dart';
import 'package:pds/presentation/%20new/newbottembar.dart';

class NoInterNetScreen extends StatelessWidget {
  const NoInterNetScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var _height = MediaQuery.of(context).size.height;
    var _width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: WillPopScope(
        onWillPop: () async => false,
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(ImageConstant.noInternetConnection, ),
              SizedBox(height: _height * 0.03),
              Text(
                "No Internet Connection",
                textAlign: TextAlign.center,
                style: TextStyle(
                    // color: Clr.textClr,
                    fontWeight: FontWeight.w700,
                    fontSize: 16.5),
              ),
              SizedBox(height: _height * 0.01),
              Text(
                "Please check your internet connection \nand try again",
                textAlign: TextAlign.center,
                style: TextStyle(
                    // color: Clr.subTextClr,
                    fontWeight: FontWeight.w600,
                    fontSize: 12),
              ),
              SizedBox(height: _height * 0.02),
              GestureDetector(
                onTap: () {
                  interNetCheck(context);
                },
                child: Container(
                  height: 40,
                  width: 100,
                  decoration: BoxDecoration(
                      color: ColorConstant.primary_color,
                      borderRadius: BorderRadius.circular(10)),
                  child: Center(
                      child: Text(
                    "Retry",
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.w600),
                  )),
                ),
              )
              // Padding(
              //   padding: EdgeInsets.only(
              //       top: _height * 0.04,
              //       bottom: _height * 0.025,
              //       left: _width * 0.18,
              //       right: _width * 0.18),
              //   // child: Button(
              //   //   onPressed: () async {
              //   //     final hasInternet = await checkInternet();
              //   //     if (hasInternet == true) {
              //   //       Get.back();
              //   //       Get.back();
              //   //       Get.back();
              //   //     } else {
              //   //       MyToasts().warningToast(toast: Validate.noInternet);
              //   //     }
              //   //   },
              //   //   text: "Try Again",
              //   //   fontWeight: FontWeight.w700,
              //   //   fontSize: 13.sp,
              //   //   textColor: Clr.bgColor,
              //   // ),
              // ),
            ],
          ),
        ),
      ),
    );
  }

  interNetCheck(context) async {
    final hasInternet = await checkInternet();
    if (hasInternet == true) {
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return NewBottomBar(
          buttomIndex: 0,
        );
      }));
    } else {}
  }
}
