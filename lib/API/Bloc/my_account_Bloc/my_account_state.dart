import 'package:archit_s_application1/API/Bloc/creatForum_Bloc/creat_Fourm_state.dart';
import 'package:archit_s_application1/API/Model/AddExportProfileModel/AddExportProfileModel.dart';
import 'package:archit_s_application1/API/Model/FetchExprtiseModel/fetchExprtiseModel.dart';
import 'package:archit_s_application1/API/Model/createDocumentModel/createDocumentModel.dart';
import 'package:archit_s_application1/API/Model/myaccountModel/myaccountModel.dart';

abstract class MyAccountState {}

class MyAccountLoadingState extends MyAccountState {}

class MyAccountInitialState extends MyAccountState {}

class MyAccountLoadedState extends MyAccountState {
  final MyAccontDetails myAccontDetails;
  MyAccountLoadedState(this.myAccontDetails);
}
class chooseDocumentLoadedState extends MyAccountState {
 final ChooseDocument chooseDocumentuploded;
  chooseDocumentLoadedState(this.chooseDocumentuploded);
}


class MyAccountErrorState extends MyAccountState {
  final String error;
  MyAccountErrorState(this.error);
}
class FetchExprtiseRoomLoadedState extends MyAccountState {
  final FetchExprtise fetchExprtise;
  FetchExprtiseRoomLoadedState(this.fetchExprtise);
}

class chooseDocumentLoadedState2 extends MyAccountState {
 final ChooseDocument chooseDocumentuploded;
  chooseDocumentLoadedState2(this.chooseDocumentuploded);
}
class AddExportLoadedState extends MyAccountState {
  final AddExpertProfile addExpertProfile;
  AddExportLoadedState(this.addExpertProfile);
}

