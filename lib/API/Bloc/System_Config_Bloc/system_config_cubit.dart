import 'package:pds/API/Bloc/System_Config_Bloc/system_config_state.dart';

import 'package:pds/API/Repo/repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SystemConfigCubit extends Cubit<SystemConfigState> {
  SystemConfigCubit() : super(SystemConfigInitialState()) {}
  Future<void> SystemConfig(BuildContext context) async {
    dynamic systemConfigModel;
    try {
      emit(SystemConfigLoadingState());
      systemConfigModel = await Repository().SystemConfig(context);
      if (systemConfigModel.success == true) {
        emit(SystemConfigLoadedState(systemConfigModel));
      }
    } catch (e) {
      emit(SystemConfigErrorState(systemConfigModel));
    }
  }

  Future<void> UserModel(BuildContext context) async {
    dynamic systemConfigModel;
    try {
      emit(SystemConfigLoadingState());
      systemConfigModel = await Repository().UserModel(context);
      if (systemConfigModel.success == true) {
        emit(fetchUserModulemodelLoadedState(systemConfigModel));
      }
    } catch (e) {
      emit(SystemConfigErrorState(systemConfigModel));
    }
  }

  Future<void> Tokenvalid(BuildContext context) async {
    dynamic systemConfigModel;
    try {
      emit(SystemConfigLoadingState());
      systemConfigModel = await Repository().Tokenvalid(context);
      if (systemConfigModel.success == true) {
        emit(TokenvalidLoadedState(systemConfigModel));
      }
    } catch (e) {
      emit(SystemConfigErrorState(systemConfigModel));
    }
  }
}
