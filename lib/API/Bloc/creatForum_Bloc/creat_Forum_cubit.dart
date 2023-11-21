import 'package:pds/API/Bloc/creatForum_Bloc/creat_Fourm_state.dart';
import 'package:pds/API/Repo/repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreatFourmCubit extends Cubit<CreatFourmState> {
  CreatFourmCubit() : super(CreatFourmInitialState()) {}
  Future<void> CreatFourm(Map<String, dynamic> params, String file,
      String fileName, BuildContext context) async {
    dynamic createForm;
    try {
      emit(CreatFourmLoadingState());
      createForm =
          await Repository().creatFourm(params, file, fileName, context);
      if (createForm.success == true) {
        emit(CreatFourmLoadedState(createForm));
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
      if (createForm.success == true) {
        emit(CreatFourmLoadedState(createForm));
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
      if (createForm.success == true) {
        print('createFormdataGet-----${createForm.object}');
        emit(ChooseDocumeentLoadedState(createForm));
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
      if (industryType.success == true) {
        emit(IndustryTypeLoadedState(industryType));
      }
    } catch (e) {
      emit(CreatFourmErrorState(industryType));
    }
  }
}
