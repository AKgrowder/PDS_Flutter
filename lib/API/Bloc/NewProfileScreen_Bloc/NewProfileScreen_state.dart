import 'package:pds/API/Model/FetchExprtiseModel/fetchExprtiseModel.dart';
import 'package:pds/API/Model/FollwersModel/FllowersModel.dart';
import 'package:pds/API/Model/IndustrytypeModel/Industrytype_Model.dart';
import 'package:pds/API/Model/NewProfileScreenModel/GetAppUserPost_Model.dart';
import 'package:pds/API/Model/NewProfileScreenModel/GetSavePost_Model.dart';
import 'package:pds/API/Model/NewProfileScreenModel/GetUserPostCommet_Model.dart';
import 'package:pds/API/Model/NewProfileScreenModel/NewProfileScreen_Model.dart';
import 'package:pds/API/Model/OnTimeDMModel/OnTimeDMModel.dart';
import 'package:pds/API/Model/RePost_Model/RePost_model.dart';
import 'package:pds/API/Model/UserTagModel/UserTag_model.dart';
import 'package:pds/API/Model/WorkExperience_Model/ADDExperience_model.dart';
import 'package:pds/API/Model/WorkExperience_Model/DeleteExperience_model.dart';
import 'package:pds/API/Model/WorkExperience_Model/WorkExperience_model.dart';
import 'package:pds/API/Model/aboutMeModel/aboutMeModel.dart';
import 'package:pds/API/Model/checkUserStatusModel/chekuserStausModel.dart';
import 'package:pds/API/Model/get_assigned_users_of_company_pageModel/get_assigned_users_of_company_pageModel.dart';
import 'package:pds/API/Model/getall_compeny_page_model/getall_compeny_page.dart';
import 'package:pds/API/Model/like_Post_Model/like_Post_Model.dart';
import 'package:pds/API/Model/saveAllBlogModel/saveAllBlog_Model.dart';
import 'package:pds/API/Model/saveBlogModel/saveBlog_Model.dart';

import '../../Model/Delete_Api_model/delete_api_model.dart';
import '../../Model/HasTagModel/hasTagModel.dart';
import '../../Model/serchForInboxModel/serchForinboxModel.dart';

abstract class NewProfileSState {}

class NewProfileSLoadingState extends NewProfileSState {}

class NewProfileSInitialState extends NewProfileSState {}

class NewProfileSLoadedState extends NewProfileSState {
  final NewProfileScreen_Model PublicRoomData;
  NewProfileSLoadedState(this.PublicRoomData);
}

class NewProfileSErrorState extends NewProfileSState {
  final String error;
  NewProfileSErrorState(this.error);
}

class GetAppPostByUserLoadedState extends NewProfileSState {
  final GetAppUserPostModel GetAllPost;
  GetAppPostByUserLoadedState(this.GetAllPost);
}

class GetUserPostCommetLoadedState extends NewProfileSState {
  final GetUserPostCommetModel GetUserPostCommet;
  GetUserPostCommetLoadedState(this.GetUserPostCommet);
}

class GetSavePostLoadedState extends NewProfileSState {
  final GetSavePostModel GetSavePost;
  GetSavePostLoadedState(this.GetSavePost);
}

class AboutMeLoadedState extends NewProfileSState {
  final AboutMe aboutMe;
  AboutMeLoadedState(this.aboutMe);
}

class AboutMeLoadedState1 extends NewProfileSState {
  final AboutMe aboutMe;
  AboutMeLoadedState1(this.aboutMe);
}

class saveAllBlogModelLoadedState1 extends NewProfileSState {
  final saveAllBlogModel saveAllBlogModelData;
  saveAllBlogModelLoadedState1(this.saveAllBlogModelData);
}

class ProfilesaveBlogLoadedState extends NewProfileSState {
  final saveBlogModel saveAllBlogModelData;
  ProfilesaveBlogLoadedState(this.saveAllBlogModelData);
}

class ProfilelikeBlogLoadedState extends NewProfileSState {
  final saveBlogModel saveAllBlogModelData;
  ProfilelikeBlogLoadedState(this.saveAllBlogModelData);
}

class PostLikeLoadedState extends NewProfileSState {
  final LikePost likePost;
  PostLikeLoadedState(this.likePost);
}

class FollowersClass extends NewProfileSState {
  final FollowersClassModel followersClassModel;
  FollowersClass(this.followersClassModel);
}

class FollowersClass1 extends NewProfileSState {
  final FollowersClassModel followersClassModel1;
  FollowersClass1(this.followersClassModel1);
}

class FetchexprtiseRoomLoadedState extends NewProfileSState {
  final FetchExprtise fetchExprtise;
  FetchexprtiseRoomLoadedState(this.fetchExprtise);
}

class IndustryTypeLoadedState extends NewProfileSState {
  final IndustryTypeModel industryTypeModel;
  IndustryTypeLoadedState(this.industryTypeModel);
}

class AddWorkExpereinceLoadedState extends NewProfileSState {
  final ADDWorkExperienceModel addWorkExperienceModel;
  AddWorkExpereinceLoadedState(this.addWorkExperienceModel);
}

class GetWorkExpereinceLoadedState extends NewProfileSState {
  final GetWorkExperienceModel addWorkExperienceModel;
  GetWorkExpereinceLoadedState(this.addWorkExperienceModel);
}

class DeleteWorkExpereinceLoadedState extends NewProfileSState {
  final DeleteWorkExperienceModel deleteWorkExperienceModel;
  DeleteWorkExpereinceLoadedState(this.deleteWorkExperienceModel);
}

class DMChatListLoadedState extends NewProfileSState {
  final OnTimeDMModel DMChatList;
  DMChatListLoadedState(this.DMChatList);
}
class SearchHistoryDataAddxtends extends NewProfileSState {
  final SearchUserForInbox searchUserForInbox;
  SearchHistoryDataAddxtends(this.searchUserForInbox);
}

class GetAllHashtagState extends NewProfileSState {
  final HasDataModel getAllHashtag;
  GetAllHashtagState(this.getAllHashtag);
}
class AddPostErrorState extends NewProfileSState {
  final dynamic error;
  AddPostErrorState(this.error);
}

class UserTagLoadedState extends NewProfileSState {
  final UserTagModel userTagModel;
  UserTagLoadedState(this.userTagModel);
}

class RePostLoadedState extends NewProfileSState {
  final RePostModel RePost;
  RePostLoadedState(this.RePost);
}
class DeletePostLoadedState extends NewProfileSState {
  final DeletePostModel DeletePost;
  DeletePostLoadedState(this.DeletePost);
}


class Getallcompenypagelodedstate extends NewProfileSState {
  final GetAllCompenyPageModel getallcompenypagemodel;
  Getallcompenypagelodedstate(this.getallcompenypagemodel);
}


class GetAssignedUsersOfCompanyPageLoadedState extends NewProfileSState {
  final GetAssignedUsersOfCompanyPage getAssignedUsersOfCompanyPage;
  GetAssignedUsersOfCompanyPageLoadedState(this.getAssignedUsersOfCompanyPage);
}

