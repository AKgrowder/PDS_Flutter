

 
import 'package:pds/API/Model/PersonalChatListModel/SelectChatMember_Model.dart';

abstract class SelectChatMemberListState {}

class SelectChatMemberListLoadingState extends SelectChatMemberListState {}

class SelectChatMemberListInitialState extends SelectChatMemberListState {}

class SelectChatMemberListLoadedState extends SelectChatMemberListState {
  final SelectChatMemberModel SelectChatMemberListModelData;
  SelectChatMemberListLoadedState(this.SelectChatMemberListModelData);
}

class SelectChatMemberListErrorState extends SelectChatMemberListState {
  final dynamic error;
  SelectChatMemberListErrorState(this.error);
}


 