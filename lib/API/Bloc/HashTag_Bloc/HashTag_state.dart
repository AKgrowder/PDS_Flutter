import 'package:pds/API/Model/HashTage_Model/HashTagView_model.dart';
import 'package:pds/API/Model/HashTage_Model/HashTag_model.dart';

abstract class HashTagState {}

class HashTagLoadingState extends HashTagState {}

class HashTagInitialState extends HashTagState {}

class HashTagLoadedState extends HashTagState {
  final HashtagModel HashTagData;
  HashTagLoadedState(this.HashTagData);
}
class HashTagViewDataLoadedState extends HashTagState {
  final HashtagViewDataModel HashTagViewData;
  HashTagViewDataLoadedState(this.HashTagViewData);
}

class HashTagErrorState extends HashTagState {
  final dynamic error;
  HashTagErrorState(this.error);
}
