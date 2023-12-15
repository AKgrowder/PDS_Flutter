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
