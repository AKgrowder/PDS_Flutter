import 'dart:io';

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../core/utils/image_constant.dart';
import '../../widgets/app_bar/custom_app_bar.dart';

class SupportScreen extends StatefulWidget {
  const SupportScreen({Key? key}) : super(key: key);

  @override
  State<SupportScreen> createState() => _SupportScreenState();
}

class _SupportScreenState extends State<SupportScreen> {
  var IsGuestUserEnabled;

  void initState() {
    // BlocProvider.of<StatusCubit>(context).getStatus();
    // init();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // double width = MediaQuery.of(context).size.width;
    double _height = MediaQuery.of(context).size.height;
    return Scaffold(
      // backgroundColor: Colors.white,
      appBar: CustomAppBar(
        height: 100,
        title: Text(
          "Support",
          style: TextStyle(
              color: Colors.black,
              fontFamily: 'Outfit',
              fontWeight: FontWeight.w600,
              fontSize: 20),
        ),
        leadingWidth: 74,
        leading: Container(
          height: 44,
          width: 44,
          margin: EdgeInsets.only(left: 30, top: 6, bottom: 6),
          child: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Padding(
              padding: const EdgeInsets.only(top: 0,right: 20),
              child: Icon(
                Icons.arrow_back,
                color: Theme.of(context).brightness == Brightness.light
                    ? Color(0XFF989898)
                    : Color(0xFFC5C0C0),
              ),
            ),
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Column(
          children: [
            // SizedBox(
            //   height: height / 26,
            // ),
            // GestureDetector(
            //   onTap: () {
            //     Navigator.push(
            //         context,
            //         MaterialPageRoute(
            //             builder: (context) => Policies(
            //                   title: "User Guidance",
            //                   data: Policy_Data.user_guide,
            //                 )));
            //   },
            //   child: Container(
            //     height: height / 15,
            //     // width: width / 1.2,
            //     decoration: BoxDecoration(
            //       borderRadius: BorderRadius.circular(5),
            //       // color: const Color(0XFFF6F6F6),
            //       color: Theme.of(context).brightness == Brightness.light
            //           ? Color(0XFFEFEFEF)
            //           : Color(0XFF212121),
            //     ),
            //     child: Row(
            //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //       children: [
            //         Padding(
            //           padding: const EdgeInsets.only(left: 20.0),
            //           child: Image.asset(
            //             ImageConstant.bag,
            //             height: 25,
            //             color: Colors.grey,
            //           ),
            //         ),
            //         SizedBox(
            //           width: MediaQuery.of(context).size.width / 15,
            //         ),
            //         Text(
            //           "User Guide",
            //           textScaleFactor: 1.0,
            //           style: TextStyle(
            //               color: Color(0XFF939393),
            //               fontFamily: 'Outfit',
            //               fontWeight: FontWeight.bold,
            //               fontSize: 16),
            //         ),
            //         Spacer(),
            //         Padding(
            //           padding: const EdgeInsets.all(8.0),
            //           child: Icon(
            //             Icons.arrow_forward_ios,
            //             color: Color(0XFF939393),
            //           ),
            //         )
            //       ],
            //     ),
            //   ),
            // ),
            // IsGuestUserEnabled == "true" && status == null
            //     ? SizedBox()
            //     : SizedBox(
            //         height: height / 45,
            //       ),
            // IsGuestUserEnabled == "true" && status == null
            //     ? SizedBox.shrink()
            //     : GestureDetector(
            //         // onTap: () {
            //         //   Navigator.push(
            //         //       context,
            //         //       MaterialPageRoute(
            //         //         builder: (context) => BlocProvider(
            //         //           create: (context) => AllRaiseTicketCubit(),
            //         //           child: raisedTicketsScreen(),
            //         //         ),
            //         //       ));
            //         // },
            //         child: Container(
            //           height: height / 15,
            //           // width: width / 1.2,
            //           decoration: BoxDecoration(
            //             borderRadius: BorderRadius.circular(5),
            //             // color: const Color(0XFFF6F6F6),
            //             color: Theme.of(context).brightness == Brightness.light
            //                 ? Color(0XFFEFEFEF)
            //                 : Color(0XFF212121),
            //           ),
            //           child: Row(
            //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //             children: [
            //               Padding(
            //                 padding: const EdgeInsets.only(left: 20.0),
            //                 child: Image.asset(ImageConstant. bag),
            //               ),
            //               SizedBox(
            //                 width: MediaQuery.of(context).size.width / 15,
            //               ),
            //               Text(
            //                 "Raised Tickets",
            //                 textScaleFactor: 1.0,
            //                 style: TextStyle(
            //                     color: Color(0XFF939393),
            //                     fontFamily: 'Outfit',
            //                     fontWeight: FontWeight.bold,
            //                     fontSize: 16),
            //               ),
            //               Spacer(),
            //               Padding(
            //                 padding: const EdgeInsets.all(8.0),
            //                 child: Icon(
            //                   Icons.arrow_forward_ios,
            //                   color: Color(0XFF939393),
            //                 ),
            //               )
            //             ],
            //           ),
            //         ),
            //       ),
            SizedBox(
              height: _height / 45,
            ),
            GestureDetector(
              onTap: () {
                showModalBottomSheet(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    context: context,
                    builder: (BuildContext context) {
                      return Container(
                        height: _height / 3.8,
                        child: Column(
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(20),
                                child: Align(
                                  alignment: Alignment.centerRight,
                                  child: Image.asset(
                                    ImageConstant.closeimage,
                                    fit: BoxFit.fill,
                                    height: 40,
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(right: 15, left: 15),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Spacer(),
                                  /*   btnWidget(
                                      img: ImageConstant.whatsAppIcon,
                                      name: "WhatsApp",
                                      onTap: () async {
                                        var phoneNumber = "7861865545";
                                        Uri url = Uri.parse(
                                            "whatsapp://send?phone=$phoneNumber");
                                        if (Platform.isAndroid) {
                                          await launchUrl(
                                            url,
                                          );
                                        } else {
                                          print("WhatsApp is not installed!");
                                        }
                                      }), */
                                  btnWidget(
                                      img: ImageConstant.redphoneimage,
                                      name: "Toll-free",
                                      height: 40,
                                      onTap: () async {
                                        Uri phoneno =
                                            Uri.parse('tel:6352283366');

                                        if (Platform.isAndroid) {
                                          await launchUrl(phoneno);
                                        } else {
                                          if (await canLaunchUrl(phoneno)) {
                                            await launchUrl(phoneno);
                                          } else {
                                            throw 'Could not launch $phoneno';
                                          }
                                        }
                                      }),
                                  Spacer(),
                                  btnWidget(
                                      img: ImageConstant.mail,
                                      name: "Email",
                                      onTap: () async {
                                        String email = Uri.encodeComponent(
                                            "info@packagingdepot.store");

                                        Uri mailto = Uri.parse("mailto:$email");
                                        if (Platform.isAndroid) {
                                          await launchUrl(mailto);
                                        } else {
                                          if (await canLaunchUrl(mailto)) {
                                            await launchUrl(mailto);
                                          } else {
                                            throw 'Could not launch $mailto';
                                          }
                                        }
                                      }),
                                  Spacer(),
                                  // btnWidget(
                                  //     img: ImageConstant.phoneimage,
                                  //     name: "Call Us",
                                  //     onTap: () async {
                                  //       Uri phoneno =
                                  //           Uri.parse('tel:6352283366');
                                  //       if (Platform.isAndroid) {
                                  //         await launchUrl(phoneno);
                                  //       } else {
                                  //         if (await canLaunchUrl(phoneno)) {
                                  //           await launchUrl(phoneno);
                                  //         } else {
                                  //           throw 'Could not launch $phoneno';
                                  //         }
                                  //       }
                                  //     }),
                                  // Spacer(),
                                ],
                              ),
                            )
                          ],
                        ),
                      );
                    });

                // showModalBottomSheet(
                //     shape: RoundedRectangleBorder(
                //         borderRadius: BorderRadius.circular(20)),
                //     context: context,
                //     builder: (BuildContext context) {
                //       return Container(
                //         height: height / 3.8,
                //         child: Column(
                //           children: [
                //             GestureDetector(
                //               onTap: () {
                //                 Navigator.pop(context);
                //               },
                //               child: Padding(
                //                 padding: const EdgeInsets.all(20),
                //                 child: Align(
                //                   alignment: Alignment.centerRight,
                //                   child: Image.asset(
                //                     ImageConstant.close,
                //                     fit: BoxFit.fill,
                //                     height: 30,
                //                   ),
                //                 ),
                //               ),
                //             ),
                //             Padding(
                //               padding:
                //                   const EdgeInsets.only(right: 15, left: 15),
                //               child: Row(
                //                 mainAxisAlignment:
                //                     MainAxisAlignment.spaceBetween,
                //                 children: [
                //                   Spacer(),
                //                   /*   btnWidget(
                //                       img: ImageConstant.whatsAppIcon,
                //                       name: "WhatsApp",
                //                       onTap: () async {
                //                         var phoneNumber = "7861865545";
                //                         Uri url = Uri.parse(
                //                             "whatsapp://send?phone=$phoneNumber");
                //                         if (Platform.isAndroid) {
                //                           await launchUrl(
                //                             url,
                //                           );
                //                         } else {
                //                           print("WhatsApp is not installed!");
                //                         }
                //                       }), */
                //                   btnWidget(
                //                       img: ImageConstant.maskGroup,
                //                       name: "Toll-free",
                //                       height: 40,
                //                       onTap: () async {
                //                         Uri phoneno =
                //                             Uri.parse('tel:18005705070');
                //                         if (Platform.isAndroid) {
                //                           await launchUrl(phoneno);
                //                         } else {
                //                           print("Somthing went wrong!");
                //                         }
                //                       }),
                //                   Spacer(),
                //                   btnWidget(
                //                       img: ImageConstant.emailIcon,
                //                       name: "Email",
                //                       onTap: () async {
                //                         String email = Uri.encodeComponent(
                //                             "info@growder.com");

                //                         Uri mailto = Uri.parse("mailto:$email");
                //                         if (Platform.isAndroid) {
                //                           await launchUrl(mailto);
                //                         } else {
                //                           print("Somthing went wrong!");
                //                         }
                //                       }),
                //                   Spacer(),
                //                   btnWidget(
                //                       img: ImageConstant.callIcon,
                //                       name: "Call Us",
                //                       onTap: () async {
                //                         Uri phoneno =
                //                             Uri.parse('tel:7861865545');
                //                         if (Platform.isAndroid) {
                //                           await launchUrl(phoneno);
                //                         } else {
                //                           print("Somthing went wrong!");
                //                         }
                //                       }),
                //                   Spacer(),
                //                 ],
                //               ),
                //             )
                //           ],
                //         ),
                //       );
                //     });
              },
              child: Container(
                height: _height / 15,
                // width: width / 1.2,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    // color: const Color(0XFFF6F6F6),
                    color: Color(0xFFF6F4F4)),
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 20.0),
                        child: Image.asset(
                          ImageConstant.phoneimage,
                          height: 20,
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 15,
                      ),
                      Text(
                        "Contact Us",
                        textScaleFactor: 1.0,
                        style: TextStyle(
                            color: Color(0XFF939393),
                            fontFamily: 'Outfit',
                            fontWeight: FontWeight.bold,
                            fontSize: 16),
                      ),
                      Spacer(),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(
                          Icons.arrow_forward_ios,
                          color: Color(0XFF939393),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            // SizedBox(
            //   height: height / 45,
            // ),
            // GestureDetector(
            //   onTap: () {
            //     Navigator.push(
            //       context,
            //       MaterialPageRoute(
            //         builder: (context) => FAQScreen(),
            //       ),
            //     );
            //   },
            //   child: Container(
            //     height: height / 15,
            //     // width: width / 1.2,
            //     decoration: BoxDecoration(
            //       borderRadius: BorderRadius.circular(5),
            //       // color: const Color(0XFFF6F6F6),
            //       color: Theme.of(context).brightness == Brightness.light
            //           ? Color(0XFFEFEFEF)
            //           : Color(0XFF212121),
            //     ),
            //     child: Center(
            //       child: Row(
            //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //         children: [
            //           Padding(
            //             padding: const EdgeInsets.only(left: 20.0),
            //             child: Image.asset(ImageConstant.FAQ),
            //           ),
            //           SizedBox(
            //             width: MediaQuery.of(context).size.width / 15,
            //           ),
            //           Text(
            //             "FAQ’s",
            //             textScaleFactor: 1.0,
            //             style: TextStyle(
            //                 color: Color(0XFF939393),
            //                 fontFamily: 'Outfit',
            //                 fontWeight: FontWeight.bold,
            //                 fontSize: 16),
            //           ),
            //           Spacer(),
            //           Padding(
            //             padding: const EdgeInsets.all(8.0),
            //             child: Icon(
            //               Icons.arrow_forward_ios,
            //               color: Color(0XFF939393),
            //             ),
            //           ),
            //         ],
            //       ),
            //     ),
            //   ),
            // ),
            // SizedBox(
            //   height: 20,
            // ),

/* 
            
                Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return Dialog(
                            elevation: 0,
                            backgroundColor: Colors.transparent,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            child: Container(
                              height: height / 2,
                              width: width,
                              // color: Colors.white,
                              child: Column(
                                children: [
                                  Image.asset(
                                    ImageConstant.versionAlertImg,
                                    height: height / 4.8,
                                    width: width,
                                    fit: BoxFit.fill,
                                  ),
                                  Container(
                                    height: height / 7,
                                    width: width,
                                    color: Colors.white,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        SizedBox(
                                          height: 10,
                                        ),
                                        AppText(
                                          text: "New Version Alert",
                                          fontWeight: FontWeight.w700,
                                          fontsize: 20,
                                          color: ColorConstant.orangeA700,
                                        ),
                                        SizedBox(
                                          height: 20,
                                        ),
                                        AppText(
                                          text:
                                              "New application version is available",
                                          fontWeight: FontWeight.w500,
                                          fontsize: 15,
                                          color: ColorConstant.black900,
                                        ),
                                        AppText(
                                          text:
                                              "please download latest version",
                                          fontWeight: FontWeight.w500,
                                          fontsize: 15,
                                          color: ColorConstant.black900,
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    height: 45,
                                    width: width,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.only(
                                            bottomLeft: Radius.circular(10),
                                            bottomRight: Radius.circular(10)),
                                        color: ColorConstant.orangeA700),
                                    child: Center(
                                        child: AppText(
                                      text: "Update",
                                      fontWeight: FontWeight.w500,
                                      fontsize: 17,
                                      color: ColorConstant.whiteA700,
                                    )),
                                  )
                                ],
                              ),
                            ),
                          );
                        });
                  },
                  child: Container(
                    height: 40,
                    width: 100,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.orange),
                    child: Center(
                        child: Text(
                      "Alert Update",
                    )),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return Dialog(
                            elevation: 0,
                            backgroundColor: Colors.transparent,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            child: Container(
                              height: height / 2,
                              width: width,
                              // color: Colors.white,
                              child: Column(
                                children: [
                                  Image.asset(
                                    ImageConstant.versionAlertImg,
                                    height: height / 4.8,
                                    width: width,
                                    fit: BoxFit.fill,
                                  ),
                                  Container(
                                    height: height / 7,
                                    width: width,
                                    color: Colors.white,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        SizedBox(
                                          height: 10,
                                        ),
                                        AppText(
                                          text: "New Version Alert",
                                          fontWeight: FontWeight.w700,
                                          fontsize: 20,
                                          color: ColorConstant.orangeA700,
                                        ),
                                        SizedBox(
                                          height: 20,
                                        ),
                                        AppText(
                                          text:
                                              "New application version is available",
                                          fontWeight: FontWeight.w500,
                                          fontsize: 15,
                                          color: ColorConstant.black900,
                                        ),
                                        AppText(
                                          text:
                                              "please download latest version",
                                          fontWeight: FontWeight.w500,
                                          fontsize: 15,
                                          color: ColorConstant.black900,
                                        ),
                                      ],
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Container(
                                        height: 50,
                                        width: width / 2.48,
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                width: 1.5,
                                                color:
                                                    ColorConstant.orangeA700),
                                            borderRadius: BorderRadius.only(
                                              bottomLeft: Radius.circular(10),
                                            ),
                                            color: ColorConstant.whiteA700),
                                        child: Center(
                                            child: AppText(
                                          text: "Later",
                                          fontWeight: FontWeight.w500,
                                          fontsize: 17,
                                          color: ColorConstant.orangeA700,
                                        )),
                                      ),
                                      Container(
                                        height: 50,
                                        width: width / 2.486,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.only(
                                                bottomRight:
                                                    Radius.circular(10)),
                                            color: ColorConstant.orangeA700),
                                        child: Center(
                                            child: AppText(
                                          text: "Update",
                                          fontWeight: FontWeight.w500,
                                          fontsize: 17,
                                          color: ColorConstant.whiteA700,
                                        )),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                          );
                        });
                  },
                  child: Container(
                    height: 40,
                    width: 100,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.orange),
                    child: Center(child: Text("Alert Update")),
                  ),
                )
              ],
            ) */
          ],
        ),
      ),
    );
  }

  Widget btnWidget({
    double? height,
    required String name,
    required String img,
    required void Function() onTap,
  }) {
    return Column(
      children: [
        GestureDetector(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Align(
              alignment: Alignment.centerRight,
              child: Image.asset(
                img,
                fit: BoxFit.fill,
                height: height ?? 40,
              ),
            ),
          ),
        ),
        Text(
          name,
          textScaleFactor: 1.0,
          style: TextStyle(
              color: Color(0XFF939393),
              fontFamily: 'Outfit',
              fontWeight: FontWeight.bold,
              fontSize: 16),
        )
      ],
    );
  }

  // init() async {
  //   final SharedPreferences prefs = await SharedPreferences.getInstance();

  //   IsGuestUserEnabled =
  //       await prefs.getString(UserdefaultsData.IsGuestUserEnabled);

  //   setState(() {});
  //   print(IsGuestUserEnabled);
  // }
}
