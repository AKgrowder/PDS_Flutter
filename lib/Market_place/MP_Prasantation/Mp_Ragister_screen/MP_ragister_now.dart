import 'package:flutter/material.dart';
import 'package:pds/Market_place/MP_Prasantation/Charge_Payment_Screen/charge_payment_screen.dart';
import 'package:pds/widgets/custom_image_view.dart';

import '../../../../core/utils/color_constant.dart';
import '../../../../core/utils/image_constant.dart';

class MPRagisterNowScreen extends StatefulWidget {
  const MPRagisterNowScreen({Key? key}) : super(key: key);

  @override
  State<MPRagisterNowScreen> createState() => _MPRagisterNowScreenState();
}

class _MPRagisterNowScreenState extends State<MPRagisterNowScreen> {
  final List<Map<String, dynamic>> _images = [
    {
      'name': 'Image 1',
      'image': ImageConstant.raw_material_marketplace,
      'isselected': false
    },
    {
      'name': 'Image 2',
      'image': ImageConstant.packageing_products,
      'isselected': false
    },
    {
      'name': 'Image 3',
      'image': ImageConstant.rental_packaging,
      'isselected': false
    },
    {'name': 'Image 4', 'image': ImageConstant.forum, 'isselected': false},
    {
      'name': 'Image 5',
      'image': ImageConstant.plastic_waste,
      'isselected': false
    },
    {'name': 'Image 5', 'image': ImageConstant.pride_lab, 'isselected': false},
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
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              padding: EdgeInsets.all(20),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 15.0,
                mainAxisSpacing: 15.0,
              ),
              itemCount: _images.length,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: () {
                    // Do something when image is tapped
                    print('Image ${index + 1} tapped!');
                  },
                  child: GridTile(
                    child: CustomImageView(
                      svgPath: _images[index]['image'],
                      fit: BoxFit.cover,
                    ),
                    header: GridTileBar(
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
                    ),
                  ),
                );
              },
            ),
            SizedBox(
              height: _height / 22,
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PaymentAndChargeScreen(),
                    ));
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
