import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pds/API/Bloc/GuestAllPost_Bloc/GetPostAllLike_Bloc/GetPostAllLike_state.dart';
 import 'package:pds/API/Repo/repository.dart';

class GetPostAllLikeCubit extends Cubit<GetPostAllLikeState> {
  GetPostAllLikeCubit() : super(GetGuestAllPostInitialState()) {}
  Future<void> GetPostAllLikeAPI(BuildContext context,String PostUID) async {
    dynamic PublicRModel;
    try {
      emit(GetGuestAllPostLoadingState());
      PublicRModel = await Repository().GetPostAllLike(context,PostUID);
      if (PublicRModel == "Something Went Wrong, Try After Some Time.") {
        emit(GetGuestAllPostErrorState("${PublicRModel}"));
      } else {
      if (PublicRModel.success == true) {
        emit(GetGuestAllPostLoadedState(PublicRModel));
      }}
    } catch (e) {
      // print('errorstate-$e');
      emit(GetGuestAllPostErrorState(PublicRModel));
    }
  }

   Future<void> followWIngMethod(String? followedToUid, BuildContext context,
      {bool showAlert = false}) async {
    dynamic likepost;
    try {
      // showAlert == true ? emit(GetGuestAllPostLoadingState()) : SizedBox();
      likepost = await Repository().folliwingMethod(followedToUid, context);
      if (likepost == "Something Went Wrong, Try After Some Time.") {
        emit(GetGuestAllPostErrorState("${likepost}"));
      } else {
      if (likepost.success == true) {
        emit(PostLikeLoadedState(likepost));
      }}
    } catch (e) {
      // print('errorstate-$e');
      emit(GetGuestAllPostErrorState(likepost));
    }
  }

  
}
