import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:pds/API/ApiService/ApiService.dart';
import 'package:pds/API/Const/const.dart';
import 'package:pds/Market_place/commenModel/apiDataGet.dart';

class ApiMethod {
  ApiServices apiServices = ApiServices();
  Future<dynamic> isMobileNoExists(
      String apiUrl, Map<String, dynamic> params, BuildContext context) async {
    final responce =
        await apiServices.postApiwithOutToken(apiUrl, params, context);
    var jsonString = json.decode(responce.body);
    log('isMobileNoExists--${jsonString}');
    switch (responce.statusCode) {
      case 200:
        return CommenModel.fromJson(jsonString);
      case 404:
        return Config.somethingWentWrong;
      case 500:
        return Config.servernotreachable;
      case 400:
        return CommenModel.fromJson(jsonString);
      case 701:
        return Config.somethingWentWrong;
      default:
        return jsonString;
    }
  }
}
