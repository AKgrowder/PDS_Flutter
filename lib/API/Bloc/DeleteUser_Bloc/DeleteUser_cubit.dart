import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pds/API/Bloc/DeleteUser_Bloc/DeleteUser_state.dart';
import 'package:pds/API/Repo/repository.dart';

class DeleteUserCubit extends Cubit<DeleteUserState> {
  DeleteUserCubit() : super(DeleteUserInitialState()) {}
  Future<void> DeleteUserApi(
      String uuid, String reason, BuildContext context) async {
    dynamic deleteUserModel;
    try {
      emit(DeleteUserLoadingState());
      deleteUserModel = await Repository().DeleteUser(uuid, reason, context);
      if (deleteUserModel == "Something Went Wrong, Try After Some Time.") {
        emit(DeleteUserErrorState("${deleteUserModel}"));
      } else {
        if (deleteUserModel.success == true) {
          emit(DeleteUserLoadedState(deleteUserModel));
        }
      }
    } catch (e) {
      emit(DeleteUserErrorState(deleteUserModel));
    }
  }
}
