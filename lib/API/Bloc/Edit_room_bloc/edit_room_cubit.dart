import 'package:pds/API/Repo/repository.dart';
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
      if (editRoom == "Something Went Wrong, Try After Some Time.") {
        emit(EditroomErrorState("${editRoom}"));
      } else {
        if (editRoom.success == true) {
          emit(EditroomLoadedState(editRoom));
        } else {
          emit(EditroomErrorState(editRoom.message));
        }
      }
    } catch (e) {
      emit(EditroomErrorState(editRoom));
    }
  }
}
