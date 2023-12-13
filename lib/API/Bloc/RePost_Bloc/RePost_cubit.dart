import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pds/API/Bloc/RePost_Bloc/RePost_state.dart';
import 'package:pds/API/Repo/repository.dart';

class RePostCubit extends Cubit<RePostState> {
  RePostCubit() : super(RePostInitialState()) {}
  Future<void> UplodeImageAPIImane(
      BuildContext context, List<File> imageFile) async {
    dynamic addPostImageUploded;
    try {
      emit(RePostLoadingState());
      addPostImageUploded = await Repository().userProfile1(imageFile, context);
      if (addPostImageUploded == "Something Went Wrong, Try After Some Time.") {
        emit(RePostErrorState("${addPostImageUploded}"));
      } else {
        if (addPostImageUploded.success == true) {
          emit(AddPostImaegState(addPostImageUploded));
        }
      }
    } catch (e) {
      emit(RePostErrorState(addPostImageUploded));
    }
  }

  Future<void> UplodeImageAPI(
    BuildContext context,
    String? fileName,
    String? file,
  ) async {
    dynamic addPostImageUploded;
    try {
      emit(RePostLoadingState());
      addPostImageUploded = await Repository()
          .AddPostImageUploded(context, fileName ?? '', file ?? '');
      if (addPostImageUploded == "Something Went Wrong, Try After Some Time.") {
        emit(RePostErrorState("${addPostImageUploded}"));
      } else {
        if (addPostImageUploded.success == true) {
          emit(AddPostImaegState(addPostImageUploded));
        }
      }
    } catch (e) {
      emit(RePostErrorState(addPostImageUploded));
    }
  }

  Future<void> RePostAPI(
      BuildContext context, Map<String, dynamic> params, String? uuid) async {
    dynamic addPostData;
    try {
      emit(RePostLoadingState());
      addPostData = await Repository().RePost(context, params, uuid);
      print("addPostData-->$addPostData");
      if (addPostData == "Something Went Wrong, Try After Some Time.") {
        emit(RePostErrorState("${addPostData}"));
      } else {
        if (addPostData.success == true) {
          emit(RePostLoadedState(addPostData));
        }
      }
    } catch (e) {
      emit(RePostErrorState(addPostData));
    }
  }

    Future<void> GetAllHashtag(
        BuildContext context, String pageNumber, String searchHashtag) async {
      dynamic addPostImageUploded;
      try {
        addPostImageUploded = await Repository()
            .get_all_hashtag(context, pageNumber, searchHashtag);

        if (addPostImageUploded.success == true) {
          emit(GetAllHashtagState(addPostImageUploded));
        }
      } catch (e) {
        emit(RePostErrorState(addPostImageUploded));
      }
    }

    Future<void> search_user_for_inbox(
        BuildContext context, String typeWord, String pageNumber) async {
      dynamic searchHistoryDataAdd;
      try {
        searchHistoryDataAdd = await Repository()
            .search_user_for_inbox(typeWord, pageNumber, context);
        if (searchHistoryDataAdd.success == true) {
          emit(SearchHistoryDataAddxtends(searchHistoryDataAdd));
        }
      } catch (e) {
        print("eeerrror-${e.toString()}");
        emit(RePostErrorState(e.toString()));
      }
    }
}
