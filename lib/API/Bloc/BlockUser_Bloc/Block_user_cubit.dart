import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pds/API/Bloc/BlockUser_Bloc/Block_user_state.dart';

import '../../Repo/repository.dart';

class BlockUserCubit extends Cubit<BlockUserState> {
  BlockUserCubit() : super(BlockUserInitialState()) {}
  Future<void> BlockUserAPI(
      String blockUserID, bool isBlocked, BuildContext context) async {
    dynamic blockUserModel;
    try {
      emit(BlockUserLoadingState());
      blockUserModel =
          await Repository().blockUser(blockUserID, isBlocked, context);
      if (blockUserModel == "Something Went Wrong, Try After Some Time.") {
        emit(BlockUserErrorState("${blockUserModel}"));
      } else {
        if (blockUserModel.success == true) {
          emit(BlockUserLoadedState(blockUserModel));
        }
      }
    } catch (e) {
      emit(BlockUserErrorState(blockUserModel));
    }
  }

    Future<void> BlockUserListAPI(
     BuildContext context) async {
    dynamic blockUserListModel;
    try {
      emit(BlockUserLoadingState());
      blockUserListModel =
          await Repository().blockUserList( context);
      if (blockUserListModel == "Something Went Wrong, Try After Some Time.") {
        emit(BlockUserErrorState("${blockUserListModel}"));
      } else {
        if (blockUserListModel.success == true) {
          emit(BlockUserListLoadedState(blockUserListModel));
        }
      }
    } catch (e) {
      emit(BlockUserErrorState(blockUserListModel));
    }
  }
}
