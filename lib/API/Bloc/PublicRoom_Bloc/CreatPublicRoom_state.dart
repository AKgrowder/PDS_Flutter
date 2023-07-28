 
import '../../Model/AddThread/CreateRoom_Model.dart';

abstract class CreatPublicRoomState {}

class CreatPublicRoomLoadingState extends CreatPublicRoomState {}

class CreatPublicRoomInitialState extends CreatPublicRoomState {}

class CreatPublicRoomLoadedState extends CreatPublicRoomState {
  final CreatPublicRoomModel PublicRoomData;
  CreatPublicRoomLoadedState(this.PublicRoomData);
}

class CreatPublicRoomErrorState extends CreatPublicRoomState {
  final String error;
  CreatPublicRoomErrorState(this.error);
}
