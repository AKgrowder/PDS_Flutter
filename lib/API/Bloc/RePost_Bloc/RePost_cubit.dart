import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pds/API/Bloc/RePost_Bloc/RePost_state.dart';
import 'package:pds/API/Repo/repository.dart';

class RePostCubit extends Cubit<RePostState> {
  RePostCubit() : super(RePostInitialState()) {}
  Future<void> UplodeImageAPIImane(BuildContext context, List<File> imageFile) async {
    dynamic addPostImageUploded;
    try {
      emit(RePostLoadingState());
      addPostImageUploded = await Repository().userProfile1(imageFile, context);
      if (addPostImageUploded.success == true) {
        emit(AddPostImaegState(addPostImageUploded));
      }
    } catch (e) {
      emit(RePostErrorState(addPostImageUploded));
    }
  }

    Future<void> UplodeImageAPI(
    BuildContext context,
    String? fileName,
    String? file,
  ) async {
    dynamic addPostImageUploded;
    try {
      emit(RePostLoadingState());
      addPostImageUploded = await Repository()
          .AddPostImageUploded(context, fileName ?? '', file ?? '');
      if (addPostImageUploded.success == true) {
        emit(AddPostImaegState(addPostImageUploded));
      }
    } catch (e) {
      emit(RePostErrorState(addPostImageUploded));
    }
  }
}
