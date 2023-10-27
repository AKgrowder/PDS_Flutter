import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pds/API/Bloc/Get_all_user_list_Bloc/get_all_user_List_state.dart';
import 'package:pds/API/Repo/repository.dart';

class GetAllUserCubit extends Cubit<GetAllUserState> {
  GetAllUserCubit() : super(GetAllUserInitialState()) {}
  Future<void> getalluser(
    int? pageNumber,
    int numberOfRecords,
    String searchName,
    BuildContext context, {
    String? filterModule,
  }) async {
    dynamic getalluserlistModel;
    try {
      emit(GetAllUserLoadingState());
      getalluserlistModel = await Repository().getalluser(
          pageNumber, numberOfRecords, searchName,context,filterModule: filterModule);
      if (getalluserlistModel.success == true) {
        emit(GetAllUserLoadedState(getalluserlistModel));
      }
    } catch (e) {
      // print('errorstate-$e');
      emit(GetAllUserErrorState(getalluserlistModel));
    }
  }
}
