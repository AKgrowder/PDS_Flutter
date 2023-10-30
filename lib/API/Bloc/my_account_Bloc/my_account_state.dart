import 'package:pds/API/Model/AddExportProfileModel/AddExportProfileModel.dart';
import 'package:pds/API/Model/FetchExprtiseModel/fetchExprtiseModel.dart';
import 'package:pds/API/Model/IndustrytypeModel/Industrytype_Model.dart';
import 'package:pds/API/Model/creat_form/creat_form_Model.dart';
import 'package:pds/API/Model/createDocumentModel/createDocumentModel.dart';
import 'package:pds/API/Model/emailVerfiaction/emailVerfiaction.dart';
import 'package:pds/API/Model/myaccountModel/myaccountModel.dart';
import 'package:pds/API/Model/updateprofileModel/updateprofileModel.dart';

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

class chooseDocumentLoadedState1 extends MyAccountState {
  final ChooseDocument1 chooseDocumentuploded1;
  chooseDocumentLoadedState1(this.chooseDocumentuploded1);
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

class CreatFourmLoadedState extends MyAccountState {
  final CreateForm createForm;
  CreatFourmLoadedState(this.createForm);
}

class UpdateProfileLoadedState extends MyAccountState {
  final UpdateProfile updateProfile;
  UpdateProfileLoadedState(this.updateProfile);
}

class EmailVerifactionLoadedState extends MyAccountState {
  final EmailVerifaction emailVerifaction;
  EmailVerifactionLoadedState(this.emailVerifaction);
}

class IndustryTypeLoadedState extends MyAccountState {
  final IndustryTypeModel industryTypeModel;
  IndustryTypeLoadedState(this.industryTypeModel);
}
