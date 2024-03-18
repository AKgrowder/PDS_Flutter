import 'package:flutter/material.dart';
import 'package:pds/API/Model/getall_compeny_page_model/getall_compeny_page.dart';
import 'package:pds/API/Repo/repository.dart';
import 'package:pds/core/utils/image_constant.dart';
import 'package:pds/widgets/custom_image_view.dart';

int _selectedProfileIndex = 0;

void showProfileSwitchBottomSheet(
    BuildContext context, GetAllCompenyPageModel getallcompenypagemodel) {
  double _bottomSheetHeight = 0;

  // Determine the height based on the length of the list
  if (getallcompenypagemodel.object!.length == 0 ||
      getallcompenypagemodel.object!.length == 1 ||
      getallcompenypagemodel.object!.length == 2 ||
      getallcompenypagemodel.object!.length == 3 ||
      getallcompenypagemodel.object!.length == 4) {
    _bottomSheetHeight =
        MediaQuery.of(context).size.height * 0.33; // 30% of screen height
  } else if (getallcompenypagemodel.object!.length == 6 ||
      getallcompenypagemodel.object!.length == 5) {
    _bottomSheetHeight =
        MediaQuery.of(context).size.height * 0.6; // 60% of screen height
  } else {
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
              itemCount: getallcompenypagemodel.object?.length,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: ListTile(
                    onTap: () {
                      print(
                          "check Value-${getallcompenypagemodel.object?[index].pageUid}");
                      print(
                          "check value1-${getallcompenypagemodel.object?[index].pageId}");

                      setState(() {
                        _selectedProfileIndex = index;
                      });
                      Repository().get_page_by_uid(
                          context,
                          '${getallcompenypagemodel.object?[index].pageUid}',
                          '${getallcompenypagemodel.object?[index].pageId}');
                    },
                    leading:
                        getallcompenypagemodel.object?[index].profilePic == null
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
                                      "${getallcompenypagemodel.object?[index].profilePic}",
                                  height: 50,
                                  radius: BorderRadius.circular(25),
                                  width: 50,
                                  fit: BoxFit.fill,
                                ),
                              ),
                    title: Text(
                        '${getallcompenypagemodel.object?[index].companyName}'),
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
