import 'package:pds/API/Bloc/auth/login_state.dart';
import 'package:pds/API/Model/authModel/getUserDetailsMdoel.dart';
import 'package:pds/API/Model/authModel/loginModel.dart';
import 'package:pds/API/Repo/repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitialState()) {}
  Future<void> loginApidata(
      Map<String, dynamic> params, BuildContext context) async {
    dynamic registerClassData;
    try {
      emit(LoginLoadingState());
      registerClassData = await Repository().loginApi(params, context);
      if (registerClassData.success == true) {
        emit(LoginLoadedState(registerClassData));
      }
    } catch (e) {
      print('LoginScreen-${e.toString()}');
      emit(LoginErrorState(registerClassData));
    }
  }

  Future<void> getUserDetails(String userId, BuildContext context) async {
    dynamic getUserDataModel;
    print('useriD-$userId');
    try {
      emit(LoginLoadingState());
      getUserDataModel = await Repository().getUsrApi(userId, context);
      if (getUserDataModel.success == true) {
        print('condison true');
        emit(GetUserLoadedState(getUserDataModel));
      }
    } catch (e) {
      print('LoginScreen-${e.toString()}');
      emit(LoginErrorState(getUserDataModel));
    }
  }
}
