// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class CommonButton extends StatelessWidget {
  final double height;
   double? width;
  EdgeInsetsGeometry? margin;
  EdgeInsetsGeometry? padding;
  final Color color;
  double? radius;
  Widget? child;
  final void Function() onTap;

  CommonButton({
    Key? key,
    required this.height,
     this.width,
    this.margin,
    this.padding,
    required this.color,
    this.radius,
    this.child,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: height,
        width: width,
        margin: margin,
        padding: padding,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(radius ?? 0.0),
        ),
        child: child,
      ),
    );
  }
}
