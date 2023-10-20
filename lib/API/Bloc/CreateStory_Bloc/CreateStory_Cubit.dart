import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pds/API/Bloc/CreateStory_Bloc/CreateStory_state.dart';
import 'package:pds/API/Repo/repository.dart';

class CreateStoryCubit extends Cubit<CreateStoryState> {
  CreateStoryCubit() : super(CreateStoryInitialState()) {}
  Future<void> CreateStoryAPI(
      Map<String, dynamic> params, BuildContext context) async {
    dynamic createForm;
    try {
      emit(CreateStoryLoadingState());
      createForm = await Repository().CreateStory(params, context);
      if (createForm.success == true) {
        emit(CreateStoryLoadedState(createForm));
      }
    } catch (e) {
      emit(CreateStoryErrorState(createForm));
    }
  }

  Future<void> UplodeImageAPI(
    BuildContext context,
    String? fileName,
    String? file,
  ) async {
    dynamic addPostImageUploded;
    try {
      emit(CreateStoryLoadingState());
      addPostImageUploded = await Repository()
          .AddPostImageUploded(context, fileName ?? '', file ?? '');
      if (addPostImageUploded.success == true) {
        emit(AddPostImaegState(addPostImageUploded));
      }
    } catch (e) {
      emit(CreateStoryErrorState(addPostImageUploded));
    }
  }

  Future<void> GetAllStoryAPI(BuildContext context) async {
    dynamic getAllStoryModel;
    try {
      emit(CreateStoryLoadingState());
      getAllStoryModel = await Repository().GetAllStory(context);
      if (getAllStoryModel.success == true) {
        emit(GetAllStoryLoadedState(getAllStoryModel));
      }
    } catch (e) {
      emit(CreateStoryErrorState(getAllStoryModel));
    }
  }
}
