import 'dart:convert';
import 'package:http/http.dart';

class ApiServices {
  var baseURL = "";
  UpdateBaseURL() async {
    baseURL = "https://71b1-2405-201-200b-a0cf-8f74-41a0-82ea-8bf.ngrok.io/";
    print(baseURL);
  }

  Future<Response> postApiCall(
    String APIurl,
    Map<String, dynamic> params,
  ) async {
    UpdateBaseURL();
     final headers1 = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer '
    };
    print("API =>******${baseURL + APIurl}");
    final response = await post(Uri.parse(baseURL + APIurl),
         headers: headers1,  body: json.encode(params));

    return response;
  }

  Future<Response> getApiCall(
    String APIurl,
  ) async {
    UpdateBaseURL();
    print("API => ******** ${baseURL + APIurl}");

    final response = await get(
      Uri.parse(baseURL + APIurl), /*  headers: headers1 */
    );
    return response;
  }


  Future<Response> postApiCalla(
    String APIurl,
  ) async {
    UpdateBaseURL();
     final headers1 = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer '
    };
    print("API =>******${baseURL + APIurl}");
    final response = await post(Uri.parse(baseURL + APIurl),
         headers: headers1,);

    return response;
  }
}
