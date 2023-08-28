import 'package:pds/API/Repo/repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../Model/delete_room_model/Delete_room_model.dart';
import 'Delete_room_state.dart';

class DeleteRoomCubit extends Cubit<DeleteRoomState> {
  DeleteRoomCubit() : super(DeleteRoomInitialState()) {}
  Future<void> DeleteRoomm(String roomuId, BuildContext context) async {
    dynamic DeleteRoom;
    try {
      emit(DeleteRoomLoadingState());
      DeleteRoom = await Repository().DeleteRoomApi(roomuId, context);
      if (DeleteRoom.success == true) {
        emit(DeleteRoomLoadedState(DeleteRoom));
      } else {
        emit(DeleteRoomErrorState(DeleteRoom.message));
      }
    } catch (e) {
      emit(DeleteRoomErrorState(DeleteRoom));
    }
  }
}
