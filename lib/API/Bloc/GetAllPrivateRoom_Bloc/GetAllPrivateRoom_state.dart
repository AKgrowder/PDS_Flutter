import 'package:pds/API/Model/acceptRejectInvitaionModel/getAllNotificationCount.dart';
import 'package:pds/API/Model/checkUserStatusModel/chekuserStausModel.dart';
import 'package:pds/API/Model/delete_room_model/Delete_room_model.dart';
import 'package:pds/API/Model/fetch_room_detail_model/fetch_room_detail_model.dart';
import 'package:pds/API/Model/sherInviteModel/sherinviteModel.dart';

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

class DeleteRoomLoadedState extends GetAllPrivateRoomState {
  final DeleteRoomModel DeleteRoom;
  DeleteRoomLoadedState(this.DeleteRoom);
}

class CheckuserLoadedState extends GetAllPrivateRoomState {
  final CheckUserStausModel checkUserStausModel;
  CheckuserLoadedState(this.checkUserStausModel);
}

// class FetchRoomDetailLoadedState extends GetAllPrivateRoomState {
//   final FetchRoomDetailModel fetchRoomDetailModel;
//   FetchRoomDetailLoadedState(this.fetchRoomDetailModel);
// }



class GetNotificationCountLoadedState extends GetAllPrivateRoomState {
  final getAllNotificationCount GetNotificationCountData;
  GetNotificationCountLoadedState(this.GetNotificationCountData);
}
