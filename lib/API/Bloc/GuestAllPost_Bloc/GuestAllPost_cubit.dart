import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pds/API/Bloc/GuestAllPost_Bloc/GuestAllPost_state.dart';
import 'package:pds/API/Repo/repository.dart';

class GetGuestAllPostCubit extends Cubit<GetGuestAllPostState> {
  dynamic gestUserData;
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
      print('errorstate-$e');
      emit(GetGuestAllPostErrorState(PublicRModel));
    }
  }

  Future<void> GetUserAllPostAPI(BuildContext context, String pageNumber,
      {bool showAlert = false}) async {
    try {
      print("showAlert-->$showAlert");
      showAlert == true ? emit(GetGuestAllPostLoadingState()) : SizedBox();
      gestUserData = await Repository().GetUserAllPost(context, pageNumber);
      if (gestUserData.success == true) {
        print("GetUserAllPostAPI data get");
        emit(GetGuestAllPostLoadedState(gestUserData));
      }
    } catch (e) {
      print('aaaaaaaa-$e');
      emit(GetGuestAllPostErrorState(e.toString()));
    }
  }

  Future<void> GetUserAllPostAPIPagantion(
      BuildContext context, String pageNumber,
      {bool showAlert = false}) async {
    dynamic gestUserDatasetUp;
    try {
      print("showAlert-->$showAlert");
      showAlert == true ? emit(GetGuestAllPostLoadingState()) : SizedBox();
      gestUserDatasetUp =
          await Repository().GetUserAllPost(context, pageNumber);
      if (gestUserDatasetUp.success == true) {
        if (gestUserDatasetUp.object != null) {
          gestUserData.object.content.addAll(gestUserDatasetUp.object.content);
          gestUserData.object.pageable.pageNumber =
              gestUserDatasetUp.object.pageable.pageNumber;
          gestUserData.object.totalElements =
              gestUserDatasetUp.object.totalElements;
        }
        emit(GetGuestAllPostLoadedState(gestUserData));
      }
    } catch (e) {
      // print('errorstate-$e');
      emit(GetGuestAllPostErrorState(gestUserData));
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

  Future<void> get_all_story(BuildContext context,
      {bool showAlert = false}) async {
    dynamic getAllStory;
    try {
      emit(GetGuestAllPostLoadingState());
      getAllStory = await Repository().GetAllStory(context);
      if (getAllStory.success == true) {
        emit(GetAllStoryLoadedState(getAllStory));
      }
    } catch (e) {
      print('errorstate-$e');
      emit(GetGuestAllPostErrorState(e));
    }
  }

  Future<void> FetchAllExpertsAPI(BuildContext context) async {
    dynamic PublicRModel;
    try {
      emit(GetGuestAllPostLoadingState());
      PublicRModel = await Repository().FetchAllExpertsAPI(context);
      if (PublicRModel.success == true) {
        emit(FetchAllExpertsLoadedState(PublicRModel));
      }
    } catch (e) {
      emit(GetGuestAllPostErrorState(PublicRModel));
    }
  }

  Future<void> create_story(
      BuildContext context, Map<String, dynamic> params) async {
    dynamic create_story;
    try {
      emit(GetGuestAllPostLoadingState());
      create_story = await Repository().cretateStoryApi(context, params);
      if (create_story.success == true) {
        emit(GetAllStoryLoadedState(create_story));
      }
    } catch (e) {
      // print('errorstate-$e');
      emit(GetGuestAllPostErrorState(create_story));
    }
  }

  Future<void> DeletePost(String postUid, BuildContext context) async {
    dynamic Deletepost;
    try {
      emit(GetGuestAllPostLoadingState());
      Deletepost = await Repository().Deletepost(postUid, context);
      if (Deletepost.success == true) {
        emit(DeletePostLoadedState(Deletepost));
        Navigator.pop(context);
      } else {
        emit(GetGuestAllPostErrorState(Deletepost.message));
      }
    } catch (e) {
      emit(GetGuestAllPostErrorState(Deletepost));
    }
  }

  Future<void> MyAccount(BuildContext context) async {
    dynamic myAccontDetails;
    try {
      emit(GetGuestAllPostLoadingState());
      myAccontDetails = await Repository().myAccount(context);
      if (myAccontDetails.success == true) {
        emit(GetUserProfileLoadedState(myAccontDetails));
      }
    } catch (e) {
      emit(GetGuestAllPostErrorState(myAccontDetails));
    }
  }

  Future<void> GetallBlog(BuildContext context) async {
    dynamic getallBlogmodel;
    try {
      emit(GetGuestAllPostLoadingState());
      getallBlogmodel = await Repository().GetallBlog(context);
      if (getallBlogmodel.success == true) {
        emit(GetallblogsLoadedState(getallBlogmodel));
      }
    } catch (e) {
      emit(GetGuestAllPostErrorState(getallBlogmodel));
    }
  }
}
