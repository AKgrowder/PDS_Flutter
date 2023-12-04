import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pds/API/Bloc/RoomExists_bloc/RoomExists_state.dart';
import 'package:pds/API/Bloc/System_Config_Bloc/system_config_state.dart';
import 'package:pds/API/Repo/repository.dart';

class RoomExistsCubit extends Cubit<RoomExistsState> {
  RoomExistsCubit() : super(RoomExistsInitialState()) {}
  Future<void> RoomExistsAPI(
      String? otherMemberID, String roomID, BuildContext context) async {
    dynamic roomExistsModel;
    try {
      emit(RoomExistsLoadingState());
      roomExistsModel =
          await Repository().roomExists(otherMemberID, roomID, context);
      if (roomExistsModel == "Something Went Wrong, Try After Some Time.") {
        emit(RoomExistsErrorState("${roomExistsModel}"));
      } else {
        if (roomExistsModel.success == true) {
          emit(RoomExistsLoadedState(roomExistsModel));
        }
      }
    } catch (e) {
      emit(RoomExistsErrorState(roomExistsModel));
    }
  }

   Future<void> DeleteRoommin(String roomuId, BuildContext context) async {
    dynamic GetAllPrivateRoom;
    try {
      emit(RoomExistsLoadingState());
      GetAllPrivateRoom = await Repository().DeleteRoomApi(roomuId, context);
      if (GetAllPrivateRoom == "Something Went Wrong, Try After Some Time.") {
        emit(RoomExistsErrorState("${GetAllPrivateRoom}"));
      } else {
        if (GetAllPrivateRoom.success == true) {
          emit(DeleteRoomLoadedState(GetAllPrivateRoom));
        } else {
          emit(RoomExistsErrorState(GetAllPrivateRoom.message));
        }
      }
    } catch (e) {
      emit(RoomExistsErrorState(GetAllPrivateRoom));
    }
  }
}
