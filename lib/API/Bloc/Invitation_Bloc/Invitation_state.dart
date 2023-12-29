import 'package:pds/API/Model/acceptRejectInvitaionModel/GetAllNotificationModel.dart';
import 'package:pds/API/Model/acceptRejectInvitaionModel/RequestList_Model.dart';
import 'package:pds/API/Model/acceptRejectInvitaionModel/acceptRejectInvitaion.dart';
import 'package:pds/API/Model/acceptRejectInvitaionModel/accept_rejectModel.dart';
import 'package:pds/API/Model/acceptRejectInvitaionModel/seenNotificationModel.dart';

import '../../Model/InvitationModel/Invitation_Model.dart';

abstract class InvitationState {}

class InvitationLoadingState extends InvitationState {}

class InvitationInitialState extends InvitationState {}

class InvitationLoadedState extends InvitationState {
  final InvitationModel InvitationRoomData;
  InvitationLoadedState(this.InvitationRoomData);
}

class InvitationErrorState extends InvitationState {
  final dynamic error;
  InvitationErrorState(this.error);
}

class AcceptRejectInvitationModelLoadedState extends InvitationState {
  final AcceptRejectInvitationModel acceptRejectInvitationModel;
  AcceptRejectInvitationModelLoadedState(this.acceptRejectInvitationModel);
}

class RequestListLoadedState extends InvitationState {
  final RequestListModel RequestListModelData;
  RequestListLoadedState(this.RequestListModelData);
}

class accept_rejectLoadedState extends InvitationState {
  final accept_rejectModel accept_rejectData;
  accept_rejectLoadedState(this.accept_rejectData);
}


class GetAllNotificationLoadedState extends InvitationState {
  final GetAllNotificationModel AllNotificationData;
  GetAllNotificationLoadedState(this.AllNotificationData);
}

class SeenNotificationLoadedState extends InvitationState {
  final seenNotificationModel SeenNotificationData;
  SeenNotificationLoadedState(this.SeenNotificationData);
}

