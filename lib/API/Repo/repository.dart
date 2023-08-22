import 'dart:convert';
import 'dart:io';

import 'package:archit_s_application1/API/Model/AddExportProfileModel/AddExportProfileModel.dart';
import 'package:archit_s_application1/API/Model/FetchExprtiseModel/fetchExprtiseModel.dart';
import 'package:archit_s_application1/API/Model/authModel/getUserDetailsMdoel.dart';
import 'package:archit_s_application1/API/Model/authModel/loginModel.dart';
import 'package:archit_s_application1/API/Model/authModel/registerModel.dart';
import 'package:archit_s_application1/API/Model/checkUserStatusModel/chekuserStausModel.dart';
import 'package:archit_s_application1/API/Model/createDocumentModel/createDocumentModel.dart';
import 'package:archit_s_application1/API/Model/otpmodel/otpmodel.dart';
import 'package:archit_s_application1/API/Model/sherInviteModel/sherinviteModel.dart';
import 'package:flutter/cupertino.dart';

import '../ApiService/ApiService.dart';
import '../Const/const.dart';
import '../Model/AddThread/CreateRoom_Model.dart';
import '../Model/CreateRoomModel/CreateRoom_Model.dart';
import '../Model/Edit_room_model/edit_room_model.dart';
import '../Model/FatchAllMembers/fatchallmembers_model.dart';
import '../Model/GetAllPrivateRoom/GetAllPrivateRoom_Model.dart';
import '../Model/HomeScreenModel/PublicRoomModel.dart';
import '../Model/InvitationModel/Invitation_Model.dart';
import '../Model/SendMSG/SendMSG_Model.dart';
import '../Model/acceptRejectInvitaionModel/acceptRejectInvitaion.dart';
import '../Model/coment/coment_model.dart';
import '../Model/creat_form/creat_form_Model.dart';
import '../Model/delete_room_model/Delete_room_model.dart';

import '../Model/FetchAllExpertsModel/FetchAllExperts_Model.dart';
import '../Model/deviceInfo/deviceInfo_model.dart';

class Repository {
  ApiServices apiServices = ApiServices();

  Future<PublicRoomModel> FetchAllPublicRoom({context}) async {
    final response = await apiServices.getApiCall(Config.FetchAllPublicRoom,
        context: context);
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
  Future<FetchExprtise> fetchExprtise() async {
    final response = await apiServices.getApiCall(Config.fetchExprtise);
    var jsonString = json.decode(response.body);
    print(jsonString);
    switch (response.statusCode) {
      case 200:
        return FetchExprtise.fromJson(jsonString);
      default:
        return FetchExprtise.fromJson(jsonString);
    }
  }

  Future<FatchAllMembersModel> FatchAllMembersAPI(
    String Roomuid,
  ) async {
    final response = await apiServices
        .getApiCallWithToken("${Config.fetchallmembers}${Roomuid}");
    print(response);
    var jsonString = json.decode(response.body);
    switch (response.statusCode) {
      case 200:
        return FatchAllMembersModel.fromJson(jsonString);
      default:
        return FatchAllMembersModel.fromJson(jsonString);
    }
  }

  Future<AddExpertProfile> addEXpertAPiCaling(
    params,
  ) async {
    final response = await apiServices.postApiCall(Config.addExport, params);
    var jsonString = json.decode(response.body);
    print(jsonString);
    switch (response.statusCode) {
      case 200:
        return AddExpertProfile.fromJson(jsonString);
      default:
        return AddExpertProfile.fromJson(jsonString);
    }
  }

  Future<InvitationModel> InvitationModelAPI() async {
    final response = await apiServices.getApiCallWithToken(Config.Invitations);
    print(response);
    var jsonString = json.decode(response.body);
    switch (response.statusCode) {
      case 200:
        return InvitationModel.fromJson(jsonString);
      default:
        return InvitationModel.fromJson(jsonString);
    }
  }

//http://192.168.29.100:8081/user/addExpertProfile
//http://192.168.29.100:8081/user/addExpertProfile
  Future<CreatPublicRoomModel> CreatPublicRoom(
    Map<String, String> params,
  ) async {
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

  Future<LoginModel> loginApi(
    Map<String, dynamic> params,
  ) async {
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

  Future<RegisterClass> registerApi(
    Map<String, String> params,
  ) async {
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

  Future<OtpModel> otpModel(
    String userNumber,
    String OTP,
  ) async {
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

  Future<GetUserDataModel> getUsrApi(
    String userId,
  ) async {
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

  Future<sendMSGModel> SendMSG(
    String Room_ID,
    String MSG,
  ) async {
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
    String Room_ID,
    String pageNumber,
    String pageCount,
  ) async {
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
    final response =
        await apiServices.getApiCallWithToken("${Config.FetchMyRoom}");
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
    Map<String, String> params,
  ) async {
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

  Future<SherInvite> sherInvite(
    String userRoomId,
    String email,
  ) async {
    final response = await apiServices
        .getApiCallWithToken("${Config.inviteUser}/${userRoomId}/${email}");
    var jsonString = json.decode(response.body);
    print(jsonString);
    switch (response.statusCode) {
      case 200:
        return SherInvite.fromJson(jsonString);
      default:
        return SherInvite.fromJson(jsonString);
    }
  }

  Future<CreateForm> creatFourm(
    Map<String, dynamic> params,
    String file,
    String fileName,
  ) async {
    final response = await apiServices
        .multipartFile(Config.company, file, fileName, params: params);
    var jsonString = json.decode(response.body);
    print('jsonString-$jsonString');
    switch (response.statusCode) {
      case 200:
        return CreateForm.fromJson(jsonString);
      default:
        return CreateForm.fromJson(jsonString);
    }
  }

  Future<FetchAllExpertsModel> FetchAllExpertsAPI({context}) async {
    final response =
        await apiServices.getApiCall(Config.fetchAllExperts, context: context);
    var jsonString = json.decode(response.body);
    print(jsonString);
    switch (response.statusCode) {
      case 200:
        return FetchAllExpertsModel.fromJson(jsonString);
      default:
        return FetchAllExpertsModel.fromJson(jsonString);
    }
  }

  Future<EditRoomModel> EditroomAPI(
    Map<String, dynamic> param,
    String roomuId,
  ) async {
    final response =
        await apiServices.postApiCall('${Config.editroom}/${roomuId}', param);
    var jsonString = json.decode(response.body);
    print(jsonString);
    switch (response.statusCode) {
      case 200:
        return EditRoomModel.fromJson(jsonString);
      default:
        return EditRoomModel.fromJson(jsonString);
    }
  }

  Future<AcceptRejectInvitationModel> acceptRejectInvitationAPI(
    bool status,
    String roomLink,
  ) async {
    final response = await apiServices.getApiCallWithToken(
        '${Config.acceptRejectInvitationAPI}/${status}/${roomLink}');
    print(response);
    var jsonString = json.decode(response.body);
    switch (response.statusCode) {
      case 200:
        return AcceptRejectInvitationModel.fromJson(jsonString);
      default:
        return AcceptRejectInvitationModel.fromJson(jsonString);
    }
  }

  Future<DeleteRoomModel> DeleteRoomApi(
    String roomuId,
  ) async {
    final response = await apiServices
        .getApiCallWithToken("${Config.DeleteRoom}/${roomuId}");
    print(response);
    var jsonString = json.decode(response.body);
    switch (response.statusCode) {
      case 200:
        return DeleteRoomModel.fromJson(jsonString);
      default:
        return DeleteRoomModel.fromJson(jsonString);
    }
  }

  Future<CheckUserStausModel> checkUserActive() async {
    final response =
        await apiServices.getApiCallWithToken("${Config.checkUserActive}");
    var jsonString = json.decode(response.body);
    switch (response.statusCode) {
      case 200:
        return CheckUserStausModel.fromJson(jsonString);
      default:
        return CheckUserStausModel.fromJson(jsonString);
    }
  }

  chooseProfileFile(String file, String fileName, {params}) async {
    print("apiCaling");
    final response = await apiServices.multipartFile(
        "${Config.uploadfile}", file, fileName,
        apiName: 'create forum', params: params);
    var jsonString = json.decode(response.body);
    print(jsonString);
    switch (response.statusCode) {
      case 200:
        return ChooseDocument.fromJson(jsonString);
      default:
        return ChooseDocument.fromJson(jsonString);
    }
  }

  userProfile(File imageFile) async {
    final response = await apiServices.multipartFileUserprofile(
        '${Config.uploadProfile}', imageFile);
    var jsonString = json.decode(response.body);
    print(jsonString);
    switch (response.statusCode) {
      case 200:
        return ChooseDocument.fromJson(jsonString);
      default:
        return ChooseDocument.fromJson(jsonString);
    }
  }
  Future<DeviceinfoModel> deviceInfoq(
    Map<String, dynamic> param, 
  ) async {
    final response =
        await apiServices.postApiCall(Config.addDeviceDetail,param);
    var jsonString = json.decode(response.body);
    print(jsonString);
    switch (response.statusCode) {
      case 200:
        return DeviceinfoModel.fromJson(jsonString);
      default:
        return DeviceinfoModel.fromJson(jsonString);
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