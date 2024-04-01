import 'package:pds/API/Bloc/auth/login_state.dart';
import 'package:pds/API/Const/const.dart';
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
      if (registerClassData == Config.somethingWentWrong) {
       emit( LoginErrorState("${registerClassData}"));
      } else {
        if (registerClassData.success == true) {
          emit(LoginLoadedState(registerClassData));
        } else {
          print('this is the get-${registerClassData.message}');
          emit(LoginErrorState(registerClassData));
        }
      }
    } catch (e) {
      print('LoginScreen-${e.toString()}');
      emit(LoginErrorState(registerClassData));
    }
  }
  Future<void> loginApiisExistFromOnBoarding(
     String username,String password,  BuildContext context) async {
    dynamic registeruserData;
    try {
      emit(LoginLoadingState());
      registeruserData = await Repository().loginApiisExistFromOnBoarding(username,password, context);
      if (registeruserData == Config.somethingWentWrong) {
       emit( LoginErrorState("${registeruserData}"));
      } else {
        if (registeruserData.success == true) {
          emit(LoginLoginisExistFromOnBoardingLoadedState(registeruserData));
        } else {
          print('this is the get-${registeruserData.message}');
          emit(LoginErrorState(registeruserData));
        }
      }
    } catch (e) {
      print('LoginScreen-${e.toString()}');
      emit(LoginErrorState(registeruserData));
    }
  }

  Future<void> getUserDetails(String userId, BuildContext context) async {
    dynamic getUserDataModel;
    print('useriD-$userId');
    try {
      emit(LoginLoadingState());
      getUserDataModel = await Repository().getUsrApi(userId, context);
      if (getUserDataModel == "Something Went Wrong, Try After Some Time.") {
        emit(LoginErrorState("${getUserDataModel}"));
      } else {
        if (getUserDataModel.success == true) {
          print('condison true');
          emit(GetUserLoadedState(getUserDataModel));
        }
      }
    } catch (e) {
      print('LoginScreen-${e.toString()}');
      emit(LoginErrorState(getUserDataModel));
    }
  }
}
