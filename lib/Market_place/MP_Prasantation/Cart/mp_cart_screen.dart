import 'package:flutter/material.dart';
import 'package:pds/core/utils/color_constant.dart';

class MpcartScreen extends StatefulWidget {
  const MpcartScreen({Key? key}) : super(key: key);

  @override
  State<MpcartScreen> createState() => _MpcartScreenState();
}

String _selectedItem = 'Pendding';

class _MpcartScreenState extends State<MpcartScreen> {
  @override
  Widget build(BuildContext context) {
    var _height = MediaQuery.of(context).size.height;
    var _width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          flexibleSpace: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: 5,
              ),
              Icon(
                Icons.arrow_back,
                color: Colors.black,
              ),
              SizedBox(
                width: 20,
              ),
              Text(
                "Cart",
                style: TextStyle(
                  fontFamily: 'outfit',
                  fontWeight: FontWeight.w400,
                  fontSize: 20,
                  color: Colors.black,
                ),
              ),
              Spacer(),
              Padding(
                padding: const EdgeInsets.only(top: 0, left: 5, right: 5),
                child: Container(
                  width: _width / 2.4,
                  decoration: BoxDecoration(
                      border: Border.all(color: ColorConstant.primary_color),
                      borderRadius: BorderRadius.circular(5)),
                  child: DropdownButtonFormField<String>(
                    decoration: InputDecoration(
                        border:
                            UnderlineInputBorder(borderSide: BorderSide.none)),
                    value: _selectedItem,
                    icon: Container(
                      height: 50,
                      // color: Colors.amber,
                      child: Center(
                        child: Icon(
                          Icons.keyboard_arrow_down,
                          color: ColorConstant.primary_color,
                          size: 25,
                        ),
                      ),
                    ),
                    style: TextStyle(color: ColorConstant.primary_color),
                    onChanged: (String? newValue) {
                      setState(() {
                        _selectedItem = newValue!;
                      });
                    },
                    items: <String>[
                      'Pendding',
                      'Partially Accepted',
                      'Payment Awaited',
                      'Ready To Dispatch'
                    ].map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10.0),
                          child: Text(
                            value,
                            style: TextStyle(
                              fontFamily: 'outfit',
                              fontWeight: FontWeight.w600,
                              fontSize: 15,
                              color: ColorConstant.primary_color,
                            ),
                          ),
                        ),
                      );
                    }).toList(growable: true),
                  ),
                ),
              ),
            ],
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
      body: Column(children: []),),
    );
  }
}
