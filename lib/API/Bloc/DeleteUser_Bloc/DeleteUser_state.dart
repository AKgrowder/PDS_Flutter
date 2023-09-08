
import 'package:pds/API/Model/DeleteUserModel/DeleteUser_Model.dart';
import 'package:pds/API/Model/LogOutModel/LogOut_model.dart';

abstract class DeleteUserState {}

class DeleteUserLoadingState extends DeleteUserState {}

class DeleteUserInitialState extends DeleteUserState {}

class DeleteUserLoadedState extends DeleteUserState {
  final DeleteUserModel deleteUserModel;
  DeleteUserLoadedState(this.deleteUserModel);
}

class DeleteUserErrorState extends DeleteUserState {
  final dynamic error; 
  DeleteUserErrorState(this.error);
}

 