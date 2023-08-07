import 'package:archit_s_application1/API/Repo/repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../Model/Edit_room_model/edit_room_model.dart';
import 'Edit_room_state.dart';

class EditroomCubit extends Cubit<EditroomState> {
  EditroomCubit() : super(EditroomInitialState()) {}
  Future<void> Editroom(
    Map<String, dynamic> params,
    String roomuId,
  ) async {
    try {
      emit(EditroomLoadingState());
      EditRoomModel editRoom = await Repository().EditroomAPI(params,roomuId);
      if (editRoom.success == true) {
        emit(EditroomLoadedState(editRoom));
      } else {
        emit(EditroomErrorState(editRoom.message.toString()));
      }
    } catch (e) {
      emit(EditroomErrorState(e.toString()));
    }
  }
}
