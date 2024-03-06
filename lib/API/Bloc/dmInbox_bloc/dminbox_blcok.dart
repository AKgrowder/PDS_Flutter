import 'dart:io';

import 'package:pds/API/ApiService/ApiService.dart';
import 'package:pds/API/Bloc/dmInbox_bloc/dmMessageState.dart';
import 'package:pds/API/Repo/repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DmInboxCubit extends Cubit<getInboxState> {
  DmInboxCubit() : super(getInboxInitialState()) {}
  dynamic getAllInboxImage;
  dynamic DmInbox;

  Future<void> DMChatListApiMethod(
      String userChatInboxUid, int pageNumber, BuildContext context) async {
    try {
      emit(getInboxLoadingState());
      DmInbox = await Repository().DMChatListApi(
        context,
        userChatInboxUid,
        pageNumber,
      );

      if (DmInbox.success == true) {
        emit(getInboxLoadedState(DmInbox));
      }
    } catch (e) {
      emit(getInboxErrorState(e.toString()));
    }
  }

  Future<void> DMChatListApiPagantion(
      String userChatInboxUid, int pageNumber, BuildContext context) async {
    dynamic DmInboxPagnationWiget;
    try {
      emit(getInboxLoadingState());
      DmInboxPagnationWiget = await Repository()
          .DMChatListApi(context, userChatInboxUid, pageNumber);
      List a = [];
      a.reversed;

      if (DmInboxPagnationWiget.success == true) {
        // DmInbox.object.content.insert(0, DmInboxPagnationWiget.object.content);
        // addAll(DmInboxPagnationWiget.object.content);

        // DmInbox.object.content.addAll(DmInboxPagnationWiget.object.content);

        DmInbox.object.content.insertAll(
            0, DmInboxPagnationWiget.object.content.reversed.toList());
        DmInbox.object.pageable.pageNumber =
            DmInboxPagnationWiget.object.pageable.pageNumber;
        DmInbox.object.totalElements =
            DmInboxPagnationWiget.object.totalElements;
        emit(getInboxLoadedState(DmInbox));
      }
    } catch (e) {
      emit(getInboxErrorState(e.toString()));
    }
  }

  Future<void> UplodeImageAPI(BuildContext context, File imageFile) async {
    dynamic addPostImageUploded;
    try {
      emit(getInboxLoadingState());
      addPostImageUploded =
          await Repository().userProfileprofileCover(imageFile, context);

      if (addPostImageUploded.success == true) {
        emit(AddPostImaegState(addPostImageUploded));
      }
    } catch (e) {
      emit(getInboxErrorState(e.toString()));
    }
  }

  Future<void> send_image_in_user_chat(BuildContext context,
      String inboxChatUserUid, String userUid, File imageFile) async {
    Map<String, dynamic> sendImageInUserChatImage;
    try {
      emit(getInboxLoadingState());
      sendImageInUserChatImage = await Repository()
          .chatImage1(inboxChatUserUid, userUid, imageFile, context);
      print("sdfjdsjhfsdhf=${sendImageInUserChatImage}");
      if (sendImageInUserChatImage['success'] == true) {
        print("this condison is workig");
        emit(SendImageInUserChatState(sendImageInUserChatImage));
      }
    } catch (e) {
      print('eeee-$e');
      emit(getInboxErrorState(e.toString()));
    }
  }

  Future<void> seetinonExpried(BuildContext context,
      {bool showAlert = false}) async {
    try {
      emit(getInboxLoadingState());
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

  Future<void> GetAllInboxImagesApi(
      BuildContext context, String userChatInboxUid, String pageNumber) async {
    try {
      emit(getInboxLoadingState());
      getAllInboxImage = await Repository()
          .get_all_inbox_images(context, userChatInboxUid, pageNumber);

      if (getAllInboxImage.success == true) {
        print("this condison is workig");
        emit(GetAllInboxImagesState(getAllInboxImage));
      }
    } catch (e) {
      print('eeee-$e');
      emit(getInboxErrorState(e.toString()));
    }
  }

  Future<void> GetAllInboxImagesPagantionApi(
      BuildContext context, String userChatInboxUid, String pageNumber) async {
    dynamic GetAllInboxImagesPagantionApi;
    try {
      emit(getInboxLoadingState());
      GetAllInboxImagesPagantionApi = await Repository()
          .get_all_inbox_images(context, userChatInboxUid, pageNumber);

      if (GetAllInboxImagesPagantionApi.success == true) {
        getAllInboxImage.object.content
            .addAll(GetAllInboxImagesPagantionApi.object.content);
        getAllInboxImage.object.pageable.pageNumber =
            GetAllInboxImagesPagantionApi.object.pageable.pageNumber;
        getAllInboxImage.object.totalElements =
            GetAllInboxImagesPagantionApi.object.totalElements;

        emit(GetAllInboxImagesState(getAllInboxImage));
      }
    } catch (e) {
      print('eeee-$e');
      emit(getInboxErrorState(e.toString()));
    }
  }

  Future<void> SeenMessage(BuildContext context, String inboxUid) async {
    dynamic SeenMessgaeModelData;
    try {
      emit(getInboxLoadingState());
      SeenMessgaeModelData = await Repository().SeenMessage(context, inboxUid);
      if (SeenMessgaeModelData ==
          "Something Went Wrong, Try After Some Time.") {
        emit(getInboxErrorState("${SeenMessgaeModelData}"));
      } else {
        if (SeenMessgaeModelData.success == true) {
          emit(SeenAllMessageLoadedState(SeenMessgaeModelData));

          print(SeenMessgaeModelData.message);
        }
      }
    } catch (e) {
      print('LoginScreen-${e.toString()}');
      emit(getInboxErrorState(SeenMessgaeModelData));
    }
  }

  Future<void> LiveStatus(BuildContext context, String inboxUid) async {
    dynamic SeenMessgaeModelData;
    try {
      emit(getInboxLoadingState());
      SeenMessgaeModelData = await Repository().LiveStatus(context, inboxUid);
      if (SeenMessgaeModelData ==
          "Something Went Wrong, Try After Some Time.") {
        emit(getInboxErrorState("${SeenMessgaeModelData}"));
      } else {
        if (SeenMessgaeModelData.success == true) {
          emit(LiveStatusLoadedState(SeenMessgaeModelData));
          print("LiveStatusModelDataLiveStatusModelData");
          print(SeenMessgaeModelData.message);
        }
      }
    } catch (e) {
      print('LoginScreen-${e.toString()}');
      emit(getInboxErrorState(SeenMessgaeModelData));
    }
  }

  Future<void> getAllNoticationsCountAPI(BuildContext context) async {
    dynamic acceptRejectInvitationModel;
    try {
      emit(getInboxLoadingState());
      acceptRejectInvitationModel =
          await Repository().getAllNoticationsCountAPI(context);
      if (acceptRejectInvitationModel ==
          "Something Went Wrong, Try After Some Time.") {
        emit(getInboxErrorState("${acceptRejectInvitationModel}"));
      } else {
        if (acceptRejectInvitationModel.success == true) {
          emit(GetNotificationCountLoadedState(acceptRejectInvitationModel));
        }
      }
    } catch (e) {
      emit(getInboxErrorState(acceptRejectInvitationModel));
    }
  }

  Future<void> get_all_story(BuildContext context,
      {bool showAlert = false}) async {
    dynamic getAllStory;
    try {
      emit(getInboxLoadingState());
      getAllStory = await Repository().GetAllStory(context);
      if (getAllStory == "Something Went Wrong, Try After Some Time.") {
        emit(getInboxErrorState("${getAllStory}"));
      } else {
        if (getAllStory.success == true) {
          emit(GetAllStoryLoadedState(getAllStory));
        }
      }
    } catch (e) {
      print('errorstate-$e');
      emit(getInboxErrorState(e));
    }
  }
}
