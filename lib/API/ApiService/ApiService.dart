import 'dart:convert';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../../core/utils/sharedPreferences.dart';

class ApiServices {
  var baseURL = "";
  var Token = "";
  UpdateBaseURL() async {
    baseURL = "http://192.168.29.102:8081/";
    print(baseURL);

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    Token = prefs.getString(PreferencesKey.loginJwt) ?? "";
  }

  Future<Response> postApiCall(
    String APIurl,
    Map<String, dynamic> params,
  ) async {
    await UpdateBaseURL();
    final headers1 = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${Token}'
    };
    print("API =>******${baseURL + APIurl}");
    final response = await post(Uri.parse(baseURL + APIurl),
        headers: headers1, body: json.encode(params));

    return response;
  }

  Future<Response> getApiCall(
    String APIurl,
  ) async {
    await UpdateBaseURL();
    print("API => ******** ${baseURL + APIurl}");

    final response = await get(
      Uri.parse(baseURL + APIurl), /*  headers: headers1 */
    );
    return response;
  }

  Future<Response> getApiCallWithToken(
    String APIurl,
  ) async {
    await UpdateBaseURL();
    final headers1 = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${Token}'
    };
    print("API => ******** ${baseURL + APIurl}");

    final response = await get(
      Uri.parse(baseURL + APIurl),
      headers: headers1,
    );
    print('respncebody-${response.body}');
    return response;
  }

  Future<Response> postApiCalla(
    String APIurl,
  ) async {
    await UpdateBaseURL();
    final headers1 = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${Token}'
    };
    print("API =>******${baseURL + APIurl}");
    final response = await post(
      Uri.parse(baseURL + APIurl),
      headers: headers1,
    );

    return response;
  }

  multipartFile(String APIurl, Map<String, dynamic> params, String file,
      String fileName) async {
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
      print('paremsget');
      response.fields["companyName"] = params['companyName'] ?? "";
      response.fields["jobProfile"] = params['jobProfile'] ?? "";
    }

    if (fileName != "" && fileName != null) {
      response.files
          .add(await http.MultipartFile.fromPath('document', fileName));
    }
    print('checkdataher');
    var res = await response.send();
    print('responce stauscode-${res.statusCode.toString()}');

    var respond = await http.Response.fromStream(res);

    return respond;
  }
}
