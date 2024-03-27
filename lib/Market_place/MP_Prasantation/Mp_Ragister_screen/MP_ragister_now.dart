import 'package:flutter/material.dart';
import 'package:pds/Market_place/MP_Prasantation/choose_your_category_screen/choose_category_screen.dart';
import 'package:pds/Market_place/commenWiget.dart/commenFlushbar.dart';
import 'package:pds/Market_place/commenWiget.dart/commenPrfrence.dart';
import 'package:pds/widgets/custom_image_view.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/utils/color_constant.dart';
import '../../../../core/utils/image_constant.dart';

class ChooseCatgory extends StatefulWidget {
  const ChooseCatgory({Key? key}) : super(key: key);

  @override
  State<ChooseCatgory> createState() => _ChooseCatgoryState();
}

/*  */
class _ChooseCatgoryState extends State<ChooseCatgory> {
  final List<Map<String, dynamic>> _images = [
    {
      'name': 'Image 1',
      'image': ImageConstant.raw_material_marketplace,
      'value': 'Raw Material Marketplace',
      'isselected': false
    },
    {
      'name': 'Image 2',
      'image': ImageConstant.packageing_products,
      'value': 'Packaging Products And Services',
      'isselected': false
    },
    {
      'name': 'Image 3',
      'image': ImageConstant.rental_packaging,
      'value': 'Rental Reusable Packaging Product Marketplace',
      'isselected': false
    },
    {
      'name': 'Image 4',
      'image': ImageConstant.forum,
      'value': 'Knowledge Forum',
      'isselected': false
    },
    {
      'name': 'Image 5',
      'image': ImageConstant.plastic_waste,
      'value': 'Plastic Waste Processing',
      'isselected': false
    },
    {
      'name': 'Image 6',
      'image': ImageConstant.pride_lab,
      'value': 'PRIDE Lab',
      'isselected': false
    },
  ];

  byDefaultSetindex() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? getInitallData = prefs.getString(
        SharedPreferencesCommenEntity.navigationrouteChosseCatgorySelctedData);
    int index =
        _images.indexWhere((element) => element['value'] == getInitallData);
    print("i want to check  index-$index");
    print("i want to check $getInitallData ");

    if (index != -1) {
      _images[index]['isselected'] = true;
    } else {
      print('Image not found in the list.');
    }
    setState(() {});
  }

  @override
  void initState() {
    byDefaultSetindex();
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
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Center(
              child: Text(
                "What Offering You Are Looking For?",
                style: TextStyle(
                    fontFamily: 'outfit',
                    fontSize: 20,
                    fontWeight: FontWeight.w500),
              ),
            ),
            Divider(
              color: ColorConstant.primary_color,
              indent: 80,
              endIndent: 80,
              thickness: 1.5,
            ),
            GridView.builder(
              shrinkWrap: true,
              padding: EdgeInsets.all(20),
              physics: NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 15.0,
                mainAxisSpacing: 15.0,
              ),
              itemCount: _images.length,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: () {
                    _images[index]['isselected'] =
                        !_images[index]['isselected'];
                    if (_images[index]['isselected']) {
                      for (int i = 0; i < _images.length; i++) {
                        if (i != index) {
                          _images[i]['isselected'] = false;
                        }
                      }
                    }
                    setState(() {});
                  },
                  child: GridTile(
                    child: CustomImageView(
                      svgPath: _images[index]['image'],
                      fit: BoxFit.cover,
                    ),
                    header: _images[index]['isselected'] == true
                        ? GridTileBar(
                            leading: Checkbox(
                              checkColor: Colors.white,
                              activeColor: ColorConstant.primary_color,
                              side: BorderSide(color: Colors.black),
                              value: _images[index]['isselected'],
                              onChanged: (bool? value) {
                                setState(() {
                                  _images[index]['isselected'] =
                                      !_images[index]['isselected'];
                                });
                              },
                            ),
                          )
                        : SizedBox(),
                  ),
                );
              },
            ),
            SizedBox(
              height: _height / 22,
            ),
            GestureDetector(
              onTap: () async {
                if (_images.any((element) => element['isselected'] == true)) {
                  String storImageData = _images
                      .firstWhere(
                          (element) => element['isselected'] == true)['value']
                      .toString();
                  final SharedPreferences prefs =
                      await SharedPreferences.getInstance();
                  prefs.setBool(
                      SharedPreferencesCommenEntity
                          .navigationrouteChosseCatgory,
                      true);
                  print("check image data -${storImageData}");
                  prefs.setString(
                      SharedPreferencesCommenEntity
                          .navigationrouteChosseCatgorySelctedData,
                      storImageData);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          ChooseCategoryScreen(eninty: storImageData),
                    ),
                  );
                } else {
                  CustomFlushBarMarketPlace().flushBar(
                      text: 'You can Selcted At Lease One Options',
                      context: context,
                      duration: 2,
                      backgroundColor: ColorConstant.primary_color);
                }
                /*  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PaymentAndChargeScreen(),
                    )); */
              },
              child: Container(
                height: 40,
                width: _width / 1.2,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: ColorConstant.primary_color,
                ),
                child: Center(
                    child: Text(
                  "Register Now",
                  style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'outfit',
                      fontSize: 18,
                      fontWeight: FontWeight.w500),
                )),
              ),
            )
          ],
        ),
      ),
    );
  }
}
