import 'package:archit_s_application1/API/Bloc/creatForum_Bloc/creat_Fourm_state.dart';
import 'package:archit_s_application1/API/Model/createDocumentModel/createDocumentModel.dart';
import 'package:archit_s_application1/API/Repo/repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../Model/creat_form/creat_form_Model.dart';

class CreatFourmCubit extends Cubit<CreatFourmState> {
  CreatFourmCubit() : super(CreatFourmInitialState()) {}
  Future<void> CreatFourm(
    Map<String, dynamic> params,
    String file,
    String fileName,
  ) async {
    try {
      emit(CreatFourmLoadingState());
      CreateForm createForm =
          await Repository().creatFourm(params, file, fileName);
      if (createForm.success == true) {
        emit(CreatFourmLoadedState(createForm));
      } else {
        emit(CreatFourmErrorState(createForm.message.toString()));
      }
    } catch (e) {
      emit(CreatFourmErrorState(e.toString()));
    }
  }

  Future<void> chooseDocument(
    Map<String, dynamic> params,
    String file,
    String fileName,
  ) async {
    try {
      emit(CreatFourmLoadingState());
      CreateForm createForm =
          await Repository().creatFourm(params, file, fileName);
      if (createForm.success == true) {
        emit(CreatFourmLoadedState(createForm));
      } else {
        emit(CreatFourmErrorState(createForm.message.toString()));
      }
    } catch (e) {
      emit(CreatFourmErrorState(e.toString()));
    }
  }

  Future<void> chooseDocumentprofile(
    String file,
    String fileName,
  ) async {
    print('if this function');
    try {
      emit(CreatFourmLoadingState());
      ChooseDocument createForm = await Repository().chooseProfileFile(
        file,
        fileName,
      );
      print('createFormDataCheck-${createForm.message}');
      if (createForm.success == true) {
        print('createFormdataGet-----${createForm.object}');
        emit(ChooseDocumeentLoadedState(createForm));
      } else {
        emit(CreatFourmErrorState(createForm.message.toString()));
      }
    } catch (e) {
      print('error data-$e');
      emit(CreatFourmErrorState(e.toString()));
    }
  }
}
