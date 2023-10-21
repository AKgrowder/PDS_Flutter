import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pds/API/Bloc/NewProfileScreen_Bloc/NewProfileScreen_state.dart';
import 'package:pds/API/Repo/repository.dart';

class NewProfileSCubit extends Cubit<NewProfileSState> {
  NewProfileSCubit() : super(NewProfileSInitialState()) {}
  Future<void> NewProfileSAPI(BuildContext context) async {
    dynamic PublicRModel;
    try {
      emit(NewProfileSLoadingState());
      PublicRModel = await Repository().NewProfileAPI(context);
      if (PublicRModel.success == true) {
        emit(NewProfileSLoadedState(PublicRModel));
      }
    } catch (e) {
      emit(NewProfileSErrorState(PublicRModel));
    }
  }
}
