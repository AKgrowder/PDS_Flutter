 
import 'package:pds/API/Model/deviceInfo/deviceInfo_model.dart';

abstract class DevicesInfoState {}

class DevicesInfoLoadingState extends DevicesInfoState {}

class DevicesInfoInitialState extends DevicesInfoState {}

class DevicesInfoLoadedState extends DevicesInfoState {
  final DeviceinfoModel deviceinfoModel;
  DevicesInfoLoadedState(this.deviceinfoModel);
}

class DevicesInfoErrorState extends DevicesInfoState {
  final String error; 
  DevicesInfoErrorState(this.error);
}
 
