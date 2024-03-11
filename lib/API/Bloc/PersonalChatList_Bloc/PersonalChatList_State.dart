import 'package:pds/API/Model/Add_PostModel/Add_postModel_Image.dart';
import 'package:pds/API/Model/DeleteUserChatModel/DeleteUserChat_Model.dart';
import 'package:pds/API/Model/GetUsersChatByUsernameModel/GetUsersChatByUsernameModel.dart';
import 'package:pds/API/Model/OnTimeDMModel/OnTimeDMModel.dart';
import 'package:pds/API/Model/PersonalChatListModel/PersonalChatList_Model.dart';
import 'package:pds/API/Model/acceptRejectInvitaionModel/accept_rejectModel.dart';
import 'package:pds/API/Model/acceptRejectInvitaionModel/getAllNotificationCount.dart';
import 'package:pds/API/Model/createDocumentModel/createDocumentModel.dart';
import 'package:pds/API/Model/forwad_Meesage/forwad_Message.dart';
import 'package:pds/API/Model/selectMultipleUsers_ChatModel/selectMultipleUsers_ChatModel.dart';
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

class SelectMultipleUsers_ChatLoadestate extends PersonalChatListState {
  final SelectMultipleUsersChatModel selectMultipleUsersChatModel;
  SelectMultipleUsers_ChatLoadestate(this.selectMultipleUsersChatModel);
}

class AddPostImaegState extends PersonalChatListState {
  final ChooseDocument1 imageDataPost;
  AddPostImaegState(this.imageDataPost);
}

class UserChatDeleteLoaded extends PersonalChatListState {
  final DeleteUserChatModel DeleteUserChatData;
  UserChatDeleteLoaded(this.DeleteUserChatData);
}

class GetNotificationCountLoadedState extends PersonalChatListState {
  final getAllNotificationCount GetNotificationCountData;
  GetNotificationCountLoadedState(this.GetNotificationCountData);
}

class OnlineChatStatusLoadedState extends PersonalChatListState {
  final accept_rejectModel accept_rejectModelData;
  OnlineChatStatusLoadedState(this.accept_rejectModelData);
}

class ForwadMessageLoadedState extends PersonalChatListState {
  final ForwardMessages forwardMessages;
  ForwadMessageLoadedState(this.forwardMessages);
}
