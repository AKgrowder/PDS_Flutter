import 'package:pds/API/Model/ViewStoryModel/ViewStory_Model.dart';

abstract class ViewStoryState {}

class ViewStoryLoadingState extends ViewStoryState {}

class ViewStoryInitialState extends ViewStoryState {}

class ViewStoryLoadedState extends ViewStoryState {
  final ViewStoryModel ViewStoryModelData;
  ViewStoryLoadedState(this.ViewStoryModelData);
}

class ViewStoryErrorState extends ViewStoryState {
  final dynamic error;
  ViewStoryErrorState(this.error);
}
