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
      if (fetchExprtise == "Something Went Wrong, Try After Some Time.") {
        emit(FetchExprtiseRoomErrorState("${fetchExprtise}"));
      } else {
      if (fetchExprtise.success == true) {
        emit(FetchExprtiseRoomLoadedState(fetchExprtise));
      }
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
      if (fetchExprtise == "Something Went Wrong, Try After Some Time.") {
        emit(FetchExprtiseRoomErrorState("${fetchExprtise}"));
      } else {
      if (fetchExprtise.success == true) {
        emit(AddExportLoadedState(fetchExprtise));
      }}
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
      if (createForm == "Something Went Wrong, Try After Some Time.") {
        emit(FetchExprtiseRoomErrorState("${createForm}"));
      } else {
      if (createForm.success == true) {
        print('createFormdataGet-----${createForm.object}');
        emit(chooseDocumentLoadedextends(createForm));
      }}
    } catch (e) {
      print('error data-$e');
      emit(FetchExprtiseRoomErrorState(createForm));
    }
  }
   Future<void> IndustryTypeAPI(BuildContext context) async {
    dynamic industryType;
    try {
      emit(FetchExprtiseRoomLoadingState());
      industryType = await Repository().IndustryType(context);
      if (industryType == "Something Went Wrong, Try After Some Time.") {
        emit(FetchExprtiseRoomErrorState("${industryType}"));
      } else {
      if (industryType.success == true) {
        emit(IndustryTypeLoadedState(industryType));
      }}
    } catch (e) {
      emit(FetchExprtiseRoomErrorState(industryType));
    }
  }
}
