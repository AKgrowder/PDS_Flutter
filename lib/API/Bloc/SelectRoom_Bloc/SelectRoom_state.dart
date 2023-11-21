

import '../../Model/SelectRoomModel/SelectRoom_Model.dart';
import '../../Model/sherInviteModel/sherinviteModel.dart';

abstract class SelectedRoomState {}

class SelectedRoomLoadingState extends SelectedRoomState {}

class SelectedRoomInitialState extends SelectedRoomState {}

class SelectedRoomLoadedState extends SelectedRoomState {
  final SelectRoomModel SelectedRoom;
  SelectedRoomLoadedState(this.SelectedRoom);
}
 

class SherInvite2LoadedState extends SelectedRoomState {
  final SherInvite sherInvite;
  SherInvite2LoadedState(this.sherInvite);
}

class SelectedRoomErrorState extends SelectedRoomState {
  final dynamic error;
  SelectedRoomErrorState(this.error);
}
