import '../../Model/FetchAllExpertsModel/FetchAllExperts_Model.dart';
import '../../Model/HomeScreenModel/MyPublicRoom_model.dart';
import '../../Model/HomeScreenModel/PublicRoomModel.dart';
import '../../Model/HomeScreenModel/getLoginPublicRoom_model.dart';
import '../../Model/System_Config_model/fetchUserModule_model.dart';
import '../../Model/checkUserStatusModel/chekuserStausModel.dart';

abstract class FetchAllPublicRoomState {}

class FetchAllPublicRoomLoadingState extends FetchAllPublicRoomState {}

class FetchAllPublicRoomInitialState extends FetchAllPublicRoomState {}

class FetchAllPublicRoomLoadedState extends FetchAllPublicRoomState {
  final PublicRoomModel PublicRoomData;
  FetchAllPublicRoomLoadedState(this.PublicRoomData);
}

class FetchAllExpertsLoadedState extends FetchAllPublicRoomState {
  final FetchAllExpertsModel FetchAllExpertsData;
  FetchAllExpertsLoadedState(this.FetchAllExpertsData);
}

class FetchAllPublicRoomErrorState extends FetchAllPublicRoomState {
  final dynamic error;
  FetchAllPublicRoomErrorState(this.error);
}

class CheckuserLoadedState extends FetchAllPublicRoomState {
  final CheckUserStausModel CheckUserStausModeldata;
  CheckuserLoadedState(this.CheckUserStausModeldata);
}

class FetchPublicRoomLoadedState extends FetchAllPublicRoomState {
  final LoginPublicRoomModel FetchPublicRoomData;
  FetchPublicRoomLoadedState(this.FetchPublicRoomData);
}

class MyPublicRoom1LoadedState extends FetchAllPublicRoomState {
  final MyPublicRoom MyPublicRoomData;
  MyPublicRoom1LoadedState(this.MyPublicRoomData);
}

class fetchUserModulemodelLoadedState extends FetchAllPublicRoomState {
  final FetchUserModulemodel fetchUserModule;
  fetchUserModulemodelLoadedState(this.fetchUserModule);
}
