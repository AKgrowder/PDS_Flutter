 
 
import 'package:archit_s_application1/API/Model/sherInviteModel/sherinviteModel.dart';

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
class SherInviteLoadedState extends GetAllPrivateRoomState {
  final SherInvite sherInvite;
  SherInviteLoadedState(this.sherInvite);
}
