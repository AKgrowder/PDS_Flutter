import 'package:pds/API/Model/authModel/getUserDetailsMdoel.dart';
import 'package:pds/API/Model/authModel/loginModel.dart';

abstract class LoginState {}

class LoginLoadingState extends LoginState {}

class LoginInitialState extends LoginState {}

class LoginLoadedState extends LoginState {
  final LoginModel loginModel;
  LoginLoadedState(this.loginModel);
}

class LoginErrorState extends LoginState {
  final dynamic error; 
  LoginErrorState(this.error);
}

class GetUserLoadedState extends LoginState {
  final GetUserDataModel getUserDataModel;
  GetUserLoadedState(this.getUserDataModel);
}
