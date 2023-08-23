import 'package:archit_s_application1/API/Repo/repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../Model/Edit_room_model/edit_room_model.dart';
import 'Edit_room_state.dart';

class EditroomCubit extends Cubit<EditroomState> {
  EditroomCubit() : super(EditroomInitialState()) {}
  Future<void> Editroom(
      Map<String, dynamic> params, String roomuId, BuildContext context) async {
    dynamic editRoom;
    try {
      emit(EditroomLoadingState());
      editRoom = await Repository().EditroomAPI(params, roomuId, context);
      if (editRoom.success == true) {
        emit(EditroomLoadedState(editRoom));
      }
    } catch (e) {
      emit(EditroomErrorState(editRoom));
    }
  }
}
