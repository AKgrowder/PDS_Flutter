import 'package:pds/API/Model/forget_password_model/forget_password_model.dart';

import '../../Model/forget_password_model/change_password_model.dart';

abstract class ForgetpasswordState {}

class ForgetpasswordLoadingState extends ForgetpasswordState {}

class ForgetpasswordInitialState extends ForgetpasswordState {}

class ForgetpasswordLoadedState extends ForgetpasswordState {
  final ForgetPasswordModel Forgetpassword;
  ForgetpasswordLoadedState(this.Forgetpassword);
}

class ChangePasswordLoadedState extends ForgetpasswordState {
  final ChangePasswordModel changePasswordModel;
  ChangePasswordLoadedState(this.changePasswordModel);
}

class ForgetpasswordErrorState extends ForgetpasswordState {
  final String error;
  ForgetpasswordErrorState(this.error);
}
