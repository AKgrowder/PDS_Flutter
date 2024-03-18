import 'package:pds/API/Model/Delete_Api_model/delete_api_model.dart';
import 'package:pds/API/Model/Getalluset_list_Model/get_all_userlist_model.dart';
import 'package:pds/API/Model/HashTage_Model/HashTagBanner_model.dart';
import 'package:pds/API/Model/HashTage_Model/HashTagView_model.dart';
import 'package:pds/API/Model/HashTage_Model/HashTag_model.dart';
import 'package:pds/API/Model/SearchPagesModel/SearchPagesModel.dart';
import 'package:pds/API/Model/UserTagModel/UserTag_model.dart';
import 'package:pds/API/Model/acceptRejectInvitaionModel/getAllNotificationCount.dart';
import 'package:pds/API/Model/getSerchDataModel/getSerchDataModel.dart';
import 'package:pds/API/Model/like_Post_Model/like_Post_Model.dart';
import 'package:pds/API/Model/serchDataAddModel/serchDataAddModel.dart';

import '../../Model/GetGuestAllPostModel/GetGuestAllPost_Model.dart';

abstract class HashTagState {}

class HashTagLoadingState extends HashTagState {}

class HashTagInitialState extends HashTagState {}

class HashTagLoadedState extends HashTagState {
  final HashtagModel HashTagData;
  HashTagLoadedState(this.HashTagData);
}

class HashTagViewDataLoadedState extends HashTagState {
  final HashtagViewDataModel HashTagViewData;
  HashTagViewDataLoadedState(this.HashTagViewData);
}

class PostLikeLoadedState extends HashTagState {
  final LikePost likePost;
  PostLikeLoadedState(this.likePost);
}

class DeletePostLoadedState extends HashTagState {
  final DeletePostModel DeletePost;
  DeletePostLoadedState(this.DeletePost);
}

class GetGuestAllPostLoadedState extends HashTagState {
  final GetGuestAllPostModel GetGuestAllPostRoomData;
  GetGuestAllPostLoadedState(this.GetGuestAllPostRoomData);
}

class HashTagErrorState extends HashTagState {
  final dynamic error;
  HashTagErrorState(this.error);
}

class GetAllUserLoadedState extends HashTagState {
  final GetAllUserListModel getAllUserRoomData;
  GetAllUserLoadedState(this.getAllUserRoomData);
}

class HashTagBannerLoadedState extends HashTagState {
  final HashTagImageModel hashTagImageModel;
  HashTagBannerLoadedState(this.hashTagImageModel);
}

class SerchDataAddClass extends HashTagState {
  final SerchDataAdd serchDataAdd;
  SerchDataAddClass(this.serchDataAdd);
}

class GetSerchData extends HashTagState {
  final GetDataInSerch getDataInSerch;
  GetSerchData(this.getDataInSerch);
}

class UserTagHashTagLoadedState extends HashTagState {
  final UserTagModel userTagModel;
  UserTagHashTagLoadedState(this.userTagModel);
}

class GetNotificationCountLoadedState extends HashTagState {
  final getAllNotificationCount GetNotificationCountData;
  GetNotificationCountLoadedState(this.GetNotificationCountData);
}



class SearchPagesLoadedState extends HashTagState {
  final SearchPages serchPages;
  SearchPagesLoadedState(this.serchPages);
}