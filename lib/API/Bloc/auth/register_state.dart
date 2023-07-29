import 'package:archit_s_application1/API/Model/authModel/registerModel.dart';

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
