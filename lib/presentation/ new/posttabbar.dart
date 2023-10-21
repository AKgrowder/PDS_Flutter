import 'package:flutter/material.dart';

class PostTabbarView extends StatelessWidget {
  List image;
  PostTabbarView({required this.image});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 10, right: 10),
      child: GridView.builder(
        physics: NeverScrollableScrollPhysics(),
        padding: EdgeInsets.zero,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, // Number of columns
          mainAxisSpacing: 0.0, // Vertical spacing between items
          crossAxisSpacing: 20, // Horizontal spacing between items
        ),
        itemCount: image.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.only(bottom: 10, top: 10),
            child: GridItem(imagePath: image[index]),
          );
        },
      ),
    );
  }
}

class GridItem extends StatelessWidget {
  final String imagePath;

  GridItem({required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12.0),
      child: Container(
        margin: EdgeInsets.all(0.0),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20)), // Remove margin
        child: Image.asset(
          imagePath,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
