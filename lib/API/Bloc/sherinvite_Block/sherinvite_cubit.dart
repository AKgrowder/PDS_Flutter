import 'package:archit_s_application1/API/Model/sherInviteModel/sherinviteModel.dart';
import 'package:archit_s_application1/API/Repo/repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'sherinvite_state.dart';

class SherInviteCubit extends Cubit<SherInviteState> {
  SherInviteCubit() : super(SherInviteInitialState()) {}
  Future<void> sherInviteApi(
      String userRoomId, String email, BuildContext context) async {
    dynamic sherInvite;
    try {
      emit(SherInviteLoadingState());
      sherInvite = await Repository().sherInvite(userRoomId, email, context);
      if (sherInvite.success == true) {
        emit(SherInviteLoadedState(sherInvite));
      }
    } catch (e) {
      emit(SherInviteErrorState(sherInvite));
    }
  }
}


// class SherInviteLoadedState extends GetAllPrivateRoomState {
//   final SherInvite sherInvite;
//   SherInviteLoadedState(this.sherInvite);
// }
