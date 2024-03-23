import 'package:pds/API/Model/HasTagModel/hasTagModel.dart';
import 'package:pds/API/Model/UserTagModel/UserTag_model.dart';
import 'package:pds/API/Model/serchForInboxModel/serchForinboxModel.dart';

import '../../Model/BlogComment_Model/BlogCommentDelete_model.dart';
import '../../Model/BlogComment_Model/BlogComment_model.dart';
import '../../Model/BlogComment_Model/BlogLikeList_model.dart';
import '../../Model/like_Post_Model/like_Post_Model.dart';

abstract class BlogCommentState {}

class BlogCommentLoadingState extends BlogCommentState {}

class BlogCommentInitialState extends BlogCommentState {}

class BlogCommentLoadedState extends BlogCommentState {
  final BlogCommentModel commentdata;
  BlogCommentLoadedState(this.commentdata);
}

class BlogCommentErrorState extends BlogCommentState {
  final String error;
  BlogCommentErrorState(this.error);
}

class DeleteBlogcommentLoadedState extends BlogCommentState {
  final DeleteBlogCommentModel Deletecomment;
  DeleteBlogcommentLoadedState(this.Deletecomment);
}

class BlognewCommentLoadedState extends BlogCommentState {
  final dynamic BlognewCommentsModeldata;
  BlognewCommentLoadedState(this.BlognewCommentsModeldata);
}

class BlogLikelistLoadedState extends BlogCommentState {
  final BlogLikeListModel blogLikeListModel;
  BlogLikelistLoadedState(this.blogLikeListModel);
}

class PostLikeBlogLoadedState extends BlogCommentState {
  final LikePost likePost;
  PostLikeBlogLoadedState(this.likePost);
}
class UserTagBlogLoadedState extends BlogCommentState {
  final UserTagModel userTagModel;
  UserTagBlogLoadedState(this.userTagModel);
}

class GetAllHashtagState1 extends BlogCommentState {
  final HasDataModel getAllHashtag;
  GetAllHashtagState1(this.getAllHashtag);
}

class SearchHistoryDataAddxtends1 extends BlogCommentState {
  final SearchUserForInbox searchUserForInbox;
  SearchHistoryDataAddxtends1(this.searchUserForInbox);
}