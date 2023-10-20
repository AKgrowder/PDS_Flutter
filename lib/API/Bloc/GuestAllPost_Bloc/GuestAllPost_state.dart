import 'package:pds/API/Model/CreateStory_Model/all_stories.dart';
import 'package:pds/API/Model/GetGuestAllPostModel/GetGuestAllPost_Model.dart';
import 'package:pds/API/Model/like_Post_Model/like_Post_Model.dart';

abstract class GetGuestAllPostState {}

class GetGuestAllPostLoadingState extends GetGuestAllPostState {}

class GetGuestAllPostInitialState extends GetGuestAllPostState {}

class GetGuestAllPostLoadedState extends GetGuestAllPostState {
  final GetGuestAllPostModel GetGuestAllPostRoomData;
  GetGuestAllPostLoadedState(this.GetGuestAllPostRoomData);
}

class GetGuestAllPostErrorState extends GetGuestAllPostState {
  final dynamic error;
  GetGuestAllPostErrorState(this.error);
}

class PostLikeLoadedState extends GetGuestAllPostState {
  final LikePost likePost;
  PostLikeLoadedState(this.likePost);
}


class GetAllStoryLoadedState extends GetGuestAllPostState {
  final GetAllStoryModel getAllStoryModel;
  GetAllStoryLoadedState(this.getAllStoryModel);
}

 