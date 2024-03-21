import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pds/API/Repo/repository.dart';

import 'follwerState.dart';

class FollowerBlock extends Cubit<FolllwerBlockState> {
  FollowerBlock() : super(FollwertBlockInitialState()) {}
  dynamic getalluserlistModel;

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
        }
      }
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
        }
      }
    } catch (e) {
      // print('errorstate-$e');
      emit(FollwertErrroState(likepost));
    }
  }

  Future<void> getFollwerApi(
    BuildContext context,
    String userUid,
  ) async {
    dynamic getAllFollwerData;
    try {
      emit(FollwertBlockLoadingState());
      getAllFollwerData = await Repository().fllowersApi(
        context,
        userUid,
      );
      if (getAllFollwerData == "Something Went Wrong, Try After Some Time.") {
        emit(FollwertErrroState("${getAllFollwerData}"));
      } else {
        if (getAllFollwerData.success == true) {
          emit(FollowersClass(getAllFollwerData));
        }
      }
    } catch (e) {
      emit(FollwertErrroState(getAllFollwerData));
    }
  }

  Future<void> getAllFollwing(
    BuildContext context,
    String userUid,
  ) async {
    dynamic getAllFollwerData;
    try {
      emit(FollwertBlockLoadingState());
      getAllFollwerData = await Repository().get_all_followering(
        context,
        userUid,
      );
      if (getAllFollwerData == "Something Went Wrong, Try After Some Time.") {
        emit(FollwertErrroState("${getAllFollwerData}"));
      } else {
        if (getAllFollwerData.success == true) {
          emit(FollowersClass1(getAllFollwerData));
        }
      }
    } catch (e) {
      emit(FollwertErrroState(getAllFollwerData));
    }
  }

  Future<void> getalluser(
    int? pageNumber,
    String searchName,
    BuildContext context, {
    String? filterModule,
  }) async {
    try {
      emit(FollwertBlockLoadingState());
      getalluserlistModel = await Repository().getalluser(
          pageNumber, searchName, context,
          filterModule: filterModule);

      if (getalluserlistModel.success == true) {
        emit(GetAllUserLoadedState(getalluserlistModel));
      }
    } catch (e) {
      print('errorstateshwowData-$e');
      emit(FollwertErrroState(e.toString()));
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
      emit(FollwertBlockLoadingState());
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
      emit(FollwertErrroState(e.toString()));
    }
  }

  Future<void> get_admin_roles_for_company_pageMethod(
      BuildContext context) async {
    try {
      emit(FollwertBlockLoadingState());
      dynamic getAdminRoleForCompny =
          await Repository().get_admin_roles_for_company_page(
        context,
      );

      if (getAdminRoleForCompny.success == true) {
        emit(AdminRoleForCompnyUserLoadedState(getAdminRoleForCompny));
      }
    } catch (e) {
      print('errorstateshwowData-$e');
      emit(FollwertErrroState(e.toString()));
    }
  }
}
