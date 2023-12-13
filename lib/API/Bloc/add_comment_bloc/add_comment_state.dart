import 'package:pds/API/Model/Add_comment_model/add_comment_model.dart';
import 'package:pds/API/Model/HasTagModel/hasTagModel.dart';
import 'package:pds/API/Model/deletecomment/delete_comment_model.dart';
import 'package:pds/API/Model/serchForInboxModel/serchForinboxModel.dart';

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

class DeletecommentLoadedState extends AddCommentState {
  final DeleteCommentModel Deletecomment;
  DeletecommentLoadedState(this.Deletecomment);
}

//-------------------------

class AddnewCommentLoadedState extends AddCommentState {
  final dynamic addnewCommentsModeldata;
  AddnewCommentLoadedState(this.addnewCommentsModeldata);
}

class GetAllHashtagState extends AddCommentState {
  final HasDataModel getAllHashtag;
  GetAllHashtagState(this.getAllHashtag);
}

class SearchHistoryDataAddxtends extends AddCommentState {
  final SearchUserForInbox searchUserForInbox;
  SearchHistoryDataAddxtends(this.searchUserForInbox);
}
