import 'package:flutter/material.dart';
import 'package:pds/core/utils/image_constant.dart';

import '../../../../core/utils/color_constant.dart';

class ChooseCategoryScreen extends StatefulWidget {
  const ChooseCategoryScreen({Key? key}) : super(key: key);

  @override
  State<ChooseCategoryScreen> createState() => _ChooseCategoryScreenState();
}

class _ChooseCategoryScreenState extends State<ChooseCategoryScreen> {
  bool areyousuppiler = false;
  bool areyouBuyer = false;
  bool rentalareyousuppiler = false;
  bool rentalareyouBuyer = false;

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
        padding: const EdgeInsets.only(left: 25.0, right: 25.0),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  "choose your category",
                  style: TextStyle(
                      fontFamily: 'outfit',
                      fontSize: 20,
                      fontWeight: FontWeight.w500),
                ),
              ),
              Divider(
                color: ColorConstant.primary_color,
                indent: 120,
                endIndent: 120,
                thickness: 1.5,
              ),
              SizedBox(
                height: _height / 50,
              ),
              Text(
                "In Raw Material Marketplace",
                style: TextStyle(
                    color: ColorConstant.primary_color,
                    fontSize: 18,
                    fontFamily: 'outfit',
                    fontWeight: FontWeight.w400),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: Container(
                  height: 50,
                  // width: _width / 1.2,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                      border: Border.all(color: Colors.black.withOpacity(0.2))),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 20.0),
                          child: Image.asset(
                            ImageConstant.supplyer_image,
                            height: 40,
                          ),
                        ),
                        Text("Are You Supplier ?",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                                fontFamily: 'outfit',
                                fontWeight: FontWeight.w400)),
                        Checkbox(
                          checkColor: Colors.white,
                          activeColor: ColorConstant.primary_color,
                          side: BorderSide(color: Colors.black),
                          value: areyousuppiler,
                          onChanged: (bool? value) {
                            setState(() {
                              areyousuppiler = value!;
                            });
                          },
                        ),
                      ]),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: Container(
                  height: 50,
                  // width: _width / 1.2,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                      border: Border.all(color: Colors.black.withOpacity(0.2))),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 20.0),
                          child: Image.asset(
                            ImageConstant.buyer_image,
                            height: 40,
                          ),
                        ),
                        Text("Are You Buyer ?",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                                fontFamily: 'outfit',
                                fontWeight: FontWeight.w400)),
                        Checkbox(
                          checkColor: Colors.white,
                          activeColor: ColorConstant.primary_color,
                          side: BorderSide(color: Colors.black),
                          value: areyouBuyer,
                          onChanged: (bool? value) {
                            setState(() {
                              areyouBuyer = value!;
                            });
                          },
                        ),
                      ]),
                ),
              ),

//------------------------------------------------------ In Rental Packaging Product Marketplace-----------------------------------------------------------------

              SizedBox(
                height: _height / 50,
              ),
              Text(
                "In Rental Packaging Product Marketplace",
                style: TextStyle(
                    color: ColorConstant.primary_color,
                    fontSize: 18,
                    fontFamily: 'outfit',
                    fontWeight: FontWeight.w400),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: Container(
                  height: 50,
                  // width: _width / 1.2,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                      border: Border.all(color: Colors.black.withOpacity(0.2))),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 20.0),
                          child: Image.asset(
                            ImageConstant.supplyer_image,
                            height: 40,
                          ),
                        ),
                        Text("Are You Supplier ?",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                                fontFamily: 'outfit',
                                fontWeight: FontWeight.w400)),
                        Checkbox(
                          checkColor: Colors.white,
                          activeColor: ColorConstant.primary_color,
                          side: BorderSide(color: Colors.black),
                          value: rentalareyousuppiler,
                          onChanged: (bool? value) {
                            setState(() {
                              rentalareyousuppiler = value!;
                            });
                          },
                        ),
                      ]),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: Container(
                  height: 50,
                  // width: _width / 1.2,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                      border: Border.all(color: Colors.black.withOpacity(0.2))),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 20.0),
                          child: Image.asset(
                            ImageConstant.buyer_image,
                            height: 40,
                          ),
                        ),
                        Text("Are You Buyer ?",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                                fontFamily: 'outfit',
                                fontWeight: FontWeight.w400)),
                        Checkbox(
                          checkColor: Colors.white,
                          activeColor: ColorConstant.primary_color,
                          side: BorderSide(color: Colors.black),
                          value: rentalareyouBuyer,
                          onChanged: (bool? value) {
                            setState(() {
                              rentalareyouBuyer = value!;
                            });
                          },
                        ),
                      ]),
                ),
              )
            ]),
      ),
    );
  }
}
