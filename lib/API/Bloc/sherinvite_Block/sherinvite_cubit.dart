import 'package:archit_s_application1/API/Model/sherInviteModel/sherinviteModel.dart';
import 'package:archit_s_application1/API/Repo/repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'sherinvite_state.dart';

class SherInviteCubit extends Cubit<SherInviteState> {
  SherInviteCubit() : super(SherInviteInitialState()) {}
  Future<void> sherInviteApi(
    String userRoomId,
    String email,
  ) async {
    try {
      emit(SherInviteLoadingState());
      SherInvite sherInvite = await Repository().sherInvite(userRoomId, email);
      if (sherInvite.success == true) {
        emit(SherInviteLoadedState(sherInvite));
      } else {
        emit(SherInviteErrorState(sherInvite.message.toString()));
      }
    } catch (e) {
      emit(SherInviteErrorState(e.toString()));
    }
  }
}


// class SherInviteLoadedState extends GetAllPrivateRoomState {
//   final SherInvite sherInvite;
//   SherInviteLoadedState(this.sherInvite);
// }
