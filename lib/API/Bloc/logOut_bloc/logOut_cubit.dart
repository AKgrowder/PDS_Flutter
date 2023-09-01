import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pds/API/Bloc/logOut_bloc/LogOut_state.dart';
import 'package:pds/API/Repo/repository.dart';

class LogOutCubit extends Cubit<LogOutState> {
  LogOutCubit() : super(LogOutInitialState()) {}
  Future<void> LogOutApi(BuildContext context) async {
    dynamic logOutModel;
    try {
      emit(LogOutLoadingState());
      logOutModel = await Repository().LogOut(context);
      if (logOutModel.success == true) {
        emit(LogOutLoadedState(logOutModel));
      }
    } catch (e) {
      emit(LogOutErrorState(logOutModel));
    }
  }
}
