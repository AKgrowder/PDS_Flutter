import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:pds/core/utils/color_constant.dart';
import 'package:pds/core/utils/internet_utils.dart';
import 'package:pds/presentation/noInterneterror/noInterNetScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/utils/image_constant.dart';
import '../../core/utils/sharedPreferences.dart';
import '../../presentation/splash_screen/splash_screen.dart';

class ApiServices {
  var baseURL = "";
  var Token = "";
  bool? checkURL = false;
  UpdateBaseURL() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    checkURL = prefs.getBool(PreferencesKey.RoutURlChnage);
    Token = prefs.getString(PreferencesKey.loginJwt) ?? "";
    if (checkURL == true) {
      /// UAT
      baseURL = prefs.getString(PreferencesKey.RoutURL) ?? "";
    } else {
      baseURL =
          // "https://0b8e-2405-201-200b-a0cf-4523-3bc3-2996-dc22.ngrok.io/";
          // "https://uatapi.packagingdepot.store/";
          // "https://api.packagingdepot.store/";
          "http://192.168.29.100:8081/";
    }

    print(baseURL);
  }

  postApiCall(
      String APIurl, Map<String, dynamic> params, BuildContext context) async {
    await UpdateBaseURL();
    print('token-$Token');
    print('parems-$params');
    final headers1 = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${Token}'
    };
    print("API =>******${baseURL + APIurl}");
    final hasInternet = await checkInternet();

    if (hasInternet == true) {
      final response = await post(Uri.parse(baseURL + APIurl),
          headers: headers1, body: json.encode(params));
      if (response.statusCode == 602) {
        setLOGOUT(context);
      } else {
        print("responce-->$response");
        return response;
      }
    } else {}
  }

  getApiCall(String APIurl, BuildContext context) async {
    await UpdateBaseURL();
    if (APIurl == "user/api/fetchSysConfig") {
      baseURL =
          // "https://0b8e-2405-201-200b-a0cf-4523-3bc3-2996-dc22.ngrok.io/";
          // "https://uatapi.packagingdepot.store/";
          // "https://api.packagingdepot.store/";
          "http://192.168.29.100:8081/";
    }
    print("API => ******** ${baseURL + APIurl}");

    final hasInternet = await checkInternet();
    if (hasInternet == true) {
      final response = await get(
        Uri.parse(baseURL + APIurl), /*  headers: headers1 */
      );
      print("response - ${response.body}");
      if (response.statusCode == 602) {
        setLOGOUT(context);
      } else {
        return response;
      }
    } else {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => NoInterNetScreen()));
    }
  }

  getApiCallWithToken(String APIurl, BuildContext context) async {
    await UpdateBaseURL();
    final headers1 = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${Token}'
    };
    print("API => ******** ${baseURL + APIurl}");
    final hasInternet = await checkInternet();
    if (hasInternet == true) {
      final response = await get(
        Uri.parse(baseURL + APIurl),
        headers: headers1,
      );

      print('respncebody-${response.body}');
      if (response.statusCode == 602) {
        setLOGOUT(context);
      } else {
        return response;
      }
    } else {}
  }

  Future<Response?> deleteApiCall(
      String APIurl, Map<String, dynamic> params, BuildContext context) async {
    await UpdateBaseURL();

    final headers1 = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${Token}'
    };
    print("API =>******${baseURL + APIurl}");
    final response = await delete(Uri.parse(baseURL + APIurl),
        headers: headers1, body: json.encode(params));

    if (response.statusCode == 602) {
      await setLOGOUT(context);
    } else {
      return response;
    }
  }

  Future<Response?> deleteApiCall1(String APIurl, BuildContext context) async {
    await UpdateBaseURL();

    print("API =>******${baseURL + APIurl}");
    final response = await delete(
      Uri.parse(baseURL + APIurl),
    );

    if (response.statusCode == 602) {
      await setLOGOUT(context);
    } else {
      return response;
    }
  }

  Future<Response?> deleteApiCallWithToken(
      String APIurl, BuildContext context) async {
    await UpdateBaseURL();

    await UpdateBaseURL();

    final headers1 = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${Token}'
    };
    print("API =>******${baseURL + APIurl}");
    final response = await delete(
      Uri.parse(baseURL + APIurl),
      headers: headers1,
    );

    if (response.statusCode == 602) {
      await setLOGOUT(context);
    } else {
      return response;
    }
  }

  Future<Response?> deleteApiCallWithOutparams(
      String APIurl, BuildContext context) async {
    await UpdateBaseURL();

    final headers1 = {'Authorization': 'Bearer ${Token}'};
    print("API =>******${baseURL + APIurl}");
    final response = await delete(
      Uri.parse(baseURL + APIurl),
      headers: headers1,
    );

    if (response.statusCode == 602) {
      await setLOGOUT(context);
    } else {
      return response;
    }
  }

  postApiCalla(String APIurl, BuildContext context) async {
    await UpdateBaseURL();
    final headers1 = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${Token}'
    };
    print("API =>******${baseURL + APIurl}");
    final hasInternet = await checkInternet();
    if (hasInternet == true) {
      final response = await post(
        Uri.parse(baseURL + APIurl),
        headers: headers1,
      );
      if (response.statusCode == 602) {
        setLOGOUT(context);
      } else {
        return response;
      }
    }
  }

  multipartFile2(
      String APIurl, Map<String, dynamic>? params, BuildContext context) async {
    await UpdateBaseURL();
    var headers1 = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${Token}'
    };
    final response =
        await http.MultipartRequest('POST', Uri.parse(baseURL + APIurl));
    print("API =>******${baseURL + APIurl}");

    response.headers.addAll(headers1);
    if (params != null) {
      /* if (params['userProfilePic'].toString().isNotEmpty &&
          params['userBackgroundPic'].toString().isNotEmpty) {
        print("multipartIfcondison");
        response.fields["userProfilePic"] = params['userProfilePic'];
        response.fields["userBackgroundPic"] = params['userBackgroundPic'];
      } else if (params['userProfilePic'].toString().isNotEmpty ) {
        print("multipart else if");
        response.fields["userProfilePic"] = params['userProfilePic'];
      } else {
        if (params['userBackgroundPic'].toString().isNotEmpty ) {
          print("multipart else ");
          response.fields["userBackgroundPic"] = params['userBackgroundPic'];
        }
      } */
      print("userProfiePictureResponce---${params['userProfilePic']}");
      print("userBackgroundPicResponce---${params['userBackgroundPic']}");
      if (params['userProfilePic'] != null &&
          params['userBackgroundPic'] != null) {
        response.fields["userProfilePic"] = params['userProfilePic'];
        response.fields["userBackgroundPic"] = params['userBackgroundPic'];
      } else if (params['userBackgroundPic'] != null) {
        response.fields["userBackgroundPic"] = params['userBackgroundPic'];
      } else if (params['userProfilePic'] != null) {
        response.fields["userProfilePic"] = params['userProfilePic'];
      }else if (params['documentName'] != null) {
          response.fields["documentName"] = params['documentName'];
      } else {
        print("multipartFile2 else condions working on--");
      }
      response.fields["document"] = params['document'];
   
      response.fields["companyName"] = params['companyName'];
      response.fields["jobProfile"] = params['jobProfile'];
      response.fields["profileUid"] = params['profileUid'];
      response.fields["name"] = params['name'];
      response.fields["email"] = params['email'];
      response.fields["industryTypesUid"] = params['industryTypesUid'];
    }
    log('companyUserAllData-${response.fields}');
    print("check userProfilePic--${params?['userProfilePic']}");
    print("check userBackgroundPic--${params?['userBackgroundPic']}");

    var res = await response.send();
    print('responce stauscode-${res.statusCode.toString()}');
    if (res.statusCode == 602) {
      setLOGOUT(context);
    } else {
      var respond = await http.Response.fromStream(res);
      print('responsData-${respond.body}');
      return respond;
    }
  }

  multipartFile(
      String APIurl, String fileName, String file, BuildContext context,
      {String? apiName, Map<String, dynamic>? params, bool? AadPost}) async {
    await UpdateBaseURL();

    print('fileApi-$file');
    print('fileName-$fileName');

    var headers1;
    if (AadPost == true) {
      print("this hader true");
      headers1 = {'document': '', 'Authorization': 'Bearer ${Token}'};
    } else {
      print("else hader");
      headers1 = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${Token}'
      };
    }

    print("Token-->$Token");
    print("API =>******${baseURL + APIurl}");
    print("header full Print-->$headers1");
    final response =
        await http.MultipartRequest('POST', Uri.parse(baseURL + APIurl));
    response.headers.addAll(headers1);
    if (params != null) {
      if (apiName != 'create forum') {
        response.fields["document"] = params['document'] ?? "";
        response.fields["companyName"] = params['companyName'] ?? "";
        response.fields["documentName"] = params['documentName'] ?? "";
        response.fields["jobProfile"] = params['jobProfile'] ?? "";
        response.fields["industryTypesUid"] = params['industryTypesUid'] ?? [];

        print('params-$params');
      }
    }

    print("paramesa-->$params");
    if (apiName == 'create forum' || AadPost == true) {
      print('this is the get');
      response.files.add(await http.MultipartFile.fromPath('document', file));
    }

    print('checkdataher');
    var res = await response.send();
    print('responce stauscode-${res.statusCode.toString()}');
    if (res.statusCode == 602) {
      setLOGOUT(context);
    } else {
      var respond = await http.Response.fromStream(res);
      print('responsData-${respond.body}');
      return respond;
    }
  }

  multipartFileUserprofile(String APIurl, File imageFile, BuildContext context,
      {bool? ImageDatasetup, String? imageDataType}) async {
    await UpdateBaseURL();
    var headers1 = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${Token}'
    };

    final response =
        await http.MultipartRequest('POST', Uri.parse(baseURL + APIurl));
    response.headers.addAll(headers1);
    print("API =>******${baseURL + APIurl}");
    if (imageFile != null) {
      if (imageDataType?.isNotEmpty == true) {
        response.files
            .add(await http.MultipartFile.fromPath('image', imageFile.path));
      } else {
        response.files
            .add(await http.MultipartFile.fromPath('document', imageFile.path));
      }
    }
    var res = await response.send();
    print('responce stauscode-${res.statusCode.toString()}');
    if (res.statusCode == 602) {
      setLOGOUT(context);
    } else {
      var respond = await http.Response.fromStream(res);
      print('responsData-${respond.body}');
      return respond;
    }
  }

  multipartFileWithSoket(
    String APIurl,
    File imageFile,
    BuildContext context,
  ) async {
    await UpdateBaseURL();
    final headers1 = {'Authorization': 'Bearer ${Token}'};
    final response =
        await http.MultipartRequest('POST', Uri.parse(baseURL + APIurl));
    response.headers.addAll(headers1);
    print("API =>******${baseURL + APIurl}");
    if (imageFile != null) {
      response.files
          .add(await http.MultipartFile.fromPath('image', imageFile.path));
    }
    var res = await response.send();
    print('responce stauscode-${res.statusCode.toString()}');
    if (res.statusCode == 602) {
      setLOGOUT(context);
    } else {
      var respond = await http.Response.fromStream(res);
      print('responsData-${respond.body}');
      return respond;
    }
  }

  multipartFileWith1(
    String APIurl,
    List<File> imageFile,
    BuildContext context,
  ) async {
    await UpdateBaseURL();
    final headers1 = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${Token}'
    };
    final response =
        await http.MultipartRequest('POST', Uri.parse(baseURL + APIurl));
    print("API =>******${baseURL + APIurl}");
    if (imageFile.isNotEmpty) {
      imageFile.forEach((element) async {
        response.files
            .add(await http.MultipartFile.fromPath('document', element.path));
      });
    }
    response.headers.addAll(headers1);
    var res = await response.send();
    print('responce stauscode-${res.statusCode.toString()}');
    if (res.statusCode == 602) {
      setLOGOUT(context);
    } else {
      var respond = await http.Response.fromStream(res);
      print('responsData-${respond.body}');
      return respond;
    }
  }
}

setLOGOUT(BuildContext context) async {
  var height = MediaQuery.of(context).size.height;
  var width = MediaQuery.of(context).size.width;

  Future.delayed(const Duration(seconds: 2), () async {
    // Navigator.pop(context);
    print("please again login");
    await setLogOut(context);
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
  });
  await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return WillPopScope(
          onWillPop: () async => false,
          child: Dialog(
            elevation: 0,
            backgroundColor: Colors.transparent,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            child: Container(
              height: height / 2,
              width: width,
              // color: Colors.white,
              child: Column(
                children: [
                  Image.asset(
                    ImageConstant.alertimage,
                    height: height / 4.8,
                    width: width,
                    fit: BoxFit.fill,
                  ),
                  Container(
                    height: height / 7,
                    width: width,
                    color: Colors.white,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "Please Login Again !",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            color: ColorConstant.primary_color,
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          "Please Login Again, Thank You!",
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 15,
                              color: Colors.black),
                        ),
                        Text(
                          "",
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 15,
                              color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      height: 45,
                      width: width,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(10),
                              bottomRight: Radius.circular(10)),
                          color: ColorConstant.primary_color),
                      child: Center(
                          child: Text(
                        "Logout",
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 17,
                          color: Colors.white,
                        ),
                      )),
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      });
}

setLogOut(BuildContext context) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.clear();
  await Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => SplashScreen()),
      (route) => false);
}
