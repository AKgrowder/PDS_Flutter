

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pds/API/Repo/repository.dart';

import 'follwerState.dart';

class FollowerBlock extends Cubit<FolllwerBlockState> {
  FollowerBlock() : super(FollwertBlockInitialState()) {}
 Future<void> removeFollwerApi(
    BuildContext context,
    String userUid,
  ) async {
    dynamic getAllFollwerData;
    try {
      emit(FollwertBlockLoadingState());
      getAllFollwerData = await Repository().removeFollwerApi(
        context,
        userUid,
      );
      if (getAllFollwerData.success == true) {
        emit(RemoveLoddingState(getAllFollwerData));
      }
    } catch (e) {
      emit(FollwertErrroState(e.toString()));
    }
  }
}
