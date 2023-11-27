import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../Model/AddThread/CreateRoom_Model.dart';
import '../../Repo/repository.dart';
import 'CreatPublicRoom_state.dart';

class CreatPublicRoomCubit extends Cubit<CreatPublicRoomState> {
  CreatPublicRoomCubit() : super(CreatPublicRoomInitialState()) {}
  Future<void> CreatPublicRoomAPI(
      Map<String, String> params, BuildContext context) async {
    dynamic PublicRModel;
    try {
      emit(CreatPublicRoomLoadingState());
      PublicRModel = await Repository().CreatPublicRoom(params, context);
      if (PublicRModel == "Something Went Wrong, Try After Some Time.") {
        emit(CreatPublicRoomErrorState("${PublicRModel}"));
      } else {
      if (PublicRModel.success == true) {
        emit(CreatPublicRoomLoadedState(PublicRModel));
      }}
    } catch (e) {
      emit(CreatPublicRoomErrorState(PublicRModel));
    }
  }
}
