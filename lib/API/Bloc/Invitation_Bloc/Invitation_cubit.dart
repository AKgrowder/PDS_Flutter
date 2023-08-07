import 'package:archit_s_application1/API/Model/acceptRejectInvitaionModel/acceptRejectInvitaion.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../Model/InvitationModel/Invitation_Model.dart';
import '../../Repo/repository.dart';
import 'Invitation_state.dart';

class InvitationCubit extends Cubit<InvitationState> {
  InvitationCubit() : super(InvitationInitialState()) {}
  Future<void> InvitationAPI() async {
    try {
      emit(InvitationLoadingState());
      InvitationModel PublicRModel = await Repository().InvitationModelAPI();
      if (PublicRModel.success == true) {
        emit(InvitationLoadedState(PublicRModel));
      } else {
        // emit(InvitationErrorState('No Data Found!'));
        emit(InvitationErrorState('${PublicRModel.message}'));
      }
    } catch (e) {
      print('errorstate-$e');
      emit(InvitationErrorState(e.toString()));
    }
  }

  Future<void> GetRoomInvitations(bool status, String roomLink) async {
    try {
      emit(InvitationLoadingState());
      AcceptRejectInvitationModel acceptRejectInvitationModel =
          await Repository().acceptRejectInvitationAPI(status, roomLink);
      if (acceptRejectInvitationModel.success == true) {
        emit(AcceptRejectInvitationModelLoadedState(
            acceptRejectInvitationModel));
      } else {
        // emit(InvitationErrorState('No Data Found!'));
        emit(InvitationErrorState('${acceptRejectInvitationModel.message}'));
      }
    } catch (e) {
      emit(InvitationErrorState(e.toString()));
    }
  }
}
