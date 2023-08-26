import 'package:pds/API/Model/System_Config_model/system_config_model.dart';

abstract class SystemConfigState {}

class SystemConfigLoadingState extends SystemConfigState {}

class SystemConfigInitialState extends SystemConfigState {}

class SystemConfigLoadedState extends SystemConfigState {
  final SystemConfigModel systemConfigModel;
  SystemConfigLoadedState(this.systemConfigModel);
}

class SystemConfigErrorState extends SystemConfigState {
  final String error;
  SystemConfigErrorState(this.error);
}
