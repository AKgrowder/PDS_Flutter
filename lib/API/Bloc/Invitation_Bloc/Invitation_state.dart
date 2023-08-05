 
import '../../Model/InvitationModel/Invitation_Model.dart';

abstract class InvitationState {}

class InvitationLoadingState extends InvitationState {}

class InvitationInitialState extends InvitationState {}

class InvitationLoadedState extends InvitationState {
  final InvitationModel InvitationRoomData;
  InvitationLoadedState(this.InvitationRoomData);
}

class InvitationErrorState extends InvitationState {
  final String error;
  InvitationErrorState(this.error);
}
