import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../Repo/repository.dart';
import 'CreateRoom_state.dart';

class CreateRoomCubit extends Cubit<CreateRoomState> {
  CreateRoomCubit() : super(CreateRoomInitialState()) {}
  Future<void> CreateRoomAPI(
      Map<String, String> params, BuildContext context) async {
    dynamic PublicRModel;
    try {
      emit(CreateRoomLoadingState());
      PublicRModel = await Repository().CreateRoomAPI(params, context);
      if (PublicRModel == "Something Went Wrong, Try After Some Time.") {
        emit(CreateRoomErrorState("${PublicRModel}"));
      } else {
      if (PublicRModel.success == true) {
        emit(CreateRoomLoadedState(PublicRModel));
      }}
    } catch (e) { 
      emit(CreateRoomErrorState(PublicRModel));
    }
  }
}
