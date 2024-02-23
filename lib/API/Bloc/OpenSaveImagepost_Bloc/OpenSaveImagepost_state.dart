import 'package:pds/API/Model/OpenSaveImagepostModel/OpenSaveImagepost_Model.dart';
import 'package:pds/API/Model/RePost_Model/RePost_model.dart';
import 'package:pds/API/Model/UserTagModel/UserTag_model.dart';
import 'package:pds/API/Model/like_Post_Model/like_Post_Model.dart';

import '../../Model/Delete_Api_model/delete_api_model.dart';

abstract class OpenSaveState {}

class OpenSaveLoadingState extends OpenSaveState {}

class OpenSaveInitialState extends OpenSaveState {}

class OpenSaveLoadedState extends OpenSaveState {
  final OpenSaveImagepostModel OpenSaveData;
  OpenSaveLoadedState(this.OpenSaveData);
}

  class PostLikeLoadedState extends OpenSaveState {
    final LikePost likePost;
    PostLikeLoadedState(this.likePost);
  }

class RePostLoadedState extends OpenSaveState {
  final RePostModel RePost;
  RePostLoadedState(this.RePost);
}

class OpenSaveErrorState extends OpenSaveState {
  final dynamic error;
  OpenSaveErrorState(this.error);
}

class UserTagSaveLoadedState extends OpenSaveState {
  final UserTagModel userTagModel;
  UserTagSaveLoadedState(this.userTagModel);
}

class DeletePostLoadedState extends OpenSaveState {
  final DeletePostModel DeletePost;
  DeletePostLoadedState(this.DeletePost);
}
