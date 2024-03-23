import 'package:flutter/material.dart';
import 'package:pds/Market_place/MP_Dilogs/MP_singin_dilog.dart';
import 'package:pds/Market_place/MP_Dilogs/MP_singup_flow_dilogs.dart';
import 'package:pds/core/utils/color_constant.dart';
import 'package:pds/core/utils/image_constant.dart';

class MpHomeScreen extends StatefulWidget {
  const MpHomeScreen({Key? key}) : super(key: key);

  @override
  State<MpHomeScreen> createState() => _MpHomeScreenState();
}

class _MpHomeScreenState extends State<MpHomeScreen> {
  bool isunderapprovel = false;
  bool isSaved = false;

  void toggleSaved() {
    setState(() {
      isSaved = !isSaved;
    });
  }

  @override
  Widget build(BuildContext context) {
    var _height = MediaQuery.of(context).size.height;
    var _width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 15.0, right: 15),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        height: 50,
                        width: 50,
                        child: Image.asset(
                          ImageConstant.iplogo,
                        ),
                      ),
                      Container(
                        height: 40,
                        width: _width / 2,
                        decoration: BoxDecoration(
                            border: Border.all(
                              color: ColorConstant.primary_color,
                              width: 1,
                            ),
                            borderRadius: BorderRadius.all(Radius.circular(8))),
                        child: TextField(
                          cursorColor: ColorConstant.primary_color,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Search Your Products',
                            hintStyle: TextStyle(
                              fontSize: 15,
                            ),
                            icon: Padding(
                              padding: const EdgeInsets.only(
                                left: 5.0,
                              ),
                              child: Container(
                                child: Icon(
                                  Icons.search,
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          showDialog(
                            barrierDismissible: true,
                            context: context,
                            builder: (_) => CategoryChooseDilog(),
                          );
                        },
                        child: Container(
                          height: 30,
                          width: 30,
                          child: Image.asset(
                            ImageConstant.groupicon,
                          ),
                        ),
                      ),
                      Container(
                        height: 30,
                        width: 30,
                        child: Image.asset(
                          ImageConstant.notificationicon,
                        ),
                      ),
                      Container(
                        height: 30,
                        width: 30,
                        child: Image.asset(
                          ImageConstant.tomcruse,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  isunderapprovel == true
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Hello Manufacturer!",
                              style: TextStyle(
                                fontSize: 20,
                                fontFamily: 'outfit',
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(
                              height: _height / 5.5,
                            ),
                            Center(
                              child: Container(
                                child: Image.asset(
                                  ImageConstant.underapproveimage,
                                ),
                              ),
                            ),
                          ],
                        )
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                              //------------------------------------------------------Wallet Balance----------------------------------------------------------------------------------------------------------
                              Container(
                                height: 60,
                                width: _width,
                                color: Colors.white,
                                child: Card(
                                  borderOnForeground: true,
                                  color: Colors.white,
                                  child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 10.0),
                                          child: Container(
                                            height: 40,
                                            child: Image.asset(
                                                ImageConstant.walletimage),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 25,
                                        ),
                                        Text(
                                          "Wallet Balance",
                                          style: TextStyle(
                                            fontSize: 15,
                                            fontFamily: 'outfit',
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                        Spacer(),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              right: 10.0),
                                          child: Text(
                                            "₹ 5,23,847",
                                            style: TextStyle(
                                                fontSize: 15,
                                                fontFamily: 'outfit',
                                                fontWeight: FontWeight.bold,
                                                color: ColorConstant
                                                    .primary_color),
                                          ),
                                        ),
                                      ]),
                                ),
                              ),
                              //---------------------------------------------------------Fund status----------------------------------------------------------------------------------------------------------
                              Container(
                                height: _height / 7,
                                width: _width,
                                color: Colors.white,
                                child: Card(
                                  borderOnForeground: true,
                                  color: ColorConstant.primaryLight_color,
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            SizedBox(
                                              width: 15,
                                            ),
                                            Text(
                                              "Credit Limit",
                                              style: TextStyle(
                                                fontSize: 15,
                                                fontFamily: 'outfit',
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                            Spacer(),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 10.0),
                                              child: Text(
                                                "2,00,000",
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    fontFamily: 'outfit',
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.black),
                                              ),
                                            ),
                                          ]),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Stack(
                                          children: [
                                            ClipRRect(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(10)),
                                              child: LinearProgressIndicator(
                                                minHeight: 10,
                                                backgroundColor:
                                                    Color(0xFF74AA61),
                                                value: 0.7,
                                                color:
                                                    ColorConstant.primary_color,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            SizedBox(
                                              width: 15,
                                            ),
                                            Text(
                                              "Utilized Fund",
                                              style: TextStyle(
                                                fontSize: 15,
                                                fontFamily: 'outfit',
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                            Spacer(),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 10.0),
                                              child: Text(
                                                "Balance",
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    fontFamily: 'outfit',
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.black),
                                              ),
                                            ),
                                          ]),
                                      Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            SizedBox(
                                              width: 15,
                                            ),
                                            Text(
                                              "1,17,202",
                                              style: TextStyle(
                                                fontSize: 15,
                                                fontFamily: 'outfit',
                                                color:
                                                    ColorConstant.primary_color,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                            Spacer(),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 10.0),
                                              child: Text(
                                                "82,798",
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    fontFamily: 'outfit',
                                                    fontWeight: FontWeight.bold,
                                                    color: Color(0XFF248900)),
                                              ),
                                            ),
                                          ]),
                                    ],
                                  ),
                                ),
                              ),

                              //----------------------------------------------------------OverView---------------------------------------------------------------------------------------------------------------------------------------------------
                              SizedBox(
                                height: 20,
                              ),
                              Text(
                                "Overview",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontFamily: 'outfit',
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              SizedBox(
                                height: 15,
                              ),

                              Row(
                                children: [
                                  Container(
                                    height: 100,
                                    width: _width / 2.2,
                                    color: Colors.white,
                                    child: Card(
                                      borderOnForeground: true,
                                      color: Colors.white,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Container(
                                                  width: 100,
                                                  child: Text(
                                                    "Total Orders Placed",
                                                    maxLines: 2,
                                                    style: TextStyle(
                                                      fontSize: 15,
                                                      fontFamily: 'outfit',
                                                      fontWeight:
                                                          FontWeight.w400,
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 10.0),
                                                  child: Container(
                                                    height: 40,
                                                    child: Image.asset(
                                                        ImageConstant
                                                            .orderhomeimage),
                                                  ),
                                                ),
                                              ]),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                              "200",
                                              maxLines: 2,
                                              style: TextStyle(
                                                fontSize: 18,
                                                fontFamily: 'outfit',
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Container(
                                    height: 100,
                                    width: _width / 2.2,
                                    color: Colors.white,
                                    child: Card(
                                      borderOnForeground: true,
                                      color: Colors.white,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Container(
                                                  width: 100,
                                                  child: Text(
                                                    "Total Orders Placed",
                                                    maxLines: 2,
                                                    style: TextStyle(
                                                      fontSize: 15,
                                                      fontFamily: 'outfit',
                                                      fontWeight:
                                                          FontWeight.w400,
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 10.0),
                                                  child: Container(
                                                    height: 40,
                                                    child: Image.asset(
                                                        ImageConstant
                                                            .priceimage),
                                                  ),
                                                ),
                                              ]),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                              "2,50,000",
                                              maxLines: 2,
                                              style: TextStyle(
                                                fontSize: 18,
                                                fontFamily: 'outfit',
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              //--------------------------------------------------------Discover custom packaging at the best prices for you-------------------------------------------------------------------------------------------------------------
                              SizedBox(
                                height: 20,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                      height: 40,
                                      child: Image.asset(
                                          ImageConstant.homedecoreimage)),
                                  Container(
                                    width: _width / 1.3,
                                    child: Text(
                                      "Discover custom packaging at the best prices for you",
                                      maxLines: 2,
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontFamily: 'outfit',
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              pricelist(_width),
                            ]),
                ]),
          ),
        ),
      ),
    );
  }

  pricelist(_width) {
    return Padding(
      padding: const EdgeInsets.only(top: 15.0),
      child: ListView.builder(
        physics: NeverScrollableScrollPhysics(),
        itemCount: 8,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return Column(
            children: [
              Container(
                height: 80,
                decoration: BoxDecoration(color: Colors.white),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      GestureDetector(
                        onTap: () {
                          if (isSaved) {
                            setState(() {
                              isSaved = false;
                            });
                          } else {
                            setState(() {
                              isSaved = true;
                            });
                          }
                        },
                        child: isSaved
                            ? Container(
                                height: 50,
                                child: Image.asset(ImageConstant.mpsaveimage),
                              )
                            : Container(
                                height: 50,
                                child: Image.asset(ImageConstant.mpunsaveimage),
                              ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            child: Text(
                              "Paper Sheets",
                              maxLines: 2,
                              style: TextStyle(
                                fontSize: 15,
                                fontFamily: 'outfit',
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          Container(
                            // color: Colors.amber,
                            width: _width / 1.75,
                            child: Text(
                              "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor.... ",
                              maxLines: 2,
                              style: TextStyle(
                                fontSize: 13,
                                fontFamily: 'outfit',
                                fontWeight: FontWeight.w200,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Container(
                        height: 40,
                        width: 75,
                        child: Card(
                          color: ColorConstant.primary_color,
                          child: Center(
                            child: Text(
                              "Get Price",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'outfit',
                                  fontWeight: FontWeight.w400),
                            ),
                          ),
                        ),
                      ),
                    ]),
              ),
              Divider(
                color: Colors.black.withOpacity(0.2),
              ),
            ],
          );
        },
      ),
    );
  }
}
