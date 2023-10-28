import 'package:pds/API/Model/NewProfileScreenModel/GetAppUserPost_Model.dart';
import 'package:pds/API/Model/NewProfileScreenModel/GetSavePost_Model.dart';
import 'package:pds/API/Model/NewProfileScreenModel/GetUserPostCommet_Model.dart';
import 'package:pds/API/Model/NewProfileScreenModel/NewProfileScreen_Model.dart';
import 'package:pds/API/Model/aboutMeModel/aboutMeModel.dart';
import 'package:pds/API/Model/checkUserStatusModel/chekuserStausModel.dart';

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
