import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../Repo/repository.dart';
import 'forget_password_state.dart';

class ForgetpasswordCubit extends Cubit<ForgetpasswordState> {
  ForgetpasswordCubit() : super(ForgetpasswordInitialState()) {}
  Future<void> Forgetpassword(String userNumber, BuildContext context) async {
    dynamic forgetpassword;
    try {
      emit(ForgetpasswordLoadingState());
      forgetpassword = await Repository().forgetpassword(userNumber, context);
      if (forgetpassword.success == true) {
        emit(ForgetpasswordLoadedState(forgetpassword));
      } else {
        emit(ForgetpasswordErrorState(forgetpassword.message));
      }
    } catch (e) {
      emit(ForgetpasswordErrorState(forgetpassword));
    }
  }

  Future<void> Changepassword(
      Map<String, dynamic> params, BuildContext context) async {
    dynamic changePasswordModel;
    try {
      emit(ForgetpasswordLoadingState());
      changePasswordModel = await Repository().Changepassword(params, context);
      if (changePasswordModel.success == true) {
        emit(ChangePasswordLoadedState(changePasswordModel));
      } else {
        emit(ForgetpasswordErrorState(changePasswordModel.message));
      }
    } catch (e) {
      emit(ForgetpasswordErrorState(changePasswordModel));
    }
  }
}
