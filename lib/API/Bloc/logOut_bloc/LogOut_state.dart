
import 'package:pds/API/Model/LogOutModel/LogOut_model.dart';

abstract class LogOutState {}

class LogOutLoadingState extends LogOutState {}

class LogOutInitialState extends LogOutState {}

class LogOutLoadedState extends LogOutState {
  final LogOutModel LoginOutModel;
  LogOutLoadedState(this.LoginOutModel);
}

class LogOutErrorState extends LogOutState {
  final dynamic error; 
  LogOutErrorState(this.error);
}

 