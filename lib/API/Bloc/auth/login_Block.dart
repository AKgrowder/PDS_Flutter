
import 'package:archit_s_application1/API/Bloc/auth/login_state.dart';
import 'package:archit_s_application1/API/Model/authModel/getUserDetailsMdoel.dart';
import 'package:archit_s_application1/API/Model/authModel/loginModel.dart';
import 'package:archit_s_application1/API/Repo/repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitialState()) {}
  Future<void> loginApidata(
    Map<String, String> params,
  ) async {
    try {
      emit(LoginLoadingState());
      LoginModel registerClassData =
          await Repository().loginApi(params,);
      if (registerClassData.success == true) {
        emit(LoginLoadedState(registerClassData));
      } else {
        emit(LoginErrorState(registerClassData.message.toString()));
      }
    } catch (e) {
      print('LoginScreen-${e.toString()}');
      emit(LoginErrorState(e.toString()));
    }
  }

  Future<void> getUserDetails(
    String userId,
  ) async {
    print('useriD-$userId');
    try {
      emit(LoginLoadingState());
      GetUserDataModel getUserDataModel =
          await Repository().getUsrApi(userId, );
      if (getUserDataModel.success == true) {
        print('condison true');
        emit(GetUserLoadedState(getUserDataModel));
      } else {
        emit(LoginErrorState(getUserDataModel.message.toString()));
      }
    } catch (e) {
      print('LoginScreen-${e.toString()}');
      emit(LoginErrorState(e.toString()));
    }
  }
}
