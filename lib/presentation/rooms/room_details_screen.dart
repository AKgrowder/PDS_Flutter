import 'package:flutter/material.dart';

import '../../theme/theme_helper.dart';

class RoomDetailScreen extends StatefulWidget {
  const RoomDetailScreen({Key? key}) : super(key: key);

  @override
  State<RoomDetailScreen> createState() => _RoomDetailScreenState();
}

class _RoomDetailScreenState extends State<RoomDetailScreen> {
  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    double _height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: theme.colorScheme.onPrimary,
      appBar: AppBar(
        backgroundColor: theme.colorScheme.onPrimary,
        centerTitle: true,
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
        title: Text(
          "Rooms Details",
          style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black,
              fontFamily: "outfit",
              fontSize: 20),
        ),
      ),
      body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Center(
          child: Container( 
            height: _height / 9,
            width: _width / 1.2,
            decoration: BoxDecoration(
              color: Color(0xFFFFE7E7),
              borderRadius: BorderRadius.circular(10),
            ),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "06/06/2023",
                  style: TextStyle(
                      fontWeight: FontWeight.w400,
                      color: Colors.grey,
                      fontFamily: "outfit",
                      fontSize: 13),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Room Name",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontFamily: "outfit",
                      fontSize: 15),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0, top: 0),
                child: Text(
                  "address specific packaging challenges....  ",
                  style: TextStyle(
                      fontWeight: FontWeight.w400,
                      color: Colors.black,
                      fontFamily: "outfit",
                      fontSize: 13),
                ),
              ),
            ]),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 36.0, top: 20),
          child: Text(
            "Company Name",
            style: TextStyle(
                fontWeight: FontWeight.w600,
                color: Colors.black,
                fontFamily: "outfit",
                fontSize: 15),
          ),
        ),
        SizedBox(
          height: 5,
        ),
        Center(
          child: Container(
            height: 50,
            width: _width / 1.2,
            decoration: BoxDecoration(
                color: Color(0xFFF6F6F6),
                borderRadius: BorderRadius.circular(10)),
            child: Padding(
              padding: const EdgeInsets.only(top: 15.0, left: 10),
              child: Text(
                "Company Name",
                style: TextStyle(
                    fontWeight: FontWeight.w400,
                    color: Colors.grey.shade700,
                    fontFamily: "outfit",
                    fontSize: 15),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 36.0, top: 20),
          child: Text(
            "Rooms Name",
            style: TextStyle(
                fontWeight: FontWeight.w600,
                color: Colors.black,
                fontFamily: "outfit",
                fontSize: 15),
          ),
        ),
        SizedBox(
          height: 5,
        ),
        Center(
          child: Container(
            height: 50,
            width: _width / 1.2,
            decoration: BoxDecoration(
                color: Color(0xFFF6F6F6),
                borderRadius: BorderRadius.circular(10)),
            child: Padding(
              padding: const EdgeInsets.only(top: 15.0, left: 10),
              child: Text(
                "Rooms Name",
                style: TextStyle(
                    fontWeight: FontWeight.w400,
                    color: Colors.grey.shade700,
                    fontFamily: "outfit",
                    fontSize: 15),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 36.0, top: 20),
          child: Text(
            "Rooms Description",
            style: TextStyle(
                fontWeight: FontWeight.w600,
                color: Colors.black,
                fontFamily: "outfit",
                fontSize: 15),
          ),
        ),
        SizedBox(
          height: 5,
        ),
        Center(
          child: Container(
            height: 150,
            width: _width / 1.2,
            decoration: BoxDecoration(
                color: Color(0xFFF6F6F6),
                borderRadius: BorderRadius.circular(10)),
            child: Padding(
              padding: const EdgeInsets.only(top: 15.0, left: 10),
              child: Text(
                "Description",
                style: TextStyle(
                    fontWeight: FontWeight.w400,
                    color: Colors.grey.shade700,
                    fontFamily: "outfit",
                    fontSize: 15),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 36.0, top: 20),
          child: Text(
            "Document",
            style: TextStyle(
                fontWeight: FontWeight.w600,
                color: Colors.black,
                fontFamily: "outfit",
                fontSize: 15),
          ),
        ),
        SizedBox(
          height: 5,
        ),
        Center(
          child: Container(
            height: 50,
            width: _width / 1.2,
            decoration: BoxDecoration(
                color: Color(0xFFF6F6F6),
                borderRadius: BorderRadius.circular(10)),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Text(
                    "xxx.jpg",
                    style: TextStyle(
                        fontWeight: FontWeight.w400,
                        color: Colors.grey.shade700,
                        fontFamily: "outfit",
                        fontSize: 15),
                  ),
                ),
                Spacer(),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(
                    Icons.download,
                    color: Colors.black.withOpacity(0.5),
                  ),
                )
              ],
            ),
          ),
        ),
      ]),
    );
  }
}
