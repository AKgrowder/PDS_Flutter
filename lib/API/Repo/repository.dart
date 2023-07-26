import 'dart:convert';
import '../ApiService/ApiService.dart';
import '../Const/const.dart';
import '../Model/AddThread/CreateRoom_Model.dart';
import '../Model/HomeScreenModel/PublicRoomModel.dart';
import '../Model/SendMSG/SendMSG_Model.dart';

class Repository {
  ApiServices apiServices = ApiServices();
  
  

  Future<PublicRoomModel> FetchAllPublicRoom() async {
    final response = await apiServices.getApiCall(Config.FetchAllPublicRoom);
    var jsonString = json.decode(response.body);
    print(jsonString);
    switch (response.statusCode) {
      case 200:
        return PublicRoomModel.fromJson(jsonString);
      default:
        return PublicRoomModel.fromJson(jsonString);
    }
  }

  Future<CreatPublicRoomModel> CreatPublicRoom(Map<String, String> params) async {
    final response = await apiServices.postApiCall(Config.CreateRoom, params);
    var jsonString = json.decode(response.body);
    print(jsonString);
    switch (response.statusCode) {
      case 200:
        return CreatPublicRoomModel.fromJson(jsonString);
      default:
        return CreatPublicRoomModel.fromJson(jsonString);
    }
  }

    Future<sendMSGModel> SendMSG(String Room_ID,String MSG) async {
    final response = await apiServices.postApiCalla("${Config.SendMSG}/${Room_ID}/${MSG}");
    var jsonString = json.decode(response.body);
    print(jsonString);
    switch (response.statusCode) {
      case 200:
        return sendMSGModel.fromJson(jsonString);
      default:
        return sendMSGModel.fromJson(jsonString);
    }
  }
}
