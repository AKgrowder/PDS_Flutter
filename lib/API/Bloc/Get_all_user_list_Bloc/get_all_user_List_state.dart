import 'package:pds/API/Model/Getalluset_list_Model/get_all_userlist_model.dart';

abstract class GetAllUserState {}

class GetAllUserLoadingState extends GetAllUserState {}

class GetAllUserInitialState extends GetAllUserState {}

class GetAllUserLoadedState extends GetAllUserState {
  final GetAllUserListModel getAllUserRoomData;
  GetAllUserLoadedState(this.getAllUserRoomData);
}

class GetAllUserErrorState extends GetAllUserState {
  final dynamic error;
  GetAllUserErrorState(this.error);
}
