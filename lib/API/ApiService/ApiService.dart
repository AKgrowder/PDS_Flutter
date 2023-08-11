import 'dart:convert';
import 'package:archit_s_application1/core/utils/internet_utils.dart';
import 'package:archit_s_application1/presentation/noInterneterror/noInterNetScreen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../../core/utils/sharedPreferences.dart';

class ApiServices {
  var baseURL = "";
  var Token = "";
  UpdateBaseURL() async {
    baseURL = "http://192.168.29.100:8081/";
    print(baseURL);
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    Token = prefs.getString(PreferencesKey.loginJwt) ?? "";
  }

  postApiCall(
    String APIurl,
    Map<String, dynamic> params,
  ) async {
    await UpdateBaseURL();
    final headers1 = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${Token}'
    };
    print("API =>******${baseURL + APIurl}");
    final hasInternet = await checkInternet();

    if (hasInternet == true) {
      final response = await post(Uri.parse(baseURL + APIurl),
          headers: headers1, body: json.encode(params));

      return response;
    } else {}
  }

  getApiCall(String APIurl, {context}) async {
    await UpdateBaseURL();
    print("API => ******** ${baseURL + APIurl}");
    final hasInternet = await checkInternet();
    if (hasInternet == true) {
      final response = await get(
        Uri.parse(baseURL + APIurl), /*  headers: headers1 */
      );
      return response;
    } else {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => NoInterNetScreen()));
    }
  }

  getApiCallWithToken(
    String APIurl,
  ) async {
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
      return response;
    } else {}
  }

  postApiCalla(
    String APIurl,
  ) async {
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

      return response;
    }
  }

  multipartFile(
      String APIurl,  String file, String fileName,
      {String? apiName,Map<String, dynamic>? params}) async {
    await UpdateBaseURL();
    print('fileApi-$file');
    print('fileName-$fileName');
    print('token-$params');

    var headers1 = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${Token}'
    };
    //http://192.168.29.100:8081/user/api/addUserProfile;
    print("API =>******${baseURL + APIurl}");
    final response =
        await http.MultipartRequest('POST', Uri.parse(baseURL + APIurl));
    response.headers.addAll(headers1);
    if (params != null) {
      if (apiName != 'create forum') {
        response.fields["companyName"] = params['companyName'] ?? "";
        response.fields["jobProfile"] = params['jobProfile'] ?? "";
      }
    }

    if (fileName != "" && fileName != null) {
      response.files
          .add(await http.MultipartFile.fromPath('document', fileName));
    }
    print('checkdataher');
    var res = await response.send();
    print('responce stauscode-${res.statusCode.toString()}');

    var respond = await http.Response.fromStream(res);
    print('responsData-${respond.body}');
    return respond;
  }
}
