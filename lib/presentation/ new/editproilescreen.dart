import 'package:flutter/material.dart';
import 'package:pds/core/utils/color_constant.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({Key? key}) : super(key: key);

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController userNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController contactController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
        title: Column(
          children: [
            Text(
              "Edit Profile",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: "Approved",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: Color(0xff019801),
                    ),
                  )
                ],
                text: "Status:",
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: Colors.black),
              ),
            ),
          ],
        ),
        centerTitle: true,
      ),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.only(left: 36, right: 36),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10, bottom: 10),
                child: Text(
                  "Name",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                ),
              ),
              customTextFeild(
                controller: nameController,
                width: width / 1.1,
                hintText: "Enter Name",
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10, bottom: 10),
                child: Text(
                  "User Name",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                ),
              ),
              customTextFeild(
                controller: userNameController,
                width: width / 1.1,
                hintText: "Enter User Name",
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10, bottom: 10),
                child: Text(
                  "Email",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                ),
              ),
              customTextFeild(
                controller: emailController,
                width: width / 1.1,
                hintText: "Email Address",
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10, bottom: 10),
                child: Text(
                  "Contact no.",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                ),
              ),
              customTextFeild(
                controller: contactController,
                width: width / 1.1,
                hintText: "Contact no.",
              ),
              Padding(
                padding: const EdgeInsets.only(top: 40),
                child: Center(
                  child: Container(
                    height: 40,
                    width: 100,
                    decoration: BoxDecoration(
                        color: ColorConstant.primary_color,
                        borderRadius: BorderRadius.circular(10)),
                    child: Center(
                      child: Text(
                        "Save",
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 15,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  customTextFeild(
      {double? width, TextEditingController? controller, String? hintText}) {
    return Container(
      // height: 50,
      width: width,
      decoration: BoxDecoration(
          color: Color(0xffFFF3F4),
          border: Border.all(
            color: Color(0xffFFC8CA),
          ),
          borderRadius: BorderRadius.circular(5)),
      child: Padding(
        padding: EdgeInsets.only(left: 12),
        child: TextFormField(
          controller: controller,
          cursorColor: ColorConstant.primary_color,
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: TextStyle(color: Color(0xff565656)),
            border: InputBorder.none,
          ),
        ),
      ),
    );
  }
}
