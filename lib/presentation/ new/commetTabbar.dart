import 'package:flutter/material.dart';
import 'package:pds/core/utils/image_constant.dart';

class MyWidget extends StatefulWidget {
  String selctedValue;
  String selctedValue1;
  String selctedValue2;
  MyWidget(
      {required this.selctedValue,
      required this.selctedValue1,
      required this.selctedValue2});

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  @override
  Widget build(BuildContext context) {
    var _height = MediaQuery.of(context).size.height;
    var _width = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, top: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 150,
                height: 25,
                decoration: ShapeDecoration(
                  color: Color(0xFFFBD8D9),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100),
                  ),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    // Step 3.
                    value: widget.selctedValue,
                    // Step 4.
                    items: <String>['Newest to oldest', '1', '2', '3', '4']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Padding(
                          padding: EdgeInsets.only(left: 10),
                          child: Text(
                            value,
                            style: TextStyle(
                              color: Color(0xFFF58E92),
                              fontSize: 14,
                              fontFamily: 'outfit',
                              fontWeight: FontWeight.w400,
                              height: 0,
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                    // Step 5.
                    onChanged: (String? newValue) {
                      setState(() {
                        widget.selctedValue = newValue!;
                      });
                    },
                  ),
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Container(
                width: 110,
                height: 25,
                decoration: ShapeDecoration(
                  color: Color(0xFFFBD8D9),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100),
                  ),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    // Step 3.
                    value: widget.selctedValue1,
                    // Step 4.
                    items: <String>['All Date', '1', '2', '3', '4']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Padding(
                          padding: EdgeInsets.only(left: 12),
                          child: Text(
                            value,
                            style: TextStyle(
                              color: Color(0xFFF58E92),
                              fontSize: 14,
                              fontFamily: 'outfit',
                              fontWeight: FontWeight.w400,
                              height: 0,
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                    // Step 5.
                    onChanged: (String? newValue) {
                      setState(() {
                        widget.selctedValue1 = newValue!;
                      });
                    },
                  ),
                ),
              ),
              SizedBox(
                width: 5,
              ),
              Container(
                width: 100,
                height: 25,
                decoration: ShapeDecoration(
                  color: Color(0xFFFBD8D9),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100),
                  ),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    // Step 3.
                    value: widget.selctedValue2,
                    // Step 4.
                    items: <String>['All Users', '1', '2', '3', '4']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Padding(
                          padding: EdgeInsets.only(left: 12),
                          child: Text(
                            value,
                            style: TextStyle(
                              color: Color(0xFFF58E92),
                              fontSize: 14,
                              fontFamily: 'outfit',
                              fontWeight: FontWeight.w400,
                              height: 0,
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                    // Step 5.
                    onChanged: (String? newValue) {
                      setState(() {
                        widget.selctedValue = newValue!;
                      });
                    },
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Expanded(
            child: ListView.builder(
               physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return Container(
                  margin: EdgeInsets.all(10),
                  height: 299,
                  decoration: ShapeDecoration(
                    shape: RoundedRectangleBorder(
                      side: BorderSide(width: 1, color: Color(0xFFD3D3D3)),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  width: _width,
                  child: Column(
                    children: [
                      Expanded(
                        child: Container(
                            // color: Colors.amber,
                            child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 50,
                              height: 50,
                              margin: EdgeInsets.only(left: 5, top: 10),
                              decoration: ShapeDecoration(
                                image: DecorationImage(
                                  image: AssetImage(ImageConstant.placeholder2),
                                  fit: BoxFit.fill,
                                ),
                                shape: OvalBorder(),
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 15,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 10),
                                  child: Text(
                                    'Kriston Watshon',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontFamily: 'outfit',
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                    margin: EdgeInsets.only(left: 10),
                                    width: _width / 1.9,
                                    // color: Colors.red,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Lorem ipsum dolor sit amet, dolor consectetur adip.',
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 14,
                                            fontFamily: 'outfit',
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                        Text('....'),
                                        Text(
                                          '1w',
                                          style: TextStyle(
                                            color: Color(0xFF8F8F8F),
                                            fontSize: 12,
                                            fontFamily: 'outfit',
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                        Container(
                                          height: _height / 4.57,
                                          width: _width,
                                          // color: Colors.amber,
                                          child: Column(
                                            children: [
                                              Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Container(
                                                    width: 45,
                                                    height: 45,
                                                    margin: EdgeInsets.only(
                                                        top: 15),
                                                    decoration: ShapeDecoration(
                                                      image: DecorationImage(
                                                        image: AssetImage(
                                                            ImageConstant
                                                                .placeholder2),
                                                        fit: BoxFit.fill,
                                                      ),
                                                      shape: OvalBorder(),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 8,
                                                            top: 5,
                                                            right: 3),
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        SizedBox(
                                                          height: 10,
                                                        ),
                                                        Text(
                                                          'Kriston Watshon',
                                                          style: TextStyle(
                                                            color: Colors.black,
                                                            fontSize: 16,
                                                            fontFamily:
                                                                "outfit",
                                                            fontWeight:
                                                                FontWeight.w600,
                                                          ),
                                                        ),
                                                        Container(
                                                          width: 160,
                                                          child: Text(
                                                            'Lorem ipsum dolor sit..',
                                                            maxLines: 1,
                                                            style: TextStyle(
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                              color:
                                                                  Colors.black,
                                                              fontSize: 16,
                                                              fontFamily:
                                                                  "outfit",
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                            ),
                                                          ),
                                                        ),
                                                        Text(
                                                          '1w',
                                                          style: TextStyle(
                                                            color: Color(
                                                                0xFF8F8F8F),
                                                            fontSize: 12,
                                                            fontFamily:
                                                                "outfit",
                                                            fontWeight:
                                                                FontWeight.w400,
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  )
                                                ],
                                              ),
                                              Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Container(
                                                    width: 45,
                                                    height: 45,
                                                    margin: EdgeInsets.only(
                                                        top: 15),
                                                    decoration: ShapeDecoration(
                                                      image: DecorationImage(
                                                        image: AssetImage(
                                                            ImageConstant
                                                                .placeholder2),
                                                        fit: BoxFit.fill,
                                                      ),
                                                      shape: OvalBorder(),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 8,
                                                            top: 5,
                                                            right: 3),
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        SizedBox(
                                                          height: 10,
                                                        ),
                                                        Text(
                                                          'Kriston Watshon',
                                                          style: TextStyle(
                                                            color: Colors.black,
                                                            fontSize: 16,
                                                            fontFamily:
                                                                "outfit",
                                                            fontWeight:
                                                                FontWeight.w600,
                                                          ),
                                                        ),
                                                        Container(
                                                          height: 50,
                                                          width: 160,
                                                          child: Text(
                                                            'Lorem ipsum dolor sit amet, dolor consectetur adip.',
                                                            maxLines: 2,
                                                            style: TextStyle(
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                              color:
                                                                  Colors.black,
                                                              fontSize: 16,
                                                              fontFamily:
                                                                  "outfit",
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                            ),
                                                          ),
                                                        ),
                                                        Text(
                                                          '1w',
                                                          style: TextStyle(
                                                            color: Color(
                                                                0xFF8F8F8F),
                                                            fontSize: 12,
                                                            fontFamily:
                                                                "outfit",
                                                            fontWeight:
                                                                FontWeight.w400,
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ],
                                          ),
                                          // color: Colors.amber,
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              width: 60,
                              height: 60,
                              margin: EdgeInsets.only(left: 10, top: 5),
                              decoration: ShapeDecoration(
                                image: DecorationImage(
                                  image: AssetImage(ImageConstant.design),
                                  fit: BoxFit.cover,
                                ),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(4)),
                              ),
                            ),
                          ],
                        )),
                      ),
                    ],
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
