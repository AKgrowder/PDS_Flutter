import 'package:pds/API/Repo/repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'SelectRoom_state.dart';

class SelectedRoomCubit extends Cubit<SelectedRoomState> {
  SelectedRoomCubit() : super(SelectedRoomInitialState()) {}
  Future<void> SelectedRoomApi(
       BuildContext context) async {
    dynamic SelectedRoom;
    try {
      emit(SelectedRoomLoadingState());
      SelectedRoom = await Repository().SelectRoomAPI(context);
      if (SelectedRoom.success == true) {
        emit(SelectedRoomLoadedState(SelectedRoom));
      }
    } catch (e) {
      emit(SelectedRoomErrorState(SelectedRoom));
    }
  }

    Future<void> sherInviteApi2(
      String userRoomId, String email, BuildContext context) async {
    dynamic sherInvite;
    try {
      emit(SelectedRoomLoadingState());
      sherInvite = await Repository().sherInvite(userRoomId, email, context);
      if (sherInvite.success == true) {
        emit(SherInvite2LoadedState(sherInvite));
      }else{
       emit(SelectedRoomErrorState(sherInvite.message));
      }
    } catch (e) {
      emit(SelectedRoomErrorState(sherInvite));
    }
  }
}


// class SelectedRoomLoadedState extends GetAllPrivateRoomState {
//   final SelectedRoom SelectedRoom;
//   SelectedRoomLoadedState(this.SelectedRoom);
// }
