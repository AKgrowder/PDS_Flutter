

import 'package:pds/API/Model/GetGuestAllPostModel/GetGuestAllPost_Model.dart';

abstract class GetGuestAllPostState {}

class GetGuestAllPostLoadingState extends GetGuestAllPostState {}

class GetGuestAllPostInitialState extends GetGuestAllPostState {}

class GetGuestAllPostLoadedState extends GetGuestAllPostState {
  final GetGuestAllPostModel GetGuestAllPostRoomData;
  GetGuestAllPostLoadedState(this.GetGuestAllPostRoomData);
}

class GetGuestAllPostErrorState extends GetGuestAllPostState {
  final dynamic error;
  GetGuestAllPostErrorState(this.error);
}

 