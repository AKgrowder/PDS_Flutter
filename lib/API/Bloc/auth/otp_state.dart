import 'package:archit_s_application1/API/Model/otpmodel/otpmodel.dart';

abstract class OtpState {}

class OtpLoadingState extends OtpState {}

class OtpInitialState extends OtpState {}

class OtpLoadedState extends OtpState {
  final OtpModel otpModel;
  OtpLoadedState(this.otpModel);
}

class OtpErrorState extends OtpState {
  final String error;
  OtpErrorState(this.error);
}
