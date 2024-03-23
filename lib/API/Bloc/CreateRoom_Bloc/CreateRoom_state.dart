import '../../Model/CreateRoomModel/CreateRoom_Model.dart';

abstract class CreateRoomState {}

class CreateRoomLoadingState extends CreateRoomState {}

class CreateRoomInitialState extends CreateRoomState {}

class CreateRoomLoadedState extends CreateRoomState {
  final CreateRoomModel PublicRoomData;
  CreateRoomLoadedState(this.PublicRoomData);
}

class CreateRoomErrorState extends CreateRoomState {
  final dynamic error;
  CreateRoomErrorState(this.error);
}
