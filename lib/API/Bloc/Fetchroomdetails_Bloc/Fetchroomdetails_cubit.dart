import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../Repo/repository.dart';
import 'Fetchroomdetails_stat.dart';

class FetchRoomDetailCubit extends Cubit<FetchRoomDetailState> {
  FetchRoomDetailCubit() : super(FetchRoomDetailInitialState()) {}
  Future<void> Fetchroomdetails(String userId, BuildContext context) async {
    dynamic fetchRoomDetailModel;
    try {
      emit(FetchRoomDetailLoadingState());
      fetchRoomDetailModel =
          await Repository().fetchRoomDetails(userId, context);
          if (fetchRoomDetailModel == "Something Went Wrong, Try After Some Time.") {
        emit(FetchRoomDetailErrorState("${fetchRoomDetailModel}"));
      } else {
      if (fetchRoomDetailModel.success == true) {
        emit(FetchRoomDetailLoadedState(fetchRoomDetailModel));
      }}
    } catch (e) {
      emit(FetchRoomDetailErrorState(fetchRoomDetailModel));
    }
  }
}
