import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pds/API/ApiService/ApiService.dart';
import 'package:pds/API/Bloc/GuestAllPost_Bloc/GuestAllPost_state.dart';
import 'package:pds/API/Repo/repository.dart';

class GetGuestAllPostCubit extends Cubit<GetGuestAllPostState> {
  dynamic gestUserData;
  dynamic PublicRModel;

  GetGuestAllPostCubit() : super(GetGuestAllPostInitialState()) {}
  Future<void> seetinonExpried(BuildContext context,
      {bool showAlert = false}) async {
    try {
      emit(GetGuestAllPostLoadingState());
    dynamic settionExperied = await Repository().logOutSettionexperied(context);
    print("checkDatWant--$settionExperied");
    if (settionExperied == "Something Went Wrong, Try After Some Time.") {
        emit(GetGuestAllPostErrorState("${settionExperied}"));
      } else {
      if (settionExperied.success == true) {
      await setLOGOUT(context);
      }
      else{
        print("failed--check---${settionExperied}");
      }}
    } catch (e) {
      print('errorstate-$e');
      // emit(GetGuestAllPostErrorState(e.toString()));
    }
  }
  Future<void> GetGuestAllPostAPI(BuildContext context, String pageNumber,
      {bool showAlert = false}) async {
    try {
      emit(GetGuestAllPostLoadingState());
      PublicRModel = await Repository().GetGuestAllPost(context, pageNumber);
       if (PublicRModel == "Something Went Wrong, Try After Some Time.") {
        emit(GetGuestAllPostErrorState("${PublicRModel}"));
      } else {
      if (PublicRModel.success == true) {
        emit(GetGuestAllPostLoadedState(PublicRModel));
      }}
    } catch (e) {
      print('errorstate-$e');
      emit(GetGuestAllPostErrorState(e.toString()));
    }
  }

  Future<void> GetGuestAllPostAPIPagantion(
      BuildContext context, String pageNumber,
      {bool showAlert = false}) async {
    dynamic gestUserDatasetUp;
    try {
      print("showAlert-->$showAlert");
      showAlert == true ? emit(GetGuestAllPostLoadingState()) : SizedBox();
      gestUserDatasetUp =
          await Repository().GetGuestAllPost(context, pageNumber);
           if (gestUserDatasetUp == "Something Went Wrong, Try After Some Time.") {
        emit(GetGuestAllPostErrorState("${gestUserDatasetUp}"));
      } else {
      if (gestUserDatasetUp.success == true) {
        if (gestUserDatasetUp.object != null) {
          PublicRModel.object.content.addAll(gestUserDatasetUp.object.content);
          PublicRModel.object.pageable.pageNumber =
              gestUserDatasetUp.object.pageable.pageNumber;
          PublicRModel.object.totalElements =
              gestUserDatasetUp.object.totalElements;
        }
        emit(GetGuestAllPostLoadedState(PublicRModel));
      }}
    } catch (e) {
      // print('errorstate-$e');
      emit(GetGuestAllPostErrorState(e.toString()));
    }
  }

  Future<void> GetUserAllPostAPI(BuildContext context, String pageNumber,
      {bool showAlert = false}) async {
    try {
      print("showAlert-->$showAlert");
      showAlert == true ? emit(GetGuestAllPostLoadingState()) : SizedBox();
      gestUserData = await Repository().GetUserAllPost(context, pageNumber);
       if (gestUserData == "Something Went Wrong, Try After Some Time.") {
        emit(GetGuestAllPostErrorState("${gestUserData}"));
      } else {
      if (gestUserData.success == true) {
        print("GetUserAllPostAPI data get");
        emit(GetGuestAllPostLoadedState(gestUserData));
      }}
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
           if (gestUserDatasetUp == "Something Went Wrong, Try After Some Time.") {
        emit(GetGuestAllPostErrorState("${gestUserDatasetUp}"));
      } else {
      if (gestUserDatasetUp.success == true) {
        if (gestUserDatasetUp.object != null) {
          gestUserData.object.content.addAll(gestUserDatasetUp.object.content);
          gestUserData.object.pageable.pageNumber =
              gestUserDatasetUp.object.pageable.pageNumber;
          gestUserData.object.totalElements =
              gestUserDatasetUp.object.totalElements;
        }
        emit(GetGuestAllPostLoadedState(gestUserData));
      }}
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

  Future<void> savedData(String? postUid, BuildContext context,
      {bool showAlert = false}) async {
    dynamic likepost;
    try {
      // showAlert == true ? emit(GetGuestAllPostLoadingState()) : SizedBox();
      likepost = await Repository().savedPostMethod(postUid, context);
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

  // this is the follwing method
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

  Future<void> get_all_story(BuildContext context,
      {bool showAlert = false}) async {
    dynamic getAllStory;
    try {
      emit(GetGuestAllPostLoadingState());
      getAllStory = await Repository().GetAllStory(context);
       if (getAllStory == "Something Went Wrong, Try After Some Time.") {
        emit(GetGuestAllPostErrorState("${getAllStory}"));
      } else {
      if (getAllStory.success == true) {
        emit(GetAllStoryLoadedState(getAllStory));
      }}
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
       if (PublicRModel == "Something Went Wrong, Try After Some Time.") {
        emit(GetGuestAllPostErrorState("${PublicRModel}"));
      } else {
      if (PublicRModel.success == true) {
        emit(FetchAllExpertsLoadedState(PublicRModel));
      }}
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
       if (create_story == "Something Went Wrong, Try After Some Time.") {
        emit(GetGuestAllPostErrorState("${create_story}"));
      } else {
      if (create_story.success == true) {
        emit(GetAllStoryLoadedState(create_story));
      }}
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
       if (Deletepost == "Something Went Wrong, Try After Some Time.") {
        emit(GetGuestAllPostErrorState("${Deletepost}"));
      } else {
      if (Deletepost.success == true) {
        emit(DeletePostLoadedState(Deletepost));
        Navigator.pop(context);
      } else {
        emit(GetGuestAllPostErrorState(Deletepost.message));
      }}
    } catch (e) {
      emit(GetGuestAllPostErrorState(Deletepost));
    }
  }

  Future<void> MyAccount(BuildContext context) async {
    dynamic myAccontDetails;
    try {
      emit(GetGuestAllPostLoadingState());
      myAccontDetails = await Repository().myAccount(context);
       if (myAccontDetails == "Something Went Wrong, Try After Some Time.") {
        emit(GetGuestAllPostErrorState("${myAccontDetails}"));
      } else {
      if (myAccontDetails.success == true) {
        emit(GetUserProfileLoadedState(myAccontDetails));
      } else {
        emit(GetGuestAllPostErrorState(myAccontDetails));
      }}
    } catch (e) {
      emit(GetGuestAllPostErrorState(myAccontDetails));
    }
  }

  Future<void> GetallBlog(BuildContext context, String userUid) async {
    dynamic getallBlogmodel;
    try {
      emit(GetGuestAllPostLoadingState());
      getallBlogmodel = await Repository().GetallBlog(context, userUid);
       if (getallBlogmodel == "Something Went Wrong, Try After Some Time.") {
        emit(GetGuestAllPostErrorState("${getallBlogmodel}"));
      } else {
      if (getallBlogmodel.success == true) {
        emit(GetallblogsLoadedState(getallBlogmodel));
      }}
    } catch (e) {
      emit(GetGuestAllPostErrorState(getallBlogmodel));
    }
  }

  Future<void> SaveBlog(
      BuildContext context, String userUid, String blogUid) async {
    dynamic getallBlogmodel;
    try {
      emit(GetGuestAllPostLoadingState());
      getallBlogmodel = await Repository().SaveBlog(context, userUid, blogUid);
       if (getallBlogmodel == "Something Went Wrong, Try After Some Time.") {
        emit(GetGuestAllPostErrorState("${getallBlogmodel}"));
      } else {
      if (getallBlogmodel.success == true) {
        emit(saveBlogLoadedState(getallBlogmodel));
      }}
    } catch (e) {
      emit(GetGuestAllPostErrorState(getallBlogmodel));
    }
  }

  Future<void> LikeBlog(
      BuildContext context, String userUid, String blogUid) async {
    dynamic getallBlogmodel;
    try {
      emit(GetGuestAllPostLoadingState());
      getallBlogmodel = await Repository().LikeBlog(context, userUid, blogUid);
       if (getallBlogmodel == "Something Went Wrong, Try After Some Time.") {
        emit(GetGuestAllPostErrorState("${getallBlogmodel}"));
      } else {
      if (getallBlogmodel.success == true) {
        emit(likeBlogLoadedState(getallBlogmodel));
      }}
    } catch (e) {
      emit(GetGuestAllPostErrorState(getallBlogmodel));
    }
  }

  Future<void> SystemConfigHome(BuildContext context) async {
    dynamic systemConfigModel;
    try {
      emit(GetGuestAllPostLoadingState());
      systemConfigModel = await Repository().SystemConfig(context);
       if (systemConfigModel == "Something Went Wrong, Try After Some Time.") {
        emit(GetGuestAllPostErrorState("${systemConfigModel}"));
      } else {
      if (systemConfigModel.success == true) {
        emit(SystemConfigLoadedState(systemConfigModel));
      }}
    } catch (e) {
      emit(GetGuestAllPostErrorState(systemConfigModel));
    }
  }

  Future<void> RePostAPI(
      BuildContext context, Map<String, dynamic> params, String? uuid) async {
    dynamic addPostData;
    try {
      emit(GetGuestAllPostLoadingState());
      addPostData = await Repository().RePost(context, params, uuid);
      print("addPostDataaaaaaaaaaaa-->${addPostData}");
       if (addPostData == "Something Went Wrong, Try After Some Time.") {
        emit(GetGuestAllPostErrorState("${addPostData}"));
      } else {
      if (addPostData.success == true) {
        emit(RePostLoadedState(addPostData));
      }}
    } catch (e) {
      emit(GetGuestAllPostErrorState(addPostData));
    }
  }
}
