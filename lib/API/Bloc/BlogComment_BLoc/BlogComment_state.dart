import '../../Model/BlogComment_Model/BlogCommentDelete_model.dart';
import '../../Model/BlogComment_Model/BlogComment_model.dart';

abstract class BlogCommentState {}

class BlogCommentLoadingState extends BlogCommentState {}

class BlogCommentInitialState extends BlogCommentState {}

class BlogCommentLoadedState extends BlogCommentState {
  final BlogCommentModel commentdata;
  BlogCommentLoadedState(this.commentdata);
}

class BlogCommentLoadedState1 extends BlogCommentState {
  final dynamic commentdata;
  BlogCommentLoadedState1(this.commentdata);
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
