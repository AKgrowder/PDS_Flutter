import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pds/API/Bloc/GuestAllPost_Bloc/GuestAllPost_state.dart';
import 'package:pds/API/Repo/repository.dart';

class GetGuestAllPostCubit extends Cubit<GetGuestAllPostState> {
  GetGuestAllPostCubit() : super(GetGuestAllPostInitialState()) {}
  Future<void> GetGuestAllPostAPI(BuildContext context) async {
    dynamic PublicRModel;
    try {
      emit(GetGuestAllPostLoadingState());
      PublicRModel = await Repository().GetGuestAllPost(context);
      if (PublicRModel.success == true) {
        emit(GetGuestAllPostLoadedState(PublicRModel));
      }
    } catch (e) {
      // print('errorstate-$e');
      emit(GetGuestAllPostErrorState(PublicRModel));
    }
  }

  Future<void> GetUserAllPostAPI(BuildContext context) async {
    dynamic PublicRModel;
    try {
      emit(GetGuestAllPostLoadingState());
      PublicRModel = await Repository().GetUserAllPost(context);
      if (PublicRModel.success == true) {
        emit(GetGuestAllPostLoadedState(PublicRModel));
      }
    } catch (e) {
      // print('errorstate-$e');
      emit(GetGuestAllPostErrorState(PublicRModel));
    }
  }
}
