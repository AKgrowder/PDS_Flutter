import 'dart:convert';
import 'package:http/http.dart';

class ApiServices {
  var baseURL = "";
  UpdateBaseURL() async {
    baseURL = "https://e43c-2405-201-200b-a0cf-58b4-abbd-2efc-3953.ngrok.io/";
    print(baseURL);
  }

  Future<Response> postApiCall(
    String APIurl,
    Map<String, dynamic> params,
  ) async {
    UpdateBaseURL();
    print("API =>******${baseURL + APIurl}");
    final response = await post(Uri.parse(baseURL + APIurl),
        /* headers: headers1, */ body: json.encode(params));

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
}
