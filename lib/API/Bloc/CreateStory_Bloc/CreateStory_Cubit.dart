import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pds/API/Bloc/CreateStory_Bloc/CreateStory_state.dart';
import 'package:pds/API/Repo/repository.dart';

class CreateStoryCubit extends Cubit<CreateStoryState> {
  CreateStoryCubit() : super(CreateStoryInitialState()) {}

  Future<void> UplodeImageAPI(
    BuildContext context,
    String? fileName,
    String? file,
  ) async {
    dynamic addPostImageUploded;
    try {
      emit(CreateStoryLoadingState());
      addPostImageUploded = await Repository()
          .AddPostImageUploded1(context, fileName ?? '', file ?? '');
  
      if (addPostImageUploded.success == true) {
              print("dvfsdvfdfg-$addPostImageUploded");  
        emit(AddPostImaegState(addPostImageUploded));
      }
    } catch (e) {
      print("erorro-$e");
      emit(CreateStoryErrorState(addPostImageUploded));
    }
  }
}
