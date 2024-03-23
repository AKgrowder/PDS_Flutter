import 'package:pds/API/Model/DeleteUserChatModel/DeleteUserChat_Model.dart';
import 'package:pds/API/Model/createDocumentModel/createDocumentModel.dart';
import 'package:pds/API/Model/getAllCompanyTypeModel/getAllCompanyTypeModel.dart';
import 'package:pds/API/Model/myaccountModel/myaccountModel.dart';

import '../../Model/compeny_page/compeny_page_model.dart';
import '../../Model/getall_compeny_page_model/getall_compeny_page.dart';

abstract class ComapnyManageState {}

class ComapnyManageLoadingState extends ComapnyManageState {}

class ComapnyManageInitialState extends ComapnyManageState {}

class chooseDocumentLoadedState extends ComapnyManageState {
  final ChooseDocument chooseDocument;
  chooseDocumentLoadedState(this.chooseDocument);
}

class compenypagelodedstate extends ComapnyManageState {
  final CompenyPageModel compenypagemodel;
  compenypagelodedstate(this.compenypagemodel);
}

class Getallcompenypagelodedstate extends ComapnyManageState {
  final GetAllCompenyPageModel getallcompenypagemodel;
  Getallcompenypagelodedstate(this.getallcompenypagemodel);
}

class ComapnyManageErrorState extends ComapnyManageState {
  final String error;
 ComapnyManageErrorState(this.error);
}


class CompnayDeletPageState extends ComapnyManageState {
  final DeleteUserChatModel deletUserChatModel;
 CompnayDeletPageState(this.deletUserChatModel);
}


class GetAllCompanyTypeGet extends ComapnyManageState {
  final GetAllCompanyType getAllcompnayType;
 GetAllCompanyTypeGet(this.getAllcompnayType);
}
