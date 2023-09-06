import 'package:pds/API/Model/authModel/getUserDetailsMdoel.dart';
import 'package:pds/API/Model/otpmodel/otpmodel.dart';

import '../../Model/forget_password_model/forget_password_model.dart';

abstract class OtpState {}

class OtpLoadingState extends OtpState {}

class OtpInitialState extends OtpState {}

class OtpLoadedState extends OtpState {
  final OtpModel otpModel;
  OtpLoadedState(this.otpModel);
}


class resendOtpLoadedState extends OtpState {
  final ForgetPasswordModel Forgetpassword;
  resendOtpLoadedState(this.Forgetpassword);
}

class OtpErrorState extends OtpState {
  final String error;
  OtpErrorState(this.error);
}


