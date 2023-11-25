import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pds/API/Bloc/ViewDetails_Bloc/ViewDetails_state.dart';
import 'package:pds/API/Repo/repository.dart';

class ViewDetailsCubit extends Cubit<ViewDeatilsState> {
  ViewDetailsCubit() : super(ViewDeatilsInitialState()) {}
  Future<void> ViewDetailsAPI(String UUid, BuildContext context) async {
    dynamic viewDetailsModel;
    try {
      emit(ViewDeatilsLoadingState());
      viewDetailsModel = await Repository().ViewDetails(UUid, context);
      if (viewDetailsModel == "Something Went Wrong, Try After Some Time.") {
        emit(ViewDeatilsErrorState("${viewDetailsModel}"));
      } else {
      if (viewDetailsModel.success == true) {
        emit(ViewDeatilsLoadedState(viewDetailsModel));
      }}
    } catch (e) {
      emit(ViewDeatilsErrorState(viewDetailsModel));
    }
  }

  Future<void> ReamoveMemberAPI(
    String roomID,
    String? memberUesrID,
    BuildContext context,
  ) async {
    dynamic removeMemberModel;
    try {
      emit(ViewDeatilsLoadingState());
      removeMemberModel =
          await Repository().RemoveUser(roomID, memberUesrID, context);
          if (removeMemberModel == "Something Went Wrong, Try After Some Time.") {
        emit(ViewDeatilsErrorState("${removeMemberModel}"));
      } else {
      if (removeMemberModel.success == true) {
        emit(RemoveUserLoadedState(removeMemberModel));
      }}
    } catch (e) {
      emit(ViewDeatilsErrorState(removeMemberModel));
    }
  }

  Future<void> ExituserAPI(
    String roomID,
    BuildContext context,
  ) async {
    dynamic removeMemberModel;
    try {
      emit(ViewDeatilsLoadingState());
      removeMemberModel = await Repository().Exituser(roomID, context);
      if (removeMemberModel == "Something Went Wrong, Try After Some Time.") {
        emit(ViewDeatilsErrorState("${removeMemberModel}"));
      } else {
      if (removeMemberModel.success == true) {
        emit(ExitUserLoadedState(removeMemberModel));
      }}
    } catch (e) {
      emit(ViewDeatilsErrorState(removeMemberModel));
    }
  }
}
