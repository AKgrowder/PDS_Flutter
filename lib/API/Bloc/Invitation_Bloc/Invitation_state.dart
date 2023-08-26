import 'package:pds/API/Model/acceptRejectInvitaionModel/acceptRejectInvitaion.dart';

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
