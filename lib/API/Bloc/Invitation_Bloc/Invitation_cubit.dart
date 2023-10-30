import 'package:pds/API/Model/acceptRejectInvitaionModel/acceptRejectInvitaion.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../Model/InvitationModel/Invitation_Model.dart';
import '../../Repo/repository.dart';
import 'Invitation_state.dart';

class InvitationCubit extends Cubit<InvitationState> {
  InvitationCubit() : super(InvitationInitialState()) {}
  Future<void> InvitationAPI(BuildContext context) async {
    dynamic PublicRModel;
    try {
      emit(InvitationLoadingState());
      PublicRModel = await Repository().InvitationModelAPI(context);
      if (PublicRModel.success == true) {
        emit(InvitationLoadedState(PublicRModel));
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
      if (acceptRejectInvitationModel.success == true) {
        emit(AcceptRejectInvitationModelLoadedState(
            acceptRejectInvitationModel));
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
      if (acceptRejectInvitationModel.success == true) {
        emit(RequestListLoadedState(acceptRejectInvitationModel));
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
      if (acceptRejectInvitationModel.success == true) {
        emit(accept_rejectLoadedState(acceptRejectInvitationModel));
      }
    } catch (e) {
      emit(InvitationErrorState(acceptRejectInvitationModel));
    }
  }
}
