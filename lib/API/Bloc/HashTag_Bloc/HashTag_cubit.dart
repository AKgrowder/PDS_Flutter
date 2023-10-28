import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pds/API/Bloc/HashTag_Bloc/HashTag_state.dart';
import 'package:pds/API/Repo/repository.dart';

class HashTagCubit extends Cubit<HashTagState> {
  HashTagCubit() : super(HashTagInitialState()) {}
  Future<void> HashTagForYouAPI(BuildContext context) async {
    dynamic HashTagForYouModel;
    try {
      emit(HashTagLoadingState());
      HashTagForYouModel = await Repository().HashTagForYouAPI(context);
      if (HashTagForYouModel.success == true) {
        emit(HashTagLoadedState(HashTagForYouModel));
      }
    } catch (e) {
      // print('errorstate-$e');
      emit(HashTagErrorState(HashTagForYouModel));
    }
  }

  Future<void> HashTagViewDataAPI(
    BuildContext context,
    String hashTag,
  ) async {
    dynamic hashTagViewModel;
    try {
      emit(HashTagLoadingState());
      hashTagViewModel = await Repository().HashTagViewDataAPI(
        context,
        hashTag,
      );
      if (hashTagViewModel.success == true) {
        emit(HashTagViewDataLoadedState(hashTagViewModel));
        print(hashTagViewModel.object.posts);
      }
    } catch (e) {
      // print('errorstate-$e');
      emit(HashTagErrorState(hashTagViewModel));
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
      emit(HashTagErrorState(likepost));
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
      emit(HashTagErrorState(likepost));
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
      emit(HashTagErrorState(likepost));
    }
  }
    Future<void> DeletePost(String postUid, BuildContext context) async {
    dynamic Deletepost;
    try {
      emit(HashTagLoadingState());
      Deletepost = await Repository().Deletepost(postUid, context);
      if (Deletepost.success == true) {
        emit(DeletePostLoadedState(Deletepost));
        Navigator.pop(context);
      } else {
        emit(HashTagErrorState(Deletepost.message));
      }
    } catch (e) {
      emit(HashTagErrorState(Deletepost));
    }
  }
  
}
