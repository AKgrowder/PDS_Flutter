import 'package:flutter/material.dart';

import '../../core/utils/size_utils.dart';
import '../../theme/theme_helper.dart';

class HistoryDetailsScren extends StatefulWidget {
  const HistoryDetailsScren({Key? key}) : super(key: key);

  @override
  State<HistoryDetailsScren> createState() => _HistoryDetailsScrenState();
}

class _HistoryDetailsScrenState extends State<HistoryDetailsScren> {
  @override
  Widget build(BuildContext context) {
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
          "History",
          style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black,
              fontFamily: "outfit",
              fontSize: 20),
        ),  
      ),
      body: Column(children: [
        Padding(
          padding: const EdgeInsets.only(top: 30.0,right: 20,left: 20),
          child: Container(
            height: height / 6.5,
            width: width / 1.1,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
            ),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 10.0, left: 10, right: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "06/06/2023, 00:00",
                          style: TextStyle(
                            fontFamily: 'outfit',
                            fontSize: 15,
                            color: Colors.grey,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        Spacer(),
                        CircleAvatar(
                          backgroundColor: Colors.green,
                          maxRadius: 4,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          "Ongoing",
                          style: TextStyle(
                            fontFamily: 'outfit',
                            fontSize: 15,
                            color: Colors.black,
                            fontWeight: FontWeight.w400,
                          ),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: Text(
                      "Company Name",
                      style: TextStyle(
                        fontFamily: 'outfit',
                        fontSize: 15,
                        color: Colors.black,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: Text(
                      "Room Name",
                      style: TextStyle(
                        fontFamily: 'outfit',
                        fontSize: 15,
                        color: Colors.black,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: Text(
                      "Expert user ID",
                      style: TextStyle(
                        fontFamily: 'outfit',
                        fontSize: 20,
                        color: Colors.black,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: Text(
                      "Address specific packaging challenges....",
                      style: TextStyle(
                        fontFamily: 'outfit',
                        fontSize: 15,
                        color: Colors.black,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                   
                ]),
          ),
        ),
      ]),
    );
  }
}
