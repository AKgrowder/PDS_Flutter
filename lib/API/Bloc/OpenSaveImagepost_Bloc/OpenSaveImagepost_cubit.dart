import 'package:pds/API/Bloc/OpenSaveImagepost_Bloc/OpenSaveImagepost_state.dart';
import 'package:pds/API/Repo/repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OpenSaveCubit extends Cubit<OpenSaveState> {
  OpenSaveCubit() : super(OpenSaveInitialState()) {}
  Future<void> openSaveImagePostAPI(
      BuildContext context, String PostUID) async {
    dynamic OpenSaveModel;
    try {
      emit(OpenSaveLoadingState());
      OpenSaveModel = await Repository().openSaveImagePost(context, PostUID);
      if (OpenSaveModel.success == true) {
        emit(OpenSaveLoadedState(OpenSaveModel));
      }
    } catch (e) {
      emit(OpenSaveErrorState(OpenSaveModel));
    }
  }
}
