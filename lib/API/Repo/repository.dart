import 'dart:convert';
import 'dart:io';

import 'package:pds/API/Model/AddExportProfileModel/AddExportProfileModel.dart';
import 'package:pds/API/Model/FetchExprtiseModel/fetchExprtiseModel.dart';
import 'package:pds/API/Model/authModel/getUserDetailsMdoel.dart';
import 'package:pds/API/Model/authModel/loginModel.dart';
import 'package:pds/API/Model/authModel/registerModel.dart';
import 'package:pds/API/Model/checkUserStatusModel/chekuserStausModel.dart';
import 'package:pds/API/Model/createDocumentModel/createDocumentModel.dart';
import 'package:pds/API/Model/deviceInfo/deviceInfo_model.dart';
import 'package:pds/API/Model/otpmodel/otpmodel.dart';
import 'package:pds/API/Model/sherInviteModel/sherinviteModel.dart';
import 'package:flutter/cupertino.dart';

import '../ApiService/ApiService.dart';
import '../Const/const.dart';
import '../Model/AddThread/CreateRoom_Model.dart';
import '../Model/CreateRoomModel/CreateRoom_Model.dart';
import '../Model/Edit_room_model/edit_room_model.dart';
import '../Model/FatchAllMembers/fatchallmembers_model.dart';
import '../Model/FetchAllExpertsModel/FetchAllExperts_Model.dart';
import '../Model/GetAllPrivateRoom/GetAllPrivateRoom_Model.dart';
import '../Model/HomeScreenModel/PublicRoomModel.dart';
import '../Model/InvitationModel/Invitation_Model.dart';
import '../Model/SendMSG/SendMSG_Model.dart';
import '../Model/System_Config_model/system_config_model.dart';
import '../Model/acceptRejectInvitaionModel/acceptRejectInvitaion.dart';
import '../Model/coment/coment_model.dart';
import '../Model/creat_form/creat_form_Model.dart';
import '../Model/delete_room_model/Delete_room_model.dart';
import '../Model/fetch_room_detail_model/fetch_room_detail_model.dart';
import '../Model/myaccountModel/myaccountModel.dart';

class Repository {
  ApiServices apiServices = ApiServices();

  FetchAllPublicRoom(BuildContext context) async {
    final response =
        await apiServices.getApiCall(Config.FetchAllPublicRoom, context);
    var jsonString = json.decode(response.body);
    print(jsonString);
    switch (response.statusCode) {
      case 200:
        return PublicRoomModel.fromJson(jsonString);
      case 404:
        return Config.somethingWentWrong;
      case 500:
        return Config.servernotreachable;

      default:
        return jsonString;
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
  //       return CreatPublicRoomModel.fromJson(jsonString);:129
  //   }
  // }
  fetchExprtise(BuildContext context) async {
    final response =
        await apiServices.getApiCall(Config.fetchExprtise, context);
    var jsonString = json.decode(response.body);
    print(jsonString);
    switch (response.statusCode) {
      case 200:
        return FetchExprtise.fromJson(jsonString);
      case 404:
        return Config.somethingWentWrong;
      case 500:
        return Config.servernotreachable;

      default:
        return jsonString;
    }
  }

  FatchAllMembersAPI(String Roomuid, BuildContext context) async {
    final response = await apiServices.getApiCallWithToken(
        "${Config.fetchallmembers}${Roomuid}", context);
    print(response);
    var jsonString = json.decode(response.body);
    switch (response.statusCode) {
      case 200:
        return FatchAllMembersModel.fromJson(jsonString);
      case 404:
        return Config.somethingWentWrong;
      case 500:
        return Config.servernotreachable;

      default:
        return jsonString;
    }
  }

  addEXpertAPiCaling(params, BuildContext context) async {
    final response =
        await apiServices.postApiCall(Config.addExport, params, context);
    var jsonString = json.decode(response.body);
    print(jsonString);
    switch (response.statusCode) {
      case 200:
        return AddExpertProfile.fromJson(jsonString);
      case 404:
        return Config.somethingWentWrong;
      case 500:
        return Config.servernotreachable;

      default:
        return jsonString;
    }
  }

  InvitationModelAPI(BuildContext context) async {
    final response =
        await apiServices.getApiCallWithToken(Config.Invitations, context);
    print(response);
    var jsonString = json.decode(response.body);
    switch (response.statusCode) {
      case 200:
        return InvitationModel.fromJson(jsonString);
      case 404:
        return Config.somethingWentWrong;
      case 500:
        return Config.servernotreachable;

      default:
        return jsonString;
    }
  }

//http://192.168.29.100:8081/user/addExpertProfile
//http://192.168.29.100:8081/user/addExpertProfile
  CreatPublicRoom(Map<String, String> params, BuildContext context) async {
    final response =
        await apiServices.postApiCall(Config.CreateRoom, params, context);
    var jsonString = json.decode(response.body);
    print(jsonString);
    switch (response.statusCode) {
      case 200:
        return CreatPublicRoomModel.fromJson(jsonString);
      case 404:
        return Config.somethingWentWrong;
      case 500:
        return Config.servernotreachable;

      default:
        return jsonString;
    }
  }

  loginApi(Map<String, dynamic> params, BuildContext context) async {
    final response =
        await apiServices.postApiCall(Config.loginApi, params, context);
    var jsonString = json.decode(response.body);
    print('jsonString-$jsonString');
    switch (response.statusCode) {
      case 200:
        return LoginModel.fromJson(jsonString);
      case 404:
        return Config.somethingWentWrong;
      case 500:
        return Config.servernotreachable;

      default:
        return LoginModel.fromJson(jsonString);
    }
  }

  registerApi(Map<String, String> params, BuildContext context) async {
    final response =
        await apiServices.postApiCall(Config.registerApi, params, context);
    var jsonString = json.decode(response.body);
    print('jsonString-$jsonString');
    switch (response.statusCode) {
      case 200:
        return RegisterClass.fromJson(jsonString);
      case 404:
        return Config.somethingWentWrong;
      case 500:
        return Config.servernotreachable;

      default:
        return jsonString;
    }
  }

  otpModel(String userNumber, String OTP, BuildContext context) async {
    final response = await apiServices.getApiCall(
        '${Config.otpApi}/${OTP}/${userNumber}', context);
    var jsonString = json.decode(response.body);
    print('jsonString-$jsonString');
    switch (response.statusCode) {
      case 200:
        return OtpModel.fromJson(jsonString);
      case 404:
        return Config.somethingWentWrong;
      case 500:
        return Config.servernotreachable;

      default:
        return jsonString;
    }
  }

  getUsrApi(String userId, BuildContext context) async {
    final response = await apiServices.getApiCall(
        '${Config.getUserDetails}/${userId}', context);
    var jsonString = json.decode(response.body);
    print('jsonString-$jsonString');
    switch (response.statusCode) {
      case 200:
        return GetUserDataModel.fromJson(jsonString);
      case 404:
        return Config.somethingWentWrong;
      case 500:
        return Config.servernotreachable;

      default:
        return jsonString;
    }
  }

  SendMSG(String Room_ID, String MSG, BuildContext context) async {
    final response = await apiServices.postApiCalla(
        "${Config.SendMSG}/${Room_ID}/${MSG}", context);
    var jsonString = json.decode(response.body);
    print('jsonString$jsonString');
    switch (response.statusCode) {
      case 200:
        return sendMSGModel.fromJson(jsonString);
      case 404:
        return Config.somethingWentWrong;
      case 500:
        return Config.servernotreachable;

      default:
        return jsonString;
    }
  }

  commentApi(String Room_ID, String pageNumber, String pageCount,
      BuildContext context) async {
    final response = await apiServices.getApiCall(
        "${Config.coomment}/${Room_ID}/${pageNumber}/${pageCount}", context);
    print(response);
    var jsonString = json.decode(response.body);
    switch (response.statusCode) {
      case 200:
        return ComentApiModel.fromJson(jsonString);
      case 404:
        return Config.somethingWentWrong;
      case 500:
        return Config.servernotreachable;

      default:
        return jsonString;
    }
  }

  GetAllPrivateRoom(BuildContext context) async {
    final response =
        await apiServices.getApiCallWithToken("${Config.FetchMyRoom}", context);
    print(response);
    var jsonString = json.decode(response.body);
    switch (response.statusCode) {
      case 200:
        return GetAllPrivateRoomModel.fromJson(jsonString);
      case 404:
        return Config.somethingWentWrong;
      case 500:
        return Config.servernotreachable;

      default:
        return jsonString;
    }
  }

  CreateRoomAPI(Map<String, String> params, BuildContext context) async {
    final response =
        await apiServices.postApiCall(Config.createRoom, params, context);
    var jsonString = json.decode(response.body);
    print(jsonString);
    switch (response.statusCode) {
      case 200:
        return CreateRoomModel.fromJson(jsonString);
      case 404:
        return Config.somethingWentWrong;
      case 500:
        return Config.servernotreachable;

      default:
        return jsonString;
    }
  }

  sherInvite(String userRoomId, String email, BuildContext context) async {
    final response = await apiServices.getApiCallWithToken(
        "${Config.inviteUser}/${userRoomId}/${email}", context);
    var jsonString = json.decode(response.body);
    print(jsonString);
    switch (response.statusCode) {
      case 200:
        return SherInvite.fromJson(jsonString);
      case 404:
        return Config.somethingWentWrong;
      case 500:
        return Config.servernotreachable;

      default:
        return jsonString;
    }
  }

  creatFourm(Map<String, dynamic> params, String file, String fileName,
      BuildContext context) async {
    final response = await apiServices
        .multipartFile(Config.company, file, fileName, context, params: params);
    var jsonString = json.decode(response.body);
    print('jsonString-$jsonString');
    switch (response.statusCode) {
      case 200:
        return CreateForm.fromJson(jsonString);
      case 404:
        return Config.somethingWentWrong;
      case 500:
        return Config.servernotreachable;

      default:
        return jsonString;
    }
  }

  FetchAllExpertsAPI(BuildContext context) async {
    final response =
        await apiServices.getApiCall(Config.fetchAllExperts, context);
    var jsonString = json.decode(response.body);
    print(jsonString);
    switch (response.statusCode) {
      case 200:
        return FetchAllExpertsModel.fromJson(jsonString);
      case 404:
        return Config.somethingWentWrong;
      case 500:
        return Config.servernotreachable;

      default:
        return jsonString;
    }
  }

  EditroomAPI(
      Map<String, dynamic> param, String roomuId, BuildContext context) async {
    final response = await apiServices.postApiCall(
        '${Config.editroom}/${roomuId}', param, context);
    var jsonString = json.decode(response.body);
    print(jsonString);
    switch (response.statusCode) {
      case 200:
        return EditRoomModel.fromJson(jsonString);
      case 404:
        return Config.somethingWentWrong;
      case 500:
        return Config.servernotreachable;

      default:
        return jsonString;
    }
  }

  acceptRejectInvitationAPI(
      bool status, String roomLink, BuildContext context) async {
    final response = await apiServices.getApiCallWithToken(
        '${Config.acceptRejectInvitationAPI}/${status}/${roomLink}', context);
    print(response);
    var jsonString = json.decode(response.body);
    switch (response.statusCode) {
      case 200:
        return AcceptRejectInvitationModel.fromJson(jsonString);
      case 404:
        return Config.somethingWentWrong;
      case 500:
        return Config.servernotreachable;

      default:
        return jsonString;
    }
  }

  DeleteRoomApi(String roomuId, BuildContext context) async {
    final response = await apiServices.getApiCallWithToken(
        "${Config.DeleteRoom}/${roomuId}", context);
    print(response);
    var jsonString = json.decode(response.body);
    switch (response.statusCode) {
      case 200:
        return DeleteRoomModel.fromJson(jsonString);
      case 404:
        return Config.somethingWentWrong;
      case 500:
        return Config.servernotreachable;

      default:
        return jsonString;
    }
  }

  checkUserActive(BuildContext context) async {
    final response = await apiServices.getApiCallWithToken(
        "${Config.checkUserActive}", context);
    var jsonString = json.decode(response.body);
    switch (response.statusCode) {
      case 200:
        return CheckUserStausModel.fromJson(jsonString);
      case 404:
        return Config.somethingWentWrong;
      case 500:
        return Config.servernotreachable;
      case 400:
        return Config.somethingWentWrong;
      default:
        return jsonString;
    }
  }

  chooseProfileFile(String file, String fileName, BuildContext context,
      {params}) async {
    print("apiCaling");
    final response = await apiServices.multipartFile(
        "${Config.uploadfile}", file, fileName, context,
        apiName: 'create forum', params: params);
    var jsonString = json.decode(response.body);
    print(jsonString);
    switch (response.statusCode) {
      case 200:
        return ChooseDocument.fromJson(jsonString);
      case 404:
        return Config.somethingWentWrong;
      case 500:
        return Config.servernotreachable;

      default:
        return jsonString;
    }
  }

  userProfile(File imageFile, BuildContext context) async {
    final response = await apiServices.multipartFileUserprofile(
        '${Config.uploadProfile}', imageFile, context);
    var jsonString = json.decode(response.body);
    print(jsonString);
    switch (response.statusCode) {
      case 200:
        return ChooseDocument.fromJson(jsonString);
      case 404:
        return Config.somethingWentWrong;
      case 500:
        return Config.servernotreachable;

      default:
        return jsonString;
    }
  }

  deviceInfoq(Map<String, dynamic> param, BuildContext context) async {
    final response =
        await apiServices.postApiCall(Config.addDeviceDetail, param, context);
    var jsonString = json.decode(response.body);
    print(jsonString);
    switch (response.statusCode) {
      case 200:
        return DeviceinfoModel.fromJson(jsonString);
      case 404:
        return Config.somethingWentWrong;
      case 500:
        return Config.servernotreachable;

      default:
        return jsonString;
    }
  }

  cretaForumUpdate(Map<String, dynamic> params, BuildContext context) async {
    final response = await apiServices.multipartFile2(Config.company, params);
    var jsonString = json.decode(response.body);
    print('jsonString-$jsonString');
    switch (response.statusCode) {
      case 200:
        return CreateForm.fromJson(jsonString);
      case 404:
        return Config.somethingWentWrong;
      case 500:
        return Config.servernotreachable;

      default:
        return jsonString;
    }
  }

  SystemConfig(BuildContext context) async {
    final response = await apiServices.getApiCall(Config.systemconfig, context);
    var jsonString = json.decode(response.body);
    print(jsonString);
    switch (response.statusCode) {
      case 200:
        return SystemConfigModel.fromJson(jsonString);
      case 404:
        return Config.somethingWentWrong;
      case 500:
        return Config.servernotreachable;

      default:
        return jsonString;
    }
  }

  myAccount(BuildContext context) async {
    final response =
        await apiServices.getApiCallWithToken(Config.myaccountApi, context);
    var jsonString = json.decode(response.body);
    print(jsonString);
    switch (response.statusCode) {
      case 200:
        return MyAccontDetails.fromJson(jsonString);
      case 404:
        return Config.somethingWentWrong;
      case 500:
        return Config.servernotreachable;

      default:
        return jsonString;
    }
  }

  fetchRoomDetails(String userId, BuildContext context) async {
    final response = await apiServices.getApiCallWithToken(
        Config.fetchRoomDetails + userId, context);
    var jsonString = json.decode(response.body);
    print(jsonString);
    switch (response.statusCode) {
      case 200:
        return FetchRoomDetailModel.fromJson(jsonString);
      case 404:
        return Config.somethingWentWrong;
      case 500:
        return Config.servernotreachable;

      default:
        return jsonString;
    }
  }
}





// var headers = {
//   'Authorization': 'Bearer eyJhbGciOiJIUzUxMiJ9.eyJpc1ZlcmlmaWVkIjp0cnVlLCJtb2R1bGUiOiJFTVBMT1lFRSIsImlzQWN0aXZlIjp0cnVlLCJ1dWlkIjoiODYwMWViNTItNzk4NS00MWU3LTgwOTAtYmMyMjQ0MjkwZjkzIiwidXNlcm5hbWUiOiJBTiIsInN1YiI6IkFOIiwiaWF0IjoxNjkxMTUyODIxLCJleHAiOjE2OTIyMzI4MjF9.AjSlFxHlTU9opgsyXaqVh_sMQuv7f-fKGmIGle6879MD-OAGTNcPN5r9ZW8Go1124YE2BbSrc1Lj5GuspgilWg'
// };
// var request = http.Request('GET', Uri.parse('http://192.168.29.100:8081/user/api/inviteUserToRoom/9fb2816c-1604-4b78-87d1-c09a9824c691/AWS@gmail.com'));

// request.headers.addAll(headers);

// http.StreamedResponse response = await request.send();

// if (response.statusCode == 200) {
//   print(await response.stream.bytesToString());
// }
// else {
//   print(response.reasonPhrase);
// }