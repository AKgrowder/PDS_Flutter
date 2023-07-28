 
 

import '../../Model/HomeScreenModel/PublicRoomModel.dart';

abstract class FetchAllPublicRoomState {}

class FetchAllPublicRoomLoadingState extends FetchAllPublicRoomState {}

class FetchAllPublicRoomInitialState extends FetchAllPublicRoomState {}

class FetchAllPublicRoomLoadedState extends FetchAllPublicRoomState {
  final PublicRoomModel PublicRoomData;
 FetchAllPublicRoomLoadedState(this.PublicRoomData);
}

class FetchAllPublicRoomErrorState extends FetchAllPublicRoomState {
  final String error;
  FetchAllPublicRoomErrorState(this.error);
}
