// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:pds/Market_place/MP_Prasantation/Charge_Payment_Screen/charge_payment_screen.dart';
import 'package:pds/Market_place/commenWiget.dart/commenButton.dart';
import 'package:pds/Market_place/commenWiget.dart/commenFlushbar.dart';
import 'package:pds/core/utils/image_constant.dart';
import 'package:pds/widgets/custom_image_view.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/utils/color_constant.dart';

class ChooseCategoryScreen extends StatefulWidget {
  String eninty;
  ChooseCategoryScreen({Key? key, required this.eninty}) : super(key: key);

  @override
  State<ChooseCategoryScreen> createState() => _ChooseCategoryScreenState();
}

class _ChooseCategoryScreenState extends State<ChooseCategoryScreen> {
  List<Map<String, dynamic>> rawMatrialMarketPlace = [
    {
      'image': ImageConstant.supplyer_image,
      'value': 'Are You Supplier ?',
      'isSelcted': false,
      'isDisabled': false,
    },
    {
      'image': ImageConstant.buyer_image,
      'value': 'Are You Buyer ?',
      'isSelcted': false,
      'isDisabled': false,
    },
  ];

  List<Map<String, dynamic>> marketplaceProductsServices = [
    {
      'image': ImageConstant.supplyer_image,
      'value': 'Are You Supplier ?',
      'isSelcted': false,
      'isDisabled': false,
    },
    {
      'image': ImageConstant.buyer_image,
      'value': 'Are You Buyer ?',
      'isSelcted': false,
      'isDisabled': false,
    },
    {
      'image': ImageConstant.AreYouBusinessAsscociate,
      'value': 'Are You Business Asscociate ?',
      'isSelcted': false,
      'isDisabled': false,
    },
    {
      'image': ImageConstant.AreYouFranchiseOwner,
      'value': 'Are You Franchise Owner ?',
      'isSelcted': false,
      'isDisabled': false,
    },
  ];

  handelEvents(Map<String, dynamic> selectedOption,
      List<Map<String, dynamic>> options, bool isvalue, String listName) {
    setState(() {
      for (int i = 0; i < options.length; i++) {
        options[i]['isSelcted'] = false;
      }
      selectedOption['isSelcted'] = isvalue;
      if (rawMatrialMarketPlace.any((element) => element['isSelcted']) ==
              true ||
          marketplaceProductsServices.any((element) => element['isSelcted']) ==
              true) {
        if (listName == 'rawMatrialMarketPlace') {
          marketplaceProductsServices.forEach((element) {
            if (selectedOption['value'] == 'Are You Buyer ?') {
              if (element['value'] == 'Are You Supplier ?') {
                element['isDisabled'] = false;
              } else {
                element['isDisabled'] = true;
              }
            } else if (selectedOption['value'] == 'Are You Supplier ?') {
              if (element['value'] == 'Are You Buyer ?') {
                element['isDisabled'] = false;
              } else {
                element['isDisabled'] = true;
              }
            }
          });
        } else if (listName == 'marketplaceProductsServices') {
          print("this condison is working");
          rawMatrialMarketPlace.forEach((element) {
            if (selectedOption['value'] == 'Are You Buyer ?') {
              if (element['value'] == 'Are You Supplier ?') {
                element['isDisabled'] = false;
              } else {
                element['isDisabled'] = true;
              }
            } else if (selectedOption['value'] == 'Are You Supplier ?') {
              if (element['value'] == 'Are You Buyer ?') {
                element['isDisabled'] = false;
              } else {
                element['isDisabled'] = true;
              }
            } else if (selectedOption['value'] ==
                    'Are You Business Asscociate ?' ||
                selectedOption['value'] == 'Are You Franchise Owner ?') {
              element['isDisabled'] = true;
            }
          });
          print("worknfffff-${rawMatrialMarketPlace}");
        }
      } else {
        rawMatrialMarketPlace.forEach((element) {
          element['isDisabled'] = false;
        });
        marketplaceProductsServices.forEach((element) {
          element['isDisabled'] = false;
        });
      }
    });
  }

  @override
  void initState() {
    print("check Value -${widget.eninty}");
    super.initState();
  }

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
          padding: const EdgeInsets.only(left: 15, right: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Column(
                  children: [
                    Text(
                      "choose your category",
                      style: TextStyle(
                          fontFamily: 'outfit',
                          fontSize: 20,
                          fontWeight: FontWeight.w500),
                    ),
                    Divider(
                      indent: 110,
                      endIndent: 110,
                      color: ColorConstant.primary_color,
                      thickness: 1.5,
                    ),
                  ],
                ),
              ),
              Text(
                "In Raw Material Marketplace",
                style: TextStyle(
                    color: ColorConstant.primary_color,
                    fontSize: 16,
                    fontFamily: 'outfit',
                    fontWeight: FontWeight.w400),
              ),
              SizedBox(
                height: 10,
              ),
              Column(
                children: rawMatrialMarketPlace
                    .map((e) => AbsorbPointer(
                          absorbing: e['isDisabled'],
                          child: Opacity(
                            opacity: e['isDisabled'] ? 0.5 : 1.0,
                            child: Container(
                              margin: EdgeInsets.only(top: 15),
                              height: 48,
                              width: _width,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  border: Border.all(
                                    color: Color(0xffDBDBDB),
                                    width: 1,
                                  )),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 10),
                                    child: CustomImageView(
                                      svgPath: e['image'],
                                      height: 40,
                                    ),
                                  ),
                                  Text(e['value'],
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 15,
                                          fontFamily: 'outfit',
                                          fontWeight: FontWeight.w400)),
                                  Checkbox(
                                    checkColor: Colors.white,
                                    activeColor: ColorConstant.primary_color,
                                    side: BorderSide(color: Colors.black),
                                    value: e['isSelcted'],
                                    onChanged: e['isDisabled'] == true
                                        ? null
                                        : (bool? value) {
                                            handelEvents(
                                                e,
                                                rawMatrialMarketPlace,
                                                value ?? false,
                                                'rawMatrialMarketPlace');
                                          },
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ))
                    .toList(),
              ),
              AbsorbPointer(
                absorbing: true,
                child: Opacity(
                  opacity: 0.5,
                  child: Container(
                    margin: EdgeInsets.only(top: 15),
                    // height: 50,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(
                          color: Color(0xffDBDBDB),
                          width: 1,
                        )),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomImageView(
                          svgPath: ImageConstant.forum,
                          height: 60,
                        ),
                        Flexible(
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.only(top: 3, left: 10),
                              child: Text(
                                'You are a Part Of Packaging Community in InPackaging Knowledge Forum',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 15,
                                    fontFamily: 'outfit',
                                    fontWeight: FontWeight.w400),
                              ),
                            ),
                          ),
                        ),
                        Checkbox(
                          checkColor: Colors.white,
                          activeColor: ColorConstant.primary_color,
                          side: BorderSide(color: Colors.black),
                          value: true,
                          onChanged: null,
                        )
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "In Packaging Marketplace Products & Services",
                style: TextStyle(
                    color: ColorConstant.primary_color,
                    fontSize: 16,
                    fontFamily: 'outfit',
                    fontWeight: FontWeight.w400),
              ),
              SizedBox(
                height: 10,
              ),
              Column(
                children: marketplaceProductsServices
                    .map((e) => AbsorbPointer(
                          absorbing: e['isDisabled'],
                          child: Opacity(
                            opacity: e['isDisabled'] ? 0.5 : 1.0,
                            child: Container(
                              margin: EdgeInsets.only(top: 10),
                              height: 48,
                              width: _width,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  border: Border.all(
                                    color: Color(0xffDBDBDB),
                                    width: 1,
                                  )),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 10),
                                    child: CustomImageView(
                                      svgPath: e['image'],
                                      height: 40,
                                    ),
                                  ),
                                  Text(e['value'],
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 15,
                                          fontFamily: 'outfit',
                                          fontWeight: FontWeight.w400)),
                                  Checkbox(
                                    checkColor: Colors.white,
                                    activeColor: ColorConstant.primary_color,
                                    side: BorderSide(color: Colors.black),
                                    value: e['isSelcted'],
                                    onChanged: e['isDisabled'] == true
                                        ? null
                                        : (bool? value) {
                                            handelEvents(
                                                e,
                                                marketplaceProductsServices,
                                                value ?? false,
                                                'marketplaceProductsServices');
                                          },
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ))
                    .toList(),
              ),
              CommonButton(
                  margin: EdgeInsets.all(10),
                  child: Center(
                      child: Text(
                    "Next",
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'outfit',
                        fontSize: 18,
                        fontWeight: FontWeight.w500),
                  )),
                  height: 40,
                  radius: 8,
                  color: ColorConstant.primary_color,
                  onTap: onSubmitMethod)
            ],
          ),
        ));
  }

  onSubmitMethod() async {
    if (rawMatrialMarketPlace.any((element) => element['isSelcted']) == true &&
        marketplaceProductsServices.any((element) => element['isSelcted']) ==
            true) {
      print("rawMatrialchedck-${widget.eninty}");

      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => PaymentAndChargeScreen(
                    category: widget.eninty,
                    rmSelcetion: rawMatrialMarketPlace
                        .firstWhere((element) => element['isSelcted'])['value'],
                    psSelcetion: marketplaceProductsServices
                        .firstWhere((element) => element['isSelcted'])['value'],
                  )));
    } else if (rawMatrialMarketPlace.any((element) => element['isSelcted']) ==
            true &&
        marketplaceProductsServices.every((element) => element['isSelcted']) ==
            false) {
      print("RAW_MATERIAL_MARKET_PLACE");

      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => PaymentAndChargeScreen(
                    category: 'RAW_MATERIAL_MARKET_PLACE',
                    rmSelcetion: rawMatrialMarketPlace
                        .firstWhere((element) => element['isSelcted'])['value'],
                  )));
    } else if (marketplaceProductsServices
                .any((element) => element['isSelcted']) ==
            true &&
        rawMatrialMarketPlace.every((element) => element['isSelcted']) ==
            false) {
      print("PACKAGING_PRODUCT_SERVICES");
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => PaymentAndChargeScreen(
                    category: 'PACKAGING_PRODUCT_SERVICES',
                    psSelcetion: marketplaceProductsServices
                        .firstWhere((element) => element['isSelcted'])['value'],
                  )));
    } else if (!rawMatrialMarketPlace.any((element) => element['isSelcted']) ==
            true &&
        !marketplaceProductsServices.any((element) => element['isSelcted']) ==
            true) {
      CustomFlushBarMarketPlace().flushBar(
          text: 'You can Selcted At Lease One Options',
          context: context,
          duration: 2,
          backgroundColor: ColorConstant.primary_color);
    }
  }
}
