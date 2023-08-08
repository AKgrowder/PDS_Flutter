import 'package:archit_s_application1/API/Repo/repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../Model/delete_room_model/Delete_room_model.dart';
import 'Delete_room_state.dart';

class DeleteRoomCubit extends Cubit<DeleteRoomState> {
  DeleteRoomCubit() : super(DeleteRoomInitialState()) {}
  Future<void> DeleteRoomm(String roomuId) async {
    try {
      emit(DeleteRoomLoadingState());
      DeleteRoomModel DeleteRoom = await Repository().DeleteRoomApi(roomuId);
      if (DeleteRoom.success == true) {
        emit(DeleteRoomLoadedState(DeleteRoom));
      } else {
        emit(DeleteRoomErrorState(DeleteRoom.message.toString()));
      }
    } catch (e) {
      emit(DeleteRoomErrorState(e.toString()));
    }
  }
}
