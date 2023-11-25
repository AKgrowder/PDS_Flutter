 import 'package:pds/API/Bloc/SelectChat_bloc/SelectChat_state.dart';
import 'package:pds/API/Repo/repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SelectChatMemberListCubit extends Cubit<SelectChatMemberListState> {
  SelectChatMemberListCubit() : super(SelectChatMemberListInitialState()) {}
  Future<void> SelectChatMemberList(BuildContext context) async {
    dynamic SelectChatMemberListModel;
    try {
      emit(SelectChatMemberListLoadingState());
      SelectChatMemberListModel = await Repository().SelectChatMemberList(context);
      if (SelectChatMemberListModel == "Something Went Wrong, Try After Some Time.") {
        emit(SelectChatMemberListErrorState("${SelectChatMemberListModel}"));
      } else {
      if (SelectChatMemberListModel.success == true) {
        emit(SelectChatMemberListLoadedState(SelectChatMemberListModel));
      }}
    } catch (e) {
      emit(SelectChatMemberListErrorState(SelectChatMemberListModel));
    }
  }
}
