import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pds/API/ApiService/ApiService.dart';
import 'package:pds/API/Bloc/postData_Bloc/postData_state.dart';
import 'package:pds/API/Repo/repository.dart';

class AddPostCubit extends Cubit<AddPostState> {
  AddPostCubit() : super(AddPostInitialState()) {}
  dynamic PersonalChatListModel;
  dynamic searchHistoryDataAdd;
  Future<void> InvitationAPI(
    BuildContext context,
    Map<String, dynamic> params,
  ) async {
    dynamic addPostData;

    try {
      emit(AddPostLoadingState());
      addPostData = await Repository().AddPostApiCalling(context, params);
      print("addPostData-->$addPostData");
      if (addPostData == "Something Went Wrong, Try After Some Time.") {
        emit(AddPostErrorState("${addPostData}"));
      } else {
        if (addPostData.success == true) {
          emit(AddPostLoadedState(addPostData));
        }
      }
    } catch (e) {
      emit(AddPostErrorState(addPostData));
    }
  }

  Future<void> UplodeImageAPI(
    BuildContext context,
    String? fileName,
    String? file,
  ) async {
    dynamic addPostImageUploded;
    try {
      emit(AddPostLoadingState());
      addPostImageUploded = await Repository()
          .AddPostImageUploded(context, fileName ?? '', file ?? '');
      if (addPostImageUploded == "Something Went Wrong, Try After Some Time.") {
        emit(AddPostErrorState("${addPostImageUploded}"));
      } else {
        if (addPostImageUploded.success == true) {
          emit(AddPostImaegState(addPostImageUploded));
        }
      }
    } catch (e) {
      emit(AddPostErrorState(addPostImageUploded));
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
      emit(AddPostErrorState(addPostImageUploded));
    }
  }

  Future<void> UplodeImageAPIImane(
      BuildContext context, List<File> imageFile) async {
    dynamic addPostImageUploded;
    try {
      emit(AddPostLoadingState());
      addPostImageUploded = await Repository().userProfile1(imageFile, context);
      if (addPostImageUploded == "Something Went Wrong, Try After Some Time.") {
        emit(AddPostErrorState("${addPostImageUploded}"));
      } else {
        if (addPostImageUploded.success == true) {
          emit(AddPostImaegState(addPostImageUploded));
        }
      }
    } catch (e) {
      emit(AddPostErrorState(addPostImageUploded));
    }
  }

  Future<void> search_user_for_inbox(
      BuildContext context, String typeWord, String pageNumber) async {
    try {
      searchHistoryDataAdd = await Repository()
          .search_user_for_inbox(typeWord, pageNumber, context);
      if (searchHistoryDataAdd.success == true) {
        emit(SearchHistoryDataAddxtends(searchHistoryDataAdd));
      }
    } catch (e) {
      print("eeerrror-${e.toString()}");
      emit(AddPostErrorState(e.toString()));
    }
  }

  Future<void> search_user_for_inboxPagantion(
      BuildContext context, String typeWord, String pageNumber) async {
    dynamic searchHistoryDataAddInPagantion;
    try {
      searchHistoryDataAddInPagantion = await Repository()
          .search_user_for_inbox(typeWord, pageNumber, context);
      if (searchHistoryDataAddInPagantion.success == true) {
        searchHistoryDataAdd.object.content
            .addAll(searchHistoryDataAddInPagantion.object.content);
        searchHistoryDataAdd.object.pageable.pageNumber =
            searchHistoryDataAddInPagantion.object.pageable.pageNumber;
        searchHistoryDataAdd.object.totalElements =
            searchHistoryDataAddInPagantion.object.totalElements;
        emit(SearchHistoryDataAddxtends(searchHistoryDataAdd));
      }
    } catch (e) {
      print("eeerrror-${e.toString()}");
      emit(AddPostErrorState(e.toString()));
    }
  }

   Future<void> seetinonExpried(BuildContext context,
      {bool showAlert = false}) async {
    try {
      emit(AddPostLoadingState());
      dynamic settionExperied =
          await Repository().logOutSettionexperied(context);
      print("checkDatWant--$settionExperied");
      // if (settionExperied == "Something Went Wrong, Try After Some Time.") {
      //     emit(GetGuestAllPostErrorState("${settionExperied}"));
      //   } else {
      if (settionExperied.success == true) {
        await setLOGOUT(context);
      } else {
        print("failed--check---${settionExperied}");
      }
      // }
    } catch (e) {
      print('errorstate-$e');
      // emit(GetGuestAllPostErrorState(e.toString()));
    }
  }
}
