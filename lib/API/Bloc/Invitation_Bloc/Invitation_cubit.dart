import 'package:archit_s_application1/API/Model/acceptRejectInvitaionModel/acceptRejectInvitaion.dart';
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
}
