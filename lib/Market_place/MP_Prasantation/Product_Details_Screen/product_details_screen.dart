import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:pds/core/utils/color_constant.dart';
import 'package:pds/core/utils/image_constant.dart';
import 'package:pds/widgets/custom_image_view.dart';
import 'package:readmore/readmore.dart';

//------Section Search List------------
//      OverView Section
//      Seller Information
//      Product Selaction
//      Additional Info
//      Product details
//      Expected Days of Delivery
//      Replacement  Policy
class MPProductdetailsScreen extends StatefulWidget {
  const MPProductdetailsScreen({Key? key}) : super(key: key);

  @override
  State<MPProductdetailsScreen> createState() => _MPProductStatedetailsScreen();
}

class _MPProductStatedetailsScreen extends State<MPProductdetailsScreen> {
  bool isSaved = false;
  bool isproductSaved = false;
  int? packing_info_selectedIndex;
  int? additional_variant__selectedIndex;
  int? size_selectedIndex;
  var userRating;
  double? rateStar = 5.0;
  int _number = 0;

  @override
  Widget build(BuildContext context) {
    var _height = MediaQuery.of(context).size.height;
    var _width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "PRODUCT",
          style: TextStyle(
            fontFamily: 'outfit',
            fontWeight: FontWeight.w600,
            fontSize: 20,
            color: Colors.black,
          ),
        ),
        leading: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Container(
            height: 40,
            width: 40,
            decoration: BoxDecoration(
                color: ColorConstant.primary_color,
                borderRadius: BorderRadius.all(
                  Radius.circular(5),
                ),
                border: Border.all(
                  color: ColorConstant.primary_color,
                )),
            child: Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      //--------------------------------------------------------------------Product Selaction---------------------------------------------------------------
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(left: 25.0, right: 25),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Text(
                  "Home/ Boxes/ Tuck in boxes/",
                  style: TextStyle(
                    fontFamily: 'outfit',
                    color: Colors.grey,
                  ),
                ),
                Text(
                  "4cm x 5cm Tuck in Box",
                  style: TextStyle(
                      fontFamily: 'outfit',
                      color: ColorConstant.primary_color,
                      fontSize: 15,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Paper Sheets",
                      style: TextStyle(
                          fontFamily: 'outfit',
                          fontSize: 20,
                          color: Colors.black,
                          fontWeight: FontWeight.w600),
                    ),
                    Row(
                      children: [
                        Text(
                          "₹990",
                          style: TextStyle(
                              fontFamily: 'outfit',
                              fontSize: 25,
                              color: ColorConstant.primary_color,
                              fontWeight: FontWeight.w600),
                        ),
                        Text(
                          "₹2400",
                          style: TextStyle(
                              fontFamily: 'outfit',
                              fontSize: 20,
                              decoration: TextDecoration.lineThrough,
                              color: Colors.grey,
                              fontWeight: FontWeight.w400),
                        ),
                      ],
                    ),
                  ],
                ),
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
                          height: 35,
                          child: CustomImageView(
                            svgPath: ImageConstant.mpsaveimage,
                          ),
                        )
                      : Container(
                          height: 35,
                          child: CustomImageView(
                            svgPath: ImageConstant.mpproductunsaveimage,
                          ),
                        ),
                )
              ],
            ),
            Row(
              children: [
                RatingBar.builder(
                  initialRating: userRating != null ? userRating : 5,
                  minRating: 1,
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  itemSize: 15,
                  itemCount: 5,
                  itemPadding: EdgeInsets.only(left: 1, right: 1),
                  itemBuilder: (context, _) => Icon(
                    Icons.star,
                    color: Color(0xFFFFC41F),
                  ),
                  onRatingUpdate: (rating) {
                    rateStar = rating;
                    print(rating);
                  },
                ),
                Text(
                  "4.6 / 5.0 (556)",
                  style: TextStyle(
                      fontFamily: 'outfit', fontWeight: FontWeight.w300),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      if (_number > 0) {
                        _number--;
                      }
                    });
                  },
                  child: Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    child: Center(
                        child: Icon(
                      Icons.remove,
                      color: Colors.grey,
                    )),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Container(
                  height: 40,
                  width: 80,
                  decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  child: Center(
                      child: Text(
                    "${_number}",
                    style: TextStyle(color: Colors.grey, fontSize: 18),
                  )),
                ),
                SizedBox(
                  width: 10,
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _number++;
                    });
                  },
                  child: Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    child: Center(
                        child: Icon(
                      Icons.add,
                      color: Colors.grey,
                    )),
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                Container(
                  height: 45,
                  width: _width / 3,
                  decoration: BoxDecoration(
                      color: ColorConstant.primary_color,
                      border: Border.all(color: ColorConstant.primary_color),
                      borderRadius: BorderRadius.all(Radius.circular(5))),
                  child: Card(
                    color: ColorConstant.primary_color,
                    child: Center(
                      child: Text(
                        "Add To Cart",
                        style: TextStyle(
                            fontFamily: 'outfit',
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              height: 80,
              decoration: BoxDecoration(
                color: ColorConstant.primaryLight_color,
              ),
              //------------------------------------------------------------------------------Seller Information------------------------------------------------------------
              child: Column(children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Seller Name",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontFamily: 'outfit',
                        ),
                      ),
                      Text(
                        "Min.Order",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontFamily: 'outfit',
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "InPacking",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontFamily: 'outfit',
                            fontWeight: FontWeight.w600),
                      ),
                      Text(
                        "100 pic",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontFamily: 'outfit',
                            fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ),
              ]),
            ),
            SizedBox(
              height: 20,
            ),

            //------------------------------------------------------------------------------OverView Section--------------------------------------------------------------
            Overviewlist(_width),
            SizedBox(
              height: 10,
            ),
            //------------------------------------------------------------------------------Product details----------------------------------------------------------------
            Container(
              // color: Colors.amber,
              child: Card(
                shadowColor: Colors.black,
                child: ExpansionTile(
                  expandedAlignment: Alignment.topLeft,
                  iconColor: Colors.black,
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Product Details",
                        style: TextStyle(
                            fontFamily: 'outfit',
                            fontSize: 18,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      ),
                      Divider(
                        color: ColorConstant.primary_color,
                        thickness: 2,
                        endIndent: 150,
                      )
                    ],
                  ),
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ReadMoreText(
                        'Est voluptate maxime quaerat rerum et Rerum similique ut doloremque aspernatur debitis ab nisiPorro et dolorum sequi',
                        trimLines: 2,
                        colorClickableText: ColorConstant.primary_color,
                        trimMode: TrimMode.Line,
                        trimCollapsedText: 'Read More',
                        trimExpandedText: ' Read Less',
                        style: TextStyle(
                            fontFamily: 'outfit',
                            fontSize: 13,
                            color: Colors.grey),
                        /* AppStyle.txtOutfitRegular13.copyWith(
                              fontSize: 14, color: ColorConstant.gray500), */
                        moreStyle: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: ColorConstant.primary_color),
                      ),
                    ),
                  ],
                ),
              ),
            ),
//-----------------------------------------------------------------------------Expected Days of Delivery------------------------------------------------

            Container(
              // color: Colors.amber,
              child: Card(
                shadowColor: Colors.black,
                child: ExpansionTile(
                  expandedAlignment: Alignment.topLeft,
                  iconColor: Colors.black,
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Expected Days of Delivery",
                        style: TextStyle(
                            fontFamily: 'outfit',
                            fontSize: 18,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      ),
                      Divider(
                        color: ColorConstant.primary_color,
                        thickness: 2,
                        endIndent: 60,
                      )
                    ],
                  ),
                  children: [
                    Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "5 days",
                          style: TextStyle(
                              fontFamily: 'outfit',
                              fontSize: 15,
                              color: Colors.grey,
                              fontWeight: FontWeight.w400),
                        )),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
//------------------------------------------------------------------------------Additional Info--------------------------------------------------------------------
            Container(
              // color: Colors.amber,
              child: Card(
                shadowColor: Colors.black,
                child: ExpansionTile(
                  expandedAlignment: Alignment.topLeft,
                  iconColor: Colors.black,
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Additional Info",
                        style: TextStyle(
                            fontFamily: 'outfit',
                            fontSize: 18,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      ),
                      Divider(
                        color: ColorConstant.primary_color,
                        thickness: 2,
                        endIndent: 160,
                      )
                    ],
                  ),
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Additionalinfolist(),
                    ),
                  ],
                ),
              ),
            ),
//----------------------------------------------------------------------------- Replacement  Policy Section--------------------------------------------------
            Container(
              // color: Colors.amber,
              child: Card(
                shadowColor: Colors.black,
                child: ExpansionTile(
                  expandedAlignment: Alignment.topLeft,
                  iconColor: Colors.black,
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Replacement  Policy",
                        style: TextStyle(
                            fontFamily: 'outfit',
                            fontSize: 18,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      ),
                      Divider(
                        color: ColorConstant.primary_color,
                        thickness: 2,
                        endIndent: 120,
                      )
                    ],
                  ),
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                    ),
                  ],
                ),
              ),
            ),

//-----------------------------------------------------------------------------Return Policy-----------------------------------------------------------------

            Container(
              // color: Colors.amber,
              child: Card(
                shadowColor: Colors.black,
                child: ExpansionTile(
                  expandedAlignment: Alignment.topLeft,
                  iconColor: Colors.black,
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Return Policy",
                        style: TextStyle(
                            fontFamily: 'outfit',
                            fontSize: 18,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      ),
                      Divider(
                        color: ColorConstant.primary_color,
                        thickness: 2,
                        endIndent: 170,
                      )
                    ],
                  ),
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                    ),
                  ],
                ),
              ),
            ),
//-----------------------------------------------------------------------------Related Products-----------------------------------------------------------------
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Related Products",
                  style: TextStyle(
                      fontFamily: 'outfit',
                      fontSize: 18,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  "View all",
                  style: TextStyle(
                      fontFamily: 'outfit',
                      fontSize: 15,
                      color: ColorConstant.primary_color,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
            ReletedProducts(_width, _height),
          ]),
        ),
//----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
      ),
    );
  }

  Additionalinfolist() {
    return Column(
      children: [
        ExcludeSemantics(
          child: ListView.builder(
            itemCount: 5,
            shrinkWrap: true,
            primary: true,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return Container(
                decoration: BoxDecoration(
                  border: Border(
                    top: index == 0
                        ? BorderSide(
                            color: Colors.grey[300]!,
                            width: 2.0,
                          )
                        : BorderSide.none,
                    bottom: BorderSide(
                      color: Colors.grey[300]!,
                      width: 2.0,
                    ),
                    left: BorderSide(
                      color: Colors.grey[300]!,
                      width: 2.0,
                    ),
                    right: BorderSide(
                      color: Colors.grey[300]!,
                      width: 2.0,
                    ),
                  ),
                ),
                child: Row(children: [
                  Expanded(
                    flex: 1,
                    child: Container(
                        padding: EdgeInsets.only(left: 5),
                        child: Text('Product')),
                  ),
                  Expanded(
                    flex: 2,
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      decoration: BoxDecoration(
                        border: Border(
                          left: BorderSide(
                            color: Colors.grey[300]!,
                            width: 1.0,
                          ),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 5),
                        child: Text(
                          '100 Screw',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                ]),
              );
            },
          ),
        ),
        SizedBox(
          height: 10,
        )
      ],
    );
  }

  Overviewlist(_width) {
    return Container(
      // color: Colors.amber,
      child: Card(
        shadowColor: Colors.black,
        child: ExpansionTile(
          iconColor: Colors.black,
          /* collapsedBackgroundColor: Colors.black,
                  collapsedIconColor: Colors.black,
                  backgroundColor: Colors.black,
                  collapsedTextColor: Colors.black,
                  expandedAlignment: Alignment.topLeft, */
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "OverView",
                style: TextStyle(
                    fontFamily: 'outfit',
                    fontSize: 18,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
              ),
              Divider(
                color: ColorConstant.primary_color,
                thickness: 2,
                endIndent: 190,
              )
            ],
          ),
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Size",
                    style: TextStyle(
                        fontFamily: 'outfit',
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                  Container(
                    height: 50,
                    width: _width,
                    child: ListView.builder(
                      itemCount: 2,
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    size_selectedIndex = index;
                                  });
                                },
                                child: Container(
                                  height: 40,
                                  width: 80,
                                  decoration: BoxDecoration(
                                      color: size_selectedIndex == index
                                          ? ColorConstant.primaryLight_color
                                          : Colors.grey.shade200,
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(5)),
                                      border: Border.all(
                                        color: size_selectedIndex == index
                                            ? ColorConstant.primary_color
                                            : Colors.grey,
                                      )),
                                  child: Center(
                                    child: Text(
                                      "A4",
                                      style: TextStyle(
                                          fontFamily: 'outfit',
                                          fontSize: 15,
                                          color: size_selectedIndex == index
                                              ? ColorConstant.primary_color
                                              : Colors.grey,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                  Text(
                    "Additional Variant",
                    style: TextStyle(
                        fontFamily: 'outfit',
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                  Container(
                    height: 50,
                    width: _width,
                    child: ListView.builder(
                      itemCount: 2,
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    additional_variant__selectedIndex = index;
                                  });
                                },
                                child: Container(
                                  height: 40,
                                  width: 100,
                                  decoration: BoxDecoration(
                                      color:
                                          additional_variant__selectedIndex ==
                                                  index
                                              ? ColorConstant.primaryLight_color
                                              : Colors.grey.shade200,
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(5)),
                                      border: Border.all(
                                        color:
                                            additional_variant__selectedIndex ==
                                                    index
                                                ? ColorConstant.primary_color
                                                : Colors.grey,
                                      )),
                                  child: Center(
                                    child: Text(
                                      "Square",
                                      style: TextStyle(
                                          fontFamily: 'outfit',
                                          fontSize: 15,
                                          color:
                                              additional_variant__selectedIndex ==
                                                      index
                                                  ? ColorConstant.primary_color
                                                  : Colors.grey,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                  Text(
                    "Package Info",
                    style: TextStyle(
                        fontFamily: 'outfit',
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                  Container(
                    height: 50,
                    width: _width,
                    child: ListView.builder(
                      itemCount: 2,
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    packing_info_selectedIndex = index;
                                  });
                                },
                                child: Container(
                                  height: 40,
                                  width: 80,
                                  decoration: BoxDecoration(
                                      color: packing_info_selectedIndex == index
                                          ? ColorConstant.primaryLight_color
                                          : Colors.grey.shade200,
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(5)),
                                      border: Border.all(
                                        color:
                                            packing_info_selectedIndex == index
                                                ? ColorConstant.primary_color
                                                : Colors.grey,
                                      )),
                                  child: Center(
                                    child: Text(
                                      "2 Box",
                                      style: TextStyle(
                                          fontFamily: 'outfit',
                                          fontSize: 15,
                                          color: packing_info_selectedIndex ==
                                                  index
                                              ? ColorConstant.primary_color
                                              : Colors.grey,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  ReletedProducts(_width, _height) {
    return Container(
      // color: Colors.amber,
      height: _height / 3,
      width: _width,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 4,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              width: 220,
              child: Card(
                elevation: 2,
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.only(left: 15.0, right: 15, top: 10),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            GestureDetector(
                              onTap: () {
                                if (isproductSaved) {
                                  setState(() {
                                    isproductSaved = false;
                                  });
                                } else {
                                  setState(() {
                                    isproductSaved = true;
                                  });
                                }
                              },
                              child: isproductSaved
                                  ? CustomImageView(
                                      svgPath: ImageConstant.mpsaveimage,
                                    )
                                  : CustomImageView(
                                      svgPath: ImageConstant.mpunsaveimage,
                                    ),
                            ),
                          ],
                        ),
                        Text(
                          "Category Name",
                          style: TextStyle(
                              fontFamily: 'outfit',
                              fontSize: 15,
                              color: Colors.grey,
                              fontWeight: FontWeight.w400),
                        ),
                        Text(
                          "Paper Sheets",
                          style: TextStyle(
                              fontFamily: 'outfit',
                              fontSize: 18,
                              color: Colors.black,
                              fontWeight: FontWeight.w500),
                        ),
                        Container(
                          width: _width,
                          // color: Colors.amber,
                          child: Text(
                            "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et ....",
                            style: TextStyle(
                                fontFamily: 'outfit',
                                fontSize: 15,
                                color: Colors.grey,
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                        Divider(
                          color: Colors.black,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "₹990",
                              style: TextStyle(
                                  fontFamily: 'outfit',
                                  fontSize: 20,
                                  color: ColorConstant.primary_color,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              "₹2400",
                              style: TextStyle(
                                  fontFamily: 'outfit',
                                  fontSize: 20,
                                  decoration: TextDecoration.lineThrough,
                                  color: Colors.grey,
                                  fontWeight: FontWeight.bold),
                            ),
                            Spacer(),
                            GestureDetector(
                              child: CustomImageView(
                                svgPath: ImageConstant.mpcartimage,
                              ),
                            )
                          ],
                        )
                      ]),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
