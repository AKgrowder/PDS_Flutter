import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../Model/FetchAllExpertsModel/FetchAllExperts_Model.dart';
import '../../Model/HomeScreenModel/PublicRoomModel.dart';
import '../../Repo/repository.dart';
import 'Fatch_PRoom_state.dart';

class FetchAllPublicRoomCubit extends Cubit<FetchAllPublicRoomState> {
  FetchAllPublicRoomCubit() : super(FetchAllPublicRoomInitialState()) {}
  Future<void> FetchAllPublicRoom(BuildContext context) async {
    dynamic PublicRModel;
    try {
      emit(FetchAllPublicRoomLoadingState());
      PublicRModel = await Repository().FetchAllPublicRoom(context);
      if (PublicRModel.success == true) {
        emit(FetchAllPublicRoomLoadedState(PublicRModel));
      }
    } catch (e) {
      emit(FetchAllPublicRoomErrorState(PublicRModel));
    }
  }

  Future<void> FetchAllExpertsAPI(BuildContext context) async {
    dynamic PublicRModel;
    try {
      emit(FetchAllPublicRoomLoadingState());
      PublicRModel = await Repository().FetchAllExpertsAPI(context);
      if (PublicRModel.success == true) {
        emit(FetchAllExpertsLoadedState(PublicRModel));
      }
    } catch (e) {
      emit(FetchAllPublicRoomErrorState(PublicRModel));
    }
  }

   Future<void> chckUserStaus(BuildContext context) async {
    dynamic checkUserStausModel;
    try {
      emit(FetchAllPublicRoomLoadingState());
      checkUserStausModel = await Repository().checkUserActive(context);
      if (checkUserStausModel.success == true) {
        emit(CheckuserLoadedState(checkUserStausModel));
      }
    } catch (e) {
      emit(FetchAllPublicRoomErrorState(checkUserStausModel));
    }
  }

  Future<void> FetchPublicRoom(String uuid,BuildContext context) async {
    dynamic FetchPublicRoomModel;
    try {
      emit(FetchAllPublicRoomLoadingState());
      FetchPublicRoomModel = await Repository().FetchPublicRoom(uuid,context);
      if (FetchPublicRoomModel.success == true) {
        emit(FetchPublicRoomLoadedState(FetchPublicRoomModel));
      }
    } catch (e) {
      emit(FetchAllPublicRoomErrorState(FetchPublicRoomModel));
    }
  }
}
