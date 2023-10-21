
import 'package:pds/API/Model/CreateStory_Model/all_stories.dart';

import '../../Model/Add_PostModel/Add_postModel_Image.dart';
import '../../Model/CreateStory_Model/CreateStory_model.dart';

abstract class CreateStoryState {}

class CreateStoryLoadingState extends CreateStoryState {}

class CreateStoryInitialState extends CreateStoryState {}



class CreateStoryErrorState extends CreateStoryState {
  final dynamic error;
  CreateStoryErrorState(this.error);
}

class AddPostImaegState extends CreateStoryState {
 final ImageDataPost imageDataPost;
  AddPostImaegState(this.imageDataPost);
}



