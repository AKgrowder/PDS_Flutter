import 'package:pds/API/Bloc/PersonalChatList_Bloc/PersonalChatList_State.dart';
import 'package:pds/API/Repo/repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PersonalChatListCubit extends Cubit<PersonalChatListState> {
  PersonalChatListCubit() : super(PersonalChatListInitialState()) {}
  Future<void> PersonalChatList(BuildContext context) async {
    dynamic PersonalChatListModel;
    try {
      emit(PersonalChatListLoadingState());
      PersonalChatListModel = await Repository().PersonalChatList(context);
      if (PersonalChatListModel == "Something Went Wrong, Try After Some Time.") {
        emit(PersonalChatListErrorState("${PersonalChatListModel}"));
      } else {
      if (PersonalChatListModel.success == true) {
        emit(PersonalChatListLoadedState(PersonalChatListModel));
      }}
    } catch (e) {
      emit(PersonalChatListErrorState(PersonalChatListModel));
    }
  }
}
