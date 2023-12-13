import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../Model/FatchAllMembers/fatchallmembers_model.dart';
import '../../Repo/repository.dart';
import 'fatch_all_members_state.dart';

class FatchAllMembersCubit extends Cubit<FatchAllMembersState> {
  FatchAllMembersCubit() : super(FatchAllMembersInitialState()) {}
  Future<void> FatchAllMembersAPI(String Roomuid, BuildContext context) async {
    dynamic PublicRModel;
    try {
      emit(FatchAllMembersLoadingState());
      PublicRModel = await Repository().FatchAllMembersAPI(Roomuid, context);
      if (PublicRModel == "Something Went Wrong, Try After Some Time.") {
        emit(FatchAllMembersErrorState("${PublicRModel}"));
      } else {
      if (PublicRModel.success == true) {
        emit(FatchAllMembersLoadedState(PublicRModel));
      }}
    } catch (e) {
      emit(FatchAllMembersErrorState(PublicRModel));
    }
  }

   Future<void> RoomExistsAPI(
      String? otherMemberID, String roomID, BuildContext context) async {
    dynamic roomExistsModel;
    try {
      // emit(FatchAllMembersLoadingState());
      roomExistsModel =
          await Repository().roomExists(otherMemberID, roomID, context);
      if (roomExistsModel == "Something Went Wrong, Try After Some Time.") {
        emit(FatchAllMembersErrorState("${roomExistsModel}"));
      } else {
        if (roomExistsModel.success == true) {
          emit(RoomExistsLoadedState(roomExistsModel));
        }
      }
    } catch (e) {
      emit(FatchAllMembersErrorState(roomExistsModel));
    }
  }
}
