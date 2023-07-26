import 'dart:convert';
import '../ApiService/ApiService.dart';
import '../Const/const.dart';
import '../Model/HomeScreenModel/PublicRoomModel.dart';

class Repository {
  ApiServices apiServices = ApiServices();

  Future<PublicRoomModel> FetchAllPublicRoom() async {
    final response =
        await apiServices.getApiCall(Config.FetchAllPublicRoom);
    var jsonString = json.decode(response.body);
    print(jsonString);
    switch (response.statusCode) {
      case 200:
        return PublicRoomModel.fromJson(jsonString);
      default:
        return PublicRoomModel.fromJson(jsonString);
    }
  }
}
