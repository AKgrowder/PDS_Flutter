import 'package:flutter/material.dart';
import 'package:pds/Market_place/commenWiget.dart/commenFlushbar.dart';
import 'package:pds/core/utils/image_constant.dart';
import 'package:pds/widgets/custom_image_view.dart';

import '../../../../core/utils/color_constant.dart';

class ChooseCategoryScreen extends StatefulWidget {
  String eninty;
  ChooseCategoryScreen({Key? key, required this.eninty}) : super(key: key);

  @override
  State<ChooseCategoryScreen> createState() => _ChooseCategoryScreenState();
}

class _ChooseCategoryScreenState extends State<ChooseCategoryScreen> {
  bool areyousuppiler = false;
  bool areyouBuyer = false;
  bool rentalareyousuppiler = false;
  bool rentalareyouBuyer = false;
  List<Map<String, dynamic>> rawMatrialMarketPlace = [
    {
      'image': ImageConstant.supplyer_image,
      'value': 'Are You Supplier ?',
      'isSelcted': false,
    },
    {
      'image': ImageConstant.buyer_image,
      'value': 'Are You Buyer ?',
      'isSelcted': false,
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
                    .map((e) => Container(
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
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                onChanged: (bool? value) {
                                  
                                  /* if (!rawMatrialMarketPlace.any((element) =>
                                              element['isSelected'] &&
                                              element['value'] ==
                                                  'Are You Buyer ?') &&
                                          e['value'] == 'Are You Buyer ?' ||
                                      !rawMatrialMarketPlace.any((element) =>
                                              element['isSelected'] &&
                                              element['value'] ==
                                                  'Are You Supplier ?') &&
                                          e['value'] == 'Are You Supplier ?') {} */
                                  setState(() {
                                    for (int i = 0;
                                        i < rawMatrialMarketPlace.length;
                                        i++) {
                                      rawMatrialMarketPlace[i]['isSelcted'] =
                                          false;
                                    }
                                    e['isSelcted'] = value ?? false;
                                  });
                                },
                              ),
                            ],
                          ),
                        ))
                    .toList(),
              ),
              Container(
                margin: EdgeInsets.only(top: 15),
                height: 48,
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
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: Center(
                          child: Text(
                            'You are a Part Of Packaging Community in InPackaging Knowledge Forum',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                                fontFamily: 'outfit',
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                      ),
                    )
                  ],
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
                    .map((e) => Container(
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
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                onChanged: (bool? value) {
                                  for (int i = 0;
                                      i < marketplaceProductsServices.length;
                                      i++) {
                                    marketplaceProductsServices[i]
                                        ['isSelcted'] = false;
                                  }
                                  e['isSelcted'] = value ?? false;

                                  setState(() {});
                                },
                              ),
                            ],
                          ),
                        ))
                    .toList(),
              ),
              GestureDetector(
                onTap: () {
                  if (rawMatrialMarketPlace
                              .any((element) => element['isSelcted']) ==
                          false &&
                      marketplaceProductsServices
                          .any((element) => element['isSelcted'] == false)) {
                    CustomFlushBarMarketPlace().flushBar(
                        text: 'You can Selcted ${widget.eninty}',
                        context: context,
                        duration: 2,
                        backgroundColor: ColorConstant.primary_color);
                  }
                },
                child: Container(
                  margin: EdgeInsets.all(10),
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
            ],
          ),
        ));
  }
}
