import 'package:pds/API/Bloc/FetchExprtise_Bloc/fetchExprtise_state.dart';
import 'package:pds/API/Repo/repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FetchExprtiseRoomCubit extends Cubit<FetchExprtiseRoomState> {
  FetchExprtiseRoomCubit() : super(FetchExprtiseRoomInitialState()) {}
  Future<void> fetchExprties(BuildContext context) async {
    dynamic fetchExprtise;
    try {
      emit(FetchExprtiseRoomLoadingState());
      fetchExprtise = await Repository().fetchExprtise(context);
      if (fetchExprtise.success == true) {
        emit(FetchExprtiseRoomLoadedState(fetchExprtise));
      }
    } catch (e) {
      emit(FetchExprtiseRoomErrorState(fetchExprtise));
    }
  }

  Future<void> addExpertProfile(params, BuildContext context) async {
    dynamic fetchExprtise;
    try {
      emit(FetchExprtiseRoomLoadingState());
      fetchExprtise = await Repository().addEXpertAPiCaling(params, context);
      if (fetchExprtise.success == true) {
        emit(AddExportLoadedState(fetchExprtise));
      }
    } catch (e) {
      emit(FetchExprtiseRoomErrorState(fetchExprtise));
    }
  }

  Future<void> chooseDocumentprofile(
      String file, String fileName, BuildContext context) async {
    print('if this function');
    dynamic createForm;
    try {
      emit(FetchExprtiseRoomLoadingState());
      createForm =
          await Repository().chooseProfileFile(file, fileName, context);
      print('createFormDataCheck-${createForm.message}');
      if (createForm.success == true) {
        print('createFormdataGet-----${createForm.object}');
        emit(chooseDocumentLoadedextends(createForm));
      }
    } catch (e) {
      print('error data-$e');
      emit(FetchExprtiseRoomErrorState(createForm));
    }
  }
}
