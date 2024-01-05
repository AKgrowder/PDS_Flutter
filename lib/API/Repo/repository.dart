import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:pds/API/Model/DeleteUserChatModel/DeleteUserChat_Model.dart';
import 'package:pds/API/Model/GetAllInboxImagesModel/GetAllInboxImagesModel.dart';
import 'package:pds/API/Model/GetGuestAllPostModel/ShareAppOpenPostModel.dart';
import 'package:pds/API/Model/acceptRejectInvitaionModel/GetAllNotificationModel.dart';
import 'package:pds/API/Model/inboxScreenModel/SeenAllMessageModel.dart';
import 'package:pds/API/Model/selectMultipleUsers_ChatModel/selectMultipleUsers_ChatModel.dart';
import 'package:pds/API/Model/UserTagModel/UserTag_model.dart';
import 'package:pds/API/Model/GetUsersChatByUsernameModel/GetUsersChatByUsernameModel.dart';
import 'package:pds/API/Model/BlogComment_Model/BlogLikeList_model.dart';
import 'package:pds/API/Model/FollwersModel/FllowersModel.dart';
import 'package:pds/API/Model/HasTagModel/hasTagModel.dart';
import 'package:pds/API/Model/IsTokenExpired/IsTokenExpired.dart';
import 'package:pds/API/Model/OnTimeDMModel/OnTimeDMModel.dart';
import 'package:pds/API/Model/RePost_Model/RePost_model.dart';
import 'package:pds/API/Model/BlogComment_Model/BlogCommentDelete_model.dart';
import 'package:pds/API/Model/BlogComment_Model/BlogComment_model.dart';
import 'package:pds/API/Model/PersonalChatListModel/SelectChatMember_Model.dart';
import 'package:flutter/cupertino.dart';
import 'package:pds/API/Model/AddExportProfileModel/AddExportProfileModel.dart';
import 'package:pds/API/Model/Add_PostModel/Add_PostModel.dart';
import 'package:pds/API/Model/Add_PostModel/Add_postModel_Image.dart';
import 'package:pds/API/Model/Add_comment_model/add_comment_model.dart';
import 'package:pds/API/Model/CreateStory_Model/all_stories.dart';
import 'package:pds/API/Model/DeleteUserModel/DeleteUser_Model.dart';
import 'package:pds/API/Model/Delete_Api_model/delete_api_model.dart';
import 'package:pds/API/Model/FetchExprtiseModel/fetchExprtiseModel.dart';
import 'package:pds/API/Model/GetGuestAllPostModel/GetGuestAllPost_Model.dart';
import 'package:pds/API/Model/GetGuestAllPostModel/GetPostLike_Model.dart';
import 'package:pds/API/Model/Get_all_blog_Model/get_all_blog_model.dart';
import 'package:pds/API/Model/IndustrytypeModel/Industrytype_Model.dart';
import 'package:pds/API/Model/LogOutModel/LogOut_model.dart';
import 'package:pds/API/Model/NewProfileScreenModel/GetAppUserPost_Model.dart';
import 'package:pds/API/Model/NewProfileScreenModel/GetSavePost_Model.dart';
import 'package:pds/API/Model/NewProfileScreenModel/GetUserPostCommet_Model.dart';
import 'package:pds/API/Model/OpenSaveImagepostModel/OpenSaveImagepost_Model.dart';
import 'package:pds/API/Model/PersonalChatListModel/PersonalChatList_Model.dart';
import 'package:pds/API/Model/RoomExistsModel/RoomExistsModel.dart';
import 'package:pds/API/Model/System_Config_model/Tokenvalid_Model.dart';
import 'package:pds/API/Model/ViewStoryModel/ViewStory_Model.dart';
import 'package:pds/API/Model/WorkExperience_Model/DeleteExperience_model.dart';
import 'package:pds/API/Model/WorkExperience_Model/WorkExperience_model.dart';
import 'package:pds/API/Model/aboutMeModel/aboutMeModel.dart';
import 'package:pds/API/Model/acceptRejectInvitaionModel/RequestList_Model.dart';
import 'package:pds/API/Model/accountType/accountTypeModel.dart';
import 'package:pds/API/Model/deletecomment/delete_comment_model.dart';
import 'package:pds/API/Model/getAllHashtagModel/getAllHashtagModel.dart';
import 'package:pds/API/Model/getSerchDataModel/getSerchDataModel.dart';
import 'package:pds/API/Model/inboxScreenModel/inboxScrrenModel.dart';
import 'package:pds/API/Model/removeFolloweModel/removeFollowerModel.dart';
import 'package:pds/API/Model/serchDataAddModel/serchDataAddModel.dart';
import 'package:pds/API/Model/serchForInboxModel/serchForinboxModel.dart';
import 'package:pds/API/Model/storyModel/stroyModel.dart';
import 'package:pds/API/Model/HashTage_Model/HashTagView_model.dart';
import 'package:pds/API/Model/HashTage_Model/HashTag_model.dart';
import 'package:pds/API/Model/Getalluset_list_Model/get_all_userlist_model.dart';
import 'package:pds/API/Model/NewProfileScreenModel/NewProfileScreen_Model.dart';
import 'package:pds/API/Model/RateUseModel/Rateuse_model.dart';
import 'package:pds/API/Model/UserReActivateModel/UserReActivate_model.dart';
import 'package:pds/API/Model/ViewDetails_Model/ViewDetails_model.dart';
import 'package:pds/API/Model/authModel/getUserDetailsMdoel.dart';
import 'package:pds/API/Model/authModel/loginModel.dart';
import 'package:pds/API/Model/authModel/registerModel.dart';
import 'package:pds/API/Model/checkUserStatusModel/chekuserStausModel.dart';
import 'package:pds/API/Model/createDocumentModel/createDocumentModel.dart';
import 'package:pds/API/Model/createStroyModel/createStroyModel.dart';
import 'package:pds/API/Model/deviceInfo/deviceInfo_model.dart';
import 'package:pds/API/Model/emailVerfiaction/emailVerfiaction.dart';
import 'package:pds/API/Model/forget_password_model/forget_password_model.dart';
import 'package:pds/API/Model/getCountOfSavedRoomModel/getCountOfSavedRoomModel.dart';
import 'package:pds/API/Model/like_Post_Model/like_Post_Model.dart';
import 'package:pds/API/Model/otpmodel/otpmodel.dart';
import 'package:pds/API/Model/pinAndUnpinModel/pinAndUnpinModel.dart';
import 'package:pds/API/Model/sherInviteModel/sherinviteModel.dart';
import 'package:pds/API/Model/updateprofileModel/updateprofileModel.dart';
import 'package:pds/core/utils/sharedPreferences.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../ApiService/ApiService.dart';
import '../Const/const.dart';
import '../Model/AddThread/CreateRoom_Model.dart';
import '../Model/CreateRoomModel/CreateRoom_Model.dart';
import '../Model/Edit_room_model/edit_room_model.dart';
import '../Model/FatchAllMembers/fatchallmembers_model.dart';
import '../Model/FetchAllExpertsModel/FetchAllExperts_Model.dart';
import '../Model/GetAllPrivateRoom/GetAllPrivateRoom_Model.dart';
import '../Model/HomeScreenModel/MyPublicRoom_model.dart';
import '../Model/HomeScreenModel/PublicRoomModel.dart';
import '../Model/HomeScreenModel/getLoginPublicRoom_model.dart';
import '../Model/InvitationModel/Invitation_Model.dart';
import '../Model/SelectRoomModel/SelectRoom_Model.dart';
import '../Model/SendMSG/SendMSG_Model.dart';
import '../Model/System_Config_model/fetchUserModule_model.dart';
import '../Model/System_Config_model/system_config_model.dart';
import '../Model/ViewDetails_Model/RemoveMember_model.dart';
import '../Model/WorkExperience_Model/ADDExperience_model.dart';
import '../Model/acceptRejectInvitaionModel/acceptRejectInvitaion.dart';
import '../Model/coment/coment_model.dart';
import '../Model/creat_form/creat_form_Model.dart';
import '../Model/delete_room_model/Delete_room_model.dart';
import '../Model/fetch_room_detail_model/fetch_room_detail_model.dart';
import '../Model/forget_password_model/change_password_model.dart';
import '../Model/myaccountModel/myaccountModel.dart';
import 'package:pds/API/Model/acceptRejectInvitaionModel/accept_rejectModel.dart';
import 'package:pds/API/Model/HashTage_Model/HashTagBanner_model.dart';
import 'package:pds/API/Model/saveBlogModel/saveBlog_Model.dart';
import 'package:pds/API/Model/saveAllBlogModel/saveAllBlog_Model.dart';
import 'package:pds/API/Model/ViewStoryModel/StoryViewList_Model.dart';
import 'package:pds/API/Model/storyDeleteModel/storyDeleteModel.dart';
import 'package:pds/API/Model/acceptRejectInvitaionModel/seenNotificationModel.dart';
import 'package:pds/API/Model/acceptRejectInvitaionModel/getAllNotificationCount.dart';

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
      case 400:
        return Config.somethingWentWrong;
      case 404:
        return Config.somethingWentWrong;
      case 500:
        return Config.servernotreachable;
      case 701:
        return Config.somethingWentWrong;
      default:
        return jsonString;
    }
  }

  fetchExprtise(BuildContext context) async {
    final response =
        await apiServices.getApiCall(Config.fetchExprtise, context);
    var jsonString = json.decode(response.body);
    print(jsonString);
    switch (response.statusCode) {
      case 200:
        return FetchExprtise.fromJson(jsonString);
      case 400:
        return Config.somethingWentWrong;
      case 404:
        return Config.somethingWentWrong;
      case 500:
        return Config.servernotreachable;
      case 701:
        return Config.somethingWentWrong;
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
      case 400:
        return Config.somethingWentWrong;
      case 404:
        return Config.somethingWentWrong;
      case 500:
        return Config.servernotreachable;
      case 701:
        return Config.somethingWentWrong;
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
      case 400:
        return Config.somethingWentWrong;
      case 500:
        return Config.servernotreachable;
      case 701:
        return Config.somethingWentWrong;
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
      case 400:
        return Config.somethingWentWrong;
      case 404:
        return Config.somethingWentWrong;
      case 500:
        return Config.servernotreachable;
      case 701:
        return Config.somethingWentWrong;
      default:
        return jsonString;
    }
  }

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
      case 400:
        return Config.somethingWentWrong;

      case 701:
        return Config.somethingWentWrong;
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
      case 400:
        return Config.loginerror;
      case 500:
        return Config.servernotreachable;
      case 701:
        return Config.somethingWentWrong;
      default:
        return jsonString;
    }
  }

  registerApi(Map<String, dynamic> params, BuildContext context) async {
    final response =
        await apiServices.postApiCall(Config.registerApi, params, context);
    var jsonString = json.decode(response.body);
    print('jsonString-$jsonString');
    switch (response.statusCode) {
      case 200:
        return RegisterClass.fromJson(jsonString);
      case 404:
        return Config.somethingWentWrong;
      case 400:
        return Config.somethingWentWrong;
      case 500:
        return Config.servernotreachable;
      case 701:
        return Config.somethingWentWrong;

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
      case 400:
        return Config.somethingWentWrong;
      case 500:
        return Config.servernotreachable;
      case 701:
        return Config.somethingWentWrong;

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
      case 400:
        return Config.somethingWentWrong;
      case 701:
        return Config.somethingWentWrong;
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
      case 400:
        return Config.somethingWentWrong;
      case 701:
        return Config.somethingWentWrong;
      default:
        return jsonString;
    }
  }

  commentApi(String Room_ID, String pageNumber, BuildContext context) async {
    final response = await apiServices.getApiCall(
        "${Config.coomment}/${Room_ID}/${pageNumber}/${20}", context);
    print(response);
    var jsonString = json.decode(response.body);
    switch (response.statusCode) {
      case 200:
        return ComentApiModel.fromJson(jsonString);
      case 404:
        return Config.somethingWentWrong;
      case 500:
        return Config.servernotreachable;
      case 701:
        return Config.somethingWentWrong;

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
      case 400:
        return Config.somethingWentWrong;
      case 701:
        return Config.somethingWentWrong;
      default:
        return jsonString;
    }
  }

  CreateRoomAPI(Map<String, String> params, BuildContext context) async {
    final response =
        await apiServices.postApiCall(Config.createRoom1, params, context);
    var jsonString = json.decode(response.body);
    print(jsonString);
    switch (response.statusCode) {
      case 200:
        return CreateRoomModel.fromJson(jsonString);
      case 404:
        return Config.somethingWentWrong;
      case 500:
        return Config.servernotreachable;
      case 400:
        return Config.somethingWentWrong;
      case 701:
        return Config.somethingWentWrong;
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
      case 400:
        return Config.somethingWentWrong;
      case 701:
        return Config.somethingWentWrong;
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
      case 400:
        return Config.somethingWentWrong;
      case 701:
        return Config.somethingWentWrong;
      default:
        return jsonString;
    }
  }

  FetchAllExpertsAPI(BuildContext context) async {
    final response =
        await apiServices.getApiCallWithToken(Config.fetchAllExperts, context);
    var jsonString = json.decode(response.body);
    print(jsonString);
    switch (response.statusCode) {
      case 200:
        return FetchAllExpertsModel.fromJson(jsonString);
      case 404:
        return Config.somethingWentWrong;
      case 500:
        return Config.servernotreachable;
      case 400:
        return Config.somethingWentWrong;
      case 701:
        return Config.somethingWentWrong;
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
      case 400:
        return Config.somethingWentWrong;
      case 701:
        return Config.somethingWentWrong;
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
      case 400:
        return Config.somethingWentWrong;
      case 701:
        return Config.somethingWentWrong;
      default:
        return jsonString;
    }
  }

  RequestListAPI(BuildContext context) async {
    final response = await apiServices.getApiCallWithToken(
        '${Config.get_all_request}', context);
    print(response);
    var jsonString = json.decode(response.body);
    switch (response.statusCode) {
      case 200:
        return RequestListModel.fromJson(jsonString);
      case 404:
        return Config.somethingWentWrong;
      case 500:
        return Config.servernotreachable;
      case 400:
        return Config.somethingWentWrong;
      case 701:
        return Config.somethingWentWrong;
      default:
        return jsonString;
    }
  }

  accept_rejectAPI(
      BuildContext context, bool isAccepted, String followUid) async {
    final response = await apiServices.getApiCallWithToken(
        '${Config.accept_reject_follow_request}?isAccepted=${isAccepted}&followUid=${followUid}',
        context);
    print(response);
    var jsonString = json.decode(response.body);
    switch (response.statusCode) {
      case 200:
        return accept_rejectModel.fromJson(jsonString);
      case 404:
        return Config.somethingWentWrong;
      case 500:
        return Config.servernotreachable;
      case 400:
        return Config.somethingWentWrong;
      case 701:
        return Config.somethingWentWrong;
      default:
        return jsonString;
    }
  }

  AllNotificationAPI(BuildContext context) async {
    final response = await apiServices.getApiCallWithToken(
        '${Config.getAllNotifications}', context);
    print(response);
    var jsonString = json.decode(response.body);
    switch (response.statusCode) {
      case 200:
        return GetAllNotificationModel.fromJson(jsonString);
      case 404:
        return Config.somethingWentWrong;
      case 500:
        return Config.servernotreachable;
      case 400:
        return Config.somethingWentWrong;
      case 701:
        return Config.somethingWentWrong;
      default:
        return jsonString;
    }
  }

  SeenNotificationAPI(BuildContext context, String notificationUid) async {
    final response = await apiServices.getApiCallWithToken(
        '${Config.SeenNotification}?notificationUid=${notificationUid}',
        context);
    print(response);
    var jsonString = json.decode(response.body);
    switch (response.statusCode) {
      case 200:
        return seenNotificationModel.fromJson(jsonString);
      case 404:
        return Config.somethingWentWrong;
      case 500:
        return Config.servernotreachable;
      case 400:
        return Config.somethingWentWrong;
      case 701:
        return Config.somethingWentWrong;
      default:
        return jsonString;
    }
  }

  getAllNoticationsCountAPI(BuildContext context) async {
    final response = await apiServices.getApiCallWithToken(
        '${Config.getAllNoticationsCount}', context);
    print(response);
    var jsonString = json.decode(response.body);
    switch (response.statusCode) {
      case 200:
        return getAllNotificationCount.fromJson(jsonString);
      case 404:
        return Config.somethingWentWrong;
      case 500:
        return Config.servernotreachable;
      case 400:
        return Config.somethingWentWrong;
      case 701:
        return Config.somethingWentWrong;
      default:
        return jsonString;
    }
  }

  HashTagBanner(BuildContext context) async {
    final response =
        await apiServices.getApiCall(Config.HashTagBanner, context);
    print(response);
    var jsonString = json.decode(response.body);
    switch (response.statusCode) {
      case 200:
        return HashTagImageModel.fromJson(jsonString);
      case 404:
        return Config.somethingWentWrong;
      case 500:
        return Config.servernotreachable;
      case 400:
        return Config.somethingWentWrong;
      case 701:
        return Config.somethingWentWrong;
      default:
        return jsonString;
    }
  }

  DeleteRoomApi(String roomuId, String name, BuildContext context) async {
    final response = await apiServices.getApiCallWithToken(
        "${Config.DeleteRoom}?roomUid=${roomuId}&option=${name}", context);
    print(response);
    var jsonString = json.decode(response.body);
    switch (response.statusCode) {
      case 200:
        return DeleteRoomModel.fromJson(jsonString);
      case 404:
        return Config.somethingWentWrong;
      case 500:
        return Config.servernotreachable;
      case 400:
        return Config.somethingWentWrong;
      case 701:
        return Config.somethingWentWrong;
      default:
        return jsonString;
    }
  }

  checkUserActive(BuildContext context) async {
    final response = await apiServices.getApiCallWithToken(
        "${Config.checkUserActive}", context);
    var jsonString = json.decode(response.body);
    print('jsonStringcheckUserActive$jsonString');
    switch (response.statusCode) {
      case 200:
        return CheckUserStausModel.fromJson(jsonString);
      case 404:
        return Config.somethingWentWrong;
      case 500:
        return Config.servernotreachable;
      case 400:
        return Config.somethingWentWrong;
      case 701:
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
      case 400:
        return Config.somethingWentWrong;
      case 701:
        return Config.somethingWentWrong;
      default:
        return jsonString;
    }
  }

  chooseProfileFile2(String file, String fileName, BuildContext context,
      {params}) async {
    print("apiCaling");
    final response = await apiServices.multipartFile(
        "${Config.uploadfile}", file, fileName, context,
        apiName: 'create forum', params: params);
    var jsonString = json.decode(response.body);
    print(jsonString);
    switch (response.statusCode) {
      case 200:
        return ChooseDocument2.fromJson(jsonString);
      case 404:
        return Config.somethingWentWrong;
      case 500:
        return Config.servernotreachable;
      case 400:
        return Config.somethingWentWrong;
      case 701:
        return Config.somethingWentWrong;
      default:
        return jsonString;
    }
  }

  userProfile(File imageFile, BuildContext context) async {
    final response = await apiServices.multipartFileUserprofile(
        '${Config.uploadfile}', imageFile, context);
    var jsonString = json.decode(response.body);
    print(jsonString);
    switch (response.statusCode) {
      case 200:
        return ChooseDocument.fromJson(jsonString);
      case 404:
        return Config.somethingWentWrong;
      case 500:
        return Config.servernotreachable;
      case 400:
        return Config.somethingWentWrong;
      case 701:
        return Config.somethingWentWrong;
      default:
        return jsonString;
    }
  }

  userProfileprofileCover(File imageFile, BuildContext context) async {
    final response = await apiServices.multipartFileUserprofile(
        '${Config.uploadfile}', imageFile, context);
    var jsonString = json.decode(response.body);
    print(jsonString);
    switch (response.statusCode) {
      case 200:
        return ChooseDocument1.fromJson(jsonString);
      case 404:
        return Config.somethingWentWrong;
      case 500:
        return Config.servernotreachable;
      case 400:
        return Config.somethingWentWrong;
      case 701:
        return Config.somethingWentWrong;
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
      case 400:
        return Config.somethingWentWrong;
      case 701:
        return Config.somethingWentWrong;
      default:
        return jsonString;
    }
  }

  employeeApiUpdate(Map<String, dynamic> param, BuildContext context) async {
    final response =
        await apiServices.postApiCall(Config.updateUserProfile, param, context);
    var jsonString = json.decode(response.body);
    print(jsonString);
    switch (response.statusCode) {
      case 200:
        return UpdateProfile.fromJson(jsonString);
      case 404:
        return Config.somethingWentWrong;
      case 500:
        return Config.servernotreachable;
      case 400:
        return Config.somethingWentWrong;
      case 701:
        return Config.somethingWentWrong;
      default:
        return jsonString;
    }
  }

  Tokenvalid(BuildContext context) async {
    final response =
        await apiServices.postApiCalla(Config.validateTokenCheck, context);
    var jsonString = json.decode(response.body);
    print('jsonString-$jsonString');
    switch (response.statusCode) {
      case 200:
        return TokenvalidModel.fromJson(jsonString);
      case 404:
        return Config.somethingWentWrong;
      case 500:
        return Config.servernotreachable;
      case 400:
        return Config.somethingWentWrong;
      case 701:
        return Config.somethingWentWrong;
      default:
        return jsonString;
    }
  }

  cretaForumUpdate(Map<String, dynamic> params, BuildContext context) async {
    final response =
        await apiServices.multipartFile2(Config.company, params, context);
    var jsonString = json.decode(response.body);
    print('dfsdfgsdfgg-$jsonString');
    switch (response.statusCode) {
      case 200:
        return CreateForm.fromJson(jsonString);
      case 404:
        return Config.somethingWentWrong;
      case 500:
        return Config.servernotreachable;
      case 400:
        return Config.somethingWentWrong;
      case 701:
        return Config.somethingWentWrong;
      default:
        return jsonString;
    }
  }

  get_all_hashtag(
      BuildContext context, String pageNumber, String searchHashtag) async {
    print("searchHashtag-$searchHashtag");
    // final response =
    //     await apiServices.getApiCall('${Config.get_all_hashtag}?numberOfRecords=10&pageNumber=${pageNumber}&searchHashtag=${searchHashtag.replaceAll("#", "%23")}', context);
    final response = await apiServices.getApiCall(
        '${Config.get_all_hashtag}?numberOfRecords=30&pageNumber=${'1'}&searchHashtag=${searchHashtag.replaceAll("#", "%23")}',
        context);
    var jsonString = json.decode(response.body);
    log("jsonString-$jsonString");
    switch (response.statusCode) {
      case 200:
        return HasDataModel.fromJson(jsonString);
      case 404:
        return Config.somethingWentWrong;
      case 500:
        return Config.servernotreachable;
      case 400:
        return Config.somethingWentWrong;
      case 701:
        return Config.somethingWentWrong;
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
      case 400:
        return Config.somethingWentWrong;
      case 701:
        return Config.somethingWentWrong;
      default:
        return jsonString;
    }
  }

  UserModel(BuildContext context) async {
    final response =
        await apiServices.getApiCallWithToken(Config.fetchUserModule, context);
    var jsonString = json.decode(response.body);
    print(jsonString);
    switch (response.statusCode) {
      case 200:
        return FetchUserModulemodel.fromJson(jsonString);
      case 404:
        return Config.somethingWentWrong;
      case 400:
        return Config.somethingWentWrong;
      case 500:
        return Config.servernotreachable;
      case 701:
        return Config.somethingWentWrong;

      default:
        return jsonString;
    }
  }

  myAccount(BuildContext context) async {
    final response =
        await apiServices.getApiCallWithToken(Config.myaccountApi, context);
    var jsonString = json.decode(response.body);
    print('Myaccount${response.statusCode}');
    switch (response.statusCode) {
      case 200:
        return MyAccontDetails.fromJson(jsonString);
      case 404:
        return Config.somethingWentWrong;
      case 500:
        return Config.servernotreachable;
      case 400:
        return Config.somethingWentWrong;
      case 701:
        return jsonString;
      default:
        return jsonString;
    }
  }

  SeenMessage(BuildContext context, String inboxUid) async {
    final response = await apiServices.getApiCallWithToken(
        "${Config.message_seen_by_user}?inboxUid=${inboxUid}", context);
    var jsonString = json.decode(response.body);
    print('Myaccount${response.statusCode}');
    switch (response.statusCode) {
      case 200:
        return SeenAllMessageModel.fromJson(jsonString);
      case 404:
        return Config.somethingWentWrong;
      case 500:
        return Config.servernotreachable;
      case 400:
        return Config.somethingWentWrong;
      case 701:
        return jsonString;
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
      case 400:
        return Config.somethingWentWrong;
      case 701:
        return Config.somethingWentWrong;
      default:
        return jsonString;
    }
  }

  forgetpassword(String userNumber, BuildContext context) async {
    final response = await apiServices.getApiCall(
        Config.forgetpassword + userNumber, context);
    var jsonString = json.decode(response.body);
    print('jsonString-$jsonString');
    switch (response.statusCode) {
      case 200:
        return ForgetPasswordModel.fromJson(jsonString);
      case 404:
        return Config.somethingWentWrong;
      case 400:
        return Config.mobileNumberIsNotvaild;
      case 500:
        return Config.servernotreachable;
      case 701:
        return Config.somethingWentWrong;

      default:
        return jsonString;
    }
  }

  FetchPublicRoom(String uuid, BuildContext context) async {
    print("FetchPublicRoom uuid-->$uuid");
    final response =
        await apiServices.getApiCall(Config.FetchPublicRoom + uuid, context);
    var jsonString = json.decode(response.body);
    print("jsonString120->$jsonString");
    switch (response.statusCode) {
      case 200:
        return LoginPublicRoomModel.fromJson(jsonString);
      case 404:
        return Config.somethingWentWrong;
      case 500:
        return Config.servernotreachable;
      case 400:
        return Config.somethingWentWrong;
      case 701:
        return Config.somethingWentWrong;
      default:
        return jsonString;
    }
  }

  MyPublicRoom1(String uuid, BuildContext context) async {
    print("uuid-->$uuid");
    final response =
        await apiServices.getApiCall(Config.fetchMyPublicRoom + uuid, context);
    var jsonString = json.decode(response.body);
    print(jsonString);
    switch (response.statusCode) {
      case 200:
        return MyPublicRoom.fromJson(jsonString);
      case 404:
        return Config.somethingWentWrong;
      case 500:
        return Config.servernotreachable;
      case 400:
        return Config.somethingWentWrong;
      case 701:
        return Config.somethingWentWrong;
      default:
        return jsonString;
    }
  }

  Changepassword(Map<String, dynamic> params, BuildContext context) async {
    final response =
        await apiServices.postApiCall(Config.changepassword, params, context);
    var jsonString = json.decode(response.body);
    print('jsonString-$jsonString');
    switch (response.statusCode) {
      case 200:
        return ChangePasswordModel.fromJson(jsonString);
      case 404:
        return Config.somethingWentWrong;
      case 500:
        return Config.servernotreachable;
      case 400:
        return Config.somethingWentWrong;
      case 701:
        return Config.somethingWentWrong;
      default:
        return jsonString;
    }
  }

  ChangepasswordinSettingScreen(
      Map<String, dynamic> params, BuildContext context) async {
    final response = await apiServices.postApiCall(
        Config.changepasswordInSettingScrnee, params, context);
    var jsonString = json.decode(response.body);
    print('jsonString-$jsonString');
    switch (response.statusCode) {
      case 200:
        return ChangePasswordModelSectionPasswordChages.fromJson(jsonString);
      case 404:
        return Config.somethingWentWrong;
      case 500:
        return Config.servernotreachable;
      case 400:
        return Config.somethingWentWrong;
      case 701:
        return Config.somethingWentWrong;
      default:
        return jsonString;
    }
  }

  GetallBlog(BuildContext context, String userUid) async {
    final response = await apiServices.getApiCall(
        "${Config.getallBlog}?userUid=${userUid}", context);
    var jsonString = json.decode(response.body);
    print(jsonString);
    switch (response.statusCode) {
      case 200:
        return GetallBlogModel.fromJson(jsonString);
      case 404:
        return Config.somethingWentWrong;
      case 500:
        return Config.servernotreachable;
      case 400:
        return Config.somethingWentWrong;
      case 701:
        return Config.somethingWentWrong;
      default:
        return jsonString;
    }
  }

  SaveBlog(BuildContext context, String userUid, String blogUid) async {
    final response = await apiServices.getApiCall(
        "${Config.saveBlog}?userUid=${userUid}&blogUid=${blogUid}", context);
    var jsonString = json.decode(response.body);
    print(jsonString);
    switch (response.statusCode) {
      case 200:
        return saveBlogModel.fromJson(jsonString);
      case 404:
        return Config.somethingWentWrong;
      case 500:
        return Config.servernotreachable;
      case 701:
        return Config.somethingWentWrong;

      default:
        return jsonString;
    }
  }

  LikeBlog(BuildContext context, String userUid, String blogUid) async {
    final response = await apiServices.getApiCall(
        "${Config.LikeBlog}?userUid=${userUid}&blogUid=${blogUid}", context);
    var jsonString = json.decode(response.body);
    print(jsonString);
    switch (response.statusCode) {
      case 200:
        return saveBlogModel.fromJson(jsonString);
      case 404:
        return Config.somethingWentWrong;
      case 500:
        return Config.servernotreachable;
      case 400:
        return Config.somethingWentWrong;
      case 701:
        return Config.somethingWentWrong;
      default:
        return jsonString;
    }
  }

  fllowersApi(BuildContext context, String userUid) async {
    final response = await apiServices.getApiCallWithToken(
        "${Config.get_all_followers}?userUid=${userUid}", context);
    var jsonString = json.decode(response.body);
    print(jsonString);
    switch (response.statusCode) {
      case 200:
        return FollowersClassModel.fromJson(jsonString);
      case 404:
        return Config.somethingWentWrong;
      case 500:
        return Config.servernotreachable;
      case 400:
        return Config.somethingWentWrong;
      case 701:
        return Config.somethingWentWrong;
      default:
        return jsonString;
    }
  }

  removeFollwerApi(BuildContext context, String follwUid) async {
    final response = await apiServices.getApiCallWithToken(
        "${Config.remove_follower}?followUid=${follwUid}", context);
    var jsonString = json.decode(response.body);
    print(jsonString);
    switch (response.statusCode) {
      case 200:
        return Remove_Follower.fromJson(jsonString);
      case 404:
        return Config.somethingWentWrong;
      case 500:
        return Config.servernotreachable;
      case 400:
        return Config.somethingWentWrong;
      case 701:
        return Config.somethingWentWrong;
      default:
        return jsonString;
    }
  }

  get_all_followering(BuildContext context, String userUid) async {
    final response = await apiServices.getApiCallWithToken(
        "${Config.get_all_followings}?userUid=${userUid}", context);
    var jsonString = json.decode(response.body);
    print(jsonString);
    switch (response.statusCode) {
      case 200:
        return FollowersClassModel.fromJson(jsonString);
      case 404:
        return Config.somethingWentWrong;
      case 500:
        return Config.servernotreachable;
      case 400:
        return Config.somethingWentWrong;
      case 701:
        return Config.somethingWentWrong;
      default:
        return jsonString;
    }
  }

  GetAllSaveBlog(BuildContext context, String userUid) async {
    final response = await apiServices.getApiCall(
        "${Config.getSavedBlogs}?userUid=${userUid}", context);
    var jsonString = json.decode(response.body);
    print(jsonString);
    switch (response.statusCode) {
      case 200:
        return saveAllBlogModel.fromJson(jsonString);
      case 404:
        return Config.somethingWentWrong;
      case 500:
        return Config.servernotreachable;
      case 400:
        return Config.somethingWentWrong;
      case 701:
        return Config.somethingWentWrong;
      default:
        return jsonString;
    }
  }

  LogOut(BuildContext context) async {
    final response =
        await apiServices.getApiCallWithToken(Config.logOut, context);
    var jsonString = json.decode(response.body);
    print('Myaccount$jsonString');
    switch (response.statusCode) {
      case 200:
        return LogOutModel.fromJson(jsonString);
      case 404:
        return Config.somethingWentWrong;
      case 500:
        return Config.servernotreachable;
      case 400:
        return Config.somethingWentWrong;
      case 701:
        return Config.somethingWentWrong;
      default:
        return jsonString;
    }
  }

  DeleteUser(String uuid, String reason, BuildContext context) async {
    final response = await apiServices.getApiCall(
        Config.DeleteUser + uuid + "/${reason}", context);
    var jsonString = json.decode(response.body);
    print('Myaccount$jsonString');
    switch (response.statusCode) {
      case 200:
        return DeleteUserModel.fromJson(jsonString);
      case 404:
        return Config.somethingWentWrong;
      case 500:
        return Config.servernotreachable;
      case 400:
        return Config.somethingWentWrong;
      case 701:
        return Config.somethingWentWrong;
      default:
        return jsonString;
    }
  }

  UserReActivate(Map<String, dynamic> params, BuildContext context) async {
    final response =
        await apiServices.postApiCall(Config.ReActivateUSer, params, context);
    var jsonString = json.decode(response.body);
    print('jsonString-$jsonString');
    switch (response.statusCode) {
      case 200:
        return UserReActivateModel.fromJson(jsonString);
      case 404:
        return Config.somethingWentWrong;
      case 500:
        return Config.servernotreachable;
      case 400:
        return Config.somethingWentWrong;
      case 701:
        return Config.somethingWentWrong;
      default:
        return jsonString;
    }
  }

  SelectRoomAPI(BuildContext context) async {
    final response = await apiServices.getApiCallWithToken(
        "${Config.SelectRoomList}", context);
    print(response);
    var jsonString = json.decode(response.body);
    switch (response.statusCode) {
      case 200:
        return SelectRoomModel.fromJson(jsonString);
      case 404:
        return Config.somethingWentWrong;
      case 500:
        return Config.servernotreachable;
      case 400:
        return Config.somethingWentWrong;
      case 701:
        return Config.somethingWentWrong;
      default:
        return jsonString;
    }
  }

  RateUs(Map<String, dynamic> params, BuildContext context) async {
    final response =
        await apiServices.postApiCall(Config.RateUs, params, context);
    var jsonString = json.decode(response.body);
    print('jsonString-$jsonString');
    switch (response.statusCode) {
      case 200:
        return RateUsModel.fromJson(jsonString);
      case 404:
        return Config.somethingWentWrong;
      case 500:
        return Config.servernotreachable;
      case 400:
        return Config.somethingWentWrong;
      case 701:
        return Config.somethingWentWrong;
      default:
        return jsonString;
    }
  }

  emailVerifaction(BuildContext context, String email) async {
    final response = await apiServices.getApiCallWithToken(
        "${Config.emailVerifaction}/${email}", context);
    var jsonString = json.decode(response.body);
    print('Myaccount$jsonString');
    switch (response.statusCode) {
      case 200:
        return EmailVerifaction.fromJson(jsonString);
      case 404:
        return Config.somethingWentWrong;
      case 500:
        return Config.servernotreachable;
      case 400:
        return Config.somethingWentWrong;
      case 701:
        return Config.somethingWentWrong;
      default:
        return jsonString;
    }
  }

  chatImage(BuildContext context, String RoomChatUserUid, String userUid,
      File imageFile) async {
    final response = await apiServices.multipartFileUserprofile(
        "${Config.chatImageRoom}/${RoomChatUserUid}/${userUid}",
        imageFile,
        context,
        imageDataType: "yes");
    var jsonString = json.decode(response.body);
    print('jasonnString$jsonString');
    switch (response.statusCode) {
      case 200:
        return jsonString;
      case 404:
        return Config.somethingWentWrong;
      case 500:
        return Config.servernotreachable;
      case 400:
        return Config.somethingWentWrong;
      case 701:
        return Config.somethingWentWrong;
      default:
        return jsonString;
    }
  }

  chatImage1(String inboxChatUserUid, String userUid, File imageFile,
      BuildContext context) async {
    final response = await apiServices.multipartFileWithSoket(
        "${Config.chatImageDM}?inboxChatUserUid=$inboxChatUserUid&userUid=$userUid",
        imageFile,
        context);
    var jsonString = json.decode(response.body);
    switch (response.statusCode) {
      case 200:
        return jsonString;
      case 404:
        return Config.somethingWentWrong;
      case 500:
        return Config.servernotreachable;
      case 400:
        return Config.somethingWentWrong;
      case 701:
        return Config.somethingWentWrong;
      default:
        return jsonString;
    }
  }

  pinAndUnPin(BuildContext context, String uuid) async {
    final responce = await apiServices.postApiCalla(
        '${Config.unPin}/${uuid.toString()}', context);
    var jsonString = json.decode(responce.body);
    print('jasonnString$jsonString');
    switch (responce.statusCode) {
      case 200:
        return UnPinModel.fromJson(jsonString);
      case 404:
        return Config.somethingWentWrong;
      case 500:
        return Config.servernotreachable;
      case 400:
        return Config.somethingWentWrong;
      case 701:
        return Config.somethingWentWrong;
      default:
        return jsonString;
    }
  }

  getCountOfSavedRoomMethod(BuildContext context) async {
    final responce = await apiServices.getApiCallWithToken(
        '${Config.getCountOfSavedRoom}', context);
    var jsonString = json.decode(responce.body);
    print('jasonnString$jsonString');
    switch (responce.statusCode) {
      case 200:
        return GetCountOfSavedRoomModel.fromJson(jsonString);
      case 404:
        return Config.somethingWentWrong;
      case 500:
        return Config.servernotreachable;
      case 400:
        return Config.somethingWentWrong;
      case 701:
        return Config.somethingWentWrong;
      default:
        return jsonString;
    }
  }

  AutoEnterinAPI(BuildContext context, String RoomID) async {
    final responce = await apiServices.getApiCallWithToken(
        '${Config.AutoCheckINRoom}?invitedRoomLink=${RoomID}', context);
    var jsonString = json.decode(responce.body);
    print('jasonnString$jsonString');
    switch (responce.statusCode) {
      case 200:
        return AutoEnterRoomModel.fromJson(jsonString);
      case 404:
        return Config.somethingWentWrong;
      case 500:
        return Config.servernotreachable;
      case 400:
        return Config.somethingWentWrong;
      case 701:
        return Config.somethingWentWrong;
      default:
        return jsonString;
    }
  }

  AutoOpenPostAPI(BuildContext context, String postLink) async {
    final responce = await apiServices.getApiCallWithToken(
        '${Config.getPostUidOrUserUid}?postLink=${postLink}', context);
    var jsonString = json.decode(responce.body);
    print('jasonnString$jsonString');
    switch (responce.statusCode) {
      case 200:
        return ShareAppOpenPostModel.fromJson(jsonString);
      case 404:
        return Config.somethingWentWrong;
      case 500:
        return Config.servernotreachable;
      case 400:
        return Config.somethingWentWrong;
      case 701:
        return Config.somethingWentWrong;
      default:
        return jsonString;
    }
  }

  ViewDetails(String UUid, BuildContext context) async {
    final responce =
        await apiServices.getApiCall('${Config.ViewDetails}/${UUid}', context);
    var jsonString = json.decode(responce.body);
    print('jasonnString$jsonString');
    switch (responce.statusCode) {
      case 200:
        return ViewDetailsModel.fromJson(jsonString);
      case 404:
        return Config.somethingWentWrong;
      case 500:
        return Config.servernotreachable;
      case 400:
        return Config.somethingWentWrong;
      case 701:
        return Config.somethingWentWrong;
      default:
        return jsonString;
    }
  }

  RemoveUser(String roomID, String? memberUesrID, BuildContext context) async {
    final responce = await apiServices.getApiCallWithToken(
        '${Config.RemoveUser}?roomUid=${roomID}&memberUserUid=${memberUesrID}',
        context);
    var jsonString = json.decode(responce.body);
    print('jasonnString$jsonString');
    print('respnse ${responce.statusCode}');
    switch (responce.statusCode) {
      case 200:
        return RemoveUserModel.fromJson(jsonString);
      case 404:
        return Config.somethingWentWrong;
      case 500:
        return Config.servernotreachable;
      case 400:
        return Config.somethingWentWrong;
      case 701:
        return Config.somethingWentWrong;
      default:
        return jsonString;
    }
  }

  Exituser(String roomID, BuildContext context) async {
    final responce = await apiServices.getApiCallWithToken(
        '${Config.RemoveUser}?roomUid=${roomID}', context);
    var jsonString = json.decode(responce.body);
    print('jasonnString$jsonString');
    print('respnse ${responce.statusCode}');
    switch (responce.statusCode) {
      case 200:
        return RemoveUserModel.fromJson(jsonString);
      case 404:
        return Config.somethingWentWrong;
      case 500:
        return Config.servernotreachable;
      case 400:
        return Config.somethingWentWrong;
      case 701:
        return Config.somethingWentWrong;
      default:
        return jsonString;
    }
  }

  GetGuestAllPost(
    BuildContext context,
    String pageNumber,
  ) async {
    final responce = await apiServices.getApiCall(
        '${Config.GuestGetAllPost}?pageNumber=$pageNumber&numberOfRecords=10',
        context);
    var jsonString = json.decode(responce.body);
    print('jasonnString$jsonString');
    print('respnse ${responce.statusCode}');
    switch (responce.statusCode) {
      case 200:
        return GetGuestAllPostModel.fromJson(jsonString);
      case 404:
        return Config.somethingWentWrong;
      case 500:
        return Config.servernotreachable;
      case 400:
        return Config.somethingWentWrong;
      case 701:
        return Config.somethingWentWrong;
      default:
        return jsonString;
    }
  }

  GetUserAllPost(
    BuildContext context,
    String pageNumber,
  ) async {
    final responce = await apiServices.getApiCallWithToken(
        '${Config.UserGetAllPost}?pageNumber=$pageNumber&numberOfRecords=10',
        context);
    var jsonString = json.decode(responce.body);
    print('jasonnString$jsonString');
    print('respnse ${responce.statusCode}');
    switch (responce.statusCode) {
      case 200:
        return GetGuestAllPostModel.fromJson(jsonString);
      case 404:
        return Config.somethingWentWrong;
      case 500:
        return Config.servernotreachable;
      case 400:
        return Config.somethingWentWrong;
      case 701:
        return Config.somethingWentWrong;
      default:
        return jsonString;
    }
  }

  AddPostApiCalling(
    BuildContext context,
    Map<String, dynamic> params,
  ) async {
    final response =
        await apiServices.postApiCall(Config.addPost, params, context);
    print('AddPost$response');
    var jsonString = json.decode(response.body);
    switch (response.statusCode) {
      case 200:
        return AddPost.fromJson(jsonString);
      case 404:
        return Config.somethingWentWrong;
      case 500:
        return Config.servernotreachable;
      case 400:
        return Config.somethingWentWrong;
      case 701:
        return Config.somethingWentWrong;

      default:
        return jsonString;
    }
  }
  // ImageDataPost

  AddPostImageUploded(
    BuildContext context,
    String fileName,
    String file,
  ) async {
    final response = await apiServices.multipartFile(
        Config.upload_data, fileName, file, context,
        AadPost: true);
    print('AddPost$response');
    var jsonString = json.decode(response.body);
    switch (response.statusCode) {
      case 200:
        return ImageDataPost.fromJson(jsonString);
      case 404:
        return Config.somethingWentWrong;
      case 500:
        return Config.servernotreachable;
      case 400:
        return Config.somethingWentWrong;
      case 701:
        return Config.somethingWentWrong;
      default:
        return jsonString;
    }
  }

  userProfile1(List<File> imageFile, BuildContext context) async {
    final response = await apiServices.multipartFileWith1(
        '${Config.upload_data}', imageFile, context);
    var jsonString = json.decode(response.body);
    print(jsonString);
    switch (response.statusCode) {
      case 200:
        return ImageDataPost.fromJson(jsonString);
      case 404:
        return Config.somethingWentWrong;
      case 500:
        return Config.servernotreachable;
      case 400:
        return Config.somethingWentWrong;
      case 701:
        return Config.somethingWentWrong;
      default:
        return jsonString;
    }
  }

  likePostMethod(String? postUid, BuildContext context) async {
    final response = await apiServices.getApiCallWithToken(
        "${Config.like_post}?postUid=${postUid}", context);
    var jsonString = json.decode(response.body);
    print(jsonString);
    switch (response.statusCode) {
      case 200:
        return LikePost.fromJson(jsonString);
      case 404:
        return Config.somethingWentWrong;
      case 500:
        return Config.servernotreachable;
      case 400:
        return Config.somethingWentWrong;
      case 701:
        return Config.somethingWentWrong;
      default:
        return jsonString;
    }
  }

  savedPostMethod(String? postUid, BuildContext context) async {
    final response = await apiServices.getApiCallWithToken(
        "${Config.save_post}?postUid=${postUid}", context);
    var jsonString = json.decode(response.body);
    print(jsonString);
    switch (response.statusCode) {
      case 200:
        return LikePost.fromJson(jsonString);
      case 404:
        return Config.somethingWentWrong;
      case 500:
        return Config.servernotreachable;
      case 400:
        return Config.somethingWentWrong;
      case 701:
        return Config.somethingWentWrong;
      default:
        return jsonString;
    }
  }

  folliwingMethod(String? followedToUid, BuildContext context) async {
    final response = await apiServices.getApiCallWithToken(
        "${Config.follow_user}?followedToUid=${followedToUid}", context);
    var jsonString = json.decode(response.body);
    print(jsonString);
    switch (response.statusCode) {
      case 200:
        return LikePost.fromJson(jsonString);
      case 404:
        return Config.somethingWentWrong;
      case 500:
        return Config.servernotreachable;
      case 400:
        return Config.somethingWentWrong;
      case 701:
        return Config.somethingWentWrong;
      default:
        return jsonString;
    }
  }

  GetPostAllLike(BuildContext context, String PostUID) async {
    final responce = await apiServices.getApiCallWithToken(
        '${Config.GetPostAllLike}?postUid=${PostUID}', context);
    var jsonString = json.decode(responce.body);
    print('jasonnString$jsonString');
    print('respnse ${responce.statusCode}');
    switch (responce.statusCode) {
      case 200:
        return GetPostLikeModel.fromJson(jsonString);
      case 404:
        return Config.somethingWentWrong;
      case 500:
        return Config.servernotreachable;
      case 400:
        return Config.somethingWentWrong;
      case 701:
        return Config.somethingWentWrong;
      default:
        return jsonString;
    }
  }

  Addcomment(BuildContext context, String PostUID) async {
    final responce = await apiServices.getApiCallWithToken(
        '${Config.Addcomments}?postUid=${PostUID}', context);
    var jsonString = json.decode(responce.body);
    print('jasonnString$jsonString');
    print('respnse ${responce.statusCode}');
    switch (responce.statusCode) {
      case 200:
        return AddCommentModel.fromJson(jsonString);
      case 404:
        return Config.somethingWentWrong;
      case 500:
        return Config.servernotreachable;
      case 400:
        return Config.somethingWentWrong;
      case 701:
        return Config.somethingWentWrong;
      default:
        return jsonString;
    }
  }

  AddNewcomment(
    BuildContext context,
    Map<String, dynamic> params,
  ) async {
    final response =
        await apiServices.postApiCall(Config.getcomments, params, context);
    print('AddPost$response');
    var jsonString = json.decode(response.body);
    switch (response.statusCode) {
      case 200:
        return jsonString;
      case 404:
        return Config.somethingWentWrong;
      case 500:
        return Config.servernotreachable;
      case 400:
        return Config.somethingWentWrong;
      case 701:
        return Config.somethingWentWrong;

      default:
        return jsonString;
    }
  }

/*   NewProfileAPI(BuildContext context, String url) async {
    print("sdfhsdfhsdfh-$url");
    final response = await apiServices.getApiCallWithToken(
        url, context);

    var jsonString = json.decode(response.body);
    print("NewProfileAPI--$jsonString");
    switch (response.statusCode) {
      case 200:
        return NewProfileScreen_Model.fromJson(jsonString);
      case 404:
        return Config.somethingWentWrong;
      case 500:
        return Config.servernotreachable;
      case 400:
        return Config.somethingWentWrong;
      case 701:
        return Config.somethingWentWrong;
      default:
        return jsonString;
    }
  } */

  NewProfileAPI(BuildContext context, String otherUserUid) async {
    print("sdfhsdfhsdfh-$otherUserUid");
    final response = await apiServices.getApiCallWithToken(
        "${Config.NewfetchUserProfile}?otherUserUid=${otherUserUid}", context);
    print('AddPost$response');
    var jsonString = json.decode(response.body);
    switch (response.statusCode) {
      case 200:
        return NewProfileScreen_Model.fromJson(jsonString);
      case 404:
        return Config.somethingWentWrong;
      case 500:
        return Config.servernotreachable;
      case 400:
        return Config.somethingWentWrong;
      case 701:
        return Config.somethingWentWrong;
      default:
        return jsonString;
    }
  }

  GetAppPostAPI(BuildContext context, String userUid) async {
    final response = await apiServices.getApiCallWithToken(
        "${Config.GetAppPost}?userUid=${userUid}", context);
    print('AddPost$response');
    var jsonString = json.decode(response.body);
    switch (response.statusCode) {
      case 200:
        return GetAppUserPostModel.fromJson(jsonString);
      case 404:
        return Config.somethingWentWrong;
      case 500:
        return Config.servernotreachable;
      case 400:
        return Config.somethingWentWrong;
      case 701:
        return Config.somethingWentWrong;
      default:
        return jsonString;
    }
  }

  GetPostCommetAPI(BuildContext context, String userUid, String orderBy) async {
    final response = await apiServices.getApiCallWithToken(
        "${Config.GetPostCommetAPI}?userUid=${userUid}&orderBy=${orderBy}",
        context);
    print('AddPost$response');
    var jsonString = json.decode(response.body);
    switch (response.statusCode) {
      case 200:
        return GetUserPostCommetModel.fromJson(jsonString);
      case 404:
        return Config.somethingWentWrong;
      case 500:
        return Config.servernotreachable;
      case 400:
        return Config.somethingWentWrong;
      case 701:
        return Config.somethingWentWrong;
      default:
        return jsonString;
    }
  }

  GetSavePostAPI(BuildContext context, String userUid) async {
    final response = await apiServices.getApiCallWithToken(
        "${Config.GetSavePostAPI}?userUid=${userUid}", context);
    print('AddPost$response');
    var jsonString = json.decode(response.body);
    switch (response.statusCode) {
      case 200:
        return GetSavePostModel.fromJson(jsonString);
      case 404:
        return Config.somethingWentWrong;
      case 500:
        return Config.servernotreachable;
      case 400:
        return Config.somethingWentWrong;
      case 701:
        return Config.somethingWentWrong;
      default:
        return jsonString;
    }
  }

  GetAllStory(BuildContext context) async {
    final response =
        await apiServices.getApiCallWithToken("${Config.getAllStory}", context);
    var jsonString = json.decode(response.body);
    print(jsonString);
    switch (response.statusCode) {
      case 200:
        return GetAllStoryModel.fromJson(jsonString);
      case 404:
        return Config.somethingWentWrong;
      case 500:
        return Config.servernotreachable;
      case 400:
        return Config.somethingWentWrong;
      case 701:
        return Config.somethingWentWrong;
      default:
        return jsonString;
    }
  }

  cretateStoryApi(BuildContext context, Map<String, dynamic> params) async {
    final response = await apiServices.postApiCall(
        "${Config.crateStroyCheck}", params, context);
    var jsonString = json.decode(response.body);
    print("cretateStoryApi:-------------$jsonString");
    switch (response.statusCode) {
      case 200:
        return CreateStroy.fromJson(jsonString);
      case 404:
        return Config.somethingWentWrong;
      case 500:
        return Config.servernotreachable;
      case 400:
        return Config.somethingWentWrong;
      case 701:
        return Config.somethingWentWrong;
      default:
        return jsonString;
    }
  }

  IndustryType(BuildContext context) async {
    final response = await apiServices.getApiCall(Config.industryType, context);
    var jsonString = json.decode(response.body);
    print(jsonString);
    switch (response.statusCode) {
      case 200:
        return IndustryTypeModel.fromJson(jsonString);
      case 404:
        return Config.somethingWentWrong;
      case 500:
        return Config.servernotreachable;
      case 400:
        return Config.somethingWentWrong;
      case 701:
        return Config.somethingWentWrong;
      default:
        return jsonString;
    }
  }

  Deletepost(String postUid, BuildContext context) async {
    final response = await apiServices.deleteApiCall(
        "${Config.Deletepost}?postUid=${postUid}", {}, context);
    print(response);
    var jsonString = json.decode(response!.body);
    switch (response.statusCode) {
      case 200:
        return DeletePostModel.fromJson(jsonString);
      case 404:
        return Config.somethingWentWrong;
      case 500:
        return Config.servernotreachable;
      case 400:
        return Config.somethingWentWrong;
      case 701:
        return Config.somethingWentWrong;
      default:
        return jsonString;
    }
  }

  HashTagForYouAPI(
      BuildContext context, String hashtagViewType, String pageNumber) async {
    final response = await apiServices.getApiCallWithToken(
        '${Config.HashTagForYou}?hashtagViewType=$hashtagViewType&pageNumber=$pageNumber&pageSize=20',
        context);

    var jsonString = json.decode(response.body);
    print("jasonnStingview-${jsonString}");
    switch (response.statusCode) {
      case 200:
        return HashtagModel.fromJson(jsonString);
      case 404:
        return Config.somethingWentWrong;
      case 500:
        return Config.servernotreachable;
      case 400:
        return Config.somethingWentWrong;
      case 701:
        return Config.somethingWentWrong;
      default:
        return jsonString;
    }
  }

  HashTagViewDataAPI(
    BuildContext context,
    String hashTag,
  ) async {
    final response = await apiServices.getApiCallWithToken(
        '${Config.HashTagView}?hashtagName=${hashTag.replaceAll("#", "%23")}',
        context);
    print(response);
    var jsonString = json.decode(response.body);
    switch (response.statusCode) {
      case 200:
        return HashtagViewDataModel.fromJson(jsonString);
      case 404:
        return Config.somethingWentWrong;
      case 500:
        return Config.servernotreachable;
      case 400:
        return Config.somethingWentWrong;
      case 701:
        return Config.somethingWentWrong;
      default:
        return jsonString;
    }
  }

  ViewStory(
    BuildContext context,
    String userUid,
    String storyUid,
  ) async {
    final response = await apiServices.getApiCallWithToken(
        '${Config.view_story}?userUid=${userUid}&storyUid=${storyUid}',
        context);
    print(response);
    var jsonString = json.decode(response.body);
    switch (response.statusCode) {
      case 200:
        return ViewStoryModel.fromJson(jsonString);
      case 404:
        return Config.somethingWentWrong;
      case 500:
        return Config.servernotreachable;
      case 400:
        return Config.somethingWentWrong;
      case 701:
        return Config.somethingWentWrong;
      default:
        return jsonString;
    }
  }

  getalluser(
    int? pageNumber,
    String searchName,
    BuildContext context, {
    String? filterModule,
  }) async {
    final response;
    if (filterModule != null) {
      response = await apiServices.getApiCallWithToken(
          "${Config.getalluser}?pageNumber=$pageNumber&numberOfRecords=20&searchName=$searchName&filterModule=$filterModule",
          context);
    } else {
      response = await apiServices.getApiCallWithToken(
          "${Config.getalluser}?pageNumber=$pageNumber&numberOfRecords=20&searchName=$searchName",
          context);
    }
    var jsonString = json.decode(response.body);
    print(jsonString);
    switch (response.statusCode) {
      case 200:
        return GetAllUserListModel.fromJson(jsonString);
      case 404:
        return Config.somethingWentWrong;
      case 500:
        return Config.servernotreachable;
      case 400:
        return Config.somethingWentWrong;
      case 701:
        return Config.somethingWentWrong;
      default:
        return jsonString;
    }
  }

  AddPostImageUploded1(
    BuildContext context,
    String fileName,
    String file,
  ) async {
    final response = await apiServices.multipartFile(
        Config.uploadStroy, fileName, file, context,
        AadPost: true);
    print('AddPost$response');
    var jsonString = json.decode(response.body);
    switch (response.statusCode) {
      case 200:
        return ImageDataPostOne.fromJson(jsonString);
      case 404:
        return Config.somethingWentWrong;
      case 500:
        return Config.servernotreachable;
      case 400:
        return Config.somethingWentWrong;
      case 701:
        return Config.somethingWentWrong;
      default:
        return jsonString;
    }
  }

  aboutMe(BuildContext context, String aboutMe) async {
    final response = await apiServices.getApiCallWithToken(
        '${Config.add_update_about_me}?aboutMe=${aboutMe.replaceAll("#", "%23")}',
        context);
    var jsonString = json.decode(response.body);
    switch (response.statusCode) {
      case 200:
        return AboutMe.fromJson(jsonString);
      case 404:
        return Config.somethingWentWrong;
      case 500:
        return Config.servernotreachable;
      case 400:
        return Config.somethingWentWrong;
      case 701:
        return Config.somethingWentWrong;
      default:
        return jsonString;
    }
  }

  openSaveImagePost(BuildContext context, String PostUID) async {
    final response = /* PostUID == ""
        ? await apiServices.getApiCallWithToken(
            '${Config.OpenSaveImagePost}?postLink=${PostLink}', context)
        : */
        await apiServices.getApiCallWithToken(
            '${Config.OpenSaveImagePost}?postUid=$PostUID', context);
    var jsonString = json.decode(response.body);
    switch (response.statusCode) {
      case 200:
        return OpenSaveImagepostModel.fromJson(jsonString);
      case 404:
        return Config.somethingWentWrong;
      case 500:
        return Config.servernotreachable;
      case 400:
        return Config.somethingWentWrong;
      case 701:
        return Config.somethingWentWrong;
      default:
        return jsonString;
    }
  }

  getAllDataGet(BuildContext context, String userUid) async {
    print("shdsdgfgsdfgfg-$userUid");
    final response = await apiServices.getApiCallWithToken(
        '${Config.get_about_me}?userUid=$userUid', context);
    var jsonString = json.decode(response.body);
    switch (response.statusCode) {
      case 200:
        return AboutMe.fromJson(jsonString);
      case 404:
        return Config.somethingWentWrong;
      case 500:
        return Config.servernotreachable;
      case 400:
        return Config.somethingWentWrong;
      case 701:
        return Config.somethingWentWrong;
      default:
        return jsonString;
    }
  }

  Deletecomment(String commentuid, BuildContext context) async {
    final response = await apiServices.deleteApiCall(
        "${Config.deletecomment}?commentUid=${commentuid}", {}, context);
    print(response);
    var jsonString = json.decode(response!.body);
    switch (response.statusCode) {
      case 200:
        return DeleteCommentModel.fromJson(jsonString);
      case 404:
        return Config.somethingWentWrong;
      case 500:
        return Config.servernotreachable;
      case 400:
        return Config.somethingWentWrong;
      case 701:
        return Config.somethingWentWrong;
      default:
        return jsonString;
    }
  }

  StoryViewList(
    BuildContext context,
    String storyUid,
  ) async {
    final response = await apiServices.getApiCallWithToken(
        '${Config.StoryViewList}?storyUid=${storyUid}', context);
    print(response);
    var jsonString = json.decode(response.body);
    switch (response.statusCode) {
      case 200:
        return StoryViewListModel.fromJson(jsonString);
      case 404:
        return Config.somethingWentWrong;
      case 500:
        return Config.servernotreachable;
      case 400:
        return Config.somethingWentWrong;
      case 701:
        return Config.somethingWentWrong;
      default:
        return jsonString;
    }
  }

  PersonalChatList(
    BuildContext context,
  ) async {
    final response = await apiServices.getApiCallWithToken(
        '${Config.PersonalChatList}', context);
    print(response);
    var jsonString = json.decode(response.body);
    switch (response.statusCode) {
      case 200:
        return PersonalChatListModel.fromJson(jsonString);
      case 404:
        return Config.somethingWentWrong;
      case 500:
        return Config.servernotreachable;
      case 400:
        return Config.somethingWentWrong;
      case 701:
        return Config.somethingWentWrong;
      default:
        return jsonString;
    }
  }

  search_historyDataAdd(BuildContext context, String typeWord) async {
    final response = await apiServices.getApiCallWithToken(
        "${Config.search_historyDataAdd}?searchDescription=$typeWord", context);
    var jsonString = json.decode(response.body);
    print("responce jasonString-$jsonString");
    switch (response.statusCode) {
      case 200:
        return SerchDataAdd.fromJson(jsonString);
      case 404:
        return Config.somethingWentWrong;
      case 500:
        return Config.servernotreachable;
      case 400:
        return Config.somethingWentWrong;
      case 701:
        return Config.somethingWentWrong;
      default:
        return jsonString;
    }
  }

  getSerchData(BuildContext context) async {
    final response = await apiServices.getApiCallWithToken(
        Config.get_hashtag_search_history, context);
    var jsonString = json.decode(response.body);
    print('search_historyDataAdd$jsonString');
    switch (response.statusCode) {
      case 200:
        return GetDataInSerch.fromJson(jsonString);
      case 404:
        return Config.somethingWentWrong;
      case 500:
        return Config.servernotreachable;
      case 400:
        return Config.somethingWentWrong;
      case 701:
        return Config.somethingWentWrong;
      default:
        return jsonString;
    }
  }

  RePost(BuildContext context, Map<String, dynamic> params, String? uuId,
      String? name) async {
    final response = await apiServices.postApiCall(
        Config.rePost + "?postUid=" + "${uuId}" + "&rePostType=" + "${name}",
        params,
        context);
    print('AddPost$response');
    var jsonString = json.decode(response.body);
    switch (response.statusCode) {
      case 200:
        return RePostModel.fromJson(jsonString);
      case 404:
        return Config.somethingWentWrong;
      case 500:
        return Config.servernotreachable;
      case 400:
        return Config.somethingWentWrong;
      case 701:
        return Config.somethingWentWrong;
      default:
        return jsonString;
    }
  }

  SelectChatMemberList(BuildContext context) async {
    final responce = await apiServices.getApiCallWithToken(
        '${Config.SelectChatMember}', context);
    var jsonString = json.decode(responce.body);
    print('jasonnString$jsonString');
    switch (responce.statusCode) {
      case 200:
        return SelectChatMemberModel.fromJson(jsonString);
      case 404:
        return Config.somethingWentWrong;
      case 500:
        return Config.servernotreachable;
      case 400:
        return Config.somethingWentWrong;
      case 701:
        return Config.somethingWentWrong;
      default:
        return jsonString;
    }
  }

  logOutSettionexperied(BuildContext context) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString(PreferencesKey.loginJwt) ?? "";
    final responce = await apiServices.getApiCall(
        '${Config.logOutUserSttionExperied}?token=$token', context);
    var jsonString = json.decode(responce.body);
    switch (responce.statusCode) {
      case 200:
        return IsTokenExpired.fromJson(jsonString);
      case 404:
        return Config.somethingWentWrong;
      case 500:
        return Config.servernotreachable;
      case 400:
        return Config.somethingWentWrong;
      case 701:
        return Config.somethingWentWrong;
      default:
        return jsonString;
    }
  }

  roomExists(String? otherMemberID, String roomID, BuildContext context) async {
    final response = await apiServices.getApiCallWithToken(
        '${Config.roomExists}?otherMemberUid=$otherMemberID&roomUid=$roomID',
        context);
    var jsonString = json.decode(response.body);
    print('jsonString-$jsonString');
    switch (response.statusCode) {
      case 200:
        return RoomExistsModel.fromJson(jsonString);
      case 404:
        return Config.somethingWentWrong;
      case 500:
        return Config.servernotreachable;
      case 400:
        return Config.somethingWentWrong;
      case 701:
        return Config.somethingWentWrong;
      default:
        return jsonString;
    }
  }

  search_user_for_inbox(
      String searchFilter, String pageNumber, BuildContext context) async {
    final response = await apiServices.getApiCallWithToken(
        '${Config.insearch_user_for_inboxUrl1}?searchFilter=$searchFilter&numberOfRecords=30&pageNumber=$pageNumber',
        context);
    var jsonString = json.decode(response.body);
    print('jsonString-$jsonString');
    switch (response.statusCode) {
      case 200:
        return SearchUserForInbox.fromJson(jsonString);
      case 404:
        return Config.somethingWentWrong;
      case 500:
        return Config.servernotreachable;
      case 400:
        return Config.somethingWentWrong;
      case 701:
        return Config.somethingWentWrong;
      default:
        return jsonString;
    }
  }

  search_user_for_inbox1(
      String searchFilter, String pageNumber, BuildContext context) async {
    final response = await apiServices.getApiCallWithToken(
        '${Config.search_user_for_inboxUrl}?searchByUsername=$searchFilter&numberOfRecords=30&pageNumber=$pageNumber',
        context);
    var jsonString = json.decode(response.body);
    print('jsonString-$jsonString');
    switch (response.statusCode) {
      case 200:
        return SearchUserForInbox.fromJson(jsonString);
      case 404:
        return Config.somethingWentWrong;
      case 500:
        return Config.servernotreachable;
      case 400:
        return Config.somethingWentWrong;
      case 701:
        return Config.somethingWentWrong;
      default:
        return jsonString;
    }
  }

  accountTypeMethod(String accountType, BuildContext context) async {
    print("accountType---$accountType");
    final response = await apiServices.getApiCallWithToken(
        '${Config.accountType}?accountType=$accountType', context);
    var jsonString = json.decode(response.body);
    print('jsonString-$jsonString');
    switch (response.statusCode) {
      case 200:
        return AccountType.fromJson(jsonString);
      case 404:
        return Config.somethingWentWrong;
      case 500:
        return Config.servernotreachable;
      case 400:
        return Config.somethingWentWrong;
      case 701:
        return Config.somethingWentWrong;
      default:
        return jsonString;
    }
  }

  AddWorkExperience(Map<String, dynamic> params, BuildContext context) async {
    final response =
        await apiServices.postApiCall(Config.addExperience, params, context);
    var jsonString = json.decode(response.body);
    print(jsonString);
    switch (response.statusCode) {
      case 200:
        return ADDWorkExperienceModel.fromJson(jsonString);
      case 404:
        return Config.somethingWentWrong;
      case 500:
        return Config.servernotreachable;
      case 400:
        return Config.somethingWentWrong;

      case 701:
        return Config.somethingWentWrong;
      default:
        return jsonString;
    }
  }

  GetWorkExperience(BuildContext context, String userUId) async {
    final response = await apiServices.getApiCallWithToken(
        '${Config.getExperience}?userUid=$userUId', context);
    var jsonString = json.decode(response.body);
    switch (response.statusCode) {
      case 200:
        return GetWorkExperienceModel.fromJson(jsonString);
      case 404:
        return Config.somethingWentWrong;
      case 500:
        return Config.servernotreachable;
      case 400:
        return Config.somethingWentWrong;
      case 701:
        return Config.somethingWentWrong;
      default:
        return jsonString;
    }
  }

  deleteWorkExperience(String workExperienceUid, BuildContext context) async {
    final response = await apiServices.deleteApiCall(
        "${Config.deleteExperience}?workExperienceUid=${workExperienceUid}",
        {},
        context);
    print(response);
    var jsonString = json.decode(response!.body);
    switch (response.statusCode) {
      case 200:
        return DeleteWorkExperienceModel.fromJson(jsonString);
      case 404:
        return Config.somethingWentWrong;
      case 500:
        return Config.servernotreachable;
      case 400:
        return Config.somethingWentWrong;
      case 701:
        return Config.somethingWentWrong;
      default:
        return jsonString;
    }
  }

  delete_story(BuildContext context, String storyUid) async {
    final response = await apiServices.deleteApiCallWithOutparams(
        '${Config.delete_story}?storyUid=${storyUid}', context);

    var jsonString = json.decode(response!.body);
    print(jsonString);
    switch (response.statusCode) {
      case 200:
        return DeleteStory.fromJson(jsonString);
      case 404:
        return Config.somethingWentWrong;
      case 500:
        return Config.servernotreachable;
      case 400:
        return Config.somethingWentWrong;
      case 701:
        return Config.somethingWentWrong;
      default:
        return jsonString;
    }
  }

  DMChatListApi(BuildContext context, String userChatInboxUid, int pageNumber,
      int numberOfRecords) async {
    final responce = await apiServices.getApiCallWithToken(
        '${Config.DMChatList}?userChatInboxUid=${userChatInboxUid}&pageNumber=${pageNumber}&numberOfRecords=${numberOfRecords}',
        context);
    var jsonString = json.decode(responce.body);

    switch (responce.statusCode) {
      case 200:
        return GetInboxMessagesModel.fromJson(jsonString);
      case 404:
        return Config.somethingWentWrong;
      case 500:
        return Config.servernotreachable;
      case 400:
        return Config.somethingWentWrong;
      case 701:
        return Config.somethingWentWrong;
      default:
        return jsonString;
    }
  }

  Blogcomment(BuildContext context, String blogID) async {
    final responce = await apiServices.getApiCallWithToken(
        '${Config.blogComment}?blogUid=${blogID}', context);
    var jsonString = json.decode(responce.body);
    print('jasonnString$jsonString');
    print('respnse ${responce.statusCode}');
    switch (responce.statusCode) {
      case 200:
        return BlogCommentModel.fromJson(jsonString);
      case 404:
        return Config.somethingWentWrong;
      case 500:
        return Config.servernotreachable;
      case 400:
        return Config.somethingWentWrong;
      case 701:
        return Config.somethingWentWrong;
      default:
        return jsonString;
    }
  }

  FirstTimeChat(
    BuildContext context,
    String? userWithUid,
  ) async {
    final response = await apiServices.postApiCalla(
        "${Config.create_user_chat}?userWithUid=${userWithUid}", context);
    print('AddPost$response');
    var jsonString = json.decode(response.body);
    switch (response.statusCode) {
      case 200:
        return OnTimeDMModel.fromJson(jsonString);
      case 404:
        return Config.somethingWentWrong;
      case 500:
        return Config.servernotreachable;
      case 400:
        return Config.somethingWentWrong;
      case 701:
        return Config.somethingWentWrong;
      default:
        return jsonString;
    }
  }

  BlogNewcomment(
    BuildContext context,
    Map<String, dynamic> params,
  ) async {
    final response =
        await apiServices.postApiCall(Config.addBlogcomments, params, context);
    print('AddPost$response');
    var jsonString = json.decode(response.body);
    switch (response.statusCode) {
      case 200:
        return jsonString;
      case 404:
        return Config.somethingWentWrong;
      case 500:
        return Config.servernotreachable;
      case 400:
        return Config.somethingWentWrong;
      case 701:
        return Config.somethingWentWrong;

      default:
        return jsonString;
    }
  }

  DeleteBlogcomment(
      String commentuid, String loginuser, BuildContext context) async {
    final response = await apiServices.deleteApiCallWithToken(
        "${Config.deleteBlogcomment}?commentUid=${commentuid}&loginUserUid=$loginuser",
        context);
    print(response);
    var jsonString = json.decode(response!.body);
    switch (response.statusCode) {
      case 200:
        return DeleteBlogCommentModel.fromJson(jsonString);
      case 404:
        return Config.somethingWentWrong;
      case 500:
        return Config.servernotreachable;
      case 400:
        return Config.somethingWentWrong;
      case 701:
        return Config.somethingWentWrong;
      default:
        return jsonString;
    }
  }

  DeleteUserDelete(String userChatInboxUid, BuildContext context) async {
    final response = await apiServices.deleteApiCallWithToken(
        "${Config.delete_user_chat}?userChatInboxUid=${userChatInboxUid}",
        context);
    print(response);
    var jsonString = json.decode(response!.body);
    switch (response.statusCode) {
      case 200:
        return DeleteUserChatModel.fromJson(jsonString);
      case 404:
        return Config.somethingWentWrong;
      case 500:
        return Config.servernotreachable;
      case 400:
        return Config.somethingWentWrong;
      case 701:
        return Config.somethingWentWrong;
      default:
        return jsonString;
    }
  }

  BlogLikeList(BuildContext context, String blogID, String? uuID) async {
    final responce = await apiServices.getApiCallWithToken(
        '${Config.blogLikeList}?blogUid=${blogID}&loginUserUid=${uuID}',
        context);
    var jsonString = json.decode(responce.body);
    print('jasonnString$jsonString');
    print('respnse ${responce.statusCode}');
    switch (responce.statusCode) {
      case 200:
        return BlogLikeListModel.fromJson(jsonString);
      case 404:
        return Config.somethingWentWrong;
      case 500:
        return Config.servernotreachable;
      case 400:
        return Config.somethingWentWrong;
      case 701:
        return Config.somethingWentWrong;
      default:
        return jsonString;
    }
  }

  get_UsersChatByUsername(
      String searchUsername, String pageNumber, BuildContext context) async {
    final respone = await apiServices.getApiCallWithToken(
        '${Config.get_UsersChatByUsername}?searchUsername=$searchUsername&pageNumber=$pageNumber&numberOfRecords=20',
        context);
    var jsonString = json.decode(respone.body);
    switch (respone.statusCode) {
      case 200:
        return GetUsersChatByUsername.fromJson(jsonString);
      case 404:
        return Config.somethingWentWrong;
      case 500:
        return Config.servernotreachable;
      case 400:
        return Config.somethingWentWrong;
      case 701:
        return Config.somethingWentWrong;
      default:
        return jsonString;
    }
  }

  selectMultipleUsers_Chat(
      Map<String, dynamic> params, BuildContext context) async {
    final respone = await apiServices.postApiCall(
        Config.selectMultipleUsers_Chat, params, context);
    var jsonString = json.decode(respone.body);
    print("dfhdsfhd-$jsonString");
    switch (respone.statusCode) {
      case 200:
        return SelectMultipleUsersChatModel.fromJson(jsonString);
      case 404:
        return Config.somethingWentWrong;
      case 500:
        return Config.servernotreachable;
      case 400:
        return Config.somethingWentWrong;
      case 701:
        return Config.somethingWentWrong;
      default:
        return jsonString;
    }
  }

  UserTag(BuildContext context, String? name) async {
    final responce = await apiServices.getApiCall(
        '${Config.userTag}?username=${name}', context);
    var jsonString = json.decode(responce.body);
    print('jasonnString$jsonString');
    print('respnse ${responce.statusCode}');
    switch (responce.statusCode) {
      case 200:
        return UserTagModel.fromJson(jsonString);
      case 404:
        return Config.somethingWentWrong;
      case 500:
        return Config.servernotreachable;
      case 400:
        return Config.somethingWentWrong;
      case 701:
        return Config.somethingWentWrong;
      default:
        return jsonString;
    }
  }

  get_all_inbox_images(
      BuildContext context, String userChatInboxUid, String pageNumber) async {
    final responce = await apiServices.getApiCallWithToken(
        '${Config.get_all_inbox_images}?userChatInboxUid=${userChatInboxUid}&pageNumber=${pageNumber}&numberOfRecords=20',
        context);
    var jsonString = json.decode(responce.body);
    print('jasonnString$jsonString');
    print('respnse ${responce.statusCode}');
    switch (responce.statusCode) {
      case 200:
        return GetAllInboxImages.fromJson(jsonString);
      case 404:
        return Config.somethingWentWrong;
      case 500:
        return Config.servernotreachable;
      case 400:
        return Config.somethingWentWrong;
      case 701:
        return Config.somethingWentWrong;
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