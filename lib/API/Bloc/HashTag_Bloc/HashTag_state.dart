import 'package:pds/API/Model/Delete_Api_model/delete_api_model.dart';
import 'package:pds/API/Model/Getalluset_list_Model/get_all_userlist_model.dart';
import 'package:pds/API/Model/HashTage_Model/HashTagBanner_model.dart';
import 'package:pds/API/Model/HashTage_Model/HashTagView_model.dart';
import 'package:pds/API/Model/HashTage_Model/HashTag_model.dart';
import 'package:pds/API/Model/like_Post_Model/like_Post_Model.dart';

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

class SerchDataAdd extends HashTagState {
  final SerchDataAdd serchDataAdd;
  SerchDataAdd(this.serchDataAdd);
}
