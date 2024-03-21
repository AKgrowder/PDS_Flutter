import 'package:flutter/material.dart';
import 'package:pds/API/Model/getall_compeny_page_model/getall_compeny_page.dart';
import 'package:pds/API/Repo/repository.dart';
import 'package:pds/core/utils/image_constant.dart';
import 'package:pds/widgets/custom_image_view.dart';

void showProfileSwitchBottomSheet(BuildContext context,
    GetAllCompenyPageModel getallcompenypagemodel, String loginUid) {
  double _bottomSheetHeight = 0;
  int? _selectedProfileIndex;
  if (getallcompenypagemodel.object?.content?.length == 1 ||
      getallcompenypagemodel.object?.content?.length == 2) {
    _bottomSheetHeight = MediaQuery.of(context).size.height * 0.18;
  } else if (getallcompenypagemodel.object?.content?.length == 3 ||
      getallcompenypagemodel.object?.content?.length == 4) {
    _bottomSheetHeight = MediaQuery.of(context).size.height * 0.25;
  } else if (getallcompenypagemodel.object?.content?.length == 6 ||
      getallcompenypagemodel.object?.content?.length == 5) {
    _bottomSheetHeight = MediaQuery.of(context).size.height * 0.6;
  } else {
    _bottomSheetHeight = MediaQuery.of(context).size.height * 0.7;
  }

  _selectedProfileIndex ??= getIndexOfInitiallySelected(getallcompenypagemodel);

  showModalBottomSheet(
    context: context,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(20.0),
        topRight: Radius.circular(20.0),
      ),
    ),
    builder: (BuildContext context) {
      return StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
          return Container(
            height: _bottomSheetHeight,
            child: ListView.builder(
              padding: EdgeInsets.only(top: 10),
              itemCount: getallcompenypagemodel.object?.content?.length,
              itemBuilder: (BuildContext context, int index) {
                final companyPage =
                    getallcompenypagemodel.object?.content?[index];
                final isSelected = _selectedProfileIndex == index;
                return Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: ListTile(
                    tileColor:
                        isSelected ? Colors.green.withOpacity(0.3) : null,
                    onTap: () {
                      if (isSelected &&
                          _selectedProfileIndex ==
                              getIndexOfInitiallySelected(
                                  getallcompenypagemodel)) {
                        return Navigator.pop(context);
                      } else {
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
                      }
                    },
                    leading:
                        companyPage?.companyPageProfilePic?.isEmpty == true ||
                                companyPage?.companyPageProfilePic == null
                            ? CustomImageView(
                                imagePath: ImageConstant.tomcruse,
                                height: 50,
                                radius: BorderRadius.circular(25),
                                width: 50,
                                fit: BoxFit.fill,
                              )
                            : GestureDetector(
                                child: CustomImageView(
                                  url: "${companyPage?.companyPageProfilePic}",
                                  height: 50,
                                  radius: BorderRadius.circular(25),
                                  width: 50,
                                  fit: BoxFit.fill,
                                ),
                              ),
                    title: Text(
                        '${companyPage?.companyPageName == null ? '${companyPage?.pageId}' : companyPage?.companyPageName}'),
                    trailing: isSelected
                        ? Image.asset(
                            ImageConstant.greenseen,
                            height: 20,
                          )
                        : null,
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

int getIndexOfInitiallySelected(GetAllCompenyPageModel model) {
  for (int i = 0; i < (model.object?.content?.length ?? 0); i++) {
    if (model.object!.content![i].isSwitched == true) {
      return i;
    }
  }

  return 0;
}
