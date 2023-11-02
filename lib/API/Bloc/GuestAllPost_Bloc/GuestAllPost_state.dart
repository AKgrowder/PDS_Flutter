import 'package:pds/API/Model/CreateStory_Model/all_stories.dart';
import 'package:pds/API/Model/Delete_Api_model/delete_api_model.dart';
import 'package:pds/API/Model/GetGuestAllPostModel/GetGuestAllPost_Model.dart';
import 'package:pds/API/Model/createStroyModel/createStroyModel.dart';
import 'package:pds/API/Model/deletecomment/delete_comment_model.dart';
import 'package:pds/API/Model/like_Post_Model/like_Post_Model.dart';
import 'package:pds/API/Model/FetchAllExpertsModel/FetchAllExperts_Model.dart';
import 'package:pds/API/Model/myaccountModel/myaccountModel.dart';
import 'package:pds/API/Model/saveBlogModel/saveBlog_Model.dart';
import '../../Model/Get_all_blog_Model/get_all_blog_model.dart';
import '../../Model/HashTage_Model/HashTag_model.dart';

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

class DeletePostLoadedState extends GetGuestAllPostState {
  final DeletePostModel DeletePost;
  DeletePostLoadedState(this.DeletePost);
}

class GetUserProfileLoadedState extends GetGuestAllPostState {
  final MyAccontDetails myAccontDetails;

  GetUserProfileLoadedState(this.myAccontDetails);
}

class GetallblogsLoadedState extends GetGuestAllPostState {
  final GetallBlogModel getallBlogdata;
  GetallblogsLoadedState(this.getallBlogdata);
}

class saveBlogLoadedState extends GetGuestAllPostState {
  final saveBlogModel saveBlogModeData;
  saveBlogLoadedState(this.saveBlogModeData);
}

class likeBlogLoadedState extends GetGuestAllPostState {
  final saveBlogModel LikeBlogModeData;
  likeBlogLoadedState(this.LikeBlogModeData);
}
