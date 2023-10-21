import 'package:pds/API/Model/Add_comment_model/add_comment_model.dart';

abstract class AddCommentState {}

class AddCommentLoadingState extends AddCommentState {}

class AddCommentInitialState extends AddCommentState {}

class AddCommentLoadedState extends AddCommentState {
  final AddCommentModel commentdata;
  AddCommentLoadedState(this.commentdata);
}

class AddCommentErrorState extends AddCommentState {
  final String error;
  AddCommentErrorState(this.error);
}

//-------------------------

class AddnewCommentLoadedState extends AddCommentState {
  final dynamic addnewCommentsModeldata;
  AddnewCommentLoadedState(this.addnewCommentsModeldata);
}
