import 'package:pds/API/Model/Add_PostModel/Add_PostModel.dart';
import 'package:pds/API/Model/Add_PostModel/Add_postModel_Image.dart';
import 'package:pds/API/Model/HasTagModel/hasTagModel.dart';
import 'package:pds/API/Model/RePost_Model/RePost_model.dart';
import 'package:pds/API/Model/UserTagModel/UserTag_model.dart';
import 'package:pds/API/Model/serchForInboxModel/serchForinboxModel.dart';

abstract class RePostState {}

class RePostLoadingState extends RePostState {}

class RePostInitialState extends RePostState {}

class RePostLoadedState extends RePostState {
  final RePostModel RePost;
  RePostLoadedState(this.RePost); 
}

class RePostErrorState extends RePostState {
  final dynamic error;
  RePostErrorState(this.error);
}
class AddPostImaegState extends RePostState {
 final ImageDataPost imageDataPost;
  AddPostImaegState(this.imageDataPost);
}

class UserTagSaveLoadedState extends RePostState {
  final UserTagModel userTagModel;
  UserTagSaveLoadedState(this.userTagModel);
}

class GetAllHashtagState extends RePostState {
  final HasDataModel getAllHashtag;
  GetAllHashtagState(this.getAllHashtag);
}
class SearchHistoryDataAddxtends extends RePostState {
  final SearchUserForInbox searchUserForInbox;
  SearchHistoryDataAddxtends(this.searchUserForInbox);
}
