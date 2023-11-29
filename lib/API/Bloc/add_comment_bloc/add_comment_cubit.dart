import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pds/API/Bloc/add_comment_bloc/add_comment_state.dart';
import 'package:pds/API/Repo/repository.dart';

class AddcommentCubit extends Cubit<AddCommentState> {
  AddcommentCubit() : super(AddCommentInitialState()) {}
  Future<void> Addcomment(BuildContext context, String PostUID) async {
    dynamic commentdata;
    try {
      emit(AddCommentLoadingState());
      commentdata = await Repository().Addcomment(context, PostUID);
      if (commentdata == "Something Went Wrong, Try After Some Time.") {
        emit(AddCommentErrorState("${commentdata}"));
      } else {
        if (commentdata.success == true) {
          emit(AddCommentLoadedState(commentdata));
        }
      }
    } catch (e) {
      emit(AddCommentErrorState(commentdata));
    }
  }

//------------------------------------------------------------------
  Future<void> AddPostApiCalling(
    BuildContext context,
    Map<String, dynamic> params,
  ) async {
    dynamic addnewcommentdata;
    try {
      addnewcommentdata = await Repository().AddNewcomment(context, params);
      print("addPostData-->$addnewcommentdata");
      if (addnewcommentdata == "Something Went Wrong, Try After Some Time.") {
        emit(AddCommentErrorState("${addnewcommentdata}"));
      } else {
        if (addnewcommentdata['success'] == true) {
          emit(AddnewCommentLoadedState(addnewcommentdata));
        } else {
          emit(AddnewCommentLoadedState(addnewcommentdata));
        }
      }
    } catch (e) {
      print("fdhfsdfhsdfh");
      emit(AddCommentErrorState(addnewcommentdata));
    }
  }

  Future<void> Deletecomment(String commentuid, BuildContext context) async {
    dynamic Deletecomment;
    try {
      emit(AddCommentLoadingState());
      Deletecomment = await Repository().Deletecomment(commentuid, context);
      if (Deletecomment == "Something Went Wrong, Try After Some Time.") {
        emit(AddCommentErrorState("${Deletecomment}"));
      } else {
        if (Deletecomment.success == true) {
          emit(DeletecommentLoadedState(Deletecomment));
        }
      }
    } catch (e) {
      emit(AddCommentErrorState(e.toString()));
    }
  }
}
