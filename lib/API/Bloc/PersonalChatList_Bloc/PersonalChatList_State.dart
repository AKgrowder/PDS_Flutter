import 'package:pds/API/Model/GetUsersChatByUsernameModel/GetUsersChatByUsernameModel.dart';
import 'package:pds/API/Model/OnTimeDMModel/OnTimeDMModel.dart';
import 'package:pds/API/Model/PersonalChatListModel/PersonalChatList_Model.dart';
import 'package:pds/API/Model/serchForInboxModel/serchForinboxModel.dart';

abstract class PersonalChatListState {}

class PersonalChatListLoadingState extends PersonalChatListState {}

class PersonalChatListInitialState extends PersonalChatListState {}

class PersonalChatListLoadedState extends PersonalChatListState {
  final PersonalChatListModel PersonalChatListModelData;
  PersonalChatListLoadedState(this.PersonalChatListModelData);
}

class PersonalChatListErrorState extends PersonalChatListState {
  final dynamic error;
  PersonalChatListErrorState(this.error);
}

class SearchHistoryDataAddxtends extends PersonalChatListState {
  final SearchUserForInbox searchUserForInbox;
  SearchHistoryDataAddxtends(this.searchUserForInbox);
}

class DMChatListLoadedState extends PersonalChatListState {
  final OnTimeDMModel DMChatList;
  DMChatListLoadedState(this.DMChatList);
}

class GetUsersChatByUsernameLoaded extends PersonalChatListState {
  final GetUsersChatByUsername getUsersChatByUsername;
  GetUsersChatByUsernameLoaded(this.getUsersChatByUsername);
}
