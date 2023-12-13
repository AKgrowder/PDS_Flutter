import 'package:pds/API/Model/storyModel/stroyModel.dart';

abstract class CreateStoryState {}

class CreateStoryLoadingState extends CreateStoryState {}

class CreateStoryInitialState extends CreateStoryState {}

class CreateStoryErrorState extends CreateStoryState {
  final dynamic error;
  CreateStoryErrorState(this.error);
}

class AddPostImaegState extends CreateStoryState {
  final ImageDataPostOne imageDataPost;
  AddPostImaegState(this.imageDataPost);
}
