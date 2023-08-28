import 'dart:convert';
import 'dart:io';

import 'package:pds/core/utils/internet_utils.dart';
import 'package:pds/presentation/noInterneterror/noInterNetScreen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/utils/sharedPreferences.dart';

class ApiServices {
  var baseURL = "";
  var Token = "";
  UpdateBaseURL() async {
    baseURL =
        // "https://0b8e-2405-201-200b-a0cf-4523-3bc3-2996-dc22.ngrok.io/";
        "http://192.168.29.100:8081/";
    print(baseURL);
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    Token = prefs.getString(PreferencesKey.loginJwt) ?? "";
  }

  postApiCall(
      String APIurl, Map<String, dynamic> params, BuildContext context) async {
    await UpdateBaseURL();
    print('token-$Token');
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

  getApiCall(String APIurl, BuildContext context) async {
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
      return response;
    } else {}
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

      return response;
    }
  }

  multipartFile2(String APIurl, Map<String, dynamic>? params) async {
    await UpdateBaseURL();
    var headers1 = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${Token}'
    };
    final response =
        await http.MultipartRequest('POST', Uri.parse(baseURL + APIurl));
    response.headers.addAll(headers1);
    if (params != null) {
      response.fields["document"] = params['document'] ?? "";
      response.fields["companyName"] = params['companyName'] ?? "";
      response.fields["jobProfile"] = params['jobProfile'] ?? "";
      response.fields["profile"] = params['profile'] ?? "";
      response.fields["uuid"] = params['uuid'] ?? "";
      response.fields["name"] = params['name'] ?? "";
    }
    print('response.fields-$response');
    var res = await response.send();
    print('responce stauscode-${res.statusCode.toString()}');

    var respond = await http.Response.fromStream(res);
    print('responsData-${respond.body}');
    return respond;
  }

  multipartFile(
      String APIurl, String fileName, String file, BuildContext context,
      {String? apiName, Map<String, dynamic>? params}) async {
    await UpdateBaseURL();
    print('fileApi-$file');
    print('fileName-$fileName');
    print('token-$params');

    var headers1 = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${Token}'
    };
    print("API =>******${baseURL + APIurl}");
    final response =
        await http.MultipartRequest('POST', Uri.parse(baseURL + APIurl));
    response.headers.addAll(headers1);
    if (params != null) {
      if (apiName != 'create forum') {
        response.fields["document"] = params['document'] ?? "";
        response.fields["companyName"] = params['companyName'] ?? "";
        response.fields["jobProfile"] = params['jobProfile'] ?? "";

        print('params-$params');
      }
    }

    if (apiName == 'create forum') {
      print('this is the get');
      response.files.add(await http.MultipartFile.fromPath('document', file));
    }

    print('checkdataher');
    var res = await response.send();
    print('responce stauscode-${res.statusCode.toString()}');

    var respond = await http.Response.fromStream(res);
    print('responsData-${respond.body}');
    return respond;
  }

  multipartFileUserprofile(
      String APIurl, File imageFile, BuildContext context) async {
    await UpdateBaseURL();
    final response =
        await http.MultipartRequest('POST', Uri.parse(baseURL + APIurl));
    print("API =>******${baseURL + APIurl}");
    if (imageFile != null) {
      response.files
          .add(await http.MultipartFile.fromPath('image', imageFile.path));
    }
    var res = await response.send();
    print('responce stauscode-${res.statusCode.toString()}');

    var respond = await http.Response.fromStream(res);
    print('responsData-${respond.body}');
    return respond;
  }
}
