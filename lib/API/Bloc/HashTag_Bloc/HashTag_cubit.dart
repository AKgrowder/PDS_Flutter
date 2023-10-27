import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pds/API/Bloc/HashTag_Bloc/HashTag_state.dart';
import 'package:pds/API/Repo/repository.dart';

class HashTagCubit extends Cubit<HashTagState> {
  HashTagCubit() : super(HashTagInitialState()) {}
  Future<void> HashTagForYouAPI(BuildContext context) async {
    dynamic HashTagForYouModel;
    try {
      emit(HashTagLoadingState());
      HashTagForYouModel = await Repository().HashTagForYouAPI(context);
      if (HashTagForYouModel.success == true) {
        emit(HashTagLoadedState(HashTagForYouModel));
      }
    } catch (e) {
      // print('errorstate-$e');
      emit(HashTagErrorState(HashTagForYouModel));
    }
  }

  Future<void> HashTagViewDataAPI(
    BuildContext context,
    String hashTag,
  ) async {
    dynamic hashTagViewModel;
    try {
      emit(HashTagLoadingState());
      hashTagViewModel = await Repository().HashTagViewDataAPI(
        context,
        hashTag,
      );
      if (hashTagViewModel.success == true) {
        emit(HashTagViewDataLoadedState(hashTagViewModel));
        print(hashTagViewModel.object.posts);
      }
    } catch (e) {
      // print('errorstate-$e');
      emit(HashTagErrorState(hashTagViewModel));
    }
  }
}
