import 'package:flutter/material.dart';
import 'package:pds/core/utils/color_constant.dart';

class PlatformCharges extends StatefulWidget {
  String category;
  PlatformCharges({Key? key, required this.category}) : super(key: key);

  @override
  State<PlatformCharges> createState() => _PlatformChargesState();
}

class _PlatformChargesState extends State<PlatformCharges> {
  @override
  Widget build(BuildContext context) {
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
      body: Column(
        children: [
          Center(
            child: Column(
              children: [
                Text(
                  "Platform Charges Details & Payment",
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
          
          
        ],
      ),
    );
  }
}
