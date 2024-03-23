import 'package:flutter/material.dart';
import 'package:pds/Market_place/MP_Prasantation/MP_Create_Account_Screen/mp_create_account_screen.dart';
import 'package:pds/core/utils/color_constant.dart';
import 'package:pds/core/utils/image_constant.dart';

class PaymentAndChargeScreen extends StatefulWidget {
  const PaymentAndChargeScreen({Key? key}) : super(key: key);

  @override
  State<PaymentAndChargeScreen> createState() => _PaymentAndChargeScreenState();
}

class _PaymentAndChargeScreenState extends State<PaymentAndChargeScreen> {
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
                    "platform charges details & payment",
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
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.asset(
                    ImageConstant.charge_payment,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Platform Charges Details & Payment",
                  style: TextStyle(fontFamily: 'outfit', fontSize: 18),
                ),
                Divider(
                  color: ColorConstant.primary_color,
                  // indent: 50,
                  endIndent: 70,
                  thickness: 1.5,
                ),
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
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "One Time Registration Charges",
                      style: TextStyle(
                          color: Colors.black,
                          fontFamily: 'outfit',
                          fontSize: 15,
                          fontWeight: FontWeight.w400),
                    ),
                    Spacer(),
                    Text(
                      "₹5999",
                      style: TextStyle(
                          color: Colors.black,
                          fontFamily: 'outfit',
                          decoration: TextDecoration.lineThrough,
                          fontSize: 13,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      width: 50,
                    ),
                    Text(
                      "Free",
                      style: TextStyle(
                          color: Colors.black,
                          fontFamily: 'outfit',
                          fontSize: 13,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "Annual Platform Charges",
                      style: TextStyle(
                          color: Colors.black,
                          fontFamily: 'outfit',
                          fontSize: 15,
                          fontWeight: FontWeight.w400),
                    ),
                    Spacer(),
                    Text(
                      "₹5999",
                      style: TextStyle(
                          color: Colors.black,
                          fontFamily: 'outfit',
                          fontSize: 13,
                          decoration: TextDecoration.lineThrough,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      width: 50,
                    ),
                    Text(
                      "Free",
                      style: TextStyle(
                          color: Colors.black,
                          fontFamily: 'outfit',
                          fontSize: 13,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  height: 40,
                  width: _width / 1,
                  decoration: BoxDecoration(
                    color: ColorConstant.primary_color,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Fixed Charges Payable Now",
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'outfit',
                              fontSize: 15,
                              fontWeight: FontWeight.w500),
                        ),
                        Text(
                          "Free",
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'outfit',
                              fontSize: 15,
                              fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: _height / 15,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CaBusinessAssosiateScreen(),
                        ));
                  },
                  child: Container(
                    height: 40,
                    // width: _width / 1.2,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: ColorConstant.primary_color,
                    ),
                    child: Center(
                        child: Text(
                      "Next",
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'outfit',
                          fontSize: 18,
                          fontWeight: FontWeight.w500),
                    )),
                  ),
                ),
              ]),
        ),
      ),
    );
  }
}
