import 'package:flutter/material.dart';
import 'package:pds/API/Model/get_assigned_users_of_company_pageModel/get_assigned_users_of_company_pageModel.dart';
import 'package:pds/API/Repo/repository.dart';
import 'package:pds/core/utils/color_constant.dart';
import 'package:pds/core/utils/image_constant.dart';

class PageAdmin extends StatefulWidget {
  GetAssignedUsersOfCompanyPage getAssignedUsersOfCompanyPage;
  String? companyPageUid;
  PageAdmin(
      {Key? key,
      required this.getAssignedUsersOfCompanyPage,
      this.companyPageUid})
      : super(key: key);

  @override
  State<PageAdmin> createState() => _PageAdminState();
}

class _PageAdminState extends State<PageAdmin> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
          centerTitle: true,
          leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              Icons.arrow_back,
              color: Colors.grey,
            ),
          ),
          backgroundColor: Colors.white,
          title: Text(
            'Page Admin',
            style: TextStyle(
                fontFamily: 'outfit',
                fontWeight: FontWeight.bold,
                color: Colors.black),
          ),
        ),
        body: ListView.builder(
          itemCount: widget.getAssignedUsersOfCompanyPage.object?.length,
          padding: EdgeInsets.only(top: 10),
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListTile(
                leading: widget.getAssignedUsersOfCompanyPage.object?[index]
                            .userProfilePic !=
                        null
                    ? CircleAvatar(
                        backgroundImage: NetworkImage(
                            '${widget.getAssignedUsersOfCompanyPage.object?[index].userProfilePic}'),
                      )
                    : CircleAvatar(
                        backgroundImage: AssetImage(ImageConstant.tomcruse),
                      ),
                title: Text(
                  '${widget.getAssignedUsersOfCompanyPage.object?[index].userName}',
                  style: TextStyle(
                      fontFamily: 'outfit', fontWeight: FontWeight.w600),
                ),
                trailing: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: ColorConstant.primary_color,
                    ),
                    onPressed: () async {
                      print(
                          "check value -${widget.getAssignedUsersOfCompanyPage.object?[index].userUid}");
                      print("check value1 -${widget.companyPageUid}");
                      var jasonnString = await Repository()
                          .delete_assigned_user_from_company_page(
                              '${widget.getAssignedUsersOfCompanyPage.object?[index].userUid}',
                              '${widget.companyPageUid}',
                              context);
                      print("jasonString Checl -${jasonnString}");
                      if (jasonnString['object'] == 'Removed successfully') {
                        SnackBar snackBar = SnackBar(
                          content: Text(jasonnString['object']),
                          backgroundColor: ColorConstant.primary_color,
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        widget.getAssignedUsersOfCompanyPage.object
                            ?.removeAt(index);
                        setState(() {});
                      }else{
                          SnackBar snackBar = SnackBar(
                          content: Text(jasonnString['object']),
                          backgroundColor: ColorConstant.primary_color,
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      }
                    },
                    child: Text(
                      'Remove',
                      style: TextStyle(
                          fontFamily: 'outfit', fontWeight: FontWeight.bold),
                    )),
              ),
            );
          },
        ),
      ),
    );
  }
}
