import 'package:archit_s_application1/API/Model/AddExportProfileModel/AddExportProfileModel.dart';
import 'package:archit_s_application1/API/Model/FetchExprtiseModel/fetchExprtiseModel.dart';
import 'package:archit_s_application1/API/Model/createDocumentModel/createDocumentModel.dart';
import 'package:archit_s_application1/API/Model/sherInviteModel/sherinviteModel.dart';

abstract class FetchExprtiseRoomState {}

class FetchExprtiseRoomLoadingState extends FetchExprtiseRoomState {}

class FetchExprtiseRoomInitialState extends FetchExprtiseRoomState {}

class FetchExprtiseRoomLoadedState extends FetchExprtiseRoomState {
  final FetchExprtise fetchExprtise;
  FetchExprtiseRoomLoadedState(this.fetchExprtise);
}

class AddExportLoadedState extends FetchExprtiseRoomState {
  final AddExpertProfile addExpertProfile;
  AddExportLoadedState(this.addExpertProfile);
}

class FetchExprtiseRoomErrorState extends FetchExprtiseRoomState {
  final dynamic error;
  FetchExprtiseRoomErrorState(this.error);
}

class SherInviteLoadedState extends FetchExprtiseRoomState {
  final SherInvite sherInvite;
  SherInviteLoadedState(this.sherInvite);
}

class chooseDocumentLoadedextends extends FetchExprtiseRoomState {
  final ChooseDocument chooseDocumentuploded;

  chooseDocumentLoadedextends(this.chooseDocumentuploded);
}
