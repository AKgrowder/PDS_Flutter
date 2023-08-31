import '../../Model/FetchAllExpertsModel/FetchAllExperts_Model.dart';
import '../../Model/HomeScreenModel/MyPublicRoom_model.dart';
import '../../Model/HomeScreenModel/PublicRoomModel.dart';
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
  final PublicRoomModel FetchPublicRoomData;
  FetchPublicRoomLoadedState(this.FetchPublicRoomData);
}

class MyPublicRoomLoadedState extends FetchAllPublicRoomState {
  final MyPublicRoom MyPublicRoomData;
  MyPublicRoomLoadedState(this.MyPublicRoomData);
}
