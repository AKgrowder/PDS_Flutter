import 'package:archit_s_application1/API/Model/authModel/registerModel.dart';
import 'package:archit_s_application1/API/Repo/repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterInitialState()) {}
  Future<void> registerApi(Map<String, String> params) async {
    try {
      emit(RegisterLoadingState());
      RegisterClass registerClassData = await Repository().registerApi(params);
      if (registerClassData.success == true) {
        
        emit(RegisterLoadedState(registerClassData));
      } else {
        emit(RegisterErrorState(registerClassData.message.toString()));
      }
    } catch (e) {
      print('LoginScreen-${e.toString()}');
      emit(RegisterErrorState(e.toString()));
    }
  }
}
