import 'package:pds/API/Model/CreateStory_Model/all_stories.dart';
import 'package:pds/API/Model/GetGuestAllPostModel/GetGuestAllPost_Model.dart';
import 'package:pds/API/Model/createStroyModel/createStroyModel.dart';
import 'package:pds/API/Model/like_Post_Model/like_Post_Model.dart';
import 'package:pds/API/Model/FetchAllExpertsModel/FetchAllExperts_Model.dart';
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


class FetchAllExpertsLoadedState extends GetGuestAllPostState {
  final FetchAllExpertsModel AllExperData;
  FetchAllExpertsLoadedState(this.AllExperData);
} 
class GetAllStoryLoadedState extends GetGuestAllPostState {
  final GetAllStoryModel getAllStoryModel;
  GetAllStoryLoadedState(this.getAllStoryModel);
}

class CreateStoryLodedState extends GetGuestAllPostState {
  final CreateStroy createStroy;
  CreateStoryLodedState(this.createStroy);
}

 