
  
import '../../Model/delete_room_model/Delete_room_model.dart';

abstract class DeleteRoomState {}

class DeleteRoomLoadingState extends DeleteRoomState {}

class DeleteRoomInitialState extends DeleteRoomState {}

class DeleteRoomLoadedState extends DeleteRoomState {
  final DeleteRoomModel DeleteRoom;
  DeleteRoomLoadedState(this.DeleteRoom);
}

class DeleteRoomErrorState extends DeleteRoomState {
  final String error;
  DeleteRoomErrorState(this.error);
}
