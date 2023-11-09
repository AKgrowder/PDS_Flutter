import 'package:pds/API/Model/FollwersModel/FllowersModel.dart';
import 'package:pds/API/Model/NewProfileScreenModel/GetAppUserPost_Model.dart';
import 'package:pds/API/Model/NewProfileScreenModel/GetSavePost_Model.dart';
import 'package:pds/API/Model/NewProfileScreenModel/GetUserPostCommet_Model.dart';
import 'package:pds/API/Model/NewProfileScreenModel/NewProfileScreen_Model.dart';
import 'package:pds/API/Model/aboutMeModel/aboutMeModel.dart';
import 'package:pds/API/Model/checkUserStatusModel/chekuserStausModel.dart';
import 'package:pds/API/Model/saveAllBlogModel/saveAllBlog_Model.dart';
import 'package:pds/API/Model/saveBlogModel/saveBlog_Model.dart';

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

class FollowersClass extends NewProfileSState {
  final FollowersClassModel followersClassModel;
  FollowersClass(this.followersClassModel);
}
class FollowersClass1 extends NewProfileSState {
  final FollowersClassModel followersClassModel1;
  FollowersClass1(this.followersClassModel1);
}

