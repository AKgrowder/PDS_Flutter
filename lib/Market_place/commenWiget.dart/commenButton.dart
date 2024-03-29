import 'package:flutter/material.dart';
import 'package:pds/core/utils/color_constant.dart';

class CommonButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  final double height;
  final double width;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;
  final Color? color;
  const CommonButton({
    Key? key,
    required this.onPressed,
    required this.text,
    required this.height,
    required this.width,
    
    this.margin,
    this.padding,
    this.color

  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      margin: margin,
      padding: padding,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(10.0),
      ),
    );
  }
}
