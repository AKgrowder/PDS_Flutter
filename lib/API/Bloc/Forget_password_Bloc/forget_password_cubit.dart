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
      BuildContext context, Map<String, dynamic> params) async {
    dynamic changePasswordModel;
    try {
      emit(ForgetpasswordLoadingState());
      changePasswordModel = await Repository().Changepassword(params,context);
      if (changePasswordModel.success == true) {
        emit(ChangePasswordLoadedState(changePasswordModel));
      } else {
        emit(ForgetpasswordErrorState(changePasswordModel.message));
      }
    } catch (e) {
      emit(ForgetpasswordErrorState(changePasswordModel));
    }
  }

  Future<void> ChangepasswordinSetitngScreenwork(
      Map<String, dynamic> params, BuildContext context) async {
    dynamic changePasswordModel;
    try {
      emit(ForgetpasswordLoadingState());
      changePasswordModel =
          await Repository().ChangepasswordinSettingScreen(params, context);
      if (changePasswordModel.success == true) {
        emit(ChangePasswordInSettingScreenLoadedState(changePasswordModel));
      } else {
        emit(ForgetpasswordErrorState(changePasswordModel.message));
      }
    } catch (e) {
      emit(ForgetpasswordErrorState(changePasswordModel));
    }
  }
}
