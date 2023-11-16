 

import 'package:pds/API/Model/OpenSaveImagepostModel/OpenSaveImagepost_Model.dart';
import 'package:pds/API/Model/like_Post_Model/like_Post_Model.dart';

abstract class OpenSaveState {}

class OpenSaveLoadingState extends OpenSaveState {}

class OpenSaveInitialState extends OpenSaveState {}

class OpenSaveLoadedState extends OpenSaveState {
  final OpenSaveImagepostModel OpenSaveData;
  OpenSaveLoadedState(this.OpenSaveData);
}
 
class PostLikeLoadedState extends OpenSaveState {
  final LikePost likePost;
  PostLikeLoadedState(this.likePost);
}


class OpenSaveErrorState extends OpenSaveState {
  final dynamic error;
  OpenSaveErrorState(this.error);
}
 