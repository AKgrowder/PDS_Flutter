import 'package:pds/API/Model/GetGuestAllPostModel/GetPostLike_Model.dart';
import 'package:pds/API/Model/like_Post_Model/like_Post_Model.dart';

abstract class GetPostAllLikeState {}

class GetGuestAllPostLoadingState extends GetPostAllLikeState {}

class GetGuestAllPostInitialState extends GetPostAllLikeState {}

class GetGuestAllPostLoadedState extends GetPostAllLikeState {
  final GetPostLikeModel GetPostAllLikeRoomData;
  GetGuestAllPostLoadedState(this.GetPostAllLikeRoomData);
}

class PostLikeLoadedState extends GetPostAllLikeState {
  final LikePost likePost;
  PostLikeLoadedState(this.likePost);
}

class GetGuestAllPostErrorState extends GetPostAllLikeState {
  final dynamic error;
  GetGuestAllPostErrorState(this.error);
}
