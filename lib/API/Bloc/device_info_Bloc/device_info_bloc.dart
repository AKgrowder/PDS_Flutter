import 'package:pds/API/Bloc/device_info_Bloc/device_info_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../Model/deviceInfo/deviceInfo_model.dart';
import '../../Repo/repository.dart';

class DevicesInfoCubit extends Cubit<DevicesInfoState> {
  DevicesInfoCubit() : super(DevicesInfoInitialState()) {}
  Future<void> DeviceInfo(
      Map<String, dynamic> param, BuildContext context) async {
    dynamic DeviceinfoModelData;
    try {
      emit(DevicesInfoLoadingState());
      DeviceinfoModelData = await Repository().deviceInfoq(param, context);
      if (DeviceinfoModelData == "Something Went Wrong, Try After Some Time.") {
        emit(DevicesInfoErrorState("${DeviceinfoModelData}"));
      } else {
      if (DeviceinfoModelData.success == true) {
        emit(DevicesInfoLoadedState(DeviceinfoModelData));
        print("+++++++++++++++++++++++++++++++++++++");
        print(DeviceinfoModelData.message);
      }}
    } catch (e) {
      print('LoginScreen-${e.toString()}');
      emit(DevicesInfoErrorState(DeviceinfoModelData));
    }
  }
}
