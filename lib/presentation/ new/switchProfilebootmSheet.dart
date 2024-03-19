import 'package:flutter/material.dart';
import 'package:pds/API/Model/getall_compeny_page_model/getall_compeny_page.dart';
import 'package:pds/API/Repo/repository.dart';
import 'package:pds/core/utils/image_constant.dart';
import 'package:pds/widgets/custom_image_view.dart';

void showProfileSwitchBottomSheet(BuildContext context,
    GetAllCompenyPageModel getallcompenypagemodel, String loginUid) {
  double _bottomSheetHeight = 0;
  int? _selectedProfileIndex;

  // Determine the height based on the length of the list
  if (getallcompenypagemodel.object?.content?.length == 1 ||
      getallcompenypagemodel.object?.content?.length == 2) {
    _bottomSheetHeight = MediaQuery.of(context).size.height * 0.20;
  } else if (getallcompenypagemodel.object?.content?.length == 3 ||
      getallcompenypagemodel.object?.content?.length == 4) {
    print("this is the if codison");
    _bottomSheetHeight = MediaQuery.of(context).size.height * 0.33;
  } else if (getallcompenypagemodel.object?.content?.length == 6 ||
      getallcompenypagemodel.object?.content?.length == 5) {
    print("else this is the if codison");
    _bottomSheetHeight =
        MediaQuery.of(context).size.height * 0.6; // 60% of screen height
  } else {
    print("else else");
    _bottomSheetHeight = MediaQuery.of(context).size.height *
        0.7; // Default: 70% of screen height
  }
  showModalBottomSheet(
    context: context,
    builder: (BuildContext context) {
      return StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
          return Container(
            height: _bottomSheetHeight,
            child: ListView.builder(
              padding: EdgeInsets.only(top: 10),
              itemCount: getallcompenypagemodel.object?.content?.length,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: ListTile(
                    onTap: () {
                      print(
                          "check Value-${getallcompenypagemodel.object?.content?[index].userCompanyPageUid}");
                      print(
                          "check value1-${getallcompenypagemodel.object?.content?[index].pageId}");

                      setState(() {
                        _selectedProfileIndex = index;
                      });
                      if (getallcompenypagemodel
                              .object?.content?[index].companyPageName ==
                          null) {
                        var json = Repository().get_page_by_uid(
                          context,
                          null,
                          loginUid,
                          '${getallcompenypagemodel.object?.content?[index].userCompanyPageUid}',
                        );
                      } else {
                        var json = Repository().get_page_by_uid(
                          context,
                          '${getallcompenypagemodel.object?.content?[index].pageId}',
                          loginUid,
                          '${getallcompenypagemodel.object?.content?[index].userCompanyPageUid}',
                        );
                      }
                    },
                    leading: getallcompenypagemodel.object?.content?[index]
                                .companyPageProfilePic ==
                            null
                        ? CustomImageView(
                            imagePath: ImageConstant.tomcruse,
                            height: 50,
                            radius: BorderRadius.circular(25),
                            width: 50,
                            fit: BoxFit.fill,
                          )
                        : GestureDetector(
                            child: CustomImageView(
                              url:
                                  "${getallcompenypagemodel.object?.content?[index].companyPageProfilePic}",
                              height: 50,
                              radius: BorderRadius.circular(25),
                              width: 50,
                              fit: BoxFit.fill,
                            ),
                          ),
                    title: Text(
                        '${getallcompenypagemodel.object?.content?[index].companyPageName == null ? '${getallcompenypagemodel.object?.content?[index].pageId}' : getallcompenypagemodel.object?.content?[index].companyPageName}'),
                    trailing: _selectedProfileIndex == index
                        ? Image.asset(
                            ImageConstant.greenseen,
                            height: 20,
                          )
                        : null,
                    /* trailing: Radio(
                      value: index,
                      groupValue: _selectedProfileIndex,
                      onChanged: (int? value) {
                        setState(() {
                          _selectedProfileIndex = value!;
                        });
                      },
                    ), */
                  ),
                );
              },
            ),
          );
        },
      );
    },
  );
}
