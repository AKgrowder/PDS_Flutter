import 'package:pds/API/Model/Add_PostModel/Add_PostModel.dart';
import 'package:pds/API/Model/Add_PostModel/Add_postModel_Image.dart';
import 'package:pds/API/Model/HasTagModel/hasTagModel.dart';
import 'package:pds/API/Model/serchForInboxModel/serchForinboxModel.dart';

abstract class AddPostState {}
class AddPostLoadingState extends AddPostState {}
class AddPostInitialState extends AddPostState {}
class AddPostLoadedState extends AddPostState {
  final AddPost addPost;
  AddPostLoadedState(this.addPost);
}

class AddPostErrorState extends AddPostState {
  final dynamic error;
  AddPostErrorState(this.error);
}

class AddPostImaegState extends AddPostState {
  final ImageDataPost imageDataPost;
  AddPostImaegState(this.imageDataPost);
}

class GetAllHashtagState extends AddPostState {
  final HasDataModel getAllHashtag;
  GetAllHashtagState(this.getAllHashtag);
}
class SearchHistoryDataAddxtends extends AddPostState {
  final SearchUserForInbox searchUserForInbox;
  SearchHistoryDataAddxtends(this.searchUserForInbox);
}

