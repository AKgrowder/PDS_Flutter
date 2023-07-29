import 'package:archit_s_application1/API/Model/authModel/loginModel.dart';

abstract class LoginState {}

class LoginLoadingState extends LoginState {}

class LoginInitialState extends LoginState {}

class LoginLoadedState extends LoginState {
  final LoginModel loginModel;
  LoginLoadedState(this.loginModel);
}

class LoginErrorState extends LoginState {
  final String error;
  LoginErrorState(this.error);
}
