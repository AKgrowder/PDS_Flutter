import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pds/API/Bloc/HashTag_Bloc/HashTag_state.dart';
import 'package:pds/API/Repo/repository.dart';

class HashTagCubit extends Cubit<HashTagState> {
  HashTagCubit() : super(HashTagInitialState()) {}
  dynamic getalluserlistModel;
  dynamic HashTagForYouModel;
  Future<void> HashTagForYouAPI(
      BuildContext context, String hashtagViewType, String pageNumber) async {
    try {
      emit(HashTagLoadingState());
      HashTagForYouModel = await Repository()
          .HashTagForYouAPI(context, hashtagViewType, pageNumber);
      if (HashTagForYouModel.success == true) {
        emit(HashTagLoadedState(HashTagForYouModel));
      }
    } catch (e) {
      // print('errorstate-$e');
      emit(HashTagErrorState(HashTagForYouModel));
    }
  }

  Future<void> HashTagForYouAPIDataGet(
      BuildContext context, String hashtagViewType, String pageNumber) async {
    dynamic HasthagpagantionDataGet;
    try {
      emit(HashTagLoadingState());
      HasthagpagantionDataGet = await Repository()
          .HashTagForYouAPI(context, hashtagViewType, pageNumber);
      if (HasthagpagantionDataGet.success == true) {
        HashTagForYouModel.object.content
            .addAll(HasthagpagantionDataGet.object.content);
        HashTagForYouModel.object.pageable.pageNumber =
            HasthagpagantionDataGet.object.pageable.pageNumber;
        HashTagForYouModel.object.totalElements =
            HasthagpagantionDataGet.object.totalElements;
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

  Future<void> getalluser(
    int? pageNumber,
    String searchName,
    BuildContext context, {
    String? filterModule,
  }) async {
    try {
      emit(HashTagLoadingState());
      getalluserlistModel = await Repository().getalluser(
          pageNumber, searchName, context,
          filterModule: filterModule);
      if (getalluserlistModel == "Something Went Wrong, Try After Some Time.") {
        emit(HashTagErrorState("${getalluserlistModel}"));
      } else {
        if (getalluserlistModel.success == true) {
          emit(GetAllUserLoadedState(getalluserlistModel));
        }
      }
    } catch (e) {
      print('errorstateshwowData-$e');
      emit(HashTagErrorState(e.toString()));
    }
  }

  Future<void> getAllPagaationApi(
    int? pageNumber,
    String searchName,
    BuildContext context, {
    String? filterModule,
  }) async {
    dynamic getalluserlistModelDataSetup;
    try {
      emit(HashTagLoadingState());
      getalluserlistModelDataSetup = await Repository().getalluser(
          pageNumber, searchName, context,
          filterModule: filterModule);
      if (getalluserlistModelDataSetup.success == true) {
        getalluserlistModel.object.content
            .addAll(getalluserlistModelDataSetup.object.content);
        getalluserlistModel.object.pageable.pageNumber =
            getalluserlistModelDataSetup.object.pageable.pageNumber;
        getalluserlistModel.object.totalElements =
            getalluserlistModelDataSetup.object.totalElements;
        emit(GetAllUserLoadedState(getalluserlistModel));
      }
    } catch (e) {
      emit(HashTagErrorState(e.toString()));
    }
  }

  Future<void> HashTagBannerAPI(BuildContext context) async {
    dynamic hashTagBannerModel;
    try {
      emit(HashTagLoadingState());
      hashTagBannerModel = await Repository().HashTagBanner(context);
      if (hashTagBannerModel.success == true) {
        emit(HashTagBannerLoadedState(hashTagBannerModel));
        print(hashTagBannerModel.message);
      }
    } catch (e) {
      emit(HashTagErrorState(e.toString()));
    }
  }

  Future<void> serchDataAdd(BuildContext context, String typeWord) async {
    dynamic serchDataAdd;
    try {
      emit(HashTagLoadingState());
      serchDataAdd =
          await Repository().search_historyDataAdd(context, typeWord);
      if (serchDataAdd.success == true) {
        emit(SerchDataAddClass(serchDataAdd));
        print(serchDataAdd.message);
      }
    } catch (e) {
      emit(HashTagErrorState(e.toString()));
    }
  }

  Future<void> serchDataGet(BuildContext context) async {
    dynamic getSerchData;
    try {
      emit(HashTagLoadingState());
      getSerchData = await Repository().getSerchData(context);
      if (getSerchData.success == true) {
        emit(GetSerchData(getSerchData));
        print(getSerchData.message);
      }
    } catch (e) {
      emit(HashTagErrorState(e.toString()));
    }
  }
}
