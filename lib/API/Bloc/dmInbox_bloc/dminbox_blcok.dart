import 'dart:io';

import 'package:pds/API/Bloc/dmInbox_bloc/dmMessageState.dart';
import 'package:pds/API/Repo/repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DmInboxCubit extends Cubit<getInboxState> {
  DmInboxCubit() : super(getInboxInitialState()) {}
  Future<void> DMChatListApiMethod(String userChatInboxUid, int pageNumber,
      int numberOfRecordsm, BuildContext context) async {
    dynamic DmInbox;
    try {
      emit(getInboxLoadingState());
      DmInbox = await Repository().DMChatListApi(
          context, userChatInboxUid, pageNumber, numberOfRecordsm);

      if (DmInbox.success == true) {
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
    Map<String,dynamic> sendImageInUserChatImage;
    try {
      emit(getInboxLoadingState());
      sendImageInUserChatImage = await Repository()
          .chatImage1(inboxChatUserUid, userUid, imageFile, context);
        print("sdfjdsjhfsdhf=${sendImageInUserChatImage}");
      if (sendImageInUserChatImage['success']== true) {
        print("this condison is workig");
        emit(SendImageInUserChatState(sendImageInUserChatImage));
      }
    } catch (e) {
      print('eeee-$e');
      emit(getInboxErrorState(e.toString()));
    }
  }
}
