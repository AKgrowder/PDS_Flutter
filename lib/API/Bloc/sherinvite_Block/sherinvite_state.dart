import 'package:pds/API/Model/sherInviteModel/sherinviteModel.dart';

abstract class SherInviteState {}

class SherInviteLoadingState extends SherInviteState {}

class SherInviteInitialState extends SherInviteState {}

class SherInviteLoadedState extends SherInviteState {
  final SherInvite sherInvite;
  SherInviteLoadedState(this.sherInvite);
}

class SherInviteErrorState extends SherInviteState {
  final dynamic error;
  SherInviteErrorState(this.error);
}
