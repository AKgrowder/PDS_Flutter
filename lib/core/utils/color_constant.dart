import 'dart:ui';
import 'package:flutter/material.dart';

class ColorConstant {
  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }

  static Color primary_color = fromHex('#ED1C25');
  static Color primaryLight_color = fromHex('#FBD8D9');
  static Color HasTagColor = fromHex('#1A9ED7');
  static Color ChatBackColor = fromHex('#FFB7B7');

  

  
}
