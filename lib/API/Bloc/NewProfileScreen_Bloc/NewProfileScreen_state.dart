import 'package:pds/API/Model/NewProfileScreenModel/NewProfileScreen_Model.dart';
import 'package:pds/API/Model/checkUserStatusModel/chekuserStausModel.dart';

abstract class NewProfileSState {}

class NewProfileSLoadingState extends NewProfileSState {}

class NewProfileSInitialState extends NewProfileSState {}

class NewProfileSLoadedState extends NewProfileSState {
  final NewProfileScreen_Model PublicRoomData;
  NewProfileSLoadedState(this.PublicRoomData);
}

class NewProfileSErrorState extends NewProfileSState {
  final String error;
  NewProfileSErrorState(this.error);
}
