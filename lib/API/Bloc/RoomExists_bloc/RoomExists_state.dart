import 'package:pds/API/Model/RoomExistsModel/RoomExistsModel.dart';
import 'package:pds/API/Model/delete_room_model/Delete_room_model.dart';

abstract class RoomExistsState {}

class RoomExistsLoadingState extends RoomExistsState {}

class RoomExistsInitialState extends RoomExistsState {}

class RoomExistsErrorState extends RoomExistsState {
  final dynamic error;
  RoomExistsErrorState(this.error);
}

class RoomExistsLoadedState extends RoomExistsState {
  final RoomExistsModel roomExistsModel;
  RoomExistsLoadedState(this.roomExistsModel);
}

class DeleteRoomLoadedState extends RoomExistsState {
  final DeleteRoomModel DeleteRoom;
  DeleteRoomLoadedState(this.DeleteRoom);
}
