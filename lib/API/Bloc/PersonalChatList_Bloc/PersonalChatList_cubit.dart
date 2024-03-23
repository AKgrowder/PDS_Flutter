import 'dart:io';

import 'package:pds/API/ApiService/ApiService.dart';
import 'package:pds/API/Bloc/PersonalChatList_Bloc/PersonalChatList_State.dart';
import 'package:pds/API/Repo/repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PersonalChatListCubit extends Cubit<PersonalChatListState> {
  PersonalChatListCubit() : super(PersonalChatListInitialState()) {}
  dynamic PersonalChatListModel;
  dynamic searchHistoryDataAdd;
  dynamic getUsersChatByUsernameData;
  Future<void> PersonalChatList(BuildContext context) async {
    try {
      emit(PersonalChatListLoadingState());
      PersonalChatListModel = await Repository().PersonalChatList(context);
      if (PersonalChatListModel ==
          "Something Went Wrong, Try After Some Time.") {
        emit(PersonalChatListErrorState("${PersonalChatListModel}"));
      } else {
        if (PersonalChatListModel.success == true) {
          emit(PersonalChatListLoadedState(PersonalChatListModel));
        }
      }
    } catch (e) {
      emit(PersonalChatListErrorState(PersonalChatListModel));
    }
  }

  Future<void> selectMultipleUsers_ChatMethod(
      Map<String, dynamic> params, BuildContext context) async {
    try {
      emit(PersonalChatListLoadingState());
      dynamic selcatedData =
          await Repository().selectMultipleUsers_Chat(params, context);

      if (selcatedData.success == true) {
        emit(SelectMultipleUsers_ChatLoadestate(selcatedData));
      }
    } catch (e) {
      emit(PersonalChatListErrorState(e));
    }
  }

  Future<void> UplodeImageAPI(BuildContext context, File imageFile) async {
    dynamic addPostImageUploded;
    try {
      emit(PersonalChatListLoadingState());
      addPostImageUploded =
          await Repository().userProfileprofileCover(imageFile, context);

      if (addPostImageUploded.success == true) {
        emit(AddPostImaegState(addPostImageUploded));
      }
    } catch (e) {
      emit(PersonalChatListErrorState(e.toString()));
    }
  }

  Future<void> search_user_for_inbox(
      BuildContext context, String typeWord, String pageNumber) async {
    try {
      emit(PersonalChatListLoadingState());
      searchHistoryDataAdd = await Repository()
          .search_user_for_inbox1(typeWord, pageNumber, context);
      if (searchHistoryDataAdd ==
          "Something Went Wrong, Try After Some Time.") {
        emit(PersonalChatListErrorState("${searchHistoryDataAdd}"));
      } else {
        if (searchHistoryDataAdd.success == true) {
          emit(SearchHistoryDataAddxtends(searchHistoryDataAdd));
        }
      }
    } catch (e) {
      print("eeerrror-${e.toString()}");
      emit(PersonalChatListErrorState(e.toString()));
    }
  }

  Future<void> search_user_for_inboxPagantion(
      BuildContext context, String typeWord, String pageNumber) async {
    dynamic searchHistoryDataAddInPagantion;
    try {
      emit(PersonalChatListLoadingState());
      searchHistoryDataAddInPagantion = await Repository()
          .search_user_for_inbox1(typeWord, pageNumber, context);
      if (searchHistoryDataAddInPagantion.success == true) {
        searchHistoryDataAdd.object.content
            .addAll(searchHistoryDataAddInPagantion.object.content);
        searchHistoryDataAdd.object.pageable.pageNumber =
            searchHistoryDataAddInPagantion.object.pageable.pageNumber;
        searchHistoryDataAdd.object.totalElements =
            searchHistoryDataAddInPagantion.object.totalElements;
        emit(SearchHistoryDataAddxtends(searchHistoryDataAdd));
      }
    } catch (e) {
      print("eeerrror-${e.toString()}");
      emit(PersonalChatListErrorState(e.toString()));
    }
  }

  Future<void> DMChatListm(String userWithUid, BuildContext context) async {
    dynamic DMChatList;
    try {
      emit(PersonalChatListLoadingState());
      DMChatList = await Repository().FirstTimeChat(context, userWithUid);
      if (DMChatList == "Something Went Wrong, Try After Some Time.") {
        emit(PersonalChatListErrorState("${DMChatList}"));
      } else {
        if (DMChatList.success == true) {
          emit(DMChatListLoadedState(DMChatList));
        } else {
          emit(PersonalChatListErrorState(DMChatList.message));
        }
      }
    } catch (e) {
      emit(PersonalChatListErrorState(DMChatList));
    }
  }

  Future<void> get_UsersChatByUsernameMethod(
      String searchUsername, String pageNumber, BuildContext context) async {
    try {
      emit(PersonalChatListLoadingState());
      getUsersChatByUsernameData = await Repository()
          .get_UsersChatByUsername(searchUsername, pageNumber, context);

      if (getUsersChatByUsernameData.success == true) {
        emit(GetUsersChatByUsernameLoaded(getUsersChatByUsernameData));
      } else {
        emit(PersonalChatListErrorState(getUsersChatByUsernameData.message));
      }
    } catch (e) {
      emit(PersonalChatListErrorState(e.toString()));
    }
  }

  Future<void> get_UsersChatByUsernamePagantion(
      String searchUsername, String pageNumber, BuildContext context) async {
    try {
      emit(PersonalChatListLoadingState());
      dynamic pagantiondata = await Repository()
          .get_UsersChatByUsername(searchUsername, pageNumber, context);

      if (pagantiondata.success == true) {
        /* searchHistoryDataAdd.object.content
            .addAll(searchHistoryDataAddInPagantion.object.content);
        searchHistoryDataAdd.object.pageable.pageNumber =
            searchHistoryDataAddInPagantion.object.pageable.pageNumber;
        searchHistoryDataAdd.object.totalElements =
            searchHistoryDataAddInPagantion.object.totalElements; */
        getUsersChatByUsernameData.object.content
            .addAll(pagantiondata.object.content);
        getUsersChatByUsernameData.object.pageable.pageNumber =
            pagantiondata.object.pageable.pageNumber;
        getUsersChatByUsernameData.object.totalElements =
            pagantiondata.object.totalElements;
        emit(GetUsersChatByUsernameLoaded(getUsersChatByUsernameData));
      } else {
        emit(PersonalChatListErrorState(getUsersChatByUsernameData.message));
      }
    } catch (e) {
      emit(PersonalChatListErrorState(e.toString()));
    }
  }

  Future<void> UserChatDelete(
      String userChatInboxUid, BuildContext context) async {
    try {
      emit(PersonalChatListLoadingState());
      getUsersChatByUsernameData =
          await Repository().DeleteUserDelete(userChatInboxUid, context);

      if (getUsersChatByUsernameData.success == true) {
        emit(UserChatDeleteLoaded(getUsersChatByUsernameData));
      } else {
        emit(PersonalChatListErrorState(getUsersChatByUsernameData.message));
      }
    } catch (e) {
      emit(PersonalChatListErrorState(e.toString()));
    }
  }

  Future<void> getAllNoticationsCountAPI(BuildContext context) async {
    dynamic acceptRejectInvitationModel;
    try {
      emit(PersonalChatListLoadingState());
      acceptRejectInvitationModel =
          await Repository().getAllNoticationsCountAPI(context);
      if (acceptRejectInvitationModel ==
          "Something Went Wrong, Try After Some Time.") {
        emit(PersonalChatListErrorState("${acceptRejectInvitationModel}"));
      } else {
        if (acceptRejectInvitationModel.success == true) {
          emit(GetNotificationCountLoadedState(acceptRejectInvitationModel));
        }
      }
    } catch (e) {
      emit(PersonalChatListErrorState(acceptRejectInvitationModel));
    }
  }

  Future<void> seetinonExpried(BuildContext context,
      {bool showAlert = false}) async {
    try {
      emit(PersonalChatListLoadingState());
      dynamic settionExperied =
          await Repository().logOutSettionexperied(context);
      print("checkDatWant--$settionExperied");
      // if (settionExperied == "Something Went Wrong, Try After Some Time.") {
      //     emit(GetGuestAllPostErrorState("${settionExperied}"));
      //   } else {
      if (settionExperied.success == true) {
        await setLOGOUT(context);
      } else {
        print("failed--check---${settionExperied}");
      }
      // }
    } catch (e) {
      print('errorstate-$e');
      // emit(GetGuestAllPostErrorState(e.toString()));
    }
  }

  Future<void> ChatOnline(BuildContext context, bool onlineStatus) async {
    dynamic acceptRejectInvitationModel;
    try {
      emit(PersonalChatListLoadingState());
      acceptRejectInvitationModel =
          await Repository().ChatOnline(context, onlineStatus);
      if (acceptRejectInvitationModel ==
          "Something Went Wrong, Try After Some Time.") {
        emit(PersonalChatListErrorState("${acceptRejectInvitationModel}"));
      } else {
        if (acceptRejectInvitationModel.success == true) {
          emit(OnlineChatStatusLoadedState(acceptRejectInvitationModel));
        }
      }
    } catch (e) {
      emit(PersonalChatListErrorState(acceptRejectInvitationModel));
    }
  }

  Future<void> forward_messages(BuildContext context,  Map<String, dynamic> params,) async {
    dynamic forwardMessages;
    try {
      emit(PersonalChatListLoadingState());
      forwardMessages =
          await Repository().forward_messages(context, params);
      if (forwardMessages == "Something Went Wrong, Try After Some Time.") {
        emit(PersonalChatListErrorState("${forwardMessages}"));
      } else {
        if (forwardMessages.success == true) {
          emit(ForwadMessageLoadedState(forwardMessages));
        }
      }
    } catch (e) {
      emit(PersonalChatListErrorState(forwardMessages));
    }
  }
}
