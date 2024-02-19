import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pds/API/Bloc/DeleteUser_Bloc/DeleteUser_state.dart';
import 'package:pds/API/Bloc/UserReActivate_Bloc/UserReActivate_state.dart';
import 'package:pds/API/Repo/repository.dart';

class UserReActivateCubit extends Cubit<UserReActivateState> {
  UserReActivateCubit() : super(UserReActivateInitialState()) {}
  Future<void> UserReActivateApi(
      Map<String, dynamic> params, BuildContext context) async {
    dynamic userReActivateModel;
    try {
      emit(UserReActivateLoadingState());
      userReActivateModel = await Repository().UserReActivate(params, context);
      if (userReActivateModel == "Something Went Wrong, Try After Some Time.") {
        emit(UserReActivateErrorState("${userReActivateModel}"));
      } else {
      if (userReActivateModel.success == true) {
        emit(UserReActivateLoadedState(userReActivateModel));
      }}
    } catch (e) {
      emit(UserReActivateErrorState(userReActivateModel));
    }
  }


  Future<void> DeviceInfo(
      Map<String, dynamic> param, BuildContext context) async {
    dynamic DeviceinfoModelData;
    try {
      emit(UserReActivateLoadingState());
      DeviceinfoModelData = await Repository().deviceInfoq(param, context);
      if (DeviceinfoModelData == "Something Went Wrong, Try After Some Time.") {
        emit(UserReActivateErrorState("${DeviceinfoModelData}"));
      } else {
      if (DeviceinfoModelData.success == true) {
        emit(DevicesInfoLoadedState(DeviceinfoModelData));
      
        print(DeviceinfoModelData.message);
      }}
    } catch (e) {
      print('LoginScreen-${e.toString()}');
      emit(UserReActivateErrorState(DeviceinfoModelData));
    }
  }
}
