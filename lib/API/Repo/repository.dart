import 'dart:convert';
import 'package:archit_s_application1/API/Model/authModel/getUserDetailsMdoel.dart';
import 'package:archit_s_application1/API/Model/authModel/loginModel.dart';
import 'package:archit_s_application1/API/Model/authModel/registerModel.dart';
import 'package:archit_s_application1/API/Model/otpmodel/otpmodel.dart';

import '../ApiService/ApiService.dart';
import '../Const/const.dart';
import '../Model/AddThread/CreateRoom_Model.dart';
import '../Model/CreateRoomModel/CreateRoom_Model.dart';
import '../Model/GetAllPrivateRoom/GetAllPrivateRoom_Model.dart';
import '../Model/HomeScreenModel/PublicRoomModel.dart';
import '../Model/SendMSG/SendMSG_Model.dart';
import '../Model/coment/coment_model.dart';
import '../Model/creat_form/creat_form_Model.dart';

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

  // Future<CreatPublicRoomModel> loginApi() async {
  //   final response = await apiServices.postApiCall();
  //   var jsonString = json.decode(response.body);
  //   print(jsonString);
  //   switch (response.statusCode) {
  //     case 200:
  //       return CreatPublicRoomModel.fromJson(jsonString);
  //     default:
  //       return CreatPublicRoomModel.fromJson(jsonString);
  //   }
  // }

  Future<CreatPublicRoomModel> CreatPublicRoom(
      Map<String, String> params) async {
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

  Future<LoginModel> loginApi(Map<String, String> params) async {
    final response = await apiServices.postApiCall(Config.loginApi, params);
    var jsonString = json.decode(response.body);
    print('jsonString-$jsonString');
    switch (response.statusCode) {
      case 200:
        return LoginModel.fromJson(jsonString);
      default:
        return LoginModel.fromJson(jsonString);
    }
  }

  Future<RegisterClass> registerApi(Map<String, String> params) async {
    final response = await apiServices.postApiCall(Config.registerApi, params);
    var jsonString = json.decode(response.body);
    print('jsonString-$jsonString');
    switch (response.statusCode) {
      case 200:
        return RegisterClass.fromJson(jsonString);
      default:
        return RegisterClass.fromJson(jsonString);
    }
  }

  Future<OtpModel> otpModel(String userNumber, String OTP) async {
    final response =
        await apiServices.getApiCall('${Config.otpApi}/${OTP}/${userNumber}');
    var jsonString = json.decode(response.body);
    print('jsonString-$jsonString');
    switch (response.statusCode) {
      case 200:
        return OtpModel.fromJson(jsonString);
      default:
        return OtpModel.fromJson(jsonString);
    }
  }

  Future<GetUserDataModel> getUsrApi(String userId) async {
    final response =
        await apiServices.getApiCall('${Config.getUserDetails}/${userId}');
    var jsonString = json.decode(response.body);
    print('jsonString-$jsonString');
    switch (response.statusCode) {
      case 200:
        return GetUserDataModel.fromJson(jsonString);
      default:
        return GetUserDataModel.fromJson(jsonString);
    }
  }

  Future<sendMSGModel> SendMSG(String Room_ID, String MSG) async {
    final response =
        await apiServices.postApiCalla("${Config.SendMSG}/${Room_ID}/${MSG}");
    var jsonString = json.decode(response.body);
    print('jsonString$jsonString');
    switch (response.statusCode) {
      case 200:
        return sendMSGModel.fromJson(jsonString);
      default:
        return sendMSGModel.fromJson(jsonString);
    }
  }

  Future<ComentApiModel> commentApi(
      String Room_ID, String pageNumber, String pageCount) async {
    final response = await apiServices
        .getApiCall("${Config.coomment}/${Room_ID}/${pageNumber}/${pageCount}");
    print(response);
    var jsonString = json.decode(response.body);
    switch (response.statusCode) {
      case 200:
        return ComentApiModel.fromJson(jsonString);
      default:
        return ComentApiModel.fromJson(jsonString);
    }
  }

  Future<GetAllPrivateRoomModel> GetAllPrivateRoom() async {
    final response = await apiServices.getApiCallWithToken("${Config.FetchMyRoom}");
    print(response);
    var jsonString = json.decode(response.body);
    switch (response.statusCode) {
      case 200:
        return GetAllPrivateRoomModel.fromJson(jsonString);
      default:
        return GetAllPrivateRoomModel.fromJson(jsonString);
    }
  }


    Future<CreateRoomModel> CreateRoomAPI(
      Map<String, String> params) async {
    final response = await apiServices.postApiCall(Config.createRoom, params);
    var jsonString = json.decode(response.body);
    print(jsonString);
    switch (response.statusCode) {
      case 200:
        return CreateRoomModel.fromJson(jsonString);
      default:
        return CreateRoomModel.fromJson(jsonString);
    }
  }

    Future<CreateForm> creatFourm(
    String token,
    Map<String, dynamic> params,
    String file,
    String fileName,
  ) async {
    final response = await apiServices.multipartFile(
        Config.company, token, params, file,fileName);
    var jsonString = json.decode(response.body);
    print('jsonString-$jsonString');
    switch (response.statusCode) {
      case 200:
        return CreateForm.fromJson(jsonString);
      default:
        return CreateForm.fromJson(jsonString);
    }
  }
}
