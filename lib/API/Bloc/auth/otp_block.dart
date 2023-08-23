import 'package:archit_s_application1/API/Bloc/auth/otp_state.dart';
import 'package:archit_s_application1/API/Model/authModel/getUserDetailsMdoel.dart';
import 'package:archit_s_application1/API/Model/otpmodel/otpmodel.dart';
import 'package:archit_s_application1/API/Repo/repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OtpCubit extends Cubit<OtpState> {
  OtpCubit() : super(OtpInitialState()) {}
  Future<void> OtpApi(
      String userNumber, String OTP, BuildContext context) async {
    dynamic otpModel;
    try {
      emit(OtpLoadingState());
      otpModel = await Repository().otpModel(OTP, userNumber, context);
      if (otpModel.success == true) {
        emit(OtpLoadedState(otpModel));
      }
    } catch (e) {
      print('LoginScreen-${e.toString()}');
      emit(OtpErrorState(otpModel));
    }
  }
}
