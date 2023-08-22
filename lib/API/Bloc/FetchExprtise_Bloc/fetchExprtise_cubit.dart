import 'package:archit_s_application1/API/Bloc/FetchExprtise_Bloc/fetchExprtise_state.dart';
import 'package:archit_s_application1/API/Model/AddExportProfileModel/AddExportProfileModel.dart';
import 'package:archit_s_application1/API/Model/FetchExprtiseModel/fetchExprtiseModel.dart';
import 'package:archit_s_application1/API/Model/createDocumentModel/createDocumentModel.dart';
import 'package:archit_s_application1/API/Repo/repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FetchExprtiseRoomCubit extends Cubit<FetchExprtiseRoomState> {
  FetchExprtiseRoomCubit() : super(FetchExprtiseRoomInitialState()) {}
  Future<void> fetchExprties() async {
    try {
      emit(FetchExprtiseRoomLoadingState());
      FetchExprtise fetchExprtise = await Repository().fetchExprtise();
      if (fetchExprtise.success == true) {
        emit(FetchExprtiseRoomLoadedState(fetchExprtise));
      } else {
        emit(FetchExprtiseRoomErrorState(fetchExprtise.message.toString()));
      }
    } catch (e) {
      emit(FetchExprtiseRoomErrorState(e.toString()));
    }
  }

  Future<void> addExpertProfile(params) async {
    try {
      emit(FetchExprtiseRoomLoadingState());
      AddExpertProfile fetchExprtise =
          await Repository().addEXpertAPiCaling(params);
      if (fetchExprtise.success == true) {
        emit(AddExportLoadedState(fetchExprtise));
      } else {
        emit(FetchExprtiseRoomErrorState(fetchExprtise.message.toString()));
      }
    } catch (e) {
      emit(FetchExprtiseRoomErrorState(e.toString()));
    }
  }

  Future<void> chooseDocumentprofile(
    String file,
    String fileName,
  ) async {
    print('if this function');
    try {
      emit(FetchExprtiseRoomLoadingState());
      ChooseDocument createForm = await Repository().chooseProfileFile(
        file,
        fileName,
      );
      print('createFormDataCheck-${createForm.message}');
      if (createForm.success == true) {
        print('createFormdataGet-----${createForm.object}');
        emit(chooseDocumentLoadedextends(createForm));
      } else {
        emit(FetchExprtiseRoomErrorState(createForm.message.toString()));
      }
    } catch (e) {
      print('error data-$e');
      emit(FetchExprtiseRoomErrorState(e.toString()));
    }
  }
}
