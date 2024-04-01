import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pds/Market_place/commenModel/apiDataGet.dart';
import 'package:pds/Market_place/commenWiget.dart/apiRequest.dart';
import 'package:pds/Market_place/repositryMethod/ApiUrl.dart';
import 'package:pds/Market_place/repositryMethod/apiMethod.dart';
import 'package:pds/core/utils/color_constant.dart';
import 'package:pds/presentation/%20new/commenwigetReposrt.dart';

abstract class LoginRegtistrtionState {}

class LoginRegtistrtionLoadingState extends LoginRegtistrtionState {}

class LoginRegtistrtionInitialState extends LoginRegtistrtionState {}

class LoginRegtistrtionResponceGetState extends LoginRegtistrtionState {
  final CommenModel commenModel;
  LoginRegtistrtionResponceGetState(this.commenModel);
}

class LoginRegisterCubit extends Cubit<LoginRegtistrtionState> {
  LoginRegisterCubit() : super(LoginRegtistrtionInitialState()) {}
  Future<void> loginApidata(
      Map<String, dynamic> params, BuildContext context) async {
        print("dsfsdfsdgfsdgfgsdfgsdfg");
    dynamic loginAndRegsitrionData;
    try {
      emit(LoginRegtistrtionLoadingState());
      loginAndRegsitrionData =
          await ApiMethod().isMobileNoExists(EndPoints.isMobileNoExists, params, context);
      if (loginAndRegsitrionData.status == ApiData.Success) {
        emit(LoginRegtistrtionResponceGetState(loginAndRegsitrionData));
      } else if (loginAndRegsitrionData.status == ApiData.Failed) {
        CustomFlushBar().flushBar(
            text: loginAndRegsitrionData.data['message'],
            context: context,
            duration: 2,
            backgroundColor: ColorConstant.primary_color);
      }
    } catch (e) {}
  }
}
