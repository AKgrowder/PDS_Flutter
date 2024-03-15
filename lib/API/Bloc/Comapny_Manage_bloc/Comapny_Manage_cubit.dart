import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pds/API/Bloc/Comapny_Manage_bloc/Comapny_Manage_state.dart';
import 'package:pds/API/Repo/repository.dart';

class ComapnyManageCubit extends Cubit<ComapnyManageState> {
  ComapnyManageCubit() : super(ComapnyManageInitialState()) {}
  Future<void> upoldeProfilePic(File imageFile, BuildContext context) async {
    print('thsi upoldeProfilePic');
    dynamic chooseDocument;
    try {
      emit(ComapnyManageLoadingState());
      chooseDocument = await Repository().userProfile(imageFile, context);
      if (chooseDocument == "Something Went Wrong, Try After Some Time.") {
        emit(ComapnyManageErrorState("${chooseDocument}"));
      } else {
        if (chooseDocument.success == true) {
          emit(chooseDocumentLoadedState(chooseDocument));
        } else {
          emit(chooseDocumentLoadedState(chooseDocument));
        }
      }
    } catch (e) {
      print('LoginScreen-${e.toString()}');
      emit(ComapnyManageErrorState(chooseDocument));
    }
  }
}
