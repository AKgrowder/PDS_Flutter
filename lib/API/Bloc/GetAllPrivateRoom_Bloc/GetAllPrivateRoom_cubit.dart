import 'package:archit_s_application1/API/Model/checkUserStatusModel/chekuserStausModel.dart';
import 'package:archit_s_application1/API/Model/delete_room_model/Delete_room_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../Model/GetAllPrivateRoom/GetAllPrivateRoom_Model.dart';
import '../../Repo/repository.dart';
import 'GetAllPrivateRoom_state.dart';

class GetAllPrivateRoomCubit extends Cubit<GetAllPrivateRoomState> {
  GetAllPrivateRoomCubit() : super(GetAllPrivateRoomInitialState()) {}
  Future<void> GetAllPrivateRoomAPI() async {
    try {
      emit(GetAllPrivateRoomLoadingState());
      GetAllPrivateRoomModel PublicRModel =
          await Repository().GetAllPrivateRoom();
      if (PublicRModel.success == true) {
        emit(GetAllPrivateRoomLoadedState(PublicRModel));
      } else {
        // emit(GetAllPrivateRoomErrorState('No Data Found!'));
        emit(GetAllPrivateRoomErrorState('${PublicRModel.message}'));
      }
    } catch (e) {
      emit(GetAllPrivateRoomErrorState(e.toString()));
    }
  }

  Future<void> DeleteRoomm(String roomuId) async {
    try {
      emit(GetAllPrivateRoomLoadingState());
      DeleteRoomModel GetAllPrivateRoom =
          await Repository().DeleteRoomApi(roomuId);
      if (GetAllPrivateRoom.success == true) {
        emit(DeleteRoomLoadedState(GetAllPrivateRoom));
      } else {
        emit(GetAllPrivateRoomErrorState(GetAllPrivateRoom.message.toString()));
      }
    } catch (e) {
      emit(GetAllPrivateRoomErrorState(e.toString()));
    }
  }

  Future<void> chckUserStaus() async {
    try {
      emit(GetAllPrivateRoomLoadingState());
      CheckUserStausModel checkUserStausModel =
          await Repository().checkUserActive();
      if (checkUserStausModel.success == true) {
        emit(CheckuserLoadedState(checkUserStausModel));
      } else {
        emit(GetAllPrivateRoomErrorState(
            checkUserStausModel.message.toString()));
      }
    } catch (e) {
      emit(GetAllPrivateRoomErrorState(e.toString()));
    }
  }
}
