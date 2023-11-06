import 'package:pds/API/Model/Add_PostModel/Add_PostModel.dart';
import 'package:pds/API/Model/Add_PostModel/Add_postModel_Image.dart';

abstract class RePostState {}

class RePostLoadingState extends RePostState {}

class RePostInitialState extends RePostState {}

class RePostLoadedState extends RePostState {
  final AddPost RePost;
  RePostLoadedState(this.RePost); 
}

class RePostErrorState extends RePostState {
  final dynamic error;
  RePostErrorState(this.error);
}
class AddPostImaegState extends RePostState {
 final ImageDataPost imageDataPost;
  AddPostImaegState(this.imageDataPost);
}