import 'package:pds/API/Model/RoomExistsModel/RoomExistsModel.dart';

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
