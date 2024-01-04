import 'package:pds/API/ApiService/ApiService.dart';
import 'package:pds/API/Model/acceptRejectInvitaionModel/acceptRejectInvitaion.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../Model/InvitationModel/Invitation_Model.dart';
import '../../Repo/repository.dart';
import 'Invitation_state.dart';

class InvitationCubit extends Cubit<InvitationState> {
  InvitationCubit() : super(InvitationInitialState()) {}
  Future<void> seetinonExpried(BuildContext context,
      {bool showAlert = false}) async {
    try {
      emit(InvitationLoadingState());
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

  Future<void> InvitationAPI(BuildContext context) async {
    dynamic PublicRModel;
    try {
      emit(InvitationLoadingState());
      PublicRModel = await Repository().InvitationModelAPI(context);
      if (PublicRModel == "Something Went Wrong, Try After Some Time.") {
        emit(InvitationErrorState("${PublicRModel}"));
      } else {
        if (PublicRModel.success == true) {
          emit(InvitationLoadedState(PublicRModel));
        }
      }
    } catch (e) {
      // print('errorstate-$e');
      emit(InvitationErrorState(PublicRModel));
    }
  }

  Future<void> GetRoomInvitations(
      bool status, String roomLink, BuildContext context) async {
    dynamic acceptRejectInvitationModel;
    try {
      emit(InvitationLoadingState());
      acceptRejectInvitationModel = await Repository()
          .acceptRejectInvitationAPI(status, roomLink, context);
      if (acceptRejectInvitationModel ==
          "Something Went Wrong, Try After Some Time.") {
        emit(InvitationErrorState("${acceptRejectInvitationModel}"));
      } else {
        if (acceptRejectInvitationModel.success == true) {
          emit(AcceptRejectInvitationModelLoadedState(
              acceptRejectInvitationModel));
        }
      }
    } catch (e) {
      emit(InvitationErrorState(acceptRejectInvitationModel));
    }
  }

  Future<void> RequestListAPI(BuildContext context) async {
    dynamic acceptRejectInvitationModel;
    try {
      emit(InvitationLoadingState());
      acceptRejectInvitationModel = await Repository().RequestListAPI(context);
      if (acceptRejectInvitationModel ==
          "Something Went Wrong, Try After Some Time.") {
        emit(InvitationErrorState("${acceptRejectInvitationModel}"));
      } else {
        if (acceptRejectInvitationModel.success == true) {
          emit(RequestListLoadedState(acceptRejectInvitationModel));
        }
      }
    } catch (e) {
      emit(InvitationErrorState(acceptRejectInvitationModel));
    }
  }

  Future<void> accept_rejectAPI(
      BuildContext context, bool isAccepted, String followUid) async {
    dynamic acceptRejectInvitationModel;
    try {
      emit(InvitationLoadingState());
      acceptRejectInvitationModel =
          await Repository().accept_rejectAPI(context, isAccepted, followUid);
      if (acceptRejectInvitationModel ==
          "Something Went Wrong, Try After Some Time.") {
        emit(InvitationErrorState("${acceptRejectInvitationModel}"));
      } else {
        if (acceptRejectInvitationModel.success == true) {
          emit(accept_rejectLoadedState(acceptRejectInvitationModel));
        }
      }
    } catch (e) {
      emit(InvitationErrorState(acceptRejectInvitationModel));
    }
  }

  Future<void> AllNotification(BuildContext context) async {
    dynamic acceptRejectInvitationModel;
    try {
      emit(InvitationLoadingState());
      acceptRejectInvitationModel =
          await Repository().AllNotificationAPI(context);
      if (acceptRejectInvitationModel ==
          "Something Went Wrong, Try After Some Time.") {
        emit(InvitationErrorState("${acceptRejectInvitationModel}"));
      } else {
        if (acceptRejectInvitationModel.success == true) {
          emit(GetAllNotificationLoadedState(acceptRejectInvitationModel));
        }
      }
    } catch (e) {
      emit(InvitationErrorState(acceptRejectInvitationModel));
    }
  }

  Future<void> SeenNotification(
      BuildContext context, String notificationUid) async {
    dynamic acceptRejectInvitationModel;
    try {
      emit(InvitationLoadingState());
      acceptRejectInvitationModel =
          await Repository().SeenNotificationAPI(context, notificationUid);
      if (acceptRejectInvitationModel ==
          "Something Went Wrong, Try After Some Time.") {
        emit(InvitationErrorState("${acceptRejectInvitationModel}"));
      } else {
        if (acceptRejectInvitationModel.success == true) {
          emit(SeenNotificationLoadedState(acceptRejectInvitationModel));
        }
      }
    } catch (e) {
      emit(InvitationErrorState(acceptRejectInvitationModel));
    }
  } 

  Future<void> getAllNoticationsCountAPI(BuildContext context) async {
    dynamic acceptRejectInvitationModel;
    try {
      emit(InvitationLoadingState());
      acceptRejectInvitationModel =
          await Repository().getAllNoticationsCountAPI(context);
      if (acceptRejectInvitationModel ==
          "Something Went Wrong, Try After Some Time.") {
        emit(InvitationErrorState("${acceptRejectInvitationModel}"));
      } else {
        if (acceptRejectInvitationModel.success == true) {
          emit(GetNotificationCountLoadedState(acceptRejectInvitationModel));
        }
      }
    } catch (e) {
      emit(InvitationErrorState(acceptRejectInvitationModel));
    }
  }
}
