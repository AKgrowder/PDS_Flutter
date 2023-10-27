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

  Future<void> GetAppPostAPI(BuildContext context, String userUid) async {
    dynamic PublicRModel;
    try {
      emit(NewProfileSLoadingState());
      PublicRModel = await Repository().GetAppPostAPI(context, userUid);
      if (PublicRModel.success == true) {
        emit(GetAppPostByUserLoadedState(PublicRModel));
      }
    } catch (e) {
      emit(NewProfileSErrorState(PublicRModel));
    }
  }

  Future<void> GetPostCommetAPI(
      BuildContext context, String userUid, String orderBy) async {
    dynamic PublicRModel;
    try {
      emit(NewProfileSLoadingState());
      PublicRModel =
          await Repository().GetPostCommetAPI(context, userUid, orderBy);
      if (PublicRModel.success == true) {
        emit(GetUserPostCommetLoadedState(PublicRModel));
      }
    } catch (e) {
      emit(NewProfileSErrorState(PublicRModel));
    }
  }

   Future<void> GetSavePostAPI (BuildContext context, String userUid) async {
    dynamic PublicRModel;
    try {
      emit(NewProfileSLoadingState());
      PublicRModel = await Repository().GetSavePostAPI(context, userUid);
      if (PublicRModel.success == true) {
        emit(GetSavePostLoadedState(PublicRModel));
      }
    } catch (e) {
      emit(NewProfileSErrorState(PublicRModel));
    }
  }
}
