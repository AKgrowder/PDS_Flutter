import 'package:archit_s_application1/API/Bloc/auth/login_state.dart';
import 'package:archit_s_application1/API/Model/authModel/loginModel.dart';
import 'package:archit_s_application1/API/Repo/repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitialState()) {}
  Future<void> loginApidata(Map<String, String> params) async {
    try {
      emit(LoginLoadingState());
      LoginModel registerClassData = await Repository().loginApi(params);
      if (registerClassData.success == true) {
        emit(LoginLoadedState(registerClassData));
      } else {
        emit(LoginErrorState(registerClassData.message.toString()));
      }
    } catch (e) {
      print('registerScreen-${e.toString()}');
      emit(LoginErrorState(e.toString()));
    }
  }
}
