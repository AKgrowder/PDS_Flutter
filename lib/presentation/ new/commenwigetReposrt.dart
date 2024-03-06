import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_observer/Observable.dart';
import 'package:pds/API/Repo/repository.dart';
import 'package:pds/core/utils/color_constant.dart';
import 'package:pds/presentation/%20new/newbottembar.dart';

List<ReportOption> reportOptions = [];

_showBottomSheet(
  int index,
  String screen,
  BuildContext context,
  String postuid,
) {
  double screenHeight = MediaQuery.of(context).size.height;
  double bottomSheetHeight = screenHeight * 0.75;
  TextEditingController otherTextData = TextEditingController();
  bool showOtherTextField = false;
  String? selcted;
  String? selcted1;
  
  otherTextData.clear();
  reportOptions.forEach((option) {
    option.selected = false;
  });
  showModalBottomSheet(
    isScrollControlled: true,
    context: context,
    builder: (BuildContext ctx) {
      return StatefulBuilder(
        builder: (BuildContext ctx, StateSetter setState) {
          return GestureDetector(
            onTap: () {
              FocusScope.of(ctx)
                  .unfocus(); // Dismiss keyboard when tapping outside text field
            },
            child: Padding(
              padding:
                  EdgeInsets.only(bottom: MediaQuery.of(ctx).viewInsets.bottom),
              child: Container(
                height: bottomSheetHeight,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.all(20.0),
                      child: Text(
                        'Select Report Reason:',
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemCount: reportOptions.length,
                        itemBuilder: (context, index) {
                          return CheckboxListTile(
                            activeColor: ColorConstant.primary_color,
                            title: Text(reportOptions[index].properString),
                            value: reportOptions[index].selected,
                            onChanged: (value) {
                              setState(() {
                                for (int i = 0; i < reportOptions.length; i++) {
                                  reportOptions[i].selected =
                                      ((i == index) ? value : false)!;

                                  if (reportOptions[index].properString ==
                                      'Others') {
                                    showOtherTextField = value ?? false;
                                  } else {
                                    showOtherTextField = false;
                                  }
                                }
                              });
                            },
                          );
                        },
                      ),
                    ),
                    SizedBox(height: 20),
                    if (showOtherTextField)
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: TextField(
                          maxLines: null,
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(250),
                            FilteringTextInputFormatter.deny(RegExp(r'^\s+')),
                          ],
                          controller: otherTextData,
                          decoration: InputDecoration(
                            hintText: 'Other',
                            border: OutlineInputBorder(),
                          ),
                          onChanged: (value) {
                            // Handle text field changes
                          },
                        ),
                      ),
                    SizedBox(height: 20),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor: MaterialStatePropertyAll(
                                ColorConstant.primary_color)),
                        onPressed: () async {
                          print(
                              "dffsdfd-${reportOptions.any((element) => element.selected) == true}");
                          for (int i = 0; i < reportOptions.length; i++) {
                            if (reportOptions[i].selected == true) {
                              selcted = reportOptions[i].properString;
                              selcted1 = reportOptions[i].label;
                              print(
                                  "otherTextData.text.length-${otherTextData.text.length}");
                              print("onlu one -$selcted");
                              print("onlu one1 -$selcted1");
                            }
                          }
                          if (reportOptions
                                      .any((element) => element.selected) ==
                                  true &&
                              selcted == 'Others') {
                            if (otherTextData.text.isEmpty) {
                              CustomFlushBar().flushBar(
                                  text: 'Report Reason can\'t be blank',
                                  context: context,
                                  duration: 2,
                                  backgroundColor: ColorConstant.primary_color);
                            } else if ((otherTextData.text.length ?? 0) > 250) {
                              CustomFlushBar().flushBar(
                                  text: 'Max characters length 250 allowed',
                                  context: context,
                                  duration: 2,
                                  backgroundColor: ColorConstant.primary_color);
                            } else {
                              Map<String, dynamic> parems = {
                                'postUid': postuid,
                                'reportType': 'OTHERS',
                                "othersDescription": otherTextData.text,
                              };
                              dynamic meesage = await Repository()
                                  .report_post(context, parems);
                              SnackBar snackBar = SnackBar(
                                content: Text(meesage.object),
                                backgroundColor: ColorConstant.primary_color,
                              );
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                              dynamic data = {
                                'index': index,
                              };
                              Observable.instance
                                  .notifyObservers([screen], map: data);

                              if (screen == '_OpenSavePostImageState') {
                                Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          NewBottomBar(buttomIndex: 0),
                                    ),
                                    (route) => false);
                              } else {
                                Navigator.pop(context);
                              }
                            }
                          } else if (reportOptions
                                  .any((element) => element.selected) ==
                              false) {
                            CustomFlushBar().flushBar(
                                text: 'Please Select Reason',
                                context: ctx,
                                duration: 2,
                                backgroundColor: ColorConstant.primary_color);
                          } else {
                            Map<String, dynamic> parems = {
                              'postUid': postuid,
                              'reportType': selcted1
                            };
                            dynamic meesage =
                                await Repository().report_post(context, parems);
                            SnackBar snackBar = SnackBar(
                              content: Text(meesage.object),
                              backgroundColor: ColorConstant.primary_color,
                            );
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                            dynamic data = {
                              'index': index,
                            };
                            print("rthis is the Data Get-${screen}");
                            Observable.instance
                                .notifyObservers([screen], map: data);
                            if (screen == '_OpenSavePostImageState') {
                              Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        NewBottomBar(buttomIndex: 0),
                                  ),
                                  (route) => false);
                            } else {
                              Navigator.pop(context);
                            }
                          }
                        },
                        child: Text('Submit'),
                      ),
                    ),
                    SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          );
        },
      );
    },
  );
}

class ReportOption {
  final String label;
  final String properString;
  bool selected;

  ReportOption({
    required this.label,
    required this.properString,
    this.selected = false,
  });
}

class CustomFlushBar {
  void flushBar(
      {required int duration,
      required String text,
      required BuildContext context,
      required Color backgroundColor}) async {
    await dismiss();
    Flushbar(
      margin: EdgeInsets.all(8),
      borderRadius: BorderRadius.circular(8),
      backgroundColor: backgroundColor,
      flushbarStyle: FlushbarStyle.FLOATING,
      message: text,
      duration: Duration(seconds: duration ?? 3),
    )..show(context);
  }

  Future<void> dismiss() async {
    if (!Flushbar().isDismissed()) {
      await Flushbar().dismiss();
    }
  }
}

showPopupMenu1(
    BuildContext context, int index, buttonKey, postuid, String screen) async {
  print("this screen-$screen");
  final RenderBox button =
      buttonKey.currentContext!.findRenderObject() as RenderBox;
  final RenderBox overlay =
      Overlay.of(context).context.findRenderObject() as RenderBox;
  final double top = button.localToGlobal(Offset.zero, ancestor: overlay).dy;
  final double left = button.localToGlobal(Offset.zero, ancestor: overlay).dx;
  final double padding = 8.0; // Adjust the padding value as needed

  final RelativeRect position = RelativeRect.fromLTRB(
    left, // left
    top + button.size.height, // top
    left + button.size.width + padding, // right
    top + button.size.height, // bottom
  );
  showMenu(
      context: context,
      position: position,
      constraints: BoxConstraints(maxWidth: 130),
      items: <PopupMenuItem>[
        PopupMenuItem(
          value: 'Report Post',
          child: GestureDetector(
            onTap: () async {
              Navigator.pop(context);

              await _showBottomSheet(index, screen, context, postuid);
            },
            child: Center(
              child: Text(
                'Report Post',
                style: TextStyle(color: Colors.black),
              ),
            ),
          ),
        ),
        /*   PopupMenuItem<String>(
            value: 'Block User',
            child: GestureDetector(
              onTap: () {
                    Navigator.pop(context);
                    print("dfdsfdfgdfg-${AllGuestPostRoomData?.object?.content?[index].userUid}");
                    print("dfdsfdfgdfg-${AllGuestPostRoomData?.object?.content?[index].userUid}");

              showDialog(
                context: context,
                builder: (_) =>
                    BlockUserdailog(blockUserID: AllGuestPostRoomData?.object?.content?[index].userUid, userName: AllGuestPostRoomData?.object?.content?[index].postUserName),
              );
              },
              child: Container(
                width: 130,
                height: 40,
                child: Center(
                  child: Text(
                    'Block User',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                decoration: BoxDecoration(
                    color: ColorConstant.primary_color,
                    borderRadius: BorderRadius.circular(5)),
              ),
            ),
          ), */
      ]);
}
