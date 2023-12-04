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
}
