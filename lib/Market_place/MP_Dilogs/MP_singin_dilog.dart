import 'package:flutter/material.dart';
import 'package:pds/core/utils/color_constant.dart';
import 'package:pds/core/utils/image_constant.dart';

class CategoryChooseDilog extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => CategoryChooseDilogState();
}

class CategoryChooseDilogState extends State<CategoryChooseDilog>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> scaleAnimation;
  TextEditingController OTPController = TextEditingController();
  bool isPhonee = false;
  var Show_Password = true;
  var Show_Passwordd = true;

  TextEditingController newpasswordController = TextEditingController();
  TextEditingController conformpasswordController = TextEditingController();
  final List<Map<String, dynamic>> _images = [
    {
      'name': 'Image 1',
      'image': ImageConstant.homerowmaterial,
      'isselected': false
    },
    {
      'name': 'Image 2',
      'image': ImageConstant.homepackagingproduct,
      'isselected': false
    },
    {
      'name': 'Image 3',
      'image': ImageConstant.homerentalpacking,
      'isselected': false
    },
    {'name': 'Image 4', 'image': ImageConstant.homefourm, 'isselected': false},
    {
      'name': 'Image 5',
      'image': ImageConstant.homeplasticwaste,
      'isselected': false
    },
    {
      'name': 'Image 5',
      'image': ImageConstant.homepridelab,
      'isselected': false
    },
  ];
  @override
  void initState() {
    super.initState();

    controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 450));
    scaleAnimation =
        CurvedAnimation(parent: controller, curve: Curves.elasticInOut);

    controller.addListener(() {
      super.setState(() {});
    });

    controller.forward();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var _height = MediaQuery.of(context).size.height;
    var _width = MediaQuery.of(context).size.width;

    return Center(
      child: Material(
        color: Color.fromARGB(0, 255, 255, 255),
        child: ScaleTransition(
          scale: scaleAnimation,
          child: Container(
            height: 550,
            width: MediaQuery.of(context).size.width / 1.17,
            decoration: ShapeDecoration(
              color: Color.fromARGB(0, 0, 0, 0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
            ),
            child: Column(
              children: [
                Container(
                  height: 550,
                  width: MediaQuery.of(context).size.width / 1.17,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color: const Color.fromARGB(255, 255, 255, 255)),
                  child: GridView.builder(
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
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                _images[index]['isselected'] =
                                    !_images[index]['isselected'];
                              });
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  border: Border.all(
                                    color: _images[index]['isselected']
                                        ? ColorConstant.primary_color
                                        : Colors.transparent,
                                  ),
                                  borderRadius: BorderRadius.circular(8)),
                              // color: Colors.amber,
                              child: Image.asset(
                                _images[index]['image'],
                                fit: BoxFit.fitHeight,
                              ),
                            ),
                          ),
                          /* header: GridTileBar(
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
                          ), */
                        ),
                      );
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
