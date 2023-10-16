import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pds/API/Bloc/GuestAllPost_Bloc/GuestAllPost_state.dart';
import 'package:pds/API/Repo/repository.dart';

class GetGuestAllPostCubit extends Cubit<GetGuestAllPostState> {
  GetGuestAllPostCubit() : super(GetGuestAllPostInitialState()) {}
  Future<void> GetGuestAllPostAPI(BuildContext context) async {
    dynamic PublicRModel;
    try {
      emit(GetGuestAllPostLoadingState());
      PublicRModel = await Repository().GetGuestAllPost(context);
      if (PublicRModel.success == true) {
        emit(GetGuestAllPostLoadedState(PublicRModel));
      }
    } catch (e) {
      // print('errorstate-$e');
      emit(GetGuestAllPostErrorState(PublicRModel));
    }
  }

  Future<void> GetUserAllPostAPI(BuildContext context,
      {bool showAlert = false}) async {
    dynamic PublicRModel;
    try {

      print("showAlert-->$showAlert");
      showAlert == true ? emit(GetGuestAllPostLoadingState()) : SizedBox();
      PublicRModel = await Repository().GetUserAllPost(context);
      if (PublicRModel.success == true) {
        emit(GetGuestAllPostLoadedState(PublicRModel));
      }
    } catch (e) {
      // print('errorstate-$e');
      emit(GetGuestAllPostErrorState(PublicRModel));
    }
  }

  Future<void> like_post(String? postUid, BuildContext context,
      {bool showAlert = false}) async {
    dynamic likepost;
    try {
      // showAlert == true ? emit(GetGuestAllPostLoadingState()) : SizedBox();
      likepost = await Repository().likePostMethod(postUid, context);
      if (likepost.success == true) {
        emit(PostLikeLoadedState(likepost));
      }
    } catch (e) {
      // print('errorstate-$e');
      emit(GetGuestAllPostErrorState(likepost));
    }
  }
   Future<void> savedData(String? postUid, BuildContext context,
      {bool showAlert = false}) async {
    dynamic likepost;
    try {
      // showAlert == true ? emit(GetGuestAllPostLoadingState()) : SizedBox();
      likepost = await Repository().savedPostMethod(postUid, context);
      if (likepost.success == true) {
        emit(PostLikeLoadedState(likepost));
      }
    } catch (e) {
      // print('errorstate-$e');
      emit(GetGuestAllPostErrorState(likepost));
    }
  }
  Future<void> followWIngMethod(String? followedToUid, BuildContext context,
      {bool showAlert = false}) async {
    dynamic likepost;
    try {
      // showAlert == true ? emit(GetGuestAllPostLoadingState()) : SizedBox();
      likepost = await Repository().folliwingMethod(followedToUid, context);
      if (likepost.success == true) {
        emit(PostLikeLoadedState(likepost));
      }
    } catch (e) {
      // print('errorstate-$e');
      emit(GetGuestAllPostErrorState(likepost));
    }
  }
}
