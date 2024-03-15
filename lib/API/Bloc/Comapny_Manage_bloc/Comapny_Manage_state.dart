import 'package:pds/API/Model/createDocumentModel/createDocumentModel.dart';
import 'package:pds/API/Model/myaccountModel/myaccountModel.dart';

abstract class ComapnyManageState {}

class ComapnyManageLoadingState extends ComapnyManageState {}

class ComapnyManageInitialState extends ComapnyManageState {}

class chooseDocumentLoadedState extends ComapnyManageState {
  final ChooseDocument chooseDocument;
  chooseDocumentLoadedState(this.chooseDocument);
}

class ComapnyManageErrorState extends ComapnyManageState {
  final String error;
 ComapnyManageErrorState(this.error);
}
