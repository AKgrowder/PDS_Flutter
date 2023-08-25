import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../Repo/repository.dart';
import 'GetAllPrivateRoom_state.dart';

class GetAllPrivateRoomCubit extends Cubit<GetAllPrivateRoomState> {
  GetAllPrivateRoomCubit() : super(GetAllPrivateRoomInitialState()) {}
  Future<void> GetAllPrivateRoomAPI(BuildContext context) async {
    dynamic PublicRModel;
    try {
      emit(GetAllPrivateRoomLoadingState());
      PublicRModel = await Repository().GetAllPrivateRoom(context);
      if (PublicRModel.success == true) {
        emit(GetAllPrivateRoomLoadedState(PublicRModel));
      }
    } catch (e) {
      emit(GetAllPrivateRoomErrorState(PublicRModel));
    }
  }

  Future<void> DeleteRoomm(String roomuId, BuildContext context) async {
    dynamic GetAllPrivateRoom;
    try {
      emit(GetAllPrivateRoomLoadingState());
      GetAllPrivateRoom = await Repository().DeleteRoomApi(roomuId, context);
      if (GetAllPrivateRoom.success == true) {
        emit(DeleteRoomLoadedState(GetAllPrivateRoom));
      }
    } catch (e) {
      emit(GetAllPrivateRoomErrorState(GetAllPrivateRoom));
    }
  }

  Future<void> chckUserStaus(BuildContext context) async {
    dynamic checkUserStausModel;
    try {
      emit(GetAllPrivateRoomLoadingState());
      checkUserStausModel = await Repository().checkUserActive(context);
      if (checkUserStausModel.success == true) {
        emit(CheckuserLoadedState(checkUserStausModel));
      }
    } catch (e) {
      emit(GetAllPrivateRoomErrorState(checkUserStausModel));
    }
  }
  

  Future<void> Fetchroomdetails(String userId, BuildContext context) async {
    dynamic fetchRoomDetailModel;
    try {
      emit(GetAllPrivateRoomLoadingState());
      fetchRoomDetailModel =
          await Repository().fetchRoomDetails(userId, context);
      if (fetchRoomDetailModel.success == true) {
        emit(FetchRoomDetailLoadedState(fetchRoomDetailModel));
      }
    } catch (e) {
      emit(GetAllPrivateRoomErrorState(fetchRoomDetailModel));
    }
  }
}
