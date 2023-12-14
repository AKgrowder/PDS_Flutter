import 'package:pds/API/Bloc/OpenSaveImagepost_Bloc/OpenSaveImagepost_state.dart';
import 'package:pds/API/Repo/repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OpenSaveCubit extends Cubit<OpenSaveState> {
  OpenSaveCubit() : super(OpenSaveInitialState()) {}
  Future<void> openSaveImagePostAPI(
      BuildContext context, String PostLink, String PostUID) async {
    dynamic OpenSaveModel;
    try {
      emit(OpenSaveLoadingState());
      OpenSaveModel =
          await Repository().openSaveImagePost(context, PostLink, PostUID);
      if (OpenSaveModel == "Something Went Wrong, Try After Some Time.") {
        emit(OpenSaveErrorState("${OpenSaveModel}"));
      } else {
        if (OpenSaveModel.success == true) {
          emit(OpenSaveLoadedState(OpenSaveModel));
        }
      }
    } catch (e) {
      emit(OpenSaveErrorState(OpenSaveModel));
    }
  }

  Future<void> like_post(String? postUid, BuildContext context,
      {bool showAlert = false}) async {
    dynamic likepost;
    try {
      // showAlert == true ? emit(GetGuestAllPostLoadingState()) : SizedBox();
      likepost = await Repository().likePostMethod(postUid, context);
      if (likepost == "Something Went Wrong, Try After Some Time.") {
        emit(OpenSaveErrorState("${likepost}"));
      } else {
        if (likepost.success == true) {
          emit(PostLikeLoadedState(likepost));
        }
      }
    } catch (e) {
      // print('errorstate-$e');
      emit(OpenSaveErrorState(likepost));
    }
  }

  Future<void> savedData(String? postUid, BuildContext context,
      {bool showAlert = false}) async {
    dynamic likepost;
    try {
      // showAlert == true ? emit(GetGuestAllPostLoadingState()) : SizedBox();
      likepost = await Repository().savedPostMethod(postUid, context);
      if (likepost == "Something Went Wrong, Try After Some Time.") {
        emit(OpenSaveErrorState("${likepost}"));
      } else {
        if (likepost.success == true) {
          emit(PostLikeLoadedState(likepost));
        }
      }
    } catch (e) {
      // print('errorstate-$e');
      emit(OpenSaveErrorState(likepost));
    }
  }

  Future<void> RePostAPI(
      BuildContext context, Map<String, dynamic> params, String? uuid,String? name) async {
    dynamic addPostData;
    try {
      emit(OpenSaveLoadingState());
      addPostData = await Repository().RePost(context, params, uuid,name);
      print("addPostDataaaaaaaaaaaa-->${addPostData}");
      if (addPostData.success == true) {
        emit(RePostLoadedState(addPostData));
      }
    } catch (e) {
      emit(OpenSaveErrorState(addPostData));
    }
  }
}
