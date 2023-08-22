import 'package:archit_s_application1/API/Model/authModel/registerModel.dart';
import 'package:archit_s_application1/API/Model/createDocumentModel/createDocumentModel.dart';

abstract class RegisterState {}

class RegisterLoadingState extends RegisterState {}

class RegisterInitialState extends RegisterState {}

class RegisterLoadedState extends RegisterState {
  final RegisterClass registerClass;
  RegisterLoadedState(this.registerClass);
}

class RegisterErrorState extends RegisterState {
  final String error;
  RegisterErrorState(this.error);
}

class chooseDocumentLoadedState extends RegisterState {
  final ChooseDocument chooseDocumentuploded;

  chooseDocumentLoadedState(this.chooseDocumentuploded);
}
