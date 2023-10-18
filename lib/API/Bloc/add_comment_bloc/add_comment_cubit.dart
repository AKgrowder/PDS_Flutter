import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pds/API/Bloc/add_comment_bloc/add_comment_state.dart';
import 'package:pds/API/Repo/repository.dart';

class AddcommentCubit extends Cubit<AddCommentState> {
  AddcommentCubit() : super(AddCommentInitialState()) {}
  Future<void> Addcomment(
        BuildContext context,String PostUID) async {
    dynamic commentdata;
    try {
      emit(AddCommentLoadingState());
      commentdata = await Repository().Addcomment(context,PostUID);
      if (commentdata.success == true) {
        emit(AddCommentLoadedState(commentdata));
      }
    } catch (e) { 
      emit(AddCommentErrorState(commentdata));
    }
  }
}
