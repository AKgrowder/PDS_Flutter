import 'package:archit_s_application1/API/Bloc/creatForum_Bloc/creat_Fourm_state.dart'; 
import 'package:archit_s_application1/API/Repo/repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../Model/creat_form/creat_form_Model.dart';

class CreatFourmCubit extends Cubit<CreatFourmState> {
  CreatFourmCubit() : super(CreatFourmInitialState()) {}
  Future<void> CreatFourm(
    String token,
    Map<String, dynamic> params,
    String file,
    String fileName,

  ) async {
    try {
      emit(CreatFourmLoadingState());
      CreateForm createForm =
          await Repository().creatFourm(token, params, file,fileName);
      if (createForm.success == true) {
        emit(CreatFourmLoadedState(createForm));
      } else {
        emit(CreatFourmErrorState('No Data Found!'));
      }
    } catch (e) {
      emit(CreatFourmErrorState(e.toString()));
    }
  }
}
