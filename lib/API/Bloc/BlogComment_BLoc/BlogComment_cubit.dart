import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pds/API/Bloc/BlogComment_BLoc/BlogComment_state.dart';
import 'package:pds/API/Repo/repository.dart';

class BlogcommentCubit extends Cubit<BlogCommentState> {
  BlogcommentCubit() : super(BlogCommentInitialState()) {}
  Future<void> BlogcommentAPI(BuildContext context, String blogID) async {
    dynamic commentdata;
    try {
      emit(BlogCommentLoadingState());
      commentdata = await Repository().Blogcomment(context, blogID);

      if (commentdata == "Something Went Wrong, Try After Some Time.") {
        emit(BlogCommentErrorState("${commentdata}"));
      } else {
        if (commentdata.success == true) {
          emit(BlogCommentLoadedState(commentdata));
        }
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

  Future<void> DeletecommentAPI(
      String commentuid, String loginuser, BuildContext context) async {
    dynamic Deletecomment;
    try {
      emit(BlogCommentLoadingState());
      Deletecomment =
          await Repository().DeleteBlogcomment(commentuid, loginuser, context);
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

  Future<void> BlogLikeList(
      BuildContext context, String blogID, String uuId) async {
    dynamic likeListData;
    try {
      emit(BlogCommentLoadingState());
      likeListData = await Repository().BlogLikeList(context, blogID, uuId);

      if (likeListData == "Something Went Wrong, Try After Some Time.") {
        emit(BlogCommentErrorState("${likeListData}"));
      } else {
        if (likeListData.success == true) {
          emit(BlogLikelistLoadedState(likeListData));
        }
      }
    } catch (e) {
      emit(BlogCommentErrorState(likeListData));
    }
  }

  Future<void> followWIngMethod(String? followedToUid, BuildContext context,
      {bool showAlert = false}) async {
    dynamic likepost;
    try {
      // showAlert == true ? emit(GetGuestAllPostLoadingState()) : SizedBox();
      likepost = await Repository().folliwingMethod(followedToUid, context);
      if (likepost == "Something Went Wrong, Try After Some Time.") {
        emit(BlogCommentErrorState("${likepost}"));
      } else {
        if (likepost.success == true) {
          emit(PostLikeBlogLoadedState(likepost));
        }
      }
    } catch (e) {
      // print('errorstate-$e');
      emit(BlogCommentErrorState(likepost));
    }
  }

  Future<void> UserTagAPI(BuildContext context, String? name) async {
    dynamic userTagData;
    try {
      emit(BlogCommentLoadingState());
      userTagData = await Repository().UserTag(context, name);
      print("userTagDataaaaaaaaaaaa-->${userTagData}");
      if (userTagData == "Something Went Wrong, Try After Some Time.") {
        emit(BlogCommentErrorState("${userTagData}"));
      } else {
        if (userTagData.success == true) {
          emit(UserTagBlogLoadedState(userTagData));
        }
      }
    } catch (e) {
      emit(BlogCommentErrorState(userTagData));
    }
  }
}
