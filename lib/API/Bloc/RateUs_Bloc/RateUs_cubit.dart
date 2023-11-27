import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pds/API/Bloc/RateUs_Bloc/RateUs_state.dart';
import 'package:pds/API/Model/RateUseModel/Rateuse_model.dart';
import 'package:pds/API/Repo/repository.dart';

class RateUsCubit extends Cubit<RateUSState> {
  RateUsCubit() : super(RateUSInitialState()) {}
  Future<void> RateUsApi(
      Map<String, dynamic> params, BuildContext context) async {
    dynamic logOutModel;
    try {
      emit(RateUSLoadingState());
      logOutModel = await Repository().RateUs(params, context);
      if (logOutModel == "Something Went Wrong, Try After Some Time.") {
        emit(RateUSErrorState("${logOutModel}"));
      } else {
      if (logOutModel.success == true) {
        emit(RateUSLoadedState(logOutModel));
      }}
    } catch (e) {
      emit(RateUSErrorState(logOutModel));
    }
  }
}
