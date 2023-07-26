import 'package:flutter/material.dart';

import '../../core/utils/size_utils.dart';
import '../../theme/theme_helper.dart';

class CreateForamScreen extends StatefulWidget {
  const CreateForamScreen({Key? key}) : super(key: key);

  @override
  State<CreateForamScreen> createState() => _CreateForamScreenState();
}

class _CreateForamScreenState extends State<CreateForamScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: theme.colorScheme.onPrimary,
      appBar: AppBar(
        leading: Icon(
          Icons.arrow_back,
          color: Colors.black,
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: theme.colorScheme.onPrimary,
        title: Text(
          "Create Forum",
          style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black,
              fontFamily: "outfit",
              fontSize: 20),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            // mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                height: 20,
              ),
              Center(
                child: Container(
                  height: 50,
                  width: width / 1.2,
                  decoration: BoxDecoration(
                      color: Color(0XFFFFE7E7),
                      borderRadius: BorderRadius.circular(5)),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 15.0, left: 15),
                    child: Text(
                      "Company Details",
                      style: TextStyle(
                        fontFamily: 'outfit',
                        fontSize: 15,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10.0, left: 35, bottom: 5),
                child: Text(
                  "Company Name",
                  style: TextStyle(
                    fontFamily: 'outfit',
                    fontSize: 15,
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Center(
                child: Container(
                  height: 50,
                  width: width / 1.2,
                  decoration: BoxDecoration(
                      color: Color(0XFFF6F6F6),
                      borderRadius: BorderRadius.circular(5)),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      cursorColor: Colors.grey,
                      decoration: InputDecoration(
                        hintText: 'Enter name',
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10.0, left: 35, bottom: 5),
                child: Text(
                  "Job Profile",
                  style: TextStyle(
                    fontFamily: 'outfit',
                    fontSize: 15,
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Center(
                child: Container(
                  height: 50,
                  width: width / 1.2,
                  decoration: BoxDecoration(
                      color: Color(0XFFF6F6F6),
                      borderRadius: BorderRadius.circular(5)),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      cursorColor: Colors.grey,
                      decoration: InputDecoration(
                        hintText: 'Job Profile',
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10.0, left: 35, bottom: 5),
                child: Text(
                  "Document",
                  style: TextStyle(
                    fontFamily: 'outfit',
                    fontSize: 15,
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 35.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      height: 50,
                      width: width / 1.65,
                      decoration: BoxDecoration(
                          color: Color(0XFFF6F6F6),
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(5),
                              bottomLeft: Radius.circular(5))),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextField(
                          cursorColor: Colors.grey,
                          decoration: InputDecoration(
                            hintText: 'Upload File',
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        height: 50,
                        width: width / 4.5,
                        decoration: BoxDecoration(
                            color: Color(0XFF777777),
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(5),
                                bottomRight: Radius.circular(5))),
                        child: Center(
                          child: Text(
                            "Choose",
                            style: TextStyle(
                              fontFamily: 'outfit',
                              fontSize: 15,
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 35.0, right: 35.0, top: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Only JPG, PNG & PDF allowed",
                      style: TextStyle(
                        fontFamily: 'outfit',
                        fontSize: 15,
                        color: Colors.grey,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      "Max size 12MB",
                      style: TextStyle(
                        fontFamily: 'outfit',
                        fontSize: 15,
                        color: Colors.black.withOpacity(0.6),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Center(
                child: Container(
                  height: 50,
                  width: width / 1.2,
                  decoration: BoxDecoration(
                      color: Color(0XFFED1C25),
                      borderRadius: BorderRadius.circular(5)),
                  child: Center(
                    child: Text(
                      "Submit",
                      style: TextStyle(
                        fontFamily: 'outfit',
                        fontSize: 15,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "By submitting you are agreeing to",
                    style: TextStyle(
                      fontFamily: 'outfit',
                      fontSize: 15,
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: Text(
                      " Terms & Cinditions",
                      style: TextStyle(
                        fontFamily: 'outfit',
                        decoration: TextDecoration.underline,
                        fontSize: 15,
                        color: Color(0xFFED1C25),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
              Center(
                child: GestureDetector(
                  onTap: () {},
                  child: Text(
                    "Privacy & Policy of PDS Terms",
                    style: TextStyle(
                      fontFamily: 'outfit',
                      fontSize: 15,
                      decoration: TextDecoration.underline,
                      color: Color(0xFFED1C25),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ]),
      ),
    );
  }
}
