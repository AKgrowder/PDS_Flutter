
import '../../Model/Add_PostModel/Add_postModel_Image.dart';
import '../../Model/CreateStory_Model/CreateStory_model.dart';

abstract class CreateStoryState {}

class CreateStoryLoadingState extends CreateStoryState {}

class CreateStoryInitialState extends CreateStoryState {}

class CreateStoryLoadedState extends CreateStoryState {
  final CreateStoryModel createForm;
  CreateStoryLoadedState(this.createForm);
}

class CreateStoryErrorState extends CreateStoryState {
  final dynamic error;
  CreateStoryErrorState(this.error);
}

class AddPostImaegState extends CreateStoryState {
 final ImageDataPost imageDataPost;
  AddPostImaegState(this.imageDataPost);
}

 
