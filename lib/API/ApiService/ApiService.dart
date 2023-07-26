import 'dart:convert';
import 'package:http/http.dart';

class ApiServices {
  var baseURL = "";
  UpdateBaseURL() async {
    baseURL = "https://d327-2405-201-200b-a0cf-bfe7-72b2-491f-7ef8.ngrok.io/";
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
