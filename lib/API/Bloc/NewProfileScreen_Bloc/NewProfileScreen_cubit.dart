import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pds/API/Bloc/NewProfileScreen_Bloc/NewProfileScreen_state.dart';
import 'package:pds/API/Repo/repository.dart';

class NewProfileSCubit extends Cubit<NewProfileSState> {
  NewProfileSCubit() : super(NewProfileSInitialState()) {}
  Future<void> NewProfileSAPI(
    BuildContext context,
    String UserUid,
    bool profileNotification,
  ) async {
    dynamic PublicRModel;
    try {
      emit(NewProfileSLoadingState());
      PublicRModel = await Repository().NewProfileAPI(context, UserUid, profileNotification);
      if (PublicRModel == "Something Went Wrong, Try After Some Time.") {
        emit(NewProfileSErrorState("${PublicRModel}"));
      } else {
        if (PublicRModel.success == true) {
          emit(NewProfileSLoadedState(PublicRModel));
        }
      }
    } catch (e) {
      print("error-${e.toString()}");
      emit(NewProfileSErrorState(PublicRModel));
    }
  }

  Future<void> GetAppPostAPI(BuildContext context, String userUid) async {
    dynamic PublicRModel;
    try {
      emit(NewProfileSLoadingState());
      PublicRModel = await Repository().GetAppPostAPI(context, userUid);
      if (PublicRModel == "Something Went Wrong, Try After Some Time.") {
        emit(NewProfileSErrorState("${PublicRModel}"));
      } else {
        if (PublicRModel.success == true) {
          emit(GetAppPostByUserLoadedState(PublicRModel));
        }
      }
    } catch (e) {
      emit(NewProfileSErrorState(PublicRModel));
    }
  }

  Future<void> GetPostCommetAPI(
      BuildContext context, String userUid, String orderBy) async {
    dynamic PublicRModel;
    try {
      emit(NewProfileSLoadingState());
      PublicRModel =
          await Repository().GetPostCommetAPI(context, userUid, orderBy);
      if (PublicRModel == "Something Went Wrong, Try After Some Time.") {
        emit(NewProfileSErrorState("${PublicRModel}"));
      } else {
        if (PublicRModel.success == true) {
          emit(GetUserPostCommetLoadedState(PublicRModel));
        }
      }
    } catch (e) {
      emit(NewProfileSErrorState(e.toString()));
    }
  }

  Future<void> GetSavePostAPI(BuildContext context, String userUid) async {
    dynamic PublicRModel;
    try {
      emit(NewProfileSLoadingState());
      PublicRModel = await Repository().GetSavePostAPI(context, userUid);
      if (PublicRModel == "Something Went Wrong, Try After Some Time.") {
        emit(NewProfileSErrorState("${PublicRModel}"));
      } else {
        if (PublicRModel.success == true) {
          emit(GetSavePostLoadedState(PublicRModel));
        }
      }
    } catch (e) {
      emit(NewProfileSErrorState(PublicRModel));
    }
  }

  Future<void> add_update_about_me(BuildContext context, String userUid) async {
    dynamic PublicRModel;
    try {
      emit(NewProfileSLoadingState());
      PublicRModel = await Repository().GetSavePostAPI(context, userUid);
      if (PublicRModel == "Something Went Wrong, Try After Some Time.") {
        emit(NewProfileSErrorState("${PublicRModel}"));
      } else {
        if (PublicRModel.success == true) {
          emit(GetSavePostLoadedState(PublicRModel));
        }
      }
    } catch (e) {
      emit(NewProfileSErrorState(PublicRModel));
    }
  }

  Future<void> abboutMeApi(BuildContext context, String aboutMe) async {
    dynamic aboutMedataSet;
    try {
      emit(NewProfileSLoadingState());
      aboutMedataSet = await Repository().aboutMe(context, aboutMe);
      if (aboutMedataSet == "Something Went Wrong, Try After Some Time.") {
        emit(NewProfileSErrorState("${aboutMedataSet}"));
      } else {
        if (aboutMedataSet.success == true) {
          emit(AboutMeLoadedState(aboutMedataSet));
        }
      }
    } catch (e) {
      emit(NewProfileSErrorState(e.toString()));
    }
  }

  Future<void> get_about_me(BuildContext context, String userId) async {
    dynamic aboutMedataSet;
    try {
      emit(NewProfileSLoadingState());
      aboutMedataSet = await Repository().getAllDataGet(context, userId);
      if (aboutMedataSet == "Something Went Wrong, Try After Some Time.") {
        emit(NewProfileSErrorState("${aboutMedataSet}"));
      } else {
        if (aboutMedataSet.success == true) {
          emit(AboutMeLoadedState1(aboutMedataSet));
        }
      }
    } catch (e) {
      emit(NewProfileSErrorState(e.toString()));
    }
  }

  Future<void> GetAllSaveBlog(BuildContext context, String userId) async {
    dynamic aboutMedataSet;
    try {
      emit(NewProfileSLoadingState());
      aboutMedataSet = await Repository().GetAllSaveBlog(context, userId);
      if (aboutMedataSet == "Something Went Wrong, Try After Some Time.") {
        emit(NewProfileSErrorState("${aboutMedataSet}"));
      } else {
        if (aboutMedataSet.success == true) {
          emit(saveAllBlogModelLoadedState1(aboutMedataSet));
        }
      }
    } catch (e) {
      emit(NewProfileSErrorState(e.toString()));
    }
  }

  Future<void> followWIngMethod(String? followedToUid, BuildContext context,
      {bool showAlert = false}) async {
    dynamic likepost;
    try {
      // showAlert == true ? emit(GetGuestAllPostLoadingState()) : SizedBox();
      likepost = await Repository().folliwingMethod(followedToUid, context);
      if (likepost == "Something Went Wrong, Try After Some Time.") {
        emit(NewProfileSErrorState("${likepost}"));
      } else {
        if (likepost.success == true) {
          emit(PostLikeLoadedState(likepost));
        }
      }
    } catch (e) {
      // print('errorstate-$e');
      emit(NewProfileSErrorState(e.toString()));
    }
  }

  Future<void> ProfileSaveBlog(
      BuildContext context, String userUid, String blogUid) async {
    dynamic getallBlogmodel;
    try {
      emit(NewProfileSLoadingState());
      getallBlogmodel = await Repository().SaveBlog(context, userUid, blogUid);
      if (getallBlogmodel == "Something Went Wrong, Try After Some Time.") {
        emit(NewProfileSErrorState("${getallBlogmodel}"));
      } else {
        if (getallBlogmodel.success == true) {
          emit(ProfilesaveBlogLoadedState(getallBlogmodel));
        }
      }
    } catch (e) {
      emit(NewProfileSErrorState(getallBlogmodel));
    }
  }

  Future<void> ProfileLikeBlog(
      BuildContext context, String userUid, String blogUid) async {
    dynamic getallBlogmodel;
    try {
      emit(NewProfileSLoadingState());
      getallBlogmodel = await Repository().LikeBlog(context, userUid, blogUid);
      if (getallBlogmodel == "Something Went Wrong, Try After Some Time.") {
        emit(NewProfileSErrorState("${getallBlogmodel}"));
      } else {
        if (getallBlogmodel.success == true) {
          emit(ProfilelikeBlogLoadedState(getallBlogmodel));
        }
      }
    } catch (e) {
      emit(NewProfileSErrorState(getallBlogmodel));
    }
  }

  Future<void> getFollwerApi(
    BuildContext context,
    String userUid,
  ) async {
    dynamic getAllFollwerData;
    try {
      emit(NewProfileSLoadingState());
      getAllFollwerData = await Repository().fllowersApi(
        context,
        userUid,
      );
      if (getAllFollwerData == "Something Went Wrong, Try After Some Time.") {
        emit(NewProfileSErrorState("${getAllFollwerData}"));
      } else {
        if (getAllFollwerData.success == true) {
          emit(FollowersClass(getAllFollwerData));
        }
      }
    } catch (e) {
      emit(NewProfileSErrorState(getAllFollwerData));
    }
  }

  Future<void> getAllFollwing(
    BuildContext context,
    String userUid,
  ) async {
    dynamic getAllFollwerData;
    try {
      emit(NewProfileSLoadingState());
      getAllFollwerData = await Repository().get_all_followering(
        context,
        userUid,
      );
      if (getAllFollwerData == "Something Went Wrong, Try After Some Time.") {
        emit(NewProfileSErrorState("${getAllFollwerData}"));
      } else {
        if (getAllFollwerData.success == true) {
          emit(FollowersClass1(getAllFollwerData));
        }
      }
    } catch (e) {
      emit(NewProfileSErrorState(getAllFollwerData));
    }
  }

  Future<void> fetchExprties(BuildContext context) async {
    dynamic fetchExprtise;
    try {
      emit(NewProfileSLoadingState());
      fetchExprtise = await Repository().fetchExprtise(context);
      if (fetchExprtise == "Something Went Wrong, Try After Some Time.") {
        emit(NewProfileSErrorState("${fetchExprtise}"));
      } else {
        if (fetchExprtise.success == true) {
          emit(FetchexprtiseRoomLoadedState(fetchExprtise));
        }
      }
    } catch (e) {
      emit(NewProfileSErrorState(fetchExprtise));
    }
  }

  Future<void> IndustryTypeAPI(BuildContext context) async {
    dynamic industryType;
    try {
      emit(NewProfileSLoadingState());
      industryType = await Repository().IndustryType(context);
      if (industryType == "Something Went Wrong, Try After Some Time.") {
        emit(NewProfileSErrorState("${industryType}"));
      } else {
        if (industryType.success == true) {
          emit(IndustryTypeLoadedState(industryType));
        }
      }
    } catch (e) {
      emit(NewProfileSErrorState(industryType));
    }
  }

  Future<void> AddWorkExperienceAPI(
      Map<String, dynamic> params, BuildContext context) async {
    dynamic addWorkExperienceModel;
    try {
      emit(NewProfileSLoadingState());
      addWorkExperienceModel =
          await Repository().AddWorkExperience(params, context);
      if (addWorkExperienceModel ==
          "Something Went Wrong, Try After Some Time.") {
        emit(NewProfileSErrorState("${addWorkExperienceModel}"));
      } else {
        if (addWorkExperienceModel.success == true) {
          emit(AddWorkExpereinceLoadedState(addWorkExperienceModel));
          print(addWorkExperienceModel);
        }
      }
    } catch (e) {
      emit(NewProfileSErrorState(addWorkExperienceModel));
    }
  }

  Future<void> GetWorkExperienceAPI(
      BuildContext context, String userUId) async {
    dynamic industryType;
    try {
      emit(NewProfileSLoadingState());
      industryType = await Repository().GetWorkExperience(context, userUId);
      if (industryType == "Something Went Wrong, Try After Some Time.") {
        emit(NewProfileSErrorState("${industryType}"));
      } else {
        if (industryType.success == true) {
          emit(GetWorkExpereinceLoadedState(industryType));
        }
      }
    } catch (e) {
      emit(NewProfileSErrorState(industryType));
    }
  }

  Future<void> DeleteWorkExperienceAPI(
      String workExperienceUid, BuildContext context) async {
    dynamic industryType;
    try {
      emit(NewProfileSLoadingState());
      industryType =
          await Repository().deleteWorkExperience(workExperienceUid, context);
      if (industryType == "Something Went Wrong, Try After Some Time.") {
        emit(NewProfileSErrorState("${industryType}"));
      } else {
        if (industryType.success == true) {
          emit(DeleteWorkExpereinceLoadedState(industryType));
        }
      }
    } catch (e) {
      emit(NewProfileSErrorState(industryType));
    }
  }

  Future<void> DMChatListm(String userWithUid, BuildContext context) async {
    dynamic DMChatList;
    try {
      emit(NewProfileSLoadingState());
      DMChatList = await Repository().FirstTimeChat(context, userWithUid);
      if (DMChatList == "Something Went Wrong, Try After Some Time.") {
        emit(NewProfileSErrorState("${DMChatList}"));
      } else {
        if (DMChatList.success == true) {
          emit(DMChatListLoadedState(DMChatList));
        } else {
          emit(NewProfileSErrorState(DMChatList.message));
        }
      }
    } catch (e) {
      emit(NewProfileSErrorState(DMChatList));
    }
  }

  Future<void> search_user_for_inbox(
      BuildContext context, String typeWord, String pageNumber) async {
    try {
      dynamic searchHistoryDataAdd = await Repository()
          .search_user_for_inbox(typeWord, pageNumber, context);
      if (searchHistoryDataAdd.success == true) {
        emit(SearchHistoryDataAddxtends(searchHistoryDataAdd));
      }
    } catch (e) {
      print("eeerrror-${e.toString()}");
      emit(NewProfileSErrorState(e.toString()));
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

  Future<void> UserTagAPI(BuildContext context, String? name) async {
    dynamic userTagData;
    try {
      emit(NewProfileSLoadingState());
      userTagData = await Repository().UserTag(context, name);
      print("userTagDataaaaaaaaaaaa-->${userTagData}");
      if (userTagData == "Something Went Wrong, Try After Some Time.") {
        emit(NewProfileSErrorState("${userTagData}"));
      } else {
        if (userTagData.success == true) {
          emit(UserTagLoadedState(userTagData));
        }
      }
    } catch (e) {
      emit(NewProfileSErrorState(userTagData));
    }
  }

  Future<void> like_post(String? postUid, BuildContext context,
      {bool showAlert = false}) async {
    dynamic likepost;
    try {
      // showAlert == true ? emit(GetGuestAllPostLoadingState()) : SizedBox();
      likepost = await Repository().likePostMethod(postUid, context);
      if (likepost == "Something Went Wrong, Try After Some Time.") {
        emit(NewProfileSErrorState("${likepost}"));
      } else {
        if (likepost.success == true) {
          emit(PostLikeLoadedState(likepost));
        }
      }
    } catch (e) {
      // print('errorstate-$e');
      emit(NewProfileSErrorState(likepost));
    }
  }

  Future<void> savedData(String? postUid, BuildContext context,
      {bool showAlert = false}) async {
    dynamic likepost;
    try {
      // showAlert == true ? emit(GetGuestAllPostLoadingState()) : SizedBox();
      likepost = await Repository().savedPostMethod(postUid, context);
      if (likepost == "Something Went Wrong, Try After Some Time.") {
        emit(NewProfileSErrorState("${likepost}"));
      } else {
        if (likepost.success == true) {
          emit(PostLikeLoadedState(likepost));
        }
      }
    } catch (e) {
      // print('errorstate-$e');
      emit(NewProfileSErrorState(likepost));
    }
  }

  Future<void> RePostAPI(BuildContext context, Map<String, dynamic> params,
      String? uuid, String? name) async {
    dynamic addPostData;
    try {
      emit(NewProfileSLoadingState());
      addPostData = await Repository().RePost(context, params, uuid, name);
      print("addPostDataaaaaaaaaaaa-->${addPostData}");
      if (addPostData == "Something Went Wrong, Try After Some Time.") {
        emit(NewProfileSErrorState("${addPostData}"));
      } else {
        if (addPostData.success == true) {
          emit(RePostLoadedState(addPostData));
        }
      }
    } catch (e) {
      emit(NewProfileSErrorState(addPostData));
    }
  }

  Future<void> DeletePost(String postUid, BuildContext context) async {
    dynamic Deletepost;
    try {
      emit(NewProfileSLoadingState());
      Deletepost = await Repository().Deletepost(postUid, context);
      if (Deletepost == "Something Went Wrong, Try After Some Time.") {
        emit(NewProfileSErrorState("${Deletepost}"));
      } else {
        if (Deletepost.success == true) {
          emit(DeletePostLoadedState(Deletepost));
          Navigator.pop(context);
        } else {
          emit(NewProfileSErrorState(Deletepost.message));
        }
      }
    } catch (e) {
      emit(NewProfileSErrorState(Deletepost));
    }
  }
}
