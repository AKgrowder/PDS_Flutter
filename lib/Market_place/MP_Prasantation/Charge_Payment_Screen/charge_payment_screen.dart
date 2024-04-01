import 'package:flutter/material.dart';
import 'package:pds/Market_place/LoginScrrenNew/login_registerscreeen.dart';
import 'package:pds/Market_place/commenWiget.dart/commenButton.dart';
import 'package:pds/core/utils/color_constant.dart';

class PaymentAndChargeScreen extends StatefulWidget {
  String category;
  String? rmSelcetion;
  String? psSelcetion;

  PaymentAndChargeScreen(
      {Key? key, required this.category, this.rmSelcetion, this.psSelcetion})
      : super(key: key);

  @override
  State<PaymentAndChargeScreen> createState() => _PaymentAndChargeScreenState();
}

class _PaymentAndChargeScreenState extends State<PaymentAndChargeScreen> {
  String? registrationName;
  @override
  Widget build(BuildContext context) {
    var _height = MediaQuery.of(context).size.height;
    var _width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
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
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 25.0, right: 25),
        child: SingleChildScrollView(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Text(
                    "Platform Charges Details & Payment",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                  ),
                ),
                Divider(
                  color: ColorConstant.primary_color,
                  indent: 50,
                  endIndent: 50,
                  thickness: 1.5,
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  decoration:
                      BoxDecoration(border: Border.all(color: Colors.grey)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 40,
                        width: _width / 1,
                        decoration: BoxDecoration(
                          color: ColorConstant.primary_color,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "Charges",
                            style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'outfit',
                                fontSize: 18,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "One Time Registration Charges",
                          style: TextStyle(
                              color: Colors.black,
                              fontFamily: 'outfit',
                              fontSize: 15,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "₹5999",
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontFamily: 'outfit',
                                  decoration: TextDecoration.lineThrough,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              "Free",
                              style: TextStyle(
                                  color: ColorConstant.primary_color,
                                  fontFamily: 'outfit',
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Annual Platform Charges",
                          style: TextStyle(
                              color: Colors.black,
                              fontFamily: 'outfit',
                              fontSize: 15,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "₹2999",
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontFamily: 'outfit',
                                  decoration: TextDecoration.lineThrough,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              "Free",
                              style: TextStyle(
                                  color: ColorConstant.primary_color,
                                  fontFamily: 'outfit',
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: 40,
                        width: _width / 1,
                        decoration: BoxDecoration(
                          color: ColorConstant.primaryLight_color,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Fixed Charges Payable Now",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontFamily: 'outfit',
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500),
                              ),
                              Text(
                                "Free",
                                style: TextStyle(
                                    color: ColorConstant.primary_color,
                                    fontFamily: 'outfit',
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                CommonButton(
                  height: 40,
                  // width: _width / 1.2,
                  radius: 8,
                  child: Center(
                      child: Text(
                    "Next",
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'outfit',
                        fontSize: 18,
                        fontWeight: FontWeight.w500),
                  )),
                  color: ColorConstant.primary_color,
                  onTap: onSubmtiMethod,
                  /* onTap: () {
                   
                    
                  }, */
                )
              ]),
        ),
      ),
    );
  }

  onSubmtiMethod() {
    print("String widget.category -${widget.category}");
    print("String psSelcetion -${widget.psSelcetion}");
    print("String rmSelcetion -${widget.rmSelcetion}");

    if (widget.psSelcetion != null && widget.rmSelcetion != null) {
      registrationName =
          '${widget.rmSelcetion?.split('You').last.split('?').first.trim()}/${widget.psSelcetion?.split('You').last.split('?').first.trim()}';
    } else if (widget.psSelcetion != null) {
      registrationName =
          widget.psSelcetion?.split('You').last.split('?').first.trim();
    } else if (widget.rmSelcetion != null) {
      registrationName =
          widget.rmSelcetion?.split('You').last.split('?').first.trim();
    }
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => LoginAndRegistrstionScreen(
                  screenName: 'Registration',
                  registrationName: registrationName,
                  category: widget.category,
                )));
  }
}
