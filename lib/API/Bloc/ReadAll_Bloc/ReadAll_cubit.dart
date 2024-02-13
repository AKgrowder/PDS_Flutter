import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pds/API/Bloc/ReadAll_Bloc/ReadAll_state.dart';
import 'package:pds/API/Repo/repository.dart';

class ReadAllMSGCubit extends Cubit<ReadAllMSGState> {
  ReadAllMSGCubit() : super(ReadAllMSGInitialState()) {}
  Future<void> ReadAllMassagesAPI(BuildContext context) async {
    dynamic readAllMsg;
    try {
      emit(ReadAllMSGLoadingState());
      readAllMsg = await Repository().ReadAllMassages(context);
      if (readAllMsg == "Something Went Wrong, Try After Some Time.") {
        emit(ReadAllMSGErrorState("${readAllMsg}"));
      } else {
      if (readAllMsg.success == true) {
        emit(ReadAllMSGLoadedState(readAllMsg));
      }}
    } catch (e) {
      emit(ReadAllMSGErrorState(readAllMsg));
    }
  }
}