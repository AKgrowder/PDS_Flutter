 
import 'package:pds/API/Bloc/viewStory_Bloc/viewStory_state.dart';
import 'package:pds/API/Repo/repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ViewStoryCubit extends Cubit<ViewStoryState> {
  ViewStoryCubit() : super(ViewStoryInitialState()) {}
  Future<void> ViewStory(BuildContext context,String userUid,
    String storyUid,) async {
    dynamic ViewStoryModel;
    try {
      emit(ViewStoryLoadingState());
      ViewStoryModel = await Repository().ViewStory(context,userUid,storyUid);
      if (ViewStoryModel.success == true) {
        emit(ViewStoryLoadedState(ViewStoryModel));
      }
    } catch (e) {
      emit(ViewStoryErrorState(ViewStoryModel));
    }
  }

   
}
