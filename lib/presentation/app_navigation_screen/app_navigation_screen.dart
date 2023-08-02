// import 'package:archit_s_application1/core/app_export.dart';
// import 'package:flutter/material.dart';

// class AppNavigationScreen extends StatelessWidget {
//   const AppNavigationScreen({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//         child: Scaffold(
//             backgroundColor: theme.colorScheme.inverseSurface,
//             body: SizedBox(
//                 width: getHorizontalSize(375),
//                 child: Column(
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     children: [
//                       Container(
//                           decoration: AppDecoration.fill3,
//                           child: Column(
//                               mainAxisAlignment: MainAxisAlignment.start,
//                               children: [
//                                 Align(
//                                     alignment: Alignment.centerLeft,
//                                     child: Padding(
//                                         padding: getPadding(
//                                             left: 20,
//                                             top: 10,
//                                             right: 20,
//                                             bottom: 10),
//                                         child: Text("App Navigation",
//                                             overflow: TextOverflow.ellipsis,
//                                             textAlign: TextAlign.center,
//                                             style: TextStyle(
//                                                 color: appTheme.black900,
//                                                 fontSize: getFontSize(20),
//                                                 fontFamily: 'Roboto',
//                                                 fontWeight: FontWeight.w400)))),
//                                 Align(
//                                     alignment: Alignment.centerLeft,
//                                     child: Padding(
//                                         padding: getPadding(left: 20),
//                                         child: Text(
//                                             "Check your app's UI from the below demo screens of your app.",
//                                             overflow: TextOverflow.ellipsis,
//                                             textAlign: TextAlign.center,
//                                             style: TextStyle(
//                                                 color: appTheme.blueGray400,
//                                                 fontSize: getFontSize(16),
//                                                 fontFamily: 'Roboto',
//                                                 fontWeight: FontWeight.w400)))),
//                                 Padding(
//                                     padding: getPadding(top: 5),
//                                     child: Divider(
//                                         height: getVerticalSize(1),
//                                         thickness: getVerticalSize(1),
//                                         color: appTheme.black900))
//                               ])),
//                       Expanded(
//                           child: SingleChildScrollView(
//                               child: Container(
//                                   decoration: AppDecoration.fill3,
//                                   child: Column(
//                                       mainAxisAlignment:
//                                           MainAxisAlignment.start,
//                                       children: [
//                                         GestureDetector(
//                                             onTap: () {
//                                               onTapsplashscreen(context);
//                                             },
//                                             child: Container(
//                                                 decoration: AppDecoration.fill3,
//                                                 child: Column(
//                                                     mainAxisAlignment:
//                                                         MainAxisAlignment.start,
//                                                     children: [
//                                                       Align(
//                                                           alignment: Alignment
//                                                               .centerLeft,
//                                                           child: Padding(
//                                                               padding:
//                                                                   getPadding(
//                                                                       left: 20,
//                                                                       top: 10,
//                                                                       right: 20,
//                                                                       bottom:
//                                                                           10),
//                                                               child: Text(
//                                                                   "1. splash screen",
//                                                                   overflow:
//                                                                       TextOverflow
//                                                                           .ellipsis,
//                                                                   textAlign:
//                                                                       TextAlign
//                                                                           .center,
//                                                                   style: TextStyle(
//                                                                       color: appTheme
//                                                                           .black900,
//                                                                       fontSize:
//                                                                           getFontSize(
//                                                                               20),
//                                                                       fontFamily:
//                                                                           'Roboto',
//                                                                       fontWeight:
//                                                                           FontWeight
//                                                                               .w400)))),
//                                                       Padding(
//                                                           padding: getPadding(
//                                                               top: 5),
//                                                           child: Divider(
//                                                               height:
//                                                                   getVerticalSize(
//                                                                       1),
//                                                               thickness:
//                                                                   getVerticalSize(
//                                                                       1),
//                                                               color: appTheme
//                                                                   .blueGray400))
//                                                     ]))),
//                                         GestureDetector(
//                                             onTap: () {
//                                               onTapregistercreateaccount(
//                                                   context);
//                                             },
//                                             child: Container(
//                                                 decoration: AppDecoration.fill3,
//                                                 child: Column(
//                                                     mainAxisAlignment:
//                                                         MainAxisAlignment.start,
//                                                     children: [
//                                                       Align(
//                                                           alignment: Alignment
//                                                               .centerLeft,
//                                                           child: Padding(
//                                                               padding:
//                                                                   getPadding(
//                                                                       left: 20,
//                                                                       top: 10,
//                                                                       right: 20,
//                                                                       bottom:
//                                                                           10),
//                                                               child: Text(
//                                                                   "2. register / create account",
//                                                                   overflow:
//                                                                       TextOverflow
//                                                                           .ellipsis,
//                                                                   textAlign:
//                                                                       TextAlign
//                                                                           .center,
//                                                                   style: TextStyle(
//                                                                       color: appTheme
//                                                                           .black900,
//                                                                       fontSize:
//                                                                           getFontSize(
//                                                                               20),
//                                                                       fontFamily:
//                                                                           'Roboto',
//                                                                       fontWeight:
//                                                                           FontWeight
//                                                                               .w400)))),
//                                                       Padding(
//                                                           padding: getPadding(
//                                                               top: 5),
//                                                           child: Divider(
//                                                               height:
//                                                                   getVerticalSize(
//                                                                       1),
//                                                               thickness:
//                                                                   getVerticalSize(
//                                                                       1),
//                                                               color: appTheme
//                                                                   .blueGray400))
//                                                     ]))),
//                                         GestureDetector(
//                                             onTap: () {
//                                               onTapRegister(context);
//                                             },
//                                             child: Container(
//                                                 decoration: AppDecoration.fill3,
//                                                 child: Column(
//                                                     mainAxisAlignment:
//                                                         MainAxisAlignment.start,
//                                                     children: [
//                                                       Align(
//                                                           alignment: Alignment
//                                                               .centerLeft,
//                                                           child: Padding(
//                                                               padding:
//                                                                   getPadding(
//                                                                       left: 20,
//                                                                       top: 10,
//                                                                       right: 20,
//                                                                       bottom:
//                                                                           10),
//                                                               child: Text(
//                                                                   "3. Register",
//                                                                   overflow:
//                                                                       TextOverflow
//                                                                           .ellipsis,
//                                                                   textAlign:
//                                                                       TextAlign
//                                                                           .center,
//                                                                   style: TextStyle(
//                                                                       color: appTheme
//                                                                           .black900,
//                                                                       fontSize:
//                                                                           getFontSize(
//                                                                               20),
//                                                                       fontFamily:
//                                                                           'Roboto',
//                                                                       fontWeight:
//                                                                           FontWeight
//                                                                               .w400)))),
//                                                       Padding(
//                                                           padding: getPadding(
//                                                               top: 5),
//                                                           child: Divider(
//                                                               height:
//                                                                   getVerticalSize(
//                                                                       1),
//                                                               thickness:
//                                                                   getVerticalSize(
//                                                                       1),
//                                                               color: appTheme
//                                                                   .blueGray400))
//                                                     ]))),
//                                         GestureDetector(
//                                             onTap: () {
//                                               onTapotpverification(context);
//                                             },
//                                             child: Container(
//                                                 decoration: AppDecoration.fill3,
//                                                 child: Column(
//                                                     mainAxisAlignment:
//                                                         MainAxisAlignment.start,
//                                                     children: [
//                                                       Align(
//                                                           alignment: Alignment
//                                                               .centerLeft,
//                                                           child: Padding(
//                                                               padding:
//                                                                   getPadding(
//                                                                       left: 20,
//                                                                       top: 10,
//                                                                       right: 20,
//                                                                       bottom:
//                                                                           10),
//                                                               child: Text(
//                                                                   "3.1. otp verification",
//                                                                   overflow:
//                                                                       TextOverflow
//                                                                           .ellipsis,
//                                                                   textAlign:
//                                                                       TextAlign
//                                                                           .center,
//                                                                   style: TextStyle(
//                                                                       color: appTheme
//                                                                           .black900,
//                                                                       fontSize:
//                                                                           getFontSize(
//                                                                               20),
//                                                                       fontFamily:
//                                                                           'Roboto',
//                                                                       fontWeight:
//                                                                           FontWeight
//                                                                               .w400)))),
//                                                       Padding(
//                                                           padding: getPadding(
//                                                               top: 5),
//                                                           child: Divider(
//                                                               height:
//                                                                   getVerticalSize(
//                                                                       1),
//                                                               thickness:
//                                                                   getVerticalSize(
//                                                                       1),
//                                                               color: appTheme
//                                                                   .blueGray400))
//                                                     ]))),
//                                         GestureDetector(
//                                             onTap: () {
//                                               onTapForgetpassword(context);
//                                             },
//                                             child: Container(
//                                                 decoration: AppDecoration.fill3,
//                                                 child: Column(
//                                                     mainAxisAlignment:
//                                                         MainAxisAlignment.start,
//                                                     children: [
//                                                       Align(
//                                                           alignment: Alignment
//                                                               .centerLeft,
//                                                           child: Padding(
//                                                               padding:
//                                                                   getPadding(
//                                                                       left: 20,
//                                                                       top: 10,
//                                                                       right: 20,
//                                                                       bottom:
//                                                                           10),
//                                                               child: Text(
//                                                                   "Forget password",
//                                                                   overflow:
//                                                                       TextOverflow
//                                                                           .ellipsis,
//                                                                   textAlign:
//                                                                       TextAlign
//                                                                           .center,
//                                                                   style: TextStyle(
//                                                                       color: appTheme
//                                                                           .black900,
//                                                                       fontSize:
//                                                                           getFontSize(
//                                                                               20),
//                                                                       fontFamily:
//                                                                           'Roboto',
//                                                                       fontWeight:
//                                                                           FontWeight
//                                                                               .w400)))),
//                                                       Padding(
//                                                           padding: getPadding(
//                                                               top: 5),
//                                                           child: Divider(
//                                                               height:
//                                                                   getVerticalSize(
//                                                                       1),
//                                                               thickness:
//                                                                   getVerticalSize(
//                                                                       1),
//                                                               color: appTheme
//                                                                   .blueGray400))
//                                                     ]))),
//                                         GestureDetector(
//                                             onTap: () {
//                                               onTapcreateaccount(context);
//                                             },
//                                             child: Container(
//                                                 decoration: AppDecoration.fill3,
//                                                 child: Column(
//                                                     mainAxisAlignment:
//                                                         MainAxisAlignment.start,
//                                                     children: [
//                                                       Align(
//                                                           alignment: Alignment
//                                                               .centerLeft,
//                                                           child: Padding(
//                                                               padding:
//                                                                   getPadding(
//                                                                       left: 20,
//                                                                       top: 10,
//                                                                       right: 20,
//                                                                       bottom:
//                                                                           10),
//                                                               child: Text(
//                                                                   "4.1. create account",
//                                                                   overflow:
//                                                                       TextOverflow
//                                                                           .ellipsis,
//                                                                   textAlign:
//                                                                       TextAlign
//                                                                           .center,
//                                                                   style: TextStyle(
//                                                                       color: appTheme
//                                                                           .black900,
//                                                                       fontSize:
//                                                                           getFontSize(
//                                                                               20),
//                                                                       fontFamily:
//                                                                           'Roboto',
//                                                                       fontWeight:
//                                                                           FontWeight
//                                                                               .w400)))),
//                                                       Padding(
//                                                           padding: getPadding(
//                                                               top: 5),
//                                                           child: Divider(
//                                                               height:
//                                                                   getVerticalSize(
//                                                                       1),
//                                                               thickness:
//                                                                   getVerticalSize(
//                                                                       1),
//                                                               color: appTheme
//                                                                   .blueGray400))
//                                                     ])))
//                                       ]))))
//                     ]))));
//   }

//   /// Navigates to the splashScreen when the action is triggered.
//   ///
//   /// The [BuildContext] parameter is used to build the navigation stack.
//   /// When the action is triggered, this function uses the `Navigator` widget
//   /// to push the named route for the splashScreen.
//   onTapsplashscreen(BuildContext context) {
//     Navigator.pushNamed(context, AppRoutes.splashScreen);
//   }

//   /// Navigates to the registerCreateAccountScreen when the action is triggered.
//   ///
//   /// The [BuildContext] parameter is used to build the navigation stack.
//   /// When the action is triggered, this function uses the `Navigator` widget
//   /// to push the named route for the registerCreateAccountScreen.
//   onTapregistercreateaccount(BuildContext context) {
//     Navigator.pushNamed(context, AppRoutes.registerCreateAccountScreen);
//   }

//   /// Navigates to the registerScreen when the action is triggered.
//   ///
//   /// The [BuildContext] parameter is used to build the navigation stack.
//   /// When the action is triggered, this function uses the `Navigator` widget
//   /// to push the named route for the registerScreen.
//   onTapRegister(BuildContext context) {
//     Navigator.pushNamed(context, AppRoutes.registerScreen);
//   }

//   /// Navigates to the otpVerificationScreen when the action is triggered.
//   ///
//   /// The [BuildContext] parameter is used to build the navigation stack.
//   /// When the action is triggered, this function uses the `Navigator` widget
//   /// to push the named route for the otpVerificationScreen.
//   onTapotpverification(BuildContext context) {
//     Navigator.pushNamed(context, AppRoutes.otpVerificationScreen);
//   }

//   /// Navigates to the forgetPasswordScreen when the action is triggered.
//   ///
//   /// The [BuildContext] parameter is used to build the navigation stack.
//   /// When the action is triggered, this function uses the `Navigator` widget
//   /// to push the named route for the forgetPasswordScreen.
//   onTapForgetpassword(BuildContext context) {
//     Navigator.pushNamed(context, AppRoutes.forgetPasswordScreen);
//   }

//   /// Navigates to the createAccountScreen when the action is triggered.
//   ///
//   /// The [BuildContext] parameter is used to build the navigation stack.
//   /// When the action is triggered, this function uses the `Navigator` widget
//   /// to push the named route for the createAccountScreen.
//   onTapcreateaccount(BuildContext context) {
//     Navigator.pushNamed(context, AppRoutes.createAccountScreen);
//   }
// }
