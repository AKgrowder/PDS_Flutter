import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:pds/API/Repo/repository.dart';
import 'package:pds/core/utils/color_constant.dart';
import 'package:pds/presentation/%20new/newbottembar.dart';

final List<ReportOption> reportOptions = [
  ReportOption(label: 'SPAM', properString: 'Spam'),
  ReportOption(label: 'VULGARITY_CONTENT', properString: 'Vulgarity Content'),
  ReportOption(
      label: 'NUDITY_OR_SEXUAL_CONTENT',
      properString: 'Nudity or Sexual Content'),
  ReportOption(label: 'SCAM_OR_FRAUD', properString: 'Scam or Fraud'),
  ReportOption(
      label: 'HATE_SPEECH_OR_SYMBOLS', properString: 'Hate Speech or Symbols'),
  ReportOption(
      label: 'BULLYING_OR_HARASSMENT', properString: 'Bullying or Harassment'),
  ReportOption(label: 'MISINFORMATION', properString: 'Misinformation'),
  ReportOption(label: 'SELF_HARM', properString: 'Self Harm'),
  ReportOption(
      label: 'THREATS_OR_VIOLENCE', properString: 'Threats or Violence'),
  ReportOption(label: 'GRAPHIC_CONTENT', properString: 'Graphic Content'),
  ReportOption(
      label: 'DANGEROUS_OR_EXTREMIST_ORGANIZATIONS',
      properString: 'Dangerous or Extremist Organizations'),
  ReportOption(label: 'FAKE_ACCOUNT', properString: 'Fake Account'),
  ReportOption(label: 'CHILD_EXPLOITATION', properString: 'Child Exploitation'),
  ReportOption(
      label: 'ILLEGAL_GOODS_AND_SERVICES',
      properString: 'Illegal Goods and Services'),
  ReportOption(
      label: 'INFRINGEMENT_OR_DEFAMATION',
      properString: 'Infringement or Defamation'),
];

_showBottomSheet(
  BuildContext context,
  String postuid,
) {
  double screenHeight = MediaQuery.of(context).size.height;
  double bottomSheetHeight = screenHeight * 0.75;
  TextEditingController otherTextData = TextEditingController();
  showModalBottomSheet(
    isScrollControlled: true,
    context: context,
    builder: (BuildContext ctx) {
      return StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
          return GestureDetector(
            onTap: () {
              FocusScope.of(context)
                  .unfocus(); // Dismiss keyboard when tapping outside text field
            },
            child: Padding(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom),
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
                                }
                              });
                            },
                          );
                        },
                      ),
                    ),
                    SizedBox(height: 20),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: TextField(
                        controller: otherTextData,
                        decoration: InputDecoration(
                          hintText: 'Other',
                          border: OutlineInputBorder(),
                        ),
                        enabled:
                            !reportOptions.any((option) => option.selected),
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
                        onPressed: () {
                          print(
                              "chck Data -${reportOptions.any((option) => option.selected)}");
                          if (reportOptions.any((option) => option.selected) ==
                              true) {
                            for (int i = 0; i < reportOptions.length; i++) {
                              if (reportOptions[i].selected == true) {
                                print("chck-${reportOptions[i].label}");
                                _handleSubmit(
                                    reportOptions[i].label, postuid, ctx);
                              }
                            }
                          } else if (otherTextData.text.isNotEmpty) {
                            _handleSubmit(
                              otherTextData.text,
                              postuid,
                              ctx,
                              othersDescription: 'othersDescription',
                            );
                          } else {
                            CustomFlushBar().flushBar(
                                text: 'Please Select Reason',
                                context: context,
                                duration: 2,
                                backgroundColor: ColorConstant.primary_color);
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

_handleSubmit(String content, String postuid, BuildContext context,
    {String? othersDescription}) async {
  print('Other content: $content');
  print('postuid: $postuid');
  dynamic meesage;
  if (othersDescription != null) {
    Map<String, dynamic> parems = {
      'postUid': postuid,
      'reportType': 'OTHERS',
      "othersDescription": content,
    };
    meesage = await Repository().report_post(context, parems);
  } else {
    Map<String, dynamic> parems = {'postUid': postuid, 'reportType': content};
    meesage = await Repository().report_post(context, parems);
  }

  SnackBar snackBar = SnackBar(
    content: Text(meesage.object),
    backgroundColor: ColorConstant.primary_color,
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
  Navigator.pop(context);
  Navigator.pop(context);

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
  BuildContext context,
  int index,
  buttonKey,
  postuid,
) {
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
               await _showBottomSheet(context, postuid);
              
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
      ]).then((value) => print("value -$value"));
}
