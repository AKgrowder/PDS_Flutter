import 'package:pds/API/Bloc/dmInbox_bloc/dmMessageState.dart';
import 'package:pds/API/Repo/repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DmInboxCubit extends Cubit<getInboxState> {
  DmInboxCubit() : super(getInboxInitialState()) {}
  Future<void> DMChatListApiMethod(String userChatInboxUid, int pageNumber,
      int numberOfRecordsm, BuildContext context) async {
    dynamic DmInbox;
    try {
      emit(getInboxLoadingState());
      DmInbox = await Repository().DMChatListApi(
          context, userChatInboxUid, pageNumber, numberOfRecordsm);

      if (DmInbox.success == true) {
        emit(getInboxLoadedState(DmInbox));
      }
    } catch (e) {
      emit(getInboxErrorState(e.toString()));
    }
  }
  
}
