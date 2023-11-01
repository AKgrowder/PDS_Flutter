import 'dart:io';
import 'package:pds/API/Repo/repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterInitialState()) {}
  Future<void> registerApi(
      Map<String, dynamic> params, BuildContext context) async {
    dynamic registerClassData;
    try {
      emit(RegisterLoadingState());
      registerClassData = await Repository().registerApi(params, context);
      if (registerClassData.success == true) {
        emit(RegisterLoadedState(registerClassData));
      }else{
        emit(RegisterErrorState(registerClassData));
      }
    } catch (e) {
      print('LoginScreen-${e.toString()}');
      emit(RegisterErrorState(registerClassData));
    }
  }

  Future<void> upoldeProfilePic(File imageFile, BuildContext context) async {
    dynamic chooseDocument;
    try {
      emit(RegisterLoadingState());
      chooseDocument = await Repository().userProfile(imageFile, context);
      if (chooseDocument.success == true) {
        emit(chooseDocumentLoadedState(chooseDocument));
      }
    } catch (e) {
      print('LoginScreen-${e.toString()}');
      emit(RegisterErrorState(chooseDocument));
    }
  }
}
