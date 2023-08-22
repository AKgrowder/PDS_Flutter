import 'package:archit_s_application1/API/Bloc/device_info_Bloc/device_info_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../Model/deviceInfo/deviceInfo_model.dart';
import '../../Repo/repository.dart';

class DevicesInfoCubit extends Cubit<DevicesInfoState> {
  DevicesInfoCubit() : super(DevicesInfoInitialState()) {}
  Future<void> DeviceInfo(
    Map<String, dynamic> param,
  ) async {
    try {
      emit(DevicesInfoLoadingState());
      DeviceinfoModel DeviceinfoModelData =
          await Repository().deviceInfoq(param);
      if (DeviceinfoModelData.success == true) {
        emit(DevicesInfoLoadedState(DeviceinfoModelData));
        print("+++++++++++++++++++++++++++++++++++++");
        print(DeviceinfoModelData.message);
      } else {
        emit(DevicesInfoErrorState(DeviceinfoModelData.message.toString()));
      }
    } catch (e) {
      print('LoginScreen-${e.toString()}');
      emit(DevicesInfoErrorState(e.toString()));
    }
  }
}
