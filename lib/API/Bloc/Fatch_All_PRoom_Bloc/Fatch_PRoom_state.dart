 
 

import '../../Model/FetchAllExpertsModel/FetchAllExperts_Model.dart';
import '../../Model/HomeScreenModel/PublicRoomModel.dart';

abstract class FetchAllPublicRoomState {}

class FetchAllPublicRoomLoadingState extends FetchAllPublicRoomState {}

class FetchAllPublicRoomInitialState extends FetchAllPublicRoomState {}

class FetchAllPublicRoomLoadedState extends FetchAllPublicRoomState {
  final PublicRoomModel PublicRoomData;
 FetchAllPublicRoomLoadedState(this.PublicRoomData);
}

class FetchAllExpertsLoadedState extends FetchAllPublicRoomState {
  final FetchAllExpertsModel FetchAllExpertsData;
 FetchAllExpertsLoadedState(this.FetchAllExpertsData);
}

class FetchAllPublicRoomErrorState extends FetchAllPublicRoomState {
  final String error;
  FetchAllPublicRoomErrorState(this.error);
}
