import 'package:pds/API/Bloc/creatForum_Bloc/creat_Fourm_state.dart';
import 'package:pds/API/Repo/repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pds/API/ApiService/ApiService.dart';

class CreatFourmCubit extends Cubit<CreatFourmState> {
  CreatFourmCubit() : super(CreatFourmInitialState()) {}
  Future<void> CreatFourm(Map<String, dynamic> params, String file,
      String fileName, BuildContext context) async {
    dynamic createForm;
    try {
      emit(CreatFourmLoadingState());
      createForm =
          await Repository().creatFourm(params, file, fileName, context);
      if (createForm == "Something Went Wrong, Try After Some Time.") {
        emit(CreatFourmErrorState("${createForm}"));
      } else {
        if (createForm.success == true) {
          emit(CreatFourmLoadedState(createForm));
        }
      }
    } catch (e) {
      emit(CreatFourmErrorState(createForm));
    }
  }

  Future<void> chooseDocument(Map<String, dynamic> params, String file,
      String fileName, BuildContext context) async {
    dynamic createForm;
    try {
      emit(CreatFourmLoadingState());
      createForm =
          await Repository().creatFourm(params, file, fileName, context);
      if (createForm == "Something Went Wrong, Try After Some Time.") {
        emit(CreatFourmErrorState("${createForm}"));
      } else {
        if (createForm.success == true) {
          emit(CreatFourmLoadedState(createForm));
        }
      }
    } catch (e) {
      emit(CreatFourmErrorState(createForm));
    }
  }

  Future<void> chooseDocumentprofile(
      String file, String fileName, BuildContext context) async {
    print('if this function');
    dynamic createForm;
    try {
      emit(CreatFourmLoadingState());
      createForm =
          await Repository().chooseProfileFile(file, fileName, context);
      print('createFormDataCheck-${createForm.message}');
      if (createForm == "Something Went Wrong, Try After Some Time.") {
        emit(CreatFourmErrorState("${createForm}"));
      } else {
        if (createForm.success == true) {
          print('createFormdataGet-----${createForm.object}');
          emit(ChooseDocumeentLoadedState(createForm));
        }
      }
    } catch (e) {
      print('error data-$e');
      emit(CreatFourmErrorState(createForm));
    }
  }

  Future<void> IndustryTypeAPI(BuildContext context) async {
    dynamic industryType;
    try {
      emit(CreatFourmLoadingState());
      industryType = await Repository().IndustryType(context);
      if (industryType == "Something Went Wrong, Try After Some Time.") {
        emit(CreatFourmErrorState("${industryType}"));
      } else {
        if (industryType.success == true) {
          emit(IndustryTypeLoadedState(industryType));
        }
      }
    } catch (e) {
      emit(CreatFourmErrorState(industryType));
    }
  }

    Future<void> seetinonExpried(BuildContext context,
      {bool showAlert = false}) async {
    try {
      emit(CreatFourmLoadingState());
      dynamic settionExperied =
          await Repository().logOutSettionexperied(context);
      print("checkDatWant--$settionExperied");
      // if (settionExperied == "Something Went Wrong, Try After Some Time.") {
      //     emit(GetGuestAllPostErrorState("${settionExperied}"));
      //   } else {
      if (settionExperied.success == true) {
        await setLOGOUT(context);
      } else {
        print("failed--check---${settionExperied}");
      }
      // }
    } catch (e) {
      print('errorstate-$e');
      // emit(GetGuestAllPostErrorState(e.toString()));
    }
  }
}
