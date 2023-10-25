import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pds/API/Bloc/postData_Bloc/postData_state.dart';
import 'package:pds/API/Repo/repository.dart';

class AddPostCubit extends Cubit<AddPostState> {
  AddPostCubit() : super(AddPostInitialState()) {}
  Future<void> InvitationAPI(
    BuildContext context,
    Map<String, dynamic> params,
  ) async {
    dynamic addPostData;
    try {
      emit(AddPostLoadingState());
      addPostData = await Repository().AddPostApiCalling(context, params);
      print("addPostData-->$addPostData");
      if (addPostData.success == true) {
        emit(AddPostLoadedState(addPostData));
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
      if (addPostImageUploded.success == true) {
        emit(AddPostImaegState(addPostImageUploded));
      }
    } catch (e) {
      emit(AddPostErrorState(addPostImageUploded));
    }
  }

  Future<void> UplodeImageAPIImane(BuildContext context, List<File> imageFile) async {
    dynamic addPostImageUploded;
    try {
      emit(AddPostLoadingState());
      addPostImageUploded = await Repository().userProfile1(imageFile, context);
      if (addPostImageUploded.success == true) {
        emit(AddPostImaegState(addPostImageUploded));
      }
    } catch (e) {
      emit(AddPostErrorState(addPostImageUploded));
    }
  }
}
