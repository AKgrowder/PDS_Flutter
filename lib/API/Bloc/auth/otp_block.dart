import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pds/API/Bloc/auth/otp_state.dart';
import 'package:pds/API/Repo/repository.dart';

class OtpCubit extends Cubit<OtpState> {
  OtpCubit() : super(OtpInitialState()) {}
  Future<void> OtpApi(
      String userNumber, String OTP, BuildContext context) async {
    dynamic otpModel;
    try {
      emit(OtpLoadingState());
      otpModel = await Repository().otpModel(OTP, userNumber, context);
      if (otpModel == "Something Went Wrong, Try After Some Time.") {
        emit(OtpErrorState("${otpModel}"));
      } else {
        if (otpModel.success == true) {
          emit(OtpLoadedState(otpModel));
        } else {
          emit(OtpErrorState(otpModel.message));
        }
      }
    } catch (e) {
      print('LoginScreen-${e.toString()}');
      emit(OtpErrorState(otpModel));
    }
  }

  Future<void> resendOtpApi(String userNumber, BuildContext context) async {
    dynamic forgetpassword;
    try {
      emit(OtpLoadingState());
      forgetpassword = await Repository().forgetpassword(userNumber, context);
      if (forgetpassword == "Something Went Wrong, Try After Some Time.") {
        emit(OtpErrorState("${forgetpassword}"));
      } else {
        if (forgetpassword.success == true) {
          emit(resendOtpLoadedState(forgetpassword));
        } else {
          emit(OtpErrorState(forgetpassword.message));
        }
      }
    } catch (e) {
      emit(OtpErrorState(forgetpassword));
    }
  }
}
