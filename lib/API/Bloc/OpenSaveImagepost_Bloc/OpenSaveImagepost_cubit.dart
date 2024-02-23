import 'package:pds/API/Bloc/OpenSaveImagepost_Bloc/OpenSaveImagepost_state.dart';
import 'package:pds/API/Repo/repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OpenSaveCubit extends Cubit<OpenSaveState> {
  OpenSaveCubit() : super(OpenSaveInitialState()) {}
  Future<void> openSaveImagePostAPI(
      BuildContext context, String PostUID,{bool showAlert = false}) async {
    dynamic OpenSaveModel;
    try {
       showAlert == true ? emit(OpenSaveLoadingState()) : SizedBox();
      OpenSaveModel = await Repository().openSaveImagePost(context, PostUID);
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

  Future<void> RePostAPI(BuildContext context, Map<String, dynamic> params,
      String? uuid, String? name) async {
    dynamic addPostData;
    try {
      emit(OpenSaveLoadingState());
      addPostData = await Repository().RePost(context, params, uuid, name);
      print("addPostDataaaaaaaaaaaa-->${addPostData}");
      if (addPostData.success == true) {
        emit(RePostLoadedState(addPostData));
      }
    } catch (e) {
      emit(OpenSaveErrorState(addPostData));
    }
  }

  Future<void> UserTagAPI(BuildContext context, String? name) async {
    dynamic userTagData;
    try {
      emit(OpenSaveLoadingState());
      userTagData = await Repository().UserTag(context, name);
      print("userTagDataaaaaaaaaaaa-->${userTagData}");
      if (userTagData == "Something Went Wrong, Try After Some Time.") {
        emit(OpenSaveErrorState("${userTagData}"));
      } else {
        if (userTagData.success == true) {
          emit(UserTagSaveLoadedState(userTagData));
        }
      }
    } catch (e) {
      emit(OpenSaveErrorState(userTagData));
    }
  }

  Future<void> followWIngMethodd(
    String? followedToUid,
    BuildContext context,
  ) async {
    dynamic likepost;
    try {
    
      likepost = await Repository().folliwingMethod(followedToUid, context);
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

   Future<void> DeletePost(String postUid, BuildContext context) async {
    dynamic Deletepost;
    try {
      emit(OpenSaveLoadingState());
      Deletepost = await Repository().Deletepost(postUid, context);
      if (Deletepost == "Something Went Wrong, Try After Some Time.") {
        emit(OpenSaveErrorState("${Deletepost}"));
      } else {
        if (Deletepost.success == true) {
          emit(DeletePostLoadedState(Deletepost));
          Navigator.pop(context);
        } else {
          emit(OpenSaveErrorState(Deletepost.message));
        }
      }
    } catch (e) {
      emit(OpenSaveErrorState(Deletepost));
    }
  }
}
