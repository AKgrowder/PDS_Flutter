import 'package:pds/API/Model/System_Config_model/system_config_model.dart';

import '../../Model/System_Config_model/fetchUserModule_model.dart';

abstract class SystemConfigState {}

class SystemConfigLoadingState extends SystemConfigState {}

class SystemConfigInitialState extends SystemConfigState {}

class SystemConfigLoadedState extends SystemConfigState {
  final SystemConfigModel systemConfigModel;
  SystemConfigLoadedState(this.systemConfigModel);
}

class SystemConfigErrorState extends SystemConfigState {
  final dynamic error;
  SystemConfigErrorState(this.error);
}

class fetchUserModulemodelLoadedState extends SystemConfigState {
  final FetchUserModulemodel fetchUserModule;
  fetchUserModulemodelLoadedState(this.fetchUserModule);
}
