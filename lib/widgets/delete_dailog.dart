import 'package:flutter/material.dart';
import 'package:pds/core/utils/color_constant.dart';
import 'package:pds/core/utils/image_constant.dart';
import 'package:pds/widgets/custom_text_form_field.dart';

class FunkyOverlay extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => FunkyOverlayState();
}

class FunkyOverlayState extends State<FunkyOverlay>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> scaleAnimation;

  TextEditingController reasonController = TextEditingController();

  @override
  void initState() {
    super.initState();

    controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 450));
    scaleAnimation =
        CurvedAnimation(parent: controller, curve: Curves.elasticInOut);

    controller.addListener(() {
      setState(() {});
    });

    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    // double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Center(
      child: Material(
        color: Color.fromARGB(0, 255, 255, 255),
        child: ScaleTransition(
          scale: scaleAnimation,
          child: Container(
            height: height / 1.4,
            decoration: ShapeDecoration(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
            ),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    height: height / 1.4 - 80,
                    width: MediaQuery.of(context).size.width / 1.17,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color: Colors.white,
                      // color: Theme.of(context).brightness == Brightness.light
                      //     ? Color(0XFFEFEFEF)
                      //     : Color(0XFF212121),
                    ),
                    child: Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Container(
                            margin: EdgeInsets.only(right: 4),
                            height: 50,
                            color: Colors.transparent,
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: Image.asset(
                                ImageConstant.closeimage,
                                height: 40,
                                width: 40,
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          height: MediaQuery.of(context).size.width / 3.2,
                          width: MediaQuery.of(context).size.width / 3,
                          // color: Colors.red[100],
                          child: Image.asset(
                            ImageConstant.closeimage,
                            fit: BoxFit.fill,
                            color: ColorConstant.primary_color,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: Text(
                              "Are you Sure you want to \n Delete your Account?",
                              textScaleFactor: 1.0,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontFamily: 'outfit',
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                color: ColorConstant
                                    .primary_color, /* textCenter: true, */
                              )),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 7),
                          child: Text(
                            "All the data will be deleted from the \n server after 30 days.",
                            textScaleFactor: 1.0,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontFamily: 'outfit',
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              // textCenter: true,
                              // color: Colors.black45,
                              color: Theme.of(context).brightness ==
                                      Brightness.light
                                  ? Colors.black45
                                  : Colors.grey,
                            ),
                          ),
                        ),
                        Padding(
                            padding: EdgeInsets.only(top: 1, left: 15),
                            child: Row(children: [
                              Padding(
                                  padding: EdgeInsets.only(top: 5, bottom: 5),
                                  child: Text("Reason",
                                      textScaleFactor: 1.0,
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                        fontFamily: 'outfit',
                                        color: ColorConstant.primary_color,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                      ))),
                              Padding(
                                  padding: EdgeInsets.only(left: 5, bottom: 2),
                                  child: Text("*",
                                      textScaleFactor: 1.0,
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                        color: ColorConstant.primary_color,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                      )))
                            ])),
                        Padding(
                          padding: const EdgeInsets.only(left: 15, right: 15),
                          child: CustomTextFormField(
                            // focusNode: FocusNode(),
                            controller: reasonController,
                            hintText: "",
                            maxLength: 150,
                            // padding: TextFormFieldPadding.PaddingT44,
                            maxLines: 5,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 35, left: 30, right: 30),
                          child: Row(
                            children: [
                              Flexible(
                                flex: 2,
                                fit: FlexFit.tight,
                                child: GestureDetector(
                                  // onTap: () {
                                  //   if (reasonController.text.isNotEmpty) {
                                  //     BlocProvider.of<DeleteUserCubit>(
                                  //             context)
                                  //         .DeleteUser(reasonController.text,context);
                                  //   } else {
                                  //     SnackBar snackBar = SnackBar(
                                  //       content: Text(
                                  //         'Please Enter Valid Reason.',
                                  //         textScaleFactor: 1.0,
                                  //       ),
                                  //       backgroundColor:
                                  //           ColorConstant.primary_color,
                                  //     );
                                  //     ScaffoldMessenger.of(context)
                                  //         .showSnackBar(snackBar);
                                  //   }
                                  //   // Navigator.pop(context);
                                  // },
                                  child: Container(
                                    width: 163,
                                    height: 48,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: ColorConstant.primary_color,
                                    ),
                                    child: Center(
                                      child: Text("Yes",
                                          textScaleFactor: 1.0,
                                          style: TextStyle(
                                              fontFamily: 'outfit',
                                              fontSize: 16,
                                              color: Colors.white,
                                              fontWeight: FontWeight.w600)),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 20,
                              ), //SizedBox
                              Flexible(
                                  flex: 2,
                                  fit: FlexFit.tight,
                                  child: GestureDetector(
                                    onTap: () {
                                      Navigator.pop(context);
                                    },
                                    child: Container(
                                        width: 163,
                                        height: 48,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          // color: ColorConstant.whiteA700,
                                          color: Theme.of(context).brightness ==
                                                  Brightness.light
                                              ? Colors.white
                                              : Colors.black,
                                          border: Border.all(
                                            // color: ColorConstant.orangeA700,
                                            color: Theme.of(context)
                                                        .brightness ==
                                                    Brightness.light
                                                ? ColorConstant.primary_color
                                                : ColorConstant.primary_color,
                                            width: 1.5,
                                            style: BorderStyle.solid,
                                            strokeAlign:
                                                BorderSide.strokeAlignInside,
                                          ),
                                        ),
                                        child: Center(
                                          child: Text(
                                            "No",
                                            textScaleFactor: 1.0,
                                            style: TextStyle(
                                                fontFamily: 'outfit',
                                                fontSize: 16,
                                                // color: ColorConstant.orangeA700,
                                                color: Theme.of(context)
                                                            .brightness ==
                                                        Brightness.light
                                                    ? Colors.black
                                                    : ColorConstant
                                                        .primary_color,
                                                fontWeight: FontWeight.w600),
                                          ),
                                        )),
                                  ))
                            ],
                            mainAxisAlignment: MainAxisAlignment.center,
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
