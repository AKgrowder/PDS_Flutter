 
 
import '../../Model/GetAllPrivateRoom/GetAllPrivateRoom_Model.dart';

abstract class GetAllPrivateRoomState {}

class GetAllPrivateRoomLoadingState extends GetAllPrivateRoomState {}

class GetAllPrivateRoomInitialState extends GetAllPrivateRoomState {}

class GetAllPrivateRoomLoadedState extends GetAllPrivateRoomState {
  final GetAllPrivateRoomModel PublicRoomData;
  GetAllPrivateRoomLoadedState(this.PublicRoomData);
}

class GetAllPrivateRoomErrorState extends GetAllPrivateRoomState {
  final String error;
  GetAllPrivateRoomErrorState(this.error);
}
