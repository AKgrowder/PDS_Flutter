import 'package:pds/API/Model/authModel/loginModel.dart';
import 'package:pds/API/Model/authModel/registerModel.dart';
import 'package:pds/API/Model/createDocumentModel/createDocumentModel.dart';

abstract class RegisterState {}

class RegisterLoadingState extends RegisterState {}

class RegisterInitialState extends RegisterState {}

class RegisterLoadedState extends RegisterState {
  final LoginModel registerClass;
  RegisterLoadedState(this.registerClass);
}

class RegisterErrorState extends RegisterState {
  final dynamic error;
  RegisterErrorState(this.error);
}

class chooseDocumentLoadedState extends RegisterState {
  final ChooseDocument chooseDocumentuploded;

  chooseDocumentLoadedState(this.chooseDocumentuploded);
}
