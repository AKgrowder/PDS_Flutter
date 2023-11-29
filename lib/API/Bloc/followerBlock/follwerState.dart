import 'package:pds/API/Model/like_Post_Model/like_Post_Model.dart';
import 'package:pds/API/Model/removeFolloweModel/removeFollowerModel.dart';

abstract class FolllwerBlockState {}

class FollwertBlockLoadingState extends FolllwerBlockState {}

class FollwertBlockInitialState extends FolllwerBlockState {}

class FollwertBlockLoadedState extends FolllwerBlockState {
  /*  final FollwertBlockModel FollwertBlock;
  FollwertBlockLoadedState(this.FollwertBlock); */
}

class FollwertErrroState extends FolllwerBlockState {
  String? error;
  FollwertErrroState(this.error);
}

class RemoveLoddingState extends FolllwerBlockState {
  Remove_Follower? remove_Follower;
  RemoveLoddingState(this.remove_Follower);
}

class PostLikeLoadedState extends FolllwerBlockState {
  final LikePost likePost;
  PostLikeLoadedState(this.likePost);
}
