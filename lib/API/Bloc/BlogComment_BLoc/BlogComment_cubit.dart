import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pds/API/Bloc/BlogComment_BLoc/BlogComment_state.dart';
import 'package:pds/API/Model/BlogComment_Model/BlogComment_model.dart';
import 'package:pds/API/Repo/repository.dart';

class BlogcommentCubit extends Cubit<BlogCommentState> {
  BlogcommentCubit() : super(BlogCommentInitialState()) {}
  Future<void> BlogcommentAPI(BuildContext context, String blogID) async {
    dynamic commentdata;
    try {
      emit(BlogCommentLoadingState());
      commentdata = await Repository().Blogcomment(context, blogID);
      BlogCommentModel commentModel1 = BlogCommentModel.fromJson(commentdata);
      print("commetData-${commentModel1.success}");
      if (commentModel1.success == true) {
        emit(BlogCommentLoadedState(commentModel1));
      } else {
        print("else working-$commentdata");
        emit(BlogCommentLoadedState1(commentdata));
      }
    } catch (e) {
      emit(BlogCommentErrorState(commentdata));
    }
  }

  Future<void> AddBloCommentApi(
    BuildContext context,
    Map<String, dynamic> params,
  ) async {
    dynamic addnewcommentdata;
    try {
      addnewcommentdata = await Repository().BlogNewcomment(context, params);
      print("addPostData-->$addnewcommentdata");
      if (addnewcommentdata == "Something Went Wrong, Try After Some Time.") {
        emit(BlogCommentErrorState("${addnewcommentdata}"));
      } else {
        if (addnewcommentdata['success'] == true) {
          emit(BlognewCommentLoadedState(addnewcommentdata));
        } else {
          emit(BlognewCommentLoadedState(addnewcommentdata));
        }
      }
    } catch (e) {
      print("fdhfsdfhsdfh");
      emit(BlogCommentErrorState(addnewcommentdata));
    }
  }

  Future<void> DeletecommentAPI(String commentuid, BuildContext context) async {
    dynamic Deletecomment;
    try {
      emit(BlogCommentLoadingState());
      Deletecomment = await Repository().DeleteBlogcomment(commentuid, context);
      if (Deletecomment == "Something Went Wrong, Try After Some Time.") {
        emit(BlogCommentErrorState("${Deletecomment}"));
      } else {
        if (Deletecomment.success == true) {
          emit(DeleteBlogcommentLoadedState(Deletecomment));
        }
      }
    } catch (e) {
      emit(BlogCommentErrorState(e.toString()));
    }
  }
}
