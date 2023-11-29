
import 'package:flutter/material.dart';

Widget cameraPicture() {
  return Container(
    height: 55,
    width: 50,
    decoration: BoxDecoration(
      border: Border.all(color: Color(0xffFFFFFF), width: 4),
      shape: BoxShape.circle,
      color: Color(0xffFBD8D9),
    ),
    child: Icon(
      Icons.camera_alt_outlined,
      color: Colors.red,
    ),
  );
}

