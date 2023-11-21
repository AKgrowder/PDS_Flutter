
import 'package:pds/API/Model/LogOutModel/LogOut_model.dart';
import 'package:pds/API/Model/UserReActivateModel/UserReActivate_model.dart';

import '../../Model/deviceInfo/deviceInfo_model.dart';

abstract class UserReActivateState {}

class UserReActivateLoadingState extends UserReActivateState {}

class UserReActivateInitialState extends UserReActivateState {}

class UserReActivateLoadedState extends UserReActivateState {
  final UserReActivateModel LoginOutModel;
  UserReActivateLoadedState(this.LoginOutModel);
}

class UserReActivateErrorState extends UserReActivateState {
  final dynamic error; 
  UserReActivateErrorState(this.error);
}

class DevicesInfoLoadedState extends UserReActivateState {
  final DeviceinfoModel deviceinfoModel;
  DevicesInfoLoadedState(this.deviceinfoModel);
}

 