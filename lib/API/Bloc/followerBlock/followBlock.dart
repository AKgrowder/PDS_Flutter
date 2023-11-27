

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pds/API/Repo/repository.dart';

import 'follwerState.dart';

class FollowerBlock extends Cubit<FolllwerBlockState> {
  FollowerBlock() : super(FollwertBlockInitialState()) {}
 Future<void> removeFollwerApi(
    BuildContext context,
    String userUid,
  ) async {
    dynamic getAllFollwerData;
    try {
      emit(FollwertBlockLoadingState());
      getAllFollwerData = await Repository().removeFollwerApi(
        context,
        userUid,
      );
      if (getAllFollwerData == "Something Went Wrong, Try After Some Time.") {
        emit(FollwertErrroState("${getAllFollwerData}"));
      } else {
      if (getAllFollwerData.success == true) {
        emit(RemoveLoddingState(getAllFollwerData));
      }}
    } catch (e) {
      emit(FollwertErrroState(e.toString()));
    }
  }

    Future<void> followWIngMethod(String? followedToUid, BuildContext context,
      {bool showAlert = false}) async {
    dynamic likepost;
    try {
      // showAlert == true ? emit(GetGuestAllPostLoadingState()) : SizedBox();
      likepost = await Repository().folliwingMethod(followedToUid, context);
      if (likepost == "Something Went Wrong, Try After Some Time.") {
        emit(FollwertErrroState("${likepost}"));
      } else {
      if (likepost.success == true) {
        emit(PostLikeLoadedState(likepost));
      }}
    } catch (e) {
      // print('errorstate-$e');
      emit(FollwertErrroState(likepost));
    }
  }
}
