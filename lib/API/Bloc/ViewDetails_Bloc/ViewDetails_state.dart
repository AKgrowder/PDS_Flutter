import 'package:pds/API/Model/ViewDetails_Model/RemoveMember_model.dart';

import '../../Model/ViewDetails_Model/ViewDetails_model.dart';

abstract class ViewDeatilsState {}

class ViewDeatilsLoadingState extends ViewDeatilsState {}

class ViewDeatilsInitialState extends ViewDeatilsState {}

class ViewDeatilsLoadedState extends ViewDeatilsState {
  final ViewDetailsModel viewDeatilsModel;
  ViewDeatilsLoadedState(this.viewDeatilsModel);
}

class RemoveUserLoadedState extends ViewDeatilsState {
  final RemoveUserModel removeUserModel;
  RemoveUserLoadedState(this.removeUserModel);
}

class ExitUserLoadedState extends ViewDeatilsState {
  final RemoveUserModel ExitUserModel;
  ExitUserLoadedState(this.ExitUserModel);
}

class ViewDeatilsErrorState extends ViewDeatilsState {
  final dynamic error;
  ViewDeatilsErrorState(this.error);
}
