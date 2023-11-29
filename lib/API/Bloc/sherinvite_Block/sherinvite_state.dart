import 'package:pds/API/Model/sherInviteModel/sherinviteModel.dart';
import 'package:pds/API/Model/FetchAllExpertsModel/FetchAllExperts_Model.dart';

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
class FetchAllExpertsLoadedState extends SherInviteState {
  final FetchAllExpertsModel FetchAllExpertsData;
  FetchAllExpertsLoadedState(this.FetchAllExpertsData);
}
